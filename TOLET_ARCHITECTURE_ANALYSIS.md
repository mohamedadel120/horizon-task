# task Project Architecture Analysis

This document outlines the architecture and core components of the `task` project based on the analysis of `D:\task`.

## 1. Architecture Overview

The project follows a **Feature-First** architecture with a clear separation of concerns using **Clean Architecture** principles.

### Layers

- **Presentation Layer**: `Cubit` (State Management) + `Screens/Widgets` (UI).
- **Domain/Data Layer**: `Repository` (Data coordination) + `Service` (API calls) + `Models` (Data structure).
- **Core Layer**: Base classes, Networking, DI, and Utilities.

### Data Flow

1.  **UI** calls **Cubit** method (e.g., `login()`).
2.  **Cubit** calls **Repository** method.
3.  **Repository** calls **Service** method.
4.  **Service** uses **ApiClient** to make HTTP request.
5.  **Service** parses response into **Model**.
6.  **Repository** returns `Either<Failure, Model>` to **Cubit**.
7.  **Cubit** emits **State** (Loading -> Success/Error) to **UI**.

## 2. Core Components

### BaseCubit (`lib/core/base/base_cubit.dart`)

- Extends `Cubit<BaseState>`.
- Manages standard states: `InitialState`, `LoadingState`, `SuccessState<T>`, `ErrorState`, `SuccessWithoutData`.
- Provides helper methods: `emitLoading()`, `emitSuccess(data)`, `emitError(message)`.

### BaseRepository (`lib/core/base/base_repository.dart`)

- Abstract class for Repositories.
- Provides `safeCall<T>(Future<T> Function() call)` to handle exceptions.
- Maps exceptions (DioError, ServerException) to `Failure` objects (NetworkFailure, ServerFailure).

### BaseService (`lib/core/base/base_service.dart`)

- Abstract class for Services.
- Uses `ApiClient` instance.
- Provides generic methods like `handleBaseModelApiRequests<T>` and `handleDirectApiRequest<T>`.
- Handles standard API patterns (GET, POST, etc.) and JSON parsing.

### ApiClient (`lib/core/networking/api_client.dart`)

- Wrapper around `Dio`.
- Configures interceptors (Auth, Language, Logger).
- Handles connectivity checks.
- Provides `safeApiCall` with comprehensive error handling.

### BaseStateWidget (`lib/core/base/base_state_widget.dart`)

- Generic Widget to handle `BaseState`.
- Automatically shows `ShimmerSkeleton` for `LoadingState`.
- Shows error message for `ErrorState`.
- Calls `builder` callback with data for `SuccessState`.

## 3. Implementation Example: Login Feature

### File Structure

```
features/auth/login/
├── controller/
│   └── cubit/
│       ├── login_cubit.dart
│       └── login_state.dart
├── data/
│   ├── api/
│   │   └── login_api_services.dart
│   ├── models/
│   │   ├── login_request_model.dart
│   │   └── login_response.dart
│   └── repository/
│       └── login_repo.dart
└── presentation/
    └── screens/
        └── login_screen.dart
```

### Component Interaction

**1. LoginService (`login_api_services.dart`)**

- Extends `BaseService`.
- Defines `login(LoginRequestBody body)`.
- Calls `handleDirectApiRequest` with endpoint, HTTP method, and `fromJson` converter.

**2. LoginRepository (`login_repo.dart`)**

- Extends `BaseRepository`.
- Injects `LoginService`.
- Calls `service.login()` wrapped in `safeCall` to return `Either<Failure, LoginResponse>`.

**3. LoginCubit (`login_cubit.dart`)**

- Extends `BaseCubit<LoginState>`.
- Injects `LoginRepository`.
- Calls `repository.login()`.
- Manages `TextEditingController`s and `formKey`.

**4. LoginState (`login_state.dart`)**

- Extends `BaseState` (or similar base).
- Holds specific UI state like `isPasswordVisible`.

## 4. Key Takeaways for New Development

- **Always extend Base classes**: Use `BaseCubit`, `BaseRepository`, `BaseService`.
- **Use Data State Wrapper**: Repositories must return `Either<Failure, T>`.
- **Use BaseStateWidget**: For consistent UI handling of Loading/Error/Success states.
- **Dependency Injection**: Dependencies are likely managed via `GetIt` (implied by `sl<ChatCubit>` usage in LoginCubit).

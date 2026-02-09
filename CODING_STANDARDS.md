# Project Coding Standards & Guidelines

This document outlines the strict coding standards and architectural patterns for this project, based on the **task** reference architecture and user requirements. **All code must strictly adhere to these rules.**

## 1. General Rules

- **File Length Limit**: **Strictly NO more than 100 lines per file.** Break down large classes into smaller, focused components.
- **Component Structure**: Always use **Object-Oriented Programming (OOP)**. Create Widgets as separate `class` definitions (e.g., `class MyButton extends StatelessWidget`), never as helper methods (e.g., `Widget _buildButton()`).
- **Consistency**: Follow the existing **task** project structure exactly.

## 2. Directory Structure & Naming

You must follow this _task_ directory structure:

```
lib/
├── core/
│   ├── base/               <-- MUST use these base classes
│   │   ├── base_cubit.dart
│   │   ├── base_repository.dart
│   │   ├── base_service.dart
│   │   └── base_state_widget.dart
│   ├── networking/         <-- ApiClient implementation
│   └── di/                 <-- Dependency Injection
└── features/
    └── [feature_name]/
        ├── controller/
        │   └── cubit/      <-- Extends BaseCubit
        ├── data/
        │   ├── api/        <-- Extends BaseService
        │   ├── models/     <-- Extends BaseModel
        │   └── repository/ <-- Extends BaseRepository
        └── presentation/
            └── screens/    <-- Uses BaseStateWidget
```

## 3. Architecture (Clean Architecture)

Follow the established layers:

- **Presentation**: `Cubit` (State Management) + `Screen` (Scaffold) + `Widgets` (Components).
- **Domain/Data**: `Repository` (Interface/Implementation) + `Service` (API calls) + `Models` (DTOs).
- **Core**: Use provided Base.

**Base Class Usage (Mandatory):**

- **Cubits**: MUST extend `BaseCubit<T>`.
- **Repositories**: MUST extend `BaseRepository` and return `Either<Failure, T>`.
- **Services**: MUST extend `BaseService` and use `ApiClient`.
- **Screens**: MUST use `BaseStateWidget` to handle `Loading`, `Error`, and `Success` states automatically.

## 4. UI/UX Guidelines

- **Loading State**: Always use **Shimmer** effects for loading states (no simple circular progress indicators unless trivial).
- **Animations**: Implement **simple, high-performance animations** (e.g., fade-ins, slide-ins) to enhance UX without clutter.
- **Atomic Design**: Break screens into small, reusable widgets to adhere to the 100-line limit.

## 5. Performance

- Use `const` constructors everywhere possible.
- Minimize widget rebuilds using `BlocBuilder` scopes effectively (don't wrap the whole Scaffold if not needed).
- Use `ListView.builder` or `SliverList` for lists.

## 6. Development Workflow

- **Ask Before Adding**: Do not add new libraries or major architectural changes without explicit user approval.
- **Memory**: This document serves as the project's "memory" for standards. All future code must adhere to this.

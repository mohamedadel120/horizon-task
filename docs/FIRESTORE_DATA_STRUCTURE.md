# Firestore data structure (Home – Figma UI)

Use this structure so the app shows **categories** in the tabs and **products** in the Recommended list.

---

## 1. Collection: `categories`

One document per tab (Popular, Recent, Favorites). **"All"** is built-in and not stored.

| Field   | Type   | Required | Description        |
|--------|--------|----------|--------------------|
| `name` | string | yes      | Tab label, e.g. "Popular", "Recent", "Favorites" |
| `order`| number | no       | Sort order (0, 1, 2…). Default 0. |

**Example documents:**

- `name`: "Popular", `order`: 0  
- `name`: "Recent", `order`: 1  
- `name`: "Favorites", `order`: 2  

---

## 2. Collection: `products`

One document per recommended item (property card).

| Field        | Type   | Required | Description |
|-------------|--------|----------|-------------|
| `title`     | string | yes      | e.g. "Modern Loft", "Woodland Cabin" |
| `imageUrl`  | string | yes      | Full image URL |
| `location`  | string | yes      | e.g. "Central District", "North Hills" |
| `price`     | string or number | yes | e.g. "120" or "$120/night" (app shows "$120/night") |
| `categoryId`| string | no       | Document ID from `categories` to filter by tab |

**Example documents:**

- `title`: "Modern Loft", `imageUrl`: "https://…", `location`: "Central District", `price`: 120 or "$120/night"  
- `title`: "Woodland Cabin", `imageUrl`: "https://…", `location`: "North Hills", `price`: 85  
- `title`: "Beachside Suite", `imageUrl`: "https://…", `location`: "Coastal Bay", `price`: 200  

---

## UI mapping (Figma → app)

- **Categories:** "All" + each `categories` document’s `name` → filter tabs.  
- **Product card:** `imageUrl`, `title`, `location`, `price` (as `displayPrice`), heart icon (favorite).  
- **Recommended:** All products when "All" is selected; when a category is selected, only products with matching `categoryId`.  

No need to send more screens unless you add new fields or screens; this matches the [Figma design](https://www.figma.com/design/sMksApwANsGXDNgmtRKVHi/Task?node-id=1-169).

# 💡 Omni Challenge

Omni Challenge is a Flutter application built using the **MVVM architecture** with **Riverpod** for state management, **go_router** for navigation, and following **Clean Architecture** and **SOLID** principles.  
It supports dynamic environment configuration using `--dart-define-from-file`.

📦 **Repository:**  
[https://github.com/ergo-notch/omni_challenge](https://github.com/ergo-notch/omni_challenge)

---

## 🚀 Features

- ✅ **Riverpod** for predictable and testable state management.
- ✅ **Clean Architecture** for scalable and maintainable code.
- ✅ **go_router** for declarative and nested navigation.
- ✅ Dynamic environment setup via `config.json`.
- ✅ Modular structure per feature.

---

## 🛠️ Installation Guide

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A physical device or emulator (Android or iOS)

---

### 1. Clone the Repository

```bash
git clone https://github.com/ergo-notch/omni_challenge.git
cd omni_challenge
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Connect a Device or Start an Emulator

- **Android:** Connect a device with developer mode or start an emulator.
- **iOS:** Use a simulator or physical device with valid provisioning profile.

### 4. Run the App with Environment Variables

```bash
flutter run --dart-define-from-file=config.json
```

#### 📄 Sample `config.json`

```json
{
  "BASE_URL": "https://rickandmortyapi.com/graphql",
  "ENVIRONMENT": "development"
}
```

---

## 🧱 Project Structure

```bash
omni_challenge/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── core/                     # Core utilities, exceptions, constants
│   ├── features/                 # Feature modules
│   │   ├── data/                 # Repositories, models, data sources
│   │   ├── domain/               # Entities, use cases
│   │   └── presentation/         # ViewModels, UI screens, widgets
├── pubspec.yaml                  # Package dependencies and assets
└── README.md                     # Project documentation
```

---

## 🧪 Testing

Run all unit and widget tests with:

```bash
flutter test
```

Test coverage includes:

- ✅ Success and failure cases in the use case layer
- ✅ State transitions in the `CharactersViewModel`
- ✅ Pagination logic and data accumulation

---

## 🧩 Troubleshooting

- Make sure `config.json` is present and correctly formatted.
- For iOS, verify your provisioning profile and device compatibility.
- Ensure assets are properly listed in `pubspec.yaml`.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 📸 Screenshots

_Add screenshots here if available._

---

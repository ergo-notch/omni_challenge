# 💡 Omni Challenge

Omni Challenge is a Flutter application built using the **MVVM pattern design** with **Riverpod** for state management, **go_router** for navigation, and following **Clean Architecture** and **SOLID** principles.  
It supports dynamic environment configuration using `--dart-define-from-file`.

https://github.com/user-attachments/assets/1831d1ae-5d30-490c-a74d-7e04e96e841f

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

## 📸 Screenshots![Simulator Screenshot - iPhone 16 - 2025-05-05 at 11 47 08](https://github.com/user-attachments/assets/dfb2afa0-7490-4f97-b92d-325e62bf127f)

![Simulator Screenshot - iPhone 16 - 2025-05-05 at 11 47 16](https://github.com/user-attachments/assets/3afa880b-cb81-4be3-a090-c55e8009ff21)
![Simulator Screenshot - iPhone 16 - 2025-05-05 at 11 47 25](https://github.com/user-attachments/assets/f86f1077-aa10-49ce-a07f-fae396c352a1)

---

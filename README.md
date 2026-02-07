
<p align="center">
  <h1 align="center">📝 Task Mate</h1>
  <p align="center">
    <strong>A thoughtfully engineered Flutter task management application</strong><br/>
    <em>Where clean architecture meets beautiful user experience</em>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Framework-blue?style=for-the-badge&logo=flutter"/>
  <img src="https://img.shields.io/badge/BLoC-State%20Management-purple?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Clean%20Architecture-Scalable-success?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Hive-Local%20Storage-yellow?style=for-the-badge"/>
</p>

---

## 🧭 The Story Behind Task Mate

Most todo apps focus on *listing tasks*.  
**Task Mate** focuses on **how users experience time, focus, and productivity**.

This project was built with one key question in mind:

> *How can a task manager feel calm, intentional, and genuinely helpful?*

Every screen, interaction, and architectural decision was made to answer that question.

---

## 🎯 What Problem Does It Solve?

- Users often feel overwhelmed by **too many tasks**
- Timers feel disconnected from real task context
- Calendars show dates, not *meaning*

**Task Mate** bridges these gaps by:
- Organizing tasks by **time and intent**
- Connecting tasks to **focus sessions**
- Giving users a **clear view of their day and year**

---

## 🧩 Core Features

### 🏠 **Home — Daily Focus**
- Categorized tasks
- Shows **today’s tasks only**
- Custom-built **time range slider**
- Dynamically filters tasks by time

> Designed to reduce noise and increase clarity.

---

### 📆 **Calendar — Big Picture**
- View tasks for **any day of the year**
- Clean, readable layout
- Optimized for fast mental scanning

> Helps users understand *when* they work best.

---

### ⏱ **Timer — Deep Focus**
- Custom countdown timer per task
- Animated progress indicator
- Sound alert on completion

> A focus tool, not just a stopwatch.

---

## 🧱 Architecture & Engineering Philosophy

Task Mate follows **Clean Architecture** with a **feature-based structure**.

### Architectural Goals:
- Long-term scalability
- Easy testing
- Clear ownership of responsibilities

### Tech Highlights:
- **BLoC** for predictable state management
- **get_it** for dependency injection
- **Dartz** for functional error handling
- **Equatable** for efficient state comparison

> Business logic is isolated, testable, and UI-agnostic.

---

## 🎨 UI & UX Principles

- Smooth, intentional animations
- Responsive layouts using `flutter_screenutil`
- Custom-designed components
- Minimal, modern visual language

> The UI is designed to feel *quiet*, *fast*, and *human*.

---

## 💾 Storage & System Features

- Local persistence with **Hive**
- Local notifications
- Timezone-aware scheduling
- Persian date & number support

---

## 🧰 Tech Stack & Packages

```yaml
cupertino_icons: ^1.0.2
flutter_screenutil: ^5.8.4
syncfusion_flutter_sliders: ^22.1.39
persian_datetime_picker: ^3.1.0
persian_number_utility: ^1.1.3
percent_indicator: ^4.2.3
flutter_ringtone_player: ^4.0.0+4
path_drawing: ^1.0.1
bloc: ^8.1.2
flutter_bloc: ^8.1.3
get_it: ^7.6.0
intl: ^0.18.1
hive: ^2.2.3
hive_flutter: ^1.1.0
hive_generator: ^2.0.0
equatable: ^2.0.5
dartz: ^0.10.1
flutter_svg: ^2.0.7
flutter_local_notifications: ^18.0.1
flutter_timezone: ^4.1.1
timezone: ^0.9.2
jiffy: ^6.2.1

---

🚀 Getting Started

git clone https://github.com/your-username/task-mate.git
cd task-mate
flutter pub get
flutter run


🔮 Future Vision

. ☁️ Cloud sync

. 🌙 Dark mode

. 📊 Productivity analytics

. 🧠 Smart task suggestions

. 🧩 Home screen widgets



🤝 Why This Project Matters

. This project demonstrates:

. Strong Flutter fundamentals

. Real-world architecture decisions

. Attention to UX, not just UI

. Production-oriented mindset

Task Mate is not a demo — it’s a statement of engineering values.

AI Training Module Generator – Frontend
Overview

This is a Flutter Web frontend for the AI Training Module Generator.
It allows users to upload meeting notes, trigger AI processing, and browse generated training modules.

What This Frontend Does

Uploads meeting notes (text or .txt file)

Shows AI processing progress

Displays generated training topics

Displays full training content per topic

Tech Stack

Flutter Web

Dart

BLoC (State Management)

REST API integration

Project Structure (Simplified)
lib/
 ├─ screens/
 │   ├─ upload_screen.dart
 │   ├─ topics_screen.dart
 │   └─ module_screen.dart
 ├─ bloc/
 │   ├─ upload/
 │   ├─ process_ai/
 │   ├─ topics/
 │   └─ module/
 ├─ repository/
 │   ├─ upload_repository.dart
 │   ├─ process_ai_repository.dart
 │   ├─ topics_repository.dart
 │   └─ module_repository.dart
 └─ main.dart

Screens Overview
Upload Screen

Enter meeting title and content

Upload .txt file

Submit notes to backend

Topics Screen

Automatically triggers AI processing

Displays loader during processing

Shows list of generated topics

Module Screen

Opens on topic click

Fetches and displays training content

Setup Instructions
1. Clone repository
git clone https://github.com/YOUR_USERNAME/ai-training-frontend.git
cd ai-training-frontend

2. Install Flutter dependencies
flutter pub get

3. Run Flutter Web
flutter run -d chrome


Make sure backend is running before using the app.

Notes

Uses BLoC for clean architecture

All API calls are centralized in repositories

Designed for clarity and scalability

Use Cases

Internal dashboards

Training portals

Knowledge management tools

License

Internal / Educational use

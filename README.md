# ToDoList

A simple to-do list app built with Swift and SwiftUI and some prompting.

## Objective
The goal of this project was to create a to-do list app that:
- Displays a list of tasks with a clean, user-friendly interface.
- Allows users to add new tasks via a sheet.
- Marks tasks as completed with a toggle (checkmark).
- Persists tasks using JSON storage for data retention across app launches.

## Procedure
1. Set up an Xcode project with SwiftUI views for the main task list (`ContentView`) and adding tasks (`AddTaskView`).
2. Created a `Task` struct to model tasks with an ID, title, and completion status.
3. Implemented JSON persistence to save and load tasks from a file.
4. Enhanced the UI with gradients, shadows, custom buttons, rounded corners, and an empty state message.
5. Uploaded the project to GitHub, troubleshooting issues with file staging and pushing.

## Errors Encountered
- "No files appeared in the commit window" (fixed by ensuring all files were staged using `git add .` in Terminal).
- "Push to GitHub created an empty repository" (fixed by verifying the commit and using `git push -f origin main` to force push the contents).

## Technologies Used
- **Swift**: Programming language.
- **SwiftUI**: UI framework.
- **Foundation**: For JSON encoding/decoding and file management.

## How to Run
1. Clone the repository: `git clone https://github.com/yourusername/ToDoList.git`.
2. Open in Xcode.
3. Build and run on the iOS Simulator or a device.

## Learning Journey
This project was built as a learning exercise for a beginner in Swift, following the completion of a password manager app (PassSafe). Resources used include:
- Apple's SwiftUI Tutorials.
- Hacking with Swift (100 Days of SwiftUI).
- Kodeco's Swift Apprentice.

## Future Improvements
- Add a swipe-to-delete feature to remove tasks.
- Allow editing of existing task titles.
- Add due dates for tasks with a date picker.

import SwiftUI

struct AddTaskView: View {
    @Binding var tasks: [Task]
    @Binding var newTaskTitle: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")
                            .font(.headline)
                            .foregroundColor(.blue)) {
                    TextField("Task Title", text: $newTaskTitle)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    newTaskTitle = ""
                    dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .font(.headline)
                },
                trailing: Button(action: {
                    if !newTaskTitle.isEmpty {
                        let newTask = Task(title: newTaskTitle, isCompleted: false)
                        tasks.append(newTask)
                        saveTasks()
                        newTaskTitle = ""
                        dismiss()
                    }
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                        .font(.headline)
                }
                .disabled(newTaskTitle.isEmpty)
            )
        }
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            try? encoded.write(to: getDocumentsDirectory().appendingPathComponent("tasks.json"))
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(tasks: .constant([]), newTaskTitle: .constant(""))
    }
}

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var newTaskTitle: String = ""
    @State private var showingAddTaskSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    if tasks.isEmpty {
                        // Empty state message
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No Tasks Yet")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("Tap 'Add Task' to get started!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    } else {
                        List {
                            ForEach(tasks) { task in
                                HStack {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(task.isCompleted ? .green : .gray)
                                        .onTapGesture {
                                            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                                tasks[index].isCompleted.toggle()
                                                saveTasks()
                                            }
                                        }
                                    
                                    Text(task.title)
                                        .font(.headline)
                                        .strikethrough(task.isCompleted)
                                        .foregroundColor(task.isCompleted ? .gray : .black)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                                .padding(.vertical, 2)
                            }
                        }
                        .listStyle(PlainListStyle()) // Remove default list styling
                        .padding(.top)
                    }
                    
                    // Add Task button
                    Button(action: {
                        showingAddTaskSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20))
                            Text("Add Task")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    .padding()
                }
            }
            .navigationTitle("To-Do List")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingAddTaskSheet) {
                AddTaskView(tasks: $tasks, newTaskTitle: $newTaskTitle)
            }
            .onAppear {
                tasks = loadTasks()
            }
        }
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            try? encoded.write(to: getDocumentsDirectory().appendingPathComponent("tasks.json"))
        }
    }
    
    func loadTasks() -> [Task] {
        if let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent("tasks.json")),
           let loadedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            return loadedTasks
        }
        return []
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

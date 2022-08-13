import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:problem_2_todo/features/home/data/models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> todoList = [
    TodoModel(title: 'First Todo Task', description: "This is the first todo task"),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Todo List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: const Text(
                'ADD',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      String title = '';
                      String description = '';
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) => title = value,
                                decoration: const InputDecoration(
                                  hintText: 'Title',
                                ),
                              ),
                              TextField(
                                onChanged: (value) => description = value,
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FlatButton(
                                    child: const Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text('ADD'),
                                    onPressed: () {
                                      if (title.isNotEmpty && description.isNotEmpty && todoList.length <= 6) {
                                        setState(() {
                                          todoList.add(TodoModel(title: title, description: description));
                                        });
                                        print('todoListAdded : $todoList');
                                        Navigator.of(context).pop();
                                      } else {
                                        print('todoList Not Added : $todoList');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          Container(
              height: 30,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: todoList.length - 1 >= index
                            ? todoList[index].isDone
                                ? Colors.green
                                : Colors.blue
                            : Colors.grey[200],
                        child: todoList.length - 1 >= index
                            ? todoList[index].isDone
                                ? const Icon(Icons.check)
                                : Container()
                            : Container(),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: MediaQuery.of(context).size.width * 0.055);
                  },
                  itemCount: todoList.length)),
          const SizedBox(height: 50),
          Text(
            todoList[selectedIndex].title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 80),
          const Text(
            'Description:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            todoList[selectedIndex].description,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 200),
          GestureDetector(
            onTap: () {
              setState(() {
                if (selectedIndex != 0) {
                  selectedIndex = selectedIndex - 1;
                  todoList.removeAt(selectedIndex + 1);
                }
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text(
                  'Do it later',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                todoList[selectedIndex].isDone = !todoList[selectedIndex].isDone;
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[500],
              ),
              child: Center(
                child: Text(
                  todoList[selectedIndex].isDone ? 'Undone' : 'Done',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

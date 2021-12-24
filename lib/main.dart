// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// ignore: unused_element

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Task> tasks;
  bool isChecked = false;
  bool isFavorite = false;
  bool isToDoList = false;
  bool isFavoriteList = true;
  bool isDoneList = false;

  _MyHomePageState() {
    tasks = List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    late TextEditingController _newTask = TextEditingController();

    void addTask() {
      tasks.add(Task.Test(
        _newTask.text,
        false,
      ));
      //_newTask.text = "";
      setState(() {});
    }

    void toDoList() {
      setState(() {
        isDoneList = false;
        isFavoriteList = false;
        isToDoList = true;
      });
    }

    void favoriteList() {
      setState(() {
        isFavoriteList = true;
        isToDoList = false;
        isDoneList = false;
      });
    }

    void doneList() {
      setState(() {
        isDoneList = true;
        isToDoList = false;
        isFavoriteList = false;
      });
    }

    Widget createTaskWidget(int index, bool isVisible) {
      return Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              height: 50,
              color: Colors.grey[350],
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: ShapeDecoration(
                        color: Colors.grey[350],
                        shape: const CircleBorder(side: BorderSide.none)),
                    child: Checkbox(
                      value: tasks[index].isDone,
                      onChanged: (value) {
                        isChecked = value ?? false;
                        tasks[index].isDone = isChecked;

                        //print(isChecked);
                        setState(() {});
                      },

                      // size: 25.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    tasks[index].text,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.star_border),
                  color: Colors.grey,
                  highlightColor: Colors.red,
                  focusColor: Colors.purple,
                  splashColor: Colors.yellow,
                  disabledColor: Colors.amber,
                  iconSize: 38,
                  onPressed: () {
                    tasks[index].isFivorit;
                    (value) {
                      isFavorite = value ?? false;
                      tasks[index].isFivorit = isFavorite;
                    };

                    setState(() {});
                  },
                ),
                Checkbox(
                  value: tasks[index].isFivorit,
                  //shape: ,
                  activeColor: Colors.amber,
                  checkColor: Colors.amber,
                  onChanged: (value) {
                    isFavorite = value ?? false;
                    tasks[index].isFivorit = isFavorite;

                    //print(isChecked);
                    setState(() {});
                  },

                  // size: 25.0,
                ),
                /*tasks[index].isFivorit
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),*/
              ])),
        ),
      );
    }

    Widget myItemBiulder(BuildContext context, int index) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        bool isVisible = (tasks[index].isDone && isDoneList) ||
            (tasks[index].isFivorit && isFavoriteList) ||
            (!tasks[index].isDone && isToDoList);

        return createTaskWidget(index, isVisible);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('My Lists'),
            ),
            ListTile(
              title: const Text('To Do Tasks'),
              onTap: toDoList,
            ),
            ListTile(
              title: const Text('Completed Tasks'),
              onTap: doneList,
            ),
            ListTile(
              title: const Text('Favorite Tasks'),
              onTap: favoriteList,
            ),
          ],
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1639047043911-1dbefe2510ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 15, 12, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                    child: Placeholder(),
                  ),
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: myItemBiulder,
                      /*Column(
                      children: [
                        Text(tasks[index].text),*
                      ],
                    );*/
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _newTask,
                                obscureText: false,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 17),
                                  hintText: 'Add a new task',
                                  prefixIcon: GestureDetector(
                                    child: const Icon(Icons.add),
                                    onTap: addTask,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    ///not pressed
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    ///onPressed

                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

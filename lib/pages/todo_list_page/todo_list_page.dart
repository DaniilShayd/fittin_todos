import 'package:test_02/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:test_02/pages/new_todo_page/new_todo_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoModel> _todos = [];
  int countAcsess = 0;
  bool _visibleIcons = true;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: themeData.colorScheme.background,
          title: Center(
            child: Text(
              'Мои дела',
              style: themeData.textTheme.headlineSmall?.copyWith(),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(34),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 15),
                  child: Text(
                    'Выполнено - $countAcsess',
                    style: themeData.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFAEAEAE)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      _visibleIcons = !_visibleIcons;
                      setState(() {});
                    },
                    icon: const Icon(Icons.visibility_off),
                    color: const Color(0xFFFF9900),
                  ),
                ),
              ],
            ),
          )),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
            ),
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (BuildContext context, index) {
                if (_visibleIcons || !_todos[index].done) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection dir) {
                      if (dir.index == 3) {
                        if (!_todos[index].done) {
                          countAcsess++;
                        }
                        setState(() =>
                            _todos[index] = _todos[index].copyWith(done: true));
                      } else {
                        if (_todos[index].done == true) {
                          countAcsess--;
                        }
                        setState(() => _todos.removeAt(index));
                      }
                    },
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _todos[index].done,
                      onChanged: (value) {
                        final checked = value ?? false;
                        setState(() {
                          checked ? countAcsess++ : countAcsess--;
                          _todos[index] = _todos[index].copyWith(
                            done: checked,
                          );
                        });
                      },
                      title: Text("${_todos[index].text}\n${_todos[index].deadline}",
                      style: !_todos[index].done ? themeData.textTheme.bodyLarge?.copyWith() : themeData.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFFD9D9D9),
                        decoration: TextDecoration.lineThrough,
                      ),),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
            /* setState(() {
            _todos.add(TodoModel(text: "text"),);
          });
        },*/
            async {
          final List<String> result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewTodoPage(),
              ));
          setState(() {
            _todos.add(
              TodoModel(
                text: result[1],
                deadline: result[0],
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

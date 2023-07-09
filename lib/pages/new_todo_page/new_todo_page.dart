import 'package:flutter/material.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({super.key});

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  final TextEditingController _textController = TextEditingController();
  bool? _checkDate;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _checkDate = true;
      });
    } else {
      if (_checkDate != null) {
        _checkDate = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              List<String> cache = [
                (_checkDate != null || _checkDate == true
                    ? '${selectedDate.year.toString()}.${selectedDate.month.toString()}.${selectedDate.day.toString()}'
                    : ''),
                _textController.text
              ];
              Navigator.pop(context, cache);
            },
            icon: Text(
              'Сохранить',
              style: themeData.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFFFF9900)),
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 197.0,
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
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: _textController,
                    maxLines: 11,
                    decoration: null,
                  ),
                ),
              ),
            ),
            CheckboxListTile(
              value: _checkDate != null || _checkDate == true,
              title: Text(
                "Дедлайн${_checkDate != null || _checkDate == true ? '\n${selectedDate.year.toString()}.${selectedDate.month.toString()}.${selectedDate.day.toString()}' : ''}",
                style: themeData.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (value) {
                _selectDate(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: Color(0xFFD9D9D9)),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Удалить',
                      style: themeData.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

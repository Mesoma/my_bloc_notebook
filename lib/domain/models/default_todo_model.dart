//domain class to define what a to_do object basically is

class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  // function to change the "isCompleted" bool from false to true or vice versa
  Todo toggleCompletion(){
    return Todo(
        id: id,
        text: text,
        isCompleted: !isCompleted
    );
  }
}

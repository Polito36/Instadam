import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  final VoidCallback onDelete; // Función de devolución de llamada para eliminar el comentario

  const Comment({
    Key? key,
    required this.text,
    required this.user,
    required this.time,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[200],
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comment
          Text(text),
          const SizedBox(height: 5),

          // User, time, delete icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(user, style: TextStyle(color: Colors.grey)),
              Text(" • ", style: TextStyle(color: Colors.grey)),
              Text(time, style: TextStyle(color: Colors.grey)),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete, // Llama a la función de devolución de llamada al presionar el botón de eliminar
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:html';

import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Lista de Tarefas',
     home: TaskListScreen(),
   );
 }
}


class TaskListScreen extends StatefulWidget {
 @override
 _TaskListScreenState createState() => _TaskListScreenState();
}


class _TaskListScreenState extends State<TaskListScreen> {
 List<String> tasks = [];


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Lista de Tarefas'),
     ),
     body: Column(
       children: <Widget>[
         Expanded(
           child: ListView.builder(
             itemCount: tasks.length,
             itemBuilder: (context, index) {
               return ListTile(
                 title: Text(tasks[index]),
                 onTap: () {
                   // Você pode adicionar ações aqui quando uma tarefa for clicada
                 },
               );
             },
           ),
         ),
       ],
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         _showAddTaskDialog();
       },
       tooltip: 'Adicionar Tarefa',
       child: Icon(Icons.add),
     ),
   );
 }


 void _showAddTaskDialog() {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text('Adicionar Tarefa'),
         content: TextField(
           onChanged: (text) {
             // Atualiza a variável local com o texto inserido
             setState(() {});
           },
           decoration: InputDecoration(
             hintText: 'Digite a tarefa...',
           ),
         ),
         actions: <Widget>[
           TextButton(
             onPressed: () {
               Navigator.of(context).pop();
             },
             child: Text('Cancelar'),
           ),
           TextButton(
             onPressed: () {
               // Adiciona a tarefa à lista
               if (tasks.isNotEmpty && tasks.last.isEmpty) {
                 tasks.removeLast();
               }
               tasks.add;
               Navigator.of(context).pop();
             },
             child: Text('Adicionar'),
           ),
         ],
       );
     },
   );
 }

}






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class ServicesDetailScreen extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? time;
  String? description;
  String? id;
  ServicesDetailScreen(
      {super.key,
      this.image,
      this.description,
      this.name,
      this.price,
      this.time,
      this.id});

  @override
  State<ServicesDetailScreen> createState() => _ServicesDetailScreenState();
}

class _ServicesDetailScreenState extends State<ServicesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name!),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.image!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          _showEditDialog(context, widget.id!, widget.price!,
                              widget.name!, widget.time!, widget.description!);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("services")
                              .doc(widget.id)
                              .delete()
                              .then((value) => Navigator.pop(context));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      "Product Name: ${widget.name}"
                          .toString()
                          .text
                          .bold
                          .make(),
                      Expanded(child: Container()),
                      "Price: ".text.bold.make(),
                      "${widget.price}\$".text.make()
                    ],
                  ),
                  20.heightBox,
                  "Product Description:".text.bold.make(),
                  "${widget.description}".toString().text.make(),
                  10.heightBox,
                  Row(
                    children: [
                      "Time:".text.bold.make(),
                      "${widget.time} hours".text.make()
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController taskiController = TextEditingController();

  TextEditingController deadlineController = TextEditingController();

  TextEditingController onTimeController = TextEditingController();

  TextEditingController statusController = TextEditingController();

  void _showEditDialog(BuildContext context, String id, String price,
      String title, String hour, String description) {
    taskiController.text = price;
    deadlineController.text = title;
    onTimeController.text = hour;
    statusController.text = description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskiController,
                decoration:
                    InputDecoration(labelText: 'Price', hintText: price),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: deadlineController,
                decoration:
                    InputDecoration(labelText: 'title', hintText: title),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: onTimeController,
                decoration: InputDecoration(labelText: 'hour', hintText: hour),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: statusController,
                decoration: InputDecoration(
                    labelText: 'description', hintText: description),
              ),
              SizedBox(height: 16.0),
              //   Row(
              //     children: [
              //       Text('Deadline: ${selectedDate.toLocal()}'),
              //       SizedBox(width: 10.0),
              //       ElevatedButton(
              //         onPressed: () => _selectDate(context, selectedDate),
              //         child: Text('Select Date'),
              //       ),
              //     ],
              //   ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateTasksJoin(
                        id,
                        taskiController.text,
                        deadlineController.text,
                        onTimeController.text,
                        statusController.text)
                    .then((value) {
                  Navigator.pop(context);
                  setState(() {});
                });
                // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateTasksJoin(String id, String task, String diets,
      String onTime, String status) async {
    await FirebaseFirestore.instance.collection('services').doc(id).update(
      {
        'price': task,
        'name': diets,
        "time": onTime,
        "description": status,
      },
    );

    // taskController.text == "";
    // deadlineController.text == "";
    // onTimeController.text == "";
    // statusController.text == "";
  }
}

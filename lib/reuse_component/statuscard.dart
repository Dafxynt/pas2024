import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final bool status;
  final String message;

  const StatusCard({
    Key? key,
    required this.status,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: status ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          status ? Icons.check_circle : Icons.error,
          color: status ? Colors.green : Colors.red,
        ),
        title: Text(
          status ? "Success" : "Failed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';

class CallLogScreen extends StatefulWidget {
  @override
  _CallLogScreenState createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  List<CallLogEntry> _callLogs = [];

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  Future<void> _getCallLogs() async {
    // Check and request permission
    if (await Permission.contacts.request().isGranted) {
      // Permission is granted. Proceed to get call logs.
      try {
        Iterable<CallLogEntry> callLogs = await CallLog.get();
        setState(() {
          _callLogs = callLogs.toList();
        });
      } catch (e) {
        // Handle error fetching call logs
        print('Error fetching call logs: $e');
      }
    } else {
      // Permission is not granted. Handle accordingly.
      // For simplicity, you can display a message to the user.
      print('Permission denied to access call logs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Log'),
      ),
      body: ListView.builder(
        itemCount: _callLogs.length,
        itemBuilder: (context, index) {
          final call = _callLogs[index];
          return ListTile(
            title: Text(call.name ?? 'Unknown'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(call.number ?? 'Unknown number'),
                Text('Date: ${DateTime.fromMillisecondsSinceEpoch(call.timestamp ?? 0)}'),
                Text('Duration: ${_durationToString(call.duration ?? 0)}'),
              ],
            ),
            leading: Icon(Icons.call),
          );
        },
      ),
    );
  }

  String _durationToString(int? duration) {
    if (duration == null) return 'Unknown';
    final Duration d = Duration(seconds: duration);
    return '${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

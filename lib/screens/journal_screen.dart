import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _entryController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _entries = [];
  String _searchQuery = '';

  void _saveEntry() {
    final text = _entryController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _entries.insert(0, {
        'id': const Uuid().v4(),
        'text': text,
        'timestamp': DateTime.now().toString(),
      });
      _entryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredEntries = _entries.where((entry) {
      return entry['text']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search entries...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),

            // 📝 Entry Field
            TextField(
              controller: _entryController,
              decoration: const InputDecoration(
                labelText: 'Write a thought...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _saveEntry,
              child: const Text('Save Entry'),
            ),
            const SizedBox(height: 12),

            // 📄 List of Filtered Entries
            Expanded(
              child: ListView.builder(
                itemCount: filteredEntries.length,
                itemBuilder: (context, index) {
                  final entry = filteredEntries[index];
                  return Card(
                    child: ListTile(
                      title: Text(entry['text'] ?? ''),
                      subtitle: Text(entry['timestamp'] ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

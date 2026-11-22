import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Обратная связь',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF6750A4)),
      home: const FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Обратная связь')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Напишите нам',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Введите ваше имя и нажмите кнопку отправки.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  FeedbackForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _nameController = TextEditingController();
  String? _sentName;
  bool _showNameError = false;

  void _submit() {
    final name = _nameController.text.trim();
    setState(() {
      _showNameError = name.isEmpty;
      _sentName = name.isEmpty ? null : name;
    });
    if (name.isNotEmpty) {
      _nameController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Ваше имя',
            border: const OutlineInputBorder(),
            errorText: _showNameError ? 'Введите имя' : null,
          ),
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          onChanged: (value) {
            if (_sentName != null ||
                (_showNameError && value.trim().isNotEmpty)) {
              setState(() {
                _sentName = null;
                _showNameError = false;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _submit, child: const Text('Отправить')),
        if (_sentName != null) ...[
          const SizedBox(height: 16),
          Semantics(
            liveRegion: true,
            child: Text(
              'Отправлено! Спасибо, $_sentName',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF347439),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

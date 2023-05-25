import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  String Api_Key = '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';
  // Future<String> generateText(String prompt) async {
  //   final response = await http.post(
  //     Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${Api_Key}',
  //     },
  //     body: jsonEncode({
  //       'prompt': prompt,
  //       'max_tokens': 50,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final text = data['choices'][0]['text'];
  //     print(text);
  //     return text;
  //   } else {
  //     throw Exception('Failed to generate text');
  //   }
  // }
  String text = '';
  Future<void> GenerateText() async {
    final apiKey = '02HPsxDH1eZVksXVI9zXT3BlbkFJftNAg0K0Eo2ojzzi1qAE';
    final prompt = 'Hello,';
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({'prompt': prompt, 'max_tokens': 50}),
    );
    final jsonResponse = jsonDecode(response.body);
    final choices = jsonResponse['choices'];
    if (choices != null && choices.isNotEmpty) {
      final text = choices[0]['text'];
      setState(() {
        this.text = text;
      });
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff444654),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/openai_logo.jpg'),
        ),
        title: Text('ChatGpt'),
      ),
      backgroundColor: Color(0xff343541),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Text('hi');
                }),
          ),
          // TextField(
          //   controller: controller,
          //   decoration: InputDecoration(
          //     suffixIcon: IconButton(
          //       onPressed: () => generateText(controller.text),
          //       icon: Icon(Icons.send_rounded),
          //       color: Color.fromRGBO(179, 179, 179, 1),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(15),
          //         borderSide:
          //             BorderSide(color: Color.fromRGBO(179, 179, 179, 1))),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //       borderSide: BorderSide(color: Colors.grey.shade400),
          //     ),
          //     hintText: 'Ask...',
          //     hintStyle: TextStyle(color: Color.fromRGBO(179, 179, 179, 1)),
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              GenerateText();
            },
            child: const Text('Generate Text'),
          ),
          const SizedBox(height: 20),
          Text(text),
        ],
      )),
    );
  }
}
// 
import 'package:flutter/material.dart';
import 'package:flutter_sample_custom_form/random_color_picker_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var currentText = 'Hi';

    const colors = <Color>[
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
    ];
    var currentColor = colors[0];

    const numbers = [1, 2, 3, 4, 5, 11, 12, 13, 14, 15];
    var currentNumber = numbers[1];

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: currentText,
                  onChanged: (value) => currentText = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '必須項目です。';
                    }
                    if (value.length <= 3) {
                      return '3文字以上入力してください。';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  items: numbers
                      .map(
                        (number) => DropdownMenuItem(
                          value: number,
                          child: Text(number.toString()),
                        ),
                      )
                      .toList(),
                  value: currentNumber,
                  onChanged: (value) {
                    if (value != null) {
                      currentNumber = value;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return '必須項目です。';
                    }
                    if (value.isEven) {
                      return '偶数は選択できません。';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                RandomColorPickerForm(
                  values: colors,
                  initialValue: currentColor,
                  onChanged: (value) => currentColor = value,
                  validator: (value) {
                    if (value == null) {
                      return '必須項目です。';
                    }
                    if (value == Colors.red) {
                      return '赤は選択できません。';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: currentColor,
                        content: Center(
                          child: Text('[$currentNumber] $currentText'),
                        ),
                      ),
                    );
                  },
                  child: const Text('確定'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

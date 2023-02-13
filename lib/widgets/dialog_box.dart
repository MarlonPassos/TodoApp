import 'package:flutter/material.dart';

import 'dialog_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: SizedBox(
        height: 120,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // get user input
            TextField(
              autofocus: true,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adicionar nova tarefa'
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // buttons (save/cancel)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                DialogButton(
                  text: 'Salvar',
                  onPressed: onSave,
                ),
                // cancel button
                const SizedBox(
                  width: 8,
                ),
                DialogButton(
                  text: 'Cancelar',
                  onPressed: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

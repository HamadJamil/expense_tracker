// ignore_for_file: use_build_context_synchronously

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:expense_tracker/local/provider/database_provider.dart';
import 'package:expense_tracker/widgets/cutsom_textform_field..dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key, this.isUpdate = false, this.name, this.id});
  final bool isUpdate;
  final String? name;
  final int? id;

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    widget.isUpdate ? _nameController.text = (widget.name)! : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Category',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _showEmojiPicker = !_showEmojiPicker;
                      });
                    },
                    child: Container(
                      height: 57,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Text(
                          context.watch<DatabaseProvider>().getEmoji,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CutsomTextformField(
                      label: 'Category Name',
                      hintText: 'Enter Category name',
                      validateMsg: 'Please Enter a categoru name',
                      controller: _nameController,
                      maxLength: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await context
                            .read<DatabaseProvider>()
                            .addCategory(
                              context.read<DatabaseProvider>().getEmoji,
                              _nameController.text,
                            );
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('New Category Added')),
                          );
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
            if (_showEmojiPicker)
              EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  context.read<DatabaseProvider>().setEmoji(emoji.emoji);
                  setState(() {
                    _showEmojiPicker = false;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:expense_tracker/widgets/cutsom_textform_field..dart';
import 'package:expense_tracker/local/provider/database_provider.dart';
import 'package:expense_tracker/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key, required this.model});
  final CategoryModel model;

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Expense',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CutsomTextformField(
                    label: 'Expense Name',
                    hintText: 'Enter expense name',
                    validateMsg: 'Please enter expense name',
                    controller: _nameController,
                    maxLength: 20,
                  ),
                  CutsomTextformField(
                    label: 'Amount',
                    hintText: 'Enter Amount',
                    validateMsg: 'Please enter expense amount',
                    controller: _amountController,
                    keyboardType: TextInputType.number,
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
                            .addExpense(
                              _nameController.text,
                              int.parse(_amountController.text),
                              widget.model.id,
                            );
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('New Expense Added')),
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
          ],
        ),
      ),
    );
  }
}

import 'package:expense_tracker/forms/add_expense_form.dart';
import 'package:expense_tracker/local/provider/database_provider.dart';
import 'package:expense_tracker/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, required this.model});
  final CategoryModel model;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DatabaseProvider>().loadExpenses(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var list = context.watch<DatabaseProvider>().expenses;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            pinned: true,
            backgroundColor: Colors.black,
            titleSpacing: 0,
            expandedHeight: height * 0.25,

            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Center(
                child: CircleAvatar(
                  minRadius: height * 0.05,
                  maxRadius: height * 0.06,
                  backgroundColor: Colors.white,
                  child: Text(
                    widget.model.emoji,
                    style: TextStyle(fontSize: height * 0.06),
                  ),
                ),
              ),
              title: Text(
                widget.model.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(
                'Expense List : ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          list.isEmpty
              ? SliverFillRemaining(
                child: Center(child: Text('NO Expenses Added Yet!')),
              )
              : SliverList.builder(
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.grey.shade300,
                        title: Text(list[index].name),
                        subtitle: Text(list[index].amount.toString()),
                        trailing: Text(list[index].createdAt),
                      ),
                    ),
                itemCount: list.length,
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddExpenseForm(model: widget.model),
              );
            },
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Expense'),
      ),
    );
  }
}

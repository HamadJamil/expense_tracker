import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            pinned: true,
            backgroundColor: Colors.black,
            titleSpacing: 0,
            centerTitle: false,
            expandedHeight: height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: CircleAvatar(
                  minRadius: height * 0.05,
                  maxRadius: height * 0.06,
                  backgroundColor: Colors.white,
                  child: Text('🍔', style: TextStyle(fontSize: height * 0.06)),
                ),
              ),
              title: Text(
                'Category Name',
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
          SliverList.builder(
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.grey.shade300,
                    title: Text('Item $index'),
                    subtitle: Text('Amount $index'),
                    trailing: Text('24-12-2022'),
                  ),
                ),
            itemCount: 15,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('Add Expense'),
      ),
    );
  }
}

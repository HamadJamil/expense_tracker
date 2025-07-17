import 'package:expense_tracker/forms/add_category_form.dart';
import 'package:expense_tracker/widgets/custom_tile.dart';
import 'package:expense_tracker/screens/expense_screen.dart';
import 'package:expense_tracker/local/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DatabaseProvider>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            actionsPadding: EdgeInsets.only(right: 10),
            actions: [Switch.adaptive(value: true, onChanged: (value) {})],
            backgroundColor: Colors.black,
            pinned: true,
            title: Text(
              'Expense Tracker',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            expandedHeight: height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/avatar.webp'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hamad Ahmad',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Consumer<DatabaseProvider>(
                            builder:
                                (ctx, db, _) => Text(
                                  db.categories.length.toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Total Spent',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '500',
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10.0),
              child: Text(
                'Categories',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Consumer<DatabaseProvider>(
            builder:
                (ctx, db, _) =>
                    db.categories.isEmpty
                        ? SliverFillRemaining(
                          child: Center(
                            child: Text('No Categories Added Yet!'),
                          ),
                        )
                        : SliverList.builder(
                          itemCount: db.categories.length,
                          itemBuilder: (ctx, idx) {
                            var category = db.categories[idx];
                            db.getCategoryExpense(categoryId: category.id);
                            return CustomTile(
                              title: category.name,
                              createdAt: category.createdAt,
                              totalSpent: db.getExpense,
                              emoji: category.emoji,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ExpenseScreen(model: category),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom,
                                      ),
                                      child: AddCategoryForm(
                                        isUpdate: true,
                                        id: category.id,
                                        name: category.name,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
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
                child: AddCategoryForm(),
              );
            },
          );
        },
        label: Text('Add Category', style: TextStyle(color: Colors.black)),
        icon: Icon(Icons.add, color: Colors.black),
        elevation: 10,
      ),
    );
  }
}

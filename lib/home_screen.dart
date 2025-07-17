import 'package:expense_tracker/add_category_form.dart';
import 'package:expense_tracker/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?_gl=1*7eok83*_ga*MzcwMTA3MjkyLjE3NDQ0MzE1MzU.*_ga_8JE65Q40S6*czE3NTI2NTcyNjckbzMkZzEkdDE3NTI2NTczMDEkajI2JGwwJGgw',
                    ),
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
                          Text(
                            '5',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (ctx, idx) {
              return CustomTile(
                title: 'Category $idx',
                createdAt: '2023-10-01',
                totalSpent: '1000',
                emoji: '🍔',
                onTap: () {},
                onLongPress: () {},
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddCategoryForm();
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

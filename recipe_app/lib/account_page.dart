import 'package:flutter/material.dart';

class User {
  final String name;
  final List<Map<String, dynamic>> recipes;

  User({required this.name, required this.recipes});
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final User user = User(
    name: 'John Doe',
    recipes: [
      {
        'imageUrl': 'https://dummyimage.com/600x400/',
        'title': 'Spaghetti Carbonara',
        'cookTime': '20 mins',
        'ingredients': ['Spaghetti', 'Eggs', 'Parmesan cheese', 'Pancetta', 'Pepper'],
        'steps': [
          'Boil the spaghetti.',
          'Cook the pancetta.',
          'Mix eggs and cheese.',
          'Combine everything.',
          'Serve with pepper.'
        ],
        'tips': ['Use fresh eggs.', 'Grate the cheese yourself.', 'Serve immediately.'],
      },
      {
        'imageUrl': 'https://dummyimage.com/600x400',
        'title': 'Chicken Alfredo',
        'cookTime': '30 mins',
        'ingredients': ['Chicken', 'Fettuccine', 'Butter', 'Cream', 'Parmesan cheese'],
        'steps': [
          'Cook the chicken.',
          'Boil the fettuccine.',
          'Make the Alfredo sauce.',
          'Combine everything.',
          'Serve with cheese.'
        ],
        'tips': ['Use heavy cream.', 'Cook pasta al dente.', 'Serve hot.'],
      },
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Text(
                'Account Page',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002D62),
                ),
              ),
            ),
            Text(
              'Name: ${user.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Number of recipes posted: ${user.recipes.length}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: user.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = user.recipes[index];
                  return RecipeCard(
                    imageUrl: recipe['imageUrl'],
                    title: recipe['title'],
                    cookTime: recipe['cookTime'],
                    ingredients: recipe['ingredients'],
                    steps: recipe['steps'],
                    tips: recipe['tips'],
                    trailing: PopupMenuButton<String>(
                      onSelected: (String result) {
                        if (result == 'Edit') {
                          // Handle edit action
                        } else if (result == 'Delete') {
                          // Handle delete action
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String cookTime;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tips;
  final Widget? trailing;

  const RecipeCard({
    required this.imageUrl,
    required this.title,
    required this.cookTime,
    required this.ingredients,
    required this.steps,
    required this.tips,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF002D62), width: 2.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(
                imageUrl: imageUrl,
                title: title,
                ingredients: ingredients,
                steps: steps,
                tips: tips,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002D62),
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                'Cook Time: $cookTime',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tips;

  const RecipeDetailPage({
    required this.imageUrl,
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.tips,
  });

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool isSaved = false;

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
      if (isSaved) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved the recipe: ${widget.title}')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF002D62),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    onPressed: toggleSave,
                    backgroundColor: const Color(0xFF002D62),
                    child: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002D62),
              ),
            ),
            const SizedBox(height: 8.0),
            ...widget.ingredients.map((ingredient) => Text('- $ingredient')).toList(),
            const SizedBox(height: 16.0),
            const Text(
              'Steps',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002D62),
              ),
            ),
            const SizedBox(height: 8.0),
            ...widget.steps.map((step) => Text('- $step')).toList(),
            const SizedBox(height: 16.0),
            const Text(
              'Tips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002D62),
              ),
            ),
            const SizedBox(height: 8.0),
            ...widget.tips.map((tip) => Text('- $tip')).toList(),
          ],
        ),
      ),
    );
  }
}
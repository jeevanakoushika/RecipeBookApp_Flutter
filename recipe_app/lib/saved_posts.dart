import 'package:flutter/material.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({super.key});

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  // Sample list of saved posts with detailed information
  final List<Map<String, dynamic>> savedPosts = [
    {
      'imageUrl': 'https://dummyimage.com/600x400/ff6347/fff',
      'title': 'Butter Chicken',
      'cookTime': '45 mins',
      'ingredients': ['Chicken', 'Butter', 'Tomato', 'Cream', 'Spices'],
      'steps': [
        'Marinate the chicken.',
        'Cook the chicken.',
        'Prepare the sauce.',
        'Combine chicken and sauce.',
        'Serve with naan or rice.'
      ],
      'tips': ['Use fresh cream.', 'Marinate overnight for better flavor.'],
    },
    {
      'imageUrl': 'https://dummyimage.com/600x400/ff6347/fff',
      'title': 'Paneer Tikka',
      'cookTime': '30 mins',
      'ingredients': ['Paneer', 'Yogurt', 'Spices', 'Bell peppers', 'Onions'],
      'steps': [
        'Marinate the paneer.',
        'Skewer the paneer and vegetables.',
        'Grill the skewers.',
        'Serve with mint chutney.'
      ],
      'tips': ['Use hung curd for marination.', 'Grill on high heat for charred edges.'],
    },
    {
      'imageUrl': 'https://dummyimage.com/600x400/ff6347/fff',
      'title': 'Biryani',
      'cookTime': '1 hr',
      'ingredients': ['Basmati rice', 'Meat or vegetables', 'Spices', 'Yogurt', 'Onions'],
      'steps': [
        'Cook the rice.',
        'Prepare the meat or vegetables.',
        'Layer rice and meat/vegetables.',
        'Cook on low heat.',
        'Serve with raita.'
      ],
      'tips': ['Use aged basmati rice.', 'Cook on dum for best results.'],
    },
    {
      'imageUrl': 'https://dummyimage.com/600x400/ff6347/fff',
      'title': 'Masala Dosa',
      'cookTime': '40 mins',
      'ingredients': ['Dosa batter', 'Potatoes', 'Onions', 'Spices', 'Coconut chutney'],
      'steps': [
        'Prepare the potato filling.',
        'Spread the dosa batter on a hot griddle.',
        'Add the filling and fold the dosa.',
        'Serve with chutney and sambar.'
      ],
      'tips': ['Use a non-stick pan.', 'Ferment the batter overnight.'],
    },
    {
      'imageUrl': 'https://dummyimage.com/600x400/ff6347/fff',
      'title': 'Chole Bhature',
      'cookTime': '50 mins',
      'ingredients': ['Chickpeas', 'Spices', 'Flour', 'Yogurt', 'Oil'],
      'steps': [
        'Prepare the chickpeas.',
        'Make the dough for bhature.',
        'Fry the bhature.',
        'Serve with chickpeas.'
      ],
      'tips': ['Soak chickpeas overnight.', 'Serve hot for best taste.'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Posts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set the back button color to white
        centerTitle: true,
        backgroundColor: Color(0xFF002D62),
      ),
      body: ListView.builder(
        itemCount: savedPosts.length,
        itemBuilder: (context, index) {
          final post = savedPosts[index];
          return RecipeCard(
            imageUrl: post['imageUrl'],
            title: post['title'],
            cookTime: post['cookTime'],
            ingredients: post['ingredients'],
            steps: post['steps'],
            tips: post['tips'],
          );
        },
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

  const RecipeCard({
    required this.imageUrl,
    required this.title,
    required this.cookTime,
    required this.ingredients,
    required this.steps,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFF002D62), width: 2.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002D62),
                ),
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
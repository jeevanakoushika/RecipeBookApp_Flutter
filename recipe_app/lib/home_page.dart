import 'package:flutter/material.dart';
import 'package:recipe_app/login_page.dart';
import 'package:recipe_app/saved_posts.dart'; // Import SavedPosts widget
import 'new_post.dart'; // Import NewPost widget
import 'account_page.dart';
import 'package:shared_preferences/shared_preferences.dart';// Import AccountPage widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    NewPost(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Clear the stored token

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _goToBookmarked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SavedPosts()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF002D62),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String result) {
              if (result == 'logout') {
                _logout();
              } else if (result == 'bookmarked') {
                _goToBookmarked();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'bookmarked',
                child: Text('Saved'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: const [
        RecipeCard(
          imageUrl: 'https://dummyimage.com/600x400/000/fff',
          title: 'Spaghetti Carbonara',
          cookTime: '20 mins',
          ingredients: ['Spaghetti', 'Eggs', 'Parmesan cheese', 'Pancetta', 'Pepper'],
          steps: [
            'Boil the spaghetti.',
            'Cook the pancetta.',
            'Mix eggs and cheese.',
            'Combine everything.',
            'Serve with pepper.'
          ],
          tips: ['Use fresh eggs.', 'Grate the cheese yourself.', 'Serve immediately.'],
        ),
        RecipeCard(
          imageUrl: 'https://dummyimage.com/600x400/000/fff',
          title: 'Chicken Alfredo',
          cookTime: '30 mins',
          ingredients: ['Chicken', 'Fettuccine', 'Butter', 'Cream', 'Parmesan cheese'],
          steps: [
            'Cook the chicken.',
            'Boil the fettuccine.',
            'Make the Alfredo sauce.',
            'Combine everything.',
            'Serve with cheese.'
          ],
          tips: ['Use heavy cream.', 'Cook pasta al dente.', 'Serve hot.'],
        ),

      ],
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

class RecipeSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search result for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : ['Recipe 1', 'Recipe 2', 'Recipe 3'].where((recipe) {
      return recipe.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
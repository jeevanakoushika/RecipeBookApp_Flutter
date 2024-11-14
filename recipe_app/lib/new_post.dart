import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _stepControllers = [];
  final List<TextEditingController> _tipControllers = [];
  XFile? _media;

  Future<void> _pickMedia() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedMedia = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _media = pickedMedia;
    });
  }

  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _addStepField() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }

  void _addTipField() {
    setState(() {
      _tipControllers.add(TextEditingController());
    });
  }

  void _removeIngredientField(int index) {
    setState(() {
      _ingredientControllers.removeAt(index);
    });
  }

  void _removeStepField(int index) {
    setState(() {
      _stepControllers.removeAt(index);
    });
  }

  void _removeTipField(int index) {
    setState(() {
      _tipControllers.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      final title = _titleController.text;
      final cookTime = _cookTimeController.text;
      final ingredients = _ingredientControllers.map((controller) => controller.text).toList();
      final steps = _stepControllers.map((controller) => controller.text).toList();
      final tips = _tipControllers.map((controller) => controller.text).toList();
      final media = _media;

      // You can now use the title, cook time, ingredients, steps, tips, and media to create a new recipe post
      print('Title: $title');
      print('Cook Time: $cookTime');
      print('Ingredients: $ingredients');
      print('Steps: $steps');
      print('Tips: $tips');
      print('Media: ${media?.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_media != null)
                Image.file(
                  File(_media!.path),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ElevatedButton(
                onPressed: _pickMedia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  minimumSize: const Size(double.infinity, 50), // Button size
                ),
                child: const Text('Upload Image or Video', style: TextStyle(color: Colors.white),),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cookTimeController,
                decoration: const InputDecoration(labelText: 'Cook Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cook time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Ingredients',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._ingredientControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: 'Ingredient'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an ingredient';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeIngredientField(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addIngredientField,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  minimumSize: const Size(double.infinity, 50), // Button size
                ),
                child: const Text('Add Ingredient', style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 20),
              const Text(
                'Steps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._stepControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: 'Step'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a step';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeStepField(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addStepField,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  minimumSize: const Size(double.infinity, 50), // Button size
                ),
                child: const Text('Add Step', style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tips',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._tipControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: 'Tip'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a tip';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeTipField(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addTipField,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  minimumSize: const Size(double.infinity, 50), // Button size
                ),
                child: const Text('Add Tip', style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF002D62), // Background color same as AppBar
                    minimumSize: const Size(200, 50), // Reduced button size
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.white), // Text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
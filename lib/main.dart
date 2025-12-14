import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book List',
      debugShowCheckedModeBanner: false,

      /// 🎨 App Theme
      theme: ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFF5F8FF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  cardTheme: const CardThemeData(
    elevation: 3,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
),


      home: const BookList(),
    );
  }
}

/// 📘 Book Model
class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

/// 📚 Book List Screen
class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final List<Book> _books = [Book(title: 'Clean Code', author: 'Robert C. Martin'),
  Book(title: 'Atomic Habits', author: 'James Clear'),
  Book(title: 'The Power of Habit', author: 'Charles Duhigg')];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  /// ➕ Show Add Book Dialog
  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Add New Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                  prefixIcon: Icon(Icons.book),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _titleController.clear();
                _authorController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addBook,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  /// ➕ Add Book Logic
  void _addBook() {
    final title = _titleController.text.trim();
    final author = _authorController.text.trim();

    if (title.isEmpty || author.isEmpty) return;

    setState(() {
      _books.add(Book(title: title, author: author));
    });

    _titleController.clear();
    _authorController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Book Library'),
      ),

      body: _books.isEmpty
          ? const Center(
              child: Text(
                'No books added yet 📚',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book, color: Colors.blue),
                    title: Text(
                      book.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(book.author),
                  ),
                );
              },
            ),

      /// ➕ FAB
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employee_model.dart';

class BirthdayWishScreen extends StatefulWidget {
  final Employee birthdayEmployee;

  const BirthdayWishScreen({
    super.key,
    required this.birthdayEmployee,
  });

  @override
  State<BirthdayWishScreen> createState() => _BirthdayWishScreenState();
}

class _BirthdayWishScreenState extends State<BirthdayWishScreen> {
  final TextEditingController _wishController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Employee _currentUser =
      employeeList.firstWhere((e) => e.id == 'EMP005');

  List<Employee> get otherEmployees =>
      employeeList.where((e) => e.id != widget.birthdayEmployee.id).toList();

  String get _collectionId => 'wishes_${widget.birthdayEmployee.id}';

  @override
  void initState() {
    super.initState();
    _seedInitialWishes();
  }

  Future<void> _seedInitialWishes() async {
    final snapshot = await _firestore.collection(_collectionId).limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    final seed = widget.birthdayEmployee.id.hashCode;
    final random = Random(seed);

    final othersExceptAdmin =
        otherEmployees.where((e) => e.id != _currentUser.id).toList();

    final wished =
        othersExceptAdmin.where((_) => random.nextDouble() < 0.7).toList();

    for (final e in wished) {
      await _firestore.collection(_collectionId).add({
        'wisherId': e.id,
        'wisherName': e.name,
        'wisherDepartment': e.department,
        'message':
            'Happy Birthday ${widget.birthdayEmployee.name}! 🎂 Wishing you a wonderful day filled with joy! 🎉',
        'timestamp': FieldValue.serverTimestamp(),
        'isAdmin': false,
      });
    }
  }

  Future<void> _sendWish() async {
    final msg = _wishController.text.trim();
    if (msg.isEmpty) return;

    _wishController.clear();

    await _firestore.collection(_collectionId).add({
      'wisherId': _currentUser.id,
      'wisherName': _currentUser.name,
      'wisherDepartment': _currentUser.department,
      'message': msg,
      'timestamp': FieldValue.serverTimestamp(),
      'isAdmin': true,
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _wishController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : const Color(0xFFFFF0F5),
      appBar: AppBar(
        title: const Text('Birthday Wishes'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(_collectionId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                final docs = snapshot.data?.docs ?? [];
                final wishedCount = docs.length;
                final totalCount = otherEmployees.length;

                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.pinkAccent, Colors.pink],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text('🎂',
                                style: TextStyle(fontSize: 60)),
                            const SizedBox(height: 8),
                            const Text(
                              'Today is the Birthday of',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.birthdayEmployee.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.birthdayEmployee.department,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$wishedCount / $totalCount wished',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Wishes Feed 💌',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      if (snapshot.connectionState ==
                          ConnectionState.waiting)
                        const Center(
                          child: CircularProgressIndicator(
                              color: Colors.pinkAccent),
                        )
                      else if (docs.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'No wishes yet! Be the first 🎂',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white54
                                    : Colors.black45,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final data = docs[index].data()
                                as Map<String, dynamic>;
                            final isAdmin =
                                data['wisherId'] == _currentUser.id;
                            final wisherName =
                                data['wisherName'] ?? 'Unknown';
                            final department =
                                data['wisherDepartment'] ?? '';
                            final message = data['message'] ?? '';

                            return Card(
                              elevation: isAdmin ? 4 : 2,
                              margin: const EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: isAdmin
                                    ? const BorderSide(
                                        color: Colors.pinkAccent,
                                        width: 1.5)
                                    : BorderSide.none,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: isAdmin
                                          ? Colors.pinkAccent
                                          : Colors.green,
                                      child: Text(
                                        wisherName[0].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: isAdmin
                                                      ? 'you'
                                                      : wisherName,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const TextSpan(
                                                    text: ' wished '),
                                                TextSpan(
                                                  text: widget
                                                      .birthdayEmployee.name,
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.pinkAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            message,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: isDark
                                                  ? Colors.white70
                                                  : Colors.black54,
                                              height: 1.4,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            isAdmin ? 'You' : department,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text('🎂',
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom send bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.pinkAccent,
                  child: Text(
                    _currentUser.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _wishController,
                    decoration: InputDecoration(
                      hintText: 'Write a birthday wish...',
                      filled: true,
                      fillColor: isDark
                          ? Colors.grey[800]
                          : const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendWish(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendWish,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

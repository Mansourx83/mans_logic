import 'package:flutter/material.dart';

class MultiSelection extends StatefulWidget {
  const MultiSelection({super.key});

  @override
  State<MultiSelection> createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  List<String> types = [
    "News",
    "Health",
    "Cooking",
    "Entertainment",
    "Sport",
    "Football",
    "Tech",
    "Flutter",
    "Ai",
    "Trending",
    "Fashion & Dressing",
    "LifeStyle",
  ];
  //set is better then list
  Set<String> emptyType = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 140),

            /// Title
            const Text(
              "What do you want to see on X?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            /// Tags Section
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(types.length, (index) {
                final type = types[index];
                final isSelected = emptyType.contains(type);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected ? emptyType.remove(type) : emptyType.add(type);
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1D9BF0).withOpacity(0.15)
                          : Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1D9BF0)
                            : Colors.grey.shade800,
                        width: 1.3,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF1D9BF0,
                                ).withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),

                    child: AnimatedScale(
                      scale: isSelected ? 1.07 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            /// Selected Items List
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: emptyType.map((v) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      v,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

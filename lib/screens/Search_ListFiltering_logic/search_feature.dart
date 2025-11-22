import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchFeature extends StatefulWidget {
  const SearchFeature({super.key});

  @override
  State<SearchFeature> createState() => _SearchFeatureState();
}

class _SearchFeatureState extends State<SearchFeature> {
  final TextEditingController _controller = TextEditingController();

  // ---------------- Products ----------------
  List<Map> products = [
    {
      "image":
          "https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?w=800",
      "title": "Brown Women Bag",
      "price": 70,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800",
      "title": "White Watch 40",
      "price": 130,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1541643600914-78b084683601?w=800",
      "title": "Men Chanel Perfume",
      "price": 2000,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800",
      "title": "Black Modern Glasses",
      "price": 1400,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800",
      "title": "Men Nike Shoes",
      "price": 150,
    },
  ];

  List<Map> filterList = [];

  // ----------- Active Selected Category ----------
  String activeCategory = "All";

  @override
  void initState() {
    filterList = List<Map>.from(products);
    super.initState();
  }

  // ---------------- Search ----------------
  void _searchFunction(String keyWord) {
    setState(() {
      filterList = products.where((product) {
        final title = product['title'].toString().toLowerCase();
        final input = keyWord.toLowerCase();
        return title.contains(input);
      }).toList();
    });
  }

  // ------------ Filter by Price ------------
  void _filterPrice() {
    setState(() {
      filterList = List<Map>.from(products);
      filterList.sort((a, b) => b['price'].compareTo(a['price']));
    });
  }

  // ------------ Filter Alphabetically ------------
  void _filterAlpha() {
    setState(() {
      filterList = List<Map>.from(products);
      filterList.sort((a, b) => a['title'].compareTo(b['title']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xfff5f6fa),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ------------------ Search Box -------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.black87,
                    onChanged: _searchFunction,
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      hintStyle: const TextStyle(height: 3.2),
                      prefixIcon: const Icon(CupertinoIcons.search),
                      suffixIcon: _controller.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _controller.clear();
                                _searchFunction('');
                                setState(() {});
                              },
                              child: const Icon(CupertinoIcons.clear_circled),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------ Categories -------------------
                Row(
                  children: [
                    _category("All", () => _searchFunction("")),
                    const SizedBox(width: 10),
                    _category("Men", () => _searchFunction("Men")),
                    const SizedBox(width: 10),
                    _category("Women", () => _searchFunction("Women")),
                    const SizedBox(width: 10),
                    _category("Nike", () => _searchFunction("Nike")),
                  ],
                ),

                const SizedBox(height: 20),

                // ------------------ Filters -------------------
                Row(
                  children: [
                    _filterButton(
                      Icons.filter_alt,
                      "Highest to Lowest",
                      _filterPrice,
                    ),
                    const SizedBox(width: 15),
                    _filterButton(Icons.sort_by_alpha, "A → Z", _filterAlpha),
                    const Spacer(),

                    // Clear button
                    GestureDetector(
                      onTap: () => setState(() {
                        filterList = List<Map>.from(products);
                        activeCategory = "All";
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.close, color: Colors.white, size: 14),
                            SizedBox(width: 5),
                            Text(
                              "Clear",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ------------------ Products List -------------------
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: filterList.length,
                    itemBuilder: (context, index) {
                      final product = filterList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product['image'],
                              width: 70,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            product['title'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: const Text(
                            "Best seller",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          trailing: Text(
                            "${product['price']}\$",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ Category Item -------------------
  Widget _category(String text, VoidCallback onTap) {
    final bool selected = activeCategory == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          activeCategory = text;
        });
        onTap();
      },
      child: Container(
        width: 70,
        height: 32,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ Filter Button -------------------
  Widget _filterButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

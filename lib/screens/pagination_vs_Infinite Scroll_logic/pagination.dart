import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  // List that stores all fetched items
  List<int> items = [];

  // Scroll controller to detect when user reaches the bottom
  final ScrollController controller = ScrollController();

  // Loading state to prevent multiple API calls at the same time
  bool isLoading = false;

  // Current page number
  int currentPage = 1;

  // Number of items per page
  final int pageSize = 25;

  // Maximum number of pages allowed
  final int maxPages = 3;

  /// ======================================================
  /// Fake API Call — Fetches paginated data
  /// ======================================================
  Future<void> _fetchData(int page) async {
    setState(() => isLoading = true);

    // Simulating network delay
    await Future.delayed(const Duration(seconds: 1));

    // Starting index of the page
    final start = (page - 1) * pageSize;

    // Generate fake items based on page number
    final newItems = List.generate(pageSize, (i) => start + i);

    setState(() {
      // Add new page items to the list
      items.addAll(newItems);

      // Set loading to false
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    // Load first page on startup
    _fetchData(currentPage);

    // Scroll listener (pagination trigger)
    controller.addListener(() {
      // When user is close to the bottom (120px before the end)
      final double trigger = controller.position.maxScrollExtent - 120;

      if (controller.position.pixels >= trigger &&
          !isLoading &&
          currentPage < maxPages) {
        currentPage++;
        _fetchData(currentPage);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3c72), Color(0xff2a5298)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 50),

            // Title
            const Text(
              "Pagination Demo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// ============================
            ///  LIST VIEW (Displays Items)
            /// ============================
            Expanded(
              child: ListView.builder(
                controller: controller, // scroll listener
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return AnimatedOpacity(
                    opacity: 1,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_bag,
                            size: 32,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Product : ${items[index]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Loading indicator when fetching new page
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 15,
                ),
              ),

            /// No more pages to load
            if (!isLoading && currentPage == maxPages)
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "✨ No More Data ✨",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

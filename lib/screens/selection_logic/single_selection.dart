import 'package:flutter/material.dart';

class SingleSelection extends StatefulWidget {
  const SingleSelection({super.key});

  @override
  State<SingleSelection> createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  List<Map> gifts = [
    {"name": "Lion", "image": "assets/animals/lion.png"},
    {"name": "cow", "image": "assets/animals/cow.png"},
    {"name": "deer", "image": "assets/animals/deer.png"},
    {"name": "rat", "image": "assets/animals/rat.png"},
    {"name": "giraffe", "image": "assets/animals/giraffe.png"},
    {"name": "tiger", "image": "assets/animals/tiger.png"},
    {"name": "white-tiger", "image": "assets/animals/white-tiger.png"},
    {"name": "pingeon", "image": "assets/animals/pingeon.png"},
    {"name": "rat", "image": "assets/animals/rat.png"},
  ];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242424),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: gifts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 50,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  selectedIndex == index
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.black26,
                                  Colors.black12,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),

                  Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                        height: selectedIndex == index ? 120 : 100,
                        child: Image.asset(
                          gifts[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 8),

                      selectedIndex == index
                          ? SizedBox.shrink()
                          : Text(
                              "${gifts[index]['name']}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ],
                  ),

                  selectedIndex == index
                      ? Positioned(
                          bottom: -5,
                          right: 0,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 52, 113),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                "Send",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

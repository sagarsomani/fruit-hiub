import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitapp/components/custom_text_field.dart';
import 'package:fruitapp/components/item_card.dart';
import 'package:fruitapp/constants.dart';
import 'package:fruitapp/model/item.dart';
import 'package:fruitapp/screens/basket.dart';
import 'package:fruitapp/screens/favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userName});
  final String userName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String selectedTab = "Hottest";
  bool isSearching = false;
  List<Item> searchResults = [];

  final recommendedItems = [
    Item(
      id: '1',
      title: 'Honey lime combo',
      imageUrl: 'assets/honey_lime_combo.png',
      price: 1500,
    ),
    Item(
      id: '2',
      title: 'Berry mango combo',
      imageUrl: 'assets/berry_mango_combo.png',
      price: 1600,
    ),
  ];

  final Map<String, List<Item>> categorizedItems = {
    "Hottest": [
      Item(
        id: '3',
        title: 'Tropical delight combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 1800,
        color: Color(0xFFFFFAEB),
      ),
      Item(
        id: '4',
        title: 'Citrus burst combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 1600,
        color: Color(0xFFFEF0F0),
      ),
      Item(
        id: '5',
        title: 'Lemon burst combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 1100,
        color: Color(0xFFF1EFF6),
      ),
    ],
    "Popular": [
      Item(
        id: '6',
        title: 'Berry blast combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 1700,
      ),
      Item(
        id: '7',
        title: 'Mango madness combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 1900,
      ),
    ],
    "New Combo": [
      Item(
        id: '8',
        title: 'Exotic fruit combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 2100,
      ),
      Item(
        id: '9',
        title: 'Seasonal special combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 2200,
      ),
    ],
    "Top": [
      Item(
        id: '10',
        title: 'Pineapple paradise combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 2300,
      ),
      Item(
        id: '11',
        title: 'Kiwi kale combo',
        imageUrl: 'assets/honey_lime_combo.png',
        price: 2400,
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchItems);
  }

  void searchItems() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        searchResults = [];
      });
      return;
    }

    final allItems = categorizedItems.values.expand((list) => list).toList();

    setState(() {
      isSearching = true;
      searchResults = allItems.where((item) {
        return item.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: kPrimaryColor),
              child: Text(
                'Welcome, ${widget.userName}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.house, color: kPrimaryColor),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.basketShopping,
                color: kPrimaryColor,
              ),
              title: Text('My Basket'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Basket()),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.heart, color: kPrimaryColor),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Favorites()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: customTwoLineIcon(),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Basket()),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10),
                  child: Icon(
                    FontAwesomeIcons.basketShopping,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'My basket',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 8),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hello ${widget.userName}, ',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 18),
                            ),
                            TextSpan(
                              text: 'What fruit salad combo do you want today?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      prefixIcon: Icons.search,
                      hintText: 'Search for fruit salad combos',
                      controller: searchController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.sliders),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (isSearching)
                SizedBox(
                  height: 220,
                  child: searchResults.isEmpty
                      ? Center(
                          child: Text(
                            'No results found.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final item = searchResults[index];
                            return ItemCard(
                              itemId: item.id,
                              itemName: item.title,
                              itemImageUrl: item.imageUrl,
                              itemPrice: item.price,
                              color: item.color,
                            );
                          },
                        ),
                )
              else ...[
                Text(
                  'Recommended Combo',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 10),
                Row(
                  children: recommendedItems.map((item) {
                    return Expanded(
                      child: ItemCard(
                        itemId: item.id,
                        itemName: item.title,
                        itemImageUrl: item.imageUrl,
                        itemPrice: item.price,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: categorizedItems.keys.map((tab) {
                    final isSelected = tab == selectedTab;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tab;
                          isSearching = false;
                          searchController.clear();
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tab,
                            style: TextStyle(
                              fontSize: isSelected ? 26 : 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          if (isSelected)
                            Container(
                              height: 2,
                              width: 30,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            )
                          else
                            const SizedBox(height: 2),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorizedItems[selectedTab]!.length,
                    itemBuilder: (context, index) {
                      final item = categorizedItems[selectedTab]![index];
                      return ItemCard(
                        itemId: item.id,
                        itemName: item.title,
                        itemImageUrl: item.imageUrl,
                        itemPrice: item.price,
                        color: item.color,
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

Widget customTwoLineIcon() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(width: 24, height: 3, color: Colors.black),
      SizedBox(height: 4),
      Container(width: 16, height: 3, color: Colors.black),
    ],
  );
}

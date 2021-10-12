import 'package:ant_icons/ant_icons.dart';
import 'package:fashion_ui/constants/colors.dart';
import 'package:fashion_ui/model/product.dart';
import 'package:fashion_ui/product/product_screen.dart';
import 'package:fashion_ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const categories = [
    "Autumn Specials",
    "Flash Sale 2021",
    "Formalwear",
    "Tiktok Trends",
  ];

  static const products = [
    Product(
      "https://static.zara.net/photos///2021/V/0/2/p/8574/560/401/2/w/750/8574560401_2_1_1.jpg?ts=1615547812020",
      "Bomber Jacket Black",
      749000,
    ),
    Product(
      "https://static.zara.net/photos///2021/I/0/2/p/1466/304/250/2/w/750/1466304250_1_1_1.jpg?ts=1627473732073",
      "Printed Denim White",
      1249000,
    ),
    Product(
      "https://static.zara.net/photos///2021/I/0/2/p/1466/306/400/2/w/750/1466306400_1_1_1.jpg?ts=1628234098629",
      "Denim Greyish Blue",
      899000,
    ),
    Product(
      "https://static.zara.net/photos///2021/I/0/2/p/6985/308/330/2/w/750/6985308330_2_5_1.jpg?ts=1631633374284",
      "Floral Print Padded Jacket",
      1999000,
    ),
    Product(
      "https://static.zara.net/photos///2021/I/0/2/p/1538/301/707/2/w/750/1538301707_2_4_1.jpg?ts=1630484941639",
      "Padded Utility Jacket",
      999000,
    ),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: SafeArea(
        child: _mainContent(),
      ),
    );
  }

  Widget _mainContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _header(),
          ),
          const SizedBox(height: 8.0),
          _categorySection(),
          const SizedBox(height: 8.0),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _itemGrid(),
            ),
          )
        ],
      );

  Widget _header() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          greetings(),
          IconButton(
            icon: Icon(AntIcons.search_outline),
            onPressed: () => print('Search clicked'),
          ),
        ],
      );

  Widget greetings() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Discover your",
            style: TextStyle(
              color: offBlack,
              fontSize: 24.0,
            ),
          ),
          const Text(
            "Style",
            style: TextStyle(
              fontSize: 64.0,
              color: orange,
              fontFamily: 'Qwigley',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );

  Widget _categorySection() => SizedBox(
        height: 60.0,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: HomeScreen.categories.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              child: _categoryWidget(
                HomeScreen.categories[i],
                _activeCategory == i,
              ),
              onTap: () {
                _activeCategory = i;
                setState(() {});
              },
            );
          },
          separatorBuilder: (_, i) => const SizedBox(width: 8.0),
        ),
      );

  Widget _categoryWidget(String text, bool isActive) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        decoration: isActive
            ? BoxDecoration(
                color: offBlack,
                borderRadius: BorderRadius.circular(16.0),
              )
            : BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16.0),
              ),
        child: Text(
          text,
          style: isActive
              ? const TextStyle(
                  color: offWhite,
                  fontWeight: FontWeight.w600,
                )
              : const TextStyle(color: offBlack),
        ),
      );

  Widget _itemGrid() => StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: 20,
        itemBuilder: (_, i) {
          final product = HomeScreen.products[i % 5];
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductScreen(product: product),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(formatCurrency(product.price)),
              ],
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(1, index.isEven ? 2 : 1),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
      );
}

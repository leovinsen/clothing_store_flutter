import 'package:fashion_ui/constants/colors.dart';
import 'package:fashion_ui/model/product.dart';
import 'package:fashion_ui/utils.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.product,
    required this.heroTag,
  }) : super(key: key);

  final Product product;
  final String heroTag;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  static const topMargin = kToolbarHeight;
  static const horizontalPadding = 24.0;

  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            _mainContent(),
            const Positioned(
              top: topMargin,
              left: horizontalPadding,
              child: BackButton(),
            ),
            Positioned(
              top: topMargin,
              right: horizontalPadding,
              child: _likeButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _likeButton() => Container(
        decoration: const BoxDecoration(
          color: offWhite,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: IconButton(
            onPressed: _toggleLike,
            icon: Icon(
              _isLiked
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_outlined,
              color: const Color(0xFFDA6764),
            ),
          ),
        ),
      );

  void _toggleLike() => setState(() {
        _isLiked = !_isLiked;
      });

  Widget _mainContent() => Column(
        children: [
          Flexible(
            child: _productImage(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _priceSection(),
                ElevatedButton(
                  onPressed: () => print('a'),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: offWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 0,
                  ),
                )
              ],
            ),
          )
        ],
      );

  Widget _productImage() {
    final image = Hero(
      tag: widget.heroTag,
      child: Image.network(
        widget.product.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
    final darkOverlay = Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Color(0x55000000),
          ],
        ),
      ),
    );
    return Stack(children: [
      image,
      Align(
        alignment: Alignment.bottomCenter,
        child: darkOverlay,
      ),
    ]);
  }

  Widget _priceSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Price"),
          Text(
            formatCurrency(widget.product.price),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}

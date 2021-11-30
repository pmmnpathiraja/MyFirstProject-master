import 'package:flutter/material.dart';
import 'package:lavajava/Models/Products.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:lavajava/Widgets/CustomText.dart';

class Details extends StatefulWidget {
  final Product product;

  Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Stack(children: <Widget>[
              Carousel(
                images: [
                  AssetImage('asset/${widget.product.image}'),
                ],
                dotBgColor: Colors.black,
                dotColor: Colors.white,
                dotIncreasedColor: Colors.orange,
                dotIncreaseSize: 1.2,
                autoplay: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "ShoppingCart");
                      },
                    ),
                  )
                ],
              )
            ]),
          ),
          CustomText(
            text: widget.product.name,
            size: 24,
            weight: FontWeight.bold,
          ),
          CustomText(
            text: "\Rs." + widget.product.price.toString(),
            size: 18,
            weight: FontWeight.w300,
            color: Colors.orange[100],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      size: 28,
                    ),
                    onPressed: () {}),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 24, 12),
                      child: GestureDetector(
                        onTap: () {
                          //methana tap kalama cart ekata yanna oni product eka
                        },
                        child: CustomText(
                            text: "Add to cart", color: Colors.white, size: 24),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.red[300],
                    ),
                    onPressed: () {}),
              ),
            ],
          )
        ],
      ),
    );
  }
}

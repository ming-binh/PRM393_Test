import 'package:flutter/material.dart';
import '../../Entities/Product.dart';

class ProductDetail extends StatelessWidget {
  final Product p;
  ProductDetail({super.key, required this.p});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Image.asset(p.image, height: 200, errorBuilder: (_, __, ___) => Icon(Icons.image, size: 100)),
        SizedBox(height: 10),
        Row(children: [
          Expanded(child: Text(p.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          Container(color: Colors.red, padding: EdgeInsets.all(4), child: Text('-${p.discountPercent}%', style: TextStyle(color: Colors.white))),
        ]),
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 20),
            children: [
              TextSpan(text: 'Price: ', style: TextStyle(color: Colors.grey)),
              TextSpan(text: '\$${p.price}', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        SizedBox(height: 5),
        Row(children: [
          Text('Rating: '),
          ...List.generate(5, (i) => Icon(
            i < p.starNumber.floor() ? Icons.star : (i < p.starNumber ? Icons.star_half : Icons.star_border),
            color: Colors.amber, size: 20,
          )),
          Text(' (${p.starNumber})'),
        ]),
        Text('This ís a product'),


        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
          label: Text('Add to Cart'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../Entities/Product.dart';
import '../../Repository/ProductDAO.dart';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int _tab = 0;
  String _query = "";
  Product? _sel;

  @override
  Widget build(BuildContext context) {
    final list = Productdao.findProductByName(_query);
    final tabs = [
      Column(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2,
              mainAxisExtent: 110,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final p = list[i];
              return InkWell(
                onTap: () => setState(() {
                  _sel = p;
                  _tab = 1;
                }),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            p.image,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(Icons.image, size: 50),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'Price: ', style: TextStyle(color: Colors.grey)),
                                      TextSpan(text: '\$${p.price}', style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Text(
                            '-${p.discountPercent}%',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
      _sel == null ? Center(child: Text('Select one')) : ProductDetail(p: _sel!),
      Center(child: Text('Cart Empty'))
    ];

    return Scaffold(
      appBar: AppBar(title: Text(['Home', 'Detail', 'Cart'][_tab]), centerTitle: true, backgroundColor: Colors.blue),
      body: tabs[_tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Detail'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}

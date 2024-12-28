import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailProdukPage extends StatefulWidget {
  final int productId;

  DetailProdukPage({super.key, required this.productId});

  @override
  _DetailProdukPageState createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  Map<String, dynamic> product = {};
  List<dynamic> reviews = [];
  int cartQuantity = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductDetail();
  }

  Future<void> fetchProductDetail() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('http://192.168.100.133:3006/product/${widget.productId}?format=json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['data'] != null && data['data']['product'] != null) {
          setState(() {
            product = data['data']['product']['data'] ?? {};
            reviews = data['data']['reviews'] ?? [];
            isLoading = false;
          });
        } else {
          throw Exception("Unexpected response format.");
        }
      } else {
        throw Exception("Failed to load product details: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching product details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : product.isEmpty
          ? Center(child: Text("Produk tidak ditemukan"))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: product['image_url'] != null
                      ? NetworkImage(product['image_url'])
                      : AssetImage('gambar/product.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Nama dan Harga
            Text(
              product['name'] ?? 'Nama produk tidak tersedia',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              "Rp ${product['price'] ?? 0}",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 16.0),
            // Divider
            Divider(color: Colors.grey[300], thickness: 1),
            // Deskripsi
            Text(
              "Deskripsi:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              product['description'] ?? 'Deskripsi tidak tersedia',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),
            Divider(color: Colors.grey[300], thickness: 1),
            // Tombol "Add to Cart"
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print("Add to Cart pressed");
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Ulasan
            Text(
              "Ulasan:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            reviews.isNotEmpty
                ? Column(
              children: reviews.map((review) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review['review']['comment'] ?? 'Tidak ada komentar',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (review['review']['ratings'] ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20.0,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
                : Text(
              "Belum ada ulasan.",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

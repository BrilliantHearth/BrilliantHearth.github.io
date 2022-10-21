class ProductCard{

  static List<ProductCard> getProductCards() => [
    ProductCard(title: 'SPHERES', imagePath: 'images/list_view_images/spheres.jpg'),
    ProductCard(title: 'TOWERS', imagePath: 'images/list_view_images/crystal_points.jpg'),
    ProductCard(title: 'CARVINGS', imagePath: 'images/list_view_images/carvings.jpg'),
    ProductCard(title: 'CANDLES', imagePath: 'images/list_view_images/candles.jpg'),
    ProductCard(title: 'BOTTLES', imagePath: 'images/list_view_images/water_bottles.jpg'),
    ProductCard(title: 'JEWELRY', imagePath: 'images/list_view_images/jewelry.jpg'),
    //ProductCard(title: 'CUSTOM ORDERS', imagePath: 'images/list_view_images/custom_orders.jpg'),
    //ProductCard(title: 'ACQUISITIONS', imagePath: 'images/list_view_images/acquisitions.jpg'),
  ];

  String title;
  String imagePath;

  ProductCard({required this.title, required this.imagePath});






}
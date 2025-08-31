/// مدل داده برای آیتم‌های منو
class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String categoryId;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
  });
}

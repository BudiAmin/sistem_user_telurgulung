class OrderModel {
  final int? id;
  final int userId;
  final int productId;
  final int totalBarang;
  final bool balado;
  final bool keju;
  final bool pedas;
  final bool asin;
  final bool barbeque;
  final int totalHarga;
  final String status;

  OrderModel({
    this.id,
    required this.userId,
    required this.productId,
    required this.totalBarang,
    this.balado = false,
    this.keju = false,
    this.pedas = false,
    this.asin = false,
    this.barbeque = false,
    required this.totalHarga,
    this.status = "menunggu_antrian",
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      totalBarang: json['total_barang'],
      balado: json['balado'] ?? false,
      keju: json['keju'] ?? false,
      pedas: json['pedas'] ?? false,
      asin: json['asin'] ?? false,
      barbeque: json['barbeque'] ?? false,
      totalHarga: json['total_harga'],
      status: json['status'] ?? "menunggu_antrian",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'total_barang': totalBarang,
      'balado': balado,
      'keju': keju,
      'pedas': pedas,
      'asin': asin,
      'barbeque': barbeque,
      'total_harga': totalHarga,
      'status': status,
    };
  }
}

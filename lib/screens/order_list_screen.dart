import 'package:flutter/material.dart';
import '../services/order_services.dart';
import 'order_detail_screen.dart';

class OrderListScreen extends StatefulWidget {
  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrderService _orderService = OrderService();
  List<dynamic> _orders = [];
  bool _loading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final orders = await _orderService.getMyOrders();
      setState(() {
        _orders = orders;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'diproses':
        return Colors.blue;
      case 'selesai':
        return Colors.green;
      case 'dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.access_time;
      case 'diproses':
        return Icons.restaurant;
      case 'selesai':
        return Icons.check_circle;
      case 'dibatalkan':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.receipt_long,
                        color: Colors.blue,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pesanan Saya',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Riwayat transaksi Anda',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : _error.isNotEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.red.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Gagal memuat pesanan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _error,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: _loadOrders,
                                    icon: const Icon(Icons.refresh),
                                    label: const Text('Coba Lagi'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : _orders.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 80,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Belum ada pesanan',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Mulai pesan telur gulung favorit Anda',
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: _loadOrders,
                                  color: Colors.blue,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(20),
                                    itemCount: _orders.length,
                                    itemBuilder: (context, index) {
                                      final order = _orders[index];
                                      return _buildOrderCard(order);
                                    },
                                  ),
                                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final status = order['status'] ?? 'pending';
    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/order-detail',
              arguments: order['id'],
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            statusIcon,
                            color: statusColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order #${order['id']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              order['created_at'] ?? '-',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor, width: 1.5),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade200),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade300,
                            Colors.orange.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.egg,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['product']?['nama'] ?? 'Produk',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order['total_barang']} item',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (order['balado'] == true ||
                    order['keju'] == true ||
                    order['pedas'] == true ||
                    order['asin'] == true ||
                    order['barbeque'] == true) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (order['balado'] == true) _buildToppingTag('Balado'),
                      if (order['keju'] == true) _buildToppingTag('Keju'),
                      if (order['pedas'] == true) _buildToppingTag('Pedas'),
                      if (order['asin'] == true) _buildToppingTag('Asin'),
                      if (order['barbeque'] == true)
                        _buildToppingTag('Barbeque'),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Harga',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          'Rp ${order['total_harga']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToppingTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.orange.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

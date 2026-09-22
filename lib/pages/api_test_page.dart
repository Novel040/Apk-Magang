import 'package:flutter/material.dart';

import '../models/gold_price.dart';
import '../services/api_service.dart';

class ApiTestPage extends StatefulWidget {
  const ApiTestPage({super.key});

  @override
  State<ApiTestPage> createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  bool isLoading = false;
  String? errorMessage;
  List<GoldPrice> goldPrices = [];

  Future<void> loadGoldPrices() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await ApiService.getGoldPrices();

      if (!mounted) return;

      setState(() {
        goldPrices = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadGoldPrices();
  }

  String _formatPrice(double price) {
    if (price < 10000) {
      return price.toStringAsFixed(2);
    }

    return price
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Test')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
            ? Center(child: Text(errorMessage!, textAlign: TextAlign.center))
            : goldPrices.isEmpty
            ? const Center(child: Text('Data kosong'))
            : ListView.builder(
                itemCount: goldPrices.length,
                itemBuilder: (context, index) {
                  final GoldPrice item = goldPrices[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(item.commodity),
                      subtitle: Text('Price: ${_formatPrice(item.price)}'),
                      trailing: Text(
                        item.recordedAt?.toLocal().toString() ?? '-',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadGoldPrices,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

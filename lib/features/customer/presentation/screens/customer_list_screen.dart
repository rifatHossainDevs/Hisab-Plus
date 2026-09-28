import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_plus/features/shared/presentation/widgets/show_snackbar_message.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/screen_background.dart';
import '../../data/models/customer_model.dart';
import '../providers/customer_list_provider.dart';
import '../widgets/customer_card.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  static const String name = '/customer-list';

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTEController = TextEditingController();
  final CustomerListProvider _customerListProvider = CustomerListProvider();

  String _searchQuery = '';

  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    _customerListProvider.getCustomerList();
    _scrollController.addListener(_loadMore);
    _searchTEController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchTEController.text.trim().toLowerCase();
    });
  }

  void _loadMore() {
    if (_customerListProvider.isLoading) return;

    if (_scrollController.position.extentAfter < 300) {
      _customerListProvider.getCustomerList();
    }
  }

  List<CustomerModel> _getFilteredCustomers(List<CustomerModel> customers) {
    if (_searchQuery.isEmpty) return customers;

    return customers.where((customer) {
      final name = customer.name.toLowerCase();
      final phone = (customer.phone ?? '').toLowerCase();
      final address = (customer.primaryAddress ?? '').toLowerCase();

      return name.contains(_searchQuery) ||
          phone.contains(_searchQuery) ||
          address.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _customerListProvider,
      child: PopScope(
        canPop: false,

        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          final now = DateTime.now();

          if (lastPressed == null ||
              now.difference(lastPressed!) > const Duration(seconds: 2)) {
            lastPressed = now;

            showSnackBarMessage(context, 'Press again to exit');
          } else {
            SystemNavigator.pop();
          }
        },
        child: ScreenBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'DOMINATE SOFTWARE',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withAlpha(400),
                              ),
                            ),
                            Text(
                              'Customers',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {
                            _customerListProvider.refreshCustomerList();
                          },
                          icon: const Icon(Icons.refresh, color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _searchTEController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _searchTEController.clear();
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: const Color(0xFFFAFCFB),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<CustomerListProvider>(
                  builder: (context, _, _) {
                    if (_customerListProvider.initialLoading) {
                      return CenteredProgressIndicator();
                    }

                    final filteredCustomers = _getFilteredCustomers(
                      _customerListProvider.customerList,
                    );

                    if (filteredCustomers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Customer Found',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              "Total customers: ${_customerListProvider.totalCustomer}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.themeColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: ListView.separated(
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  return CustomerCard(
                                    customerModel: filteredCustomers[index],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemCount: filteredCustomers.length,
                              ),
                            ),
                          ),

                          if (_customerListProvider.isLoadingMore)
                            _buildBottomLinearProgressIndicator(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomLinearProgressIndicator() {
    return Column(
      children: [
        const LinearProgressIndicator(),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTEController.dispose();
    super.dispose();
  }
}

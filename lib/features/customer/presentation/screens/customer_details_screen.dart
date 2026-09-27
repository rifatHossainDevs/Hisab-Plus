import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/urls.dart';
import '../../../shared/presentation/widgets/no_image.dart';
import '../../../shared/presentation/widgets/screen_background.dart';
import '../../data/models/customer_model.dart';
import '../widgets/customer_details_item.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key, required this.customerModel});

  static const String name = '/customer-details';

  final CustomerModel customerModel;

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final CustomerModel customer = widget.customerModel;

    return ScreenBackground(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48, bottom: 40),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _buildCustomerImage(customer.imagePath),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        customer.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      customer.primaryAddress?.toString() ??
                          'No Address Found',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xCCFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${customer.notes == null ? '': "${customer.notes} • "} Customer #${customer.id}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xB3FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 24,
                      right: 24,
                      bottom: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          "Contact",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF6B7685),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomerDetailsItem(
                          title: 'Phone',
                          value: customer.phone ?? '— not available —',
                        ),
                        CustomerDetailsItem(
                          title: 'Address',
                          value:
                              customer.primaryAddress?.toString() ??
                              'No Address Found',
                        ),
                        CustomerDetailsItem(
                          title: 'Email',
                          value: customer.email ?? '— not available —',
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "ACTIVITY",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF6B7685),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomerDetailsItem(
                          title: 'Last invoice',
                          value: customer.lastInvoiceNo == "" ? '—': customer.lastInvoiceNo ?? '—',
                        ),
                        CustomerDetailsItem(
                          title: 'Last sold product',
                          value: customer.lastSoldProduct == "" ? '—': customer.lastSoldProduct ?? '—',
                        ),
                        CustomerDetailsItem(
                          title: 'Total Sales',
                          value: '৳${customer.totalSalesValue}',
                        ),
                        CustomerDetailsItem(
                          title: 'Last transaction',
                          value: customer.lastTransactionDate ?? '—',
                        ),
                      ],
                    ),
                  ),

                  // Floating Summary Card
                  Positioned(
                    top: -44,
                    left: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black.withAlpha(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total due",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B7685),
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  customer.totalDue.toString(),
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFE04536),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 48,
                            width: 1,
                            color: const Color(0xFFE6EAEE),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total collection",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B7685),
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  customer.totalCollection.toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return const NoImage();
    }

    return CachedNetworkImage(
      imageUrl: '${Urls.imageUrl}$imagePath',
      fit: BoxFit.cover,
      placeholder: (_, _) => const NoImage(),
      errorWidget: (_, _, _) => const NoImage(),
    );
  }
}

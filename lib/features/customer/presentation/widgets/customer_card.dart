import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_plus/features/customer/data/models/customer_model.dart';

import '../../../../app/urls.dart';
import '../../../shared/presentation/widgets/no_image.dart';
import '../screens/customer_details_screen.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customerModel});

  final CustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CustomerDetailsScreen.name, arguments: customerModel);
      },
      child: Card(
        elevation: 2,
        color: const Color(0xFFE8F4F1),
        shadowColor: const Color(0xFF12836E).withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: _buildCustomerImage(),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: const Color(0xFF151B29),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      customerModel.primaryAddress?.toString() ??
                          'No address found',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF6B7685),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      customerModel.phone?.toString() ?? 'No phone found',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF6B7685),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL DUE",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF6B7685),
                    ),
                  ),
                  Text(
                    customerModel.totalDue.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFDE5A5A),
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

  Widget _buildCustomerImage() {
    final imagePath = customerModel.imagePath;

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

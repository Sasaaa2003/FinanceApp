import 'package:flutter/material.dart';

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardHolder;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;
  final String profileAsset; // optional: path asset e.g. 'assets/images/pf1.jpg'

  const AtmCard({
    super.key,
    required this.bankName,
    required this.cardHolder,
    required this.cardNumber,
    required this.balance,
    required this.color1,
    required this.color2,
    this.profileAsset = '',
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color2.withOpacity(0.28),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // subtle decorative shapes (like design on background)
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Profile small rounded-square at top-right
            Positioned(
              top: 12,
              right: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 52,
                  height: 38,
                  color: Colors.white.withOpacity(0.2),
                  child: profileAsset.isNotEmpty
                      ? Image.asset(profileAsset, fit: BoxFit.cover)
                      : Icon(Icons.person, color: Colors.white70),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top row: bank name and mini card icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bankName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // small rectangle simulating card icon
                      Container(
                        width: 46,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(2))),
                            Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.white70, shape: BoxShape.circle)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Balance
                  Text(
                    balance,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Chip and card number row
                  Row(
                    children: [
                      // chip mock
                      Container(
                        width: 42,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Container(
                            width: 18,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // card number (spaced)
                      Expanded(
                        child: Text(
                          cardNumber,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      // mastercard-like circles
                      Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF44336),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFC107),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // card holder
                  Text(
                    cardHolder.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

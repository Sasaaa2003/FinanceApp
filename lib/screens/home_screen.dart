import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _cards = [
    {
      'bank': 'Bank Nova',
      'holder': 'Anisa',
      'number': '**** 2345',
      'balance': '\$ 10,000',
      'c1': const Color.fromARGB(255, 246, 143, 59),
      'c2': const Color.fromARGB(255, 114, 56, 22),
      'profile': '',
    },
    {
      'bank': 'Savings',
      'holder': 'Anisa',
      'number': '**** 8765',
      'balance': '\$ 5,350',
      'c1': const Color.fromARGB(255, 27, 109, 11),
      'c2': const Color.fromARGB(255, 97, 211, 63),
      'profile': '',
    },
    {
      'bank': 'Business',
      'holder': 'Anisa Co',
      'number': '**** 9988',
      'balance': '\$ 25,200',
      'c1': const Color(0xFF1E40AF),
      'c2': const Color.fromARGB(255, 98, 94, 138),
      'profile': '',
    },
    {
      'bank': 'Backup',
      'holder': 'Anisa',
      'number': '**** 4433',
      'balance': '\$ 3,000',
      'c1': const Color.fromARGB(255, 116, 117, 117),
      'c2': const Color.fromARGB(255, 7, 8, 10),
      'profile': '',
    },
  ];

  int _selectedCard = 0;
  int _selectedMenu = -1;
  int _selectedBottomIndex = 0;

  late AnimationController _floatController;
  late Animation<Offset> _floatAnimation;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.03),
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel('Coffee Shop', '-Rp35.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp25.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp60.000', 'Event'),
      TransactionModel('Salary', '+Rp5.000.000', 'Income'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ Tambahkan bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: const Color(0xFF6B7280),
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline_rounded),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),

      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 355,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1E3A8A),
                    Color(0xFF6D8BE8),
                    Color.fromARGB(255, 4, 25, 88)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Color(0xFF1E3A8A)),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'welcome back, Anisa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 42,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.credit_card,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // === SWIPE CARD ===
                SizedBox(
                  height: 210,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _cards.length,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedCard = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final card = _cards[index];
                      final isSelected = index == _selectedCard;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        transform: Matrix4.identity()
                          ..scale(isSelected ? 1.03 : 0.97),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AtmCard(
                              bankName: card['bank'],
                              cardHolder: card['holder'],
                              cardNumber: card['number'],
                              balance: card['balance'],
                              color1: card['c1'],
                              color2: card['c2'],
                              profileAsset: card['profile'],
                            ),
                            if (isSelected)
                              SlideTransition(
                                position: _floatAnimation,
                                child: AtmCard(
                                  bankName: card['bank'],
                                  cardHolder: card['holder'],
                                  cardNumber: card['number'],
                                  balance: card['balance'],
                                  color1: card['c1'],
                                  color2: card['c2'],
                                  profileAsset: card['profile'],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAnimatedMenuButton(0, Icons.health_and_safety, 'Health'),
                      _buildAnimatedMenuButton(1, Icons.travel_explore, 'Travel'),
                      _buildAnimatedMenuButton(2, Icons.fastfood, 'Food'),
                      _buildAnimatedMenuButton(3, Icons.event, 'Event'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // === RECENT TRANSACTIONS ===
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent Transactions',
                            style: TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Column(
                            children: transactions.map((tx) {
                              IconData icon;
                              Color iconBg;
                              switch (tx.category) {
                                case 'Food':
                                  icon = Icons.fastfood_rounded;
                                  iconBg = const Color(0xFFFFE8E0);
                                  break;
                                case 'Travel':
                                  icon = Icons.travel_explore_rounded;
                                  iconBg = const Color(0xFFE0F2FE);
                                  break;
                                case 'Health':
                                  icon = Icons.health_and_safety_rounded;
                                  iconBg = const Color(0xFFE0FFE8);
                                  break;
                                case 'Event':
                                  icon = Icons.event_rounded;
                                  iconBg = const Color(0xFFEDE9FE);
                                  break;
                                default:
                                  icon = Icons.monetization_on_rounded;
                                  iconBg = const Color(0xFFF1F5F9);
                              }

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 4,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: iconBg,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(icon,
                                          color: const Color(0xFF1E3A8A), size: 26),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tx.title,
                                            style: const TextStyle(
                                              color: Color(0xFF0F172A),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            tx.category,
                                            style: const TextStyle(
                                              color: Color(0xFF6B7280),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      tx.amount,
                                      style: TextStyle(
                                        color: tx.amount.startsWith('-')
                                            ? Colors.redAccent
                                            : Colors.green,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedMenuButton(int index, IconData icon, String label) {
    final bool isSelected = _selectedMenu == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMenu = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 95,
        height: 65,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1E3A8A)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF1E3A8A),
                size: 28,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF1E3A8A),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

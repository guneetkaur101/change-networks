

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../models/product_detail.dart';
import '../models/top_search_model.dart';
import '../services/GplPaginatedApi.dart';
import '../services/api_service.dart';
import '../services/effective_date_service.dart';
import '../services/productdetailApi.dart';
import 'package:lottie/lottie.dart';

class CiscoGplPage extends StatelessWidget {
  const CiscoGplPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Full screen background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFECE9F1),
                  Color(0xFFCBC7D4),
                  Color(0xFFAAB5C4),
                ],
              ),
            ),
          ),
          // Top-right blurry semi-circle
          Positioned(
            top: -100,
            right: 530,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFCBD8E2),
                        Color(0xFFB6C4D4),
                        Color(0xFFECE9F1),
                      ],
                      radius: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom-left blurry semi-circle
          Positioned(
            bottom: -50,
            left: 240,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFCBD8E2),
                        Color(0xFFB6C4D4),
                        Color(0xFFECE9F1),
                      ],
                      radius: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Glassmorphic Dome (upside-down at bottom)
          Positioned(
            bottom: 85,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: DomeClipper(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  height: screenHeight * 0.75,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topCenter,
                      radius: 1.2,
                      colors: [
                        Colors.black.withOpacity(0.25), // Inner tint
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.9), width: 4),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(400),
                      topRight: Radius.circular(400),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // -- Main content (Glassmorphic search bar etc) --
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CiscoPriceListHeader(),
                  SizedBox(height: 20),
                  const CiscoSearchBar(),
                  const SizedBox(height: 40),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // Footer section remains unchanged
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 32,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: const [
                      ContactInfoBlock(
                        icon: Icons.email_outlined,
                        title: "Email",
                        subtitle: "info@change-networks.com",
                      ),
                      ContactInfoBlock(
                        icon: Icons.phone_outlined,
                        title: "Support",
                        subtitle: "24/7 Available",
                      ),
                      ContactInfoBlock(
                        icon: Icons.location_on_outlined,
                        title: "Global Offices",
                        subtitle: "Dubai, India, Hong Kong, China",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ContactInfoBlock({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F7), // Light blue background for icon
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2196F3), // Blue icon color
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // bottom-left
    path.quadraticBezierTo(
      size.width / 2, -size.height * 0.8, // top-center
      size.width, size.height, // bottom-right
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CiscoPriceListHeader extends StatefulWidget {
  const CiscoPriceListHeader({super.key});

  @override
  State<CiscoPriceListHeader> createState() => _CiscoPriceListHeaderState();
}

class _CiscoPriceListHeaderState extends State<CiscoPriceListHeader> {
  String? _formattedDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEffectiveDate();
  }

  Future<void> _loadEffectiveDate() async {
    final response = await EffectiveDateApiService.fetchEffectiveDate();
    if (response != null) {
      final parsedDate = DateTime.tryParse(response.effectiveDate);
      if (parsedDate != null) {
        setState(() {
          _formattedDate =
              "${_monthAbbr(parsedDate.month)} ${parsedDate.day}, ${parsedDate.year}";
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _formattedDate = "Unavailable";
        _isLoading = false;
      });
    }
  }

  String _monthAbbr(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Cisco Price List',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              // fontFamily: 'Segoe UI',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              _isLoading
                  ? 'Effective: Loading...'
                  : 'Effective: ${_formattedDate ?? "Unavailable"}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Most Accurate, Latest and Fastest Cisco Global Price List Search",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CiscoSearchBar extends StatefulWidget {
  const CiscoSearchBar({super.key});

  @override
  State<CiscoSearchBar> createState() => _CiscoSearchBarState();
}

class _CiscoSearchBarState extends State<CiscoSearchBar> {
  ProductDetail? _selectedProduct;

  final TextEditingController _searchController = TextEditingController();
  late Future<List<TopSearchProduct>> futureProducts;

  String _activeTab = 'Top Search';
  String _searchQuery = "";

  late List<TopSearchProduct> _allProducts = [];
  late List<TopSearchProduct> _filteredProducts = [];

  List<ProductDetail> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    ApiService.fetchTopSearchProducts().then((products) {
      setState(() {
        _allProducts = products;
        _filteredProducts = List.from(products);
      });
    });
    _searchController.addListener(() {
      setState(() {}); // So the suffixIcon updates live
    });
  }

  // void _onRowTap(String procCode) async {
  //
  //   final product = await ProductDetailApi.fetchProductDetail(procCode);
  //   if (product != null) {
  //     setState(() {
  //       _selectedProduct = product;
  //       _searchController.text = procCode;
  //       _activeTab = 'GPL Search'; // Switch tab
  //     });
  //     // Trigger the search automatically for GPL tab
  //     _onSearch();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to fetch product details')),
  //     );
  //   }
  // }

  void _onRowTap(String procCode) async {
    setState(() {
      _isLoading = true;
      _searchResults = [];
      _activeTab = 'GPL Search'; // Switch immediately
      _searchController.text = procCode;
      _searchQuery = procCode;
    });

    final product = await ProductDetailApi.fetchProductDetail(procCode);
    if (product != null) {
      setState(() {
        _selectedProduct = product;
        _isLoading = false;
      });
      _onSearch(); // Triggers new search
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch product details')),
      );
    }
  }

  void showQuoteDialog(BuildContext context, String procCode) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    String selectedCountry = "India 🇮🇳";

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Request Quote',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                const SizedBox(height: 8),

                // Dialog content
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: 'Full Name *',
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email *',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCountry,
                              items: [
                                "India 🇮🇳",
                                "USA 🇺🇸",
                                "UK 🇬🇧",
                                "Germany 🇩🇪",
                                "Australia 🇦🇺"
                              ].map((country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(country),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) selectedCountry = value;
                              },
                              decoration: const InputDecoration(labelText: "Country"),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: mobileController,
                              decoration: const InputDecoration(
                                labelText: 'Mobile *',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(text: procCode),
                              decoration: const InputDecoration(
                                labelText: 'Product Code *',
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: quantityController,
                              decoration: const InputDecoration(labelText: 'Quantity *'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: messageController,
                        decoration: const InputDecoration(labelText: 'Message *'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Captcha here ",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Footer actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE53935), Color(0xFFB71C1C)], // Reddish gradient
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Validate and submit
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  void _onSearch() async {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _searchQuery = query;
    });

    if (_activeTab == 'Top Search') {
      if (query.isEmpty) {
        setState(() {
          _filteredProducts = List.from(_allProducts);
        });
      } else {
        setState(() {
          _filteredProducts = _allProducts
              .where(
                  (product) => product.procCode.toLowerCase().startsWith(query))
              .toList();
        });
      }
    } else if (_activeTab == 'GPL Search' || _activeTab == 'Product Search') {
      // if (query.isNotEmpty) {
      //   final filteredResults =
      //       await GplPaginatedApi.fetchFilteredProducts(query);
      //
      //   if (filteredResults.isNotEmpty) {
      //     setState(() {
      //       _searchResults = filteredResults;
      //     });
      //   } else {
      //     setState(() {
      //       _searchResults = [];
      //     });
      //   }
      // }
      if (query.isNotEmpty) {
        setState(() {
          _isLoading = true;
          _searchResults = [];
        });

        try {
          final filteredResults =
          await GplPaginatedApi.fetchFilteredProducts(query);
          setState(() {
            _searchResults = filteredResults;
          });
        } catch (e) {
          // handle error (optional)
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }


  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = "";
      _selectedProduct = null;

      if (_activeTab == 'Top Search') {
        _filteredProducts = List.from(_allProducts);
      } else if (_activeTab == 'GPL Search' || _activeTab == 'Product Search') {
        _searchResults = [];
      }
    });
  }


  Widget _buildSearchTabs() {
    final tabs = ['GPL Search', 'Product Search', 'Top Search'];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      children: tabs.map((label) {
        final isActive = label == _activeTab;
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: isActive ? Colors.blue : Colors.white,
            side: BorderSide(
                color: isActive ? Colors.lightBlue : Colors.grey[400]!),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            setState(() {
              _activeTab = label;
              // _onSearch();
              _selectedProduct = null;

              _searchQuery = "";
              _searchResults = [];
              if (label == 'Top Search') {
                _searchController.clear();
                _filteredProducts = List.from(_allProducts);
              }
            });
          },
          child: Text(label,
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w500)),
        );
      }).toList(),
    );
  }

  Widget _buildTopSearchTable() {
    if (_filteredProducts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          _searchQuery.isNotEmpty
              ? 'No results found for "$_searchQuery".'
              : 'Enter a keyword to search or check "Top Search" tab.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      );
    }

    final scrollController = ScrollController();

    return Center(
      child: Container(
        width: 700,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: const [
                  Expanded(
                      flex: 1,
                      child: Text('Rank',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 3,
                      child: Text('Product Code',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text('Search Frequency',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            // Scrollable content
            SizedBox(
              height: 300,
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    // final row = _filteredProducts[index];
                    final product = _filteredProducts[index];
                    return InkWell(
                      onTap: () => _onRowTap(product.procCode),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Text('${index + 1}')),
                            Expanded(flex: 3, child: Text(product.procCode)),
                            Expanded(
                                flex: 2,
                                child:
                                    Text(product.searchFrequency.toString())),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return 'Invalid Date';
    }
  }

  Widget _buildGplProductList() {
    if (_searchResults.isEmpty ||
        (_activeTab != 'GPL Search' && _activeTab != 'Product Search')) {
      return const SizedBox.shrink();
    }

    final scrollController = ScrollController();

    return Center(
      child: Container(
        width: 1100,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
        ),
        child: Column(
          children: [
           // (outside scrollable area)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: const Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text('Product Code',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14))),
                  Expanded(
                      flex: 6,
                      child: Text('Description',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14))),
                  Expanded(
                      flex: 2,
                      child: Text('GPL (\$)',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14))),
                  Expanded(
                      flex: 1,
                      child: Text('EOS',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14))),
                  Expanded(
                      flex: 1,
                      child: Text('GET QUOTE',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14))),
                ],
              ),
            ),

            // Scrollable product rows with scrollbar
            SizedBox(
              height: 300, // Adjust height as needed
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final product = _searchResults[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text(product.procCode,style:TextStyle(fontSize: 14))),
                          Expanded(flex:6, child: Text(product.proDesc,style:TextStyle(fontSize: 14))),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "\$${product.price.toStringAsFixed(2)}",style:TextStyle(fontSize: 14))),
                          Expanded(flex: 1, child: Text(_formatDate(product.eos) ?? 'N/A',style:TextStyle(fontSize: 14))),
                          SizedBox(
                            width: 100, // Make button width fixed
                            child: ElevatedButton(
                                onPressed: () => showQuoteDialog(context, product.procCode),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text("Get Quote",
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildSearchTabs(),
          const SizedBox(height: 24),
          GlassmorphicContainer(
            width: 850,
            height: 110,
            borderRadius: 60,
            blur: 20,
            border: 1.6,
            alignment: Alignment.center,
            linearGradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: (_) => _onSearch(),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // Remove default TextField border
                            hintText: '"Enter product code to search..."',
                            hintStyle: TextStyle(color: Colors.black54),
                            // filled: false,
                            // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear,
                                        color: Colors.grey[600]),
                                    onPressed: _clearSearch,
                                  )
                                : null,
                          ),
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        onPressed: _onSearch,
                        icon: const Icon(Icons.search, size: 18),
                        label: const Text('Search'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_activeTab == 'Top Search') _buildTopSearchTable(),
          if (_activeTab == 'GPL Search' || _activeTab == 'Product Search')
            // _buildGplProductList(),
            // _isLoading
            //     ? const Padding(
            //   padding: EdgeInsets.all(40),
            //   child: CircularProgressIndicator(),
            // )
            //     : _buildGplProductList(),
            _isLoading
                ? const Padding(
              padding: EdgeInsets.all(40),
              child: SizedBox(
                width: 100,
                height: 100,
                child: LottieLoader(),
              ),
            )
                : _buildGplProductList(),

        ],
      ),
    );
  }
}




class LottieLoader extends StatelessWidget {
  const LottieLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/trail_loader.json',
      repeat: true,
      animate: true,
      width: 100,
      height: 100,
    );
  }
}

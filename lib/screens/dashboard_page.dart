import 'package:flutter/material.dart';
import 'orbit_animation.dart';

class DashboardPage extends StatelessWidget {
  // const DashboardPage({super.key});
  final void Function(String label, int index, [int? dropdownIndex]) onCardTap;

  const DashboardPage({super.key, required this.onCardTap});
  @override
  Widget build(BuildContext context) {
    // return _UnderConstructionPage(title: 'Dashboard');
    return _UnderConstructionPage(title: 'Dashboard', onCardTap: onCardTap);
  }
}

class _UnderConstructionPage extends StatelessWidget {
  final String title;
  // const _UnderConstructionPage({required this.title});
  final void Function(String label, int index, [int? dropdownIndex]) onCardTap;
  const _UnderConstructionPage({
    required this.title,
    required this.onCardTap,
  });
  // ..starting
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(
  //           Icons.construction,
  //           size: 64,
  //           color: const Color.fromARGB(255, 72, 72, 72),
  //         ),
  //         SizedBox(height: 16),
  //         Text(
  //           '$title under construction',
  //           style: Theme.of(context).textTheme.headlineSmall,
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           'We are working hard to bring this page to you soon!',
  //           style: Theme.of(context).textTheme.bodyMedium,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //just chnge networks
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Row(
  //       children: [
  //         // LEFT: Dashboard content
  //         Expanded(
  //           flex: 3,
  //           child: Padding(
  //             padding: const EdgeInsets.all(24.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("Change networks", style: Theme.of(context).textTheme.headlineSmall),
  //                 const SizedBox(height: 20),
  //                 // Add more widgets here
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //         // RIGHT: Orbit animation
  //         Expanded(
  //           flex: 2,
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: OrbitingAnimation(), // Animated orbit widget
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //without responsive
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // backgroundColor: Colors.black,
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(48.0),
  //         child: Column(
  //           children: [Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // LEFT: Dashboard content
  //           Expanded(
  //             flex: 3,
  //             child: Padding(
  //               padding: const EdgeInsets.all(48.0),
  //               child: Column(
  //                 // crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children:  [
  //
  //                   RichText(
  //                     text: TextSpan(
  //                       style: TextStyle(
  //                         fontSize: 32,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                         height: 1.3,
  //                       ),
  //                       children: [
  //                         TextSpan(text: "CHANGE "),
  //                         TextSpan(
  //                           text: "Networks",
  //                           style: TextStyle(
  //                             color: Colors.blue.shade700, // Change color as desired
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const TextSpan(text: ": Your Global IT Networking Partner"),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   SizedBox(height: 24),
  //                   Text(
  //                     "CHANGE Networks is a leading multinational IT company specializing in software development and networking hardware distribution. ",
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       color: Colors.black54,
  //                       height: 1.5,
  //                     ),
  //                   ),
  //                   SizedBox(height: 80),
  //
  //                   // Grid of clickable cards
  //                   //without images
  //                   //   GridView.count(
  //                   //     shrinkWrap: true,
  //                   //     physics: NeverScrollableScrollPhysics(),
  //                   //     crossAxisCount: 4,
  //                   //     crossAxisSpacing: 16,
  //                   //     mainAxisSpacing: 16,
  //                   //     children: [
  //                   //       _buildFeatureCard(context, "Gallery", 1),
  //                   //       _buildFeatureCard(context, "Products", 2),
  //                   //       _buildFeatureCard(context, "Youtube", null,
  //                   //           isExternal: true),
  //                   //       _buildFeatureCard(context, "Cisco GPL", 7),
  //                   //     ],
  //                   //   ),
  //                   GridView.count(
  //                     shrinkWrap: true,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     crossAxisCount: 4,
  //                     crossAxisSpacing: 16,
  //                     mainAxisSpacing: 16,
  //                     children: [
  //                       _buildFeatureCard(context, "Gallery", 1, imagePath: "assets/icons/gallery.jpg"),
  //                       _buildFeatureCard(context, "Products", 2, imagePath: "assets/icons/product.jpg"),
  //                       _buildFeatureCard(context, "Youtube", null, isExternal: true, imagePath: "assets/icons/youtube.jpg"),
  //                       _buildFeatureCard(context, "Cisco GPL", 7, imagePath: "assets/icons/cisco.jpg"),
  //                     ],
  //                   ),
  //
  //
  //                 ],
  //               ),
  //             ),
  //           ),
  //
  //           // RIGHT: Orbit animation
  //           Expanded(
  //             flex: 2,
  //             child: Align(
  //               alignment: Alignment.center,
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.8,
  //                 child: const OrbitingAnimation(),
  //               ),
  //           ),
  //           ),
  //
  //         ],
  //       ),
  //   ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //not accurate responsove
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(48.0),
  //         child: LayoutBuilder(
  //           builder: (context, constraints) {
  //             final isWide = constraints.maxWidth > 1000;
  //
  //             return Flex(
  //               direction: isWide ? Axis.horizontal : Axis.vertical,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // LEFT CONTENT: Text and Cards
  //                 Expanded(
  //                   flex: isWide ? 3 : 0,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(24.0),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         RichText(
  //                           text: TextSpan(
  //                             style: const TextStyle(
  //                               fontSize: 32,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black,
  //                               height: 1.3,
  //                             ),
  //                             children: [
  //                               const TextSpan(text: "CHANGE "),
  //                               TextSpan(
  //                                 text: "Networks",
  //                                 style: TextStyle(
  //                                   color: Colors.blue.shade700,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                               const TextSpan(
  //                                   text: ": Your Global IT Networking Partner"),
  //                             ],
  //                           ),
  //                         ),
  //                         const SizedBox(height: 24),
  //                         const Text(
  //                           "CHANGE Networks is a leading multinational IT company specializing in software development and networking hardware distribution.",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             color: Colors.black54,
  //                             height: 1.5,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 48),
  //
  //                         /// Card Grid
  //                         GridView.count(
  //                           shrinkWrap: true,
  //                           physics: const NeverScrollableScrollPhysics(),
  //                           crossAxisCount: isWide ? 4 : 2,
  //                           crossAxisSpacing: 16,
  //                           mainAxisSpacing: 16,
  //                           childAspectRatio: 1,
  //                           children: [
  //                             _buildFeatureCard(context, "Gallery", 1,
  //                                 imagePath: "assets/icons/gallery.jpg"),
  //                             _buildFeatureCard(context, "Products", 2,
  //                                 imagePath: "assets/icons/product.jpg"),
  //                             _buildFeatureCard(context, "Youtube", null,
  //                                 isExternal: true,
  //                                 imagePath: "assets/icons/youtube.jpg"),
  //                             _buildFeatureCard(context, "Cisco GPL", 7,
  //                                 imagePath: "assets/icons/cisco.jpg"),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //
  //                 // RIGHT CONTENT: Orbit Animation
  //                 if (isWide)
  //                   Expanded(
  //                     flex: 2,
  //                     child: Center(
  //                       child: SizedBox(
  //                         height: MediaQuery.of(context).size.height * 0.6,
  //                         child: const OrbitingAnimation(),
  //                       ),
  //                     ),
  //                   )
  //                 else
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 32.0),
  //                     child: Center(
  //                       child: SizedBox(
  //                         height: 300,
  //                         child: const OrbitingAnimation(),
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 1000;

              if (isWide) {
                // Wide Screen Layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT: Text + Cards
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleAndDescription(context),
                            const SizedBox(height: 48),
                            _buildCardGrid(context, isWide),
                          ],
                        ),
                      ),
                    ),

                    // RIGHT: Animation
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: const OrbitingAnimation(),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Small Screen Layout (Column)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _buildTitleAndDescription(context),
                    ),

                    const SizedBox(height: 48), // Increased spacing before animation

                    // Move animation further down
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: SizedBox(
                          height: 280,
                          child: const OrbitingAnimation(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 48), // Added more spacing before grid
                    _buildCardGrid(context, isWide),
                  ],
                );

              }
            },
          ),
        ),
      ),
    );
  }


  //without images
  // Widget _buildFeatureCard(BuildContext context, String title, int? index,
  //     {bool isExternal = false}) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (isExternal) {
  //         // For example: open YouTube link
  //         // You can use `url_launcher` package
  //         // launchUrl(Uri.parse("https://www.youtube.com/@commandonetworks/featured"));
  //       } else {
  //         onCardTap(title, index!);
  //       }
  //     },
  //
  //   child: Card(
  //       elevation: 4,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       color: Colors.white,
  //       child: Center(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(
  //             title,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black87,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //image size too small
  Widget _buildFeatureCard(BuildContext context, String title, int? index,
      {bool isExternal = false, required String imagePath}) {
    return InkWell(
      onTap: () {
        if (isExternal) {
          // Open external URL without needing Developer  Mode on Windows
        } else {
          onCardTap(title, index!);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Rounded Image
              LayoutBuilder(
                builder: (context, constraints) {
                  final iconSize = constraints.maxWidth * 0.3; // 30% of card width
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildTitleAndDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.3,
            ),
            children: [
              const TextSpan(text: "CHANGE "),
              TextSpan(
                text: "Networks",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ": Your Global IT Networking Partner"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "CHANGE Networks is a leading multinational IT company specializing in software development and networking hardware distribution.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }
//for 2 card on vertical
  // Widget _buildCardGrid(BuildContext context, bool isWide) {
  //   return GridView.count(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     // crossAxisCount: isWide ? 4 : 2,
  //     crossAxisCount: isWide ? 4 : MediaQuery.of(context).size.width > 600 ? 2 : 1,
  //   //        > 1000px: 4 cards
  //   // > 600px: 2 cards
  //   //
  //   // <= 600p: 1 card per row
  //
  //
  //     crossAxisSpacing: 16,
  //     mainAxisSpacing: 16,
  //     childAspectRatio: 1,
  //     children: [
  //       _buildFeatureCard(context, "Gallery", 1,
  //           imagePath: "assets/icons/gallery.jpg"),
  //       _buildFeatureCard(context, "Products", 2,
  //           imagePath: "assets/icons/product.jpg"),
  //       _buildFeatureCard(context, "Youtube", null,
  //           isExternal: true, imagePath: "assets/icons/youtube.jpg"),
  //       _buildFeatureCard(context, "Cisco GPL", 7,
  //           imagePath: "assets/icons/cisco.jpg"),
  //     ],
  //   );
  // }

  Widget _buildCardGrid(BuildContext context, bool isWide) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double aspectRatio;

    if (width > 1200) {
      crossAxisCount = 4;
      aspectRatio = 1.1;
    } else if (width > 1000) {
      crossAxisCount = 4;
      aspectRatio = 1.1;
    } else if (width > 800) {
      crossAxisCount = 3;
      aspectRatio = 1.1;
    } else if (width > 600) {
      crossAxisCount = 2;
      aspectRatio = 1;
    } else {
      crossAxisCount = 1; // still 2 on small devices
      aspectRatio = 1.2;
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: aspectRatio,
      children: [

        _buildFeatureCard(context, "Gallery", 1,
            imagePath: "assets/icons/gallery.jpg"),
        _buildFeatureCard(context, "Products", 2,
            imagePath: "assets/icons/product.jpg"),
        _buildFeatureCard(context, "Youtube", null,
            isExternal: true, imagePath: "assets/icons/youtube.jpg"),
        _buildFeatureCard(context, "Cisco GPL",3,
            imagePath: "assets/icons/cisco.jpg"),
        _buildFeatureCard(context, "Gallery", 1,
            imagePath: "assets/icons/gallery.jpg"),
        _buildFeatureCard(context, "Products", 2,
            imagePath: "assets/icons/product.jpg"),
        _buildFeatureCard(context, "Youtube", null,
            isExternal: true, imagePath: "assets/icons/youtube.jpg"),
        _buildFeatureCard(context, "Cisco GPL", 3,
            imagePath: "assets/icons/cisco.jpg"),

      ],
    );
  }


}

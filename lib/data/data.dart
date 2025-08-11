// product_data.dart

class CategoryNode {
  final String name;
  final String? imageUrl;
  final List<CategoryNode>? subCategories;

  CategoryNode(this.name, {this.imageUrl, this.subCategories});
}

// Sample image links (replace with your actual links)
final List<CategoryNode> sidebarCategories = [
  CategoryNode('Switches', imageUrl: 'https://i.imgur.com/Je2KzrA.png', subCategories: [
    CategoryNode('Managed Switches', imageUrl: 'https://i.imgur.com/A1.png', subCategories: [
      CategoryNode('C3500 L3+ Series Switches', imageUrl: 'https://i.imgur.com/B1.png'),
      CategoryNode('C3000 L3 Series Switches', imageUrl: 'https://i.imgur.com/B2.png'),
      CategoryNode('E3000 L3 Series', imageUrl: 'https://i.imgur.com/B3.png'),
      CategoryNode('IE3000 L3 Industrial Series', imageUrl: 'https://i.imgur.com/B4.png'),
      CategoryNode('C2000 L2+ Series', imageUrl: 'https://i.imgur.com/B5.png'),
      CategoryNode('E2000 L2+ Series', imageUrl: 'https://i.imgur.com/B6.png'),
    ]),
    CategoryNode('Unmanaged Switches', imageUrl: 'https://i.imgur.com/A2.png'),
  ]),
  CategoryNode('Wireless', imageUrl: 'https://i.imgur.com/ALoYzC5.png', subCategories: [
    CategoryNode('E1100 Series', imageUrl: 'https://i.imgur.com/W1.png'),
    CategoryNode('E1000 Series', imageUrl: 'https://i.imgur.com/W2.png'),
    CategoryNode('Indoor Access Point', imageUrl: 'https://i.imgur.com/W3.png'),
    CategoryNode('IE1000 Industrial Series', imageUrl: 'https://i.imgur.com/W4.png'),
    CategoryNode('Outdoor Access Point', imageUrl: 'https://i.imgur.com/W5.png'),
    CategoryNode('E300 Series', imageUrl: 'https://i.imgur.com/W6.png'),
    CategoryNode('Wireless Bridge', imageUrl: 'https://i.imgur.com/W7.png'),
    CategoryNode('E200 AI Series', imageUrl: 'https://i.imgur.com/W8.png'),
    CategoryNode('Wireless Controllers', imageUrl: 'https://i.imgur.com/W9.png'),
    CategoryNode('E100 Series', imageUrl: 'https://i.imgur.com/W10.png'),
    CategoryNode('Wi-Fi Adapters', imageUrl: 'https://i.imgur.com/W11.png'),
  ]),
  CategoryNode('Routers', imageUrl: 'https://i.imgur.com/3fGrGkN.png'),
  CategoryNode('Gateways', imageUrl: 'https://i.imgur.com/l5qIHQZ.png', subCategories: [
    CategoryNode('Wi-Fi Routers', imageUrl: 'https://i.imgur.com/G1.png'),
  ]),
  CategoryNode('Accessories', imageUrl: 'https://i.imgur.com/5SxOPMY.png', subCategories: [
    CategoryNode('AIR-R3000AX', imageUrl: 'https://i.imgur.com/A3000.png'),
    CategoryNode('Media Converters', imageUrl: 'https://i.imgur.com/M1.png'),
    CategoryNode('AIR-R1200-4G', imageUrl: 'https://i.imgur.com/A1200.png'),
    CategoryNode('SFP Modules', imageUrl: 'https://i.imgur.com/SFP.png'),
    CategoryNode('PoE Injectors & Adapters', imageUrl: 'https://i.imgur.com/POE.png'),
    CategoryNode('RJ45 Connectors', imageUrl: 'https://i.imgur.com/RJ45.png'),
    CategoryNode('Copper Patch Cables', imageUrl: 'https://i.imgur.com/Copper.png'),
    CategoryNode('PLC Splitter', imageUrl: 'https://i.imgur.com/PLC.png'),
    CategoryNode('DAC/AOC Cables', imageUrl: 'https://i.imgur.com/DAC.png'),
    CategoryNode('Fiber Patch Cables', imageUrl: 'https://i.imgur.com/Fiber.png'),
  ]),
];
final topLevelCategories = sidebarCategories
    .map((c) => CategoryNode(c.name, imageUrl: c.imageUrl))
    .toList();

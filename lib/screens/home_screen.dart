
import 'package:change_user/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/top_navbar.dart';
import '../screens/dashboard_page.dart';
import '../screens/gallery_page.dart';
import '../screens/products_page.dart';
import '../screens/order_matrix_page.dart';
import '../screens/quote_matrix_page.dart';
import '../screens/quote_tools_page.dart';
import '../screens/sales_matrix_page.dart';
import '../screens/cisco_gpl_page.dart';
import 'Login_Page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  static final GlobalKey<_MainScaffoldState> globalKey = GlobalKey<_MainScaffoldState>();

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  String _selectedPage = 'Dashboard';
  int _selectedIndex = 0;
  int? _selectedDropdownIndex;

  void changePage(String label, int index, [int? dropdownIndex]) {
    setState(() {
      _selectedPage = label;
      _selectedIndex = index;
      _selectedDropdownIndex = dropdownIndex;
    });
  }

  Widget _getPageWidget() {
    switch (_selectedPage) {
      case 'Dashboard':
        // return const DashboardPage();
        return  DashboardPage(onCardTap: changePage);
      case 'Gallery':
        return const GalleryPage();
      case 'Products':
        return const ProductsPage();
      case 'Order Matrix':
        return const OrderMatrixPage();
      case 'Quote Matrix':
        return const QuoteMatrixPage();
      case 'Quote Tools':
        return const QuoteToolsPage();
      case 'Sales Matrix':
        return const SalesMatrixPage();
      case 'Cisco GPL':
        return const CiscoGplPage();
      case 'Login':
        return const LoginPage();


      default:
        return DashboardPage(onCardTap: changePage);

    }
  }

  // void _onSidebarSelect(String label, int index, [int? dropdownIndex]) {
  //   setState(() {
  //     _selectedPage = label;
  //     _selectedIndex = index;
  //     _selectedDropdownIndex = dropdownIndex;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            // isLoggedIn: auth.isLoggedIn,
            onLoginPressed: () => changePage('Login', 99), ),
          SecondTopNavbar(
            selectedIndex: _selectedIndex,
            selectedDropdownIndex: _selectedDropdownIndex,
            // onSelect: _onSidebarSelect,
            onSelect: changePage,
          ),
          Expanded(child: _getPageWidget()),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold();
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  const FeatureCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
import 'package:dashpro/core/theme/app_colors.dart';
import 'package:dashpro/core/theme/app_textstyle.dart';
import 'package:dashpro/core/utils/responsive.dart';
import 'package:dashpro/features/model/dashboard_model.dart';
import 'package:dashpro/features/model/state_card_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String activeTile = 'Dashboard';
  String selectedIndex = 'This Week';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);
    final width = Responsive.width(context);
    final height = Responsive.height(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.scaffoldBG,

      drawer: isMobile
          ? Drawer(width: 250, child: _buildSidebar(context))
          : null,
      body: Row(
        children: [
          isMobile
              ? SizedBox()
              : SizedBox(
                  width: isTablet
                      ? Responsive.width(context) / 4
                      : Responsive.width(context) / 4.6,
                  child: _buildSidebar(context),
                ),
          Expanded(
            flex: isTablet ? 7 : 5,
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---[HEADER SECTION]---
                    _buildHeader(),

                    //---[STATE CARD]---
                    _buildStateCardItems(isTablet, context),

                    SizedBox(height: 10),
                    //---[REVENUE + SALES CATEGORY SECTION]---
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: isMobile
                          //MOBILE VIEW
                          ? _mobileView(context)
                          : isTablet
                          // TABLET VIEW
                          ? _tabletView(context)
                          //DESKTOP VIEW
                          : _desktopView(context),
                    ),

                    //TOP PRODUCT + CUSTOMER LOCATION + RECENT ACTIVITIES
                    _buildTopProductCustomerRecentActivitySection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopProductCustomerRecentActivitySection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);
    final width = Responsive.width(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),

      // ================= DESKTOP =================
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTopProductsCard(context)),
                SizedBox(width: 20),
                Expanded(
                  child: _buildCustomerLocations(
                    isTablet,
                    width,
                    isMobile,
                    isDesktop,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(child: _buildRecentActivityCard()),
              ],
            )
          // ================= TABLET =================
          : isTablet
          ? Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildTopProductsCard(context)),
                    SizedBox(width: 20),
                    Expanded(
                      child: _buildCustomerLocations(
                        isTablet,
                        width,
                        isMobile,
                        isDesktop,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildRecentActivityCard(),
              ],
            )
          // ================= MOBILE =================
          : Column(
              children: [
                _buildTopProductsCard(context),
                SizedBox(height: 20),
                _buildCustomerLocations(isTablet, width, isMobile, isDesktop),
                SizedBox(height: 20),
                _buildRecentActivityCard(),
              ],
            ),
    );
  }

  Widget _buildRecentActivityCard() {
    return Container(
      height: 360,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: buildRevenueHeader(
              true,
              title: 'Recent Activity',
              Text(
                'View all',
                style: MyAppTextStyles.cardTitle.copyWith(
                  color: Colors.blue,
                  fontSize: 8,
                ),
              ),
            ),
          ),

          // LIST
          Expanded(
            child: ListView(
              children: [
                _activityTile(
                  'New Order Received',
                  '#ORD-1245',
                  '2 min ago',
                  Icons.sticky_note_2_outlined,
                  Colors.purple,
                ),
                _activityTile(
                  'Payment received',
                  '\$1837',
                  '10 min ago',
                  Icons.wallet,
                  Colors.green,
                ),
                _activityTile(
                  'New Customer Registered',
                  'Babar Azam',
                  '30 min ago',
                  Icons.group_outlined,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityTile(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      title: Text(title, style: MyAppTextStyles.heading.copyWith(fontSize: 10)),
      subtitle: Text(subtitle, style: MyAppTextStyles.caption),
      leading: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      trailing: Text(time, style: MyAppTextStyles.caption),
    );
  }

  Row _buildCustomerLocations(
    bool isTablet,
    double width,
    bool isMobile,
    bool isDesktop,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildRevenueCard(
            width: isTablet
                ? width / 3
                : isMobile
                ? double.infinity
                : width / 3.75,
            height: 230,
            buildRevenueHeader: buildRevenueHeader(
              isDesktop,
              title: 'Customer  Locations',
              SizedBox(),
            ),
            body: Row(),
            vertical: 12,
            horizontal: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTopProductsCard(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);
    final width = Responsive.width(context);
    final height = Responsive.height(context);
    return Container(
      width: isTablet
          ? width / 2.85
          : isMobile
          ? double.infinity
          : width / 3.78,
      height: 230,
      padding: EdgeInsets.symmetric(vertical: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,

            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        children: [
          //REVENUE HEADER TEXT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: buildRevenueHeader(
              true,
              title: 'Top  Products',
              Text(
                'View all',
                style: MyAppTextStyles.cardTitle.copyWith(
                  color: Colors.blue,
                  fontSize: 8,
                ),
              ),
            ),
          ),
          Divider(indent: 15, endIndent: 15, thickness: 0.5),

          //TOP PRODUCT TITLES
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              _topProductTitles(
                                title: 'Products',
                                isGrowth: false,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _topProductTitles(
                            title: 'Sales',
                            isGrowth: false,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: _topProductTitles(
                            title: 'Revenue',
                            isGrowth: false,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _topProductTitles(
                            title: 'Growth',
                            isGrowth: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(indent: 15, endIndent: 15, thickness: 0.2),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        _buildProductRow(
                          image: 'assets/png/profile.png',
                          productTitle: 'Wireless Headphone',
                          sales: '1287',
                          revenue: '12,746.00',
                          growth: '↑ 15.3%',
                        ),
                        Divider(indent: 15, endIndent: 15, thickness: 0.2),

                        _buildProductRow(
                          image: 'assets/png/profile.png',
                          productTitle: 'Smart Watch',
                          sales: '856',
                          revenue: '8756.00',
                          growth: '↑ 8.4%',
                        ),

                        Divider(indent: 15, endIndent: 15, thickness: 0.2),

                        _buildProductRow(
                          image: 'assets/png/profile.png',
                          productTitle: 'Camera Lens',
                          sales: '625',
                          revenue: '5378.00',
                          growth: '↓ 3.3%',
                          growthTextColor: Colors.redAccent.shade200,
                        ),

                        Divider(indent: 15, endIndent: 15, thickness: 0.2),

                        _buildProductRow(
                          image: 'assets/png/profile.png',
                          productTitle: 'Speaker',
                          sales: '547',
                          revenue: '4839.00',
                          growth: '↑ 6.3%',
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
    );
  }

  Widget _buildProductRow({
    required String image,
    required String productTitle,
    required String sales,
    required String revenue,
    required String growth,
    Color growthTextColor = const Color(0xFF10B981),
  }) {
    return Row(
      children: [
        /// Product Section
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: _topProductTitles(
                  title: productTitle,
                  isGrowth: false,
                  maxLine: 2,
                ),
              ),
            ],
          ),
        ),

        /// Sales
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _topProductTitles(title: sales, isGrowth: false),
          ),
        ),

        /// Revenue
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _topProductTitles(title: revenue, isGrowth: false),
          ),
        ),

        /// Growth
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _topProductTitles(
              title: growth,
              isGrowth: true,
              growthTextColor: growthTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _topProductTitles({
    Color? growthTextColor,
    required bool isGrowth,
    required String title,
    int maxLine = 1,
  }) {
    return Text(
      title,
      overflow: Responsive.isTablet(context) ? TextOverflow.ellipsis : null,
      softWrap: true,
      maxLines: maxLine,
      style: isGrowth
          ? MyAppTextStyles.growthLabel.copyWith(
              fontSize: 9,
              color: growthTextColor,
            )
          : MyAppTextStyles.cardTitle.copyWith(fontSize: 9),
    );
  }

  //DESKTOP VIEW
  Widget _desktopView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildRevenueCard(
            width: double.infinity,
            height: 240,
            vertical: 12,
            horizontal: 12,
            buildRevenueHeader: buildRevenueHeader(
              true,
              title: 'Revenue Overview',
              _buildDropDown(),
            ),
            body: buildRevenueChart(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _buildRevenueCard(
            width: 300,
            height: 240,
            vertical: 12,
            horizontal: 12,
            buildRevenueHeader: buildRevenueHeader(
              true,
              title: 'Sales by Category',
              _buildDropDown(),
            ),
            body: _buildSalesCard(true, context),
          ),
        ),
        const SizedBox(width: 16),
        _buildRevenueCard(
          width: Responsive.width(context) / 5,
          height: 240,
          vertical: 18,
          horizontal: 0,
          buildRevenueHeader: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: buildRevenueHeader(
                  true,
                  title: 'Upcoming Tasks',
                  Text(
                    'View all',
                    style: MyAppTextStyles.cardTitle.copyWith(
                      color: Colors.blue,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    _buildTaskTiles(
                      icon: Icons.check_circle,
                      title: 'Review new dashboard',
                      subTitle: 'UI/UX Design',
                      date: 'May 20',
                      dateColor: Colors.redAccent.shade200,
                      isActive: false,
                    ),
                    SizedBox(height: 12),
                    _buildTaskTiles(
                      icon: Icons.check_circle_outline,
                      title: 'Create marketing plan',
                      subTitle: 'Marketing',
                      date: 'May 21',
                      dateColor: Colors.grey.shade400,
                      isActive: true,
                    ),
                    SizedBox(height: 12),

                    _buildTaskTiles(
                      icon: Icons.check_circle_outline,
                      title: 'Update product list',
                      subTitle: 'Product Team',
                      date: 'May 22',
                      dateColor: Colors.grey.shade400,
                      isActive: true,
                    ),
                    SizedBox(height: 12),

                    _buildTaskTiles(
                      icon: Icons.check_circle_outline,
                      title: 'Client meeting',
                      subTitle: 'Project Discussion',
                      date: 'May 23',
                      dateColor: Colors.grey.shade400,
                      isActive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Container(),
        ),
      ],
    );
  }

  //TABLET VIEW
  Widget _tabletView(BuildContext context) {
    return Column(
      children: [
        _buildRevenueCard(
          width: double.infinity,
          height: 240,
          vertical: 12,
          horizontal: 12,
          buildRevenueHeader: buildRevenueHeader(
            false,
            title: 'Revenue Overview',
            _buildDropDown(),
          ),
          body: buildRevenueChart(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildRevenueCard(
                width: Responsive.width(context) / 2.8,
                height: 240,
                vertical: 12,
                horizontal: 12,
                buildRevenueHeader: Column(
                  children: [
                    buildRevenueHeader(
                      false,
                      title: 'Sales by Category',
                      _buildDropDown(),
                    ),
                    SizedBox(height: 8),
                    _buildSalesCard(false, context),
                  ],
                ),
                body: SizedBox(),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildRevenueCard(
                    width: Responsive.width(context) / 2.6,

                    height: 240,
                    vertical: 18,
                    horizontal: 12,
                    buildRevenueHeader: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),

                          child: buildRevenueHeader(
                            false,
                            title: 'Upcoming Tasks',
                            Text(
                              'View all',
                              style: MyAppTextStyles.cardTitle.copyWith(
                                color: Colors.blue,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              _buildTaskTiles(
                                icon: Icons.check_circle,
                                title: 'Review new dashboard',
                                subTitle: 'UI/UX Design',
                                date: 'May 20',
                                dateColor: Colors.redAccent.shade200,
                                isActive: false,
                              ),
                              SizedBox(height: 12),
                              _buildTaskTiles(
                                icon: Icons.check_circle_outline,
                                title: 'Create marketing plan',
                                subTitle: 'Marketing',
                                date: 'May 21',
                                dateColor: Colors.grey.shade400,
                                isActive: true,
                              ),
                              SizedBox(height: 12),

                              _buildTaskTiles(
                                icon: Icons.check_circle_outline,
                                title: 'Update product list',
                                subTitle: 'Product Team',
                                date: 'May 22',
                                dateColor: Colors.grey.shade400,
                                isActive: true,
                              ),
                              SizedBox(height: 12),

                              _buildTaskTiles(
                                icon: Icons.check_circle_outline,
                                title: 'Client meeting',
                                subTitle: 'Project Discussion',
                                date: 'May 23',
                                dateColor: Colors.grey.shade400,
                                isActive: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    body: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //MOBILE VIEW
  Widget _mobileView(BuildContext context) {
    return Column(
      children: [
        _buildRevenueCard(
          width: double.infinity,
          height: 240,
          vertical: 12,
          horizontal: 12,
          buildRevenueHeader: buildRevenueHeader(
            false,
            title: 'Revenue Overview',
            _buildDropDown(),
          ),
          body: buildRevenueChart(),
        ),
        const SizedBox(height: 16),
        _buildRevenueCard(
          width: double.infinity,
          height: 240,
          vertical: 12,
          horizontal: 12,
          buildRevenueHeader: Column(
            children: [
              buildRevenueHeader(
                false,
                title: 'Sales by Category',
                _buildDropDown(),
              ),
              SizedBox(height: 5),
              _buildSalesCard(false, context),
            ],
          ),
          body: SizedBox(),
        ),
        const SizedBox(height: 16),
        _buildRevenueCard(
          width: double.infinity,
          height: 240,
          vertical: 18,
          horizontal: 12,
          buildRevenueHeader: Column(
            children: [
              buildRevenueHeader(
                false,
                title: 'Upcoming Tasks',
                Text(
                  'View all',
                  style: MyAppTextStyles.cardTitle.copyWith(
                    color: Colors.blue,
                    fontSize: 8,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    _buildTaskTiles(
                      icon: Icons.check_circle,
                      title: 'Review new dashboard',
                      subTitle: 'UI/UX Design',
                      date: 'May 20',
                      dateColor: Colors.redAccent.shade200,
                      isActive: false,
                    ),
                    SizedBox(height: 12),
                    _buildTaskTiles(
                      icon: Icons.check_circle_outline,
                      title: 'Create marketing plan',
                      subTitle: 'Marketing',
                      date: 'May 21',
                      dateColor: Colors.grey.shade400,
                      isActive: true,
                    ),
                    SizedBox(height: 12),

                    _buildTaskTiles(
                      icon: Icons.check_circle_outline,
                      title: 'Update product list',
                      subTitle: 'Product Team',
                      date: 'May 22',
                      dateColor: Colors.grey.shade400,
                      isActive: true,
                    ),
                    SizedBox(height: 12),

                    _buildTaskTiles(
                      icon: Icons.check_circle_outline,
                      title: 'Client meeting',
                      subTitle: 'Project Discussion',
                      date: 'May 23',
                      dateColor: Colors.grey.shade400,
                      isActive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SizedBox(),
        ),
      ],
    );
  }

  //TASK TILES
  Widget _buildTaskTiles({
    required bool isActive,
    required IconData icon,
    required String title,
    required String subTitle,
    required String date,
    required Color dateColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isActive ? Colors.grey.shade400 : Colors.green,
          size: 18,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: MyAppTextStyles.cardTitle.copyWith(fontSize: 10),
            ),
            Text(
              subTitle,
              style: MyAppTextStyles.cardTitle.copyWith(
                fontSize: 9,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          date,
          style: MyAppTextStyles.cardTitle.copyWith(
            fontSize: 8.5,
            color: dateColor,
          ),
        ),
      ],
    );
  }

  //SALES CARD
  Row _buildSalesCard(bool isDesktop, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: isDesktop ? 150 : 150,
              width: isDesktop
                  ? 150
                  : Responsive.isMobile(context)
                  ? 200
                  : 95,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: isDesktop ? 38 : 38,
                  sections: _sections(),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: MyAppTextStyles.cardTitle.copyWith(fontSize: 10),
                ),
                Text(
                  '\$45,231',
                  style: MyAppTextStyles.heading.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            children: [
              _legendItem(
                title: 'Electronics',
                percentage: '40',
                color: Colors.blue.shade700,
              ),
              SizedBox(height: 10),
              _legendItem(
                title: 'Fashion',
                percentage: '25',
                color: Colors.deepPurpleAccent,
              ),
              SizedBox(height: 10),

              _legendItem(
                title: 'Home & Living',
                percentage: '20',
                color: Colors.greenAccent,
              ),
              SizedBox(height: 10),

              _legendItem(
                title: 'Beauty',
                percentage: '20',
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  //SALES ITEMS
  Widget _legendItem({
    required String title,
    required String percentage,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 5),
            Text(title, style: MyAppTextStyles.cardTitle.copyWith(fontSize: 8)),
          ],
        ),
        Text(
          '$percentage%',
          style: MyAppTextStyles.cardTitle.copyWith(fontSize: 8),
        ),
      ],
    );
  }

  //PIE SECTIONS
  List<PieChartSectionData> _sections() {
    return [
      _buildPieChartSectionData(value: 40, color: Colors.blue.shade700),
      _buildPieChartSectionData(value: 25, color: Colors.deepPurpleAccent),
      _buildPieChartSectionData(value: 20, color: Colors.greenAccent),
      _buildPieChartSectionData(value: 15, color: Colors.orange),
    ];
  }

  //PIE MODEL
  PieChartSectionData _buildPieChartSectionData({
    required double value,
    required Color color,
    bool showTitle = false,
    double radius = 20,
  }) {
    return PieChartSectionData(
      value: value,
      color: color,
      showTitle: showTitle,
      radius: radius,
    );
  }

  //REVENUE CARD
  Widget _buildRevenueCard({
    required double width,
    required double height,
    required Widget buildRevenueHeader,
    required Widget body,
    required double vertical,
    required double horizontal,
  }) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,

            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        children: [
          //REVENUE HEADER TEXT
          buildRevenueHeader,

          SizedBox(height: 30),

          //REVENUE CHART CHILD
          body,
        ],
      ),
    );
  }

  //REVENUE HEADER
  Row buildRevenueHeader(
    bool isDesktop,
    Widget child, {
    required String title,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //STATE HEADER
        Text(title, style: MyAppTextStyles.heading.copyWith(fontSize: 11)),

        //DROP DOWN MENU
        child,
      ],
    );
  }

  //REVENUE CHART FL
  SizedBox buildRevenueChart() {
    return SizedBox(
      height: 150,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 40,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 9.9,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.grey.shade200, strokeWidth: 1);
            },
          ),
          titlesData: _buildAxesTitles(),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(1, 10),
                FlSpot(2, 8),
                FlSpot(3, 15),
                FlSpot(4, 10),
                FlSpot(5, 25),
                FlSpot(6, 19),
                FlSpot(7, 40),
              ],
              isCurved: true,
              color: AppColors.secondaryBlue,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondaryBlue.withValues(alpha: 0.3),
                    AppColors.secondaryBlue.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //DROP DOWN REVENUE SECTION
  Container _buildDropDown() {
    return Container(
      height: 28,
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined, size: 14),
          value: selectedIndex,
          items: ['This Week', 'Last Week', 'This Month'].map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: MyAppTextStyles.cardTitle.copyWith(
                  fontSize: 8,
                  color: Colors.black54,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedIndex = newValue!;
            });
          },
        ),
      ),
    );
  }

  FlTitlesData _buildAxesTitles() {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) {
            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            if (value.toInt() >= 0 && value.toInt() < days.length) {
              return SideTitleWidget(
                space: 10,
                meta: meta,
                child: Text(
                  days[value.toInt()],
                  style: MyAppTextStyles.caption.copyWith(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return SideTitleWidget(
              angle: 0.0,
              space: 8,
              meta: meta,
              child: Text(
                '\$${value.toInt()}K',
                style: MyAppTextStyles.caption.copyWith(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //STATE CARDS LIST
  Widget _buildStateCardItems(bool isTablet, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTablet = Responsive.isTablet(context);
    bool isDesktop = Responsive.isDesktop(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          //---[GREETINGS SECTION]---
          _buildGreetings(),

          //---[STATE CARD SECTION]---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stateCardItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile
                    ? 1
                    : isTablet
                    ? 2
                    : 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 10,
                childAspectRatio: isDesktop
                    ? 2.12
                    : isTablet
                    ? 2.2
                    : 2.95,
              ),
              itemBuilder: (context, index) {
                final state = stateCardItems[index];

                return _buildStateCard(
                  cIcon: state.cIcon,
                  containerColor: state.color,
                  title: state.title,
                  subTitle: state.subTitle,
                  growthText: state.growthText,
                  lineColor: state.color,
                  iconSize: state.iconSize ?? 18,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //SIDE BAR
  Widget _buildSidebar(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: AppColors.sidebarDark),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Row(
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.dashboard, color: AppColors.primaryBlue),
                  SizedBox(width: 10),
                  Text(
                    'DashPro',
                    style: MyAppTextStyles.cardTitle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              ...dashList.map((list) {
                return _buildListTile(
                  title: list.title,
                  icon: list.icon,
                  onTap: () => setState(() => activeTile = list.title),
                  isSelectedTile: activeTile == list.title,
                );
              }),

              Responsive.isDesktop(context)
                  ? SizedBox(height: 450)
                  : SizedBox(height: 20),
              Responsive.isMobile(context)
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        bottom: 20,
                        right: 15,
                      ),
                      child: Container(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade900),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                        'assets/png/profile.png',
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Responsive.isDesktop(context)
                                        ? Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              Text(
                                                'Bilal Ahmad',
                                                style: MyAppTextStyles.heading
                                                    .copyWith(
                                                      color:
                                                          Colors.grey.shade400,

                                                      fontSize: 12,
                                                    ),
                                              ),
                                              Text(
                                                'Admin',
                                                style: MyAppTextStyles.cardTitle
                                                    .copyWith(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(width: 20),
                                  ],
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  //DASHBOARD HEADER
  Widget _buildHeader() {
    bool isMobile = Responsive.isMobile(context);
    bool isTablet = Responsive.isTablet(context);

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsetsGeometry.only(left: 10, right: 15, top: 15, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isMobile
              ? IconButton(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  icon: Icon(Icons.menu),
                )
              : SizedBox(),
          SizedBox(width: 5),
          Text(
            'Dashboard',
            style: Responsive.isMobile(context)
                ? MyAppTextStyles.heading.copyWith(fontSize: 16)
                : MyAppTextStyles.heading.copyWith(fontSize: 18),
          ),
          isMobile ? SizedBox(width: 20) : SizedBox(width: 20),
          Expanded(
            flex: isTablet
                ? 3
                : isMobile
                ? 6
                : 2,
            child: Container(
              height: 30,

              decoration: BoxDecoration(
                color: Color(0xFFF3F6F6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  hintStyle: MyAppTextStyles.caption.copyWith(fontSize: 10),
                  suffixIcon: const Icon(Icons.search, size: 18),
                  border: InputBorder.none,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: -6,
                  ),
                ),
              ),
            ),
          ),
          Responsive.isDesktop(context) ? Spacer(flex: 2) : Spacer(flex: 1),

          //ACTION ICONS
          Row(
            children: [
              const Icon(
                Icons.notifications_none,
                color: Colors.grey,
                size: 15,
              ),
              const SizedBox(width: 15),
              const Icon(Icons.email_outlined, color: Colors.grey, size: 15),
              const SizedBox(width: 15),
              CircleAvatar(
                minRadius: 18,

                backgroundImage: AssetImage('assets/png/profile.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //GREETINGS
  Widget _buildGreetings() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //GREETINGS
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Welcome back, Bilal!',
                style: MyAppTextStyles.heading.copyWith(fontSize: 16),
              ),
              Text(
                "Here's what happening with your business today",
                style: MyAppTextStyles.caption.copyWith(fontSize: 8),
              ),
            ],
          ),
          SizedBox(height: 10),

          //ICON + REVENUE + GROWTH + FL CHART
        ],
      ),
    );
  }

  //STATE CARD
  Widget _buildStateCard({
    required IconData cIcon,
    required double iconSize,
    required Color containerColor,
    lineColor,
    required String title,
    required String subTitle,
    required String growthText,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,

            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsetsGeometry.all(5),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(cIcon, color: Colors.white, size: iconSize),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: MyAppTextStyles.cardTitle.copyWith(
                            fontSize: 6.5,
                          ),
                        ),

                        Icon(
                          Icons.more_vert,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),

                    Text(
                      subTitle,
                      style: MyAppTextStyles.caption.copyWith(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),

          //Growth DETAILS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: growthText,
                      style: MyAppTextStyles.growthLabel.copyWith(fontSize: 8),
                    ),

                    TextSpan(
                      text: '    vs last week',
                      style: MyAppTextStyles.growthLabel.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 45),
              //FL CHART DUMMY DATA
              SizedBox(
                width: 30,
                height: 20,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(show: false),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 0.1),
                          FlSpot(1, 1.2),
                          FlSpot(2, 1),
                          FlSpot(3, 2),
                          FlSpot(4, 1.9),
                          FlSpot(5, 1.5),
                          FlSpot(6, 2.5),
                          FlSpot(7, 3.0),
                          FlSpot(8, 5.0),
                        ],
                        isCurved: true,
                        color: lineColor,
                        barWidth: 1,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF4DA3FF).withValues(alpha: 0.35),
                              const Color(0xFF4DA3FF).withValues(alpha: 0.15),
                              const Color(0xFF4DA3FF).withValues(alpha: 0.0),
                            ],
                            stops: const [0.0, 0.5, 1.0], // smooth transition
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
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
    );
  }

  //TILE CARD
  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isSelectedTile,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: Responsive.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 12, vertical: 8)
            : EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: Responsive.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            : EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelectedTile ? AppColors.secondaryBlue : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelectedTile ? Colors.white : AppColors.sideBarSecondary,
              size: 14,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: isSelectedTile
                  ? MyAppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    )
                  : MyAppTextStyles.caption.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

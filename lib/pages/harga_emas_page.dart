import 'package:flutter/material.dart';

class HargaEmasPage extends StatefulWidget {
  const HargaEmasPage({super.key});

  @override
  State<HargaEmasPage> createState() => _HargaEmasPageState();
}

class _HargaEmasPageState extends State<HargaEmasPage> {
  // ============================================================
  // STATE
  // ============================================================

  int _selectedAsset = 0;
  int _selectedPeriod = 1;
  int _currentPage = 1;
  int _selectedChartPoint = 6;

  DateTime _startDate = DateTime(2024, 5, 18);
  DateTime _endDate = DateTime(2024, 5, 24);

  final List<String> _assets = [
    'LGD (Loco Gold)',
    'HSI',
    'SNI',
  ];

  final List<String> _periods = [
    'Hari Ini',
    '7 Hari',
    '30 Hari',
    'Kustom',
  ];

  // ============================================================
  // DATA CHART
  // ============================================================

  final List<GoldChartPoint> _chartData = [
    GoldChartPoint(
      date: '16 Mei 2024',
      shortDate: '16 Mei',
      price: 2342.10,
    ),
    GoldChartPoint(
      date: '17 Mei 2024',
      shortDate: '17 Mei',
      price: 2354.50,
    ),
    GoldChartPoint(
      date: '20 Mei 2024',
      shortDate: '20 Mei',
      price: 2348.90,
    ),
    GoldChartPoint(
      date: '21 Mei 2024',
      shortDate: '21 Mei',
      price: 2372.40,
    ),
    GoldChartPoint(
      date: '22 Mei 2024',
      shortDate: '22 Mei',
      price: 2366.10,
    ),
    GoldChartPoint(
      date: '23 Mei 2024',
      shortDate: '23 Mei',
      price: 2382.70,
    ),
    GoldChartPoint(
      date: '24 Mei 2024',
      shortDate: '24 Mei',
      price: 2391.80,
    ),
  ];

  // ============================================================
  // DATA OHLC
  // ============================================================

  final List<OhlcData> _ohlcData = [
    OhlcData(
      date: '24/05/2024',
      open: 2380.50,
      high: 2395.10,
      low: 2374.20,
      close: 2391.80,
      change: 0.47,
    ),
    OhlcData(
      date: '23/05/2024',
      open: 2368.20,
      high: 2385.00,
      low: 2362.40,
      close: 2382.70,
      change: 0.70,
    ),
    OhlcData(
      date: '22/05/2024',
      open: 2371.90,
      high: 2376.50,
      low: 2358.10,
      close: 2366.10,
      change: -0.27,
    ),
    OhlcData(
      date: '21/05/2024',
      open: 2350.00,
      high: 2375.20,
      low: 2347.80,
      close: 2372.40,
      change: 1.00,
    ),
    OhlcData(
      date: '20/05/2024',
      open: 2356.10,
      high: 2361.00,
      low: 2341.30,
      close: 2348.90,
      change: -0.24,
    ),
    OhlcData(
      date: '17/05/2024',
      open: 2340.80,
      high: 2359.70,
      low: 2335.20,
      close: 2354.50,
      change: 0.53,
    ),
    OhlcData(
      date: '16/05/2024',
      open: 2332.10,
      high: 2346.00,
      low: 2328.00,
      close: 2342.10,
      change: 0.43,
    ),
    OhlcData(
      date: '15/05/2024',
      open: 2345.00,
      high: 2349.80,
      low: 2326.50,
      close: 2332.00,
      change: -0.55,
    ),
    OhlcData(
      date: '14/05/2024',
      open: 2336.20,
      high: 2351.40,
      low: 2331.00,
      close: 2345.00,
      change: 0.38,
    ),
    OhlcData(
      date: '13/05/2024',
      open: 2352.00,
      high: 2355.00,
      low: 2330.10,
      close: 2336.20,
      change: -0.67,
    ),
  ];

  // ============================================================
  // FORMATTER
  // ============================================================

  String _formatPrice(double value) {
    return value.toStringAsFixed(2);
  }

  String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'Pilih tanggal mulai',
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime(2030),
      helpText: 'Pilih tanggal akhir',
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  void _applyFilter() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Filter diterapkan: ${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data sedang disiapkan untuk export...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageTitle(),
                    const SizedBox(height: 20),
                    _buildAssetTabs(),
                    const SizedBox(height: 18),
                    _buildSettlementCard(),
                    const SizedBox(height: 18),
                    _buildFilterCard(),
                    const SizedBox(height: 18),
                    _buildChartCard(),
                    const SizedBox(height: 18),
                    _buildOhlcCard(),
                    const SizedBox(height: 18),
                    _buildPagination(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
    ),
    child: Row(
      children: [
        // BACK TO DASHBOARD
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
          ),
          color: const Color(0xFF111827),
          tooltip: 'Kembali ke Dashboard',
        ),

        const SizedBox(width: 2),

        // LOGO
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.show_chart,
            color: Colors.white,
            size: 22,
          ),
        ),

        const SizedBox(width: 10),

        // TITLE
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EQUITY PULSE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: Color(0xFF111827),
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  SizedBox(
                    width: 7,
                    height: 7,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFF16A34A),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'MARKET OPEN',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF16A34A),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // NOTIFICATION
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF374151),
          ),
        ),

        // PROFILE
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFE5E7EB),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_outline,
            color: Color(0xFF374151),
            size: 20,
          ),
        ),
      ],
    ),
  );
}

  // ============================================================
  // PAGE TITLE
  // ============================================================

  Widget _buildPageTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Harga Emas',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
            height: 1.15,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Data Pasar & Kuotasi OHLC Terverifikasi',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: const Color(0xFFBBF7D0),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_outlined,
                    size: 13,
                    color: Color(0xFF15803D),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Source: News Maker',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF15803D),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // ASSET TABS
  // ============================================================

  Widget _buildAssetTabs() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(
          _assets.length,
          (index) {
            final isSelected = _selectedAsset == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAsset = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _assets[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF111827)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // LIVE SETTLEMENT CARD
  // ============================================================

  Widget _buildSettlementCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Live Settlement Ref',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'USD / t.oz',
                  style: TextStyle(
                    color: Color(0xFFD1D5DB),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '2,391.80',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF14532D),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '+11.30 (+0.47%)',
                  style: TextStyle(
                    color: Color(0xFF86EFAC),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Day Range',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '2,374.20',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF374151),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.78,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  '2,395.10',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILTER CARD
  // ============================================================

  Widget _buildFilterCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.tune_rounded,
                size: 19,
                color: Color(0xFF374151),
              ),
              const SizedBox(width: 8),
              const Text(
                'Filter Parameter',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: Color(0xFF16A34A),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Real-time Feed',
                      style: TextStyle(
                        color: Color(0xFF15803D),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // PERIOD
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _periods.length,
                (index) {
                  final selected = _selectedPeriod == index;

                  return Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPeriod = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF111827)
                              : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _periods[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: selected
                                ? Colors.white
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 14),

          // DATE
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  label: 'Tanggal Mulai',
                  value: _formatDate(_startDate),
                  onTap: _pickStartDate,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDateField(
                  label: 'Tanggal Akhir',
                  value: _formatDate(_endDate),
                  onTap: _pickEndDate,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _applyFilter,
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: 17,
                  ),
                  label: const Text('Terapkan Filter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111827),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              OutlinedButton.icon(
                onPressed: _exportData,
                icon: const Icon(
                  Icons.download_outlined,
                  size: 17,
                ),
                label: const Text('Export'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF374151),
                  side: const BorderSide(
                    color: Color(0xFFD1D5DB),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 15,
              color: Color(0xFF6B7280),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF374151),
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

  // ============================================================
  // CHART CARD
  // ============================================================

  Widget _buildChartCard() {
    final selectedPoint = _chartData[_selectedChartPoint];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tren Harga Penutupan (Close)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pergerakan historis 7 hari kerja terakhir',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 14,
                      color: Color(0xFF16A34A),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Bullish',
                      style: TextStyle(
                        color: Color(0xFF15803D),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // TOOLTIP
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedPoint.date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '\$${_formatPrice(selectedPoint.price)}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 235,
            width: double.infinity,
            child: GestureDetector(
              onTapDown: (details) {
                final box =
                    context.findRenderObject() as RenderBox?;
                if (box == null) return;

                final localPosition =
                    details.localPosition;

                final width =
                    MediaQuery.of(context).size.width - 74;

                final chartLeft = 40.0;
                final chartRight = width - 10;
                final usableWidth =
                    chartRight - chartLeft;

                final ratio = ((localPosition.dx - chartLeft) /
                        usableWidth)
                    .clamp(0.0, 1.0);

                final index =
                    (ratio * (_chartData.length - 1))
                        .round()
                        .clamp(0, _chartData.length - 1);

                setState(() {
                  _selectedChartPoint = index;
                });
              },
              child: CustomPaint(
                painter: GoldChartPainter(
                  data: _chartData,
                  selectedIndex: _selectedChartPoint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OHLC TABLE
  // ============================================================

  Widget _buildOhlcCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              17,
              17,
              17,
              14,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buku Kuotasi Pasar OHLC',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Data Open, High, Low & Close',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '10 Entri Terakhir',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFFE5E7EB),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 22,
              headingRowHeight: 42,
              dataRowMinHeight: 46,
              dataRowMaxHeight: 52,
              headingTextStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF6B7280),
              ),
              dataTextStyle: const TextStyle(
                fontSize: 10,
                color: Color(0xFF374151),
              ),
              columns: const [
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Open')),
                DataColumn(label: Text('High')),
                DataColumn(label: Text('Low')),
                DataColumn(label: Text('Close')),
                DataColumn(label: Text('Arah')),
              ],
              rows: _ohlcData.map((item) {
                final positive = item.change >= 0;

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        item.date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(_formatPrice(item.open)),
                    ),
                    DataCell(
                      Text(_formatPrice(item.high)),
                    ),
                    DataCell(
                      Text(_formatPrice(item.low)),
                    ),
                    DataCell(
                      Text(
                        _formatPrice(item.close),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: positive
                              ? const Color(0xFFECFDF5)
                              : const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${positive ? '+' : ''}${item.change.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: positive
                                ? const Color(0xFF15803D)
                                : const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGINATION
  // ============================================================

  Widget _buildPagination() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Baris per halaman:',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '10',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Menampilkan ${((_currentPage - 1) * 10) + 1}-'
                '${_currentPage * 10} dari 120 data',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _paginationButton(
                icon: Icons.first_page,
                enabled: _currentPage > 1,
                onTap: () {
                  if (_currentPage > 1) {
                    setState(() {
                      _currentPage = 1;
                    });
                  }
                },
              ),
              const SizedBox(width: 4),
              _paginationButton(
                icon: Icons.chevron_left,
                enabled: _currentPage > 1,
                onTap: () {
                  if (_currentPage > 1) {
                    setState(() {
                      _currentPage--;
                    });
                  }
                },
              ),
              const SizedBox(width: 6),
              ...List.generate(
                5,
                (index) {
                  final page = index + 1;

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _currentPage == page
                              ? const Color(0xFF111827)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          '$page',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: _currentPage == page
                                ? Colors.white
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 3),
              const Text(
                '...',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 3),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentPage = 12;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    '12',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _currentPage == 12
                          ? const Color(0xFF111827)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              _paginationButton(
                icon: Icons.chevron_right,
                enabled: _currentPage < 12,
                onTap: () {
                  if (_currentPage < 12) {
                    setState(() {
                      _currentPage++;
                    });
                  }
                },
              ),
              const SizedBox(width: 4),
              _paginationButton(
                icon: Icons.last_page,
                enabled: _currentPage < 12,
                onTap: () {
                  if (_currentPage < 12) {
                    setState(() {
                      _currentPage = 12;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paginationButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled
              ? const Color(0xFFF3F4F6)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          size: 17,
          color: enabled
              ? const Color(0xFF374151)
              : const Color(0xFFD1D5DB),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    final items = [
      _BottomNavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: 'Dashboard',
      ),
      _BottomNavItem(
        icon: Icons.newspaper_outlined,
        activeIcon: Icons.newspaper,
        label: 'Berita',
      ),
      _BottomNavItem(
        icon: Icons.show_chart,
        activeIcon: Icons.show_chart,
        label: 'Harga',
      ),
      _BottomNavItem(
        icon: Icons.table_chart_outlined,
        activeIcon: Icons.table_chart,
        label: 'Pivot',
      ),
      _BottomNavItem(
        icon: Icons.calculate_outlined,
        activeIcon: Icons.calculate,
        label: 'Kalkulator',
      ),
      _BottomNavItem(
        icon: Icons.history_outlined,
        activeIcon: Icons.history,
        label: 'Histori',
      ),
      _BottomNavItem(
        icon: Icons.apartment_outlined,
        activeIcon: Icons.apartment,
        label: 'Profil PT',
      ),
    ];

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              items.length,
              (index) {
                final active = index == 2;

                return SizedBox(
                  width: 82,
                  child: InkWell(
                    onTap: () {
                      // Navigasi akan dihubungkan setelah
                      // seluruh halaman Flutter selesai.
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          active
                              ? items[index].activeIcon
                              : items[index].icon,
                          size: 21,
                          color: active
                              ? const Color(0xFF111827)
                              : const Color(0xFF9CA3AF),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[index].label,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: active
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: active
                                ? const Color(0xFF111827)
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// MODEL CHART
// ================================================================

class GoldChartPoint {
  final String date;
  final String shortDate;
  final double price;

  const GoldChartPoint({
    required this.date,
    required this.shortDate,
    required this.price,
  });
}

// ================================================================
// MODEL OHLC
// ================================================================

class OhlcData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double change;

  const OhlcData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.change,
  });
}

// ================================================================
// MODEL BOTTOM NAV
// ================================================================

class _BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// ================================================================
// CUSTOM CHART PAINTER
// ================================================================

class GoldChartPainter extends CustomPainter {
  final List<GoldChartPoint> data;
  final int selectedIndex;

  GoldChartPainter({
    required this.data,
    required this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    const leftPadding = 42.0;
    const rightPadding = 12.0;
    const topPadding = 18.0;
    const bottomPadding = 32.0;

    final chartWidth =
        size.width - leftPadding - rightPadding;

    final chartHeight =
        size.height - topPadding - bottomPadding;

    final prices = data.map((e) => e.price).toList();

    final minPrice =
        prices.reduce((a, b) => a < b ? a : b) - 8;

    final maxPrice =
        prices.reduce((a, b) => a > b ? a : b) + 8;

    // ------------------------------------------------------------
    // GRID
    // ------------------------------------------------------------

    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    const gridCount = 4;

    for (int i = 0; i <= gridCount; i++) {
      final y = topPadding +
          (chartHeight / gridCount) * i;

      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );

      final value =
          maxPrice -
          ((maxPrice - minPrice) / gridCount) * i;

      final textPainter = TextPainter(
        text: TextSpan(
          text: value.toStringAsFixed(0),
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF9CA3AF),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          0,
          y - textPainter.height / 2,
        ),
      );
    }

    // ------------------------------------------------------------
    // POINTS
    // ------------------------------------------------------------

    final points = <Offset>[];

    for (int i = 0; i < data.length; i++) {
      final x = leftPadding +
          (chartWidth / (data.length - 1)) * i;

      final normalized =
          (data[i].price - minPrice) /
          (maxPrice - minPrice);

      final y =
          topPadding +
          chartHeight -
          normalized * chartHeight;

      points.add(Offset(x, y));
    }

    // ------------------------------------------------------------
    // AREA
    // ------------------------------------------------------------

    final areaPath = Path();

    areaPath.moveTo(
      points.first.dx,
      size.height - bottomPadding,
    );

    for (final point in points) {
      areaPath.lineTo(point.dx, point.dy);
    }

    areaPath.lineTo(
      points.last.dx,
      size.height - bottomPadding,
    );

    areaPath.close();

    final areaPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x3322C55E),
          Color(0x0022C55E),
        ],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );

    canvas.drawPath(areaPath, areaPaint);

    // ------------------------------------------------------------
    // LINE
    // ------------------------------------------------------------

    final linePath = Path();

    linePath.moveTo(
      points.first.dx,
      points.first.dy,
    );

    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    final linePaint = Paint()
      ..color = const Color(0xFF16A34A)
      ..strokeWidth = 2.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, linePaint);

    // ------------------------------------------------------------
    // X AXIS LABEL
    // ------------------------------------------------------------

    for (int i = 0; i < data.length; i++) {
      if (i % 2 != 0 && i != data.length - 1) {
        continue;
      }

      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i].shortDate,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF9CA3AF),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      double x =
          points[i].dx - textPainter.width / 2;

      if (x < leftPadding) {
        x = leftPadding;
      }

      if (x + textPainter.width >
          size.width - rightPadding) {
        x = size.width -
            rightPadding -
            textPainter.width;
      }

      textPainter.paint(
        canvas,
        Offset(
          x,
          size.height - bottomPadding + 10,
        ),
      );
    }

    // ------------------------------------------------------------
    // SELECTED POINT
    // ------------------------------------------------------------

    final selected =
        points[selectedIndex.clamp(0, points.length - 1)];

    final verticalPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(
        selected.dx,
        topPadding,
      ),
      Offset(
        selected.dx,
        size.height - bottomPadding,
      ),
      verticalPaint,
    );

    final outerCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final selectedCircle = Paint()
      ..color = const Color(0xFF16A34A)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      selected,
      6,
      outerCircle,
    );

    canvas.drawCircle(
      selected,
      4,
      selectedCircle,
    );
  }

  @override
  bool shouldRepaint(covariant GoldChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.data != data;
  }
}
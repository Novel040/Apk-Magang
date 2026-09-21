import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoriPage extends StatefulWidget {
  const HistoriPage({super.key});

  @override
  State<HistoriPage> createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  int selectedCommodity = 2;
  int selectedDateFilter = 0;
  int currentPage = 1;

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> historyData = [
    {
      'date': '24/05/2025',
      'open': '1.488.000',
      'high': '1.498.500',
      'low': '1.484.000',
      'close': '1.496.000',
      'change': '+8.000',
      'percent': '(+0.54%)',
      'up': true,
    },
    {
      'date': '23/05/2025',
      'open': '1.492.000',
      'high': '1.495.000',
      'low': '1.485.000',
      'close': '1.488.000',
      'change': '-4.000',
      'percent': '(-0.27%)',
      'up': false,
    },
    {
      'date': '22/05/2025',
      'open': '1.479.000',
      'high': '1.494.000',
      'low': '1.476.500',
      'close': '1.492.000',
      'change': '+13.000',
      'percent': '(+0.88%)',
      'up': true,
    },
    {
      'date': '21/05/2025',
      'open': '1.482.000',
      'high': '1.486.000',
      'low': '1.475.000',
      'close': '1.479.000',
      'change': '-3.000',
      'percent': '(-0.20%)',
      'up': false,
    },
    {
      'date': '20/05/2025',
      'open': '1.470.000',
      'high': '1.484.500',
      'low': '1.468.000',
      'close': '1.482.000',
      'change': '+12.000',
      'percent': '(+0.82%)',
      'up': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredData {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return historyData;
    }

    return historyData.where((item) {
      return item['date'].toString().toLowerCase().contains(query) ||
          item['open'].toString().toLowerCase().contains(query) ||
          item['high'].toString().toLowerCase().contains(query) ||
          item['low'].toString().toLowerCase().contains(query) ||
          item['close'].toString().toLowerCase().contains(query);
    }).toList();
  }

  void resetFilter() {
    setState(() {
      selectedDateFilter = 0;
      selectedCommodity = 2;
      currentPage = 1;
      searchController.clear();
    });
  }

  void showExportMessage(String type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF6FFBBE),
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Berkas $type berhasil disiapkan untuk diunduh.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    const SizedBox(height: 12),
                    _buildCommodityTabs(),
                    const SizedBox(height: 12),
                    _buildSniNotice(),
                    const SizedBox(height: 12),
                    _buildFilterCard(),
                    const SizedBox(height: 12),
                    _buildHistoryTable(),
                    const SizedBox(height: 12),
                    _buildIntegrityCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF111827),
            ),
            tooltip: 'Kembali',
          ),
          const SizedBox(width: 2),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF785600),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.show_chart,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'EQUITY PULSE',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x1A006947),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF006947),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Market Open',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF006947),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'PT EQUITYWORLD FUTURES',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF785600),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              size: 22,
              color: Color(0xFF4F4535),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EEFF),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x33785600),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 18,
              color: Color(0xFF785600),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitleSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDEA6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.archive_outlined,
                      size: 14,
                      color: Color(0xFF271900),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'INSTITUTIONAL ARCHIVE',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF271900),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.verified,
                    size: 15,
                    color: Color(0xFF006947),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Source: ',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      color: const Color(0xFF4F4535),
                    ),
                  ),
                  Text(
                    'News Maker',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Histori Data Harga Emas',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1C30),
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Arsip catatan historis transaksi dan penutupan harga emas harian resmi EWF Gold Hub.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              height: 1.4,
              color: const Color(0xFF4F4535),
            ),
          ),
          const SizedBox(height: 10),
          _buildAverageBanner(),
        ],
      ),
    );
  }

  Widget _buildAverageBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RATA-RATA PENUTUPAN 30H (SNI)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: const Color(0xFF4F4535),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rp 1.482.500',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '+1.84%',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF006947),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 90,
            height: 32,
            child: CustomPaint(
              painter: _SparklinePainter(),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMODITY TABS
  // ============================================================

  Widget _buildCommodityTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _commodityTab('LGD', 0),
          _commodityTab('HSI', 1),
          _commodityTab('SNI', 2),
        ],
      ),
    );
  }

  Widget _commodityTab(String title, int index) {
    final selected = selectedCommodity == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCommodity = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: selected
                ? const [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected) ...[
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF785600),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? const Color(0xFF785600)
                      : const Color(0xFF4F4535),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SNI NOTICE
  // ============================================================

  Widget _buildSniNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.policy_outlined,
            size: 20,
            color: Color(0xFF785600),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'PROTOKOL REKONSILIASI SNI',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xFF785600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Baku Murni',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4F4535),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Katalog historis SNI disajikan secara mutlak berbasis audit OHLC tanpa kalkulasi derivatif Pivot Point, Signal BUY/SELL, Rentang Volatilitas, R1-R4, S1-S4, maupun NEST.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    height: 1.35,
                    color: const Color(0xFF4F4535),
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
  // FILTER
  // ============================================================

  Widget _buildFilterCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.tune,
                size: 18,
                color: Color(0xFF785600),
              ),
              const SizedBox(width: 7),
              Text(
                'Parameter Filter',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: resetFilter,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Reset Filter',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF785600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildDateFilters(),
          const SizedBox(height: 12),
          _buildFilterInputs(),
          const SizedBox(height: 12),
          _buildExportSection(),
        ],
      ),
    );
  }

  Widget _buildDateFilters() {
    final filters = [
      'Bulan Ini',
      '3 Bulan Terakhir',
      '1 Tahun',
      'Kustom',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final selected = selectedDateFilter == index;

          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedDateFilter = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF785600)
                      : const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    if (index == 3) ...[
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 14,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF4F4535),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      filters[index],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF4F4535),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFilterInputs() {
    return Column(
      children: [
        _buildProductDropdown(),
        const SizedBox(height: 10),
        _buildSearchInput(),
      ],
    );
  }

  Widget _buildProductDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRODUK KOMODITAS',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.7,
            color: const Color(0xFF4F4535),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCommodity == 2
                  ? 'SNI 99.99% Emas Murni Fisik'
                  : selectedCommodity == 1
                      ? 'HSI Gold'
                      : 'LGD Gold',
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF4F4535),
              ),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF0B1C30),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'LGD Gold',
                  child: Text('LGD Gold'),
                ),
                DropdownMenuItem(
                  value: 'HSI Gold',
                  child: Text('HSI Gold'),
                ),
                DropdownMenuItem(
                  value: 'SNI 99.99% Emas Murni Fisik',
                  child: Text('SNI 99.99% Emas Murni Fisik'),
                ),
              ],
              onChanged: (value) {
                if (value == 'LGD Gold') {
                  setState(() => selectedCommodity = 0);
                } else if (value == 'HSI Gold') {
                  setState(() => selectedCommodity = 1);
                } else {
                  setState(() => selectedCommodity = 2);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PENCARIAN CEPAT',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.7,
            color: const Color(0xFF4F4535),
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: searchController,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: const Color(0xFF0B1C30),
          ),
          decoration: InputDecoration(
            hintText: 'Cari tanggal (DD/MM/YYYY)...',
            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: const Color(0xFF4F4535),
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 18,
              color: Color(0xFF4F4535),
            ),
            filled: true,
            fillColor: const Color(0xFFEFF4FF),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF785600),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EXPORT
  // ============================================================

  Widget _buildExportSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.download_outlined,
                size: 18,
                color: Color(0xFF4F4535),
              ),
              const SizedBox(width: 6),
              Text(
                'Ekspor Dokumen:',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _exportButton(
                'CSV',
                Icons.table_view_outlined,
              ),
              _exportButton(
                'XLSX',
                Icons.description_outlined,
              ),
              _exportButton(
                'PDF',
                Icons.picture_as_pdf_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _exportButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () => showExportMessage(title),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: const Color(0xFF0B1C30),
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HISTORY TABLE
  // ============================================================

  Widget _buildHistoryTable() {
    final data = filteredData;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildTableHeader(),
          if (data.isNotEmpty)
            _buildScrollableTable(data)
          else
            _buildEmptyState(),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF785600),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Buku Catatan OHLC Emas',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFDCE9FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'ISO 8601',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4F4535),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableTable(List<Map<String, dynamic>> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 650,
        child: Column(
          children: [
            _buildTableColumnHeader(),
            ...List.generate(
              data.length,
              (index) => _buildHistoryRow(
                data[index],
                index,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableColumnHeader() {
    return Container(
      color: const Color(0xFFE5EEFF),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Row(
        children: [
          _tableHeaderCell('Tanggal', 145, alignLeft: true),
          _tableHeaderCell('Open (IDR)', 95),
          _tableHeaderCell('High (IDR)', 95),
          _tableHeaderCell('Low (IDR)', 95),
          _tableHeaderCell('Close (IDR)', 95),
          _tableHeaderCell('Perubahan', 110),
        ],
      ),
    );
  }

  Widget _tableHeaderCell(
    String title,
    double width, {
    bool alignLeft = false,
  }) {
    return SizedBox(
      width: width,
      child: Text(
        title.toUpperCase(),
        textAlign: alignLeft ? TextAlign.left : TextAlign.right,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF4F4535),
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _buildHistoryRow(
    Map<String, dynamic> item,
    int index,
  ) {
    final isUp = item['up'] as bool;

    return Container(
      color: index.isOdd
          ? const Color(0xFFF8F9FF)
          : Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 145,
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: Color(0xFF4F4535),
                ),
                const SizedBox(width: 6),
                Text(
                  item['date'],
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),
          _tableValue(item['open'], 95),
          _tableValue(item['high'], 95, bold: true),
          _tableValue(
            item['low'],
            95,
            color: const Color(0xFF4F4535),
          ),
          _tableValue(item['close'], 95, bold: true),
          SizedBox(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      isUp
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      size: 15,
                      color: isUp
                          ? const Color(0xFF006947)
                          : const Color(0xFFBA1A1A),
                    ),
                    Text(
                      item['change'],
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isUp
                            ? const Color(0xFF006947)
                            : const Color(0xFFBA1A1A),
                      ),
                    ),
                  ],
                ),
                Text(
                  item['percent'],
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isUp
                        ? const Color(0xFF006947)
                        : const Color(0xFFBA1A1A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableValue(
    String value,
    double width, {
    bool bold = false,
    Color color = const Color(0xFF0B1C30),
  }) {
    return SizedBox(
      width: width,
      child: Text(
        value,
        textAlign: TextAlign.right,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFDCE9FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off,
              size: 24,
              color: Color(0xFF4F4535),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Catatan Tidak Ditemukan',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tidak ada arsip harga untuk parameter tanggal yang dimasukkan.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: const Color(0xFF4F4535),
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
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFEFF4FF),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Total Data:',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: const Color(0xFF4F4535),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '248 Catatan',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '• Terverifikasi',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: const Color(0xFF4F4535),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Navigasi halaman ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: const Color(0xFF4F4535),
                ),
              ),
              Text(
                '$currentPage',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Text(
                ' dari ',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: const Color(0xFF4F4535),
                ),
              ),
              Text(
                '25',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              const SizedBox(width: 10),
              _pageButton(
                Icons.chevron_left,
                enabled: currentPage > 1,
                onTap: () {
                  if (currentPage > 1) {
                    setState(() {
                      currentPage--;
                    });
                  }
                },
              ),
              const SizedBox(width: 4),
              _numberPageButton(1),
              const SizedBox(width: 4),
              _numberPageButton(2),
              const SizedBox(width: 4),
              _pageButton(
                Icons.chevron_right,
                enabled: currentPage < 25,
                onTap: () {
                  if (currentPage < 25) {
                    setState(() {
                      currentPage++;
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

  Widget _pageButton(
    IconData icon, {
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? const Color(0xFF4F4535)
              : const Color(0x664F4535),
        ),
      ),
    );
  }

  Widget _numberPageButton(int page) {
    final selected = currentPage == page;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = page;
        });
      },
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF785600)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '$page',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: selected
                ? Colors.white
                : const Color(0xFF0B1C30),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INTEGRITY CARD
  // ============================================================

  Widget _buildIntegrityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDEA6),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 22,
              color: Color(0xFF785600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Integritas Arsip Transaksi',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Seluruh data disinkronkan secara otomatis pada pukul 17:30 WIB setiap hari bursa.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    height: 1.35,
                    color: const Color(0xFF4F4535),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF006947),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'Tersertifikasi',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF006947),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// SPARKLINE PAINTER
// ================================================================

class _SparklinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF006947)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0x14006947)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height * 0.75);

    path.cubicTo(
      size.width * 0.20,
      size.height * 0.88,
      size.width * 0.30,
      size.height * 0.55,
      size.width * 0.38,
      size.height * 0.55,
    );

    path.cubicTo(
      size.width * 0.52,
      size.height * 0.55,
      size.width * 0.62,
      size.height * 0.44,
      size.width * 0.68,
      size.height * 0.44,
    );

    path.cubicTo(
      size.width * 0.80,
      size.height * 0.44,
      size.width * 0.88,
      size.height * 0.25,
      size.width,
      size.height * 0.12,
    );

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
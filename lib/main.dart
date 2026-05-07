import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF534AB7)),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

// ── Model data workshop ──────────────────────────────────────────────────────

class Workshop {
  final String judul;
  final String tanggal;
  final String lokasi;
  final int kuotaTersedia;
  final int kuotaTotal;

  const Workshop({
    required this.judul,
    required this.tanggal,
    required this.lokasi,
    required this.kuotaTersedia,
    required this.kuotaTotal,
  });
}

// ── Halaman utama ────────────────────────────────────────────────────────────

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  // Data contoh workshop
  static const List<Workshop> daftarWorkshop = [
    Workshop(
      judul: 'Seminar UI/UX Design 2026',
      tanggal: 'Senin, 12 Mei 2026',
      lokasi: 'Aula Gedung A, Lt. 3',
      kuotaTersedia: 28,
      kuotaTotal: 50,
    ),
    Workshop(
      judul: 'Workshop Flutter & Dart',
      tanggal: 'Rabu, 14 Mei 2026',
      lokasi: 'Lab Komputer 2',
      kuotaTersedia: 3,
      kuotaTotal: 30,
    ),
    Workshop(
      judul: 'Pelatihan Machine Learning Dasar',
      tanggal: 'Jumat, 16 Mei 2026',
      lokasi: 'Ruang Seminar B',
      kuotaTersedia: 15,
      kuotaTotal: 40,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Widget 1: AppBar — header halaman
      appBar: AppBar(
        backgroundColor: const Color(0xFF534AB7),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workshop Kampus',
              style: TextStyle(
                color: Color(0xFFEEEDFE),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Daftar kegiatan tersedia',
              style: TextStyle(
                color: Color(0xFFAFA9EC),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),

      // Widget 2: ListView — daftar kartu yang bisa di-scroll
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarWorkshop.length,
        itemBuilder: (context, index) {
          return KartuWorkshop(workshop: daftarWorkshop[index]);
        },
      ),
    );
  }
}

// ── Widget kartu workshop ────────────────────────────────────────────────────

class KartuWorkshop extends StatelessWidget {
  final Workshop workshop;

  const KartuWorkshop({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    final bool hampirPenuh = workshop.kuotaTersedia <= 5;

    // Widget 3: Card — container kartu dengan shadow dan sudut membulat
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),

        // Column — menyusun elemen secara vertikal di dalam kartu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul workshop
            Text(
              workshop.judul,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF26215C),
              ),
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),

            // Baris tanggal
            _BariInfo(
              icon: Icons.calendar_today_outlined,
              teks: workshop.tanggal,
            ),
            const SizedBox(height: 6),

            // Baris lokasi
            _BariInfo(
              icon: Icons.location_on_outlined,
              teks: workshop.lokasi,
            ),
            const SizedBox(height: 6),

            // Baris kuota dengan badge warna
            Row(
              children: [
                Icon(
                  Icons.people_outline,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: hampirPenuh
                        ? const Color(0xFFFAEEDA)
                        : const Color(0xFFEAF3DE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        hampirPenuh
                            ? Icons.warning_amber_outlined
                            : Icons.check_circle_outline,
                        size: 13,
                        color: hampirPenuh
                            ? const Color(0xFF633806)
                            : const Color(0xFF3B6D11),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${workshop.kuotaTersedia} / ${workshop.kuotaTotal} kursi tersedia',
                        style: TextStyle(
                          fontSize: 12,
                          color: hampirPenuh
                              ? const Color(0xFF633806)
                              : const Color(0xFF3B6D11),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Widget 4: ElevatedButton — tombol daftar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Tampilkan snackbar konfirmasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Berhasil mendaftar: ${workshop.judul}',
                      ),
                      backgroundColor: const Color(0xFF534AB7),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF534AB7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Daftar Sekarang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget helper baris info (ikon + teks) ───────────────────────────────────

class _BariInfo extends StatelessWidget {
  final IconData icon;
  final String teks;

  const _BariInfo({required this.icon, required this.teks});

  @override
  Widget build(BuildContext context) {
    // Row — menyusun ikon dan teks secara horizontal
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Text(
          teks,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
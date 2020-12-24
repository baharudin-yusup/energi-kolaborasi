import 'category_model.dart';

class ArticleModel {
  final int id;
  final String title;
  final String category;
  final String department;
  final String author;
  final String description;
  final String bannerUrl;
  final DateTime publishTime;
  final String content;

  ArticleModel(this.id,
      {this.title,
      this.category,
      this.department,
      this.author,
      this.description,
      this.bannerUrl,
      this.publishTime,
      this.content});
}

List<ArticleModel> energyArticles = [
  ArticleModel(0,
      title:
          'Siapkan Milenial Terjun di Industri Energi, PPSDM KEBTKE Gelar Kuliah Kapita Selekta',
      category: CategoryModel.MINERAL,
      department:
          'Kepala Biro Komunikasi, Layanan Informasi Publik dan Kerja Sama',
      author: 'Agung Pribadi (08112213555)',
      description:
          'Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.',
      bannerUrl: 'assets/article/1.jpg',
      publishTime: DateTime(2020, 11, 7),
      content: '''
          Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.
          
          Salah satu langkah yang ditempuh adalah melalui kuliah kapita selekta. Kuliah kali ini dikhususkan bagi mahasiswa/mahasiswi Departemen Teknik Kimia, Fakultas Teknik Universitas Indonesia secara daring dengan menghadirkan Kepala PPSDM KEBTKE Kementerian ESDM Laode Sulaeman sebagai pembicara.

          "Kegiatan ini bertujuan untuk mempersiapkan calon sarjana baru menghadapi dunia pekerjaan atau bisnis dengan kompetensi yang lebih memenuhi kebutuhan dunia usaha, industri, dan penelitian," kata Loade pada Kamis (26/11).

          Lebih lanjut, Loade membeberkan isu-isu global dan peluang kerja bidang energi, tantangan ketenagakerjaan nasional hingga penguatan SDM dari sisi Human Personality Development dalam merespon tantangan global berbasis kelembagaan.

          Secara khusus Laode menyoroti penyerapan pemanfaatan Energi Baru Terbarukan (EBT). Tercatat pada tahun 2019 realisasi bauran energi primer EBT dalam energi mix nasional sebesar 9,15%. Sementara untuk kapasitas pembangkit EBT 10,3GW atau 12,4% dari kapasitas total pembangkit pada tahun 2019 sejumlah 69,1GW.

          Sementara untuk daya saing tenaga kerja Indonesia, berdasarkan penelitian Institute for Management Development (IMD) menunjukkan, peringkat Indonesia masih tertinggal dibandingkan sejumlah negara ASEAN seperti Thailand, Malaysia, dan Singapura. Secara global, Indonesia berada di peringkat 47 dari 63 negara. "Rendahnya pendidikan pekerja serta ketidaksesuaian (mismatch) antara pendidikan dengan pekerjaan," kata Laode.

          Saat ini, Pemerintah terus memperkuat SDM di sektor energi melalui pelatihan vokasi, pemagangan berbasis kompetensi di industri, maupun oleh Lembaga penerbit sertifikasi kompetensi. "Kemitraan yang kuat antara institusi pendidikan, Lembaga sertifikasi dan industri adalah syarat mutlak terwujudnya SDM unggul melalui penguatan ini," jelas Laode.

          Ia mempertegas, selain keterampilan/skill keteknikan, softskill termasuk customer awareness, problem solving, team worker, self management, dan communication and literasi adalah kunci utama memasuki dunia kerja bidang energi.

          Melalui "Good Governance and Clean Government", berbagai upaya peningkatan layanan dilaksanakan di semua lini oleh PPSDM KEBTKE. (SA/NA)


          '''),
  ArticleModel(1,
      title:
          'Siapkan Milenial Terjun di Industri Energi, PPSDM KEBTKE Gelar Kuliah Kapita Selekta',
      category: CategoryModel.MINERAL,
      department:
          'Kepala Biro Komunikasi, Layanan Informasi Publik dan Kerja Sama',
      author: 'Agung Pribadi (08112213555)',
      description:
          'Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.',
      bannerUrl: 'assets/article/2.jpg',
      publishTime: DateTime(2020, 12, 7),
      content: '''
          Penyediaan tenaga listrik nasional dalam RUPTL 2019-2028 menyiratkan bahwa total kapasitas tambahan pembangkit listrik yang akan dibangun hingga Tahun 2028 adalah sekitar 56,39 GigaWatt, dengan penambahan pembangkit energi baru dan terbarukan (EBT) sebesar 16,7 GigaWatt, terdiri dari penyediaan energi dari tenaga air (57%) dan energi panas bumi (27%) dan sisanya dipenuhi oleh varian pembangkit EBT lainnya.

          Kepala Badan Pengembangan Sumber Daya Manusia, Energi dan Sumber Daya Mineral Prahoro Yulijanto Nurtjahyo saat membuka Kelas Keuangan Berkelanjutan dengan tema "Transisi Energi dan Investasi Energi Terbarukan, Jumat (4/12), mengungkapkan bahwa salah satu kendala yang dihadapi subsector EBT adalah terhambatnya akses pendanaan untuk proyek EBT yang disebabkan oleh asumsi bahwa subsektor EBT masih berisiko tinggi dalam investasinya.

          "Masih tingginya biaya pembiayaan, terbatasnya ruang LJK dalam memberikan tenor yang panjang, penghindaran risiko, kerangka kebijakan yang belum efisien serta keterbatasan pemahaman para LJK, dan hambatan ini tersebar di seluruh fase proyek energi terbarukan," ungkap Prahoro kepada para peserta kelas virtual kerjasama antara BPSDM ESDM Kementerian ESDM, Inisiatif Keuangan Berkelanjutan Indonesia (IKBI), PT Bank HSBC Indonesia, dan WWF Indonesia tersebut.

          Oleh karena itu, Prahoro berharap, untuk di tahap awal dalam mendukung pembiayaan subsektor EBT, LJK perlu mempunyai pemahaman yang lebih baik secara menyeluruh agar memungkinkan LJK untuk berinovasi dalam mengembangan produk dan fasilitas keuangan dengan keterbatasan yang ada.

          Prahoro memaparkan, dalam perjalanan mencapai target Kebijakan Energi Nasional yang menetapkan bahwa pada tahun 2025 setidaknya 23% porsi bauran energi nasional berasal dari implementasi EBT, pada semester pertama tahun 2020, capaian porsi pembangkit listrik EBT di Indonesia telah mencapai 10.427 MegaWatt atau 14,69% dari total kapasitas terpasang pembangkit nasional sebesar 71 GigaWatt.

          Lebih lanjut Prahoro menyebut, dalam perencanaan ketenagalistrikan nasional ada beberapa prioritas yang telah ditetapkan yakni Pembangkit Listrik Tenaga Uap (PLTU) berbahan bakar batu bara masih akan dikembangkan dalam 5 tahun ke depan dan kemudian secara bertahap akan berkurang. Di samping itu, Pembangkit Listrik Tenaga Gas (PLTG) akan dikembangkan relatif konstan setelah tahun 2019. Selanjutnya, Pembangkit listrik energi terbarukan akan dikembangkan relatif konstan hingga Tahun 2024 dan kemudian akan meningkat secara signifikan pada Tahun 2025.

          Kelas yang diselenggarakan BPSDM ESDM ini terbuka untuk seluruh level staf dan divisi pada Lembaga Jasa Keuangan maupun Regulator terkait untuk memberikan pemahaman dalam subsektor energi terbarukan, baik itu terkait dengan kebijakan dan regulasi, proses bisnis energi terbarukan, aspek keberlanjutan, yang pada akhirnya dapat mengubah mindset pesimis menjadi optimis dalam meningkatkan investasi dan pembiayaan pengembangan energi terbarukan.

          "Para peserta untuk memanfaatkan waktu belajar dan ruang jejaring ini sebaik-baiknya agar memberikan manfaat yang optimal terhadap tujuan utama diselenggarakannya kelas ini. Manfaatkan ilmu yang didapatkan untuk mendukung transisi energi dan peningkatan investasi energi terbarukan di Indonesia. Peran serta dan kontribusi Anda diiringi kerjasama di antara pemangku kepentingan untuk mewujudkan target bauran energi terbarukan di tahun 2025", tutup Prahoro. (KO)

          '''),
  ArticleModel(
    2,
    title:
        'Project Arrangement Pengembangan Energi Terbarukan dengan Swiss Ditandatangani',
    category: CategoryModel.ENERGY,
    department:
        'Kepala Biro Komunikasi, Layanan Informasi Publik dan Kerja Sama',
    author: 'Agung Pribadi (08112213555)',
    description:
        'Project Arrangement (PA) antara Badan Pengembangan Sumber Daya Manusia Kementerian Energi dan Sumber Daya Mineral (BPSDM ESDM) dengan The State Secretariat for Economic Affairs of the Swiss Confederation diwakili Kurt Kunz, Duta Besar Swiss untuk Indonesia, Timor Leste, dan ASEAN ditandatangani pada Rabu (2/12) dengan lingkup pengembangan Energi Terbarukan.',
    bannerUrl: 'assets/article/3.jpg',
    publishTime: DateTime(2020, 12, 2),
    content: '''
      Project Arrangement (PA) antara Badan Pengembangan Sumber Daya Manusia Kementerian Energi dan Sumber Daya Mineral (BPSDM ESDM) dengan The State Secretariat for Economic Affairs of the Swiss Confederation diwakili Kurt Kunz, Duta Besar Swiss untuk Indonesia, Timor Leste, dan ASEAN ditandatangani pada Rabu (2/12) dengan lingkup pengembangan Energi Terbarukan.

      PA ini merupakan turunan serta tindak lanjut dari Nota Kesepahaman (MoU) yang telah di tandatangani oleh Menteri ESDM Arifin Tasrif dan The State Secretariat for Economic Affairs of the Swiss Confederation pada 9 Oktober 2020 lalu.

      Kepala BPSDM ESDM Prahoro Nurtjahyo mengungkapkan, dengan adanya kerjasama ini, diharapkan dapat meningkatkan kapasitas dan produktifitas Sumber Daya Manusia pengelola subsektor Energi Baru Terbarukan di kedua negara.

      "Dokumen ini menjadi awal dari para pemangku kepentingan di Indonesia dalam rangka terus mempromosikan keberlanjutan dan produktivitas dalam capacity building. Ke depannya tak hanya sektor energi, namun kerja sama ini juga akan melibatkan sektor-sektor lainnya," lanjut Prahoro.

      Lingkup Kerjasama mencakup pengembangan pelatihan formal dan non formal subsektor Energi Baru Terbarukan, kegiatan lainnya dalam ruang lingkup pertukaran pengetahuan dan peningkatan kapasitas.

      Selain BPSDM ESDM, program kerjasama ini akan juga melibatkan Bappenas/Kementerian PPN, Kementerian Pendidikan dan Kebudayaan, Badan Nasional Sertifikasi Profesi serta Politeknik yang bergerak di subsektor Energi Baru Terbarukan yang berada di Indonesia dan Swiss.

      Kerja sama Indonesia-Swiss ini dilatarbelakangi keinginan kedua negara untuk meningkatkan kontribusi dalam transisi energi di dunia, dimana Indonesia menetapkan kebijakan energi nasionalnya untuk meningkatkan pangsa energi terbarukan menjadi 23% pada tahun 2025, dan 31% pada tahun 2050.

      Sementara itu, pemerintah Swiss telah memasang target untuk mengurangi penggunaan bahan bakar fosil sebesar 20% pada tahun 2020. Sebagian besar energi yang dihasilkan di Swiss itu terbarukan, yang berasal dari tenaga air dan biomassa. Namun, keduanya hanya menyumbang sekitar 15% dari total konsumsi energi keseluruhan karena 85% energi yang digunakan itu berasal dari sumber energi impor, Sebagian besar dari bahan bakar fosil dan tenaga nuklir. (KO)
      ''',
  ),
  ArticleModel(3,
      title:
          'Siapkan Milenial Terjun di Industri Energi, PPSDM KEBTKE Gelar Kuliah Kapita Selekta',
      category: CategoryModel.MINERAL,
      department:
          'Kepala Biro Komunikasi, Layanan Informasi Publik dan Kerja Sama',
      author: 'Agung Pribadi (08112213555)',
      description:
          'Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.',
      bannerUrl: 'assets/article/4.jpg',
      publishTime: DateTime(2020, 11, 7),
      content: '''
          Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.
          
          Salah satu langkah yang ditempuh adalah melalui kuliah kapita selekta. Kuliah kali ini dikhususkan bagi mahasiswa/mahasiswi Departemen Teknik Kimia, Fakultas Teknik Universitas Indonesia secara daring dengan menghadirkan Kepala PPSDM KEBTKE Kementerian ESDM Laode Sulaeman sebagai pembicara.

          "Kegiatan ini bertujuan untuk mempersiapkan calon sarjana baru menghadapi dunia pekerjaan atau bisnis dengan kompetensi yang lebih memenuhi kebutuhan dunia usaha, industri, dan penelitian," kata Loade pada Kamis (26/11).

          Lebih lanjut, Loade membeberkan isu-isu global dan peluang kerja bidang energi, tantangan ketenagakerjaan nasional hingga penguatan SDM dari sisi Human Personality Development dalam merespon tantangan global berbasis kelembagaan.

          Secara khusus Laode menyoroti penyerapan pemanfaatan Energi Baru Terbarukan (EBT). Tercatat pada tahun 2019 realisasi bauran energi primer EBT dalam energi mix nasional sebesar 9,15%. Sementara untuk kapasitas pembangkit EBT 10,3GW atau 12,4% dari kapasitas total pembangkit pada tahun 2019 sejumlah 69,1GW.

          Sementara untuk daya saing tenaga kerja Indonesia, berdasarkan penelitian Institute for Management Development (IMD) menunjukkan, peringkat Indonesia masih tertinggal dibandingkan sejumlah negara ASEAN seperti Thailand, Malaysia, dan Singapura. Secara global, Indonesia berada di peringkat 47 dari 63 negara. "Rendahnya pendidikan pekerja serta ketidaksesuaian (mismatch) antara pendidikan dengan pekerjaan," kata Laode.

          Saat ini, Pemerintah terus memperkuat SDM di sektor energi melalui pelatihan vokasi, pemagangan berbasis kompetensi di industri, maupun oleh Lembaga penerbit sertifikasi kompetensi. "Kemitraan yang kuat antara institusi pendidikan, Lembaga sertifikasi dan industri adalah syarat mutlak terwujudnya SDM unggul melalui penguatan ini," jelas Laode.

          Ia mempertegas, selain keterampilan/skill keteknikan, softskill termasuk customer awareness, problem solving, team worker, self management, dan communication and literasi adalah kunci utama memasuki dunia kerja bidang energi.

          Melalui "Good Governance and Clean Government", berbagai upaya peningkatan layanan dilaksanakan di semua lini oleh PPSDM KEBTKE. (SA/NA)


          '''),
  ArticleModel(4,
      title:
          'Siapkan Milenial Terjun di Industri Energi, PPSDM KEBTKE Gelar Kuliah Kapita Selekta',
      category: CategoryModel.OIL,
      department:
          'Kepala Biro Komunikasi, Layanan Informasi Publik dan Kerja Sama',
      author: 'Agung Pribadi (08112213555)',
      description:
          'Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.',
      bannerUrl: 'assets/article/5.jpg',
      publishTime: DateTime(2020, 11, 7),
      content: '''
          Menghadapi tantangan dunia industri 4.0 di sektor energi, Pusat Pengembangan Sumber Daya Manusia Ketenagalistrikan dan Energi Baru Terbarukan dan Konservasi Energi (PPSDM KEBTKE) Kementerian ESDM mempersiapkan SDM yang mumpuni agar bisa beradaptasi langsung dengan dunia kerja.
          
          Salah satu langkah yang ditempuh adalah melalui kuliah kapita selekta. Kuliah kali ini dikhususkan bagi mahasiswa/mahasiswi Departemen Teknik Kimia, Fakultas Teknik Universitas Indonesia secara daring dengan menghadirkan Kepala PPSDM KEBTKE Kementerian ESDM Laode Sulaeman sebagai pembicara.

          "Kegiatan ini bertujuan untuk mempersiapkan calon sarjana baru menghadapi dunia pekerjaan atau bisnis dengan kompetensi yang lebih memenuhi kebutuhan dunia usaha, industri, dan penelitian," kata Loade pada Kamis (26/11).

          Lebih lanjut, Loade membeberkan isu-isu global dan peluang kerja bidang energi, tantangan ketenagakerjaan nasional hingga penguatan SDM dari sisi Human Personality Development dalam merespon tantangan global berbasis kelembagaan.

          Secara khusus Laode menyoroti penyerapan pemanfaatan Energi Baru Terbarukan (EBT). Tercatat pada tahun 2019 realisasi bauran energi primer EBT dalam energi mix nasional sebesar 9,15%. Sementara untuk kapasitas pembangkit EBT 10,3GW atau 12,4% dari kapasitas total pembangkit pada tahun 2019 sejumlah 69,1GW.

          Sementara untuk daya saing tenaga kerja Indonesia, berdasarkan penelitian Institute for Management Development (IMD) menunjukkan, peringkat Indonesia masih tertinggal dibandingkan sejumlah negara ASEAN seperti Thailand, Malaysia, dan Singapura. Secara global, Indonesia berada di peringkat 47 dari 63 negara. "Rendahnya pendidikan pekerja serta ketidaksesuaian (mismatch) antara pendidikan dengan pekerjaan," kata Laode.

          Saat ini, Pemerintah terus memperkuat SDM di sektor energi melalui pelatihan vokasi, pemagangan berbasis kompetensi di industri, maupun oleh Lembaga penerbit sertifikasi kompetensi. "Kemitraan yang kuat antara institusi pendidikan, Lembaga sertifikasi dan industri adalah syarat mutlak terwujudnya SDM unggul melalui penguatan ini," jelas Laode.

          Ia mempertegas, selain keterampilan/skill keteknikan, softskill termasuk customer awareness, problem solving, team worker, self management, dan communication and literasi adalah kunci utama memasuki dunia kerja bidang energi.

          Melalui "Good Governance and Clean Government", berbagai upaya peningkatan layanan dilaksanakan di semua lini oleh PPSDM KEBTKE. (SA/NA)


          '''),
];

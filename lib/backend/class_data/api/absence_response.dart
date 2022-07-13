class AbsenceResponse {
  int? status;
  String? message;
  List<AbsenceResponseData>? data;

  AbsenceResponse({this.status, this.message, this.data});

  AbsenceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AbsenceResponseData>[];
      json['data'].forEach((v) {
        data!.add(AbsenceResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AbsenceResponseData {
  String? idKehadiran;
  String? bulan;
  String? nik;
  String? namaPegawai;
  String? jenisKelamin;
  String? namaJabatan;
  String? hadir;
  String? sakit;
  String? alpha;

  AbsenceResponseData({
    this.idKehadiran,
    this.bulan,
    this.nik,
    this.namaPegawai,
    this.jenisKelamin,
    this.namaJabatan,
    this.hadir,
    this.sakit,
    this.alpha,
  });

  AbsenceResponseData.fromJson(Map<String, dynamic> json) {
    idKehadiran = json['id_kehadiran'];
    bulan = json['bulan'];
    nik = json['nik'];
    namaPegawai = json['nama_pegawai'];
    jenisKelamin = json['jenis_kelamin'];
    namaJabatan = json['nama_jabatan'];
    hadir = json['hadir'];
    sakit = json['sakit'];
    alpha = json['alpha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_kehadiran'] = idKehadiran;
    data['bulan'] = bulan;
    data['nik'] = nik;
    data['nama_pegawai'] = namaPegawai;
    data['jenis_kelamin'] = jenisKelamin;
    data['nama_jabatan'] = namaJabatan;
    data['hadir'] = hadir;
    data['sakit'] = sakit;
    data['alpha'] = alpha;
    return data;
  }
}
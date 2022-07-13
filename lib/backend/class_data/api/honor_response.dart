class HonorResponse {
  int? status;
  String? message;
  List<HonorResponseData>? data;

  HonorResponse({this.status, this.message, this.data});

  HonorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HonorResponseData>[];
      json['data'].forEach((v) {
        data!.add(HonorResponseData.fromJson(v));
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

class HonorResponseData {
  String? id;
  String? idUser;
  String? bulan;
  String? gajiPokok;
  String? uangMakan;
  String? tjTransport;
  String? namaPegawai;
  String? namaJabatan;

  HonorResponseData({
    this.id,
    this.idUser,
    this.bulan,
    this.gajiPokok,
    this.uangMakan,
    this.tjTransport,
    this.namaPegawai,
    this.namaJabatan,
  });

  HonorResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    bulan = json['bulan'];
    gajiPokok = json['gaji_pokok'];
    uangMakan = json['uang_makan'];
    tjTransport = json['tj_transport'];
    namaPegawai = json['nama_pegawai'];
    namaJabatan = json['jabatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_user'] = idUser;
    data['bulan'] = bulan;
    data['gaji_pokok'] = gajiPokok;
    data['uang_makan'] = uangMakan;
    data['tj_transport'] = tjTransport;
    data['nama_pegawai'] = namaPegawai;
    data['jabatan'] = namaJabatan;
    return data;
  }
}
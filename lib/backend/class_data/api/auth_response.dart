class AuthResponse {
  int? status;
  String? message;
  List<AuthResponseData>? data;

  AuthResponse({this.status, this.message, this.data});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AuthResponseData>[];
      json['data'].forEach((v) {
        data!.add(AuthResponseData.fromJson(v));
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

class AuthResponseData {
  String? idPegawai;
  String? nik;
  String? namaPegawai;
  String? username;
  String? password;
  String? jenisKelamin;
  String? jabatan;
  String? tanggalMasuk;
  String? status;
  String? photo;
  String? hakAkses;

  AuthResponseData(
      {this.idPegawai,
        this.nik,
        this.namaPegawai,
        this.username,
        this.password,
        this.jenisKelamin,
        this.jabatan,
        this.tanggalMasuk,
        this.status,
        this.photo,
        this.hakAkses});

  AuthResponseData.fromJson(Map<String, dynamic> json) {
    idPegawai = json['id_pegawai'];
    nik = json['nik'];
    namaPegawai = json['nama_pegawai'];
    username = json['username'];
    password = json['password'];
    jenisKelamin = json['jenis_kelamin'];
    jabatan = json['jabatan'];
    tanggalMasuk = json['tanggal_masuk'];
    status = json['status'];
    photo = json['photo'];
    hakAkses = json['hak_akses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pegawai'] = idPegawai;
    data['nik'] = nik;
    data['nama_pegawai'] = namaPegawai;
    data['username'] = username;
    data['password'] = password;
    data['jenis_kelamin'] = jenisKelamin;
    data['jabatan'] = jabatan;
    data['tanggal_masuk'] = tanggalMasuk;
    data['status'] = status;
    data['photo'] = photo;
    data['hak_akses'] = hakAkses;
    return data;
  }
}
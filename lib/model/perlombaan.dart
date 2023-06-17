class Perlombaan {
  String? idLomba;
  String? namaLomba;
  String? deskripsiLomba;
  String? kuotaLomba;

  Perlombaan({
    this.idLomba,
    this.namaLomba,
    this.deskripsiLomba,
    this.kuotaLomba,
    });

  factory Perlombaan.fromJson(Map<String, dynamic> json) => Perlombaan(
        idLomba: json['idLomba'],
        namaLomba: json['namaLomba'],
        deskripsiLomba: json['deskripsiLomba'],
        kuotaLomba: json['kuotaLomba'],
      );

  Map<String, dynamic> toJson() => {
        'idLomba': this.idLomba,
        'namaLomba': this.namaLomba,
        'deskripsiLomba': this.deskripsiLomba,
        'kuotaLomba': this.kuotaLomba,
      };
}
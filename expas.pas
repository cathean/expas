Program bexpe;
Uses
  crt, sysutils;
Type
  klien = record
    id_klien : integer;
    nama : string;
    alamat : string;
    no_hp : string;
  end;
  
  paket = record
    id_klien : integer;
    id_penerima : integer;
    id_karyawan : integer;
    id_paket : integer;
    nama : string;
    jenis : string;
    harga : integer;
    berat : integer;
    tanggal : string;
    tujuan : string;
  end;
  
  karyawan = record
    id_karyawan : integer;
    nama : string;
    no_hp : string;
  end;
  
  penerima = record
    id_penerima : integer;
    nama : string;
    alamat : string;
    no_hp : string;
  end;
Var
  ch : integer;
  
Procedure saveKlien(kl : klien);
var
  Fkl : file of klien;
begin
  Assign(Fkl, 'kliendb.dat');
  Seek(Fkl, FileSize(Fkl) - 1);
  write(Fkl, kl);
  Close(Fkl);
end;

Procedure savePaket(pk : paket);
var
  Fpk : file of paket;
begin
  Assign(Fpk, 'paketdb.dat');
  Seek(Fpk, FileSize(Fpk) - 1);
  write(Fpk, pk);
  Close(Fpk);
end;

Procedure saveKaryawan(kw : karyawan);
var
  Fkw : file of karyawan;
begin
  Assign(Fkw, 'karyawandb.dat');
  Seek(Fkw, FileSize(Fkw) - 1);
  write(Fkw, kw);
  Close(Fkw);
end;

Procedure savePenerima(pr : penerima);
var
  Fpr : file of penerima;
begin
  Assign(Fpr, 'penerimadb.dat');
  Seek(Fpr, FileSize(Fpr) - 1);
  write(Fpr, pr);
  Close(Fpr);
end;

Procedure menuUtama;
begin
  writeln('=========================');
  writeln('1) Masuk sebagai operator');
  writeln('2) Masuk sebagai klien');
  writeln('3) Cek paket saya');
  writeln('4) Bantuan');
  writeln('5) Keluar');
  writeln('=========================');
  write('Pilih => ');
  readln(ch);
end;

Procedure menuKlien;
begin
  writeln('=========================');
  writeln('1) Kirim paket baru');
  writeln('2) Cek paket yang dikirim');
  writeln('3) Keluar');
  writeln('=========================');
  write('Pilih => ');
  readln(ch);
end;

BEGIN
  repeat
    menuUtama;
  until (ch = 4);
END.

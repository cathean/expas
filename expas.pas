Program bexpe;
Uses
  crt, sysutils;
Const
	MAX_KLIEN = 10;
	MAX_PAKET = 30;
	MAX_KARYAWAN = 5;
	MAX_PENERIMA = 10;
Type
  klien = record
    id_klien : integer;
    nama : string;
    alamat : string;
    no_hp : string;
    hargatot : integer;
  end;
  
  paket = record
    id_klien : integer;
    id_penerima : integer;
    id_karyawan : integer;
    id_paket : integer;
    nama : string;
    jenis : string;
    harga : integer;
    berat : real;
    tanggal : string;
    tujuan : string;
    status : string;
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
  
  klienArr = array [1..MAX_KLIEN] of klien;
  paketArr = array [1..MAX_PAKET] of paket;
  karyawanArr = array [1..MAX_KARYAWAN] of karyawan;
  penerimaArr = array [1..MAX_PENERIMA] of penerima;
Var
	klMem : klienArr;
	pkMem : paketArr;
	kwMem : karyawanArr;
	prMem : penerimaArr;
	klLen : integer;
	pkLen : integer;
	kwLen : integer;
	prLen : integer;
  ch : integer;
 
Procedure init();
var
	Fkl : file of klien;
	Fpk : file of paket;
	Fkw : file of karyawan;
	Fpr : file of penerima;
begin
	if not FileExists('kliendb.dat') then
	begin
		Assign(Fkl, 'kliendb.dat');
		Rewrite(Fkl);
		Close(Fkl);
	end;
	
	if not FileExists('paketdb.dat') then
	begin
		Assign(Fpk, 'paketdb.dat');
		Rewrite(Fpk);
		Close(Fpk);
	end;
	
	if not FileExists('karyawandb.dat') then
	begin
		Assign(Fkw, 'karyawandb.dat');
		Rewrite(Fkw);
		Close(Fkw);
	end;
	
	if not FileExists('penerimadb.dat') then
	begin
		Assign(Fpr, 'penerimadb.dat');
		Rewrite(Fpr);
		Close(Fpr);
	end;
end;

Procedure createArr(klMem : klienArr; pkMem : paketArr; kwMem : karyawanArr; prMem : penerimaArr);
var
	i : integer;
begin
	for i := 1 to MAX_KLIEN do
	begin
		klMem[i].id_klien := 0;
		klMem[i].nama := '';
		klMem[i].alamat := '';
		klMem[i].no_hp := '';
		klMem[i].hargatot := 0;
	end;
	
		for i := 1 to MAX_PAKET do
	begin
		pkMem[i].id_klien := 0;
		pkMem[i].id_penerima := 0;
		pkMem[i].id_karyawan := 0;
		pkMem[i].id_paket := 0;
		pkMem[i].nama := '';
		pkMem[i].jenis := '';
		pkMem[i].harga := 0;
		pkMem[i].berat := 0;
		pkMem[i].tanggal := '';
		pkMem[i].tujuan := '';
		pkMem[i].status := '';
	end;
	
		for i := 1 to MAX_KARYAWAN do
	begin
		kwMem[i].id_karyawan := 0;
		kwMem[i].nama := '';
		kwMem[i].no_hp := '';
	end;
	
		for i := 1 to MAX_PENERIMA do
	begin
		prMem[i].id_penerima := 0;
		prMem[i].nama := '';
		prMem[i].alamat := '';
		prMem[i].no_hp := '';
	end;
end;

Procedure load();
var
	Fkl : file of klien;
	Fpk : file of paket;
	Fkw : file of karyawan;
	Fpr : file of penerima;
	i : integer;
begin
	Assign(Fkl, 'kliendb.dat');
	Reset(Fkl);
	klLen := FileSize(Fkl);
	
	for i := 1 to klLen do
	begin
		Seek(Fkl, i - 1);
		Read(Fkl, klMem[i]);
	end;
	
	Close(Fkl);
	
	Assign(Fpr, 'penerimadb.dat');
	Reset(Fpr);
	prLen := FileSize(Fpr);
	
	for i := 1 to prLen do
	begin
		Seek(Fpr, i - 1);
		Read(Fpr, prMem[i]);
	end;
	
	Close(Fpr);
	
	Assign(Fpk, 'paketdb.dat');
	Reset(Fpk);
	pkLen := FileSize(Fpk);
	
	for i := 1 to pkLen do
	begin
		Seek(Fpk, i - 1);
		Read(Fpk, pkMem[i]);
	end;
	
	Close(Fpk);
	
	Assign(Fkw, 'karyawandb.dat');
	Reset(Fkw);
	kwLen := FileSize(Fkw);
	
	for i := 1 to kwLen do
	begin
		Seek(Fkw, i - 1);
		Read(Fkw, kwMem[i]);
	end;
	
	Close(Fkw);
end;

Procedure saveKlien(kl : klien);
var
	i : integer;
  Fkl : file of klien;
begin
	klMem[klLen + 1] := kl;
  Assign(Fkl, 'kliendb.dat');
  Rewrite(Fkl);
  
  for i := 1 to klLen + 1 do
  begin
		write(Fkl, klMem[i]);
  end;
  
  Close(Fkl);
end;

Procedure savePaket(pk : paket);
var
	i : integer;
  Fpk : file of paket;
begin
	pkMem[pkLen + 1] := pk;
  Assign(Fpk, 'paketdb.dat');
  Rewrite(Fpk);
  
  for i := 1 to pkLen + 1 do
  begin
		write(Fpk, pkMem[i]);
  end;
  
  Close(Fpk);
end;

Procedure saveKaryawan(kw : karyawan);
var
	i : integer;
  Fkw : file of karyawan;
begin
	kwMem[kwLen + 1] := kw;
  Assign(Fkw, 'karyawandb.dat');
  Rewrite(Fkw);
  
  for i := 1 to kwLen + 1 do
  begin
		write(Fkw, kwMem[i]);
  end;
  
  Close(Fkw);
end;

Procedure savePenerima(pr : penerima);
var
  Fpr : file of penerima;
  i : integer;
begin
	prMem[prLen + 1] := pr;
  Assign(Fpr, 'penerimadb.dat');
  Rewrite(Fpr);
  
  for i := 1 to prLen + 1 do
  begin
		write(Fpr, prMem[i]);
  end;
  
  Close(Fpr);
end;

Procedure menuUtama;
begin
	clrscr;
	writeln('UNIKOM EXPEDITION EXPRESS -version 1.0');
	writeln('######################################');
	writeln('(Tugas kelompok nomor 2)');
	writeln;
	writeln('Menu pilihan');
  writeln('=========================');
  writeln('1) Masuk sebagai operator');
  writeln('2) Kirim paket');
  writeln('3) Cek paket saya');
  writeln('4) Bantuan');
  writeln('5) Keluar');
  writeln('=========================');
  write('Pilih => ');
  readln(ch);
end;

Procedure operatorMenu;
var
	id : integer;
	kw : karyawan;
	Fkw : file of karyawan;
begin
	clrscr;
	
	Assign(Fkw, 'karyawandb.dat');
	Reset(Fkw); //Karyawan pertama adalah bapak Eddy dengan nomor ID = 1
	read(Fkw, kw);

	repeat
		writeln('Masuk sebagai karyawan UNIKOM EXPEDITION EXPRESS');
		writeln('################################################');
		writeln;
		write('ID karyawan (0 untuk keluar) : ');
		readln(id);
		
		if (id = 0) then exit;
	until (id = kw.id_karyawan);

	clrscr;
	writeln('Masuk sebagai karyawan UNIKOM EXPEDITION EXPRESS');
	writeln('################################################');
	writeln;
	writeln('Informasi karyawan');
	writeln('##################');
	writeln('>ID       : ', kw.id_karyawan);
	writeln('>Nama     : ', kw.nama);
	writeln('>Nomor HP : ', kw.no_hp);
	writeln;
	writeln('Pilihan menu');
  writeln('=========================');
  writeln('1) Daftar paket');
  writeln('2) Daftar klien dan penerima');
  writeln('3) Hapus semua database');
  writeln('4) Kembali');
  writeln('=========================');
  write('Pilih => ');
  readln(ch);
  
  Close(Fkw);
end;

Function hitungHarga(h : real) : integer;
begin
	hitungHarga := round(h) * 10000;
end;

Procedure kirimPaket();
var
	kl : klien;
	pr : penerima;
	pk : paket;
	i, npaket : integer;
  Fkl : file of klien;
  Fpr : file of penerima;
  Fpk : file of paket;
  d, m, y : word;
  tgl : string;
begin
	DecodeDate(Date, y, m, d);
	tgl := IntToStr(d) + '/' + IntToStr(m) + '/' + IntToStr(y);
	clrscr;
	
	//INFORMASI DATA KLIEN
	Assign(Fkl, 'kliendb.dat');
	Reset(Fkl);
	kl.id_klien := FileSize(Fkl) + 1;
	Close(Fkl);
	
	writeln('DATA KLIEN');
	writeln('============================');
	writeln('ID pengirim   : ', kl.id_klien );
	write('Nama pengirim : ');
	readln(kl.nama);
	write('Alamat        : ');
	readln(kl.alamat);
	write('Nomor HP      : ');
	readln(kl.no_hp);
	
	saveKlien(kl);
	
	writeln;
	
	//INFORMASI DATA PENERIMA
	Assign(Fpr, 'penerimadb.dat');
	Reset(Fpr);
	pr.id_penerima := FileSize(Fpr) + 1;
	Close(Fpr);
	
	writeln('DATA PENERIMA');
	writeln('============================');
	writeln('ID penerima  : ', pr.id_penerima);
	write('Nama penerima : ');
	readln(pr.nama);
	write('Alamat        : ');
	readln(pr.alamat);
	write('Nomor HP      : ');
	readln(pr.no_hp);
	
	savePenerima(pr);
	
	writeln;
	
	clrscr;
	
	//INFORMASI DATA PAKET
	writeln('DATA PAKET');
	writeln('============================');
	write('Berapa banyak paket : ');
	readln(npaket);
	
	writeln;
	writeln('========================================================================');	
	writeln('| ID paket |  Nama barang  | Jenis Barang | Berat(kg) | Tujugan barang |');
	writeln('========================================================================');
	
	for i := 1 to npaket do
	begin
		writeln;
		Assign(Fpk, 'paketdb.dat');
		Reset(Fpk);
	
		pk.id_klien := kl.id_klien;
		pk.id_penerima := pr.id_penerima;
		pk.id_karyawan := 1;
		pk.status := 'PENDING';
		pk.id_paket := kl.id_klien * 100 + pr.id_penerima * 10 + FileSize(Fpk) + 1;
		pk.tanggal := tgl;

		gotoxy(1, i + 7); writeln('|          |               |              |           |                |');
	
		gotoxy(3, i + 7); writeln(pk.id_paket);
		gotoxy(14, i + 7); readln(pk.nama);
		gotoxy(30, i + 7); readln(pk.jenis);
		gotoxy(45, i + 7); readln(pk.berat);
		
		pk.harga := hitungHarga(pk.berat);
		
		gotoxy(57, i + 7); readln(pk.tujuan);
		
		Close(Fpk);
		savePaket(pk);
		load;
	end;
	
	gotoxy(1, i + 8); writeln('========================================================================');
	
end;

Procedure cariPaketKlien(id : integer; var pkResult : paketArr; var byk : integer);
var
	i, k : integer;
	pk : paket;
	Fpk : file of paket;
begin
	k := 1;

	Assign(Fpk, 'paketdb.dat');
	Reset(Fpk);
	pkLen := FileSize(Fpk);
	
	for i := 1 to pkLen do
	begin
		Seek(Fpk, i - 1);
		Read(Fpk, pk);
		
		if (pk.id_klien = id) then
		begin
			pkResult[k] := pk;
			k := k + 1;
		end;
	end;
	
	Close(Fpk);
	
	byk := k;
end;

 Procedure cariPaket(id : integer; var pkResult : paket);
var
	i : integer;
	pk : paket;
	Fpk : file of paket;
begin

	Assign(Fpk, 'paketdb.dat');
	Reset(Fpk);
	pkLen := FileSize(Fpk);
	
	for i := 1 to pkLen do
	begin
		Seek(Fpk, i - 1);
		Read(Fpk, pk);
		
		if (pk.id_paket = id) then
		begin
			pkResult := pk;
			break;
		end;
	end;
	
	Close(Fpk);
end;

Procedure cekPaket;
var
	id, byk, i : integer;
	pk1 : paketArr;
	pk2 : paket;
begin
	clrscr;
  writeln('=========================');
  writeln('1) Cari dengan ID klien');
  writeln('2) Cari dengan ID paket');
  writeln('3) Kembali');
  writeln('=========================');
  write('Pilih => ');
  readln(ch);
	
	case ch of
		1:	begin
					clrscr;
					write('ID klien anda : ');
					readln(id);
					
					cariPaketKlien(id, pk1, byk);
					byk := byk - 1;
					
					clrscr;
					
					writeln('ID klien                  : ', id);
					writeln('Banyak paket yang dikirim : ', byk);
					writeln;
					writeln('===================================================================================');
					writeln('| ID Paket | ID Penerima |   Nama barang   |  Jenis  |  Harga  | Berat |  Status  |');
					writeln('===================================================================================');
					
					for i := 1 to byk do
					begin
						gotoxy(1, 6 + i); write('|          |             |                 |         |         |       |          |');
						gotoxy(3, 6 + i); write(pk1[i].id_paket);
						gotoxy(14, 6 + i); write(pk1[i].id_penerima);
						gotoxy(28, 6 + i); write(pk1[i].nama);
						gotoxy(46, 6 + i); write(pk1[i].jenis);
						gotoxy(56, 6 + i); write(pk1[i].harga);
						gotoxy(66, 6 + i); write(pk1[i].berat:0:2);
						gotoxy(74, 6 + i); write(pk1[i].status);
					end;
					
					gotoxy(1, 7 + i); write('===================================================================================');
					
					readln;
				end;
		2:	begin
					clrscr;
					write('ID paket anda : ');
					readln(id);
					
					cariPaket(id, pk2);
					
					clrscr;
					
					writeln('ID klien : ', pk2.id_klien);
					
					writeln;
					
					writeln('===================================================================================');
					writeln('| ID Paket | ID Penerima |   Nama barang   |  Jenis  |  Harga  | Berat |  Status  |');
					writeln('===================================================================================');
					writeln('|          |             |                 |         |         |       |          |');
					writeln('===================================================================================');
					
						gotoxy(3, 6); write(pk2.id_paket);
						gotoxy(14, 6); write(pk2.id_penerima);
						gotoxy(28, 6); write(pk2.nama);
						gotoxy(46, 6); write(pk2.jenis);
						gotoxy(56, 6); write(pk2.harga);
						gotoxy(66, 6); write(pk2.berat:0:2);
						gotoxy(74, 6); write(pk2.status);
					
					readln;
				end;
		3:	exit;
	end;
end;

Procedure urusPaket(id : integer);
var
	adakah : boolean;
	klPos, prPos, pkIndex, i : integer;
	pk : paket;
	
	Fpk : file of paket;
begin
	clrscr;
	adakah := false;
	
	Assign(Fpk, 'paketdb.dat');
	Reset(Fpk);
	pkLen := FileSize(Fpk);
	
	for i := 1 to pkLen do
	begin
		Seek(Fpk, i - 1);
		Read(Fpk, pk);
		
		if (pk.id_paket = id) then
		begin
			pkIndex := i;
			adakah := true;
			break;
		end;
	end;
	
	if not (adakah) then
	begin
		writeln;
		writeln('Paket dengan ID ', id, ' tidak ada!');
		writeln('Tekan ENTER untuk kembali!');
    
    Close(Fpk);
		exit;
	end
	else
	begin
		clrscr;
		
		for i := 1 to klLen do
		begin
			if (klMem[i].id_klien = pk.id_klien) then
			begin
				klPos := i;
				break;
			end;
		end;
		
		for i := 1 to prLen do
		begin
			if (prMem[i].id_penerima = pk.id_penerima) then
			begin
				prPos := i;
				break;
			end;
		end;
		
		writeln('INFORMASI KLIEN');
		writeln('###############');
		writeln('ID klien    : ', pk.id_klien);
		writeln('Nama klien  : ', klMem[klPos].nama);
		writeln('Alamat      : ', klMem[klPos].alamat);
		writeln('No HP       : ', klMem[klPos].no_hp);
		writeln;
		writeln('INFORMASI PENERIMA');
		writeln('##################');
		writeln('ID penerima   : ', pk.id_penerima);
		writeln('Nama penerima : ', prMem[prPos].nama);
		writeln('Alamat        : ', prMem[prPos].alamat);
		writeln('No HP         : ', prMem[prPos].no_hp);
		writeln;
		writeln('INFORMASI PAKET');
		writeln('###############');
		writeln;
		writeln('=====================================================================================');
		writeln('|  Tanggal  |   Nama barang   |   Jenis   |  Harga  | Berat |   Tujuan   |  Status  |');
		writeln('=====================================================================================');
		writeln('|           |                 |           |         |       |            |          |');
		writeln('=====================================================================================');
		gotoxy(3, 21); write(pk.tanggal);
		gotoxy(15, 21); write(pk.nama);
		gotoxy(33, 21); write(pk.jenis);
		gotoxy(45, 21); write(pk.harga);
		gotoxy(55, 21); write(pk.berat:0:2);
		gotoxy(63, 21); write(pk.tujuan);
		gotoxy(76, 21); readln(pk.status);
	end;
	
	Close(Fpk);
end;

Procedure daftarPaket;
var
	i, id : integer;
	pk : paket;
	Fpk : file of paket;
begin
	clrscr;
	
	Assign(Fpk, 'paketdb.dat');
	Reset(Fpk);
	pkLen := FileSize(Fpk);
	
	writeln('===================================================================================');
	writeln('| ID Paket | ID Penerima |   Nama barang   |  Jenis  |  Harga  | Berat |  Status  |');
	writeln('===================================================================================');
	
	for i := 1 to pkLen do
	begin
		Seek(Fpk, i - 1);
		Read(Fpk, pk);
		
		gotoxy(1, 3 + i); write('|          |             |                 |         |         |       |          |');
		gotoxy(3, 3 + i); write(pk.id_paket);
		gotoxy(14, 3 + i); write(pk.id_penerima);
		gotoxy(28, 3 + i); write(pk.nama);
		gotoxy(46, 3 + i); write(pk.jenis);
		gotoxy(56, 3 + i); write(pk.harga);
		gotoxy(66, 3 + i); write(pk.berat:0:2);
		gotoxy(74, 3 + i); write(pk.status);
	end;
	
	gotoxy(1, 4 + i); write('===================================================================================');
	
	Close(Fpk);
	
	writeln;
	writeln;
	writeln('Detail paket dan ganti status (nol untuk keluar)');
	write('ID paket : ');
	readln(id);
	urusPaket(id);
	
	readln;
end;

Procedure hapusDB;
begin
	clrscr;
	writeln('Menghapus database...');
	writeln('...hapus kliendb.dat');
	DeleteFile('kliendb.dat');
	writeln('...hapus paketdb.dat');
	DeleteFile('paketdb.dat');
	writeln('...hapus penerimadb.dat');
	DeleteFile('penerimadb.dat');
	writeln;
	writeln('Berhasil! Tekan ENTER untuk keluar');
	readln;
	halt(1);
end;

BEGIN
	init;
	
  repeat
		clrscr;
		createArr(klMem, pkMem, kwMem, prMem);
		load;
    menuUtama;
    
    case ch of
			1:	begin
						operatorMenu;
						
						case ch of
							1:	begin
										daftarPaket;
									end;
							2:	begin
									end;
							3:	begin
										hapusDB;
									end;
							4:	begin
										continue;
									end;
						end;
					end;
			2:	begin
						kirimPaket;
					end;
			3:	begin
						cekPaket;
					end;
    end;
  until (ch = 5);
END.

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
    berat : integer;
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
	Reset(Fkw);
	read(Fkw, kw);

	repeat
		write('Masukkan id karyawan anda (0 utk keluar) : ');
		readln(id);
		
		if (id = 0) then exit;
	until (id = kw.id_karyawan);

	clrscr;
  writeln('=========================');
  writeln('1) Daftar paket');
  writeln('2) Ganti status paket');
  writeln('3) Hapus semua database');
  writeln('4) Kembali');
  writeln('=========================');
  write('Pilih => ');
  readln(ch);
  
  Close(Fkw);
end;

Procedure kirimPaket();
var
	kl : klien;
	pr : penerima;
	pk : paket;
	kw : karyawan;
	i, npaket : integer;
  Fkl : file of klien;
  Fpr : file of penerima;
  Fpk : file of paket;
  Fkw : file of karyawan;
begin
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
	
	//INFORMASI DATA PAKET
	writeln('DATA PAKET');
	writeln('============================');
	write('Berapa banyak paket : ');
	readln(npaket);
	
	for i := 1 to npaket do
	begin
		Assign(Fpk, 'paketdb.dat');
		Reset(Fpk);
	
		pk.id_klien := kl.id_klien;
		pk.id_penerima := pr.id_penerima;
		pk.id_karyawan := 1;
		pk.status := 'PENDING';
		pk.id_paket := kl.id_klien * 100 + pr.id_penerima * 10 + FileSize(Fpk) + 1;
	
		writeln('ID paket      : ', pk.id_paket);
		write('Nama barang   : ');
		readln(pk.nama);
		write('Tujuan barang : ');
		readln(pk.tujuan);
		
		Close(Fpk);
		savePaket(pk);
		load;
	end;
	
	
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
						gotoxy(66, 6 + i); write(pk1[i].berat);
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
						gotoxy(66, 6); write(pk2.berat);
						gotoxy(74, 6); write(pk2.status);
					
					readln;
				end;
		3:	exit;
	end;
end;

Procedure hapusDB;
begin
	clrscr;
	writeln('Menghapus database...');
	DeleteFile('kliendb.dat');
	DeleteFile('paketdb.dat');
	DeleteFile('penerimadb.dat');
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

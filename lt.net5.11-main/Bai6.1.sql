CREATE DATABASE HRMDB;
GO
USE HRMDB;
GO

-- 1. Bảng PhongBan
CREATE TABLE PhongBan (
    MaPB INT IDENTITY(1,1) PRIMARY KEY,
    TenPB NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(255)
);

-- 2. Bảng NhanVien
CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATETIME,
    CCCD VARCHAR(20) UNIQUE,
    MaPB INT FOREIGN KEY REFERENCES PhongBan(MaPB),
    LuongCoBan DECIMAL(18,2) CHECK (LuongCoBan > 0),
    HeSoLuong FLOAT DEFAULT 1.0
);

-- 3. Bảng BangChamCong
CREATE TABLE BangChamCong (
    MaCong INT IDENTITY(1,1) PRIMARY KEY,
    MaNV INT FOREIGN KEY REFERENCES NhanVien(MaNV),
    ThangNam VARCHAR(7), -- Ví dụ: "11/2026"
    SoNgayCong FLOAT CHECK (SoNgayCong <= 31),
    SoGioOT FLOAT DEFAULT 0
);

-- 4. Bảng BangLuong
CREATE TABLE BangLuong (
    MaLuong INT IDENTITY(1,1),
    MaNV INT FOREIGN KEY REFERENCES NhanVien(MaNV),
    ThangNam VARCHAR(7),
    ThucLinh DECIMAL(18,2),
    CONSTRAINT PK_BangLuong PRIMARY KEY (MaNV, ThangNam)
);

-- Thêm dữ liệu mẫu thử nghiệm
INSERT INTO PhongBan (TenPB, MoTa) VALUES (N'Phòng Nhân sự', N'Quản lý nhân sự'), (N'Phòng Kỹ thuật', N'Phát triển phần mềm');
INSERT INTO NhanVien (HoTen, NgaySinh, CCCD, MaPB, LuongCoBan, HeSoLuong) 
VALUES (N'Nguyễn Văn A', '1995-05-10', '012345678901', 1, 10000000, 1.2),
       (N'Trần Thị B', '1998-08-20', '012345678902', 2, 12000000, 1.5);
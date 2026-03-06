FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ก๊อปปี้ไฟล์ทั้งหมด
COPY . .

# สั่ง Restore และ Publish โดยระบุไฟล์โปรเจกต์ให้ชัดเจน
RUN dotnet restore "Infromation Chanal Safety.csproj"
RUN dotnet publish "Infromation Chanal Safety.csproj" -c Release -o /app

# ใช้ Runtime สำหรับรันเว็บ
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .

# คำสั่งรัน (ตรวจสอบชื่อไฟล์ .dll ให้ตรงเป๊ะ)
ENTRYPOINT ["dotnet", "Infromation Chanal Safety.dll"]
@echo off
color 0a
title 9008ˢ���ű� REV.1 by Leak
echo ���ű���������RX-130 Lumia950ϵ�й����豸��
echo �����޼ۣ�ˢ��ǰ��ע�ⱸ�ݣ��˲������룩��
echo ��ȷ�������豸����9008״̬���Ѱ�װ���������

:set
echo ������Ŀ���豸�˿ںţ�������COM4������4��
set /p com=

:menu
cls
echo 9008ˢ���ű� REV.1 by Leak
echo ���ű���������RX-130Ϊ�����һЩ32GB�豸��
echo.
echo ��ǰѡ���˿ڣ�COM%com%
echo -����0�����趨�˿ں���
echo -����1�����ݵ�ǰ����
echo -����2����ˢд
echo -����3�˳�����
echo.
set /p choice=������:
if "%choice%"=="0" goto set
if "%choice%"=="1" goto dump
if "%choice%"=="2" goto flash
if "%choice%"=="3" goto exit

:dump
cls
echo 9008ˢ���ű� REV.1 by Leak
echo Dump Mode
echo ������Ŀ���ļ�����������1.img����
set /p filename=
emmcdl -p COM%com% -f 8994.mbn -d 0 61071360 -o %filename%
goto menu

:flash
cls
echo 9008ˢ���ű� REV.1 by Leak
echo Flash Mode
echo �뽫����Ҫˢ���img�ļ�������ΪFlash.img�����뵱ǰ�ļ��С�
echo ������1��ȷ�ϡ�
set /p choice=������:
if "%choice%"=="1" goto f else goto flash

:f
emmcdl -p COM%com% -f 8994.mbn -x rawprogram0.xml -SetActivePartition 0
goto menu

:exit
pause
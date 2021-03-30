Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E234E372
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhC3Io0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 04:44:26 -0400
Received: from mout.web.de ([212.227.15.3]:38697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhC3IoL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617093845;
        bh=C8LHwDRsT1kheBjdSBuw0JKthw5fmlvBbh+P5eJZ8Yc=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=E7PRyLU7wGEWTQOH8SxLrmD6X+tL/s5EuA1A58nEkN8sSjZ0d7NKX6NenY6LiMwhP
         JfRUdjPE1O8HbMMW+6vwOq2lXHJI7mV0e+eDxJkAwZZCMJoZ71a+bRj+n6xunRXSbt
         /7jYVXZEgIGcHA1Qssix30HxRbMBa4nPmtOa5nQ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [62.216.205.36] ([62.216.205.36]) by web-mail.web.de
 (3c-app-webde-bs38.server.lan [172.19.170.38]) (via HTTP); Tue, 30 Mar 2021
 10:44:05 +0200
MIME-Version: 1.0
Message-ID: <trinity-6258eac7-550c-402f-9280-6f529e372d32-1617093845116@3c-app-webde-bs38>
From:   B A <chris.std@web.de>
To:     Chris Murphy <lists@colorremedies.com>,
        btrfs kernel mailing list <linux-btrfs@vger.kernel.org>
Subject: Aw: Re: Help needed with filesystem errors: parent transid verify
 failed
Content-Type: multipart/mixed;
 boundary=rekceb-11c7453c-cb1c-41a3-899d-816bccf2aaf3
Date:   Tue, 30 Mar 2021 10:44:05 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAJCQCtQWtnjyN88gif-tmA_cxcs+6HPgVxB5XwNmAVj3qMKmfw@mail.gmail.com>
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQWtnjyN88gif-tmA_cxcs+6HPgVxB5XwNmAVj3qMKmfw@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:hs6S3eZO7k/30YgiAitpeJOihlho2vFiq54QZs5ntT5YEkOgrjThNKfGrylsSrQYcSjOQ
 IWJS3wGyBTzIH7sbNhZ+AIv5OfJm1gJHvn2DuhngLiYkl7btKgVvB0AmkVFfZXnawOF0NuR16ex8
 f4GzZUE+QzDkXIbiOg71TFiizf1QMm3W+Bf7LGKv0KZS/0tdmcAQwzMDo/2Gv3MdAAq111VZbanR
 CpZU6YWl4fVkivrkS7sJ5eDhIw7kBxonm/jbS43AgsuThcz1STH33W7lRt1HTAkNK8YTiPzQUweG
 Lc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:is6qb4X7Dy4=:chJbOKIlZ5aOBy666dO1pp
 oGL1OaaWeaPOnYdS9NWSuiNlJ/NgznGJ3c90FEV3p9LUM0SU9zFV5A6/M/Kkcudh5HZznRiSR
 E1reTV5e8akIA7npkWztJ1yg3v+IsFSvBFIHUmJH8IzmeP22iEbfoH2Aq4+zPYxz4vDE3w4Y3
 KRUvi9TuxNUVItkQt3mRDVHsHl4w7+XwRIb/KSsiJZRWcnZ2oszRjKH0vHyEQymEraAiFH4KX
 0OkNTBsGpJp+7U60bPaGz0G5UAseL28JVNu2xQhLTomqeZTdxH15jdkPd1JTXwCIOPgBi9dHc
 P7m9TIxSR6jTHxYl/bj0ZIbKdaY+2AuM2tJUqCDodimQpgTCQxthGDTH14hqDiGhuyPUJ2Pha
 wUGktRLE4KjfZUCyinFNabu4RjLZvsC7d5uEmyu5aBork83BKfmKRVybnKQHmIUOX+88cTP4K
 KngneA7Sivgy3XamYKUdbQQosv+jJVQBR6Yc50nDMYCDuiit+0oOY5sqXW81nItMLEUWBiOXF
 8wxXqII625PTowf9UdcnwYcqYuj43NoZMur7sXX231+0MEe6pJBF3iJw8OyOC00K2JkzQs7MF
 n0irhzO8lyS16wlRM2S8lGGRQnQpb9h7U4mtD2hX/rZHFovdWj3aFz4mRDWiLF8wH3shfhdEf
 jdgQO/0izexOfZNsI6n8it50ZIJ+RM9f89VQXSzBMSzY5M5OunVFr2ERaH7NBNQQIeaJK0qzd
 9J7DY8wfdA4V5UMk3/5jtf0oYEN7ehhki0kAtTOFhTbkk0cjn10PcZmxjYO49bL1bjUp7k+Q8
 iH8oetM8YWCrvCOWCLxP/gBzbB4EyVmNQ3GZyTz+1PwbIOWlNxEFNnjhYg5fY5JjL5fVB0TT3
 Uf19LwVh7kfHlTgkdymY8O0fqhuHWwHvm5e9EhMPFIKQh/7jND8rLtGpF2ApWI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--rekceb-11c7453c-cb1c-41a3-899d-816bccf2aaf3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> Gesendet: Dienstag, 30=2E M=C3=A4rz 2021 um 00:07 Uhr
> Von: "Chris Murphy" <lists@colorremedies=2Ecom>
> An: "B A" <chris=2Estd@web=2Ede>
> Cc: "Btrfs BTRFS" <linux-btrfs@vger=2Ekernel=2Eorg>
> Betreff: Re: Help needed with filesystem errors: parent transid verify f=
ailed
>
> On Sun, Mar 28, 2021 at 9:41 AM B A <chris=2Estd@web=2Ede> wrote:
> >
> > * Samsung 840 series SSD (SMART data looks fine)
>=20
> EVO or PRO? And what does its /proc/mounts line look like?

Model is MZ-7TD500, which seems to be an EVO=2E Firmware is DXT08B0Q=2E

From /etc/fstab:

UUID=3D1a149bda-057d-4775-ba66-1bf259fce9a5 /        btrfs   subvol=3Droot=
-f23,x-systemd=2Edevice-timeout=3D0,compress=3Dlzo,ssd,noatime 0 0
UUID=3D1b1f5c60-57f3-435c-b73e-2de727a302e2 /boot    ext4    nosuid,noexec=
,nodev        1 2
UUID=3D1a149bda-057d-4775-ba66-1bf259fce9a5 /home    btrfs   subvol=3Dhome=
,x-systemd=2Edevice-timeout=3D0,compress=3Dlzo,ssd,nosuid,nodev,noatime 0 0
UUID=3D1a149bda-057d-4775-ba66-1bf259fce9a5 /var     btrfs   subvol=3Dvar-=
f23,x-systemd=2Edevice-timeout=3D0,compress=3Dlzo,ssd,nosuid,noexec,nodev,n=
oatime 0 0

> Total_LBAs_Written?

Raw value: 92857573119
(full output in attached file)


Kind regards,
Chris
--rekceb-11c7453c-cb1c-41a3-899d-816bccf2aaf3
Content-Type: text/plain
Content-Disposition: attachment; filename=smartctl_-all.txt
Content-Transfer-Encoding: quoted-printable

smartctl 7.2 2021-01-17 r5171 [x86_64-linux-5.8.15-301.fc33.x86_64] (local=
 build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.or=
g

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Samsung based SSDs
Device Model:     Samsung SSD 840 Series
Serial Number:    [removed]
LU WWN Device Id: [removed]
Firmware Version: DXT08B0Q
User Capacity:    500,107,862,016 bytes [500 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
TRIM Command:     Available, deterministic, zeroed
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4c
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Tue Mar 30 04:37:16 2021 EDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine com=
pleted
					without error or no self-test has ever
					been run.
Total time to complete Offline
data collection: 		(53956) seconds.
Offline data collection
capabilities: 			 (0x53) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					No Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  70) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 1
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED =
 WHEN_FAILED RAW_VALUE
  5 Reallocated_Sector_Ct   0x0033   100   100   010    Pre-fail  Always  =
     -       0
  9 Power_On_Hours          0x0032   097   097   000    Old_age   Always  =
     -       12588
 12 Power_Cycle_Count       0x0032   091   091   000    Old_age   Always  =
     -       8958
177 Wear_Leveling_Count     0x0013   089   089   000    Pre-fail  Always  =
     -       131
179 Used_Rsvd_Blk_Cnt_Tot   0x0013   100   100   010    Pre-fail  Always  =
     -       0
181 Program_Fail_Cnt_Total  0x0032   100   100   010    Old_age   Always  =
     -       0
182 Erase_Fail_Count_Total  0x0032   100   100   010    Old_age   Always  =
     -       0
183 Runtime_Bad_Block       0x0013   100   100   010    Pre-fail  Always  =
     -       0
187 Uncorrectable_Error_Cnt 0x0032   100   100   000    Old_age   Always  =
     -       0
190 Airflow_Temperature_Cel 0x0032   073   051   000    Old_age   Always  =
     -       27
195 ECC_Error_Rate          0x001a   200   200   000    Old_age   Always  =
     -       0
199 CRC_Error_Count         0x003e   099   099   000    Old_age   Always  =
     -       4
235 POR_Recovery_Count      0x0012   099   099   000    Old_age   Always  =
     -       1958
241 Total_LBAs_Written      0x0032   099   099   000    Old_age   Always  =
     -       92857573119

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours=
)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      1935      =
   -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
  255        0    65535  Read_scanning was never started
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay=
.


--rekceb-11c7453c-cb1c-41a3-899d-816bccf2aaf3--


Return-Path: <linux-btrfs+bounces-15546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C6B09B07
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 07:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5052C5A5BEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 05:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA41E520A;
	Fri, 18 Jul 2025 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiYVGd5S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED422A930
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818084; cv=none; b=UsTXArYoPDOsPj6TlFso/cukgq7m0krEXqrAWeV3LuIkVogAuO0kN9JekCvWCnHHZZpRsUntTwRrCUph2S+OtNlhDYsYYBULNv1jZ3qFqLqI+XKC+acux9zm04sB0cfDN+n0bRt8lUAsR54wQ7OMR0JRJSzCAkgX1Kh0hLgl0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818084; c=relaxed/simple;
	bh=2FINUA31d1SkzLEZvU+UP0x2uwr7DE87SVtJlRXsg1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PP+HJ0D3AcQjsY1jVzgqeZRtyX+gIHLkQ0hMKzrhUl6W3ScPa3toF4vhfWDi2J5moRV3xuxJz2qRhoCxev3UVE4aNJeOdUFqEdFZNJqvA6vVpKDRx4e1z+k7fFE6o2lvWM2qEkyL+raYXmO7PB87csYH238H0FZ37FamqWoR680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiYVGd5S; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso16072331fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 22:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752818080; x=1753422880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1XKSPX7idvUf2IfcoWqYxvm95WhuWNRdajgbOdF1f8=;
        b=RiYVGd5SGhjIVLmCj+tINDf4I8ZsVM1MFSDG68Ga4k7Ok0d26q0yjCBfr3vymEyPm5
         P/ewvAhx41cqwEtkXZQOW2fyAvpcNyLYne9QzdXVj1Qpyjy+5OpjJ+EIf8UuKLQtDqPB
         2kzlxq2cz8vuISPIRouW9W5mhlWlXCRbJlDSMufka5ROUvrLLGjDYLXqzDYE+34V8wuF
         vF6/Yq1yHMhqX2iR1V5DX54JYmTFq/g2maTGLL42vMuwAoLZBsST/k/7KqSVP0oWpVuf
         Isvvo41GjnPIfzt20l1N646yEg8mUJ8GF6EVyLL0DyZAyEieGPWELTteHG/bpLPW9IC4
         C17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752818080; x=1753422880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1XKSPX7idvUf2IfcoWqYxvm95WhuWNRdajgbOdF1f8=;
        b=DNJcftstH9WC5Vvg30vTWgasiWKDdfqnEamhTw11lXhYaYB7ZLmyDoOT2IVJru+Wrn
         YiuSf9hYVNFNtVHHwr1m/sWs+u7EuhAecd29ufs4x5k1tuys3wukgdgLSAcrhAa+x02c
         54W//KIpW3F9YTvZieKOR2JLNTb/GM+MWnr89ftwHDIu4g8nLAfUTMFj5ys+K+9WIV7b
         azk6/6cCTc4BZWz7Q6GEt8I4Paa3JCLFrD3i83zu4ODiiX0klIkWSeHh1eIEJWnoO+KI
         /k+dCKRPvJ9i8FXlPFBj8TMZSiiLo+JijaLKXRVjRvXyrMyMZts1veja8ccBp9In183G
         1LOg==
X-Gm-Message-State: AOJu0YxjdAKSMPsAsaqhSBmd3bglBEKHvyMiV1sZO7IyNydE84uFIeZY
	oIUdsIWEnBK7ahX+TbT+2AwABwv6l4eqg2JHINY+1Wpv9lt5SEYZaWYWAiwLQSk9axwijBsfU1h
	cMlP3AajG+hwWbw6HTRewqG/wCxvu/H01+KwP
X-Gm-Gg: ASbGncub5X3LHO6j7BRF3tFIWqueYbSO6a1sqZ6EU1ho5IFADqeD2U376W5Xc/L/VUP
	XnLqX4wTgqHEvg1tYIa71zmOHJTqkHDyG64BixUpeJKDgwFfwg9z/TKdDpLc65/u2EbElBZFTfM
	9lSbHsQyUAxCxFXaBP5PcyE6h4aQt18hC5eCTO676BcomXhej1/e5/9o7yZtnipISpYOwhtR0j2
	ZPftqYXyWP0i61dTQTsCOtsUboNLBoqEGuAacTC
X-Google-Smtp-Source: AGHT+IEp7/MkPumknT5HxdfUXYvaldet5U/ha5TIuB7X+wHafdWR94sXYu6XekQbCXnsD1XzEjElkK2rx01wCltlKvQ=
X-Received: by 2002:a05:651c:4110:b0:32c:a097:415b with SMTP id
 38308e7fff4ca-3308e57f483mr25759841fa.34.1752818079512; Thu, 17 Jul 2025
 22:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPYq2E2V-sY9HcUOqCnz1hrHJmXSB0O2wHxFBeC62fjrMg+R4w@mail.gmail.com>
 <8dc2668f-9fa2-4a23-9735-36f7f2d520e8@harmstone.com>
In-Reply-To: <8dc2668f-9fa2-4a23-9735-36f7f2d520e8@harmstone.com>
From: PranshuTheGamer <12345qwertyman12345@gmail.com>
Date: Fri, 18 Jul 2025 08:54:27 +0300
X-Gm-Features: Ac12FXwYzQouMXSNGqbNM5DG5JHVLKdlLgn6fib-dGdSGcjqug4pTCYEttycvkQ
Message-ID: <CAPYq2E15fcswWQZz+nF+m_4Qdau1tFfwD-4LAWFCTbVhaVTZHQ@mail.gmail.com>
Subject: Re: [help me] corrupted filesystem, restoration methods exhausted.
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No, I haven't run an extended smart test. I've tried to but it keeps saying
# 1  Extended offline    Interrupted (host reset)      90%       270

Heres the full smartctl output:
> sudo smartctl -x -d sat /dev/sdb
smartctl 7.5 2025-04-30 r5714 [x86_64-linux-6.15.4-arch2-1] (local build)
Copyright (C) 2002-25, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD20SDRW-11VUUS1
Serial Number:    WD-WXG2A91798KJ
LU WWN Device Id: 5 0014ee 2bfb4790c
Firmware Version: 01.01A01
User Capacity:    2,000,365,379,584 bytes [2.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      2.5 inches
TRIM Command:     Available, deterministic
Device is:        Not in smartctl database 7.5/5706
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Jul 18 08:53:07 2025 +03
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     128 (minimum power consumption without standby)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, NOT FROZEN [SEC1], Master PW ID: 0xbbbb

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)    Offline data collection activity
                    was never started.
                    Auto Offline Data Collection: Disabled.
Self-test execution status:      (  41)    The self-test routine was interrupted
                    by the host with a hard or soft reset.
Total time to complete Offline
data collection:         (19200) seconds.
Offline data collection
capabilities:             (0x51) SMART execute Offline immediate.
                    No Auto Offline data collection support.
                    Suspend Offline collection upon new
                    command.
                    No Offline surface scan supported.
                    Self-test supported.
                    No Conveyance Self-test supported.
                    Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    General Purpose Logging supported.
Short self-test routine
recommended polling time:     (   2) minutes.
Extended self-test routine
recommended polling time:     ( 330) minutes.
SCT capabilities:           (0x7035)    SCT Status supported.
                    SCT Feature Control supported.
                    SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
  3 Spin_Up_Time            POS--K   192   187   021    -    3383
  4 Start_Stop_Count        -O--CK   100   100   000    -    260
  5 Reallocated_Sector_Ct   PO--CK   200   200   140    -    0
  7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
  9 Power_On_Hours          -O--CK   100   100   000    -    270
 10 Spin_Retry_Count        -O--CK   100   100   000    -    0
 11 Calibration_Retry_Count -O--CK   100   100   000    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    202
192 Power-Off_Retract_Count -O--CK   200   200   000    -    117
193 Load_Cycle_Count        -O--CK   199   199   000    -    3541
194 Temperature_Celsius     -O---K   106   094   000    -    41
196 Reallocated_Event_Count -O--CK   200   200   000    -    0
197 Current_Pending_Sector  -O--CK   200   200   000    -    0
198 Offline_Uncorrectable   ----CK   100   253   000    -    0
199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    0
200 Multi_Zone_Error_Rate   ---R--   100   253   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      5  Comprehensive SMART error log
0x03       GPL     R/O      6  Ext. Comprehensive SMART error log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x24       GPL     R/O    288  Current Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xa0-0xa7  GPL,SL  VS      16  Device vendor specific log
0xa8-0xb6  GPL,SL  VS       1  Device vendor specific log
0xb7       GPL,SL  VS      76  Device vendor specific log
0xb9       GPL,SL  VS       4  Device vendor specific log
0xbd       GPL,SL  VS       1  Device vendor specific log
0xc0       GPL,SL  VS       1  Device vendor specific log
0xc1       GPL     VS      93  Device vendor specific log
0xcf       GPL     VS   65535  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (6 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Interrupted (host reset)      90%       270         -
# 2  Short offline       Completed without error       00%       269         -
# 3  Extended offline    Aborted by host               90%       269         -
# 4  Extended offline    Aborted by host               90%       269         -
# 5  Extended offline    Interrupted (host reset)      90%       268         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       258 (0x0102)
Device State:                        Active (0)
Current Temperature:                    41 Celsius
Power Cycle Min/Max Temperature:     30/48 Celsius
Lifetime    Min/Max Temperature:     17/53 Celsius
Under/Over Temperature Limit Count:   0/0
Vendor specific:
01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/60 Celsius
Min/Max Temperature Limit:           -41/85 Celsius
Temperature History Size (Index):    128 (16)

Index    Estimated Time   Temperature Celsius
  17    2025-07-18 06:46    37  ******************
 ...    ..(  7 skipped).    ..  ******************
  25    2025-07-18 06:54    37  ******************
  26    2025-07-18 06:55    36  *****************
 ...    ..(  3 skipped).    ..  *****************
  30    2025-07-18 06:59    36  *****************
  31    2025-07-18 07:00    35  ****************
 ...    ..(  7 skipped).    ..  ****************
  39    2025-07-18 07:08    35  ****************
  40    2025-07-18 07:09    34  ***************
 ...    ..( 26 skipped).    ..  ***************
  67    2025-07-18 07:36    34  ***************
  68    2025-07-18 07:37    33  **************
 ...    ..( 15 skipped).    ..  **************
  84    2025-07-18 07:53    33  **************
  85    2025-07-18 07:54     ?  -
  86    2025-07-18 07:55    33  **************
  87    2025-07-18 07:56    34  ***************
  88    2025-07-18 07:57    35  ****************
  89    2025-07-18 07:58    38  *******************
  90    2025-07-18 07:59    37  ******************
  91    2025-07-18 08:00    39  ********************
  92    2025-07-18 08:01    39  ********************
  93    2025-07-18 08:02    39  ********************
  94    2025-07-18 08:03    38  *******************
  95    2025-07-18 08:04    38  *******************
  96    2025-07-18 08:05    37  ******************
  97    2025-07-18 08:06     ?  -
  98    2025-07-18 08:07    26  *******
  99    2025-07-18 08:08     ?  -
 100    2025-07-18 08:09    29  **********
 101    2025-07-18 08:10     ?  -
 102    2025-07-18 08:11    29  **********
 103    2025-07-18 08:12     ?  -
 104    2025-07-18 08:13    30  ***********
 105    2025-07-18 08:14    31  ************
 106    2025-07-18 08:15    34  ***************
 107    2025-07-18 08:16    35  ****************
 108    2025-07-18 08:17    36  *****************
 109    2025-07-18 08:18    37  ******************
 110    2025-07-18 08:19    38  *******************
 111    2025-07-18 08:20    39  ********************
 112    2025-07-18 08:21    40  *********************
 113    2025-07-18 08:22    41  **********************
 114    2025-07-18 08:23    41  **********************
 115    2025-07-18 08:24    42  ***********************
 116    2025-07-18 08:25    42  ***********************
 117    2025-07-18 08:26    43  ************************
 118    2025-07-18 08:27    43  ************************
 119    2025-07-18 08:28    44  *************************
 120    2025-07-18 08:29    44  *************************
 121    2025-07-18 08:30    45  **************************
 ...    ..(  2 skipped).    ..  **************************
 124    2025-07-18 08:33    45  **************************
 125    2025-07-18 08:34    46  ***************************
 126    2025-07-18 08:35    47  ****************************
 ...    ..(  4 skipped).    ..  ****************************
   3    2025-07-18 08:40    47  ****************************
   4    2025-07-18 08:41    48  *****************************
   5    2025-07-18 08:42    48  *****************************
   6    2025-07-18 08:43    48  *****************************
   7    2025-07-18 08:44    47  ****************************
   8    2025-07-18 08:45    45  **************************
   9    2025-07-18 08:46    44  *************************
  10    2025-07-18 08:47    43  ************************
  11    2025-07-18 08:48    42  ***********************
  12    2025-07-18 08:49    41  **********************
  13    2025-07-18 08:50     ?  -
  14    2025-07-18 08:51    41  **********************
  15    2025-07-18 08:52    41  **********************
  16    2025-07-18 08:53    41  **********************

SCT Error Recovery Control command not supported

Device Statistics (GP/SMART Log 0x04) not supported

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2            1  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2            2  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS
0x000f  2            0  R_ERR response for host-to-device data FIS, CRC
0x0012  2            0  R_ERR response for host-to-device non-data FIS, CRC
0x8000  4         2348  Vendor specific


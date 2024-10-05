Return-Path: <linux-btrfs+bounces-8571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DBC9916E9
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7EFB214F0
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD914E2DA;
	Sat,  5 Oct 2024 13:01:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94842F2A
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Oct 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728133295; cv=none; b=SS+qsbDTdkT22TBGsT/S/xwpH0DXicpbC3wuZU6LjVx5uRWwLXtjZvYmQEPveWw/pneiXZ66qjNEOHDiXTj0mhDBS12alofmH4jNJc00WTDtz5otZnlG67Z5V2y5i2q3HVCsWbsBjANeDLEogxj5C8HnWG7zkrhN/cyLzQnfYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728133295; c=relaxed/simple;
	bh=G5ZGYKQSmmI8sWgMVkohWdEvnOQ/8Q+vQexKtnVHF5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OmoUo2zkD2vq7rKNno0e5kDu6/N5CVwsRuPi8U9NucbYGW3MYKFkdeeULaJiM+wvBLP8YmfC69baY/oZYsBHD4VlcX9VYD9BpmZpFYF9gN/U6f95haRe/gURkT4uMyLiOLVe55czgmZaa4ddsmol8pBi/VQp8UTDA+h7A4RgX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 65DC2C0C4F7;
	Sat,  5 Oct 2024 15:01:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id clZEZ2LdZYq2; Sat,  5 Oct 2024 15:01:15 +0200 (CEST)
Received: from [192.168.55.110] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id A77EAC0C448;
	Sat,  5 Oct 2024 15:01:15 +0200 (CEST)
Message-ID: <5753f20c-4b2d-4f21-8e5a-6e58acdaf488@dubiel.pl>
Date: Sat, 5 Oct 2024 15:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Bytes_scrubbed_=E2=80=94_more_than_100=25?=
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <03362532-cf30-4f02-b5fc-f1a5cc5f5a53@dubiel.pl>
 <0600035f-ef46-4b2d-af68-557541aeeb15@gmx.com>
 <c59b8d64-e9dc-4cf5-94f4-554f9f05d797@dubiel.pl>
 <34787783-dfb8-4505-848d-ed31913cc478@gmx.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <34787783-dfb8-4505-848d-ed31913cc478@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



W dniu 30.09.2024 o 12:25, Qu Wenruo pisze:
>
> Unfortunately we need the full output without interruption.
>
> And I didn't notice there are 4 devices involved, in that case, if you
> are able to run the command again:
>
> # btrfs scrub start -BdR <mnt>




Here is output of command:




root@wawel:~/scrub-blad-100%/watch# btrfs fi show /
Label: none  uuid: 44803366-3981-4ebb-853b-6c991380c8a6
     Total devices 4 FS bytes used 12.04TiB
     devid    2 size 5.45TiB used 5.38TiB path /dev/sdc2
     devid    3 size 5.45TiB used 5.37TiB path /dev/sdd2
     devid    4 size 10.90TiB used 10.78TiB path /dev/sdb3
     devid    6 size 5.43TiB used 5.39TiB path /dev/sda3







root@wawel:~/scrub-blad-100%/watch# btrfs fi usage /
Overall:
     Device size:          27.22TiB
     Device allocated:          26.92TiB
     Device unallocated:         316.89GiB
     Device missing:             0.00B
     Device slack:           7.00KiB
     Used:              24.09TiB
     Free (estimated):           1.45TiB    (min: 1.45TiB)
     Free (statfs, df):           1.41TiB
     Data ratio:                  2.00
     Metadata ratio:              2.00
     Global reserve:         512.00MiB    (used: 0.00B)
     Multiple profiles:                no

Data,RAID1: Size:13.31TiB, Used:12.02TiB (90.29%)
    /dev/sdc2       5.30TiB
    /dev/sdd2       5.30TiB
    /dev/sdb3      10.63TiB
    /dev/sda3       5.39TiB

Metadata,RAID1: Size:151.00GiB, Used:27.41GiB (18.15%)
    /dev/sdc2      79.00GiB
    /dev/sdd2      77.00GiB
    /dev/sdb3     146.00GiB

System,RAID1: Size:64.00MiB, Used:2.42MiB (3.78%)
    /dev/sdd2      32.00MiB
    /dev/sdb3      64.00MiB
    /dev/sda3      32.00MiB

Unallocated:
    /dev/sdc2      75.03GiB
    /dev/sdd2      77.03GiB
    /dev/sdb3     124.00GiB
    /dev/sda3      40.83GiB






root@wawel:~/scrub-blad-100%/watch# btrfs dev usage /
/dev/sdc2, ID: 2
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              5.30TiB
    Metadata,RAID1:         79.00GiB
    Unallocated:            75.03GiB

/dev/sdd2, ID: 3
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              5.30TiB
    Metadata,RAID1:         77.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            77.03GiB

/dev/sdb3, ID: 4
    Device size:            10.90TiB
    Device slack:            3.50KiB
    Data,RAID1:             10.63TiB
    Metadata,RAID1:        146.00GiB
    System,RAID1:           64.00MiB
    Unallocated:           124.00GiB

/dev/sda3, ID: 6
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.39TiB
    System,RAID1:           32.00MiB
    Unallocated:            40.83GiB









# btrfs scrub start -BdR <mnt>



Starting scrub on devid 3
Starting scrub on devid 4
Starting scrub on devid 6

Scrub device /dev/sdc2 (id 2) done
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         12:47:10
     data_extents_scrubbed: 82439875
     tree_extents_scrubbed: 940825
     data_bytes_scrubbed: 5213978984448
     tree_bytes_scrubbed: 15414476800
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 1763746
     csum_discards: 1271180342
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 5992192409600

Scrub device /dev/sdd2 (id 3) done
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         13:13:41
     data_extents_scrubbed: 82972022
     tree_extents_scrubbed: 949560
     data_bytes_scrubbed: 5220045656064
     tree_bytes_scrubbed: 15557591040
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 1675697
     csum_discards: 1272749512
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 5991547535360

Scrub device /dev/sdb3 (id 4) done
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
     data_extents_scrubbed: 165926830
     tree_extents_scrubbed: 1673427
     data_bytes_scrubbed: 10468050702336
     tree_bytes_scrubbed: 27417427968
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 3446359
     csum_discards: 2552230082
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 11983494512640

Scrub device /dev/sda3 (id 6) done
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         13:21:57
     data_extents_scrubbed: 85544855
     tree_extents_scrubbed: 155
     data_bytes_scrubbed: 5605891260416
     tree_bytes_scrubbed: 2539520
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 402
     csum_discards: 1368625394
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 5965777731584










watching    btrfs scrub status /

overt 100% scrubbed:


sob, 5 paź 2024, 14:08:29 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:18
Time left:        15229440:44:56
ETA:              Tue Feb 16 13:53:25 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.17%)
Rate:             320.87MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:32 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:21
Time left:        15229823:03:22
ETA:              Thu Mar  4 12:11:54 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.86MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:35 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:24
Time left:        15230230:08:39
ETA:              Sun Mar 21 11:17:14 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.86MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:38 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:27
Time left:        15230614:34:24
ETA:              Tue Apr  6 12:43:02 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.85MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:41 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:30
Time left:        15231018:23:56
ETA:              Fri Apr 23 08:32:37 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.84MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:44 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:33
Time left:        15231410:44:45
ETA:              Sun May  9 16:53:29 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.83MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:47 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:36
Time left:        15231792:33:47
ETA:              Tue May 25 14:42:34 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.82MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:50 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:39
Time left:        15232182:52:01
ETA:              Thu Jun 10 21:00:51 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.81MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:53 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:42
Time left:        15232590:07:36
ETA:              Sun Jun 27 20:16:29 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.81MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:56 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:45
Time left:        15232968:44:33
ETA:              Tue Jul 13 14:53:29 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.18%)
Rate:             320.80MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:08:59 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:48
Time left:        15233347:47:06
ETA:              Thu Jul 29 09:56:05 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.19%)
Rate:             320.79MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:02 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:51
Time left:        15233736:51:19
ETA:              Sat Aug 14 15:00:21 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.19%)
Rate:             320.78MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:05 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:54
Time left:        15234122:05:44
ETA:              Mon Aug 30 16:14:49 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.19%)
Rate:             320.77MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:08 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:54:57
Time left:        15234533:04:57
ETA:              Thu Sep 16 19:14:05 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.19%)
Rate:             320.77MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:11 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:00
Time left:        15234930:11:07
ETA:              Sun Oct  3 08:20:18 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.19%)
Rate:             320.76MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:14 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:03
Time left:        15235309:54:51
ETA:              Tue Oct 19 04:04:05 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.13TiB  (100.19%)
Rate:             320.75MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:17 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:06
Time left:        15235713:32:09
ETA:              Thu Nov  4 22:41:26 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.19%)
Rate:             320.74MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:20 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:09
Time left:        15236092:37:27
ETA:              Sat Nov 20 17:46:47 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.19%)
Rate:             320.73MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:23 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:12
Time left:        15236468:44:29
ETA:              Mon Dec  6 09:53:52 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.72MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:26 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:15
Time left:        15236863:35:21
ETA:              Wed Dec 22 20:44:47 3762
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.72MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:29 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:18
Time left:        15237234:34:44
ETA:              Fri Jan  7 07:44:13 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.71MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:32 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:21
Time left:        15237611:20:30
ETA:              Sun Jan 23 00:30:02 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.70MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:35 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:24
Time left:        15237999:24:22
ETA:              Tue Feb  8 04:33:57 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.69MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:38 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:27
Time left:        15238371:16:01
ETA:              Wed Feb 23 16:25:39 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.68MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:41 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:30
Time left:        15238751:45:24
ETA:              Fri Mar 11 12:55:05 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.20%)
Rate:             320.68MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:44 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:33
Time left:        15239129:32:45
ETA:              Sun Mar 27 07:42:29 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.67MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:47 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:36
Time left:        15239510:45:12
ETA:              Tue Apr 12 04:54:59 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.66MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:50 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:39
Time left:        15239886:05:14
ETA:              Wed Apr 27 20:15:04 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.65MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:53 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:42
Time left:        15240264:31:20
ETA:              Fri May 13 14:41:13 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.64MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:56 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:45
Time left:        15240730:33:17
ETA:              Thu Jun  2 00:43:13 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.63MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:09:59 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:48
Time left:        15241118:30:22
ETA:              Sat Jun 18 04:40:21 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.63MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:02 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:51
Time left:        15241519:53:48
ETA:              Mon Jul  4 22:03:50 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.62MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:05 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:54
Time left:        15241921:29:23
ETA:              Thu Jul 21 15:39:28 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.61MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:08 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:55:57
Time left:        15242339:28:19
ETA:              Mon Aug  8 01:38:27 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.21%)
Rate:             320.60MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:11 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:00
Time left:        15242748:24:30
ETA:              Thu Aug 25 02:34:41 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.59MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:14 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:03
Time left:        15243137:49:23
ETA:              Sat Sep 10 07:59:37 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.58MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:17 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:06
Time left:        15243509:31:35
ETA:              Sun Sep 25 19:41:52 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.58MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:20 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:09
Time left:        15243894:21:15
ETA:              Tue Oct 11 20:31:35 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.57MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:23 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:12
Time left:        15244266:38:20
ETA:              Thu Oct 27 08:48:43 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.56MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:26 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:15
Time left:        15244653:38:12
ETA:              Sat Nov 12 10:48:38 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.55MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:29 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:18
Time left:        15245142:56:01
ETA:              Fri Dec  2 20:06:30 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.54MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:32 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:21
Time left:        15245528:26:01
ETA:              Sun Dec 18 21:36:33 3763
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.22%)
Rate:             320.53MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:35 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:24
Time left:        15245915:27:00
ETA:              Wed Jan  4 00:37:35 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.23%)
Rate:             320.53MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:38 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:27
Time left:        15246300:26:40
ETA:              Fri Jan 20 01:37:18 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.23%)
Rate:             320.52MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:41 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:30
Time left:        15246674:04:18
ETA:              Sat Feb  4 15:14:59 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.23%)
Rate:             320.51MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:44 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:33
Time left:        15247044:32:28
ETA:              Mon Feb 20 01:43:12 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.23%)
Rate:             320.50MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:47 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:36
Time left:        15247421:58:14
ETA:              Tue Mar  6 19:09:01 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.23%)
Rate:             320.49MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:50 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:39
Time left:        15247806:02:35
ETA:              Thu Mar 22 19:13:25 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.14TiB  (100.23%)
Rate:             320.49MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:53 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:42
Time left:        15248197:37:19
ETA:              Sun Apr  8 03:48:12 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.23%)
Rate:             320.48MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:56 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:45
Time left:        15248569:31:37
ETA:              Mon Apr 23 15:42:33 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.23%)
Rate:             320.47MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:10:59 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:48
Time left:        15248938:24:34
ETA:              Wed May  9 00:35:33 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.46MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:02 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:51
Time left:        15249369:07:14
ETA:              Sat May 26 23:18:16 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.45MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:05 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:54
Time left:        15249771:37:36
ETA:              Tue Jun 12 17:48:41 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.45MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:08 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:56:57
Time left:        15250152:00:18
ETA:              Thu Jun 28 14:11:26 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.44MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:11 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:00
Time left:        15250525:24:44
ETA:              Sat Jul 14 03:35:55 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.43MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:14 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:03
Time left:        15250905:00:41
ETA:              Sun Jul 29 23:11:55 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.42MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:17 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:06
Time left:        15251272:49:36
ETA:              Tue Aug 14 07:00:53 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.41MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:20 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:09
Time left:        15251651:11:30
ETA:              Thu Aug 30 01:22:50 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.24%)
Rate:             320.41MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:23 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:12
Time left:        15252040:31:00
ETA:              Sat Sep 15 06:42:23 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.40MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:26 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:15
Time left:        15252407:39:37
ETA:              Sun Sep 30 13:51:03 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.39MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:29 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:18
Time left:        15252786:53:56
ETA:              Tue Oct 16 09:05:25 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.38MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:32 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:21
Time left:        15253197:20:59
ETA:              Fri Nov  2 10:32:31 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.37MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:35 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:24
Time left:        15253599:11:42
ETA:              Mon Nov 19 04:23:17 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.36MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:38 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:27
Time left:        15253994:09:34
ETA:              Wed Dec  5 15:21:12 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.36MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:41 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:30
Time left:        15254362:56:29
ETA:              Fri Dec 21 00:08:10 3764
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.25%)
Rate:             320.35MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:44 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:33
Time left:        15254741:03:03
ETA:              Sat Jan  5 18:14:47 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.34MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:47 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:36
Time left:        15255121:13:23
ETA:              Mon Jan 21 14:25:10 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.33MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:50 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:39
Time left:        15255499:57:39
ETA:              Wed Feb  6 09:09:29 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.32MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:53 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:42
Time left:        15255880:34:46
ETA:              Fri Feb 22 05:46:39 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.32MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:56 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:45
Time left:        15256266:59:10
ETA:              Sun Mar 10 08:11:06 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.31MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:11:59 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:48
Time left:        15256661:35:20
ETA:              Tue Mar 26 18:47:19 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.30MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:02 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:51
Time left:        15257068:15:02
ETA:              Fri Apr 12 18:27:04 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.29MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:05 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:54
Time left:        15257448:43:13
ETA:              Sun Apr 28 14:55:18 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.26%)
Rate:             320.28MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:08 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:57:57
Time left:        15257837:09:36
ETA:              Tue May 14 19:21:44 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.28MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:11 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:00
Time left:        15258222:09:58
ETA:              Thu May 30 20:22:09 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.27MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:14 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:03
Time left:        15258593:36:22
ETA:              Sat Jun 15 07:48:36 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.26MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:17 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:06
Time left:        15258958:39:26
ETA:              Sun Jun 30 12:51:43 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.25MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:20 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:09
Time left:        15259347:32:14
ETA:              Tue Jul 16 17:44:34 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.24MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:23 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:12
Time left:        15259719:56:27
ETA:              Thu Aug  1 06:08:50 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.24MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:26 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:15
Time left:        15260187:26:12
ETA:              Tue Aug 20 17:38:38 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.23MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:29 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:18
Time left:        15260683:49:19
ETA:              Tue Sep 10 10:01:48 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.15TiB  (100.27%)
Rate:             320.22MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:32 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:21
Time left:        15261110:17:16
ETA:              Sat Sep 28 04:29:48 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.27%)
Rate:             320.21MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:35 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:24
Time left:        15261549:41:13
ETA:              Wed Oct 16 11:53:48 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.27%)
Rate:             320.20MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:38 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:27
Time left:        15261915:33:41
ETA:              Thu Oct 31 16:46:19 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.19MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:41 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:30
Time left:        15262294:02:44
ETA:              Sat Nov 16 11:15:25 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.18MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:44 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:33
Time left:        15262670:13:48
ETA:              Mon Dec  2 03:26:32 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.17MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:47 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:36
Time left:        15263055:06:59
ETA:              Wed Dec 18 04:19:46 3765
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.17MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:50 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:39
Time left:        15263438:36:47
ETA:              Fri Jan  3 03:49:37 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.16MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:53 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:42
Time left:        15263805:15:36
ETA:              Sat Jan 18 10:28:29 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.15MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:12:56 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:46
Time left:        15264369:51:36
ETA:              Mon Feb 10 23:04:32 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.28%)
Rate:             320.14MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:00 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:49
Time left:        15264764:28:22
ETA:              Thu Feb 27 09:41:22 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.13MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:03 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:52
Time left:        15265153:25:17
ETA:              Sat Mar 15 14:38:20 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.12MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:06 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:55
Time left:        15265564:43:12
ETA:              Tue Apr  1 18:56:18 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.11MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:09 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:58:58
Time left:        15265956:56:18
ETA:              Fri Apr 18 03:09:27 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.11MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:12 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:01
Time left:        15266357:35:30
ETA:              Sun May  4 19:48:42 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.10MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:15 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:04
Time left:        15266745:48:10
ETA:              Wed May 21 00:01:25 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.09MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:18 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:07
Time left:        15267137:07:36
ETA:              Fri Jun  6 07:20:54 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.08MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:21 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:10
Time left:        15267507:51:49
ETA:              Sat Jun 21 18:05:10 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.29%)
Rate:             320.07MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:24 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:13
Time left:        15267878:04:21
ETA:              Mon Jul  7 04:17:45 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.30%)
Rate:             320.06MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:27 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:16
Time left:        15268255:29:16
ETA:              Tue Jul 22 21:42:43 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.30%)
Rate:             320.06MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:30 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:19
Time left:        15268645:17:48
ETA:              Fri Aug  8 03:31:18 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.30%)
Rate:             320.05MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:33 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:22
Time left:        15269014:14:29
ETA:              Sat Aug 23 12:28:02 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.30%)
Rate:             320.04MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:36 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           running
Duration:         21:59:25
Time left:        15269420:39:06
ETA:              Tue Sep  9 10:52:42 3766
Total to scrub:   24.09TiB
Bytes scrubbed:   24.16TiB  (100.30%)
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:39 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:42 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:45 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:48 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:51 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:54 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:13:57 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:00 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:03 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:06 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:09 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:12 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:15 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:18 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:21 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:24 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found



sob, 5 paź 2024, 14:14:27 CEST
UUID:             44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Fri Oct  4 16:14:11 2024
Status:           finished
Duration:         21:59:27
Total to scrub:   24.09TiB
Rate:             320.03MiB/s (some device limits set)
Error summary:    no errors found
























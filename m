Return-Path: <linux-btrfs+bounces-11214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D87A25138
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 03:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1607A1D09
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279C179BD;
	Mon,  3 Feb 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Jq2I2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66AA923
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738549160; cv=none; b=hvBF3O2asE23QNHvzViFbim6NslyfK4on26S58FDMNRxBAs6BUxaFmcjMRe3bXiBXZ2zIZlnQxRUudP6/PrvkHlIW7pmrdt9W0C0dE2Jqkw/BrNfc+7nvUYc9iVChVouJyv584AxE+jRblvUOTBEHRXJVjJR7D9Is0IhzsnIMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738549160; c=relaxed/simple;
	bh=s7qeXi8KgiDAVC214AFvwtl4RzNS+6REIRviifJNRe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NNBxz8kYXfAsrcGjWRgbwxBycg/ur5lmXTrr9jm5MIStGQJqvV52g1VZtTKn/GL2TKo4WiLKxLQWrnZe1DeZjT1nNg4F6BKmRN/gab6nMXMF7LldoCZcDlxJcQmtNj7uHk2tILShsEAjcXM1q/yhNn4iKEUzlGFke0TvkguOr3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7Jq2I2e; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401e6efffcso4073095e87.3
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2025 18:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738549157; x=1739153957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSnKZqGz/aYrex4I50mWqu34yl22uWPwkFtsFzU14jE=;
        b=O7Jq2I2e6BUNZdHg61d+VmFRVzIGig8Ms5g1Xpc90YEIfGx96iLTMakKE/E3LQuIlC
         mCS0RwE+NXFODLcZalVM6x7t7QVekZcLl9JBYujWoQV2N3Z8DNWLd2SWGRMY2Y/DMoV6
         hd3TeW0T67OUC8xLWkzv07Ux4acEfjV8kw65ZYUIzDEXOqSm1CDDa7HIN30HE3mr02Nn
         NiXBPKwvXhjF9aoPQnvlI5t9B87KzmIxyypNVFK/UXy3kZBNhzg6e+aRQ7Bw4oXHcOO9
         r5TNf1vfis0YKeHUIBe5ZuytHvtDrpL0p/rhugI4Hj+HLTB7ctukZoWhnisRMaIHGDgZ
         JjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738549157; x=1739153957;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSnKZqGz/aYrex4I50mWqu34yl22uWPwkFtsFzU14jE=;
        b=GQ9WvecYa89Nir+XiMURGk18v7y1ql76zIhlDf7sMVWBiEg1gZkr7Cn9Tw1AMVRBbD
         cYDIbvJiJ7vn/kXuXs6ty9hDox20FNbKe12giVr4w7iMtueOlfVHi0mvADCKsw7srgcZ
         pQBJ++4qcqQMPlx3o9bZT9WsZk1i/WtFB2y0/oPE0DSaxxPldKLNG2Ept59wwviEas3O
         rfKFfKout1GwhafVQU4Sz8oHYAoy3Qd11yyUOSCyL5u0md6+TLgIQ+po/QBuoM32D/YU
         QmcMYnainGGAuHOQaHOC7XFcaTDrwllc7E7r4JPPJbPL4WQ9BsSax1WWlforiOz2OZjZ
         /g5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvG7oSWb8dorgGy1oWbzB2mtKoWsNure0PptynCNW49R58Sg+R+3TFFrkLkzR/IhJ9cG5SnZj1kYW0jA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6FDsoUOODe2uxXXXhdDEwB0rLo6QsLg3BDGfbPw+4nhiw0Rk
	w4rQydEsefSPXpu9SLr06xXQnV8g9Cr/cZLCQQ+A9jeCo6kPR6/L
X-Gm-Gg: ASbGnctszj+dMtaqyBDRJU7Oyiu57XzGDgrom9xq/7Wf3nvgxBpL0U+v0k8jC/1v6Fm
	Tg9kIoWiysBNY/DqRLnxbedD3znWw3BfiCk0BYjGiG/Izy96tPzInDPMWOrZtw8CFd+Ce197LKz
	LW31zfL2pxGTyZSdDJAMFc1+A1Z0hwbGb5Azqr5kL/rcQ9xJt/EswEYQHi3cx8hCegOx5qJdhqc
	jvK6IHcAK/HxzTNVQlpiulJiuN9oXlrzPVvNsEWW0SOfNuvaJJG7FBTj7TO1NTMO2e2td78z+bC
	7oqW1us/P4QbN7vYxlR763w=
X-Google-Smtp-Source: AGHT+IEoLoe2mercqZ0WZJ7vuMIEHGhwUuIzUytotofdZWk5Np3Q8HULrxkliFn33LL3eui1azpBsA==
X-Received: by 2002:ac2:4943:0:b0:543:bb21:4255 with SMTP id 2adb3069b0e04-543e4c417e6mr5765501e87.49.1738549156306;
        Sun, 02 Feb 2025 18:19:16 -0800 (PST)
Received: from [10.0.3.208] ([83.146.185.102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb7893sm1152649e87.177.2025.02.02.18.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 18:19:14 -0800 (PST)
Message-ID: <92dbe939-46a6-4142-b6be-3ef69fffce1b@gmail.com>
Date: Mon, 3 Feb 2025 04:19:13 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Jeff Siddall <news@siddall.name>,
 linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
 <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
From: Jussi Kansanen <jussi.kansanen@gmail.com>
In-Reply-To: <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/3/25 02:44, Qu Wenruo wrote:
> 
> 
> 在 2025/2/3 09:13, Jeff Siddall 写道:
>> After a device failed on RAID1 filesystem, an attempt to convert the
>> online filesystem from RAID1 to single failed.  This isn't an uncommon
>> use case if the failed device isn't readily replaceable.
>>
>> The command ran was:
>>
>> btrfs balance start -f -sconvert=single -mconvert=single -
>> dconvert=single /mountpoint
>>
>> and the kernel logs were:
>>
>> kernel: BTRFS info (device nvme0n1p3): balance: start -dconvert=single -
>> mconvert=dup -sconvert=dup
>> kernel: BTRFS info (device nvme0n1p3): relocating block group
>> 1222049267712 flags data|raid1
>> kernel: BTRFS warning (device nvme0n1p3): chunk 1223123009536 missing 1
>> devices, max tolerance is 0 for writable mount
> 
> This is not the chunk to be relocated. Considering the tolerance is only
> 0, meaning it's the newly created single chunk.
> 
> I tried locally, but failed to reproduce the same problem.
> 
> Mind to provide the following info:
> 
> - Kernel version
> - Btrfs fi usage output
> - Mount option of the fs
> 
> My major concern is, the failing devices is still considered online, but
> will fail all read/write/flush commands.
> (Btrfs only has read time repair, not failing device detection)
> 
> In that case, converting to single is the worst thing you can do, as it
> will write metadata chunks into that failing devices, and lost everything.
> 
> The proper solution is to unmount the fs (if possible), remove the
> failing device, then mount the fs in degraded mode, add replace the
> missing device with a newer one.
> 
> Thanks,
> Qu
> 
>> kernel: BTRFS: error (device nvme0n1p3) in write_all_supers:4370:
>> errno=-5 IO failure (errors while submitting device barriers.)
>> kernel: BTRFS info (device nvme0n1p3: state E): forced readonly
>> kernel: BTRFS warning (device nvme0n1p3: state E): Skipping commit of
>> aborted transaction.
>> kernel: BTRFS: error (device nvme0n1p3: state EA) in
>> cleanup_transaction:1992: errno=-5 IO failure
>> kernel: BTRFS info (device nvme0n1p3: state EA): balance: ended with
>> status: -5
>>
>> Either it should be made possible to convert a RAID1 device with a
>> missing device to a single device filesystem without errors, or the
>> command should return a message stating that it is not supported to
>> convert RAID1 array with missing devices to a single.  Having the
>> process fail and then going forced readonly is a significant failure on
>> an otherwise working system.
>>
>>
>>
> 
> 

Hi, here's a reproducer for similar issue that Jeff had:

debian:/mnt# uname -a
Linux debian 6.12.11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.11-1 (2025-01-25) 
x86_64 GNU/Linux

debian:/mnt# findmnt .
TARGET SOURCE   FSTYPE OPTIONS
/mnt   /dev/sdd btrfs  rw,relatime,space_cache=v2,subvolid=5,subvol=/

debian:/mnt# btrfs fi usage .
Overall:
     Device size:		  16.00GiB
     Device allocated:		   4.52GiB
     Device unallocated:		  11.48GiB
     Device missing:		     0.00B
     Device slack:		     0.00B
     Used:			   2.00GiB
     Free (estimated):		   6.74GiB	(min: 6.74GiB)
     Free (statfs, df):		   6.74GiB
     Data ratio:			      2.00
     Metadata ratio:		      2.00
     Global reserve:		   5.50MiB	(used: 0.00B)
     Multiple profiles:		        no

Data,RAID1: Size:2.00GiB, Used:1.00GiB (50.05%)
    /dev/sdd	   2.00GiB
    /dev/sde	   2.00GiB

Metadata,RAID1: Size:256.00MiB, Used:1.14MiB (0.45%)
    /dev/sdd	 256.00MiB
    /dev/sde	 256.00MiB

System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
    /dev/sdd	   8.00MiB
    /dev/sde	   8.00MiB

Unallocated:
    /dev/sdd	   5.74GiB
    /dev/sde	   5.74GiB


debian:/mnt# echo 1 > /sys/block/sde/device/delete

debian:/mnt# btrfs balance start -mconvert=dup -dconvert=single .
ERROR: error during balancing '.': Input/output error
There may be more info in syslog - try dmesg | tail

debian:/mnt# dmesg | tail -35
[  582.117314] BTRFS info (device sdd): first mount of filesystem 
d4b36ef9-3518-43a6-bc68-a2b4df751896
[  582.117329] BTRFS info (device sdd): using crc32c (crc32c-intel) checksum 
algorithm
[  582.117333] BTRFS info (device sdd): using free-space-tree
[  582.119952] BTRFS info (device sdd): checking UUID tree
[  979.011795] sd 6:0:0:0: [sde] Synchronizing SCSI cache
[  979.013096] ata7.00: Entering standby power mode
[ 1002.726249] btrfs: attempt to access beyond end of device
                sde: rw=6145, sector=21696, nr_sectors = 32 limit=0
[ 1002.726274] btrfs: attempt to access beyond end of device
                sde: rw=6145, sector=21728, nr_sectors = 32 limit=0
[ 1002.726281] btrfs: attempt to access beyond end of device
                sde: rw=6145, sector=21760, nr_sectors = 32 limit=0
[ 1002.726442] BTRFS error (device sdd): bdev /dev/sde errs: wr 1, rd 0, flush 
0, corrupt 0, gen 0
[ 1002.726501] BTRFS error (device sdd): bdev /dev/sde errs: wr 2, rd 0, flush 
0, corrupt 0, gen 0
[ 1002.726534] BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 
0, corrupt 0, gen 0
[ 1002.726659] BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 
1, corrupt 0, gen 0
[ 1002.726692] btrfs: attempt to access beyond end of device
                sde: rw=145409, sector=128, nr_sectors = 8 limit=0
[ 1002.726702] BTRFS warning (device sdd): lost super block write due to IO 
error on /dev/sde (-5)
[ 1002.726704] BTRFS error (device sdd): bdev /dev/sde errs: wr 4, rd 0, flush 
1, corrupt 0, gen 0
[ 1002.726728] btrfs: attempt to access beyond end of device
                sde: rw=14337, sector=131072, nr_sectors = 8 limit=0
[ 1002.726733] BTRFS warning (device sdd): lost super block write due to IO 
error on /dev/sde (-5)
[ 1002.726737] BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 
1, corrupt 0, gen 0
[ 1002.726835] BTRFS error (device sdd): error writing primary super block to 
device 2
[ 1002.726844] BTRFS info (device sdd): balance: start -dconvert=single 
-mconvert=dup -sconvert=dup
[ 1002.726990] BTRFS info (device sdd): relocating block group 1372585984 flags 
data|raid1
[ 1002.727811] BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 
2, corrupt 0, gen 0
[ 1002.727816] BTRFS warning (device sdd): chunk 2446327808 missing 1 devices, 
max tolerance is 0 for writable mount
[ 1002.727818] BTRFS: error (device sdd) in write_all_supers:4044: errno=-5 IO 
failure (errors while submitting device barriers.)
[ 1002.727821] BTRFS info (device sdd state E): forced readonly
[ 1002.727823] BTRFS warning (device sdd state E): Skipping commit of aborted 
transaction.
[ 1002.727824] BTRFS error (device sdd state EA): Transaction aborted (error -5)
[ 1002.727826] BTRFS: error (device sdd state EA) in cleanup_transaction:2017: 
errno=-5 IO failure
[ 1002.727838] BTRFS info (device sdd state EA): balance: ended with status: -5

debian:~# umount /mnt

debian:~# btrfs fi show
warning, device 2 is missing
Label: none  uuid: d4b36ef9-3518-43a6-bc68-a2b4df751896
	Total devices 2 FS bytes used 1.00GiB
	devid    1 size 8.00GiB used 2.26GiB path /dev/sdd
	*** Some devices missing

mount -odegraded /dev/sdd /mnt

debian:~# dmesg | tail -15
[ 1332.628959] BTRFS info (device sdd): first mount of filesystem 
d4b36ef9-3518-43a6-bc68-a2b4df751896
[ 1332.628974] BTRFS info (device sdd): using crc32c (crc32c-intel) checksum 
algorithm
[ 1332.628978] BTRFS info (device sdd): using free-space-tree
[ 1332.630281] BTRFS warning (device sdd): devid 2 uuid 
0afd8d45-96d6-4393-b7ce-e55abd4b668e is missing
[ 1332.632964] BTRFS info (device sdd): balance: resume -dconvert=single,soft 
-mconvert=dup,soft -sconvert=dup,soft
[ 1332.633041] BTRFS info (device sdd): relocating block group 1372585984 flags 
data|raid1
[ 1332.638220] BTRFS info (device sdd): found 1 extents, stage: move data extents
[ 1332.640073] BTRFS info (device sdd): found 1 extents, stage: update data pointers
[ 1332.641350] BTRFS info (device sdd): relocating block group 298844160 flags 
data|raid1
[ 1333.991088] BTRFS info (device sdd): found 8 extents, stage: move data extents
[ 1333.994336] BTRFS info (device sdd): found 8 extents, stage: update data pointers
[ 1333.997220] BTRFS info (device sdd): relocating block group 30408704 flags 
metadata|raid1
[ 1333.998489] BTRFS info (device sdd): found 1 extents, stage: move data extents
[ 1333.999617] BTRFS info (device sdd): relocating block group 22020096 flags 
system|raid1
[ 1334.000838] BTRFS info (device sdd): balance: ended with status: 0

debian:/mnt# btrfs fi usage .
Overall:
     Device size:		  16.00GiB
     Device allocated:		   3.00GiB
     Device unallocated:		  13.00GiB
     Device missing:		   8.00GiB
     Device slack:		     0.00B
     Used:			   1.00GiB
     Free (estimated):		  14.44GiB	(min: 7.94GiB)
     Free (statfs, df):		   6.44GiB
     Data ratio:			      1.00
     Metadata ratio:		      2.00
     Global reserve:		   5.50MiB	(used: 0.00B)
     Multiple profiles:		        no

Data,single: Size:2.44GiB, Used:1.00GiB (41.07%)
    /dev/sdd	   2.44GiB

Metadata,DUP: Size:256.00MiB, Used:1.17MiB (0.46%)
    /dev/sdd	 512.00MiB

System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
    /dev/sdd	  64.00MiB

Unallocated:
    /dev/sdd	   5.00GiB
    <missing disk>	   8.00GiB

debian:/mnt# btrfs device remove missing .

debian:/mnt# dmesg | tail -1
[ 1714.116147] BTRFS info (device sdd): device deleted: missing




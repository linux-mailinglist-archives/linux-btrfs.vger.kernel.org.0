Return-Path: <linux-btrfs+bounces-474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32B801492
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9273BB20ECB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908735787D;
	Fri,  1 Dec 2023 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcF2f23m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E63F1
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:36:39 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58d533268e6so1475169eaf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701462998; x=1702067798; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDm/XpRaY3b9nS+d0nNFT+XCSC8JIVEOGJh1j028wmQ=;
        b=DcF2f23mQIiZboX87cuBDlT0BQxzsxVyC7YPTPEgr1Q52Ortbwpm04JuDDSmmT1bRb
         UgEw1uOWf+IWBY/XFqLumqK1h7LsGbeA6UFnOJyzkAvuUTGGV0vSnAWt9TOjfuVi2bml
         BxXiJ5FxRI0GMMt+i9SQbTbn0G9/nGEL/piZ4s4QkKNOOIOYxp+l57anjcmmV8PB+331
         0LIiMsDvNoPPITMiKMLevrjTnBwyy4hKCFg969at4SNG97XTcJCEQH/RGTTvY3Ur8Gkj
         2AEcP8uOAnmQOu8+AWrzYJ2iFmaTpypTyaNAlR/E/PSVdPp8mVR9jPCN3f5r5foxt2Ri
         az/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462998; x=1702067798;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDm/XpRaY3b9nS+d0nNFT+XCSC8JIVEOGJh1j028wmQ=;
        b=ZbQzIdHnQadPDNhkyHmSshHINoiKO2CxhVgJ7WDICts2T8h+RtbubOw/IZSgbLLbu6
         TRBJh1veKyIfFFXS5NRbosKxiHDz42+zWYrgjxrusYQD3ceD12pbUQJYG7xx/qyMOfMc
         bkAy7hUUZpSgKw5JWkJ7fQYG7pk5yVTt0LjLVvvVnkP5KA0v6w/47N12VsqTGiehWtfN
         yJ0ph5CSupsDTWnZvovCXqgSTrNVHPZ/ZpYN3AeOXWUfVEjH4Cr5FthMr0PBZivy6iVm
         ehRLtRPB+lNd+KhwdNTwM6C0MmArWNVCYhk55/m78jMwoBUgKxAsk88seTLN/jv9wcw1
         fwPg==
X-Gm-Message-State: AOJu0YwEopozBopzkvc7UDJ6sJRlpZCiPETQ6tuIrGJSdQ000lnNftFo
	HPwbnBO89BdXE8iy6tkJirGsnTIDf7E=
X-Google-Smtp-Source: AGHT+IFJ19TCLQBInJpYPeRbwGc3LgumDMGAb6MsNTXcy3oMUXYPrK+bavZlF3qqbvybJ1aG9VvGGA==
X-Received: by 2002:a4a:6207:0:b0:58e:1c47:30f3 with SMTP id x7-20020a4a6207000000b0058e1c4730f3mr49465ooc.16.1701462998280;
        Fri, 01 Dec 2023 12:36:38 -0800 (PST)
Received: from [10.0.3.181] (104-183-76-119.lightspeed.hstntx.sbcglobal.net. [104.183.76.119])
        by smtp.gmail.com with ESMTPSA id y19-20020a4a6253000000b0058a010374e6sm680886oog.39.2023.12.01.12.36.37
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:36:37 -0800 (PST)
Message-ID: <594d83ff-ebff-490e-aa8c-842c6a604a31@gmail.com>
Date: Fri, 1 Dec 2023 14:36:36 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: gara <dw.gara@gmail.com>
Subject: Unmountable 4-drive btrfs RAID after drive failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tl;dr: btrfs RAID doesn't mount after single drive failure, `btrfs 
restore` also can't make progress - pls help save my data

I am currently running `btrfs rescue chunk-recover` and will for another 
day or two, but before I ask it to rebuild anything (didnt get a prompt 
to yet) I would be very thankful for any pointers on what else I could 
do/check to get as much data as possible off of the FS.
Data loss would not be critical but it would hurt.

The situation / process so far:

I run a 4-drive NAS that with LUKS->BTRFS-RAID setup over all disks 
(don't remember if it's a RAID5/6 or RAID10, is there a way to check?), 
my rootfs is on a different drive so i can still boot into my box

> uname -a
Linux helios4 5.15.93-mvebu #23.02.2 SMP Fri Feb 17 23:47:24 UTC 2023 armv7l GNU/Linux
> btrfs --version
btrfs-progs v5.10.1

I noticed yesterday that my SSHFS mounts to this NAS are not writable.

After getting `Input/Output Error`s reading the mountpoint from bash 
directly on the device, I rebooted.

After reboot /dev/sdd** is missing (it's clicking, so probably ded), 
SMART info for the 3 remaining drives looks healthy.
Normal luksOpen works on all 3 drives, but mount fails and dmesg prints

[  465.182744] BTRFS error (device dm-2): devid 4 uuid e79df2b2-5ad0-43b3-a280-3e240b9a2cff is missing
[  465.182759] BTRFS error (device dm-2): failed to read the system array: -2
[  465.183063] BTRFS error (device dm-2): open_ctree failed

> btrfs fi show
Label: none  uuid: 90f61aa9-e02c-4c47-ac31-559f08083565
	Total devices 1 FS bytes used 384.00KiB
	devid    1 size 1.82TiB used 2.02GiB path /dev/sdd

warning, device 4 is missing
parent transid verify failed on 92405825536 wanted 40448 found 31913
parent transid verify failed on 92405825536 wanted 40448 found 31913
Ignoring transid failure
parent transid verify failed on 92405841920 wanted 33513 found 31913
parent transid verify failed on 92405841920 wanted 33513 found 31913
Ignoring transid failure
parent transid verify failed on 92405858304 wanted 35618 found 31923
parent transid verify failed on 92405858304 wanted 35618 found 31923
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=92405809152 item=6 parent level=1 child bytenr=92405858304 child level=1
Couldn't read chunk tree
Label: none  uuid: 4a957a95-f784-41c3-a46c-13e975867a9f
	Total devices 4 FS bytes used 2.50TiB
	devid    1 size 5.46TiB used 1.25TiB path /dev/mapper/redA
	devid    2 size 5.46TiB used 389.03GiB path /dev/mapper/blueB
	devid    3 size 5.46TiB used 1.25TiB path /dev/mapper/redC
	*** Some devices missing

mounting degraded fails too

> mount -t btrfs -o ro,degraded /dev/mapper/redA /mnt/nas/
mount: /mnt/nas: wrong fs type, bad option, bad superblock on /dev/mapper/redA, missing codepage or helper program, or other error.

and dmesg prints after mounting:

[56750.747574] BTRFS info (device dm-2): allowing degraded mounts
[56750.747590] BTRFS info (device dm-2): disk space caching is enabled
[56750.747594] BTRFS info (device dm-2): has skinny extents
[56750.932131] BTRFS error (device dm-2): parent transid verify failed on 92405825536 wanted 40448 found 31913
[56750.939473] BTRFS error (device dm-2): failed to read chunk tree: -5
[56750.994132] BTRFS error (device dm-2): open_ctree failed

I spent a good day googling and trying all nondestructive things i could 
find to get the FS mounted or the data off, i.e.

> btrfs restore -si /dev/mapper/redA /mnt/rec/
warning, device 4 is missing
parent transid verify failed on 92405825536 wanted 40448 found 31913
parent transid verify failed on 92405825536 wanted 40448 found 31913
Ignoring transid failure
parent transid verify failed on 92405841920 wanted 33513 found 31913
parent transid verify failed on 92405841920 wanted 33513 found 31913
Ignoring transid failure
parent transid verify failed on 92405858304 wanted 35618 found 31923
parent transid verify failed on 92405858304 wanted 35618 found 31923
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=92405809152 item=6 parent level=1 child bytenr=92405858304 child level=1
Couldn't read chunk tree
Could not open root, trying backup super
warning, device 1 is missing
warning, device 2 is missing
warning, device 4 is missing
bad tree block 92405825536, bytenr mismatch, want=92405825536, have=0
Couldn't read chunk tree
Could not open root, trying backup super
warning, device 1 is missing
warning, device 2 is missing
warning, device 4 is missing
bad tree block 92405825536, bytenr mismatch, want=92405825536, have=0
Couldn't read chunk tree
Could not open root, trying backup super

> btrfs check --readonly --force /dev/mapper/redA
Opening filesystem to check...
warning, device 4 is missing
parent transid verify failed on 92405825536 wanted 40448 found 31913
parent transid verify failed on 92405825536 wanted 40448 found 31913
Ignoring transid failure
parent transid verify failed on 92405841920 wanted 33513 found 31913
parent transid verify failed on 92405841920 wanted 33513 found 31913
Ignoring transid failure
parent transid verify failed on 92405858304 wanted 35618 found 31923
parent transid verify failed on 92405858304 wanted 35618 found 31923
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=92405809152 item=6 parent level=1 child bytenr=92405858304 child level=1
Couldn't read chunk tree
ERROR: cannot open file system

> mount -t btrfs -o ro,degraded,rescue=all /dev/mapper/redA /mnt/nas/
mount: /mnt/nas: wrong fs type, bad option, bad superblock on /dev/mapper/redA, missing codepage or helper program, or other error.
> mount -t btrfs -o degraded,rescue=skip_bg /dev/mapper/redA /mnt/nas/
mount: /mnt/nas: wrong fs type, bad option, bad superblock on /dev/mapper/redA, missing codepage or helper program, or other error.
> mount -t btrfs -o degraded,ro,recovery /dev/mapper/redA /mnt/nas/
mount: /mnt/nas: wrong fs type, bad option, bad superblock on /dev/mapper/redA, missing codepage or helper program, or other error.

superblock dump in case it helps:

> btrfs inspect-internal dump-super /dev/mapper/redA
superblock: bytenr=65536, device=/dev/mapper/redA
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x7f35aa3d [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			4a957a95-f784-41c3-a46c-13e975867a9f
metadata_uuid		4a957a95-f784-41c3-a46c-13e975867a9f
label			
generation		54015
root			3023220178944
sys_array_size		193
chunk_root_generation	40448
root_level		1
chunk_root		92405809152
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		24004633395200
bytes_used		2744322326528
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		4
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	54015
uuid_tree_generation	54015
dev_item.uuid		d64ab077-6466-4c54-8a89-7b60f86cacb9
dev_item.fsid		4a957a95-f784-41c3-a46c-13e975867a9f [match]
dev_item.type		0
dev_item.total_bytes	6001158348800
dev_item.bytes_used	1373349347328
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0



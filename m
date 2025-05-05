Return-Path: <linux-btrfs+bounces-13645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDFAA8EB7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8BC7A4026
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D31F4703;
	Mon,  5 May 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="5acJNffj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ab3.no (mail.ab3.no [176.58.113.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7F1DBB3A
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.58.113.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435599; cv=none; b=JLfvIckxYbZW85rCZ+tduA9uyAUY1sDUEVklO2YtV4OjsN0QxFVhGWx9PiN6ZeOZ6vlMe1wsqVbjpsM61zZGXQ6ECXbiNNtRvmqODXL2vyEkUcQ4T5VLriQ+pkdmAveLQImz8KuFPkKzvp4z3xTaVYA/V+8iFubtKmHEwUy36vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435599; c=relaxed/simple;
	bh=576QbkySLFxDoo9BNDzuxFn146cvzSK4Dl4DRHHUQpA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Na4/84Yc8AS1cs7Qn+vh2RgaXvssxaADp2y3ff+p/n3129lRvArVpMVWueu8OSTh3H9K0WXMI/3rEWMfWs9zVbxN9GLYuhC6Tbq1u0MJPH7hPGZwQjLpWghuWI1BzxDl/FdQnyI4NovNCAdtR/6WparfgQo2nXtnAbDJdzS3Swo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no; spf=pass smtp.mailfrom=ab3.no; dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b=5acJNffj; arc=none smtp.client-ip=176.58.113.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ab3.no
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 00E824DE03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
	t=1746435594; bh=576QbkySLFxDoo9BNDzuxFn146cvzSK4Dl4DRHHUQpA=;
	h=Date:From:Subject:To:Cc:From;
	b=5acJNffjMsGhtl3PMvhmSdATVbBeTrnLqTKIEK6OAK7R+tbd2m7f/RnLVTF4ASP/L
	 Pjgvom4000/mqFER1PYJZ3lTagIk0wyO3rNJtmFWVW4SMQr9dSjyEbVmBQNk6yfuKW
	 DAj0NeuoJ3cZlIcbxFCiLUbZ1atqamqqtW1DJlt4=
Message-ID: <c00b7f69-6a21-455b-aab2-dafcd1194346@ab3.no>
Date: Mon, 5 May 2025 10:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mads <mads@ab3.no>
Subject: BTRFS critical (device sda): bad key order, sibling blocks, left last
 (4382045401088 230 4096) right first (4382045396992 230 4096)
To: linux-btrfs@vger.kernel.org
Content-Language: en-GB
Cc: jth@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Tested out creating a raid1 with raid stripe tree enabled on 6.14.5 
(aarch64):

> # mkfs.btrfs -d raid1 -m raid1 -O raid-stripe-tree,raid56 /dev/sda 
> /dev/sdb
> btrfs-progs v6.14
> See https://btrfs.readthedocs.io for more information.
>
> Performing full device TRIM /dev/sdb (10.91TiB) ...
> Performing full device TRIM /dev/sda (10.91TiB) ...
> NOTE: several default settings have changed in version 5.15, please 
> make sure
>       this does not affect your deployments:
>       - DUP for metadata (-m dup)
>       - enabled no-holes (-O no-holes)
>       - enabled free-space-tree (-R free-space-tree)
>
> Label:              (null)
> UUID:               27994ac2-061f-487c-9beb-53fc007d21da
> Node size:          16384
> Sector size:        4096        (CPU page size: 4096)
> Filesystem size:    21.83TiB
> Block group profiles:
>   Data:             RAID1             1.00GiB
>   Metadata:         RAID1             1.01GiB
>   System:           RAID1             8.00MiB
> SSD detected:       no
> Zoned device:       no
> Features:           extref, raid56, skinny-metadata, no-holes, 
> free-space-tree, raid-stripe-tree
> Checksum:           crc32c
> Number of devices:  2
> Devices:
>    ID        SIZE  PATH
>     1    10.91TiB  /dev/sda
>     2    10.91TiB  /dev/sdb


I have rsynced about 7TB of data to it, and that has worked great. But 
then I tried building a bunch of packages on Gentoo where the build work 
path (/var/tmp/portage) was a subvolume on the same raid1, and during 
one of the packages I hit this BUG:


kernel: BTRFS critical (device sda): left extent buffer:
kernel: BTRFS info (device sda): leaf 2812729409536 gen 1880 total ptrs 
243 free space 2432 owner 12
kernel:         item 0 key (4382038179840 230 61440) itemoff 16251 
itemsize 32
kernel:                         stride 0 devid 2 physical 4358394888192
kernel:                         stride 1 devid 1 physical 4358415859712
kernel:         item 1 key (4382038241280 230 16384) itemoff 16219 
itemsize 32
kernel:                         stride 0 devid 2 physical 4358394949632
kernel:                         stride 1 devid 1 physical 4358415921152
[...lots of more lines...]
kernel: BTRFS critical (device sda): right extent buffer:
kernel: BTRFS info (device sda): leaf 2813074292736 gen 1880 total ptrs 
95 free space 10868 owner 12
kernel:         item 0 key (4382045396992 230 4096) itemoff 16251 
itemsize 32
kernel:                         stride 0 devid 2 physical 4358402105344
kernel:                         stride 1 devid 1 physical 4358423076864
kernel:         item 1 key (4382045413376 230 24576) itemoff 16219 
itemsize 32
kernel:                         stride 0 devid 2 physical 4358402121728
kernel:                         stride 1 devid 1 physical 4358423093248
[...lots of more lines...]
mai 04 21:58:12 ananke kernel: BTRFS critical (device sda): bad key 
order, sibling blocks, left last (4382045401088 230 4096) right first 
(4382045396992 230 4096)
kernel: ------------[ cut here ]------------
kernel: BTRFS: Transaction aborted (error -117)
kernel: WARNING: CPU: 3 PID: 344 at fs/btrfs/ctree.c:3494 
push_leaf_left+0x204/0x268
kernel: Modules linked in: aes_ce_blk aes_ce_cipher polyval_ce 
polyval_generic ghash_ce sm4 sha2_ce snd_soc_rk817 sha256_arm64 sha1_ce 
snd_soc_core snd_pcm_dmaengine r8169 sch_fq_codel zram zsmalloc 
lz4hc_compress lz4_compress fuse loop dm_mod nfnetlink ip_tables x_tables
kernel: CPU: 3 UID: 0 PID: 344 Comm: btrfs-transacti Not tainted 
6.14.5-gentoo #1
kernel: Hardware name: Qnap TS-433-4G NAS System 4-Bay (DT)
kernel: pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
kernel: pc : push_leaf_left+0x204/0x268
kernel: lr : push_leaf_left+0x204/0x268
kernel: sp : ffff800082e0b930
kernel: x29: ffff800082e0b930 x28: 000000000000005f x27: 0000000000000001
kernel: x26: ffff2ff15e8f7e10 x25: ffff2ff155fa0d90 x24: 00000000ffffffff
kernel: x23: 0000000000000001 x22: ffff2ff148e99e10 x21: ffff2ff333b8a000
kernel: x20: ffff2ff33047e540 x19: 0000000000000001 x18: 00000000ffffffff
kernel: x17: 2073727470206c61 x16: 746f742030383831 x15: 0720072007290737
kernel: x14: 07310731072d0720 x13: 0720072007290737 x12: 07310731072d0720
kernel: x11: ffffa4b336bd2278 x10: 0000000000000667 x9 : ffffa4b3350270c8
kernel: x8 : 00000000ffffefff x7 : 00000000fffff000 x6 : ffffa4b336c2a278
kernel: x5 : ffff2ff33f767508 x4 : 0000000000000000 x3 : 0000000000000000
kernel: x2 : ffff2ff33f774930 x1 : ffff2ff3321f4500 x0 : 0000000000000000
kernel: Call trace:
kernel:  push_leaf_left+0x204/0x268 (P)
kernel:  btrfs_del_items+0x2c8/0x460
kernel:  btrfs_delete_raid_extent+0x200/0x4e8
kernel:  __btrfs_free_extent.isra.0+0x5d0/0x1340
kernel:  __btrfs_run_delayed_refs+0x424/0xcd8
kernel:  btrfs_run_delayed_refs+0x48/0x198
kernel:  btrfs_commit_transaction+0x70/0xdd8
kernel:  transaction_kthread+0x168/0x1c8
kernel:  kthread+0x120/0x1e8
kernel:  ret_from_fork+0x10/0x20
kernel: ---[ end trace 0000000000000000 ]---
kernel: BTRFS: error (device sda state A) in push_leaf_left:3494: 
errno=-117 Filesystem corrupted
kernel: BTRFS info (device sda state EA): forced readonly
kernel: BTRFS: error (device sda state EA) in 
do_free_extent_accounting:2966: errno=-117 Filesystem corrupted
kernel: BTRFS error (device sda state EA): failed to run delayed ref for 
logical 4382047010816 num_bytes 4096 type 178 action 2 ref_mod 1: -117
kernel: BTRFS: error (device sda state EA) in 
btrfs_run_delayed_refs:2160: errno=-117 Filesystem corrupted
kernel: BTRFS info (device sda state EA): last unmount of filesystem 
27994ac2-061f-487c-9beb-53fc007d21da


You can find the complete dmesg here: 
http://cwillu.com:8080/92.220.197.228/1

I don't know if this is related to enabling raid stripe tree, or 
something else.

- Mads


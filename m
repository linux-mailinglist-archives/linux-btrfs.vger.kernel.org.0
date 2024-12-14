Return-Path: <linux-btrfs+bounces-10374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A32C9F2039
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 19:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8848C1664B6
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B880198836;
	Sat, 14 Dec 2024 18:03:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833D28F1
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199393; cv=none; b=VcMRa+KoKp+89hCPtk1TgfN98oD9cVQluCKFMMiUqrunfMcGdE4mrDnUeFW9UUxhXbaup8pdGQExU3gQQqTy78yK7vZ8OHVvNZqIVyrUOEGkV9Jz3zTVEVbjo7zZImGuipeXoEykJapdUNGddH0AXoa82E/SsH0trSp7uvaNpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199393; c=relaxed/simple;
	bh=jRHl/g5hFI+wNMKGPbvvPiAIz+h6rHxbH+FSkpTlAGA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RBlipSBRhIKMG2irG5ODQx8fFnJwLtL1iKdC9vhjfqthR32BvE/JdKtiei4/PIpIwvF977nOOWYe5lATwMXY7OerWUUOgdZlEOYvhYIwTy/85R1o4wLNHtjOS7tdsKHGsmmR+Z3R+SXOIpaQjONRcp2KzLsDNtSiLwZdGiENC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id A9F8DC0EE6C
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 18:55:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IHtkmlgQW2Pf for <linux-btrfs@vger.kernel.org>;
	Sat, 14 Dec 2024 18:55:08 +0100 (CET)
Received: from [192.168.1.29] (aadu23.neoplus.adsl.tpnet.pl [83.4.98.23])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 1D433C0EE6B
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 18:55:08 +0100 (CET)
Message-ID: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
Date: Sat, 14 Dec 2024 18:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: 97% full system, dusage didn't help, musage strange
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



My system is almost full:


root@zefir:~# df -h

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2       8.2T  7.9T  256G  97% /




root@zefir:~# btrfs fi df /

Data, RAID1: total=8.08TiB, used=7.84TiB
System, RAID1: total=32.00MiB, used=1.47MiB
Metadata, RAID1: total=44.00GiB, used=36.26GiB
GlobalReserve, single: total=512.00MiB, used=0.00B




I have 256 GB free space, but almost no unallocated space:


root@zefir:~# btrfs dev usa /
/dev/sdb2, ID: 1
    Device size:             5.43TiB
    Device slack:              0.00B
    Data,RAID1:              5.38TiB
    Metadata,RAID1:         31.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            11.00GiB

/dev/sdc2, ID: 2
    Device size:             5.43TiB
    Device slack:              0.00B
    Data,RAID1:              5.39TiB
    Metadata,RAID1:         22.00GiB
    Unallocated:            10.03GiB

/dev/sda3, ID: 3
    Device size:             5.43TiB
    Device slack:              0.00B
    Data,RAID1:              5.38TiB
    Metadata,RAID1:         35.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            11.00GiB




I've been running whole day

           btrfs balance start -dusage=xxx,limit=8 /

with increasing numbers of xxx, until I reached dusage=90:


root@zefir:~# btrfs bala start -dusage=20,limit=8 /
Done, had to relocate 0 out of 8319 chunks

root@zefir:~# btrfs bala start -dusage=50,limit=8 /
Done, had to relocate 0 out of 8319 chunks

root@zefir:~# btrfs bala start -dusage=80,limit=8 /
Done, had to relocate 0 out of 8319 chunks

root@zefir:~# btrfs bala start -dusage=90,limit=8 /





I was running with -dusage=90 (90%) whole day, but
unallocated space didn't increase.

On logs i can see:

2024-12-09T08:46:13.001188+01:00 zefir kernel: [431476.446252] BTRFS 
info (device sda2): balance: start -dusage=90,limit=8
2024-12-09T08:46:13.013180+01:00 zefir kernel: [431476.458060] BTRFS 
info (device sda2): relocating block group 34750669520896 flags data|raid1
2024-12-09T08:46:40.389168+01:00 zefir kernel: [431503.832191] BTRFS 
info (device sda2): found 6 extents, stage: move data extents
2024-12-09T08:46:44.193216+01:00 zefir kernel: [431507.636729] BTRFS 
info (device sda2): found 6 extents, stage: update data pointers
2024-12-09T08:46:47.113166+01:00 zefir kernel: [431510.558009] BTRFS 
info (device sda2): relocating block group 34748522037248 flags data|raid1
2024-12-09T08:47:22.241196+01:00 zefir kernel: [431545.684216] BTRFS 
info (device sda2): found 11 extents, stage: move data extents
2024-12-09T08:47:23.933198+01:00 zefir kernel: [431547.378516] BTRFS 
info (device sda2): found 11 extents, stage: update data pointers
2024-12-09T08:47:25.137176+01:00 zefir kernel: [431548.582508] BTRFS 
info (device sda2): relocating block group 34731342168064 flags data|raid1
2024-12-09T08:48:01.897151+01:00 zefir kernel: [431585.342544] BTRFS 
info (device sda2): found 8 extents, stage: move data extents
2024-12-09T08:48:07.949185+01:00 zefir kernel: [431591.393774] BTRFS 
info (device sda2): found 8 extents, stage: update data pointers
2024-12-09T08:48:10.169177+01:00 zefir kernel: [431593.614676] BTRFS 
info (device sda2): relocating block group 34723825975296 flags data|raid1
2024-12-09T08:48:33.781190+01:00 zefir kernel: [431617.225031] BTRFS 
info (device sda2): found 10 extents, stage: move data extents
2024-12-09T08:48:44.353165+01:00 zefir kernel: [431627.799342] BTRFS 
info (device sda2): found 10 extents, stage: update data pointers
2024-12-09T08:48:47.453174+01:00 zefir kernel: [431630.899246] BTRFS 
info (device sda2): relocating block group 34721678491648 flags data|raid1

But unallocated space didn't increase.





So I started to play with metadata optimization, that is with musage.



When I put limit=0, no blocks are reallocated.
When I put limit=1 or limit=2 always one block is reallocated.
When I put limit greater then no blocks are reallocated.


See the test:

root@zefir:~# for lim in 0 1 2 3 4 5 6; do echo "lim=$lim"; for f in 
$(seq 5); do btrfs bala start -musage=30,limit=$lim /; done; done
lim=0
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
lim=1
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
lim=2
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
Done, had to relocate 1 out of 8318 chunks
lim=3
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
lim=4
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
lim=5
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
lim=6
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks
Done, had to relocate 0 out of 8318 chunks




root@zefir:~# btrfs bala start -musage=30,limit=1 /
Done, had to relocate 1 out of 8318 chunks

root@zefir:~# dmesg -T | tail
[Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: start 
-musage=30,limit=6 -susage=30,limit=6
[Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: ended with 
status: 0
[Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: start 
-musage=30,limit=6 -susage=30,limit=6
[Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: ended with 
status: 0
[Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: start 
-musage=30,limit=6 -susage=30,limit=6
[Sat Dec 14 18:50:00 2024] BTRFS info (device sdb2): balance: ended with 
status: 0
[Sat Dec 14 18:50:42 2024] BTRFS info (device sdb2): balance: start 
-musage=30,limit=1 -susage=30,limit=1
[Sat Dec 14 18:50:42 2024] BTRFS info (device sdb2): relocating block 
group 38091650760704 flags system|raid1
[Sat Dec 14 18:50:43 2024] BTRFS info (device sdb2): found 91 extents, 
stage: move data extents
[Sat Dec 14 18:50:44 2024] BTRFS info (device sdb2): balance: ended with 
status: 0




During those all operations level of Unallocated space is not increasing.
What should i do next?












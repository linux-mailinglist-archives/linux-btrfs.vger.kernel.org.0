Return-Path: <linux-btrfs+bounces-19951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8FCD64E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 200C0300FA36
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBC276049;
	Mon, 22 Dec 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gavinwestwood.co.uk header.i=@gavinwestwood.co.uk header.b="SKYmmkKi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from willow.solutium.co.uk (willow.solutium.co.uk [85.119.82.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251E274B32
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.82.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412107; cv=none; b=H16Dmmi5T0xITVVAzh8U7cZDZdPQtL7t68dQV2x2Pa3Dy+DFHqDAcOMJyZuqE42hFB9yBLqgTyEQDn6x8cs+3kmI8ESabV1NAe1a0FHsrwbuekE7AfeEnN5/TcHR7WOD8+ctvTxzjOZhIDJFV78gjO/9IwCQCY0I2CpZBgrY2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412107; c=relaxed/simple;
	bh=LwvwialG/4IMDT6VICw7LfXkBQBRvHVHgsejWfJ/tgo=;
	h=Message-ID:Date:MIME-Version:From:To:Content-Type:Subject; b=uhToKxgLPUUMDQh38OdMYJQwx7k081qD7Lhj5iknuYQna1KQKtIfbTlnAefP1psfZuID0GREIGWUQIz98I3tVOXtRKNQhbL/IgdHlMjDTBlLHw3IsIqTMLHVd82wOniE5hSqbNVboNT4w5Qshk9qNt4h4ht9u9SrhOpYNskSb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gavinwestwood.co.uk; spf=pass smtp.mailfrom=gavinwestwood.co.uk; dkim=pass (2048-bit key) header.d=gavinwestwood.co.uk header.i=@gavinwestwood.co.uk header.b=SKYmmkKi; arc=none smtp.client-ip=85.119.82.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gavinwestwood.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gavinwestwood.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gavinwestwood.co.uk; s=dk20240123; h=Subject:Content-Transfer-Encoding:
	Content-Type:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xh6LyNPWb5x6aao64B91Hf2QfCOgq0ytt7mTpLD012E=; b=SKYmmkKi/4qNlpygcffkv1sP08
	sFjE4Kd/S2Uctb6m7qSQ5N9CZKqKk35czGU5L60Hw468DUSSiAw1Qo671X7n3FIR5XdlT8fIQ310n
	5KS2x7VM8r7PfJoN0z0cC6clGMDBzKkeSXiOfNmBTKFWRrczu4cwQ8KrHAoLGvNc1MU45UYXCMyxf
	hMq8utmHmf5LjbTVFuVC7XEpZn3PRxcCvg6EdpNMWZTNAAjL50anSxRJAksTt3MOgxSMGbAUKjykz
	vxhqUKoKOQRc8mUeysMtCp1nK/J4uhINRNnBBSl+fZZLE2XWdm9hAU9spj8buVhw4+eIUa8zEnFtW
	Wl13WSAg==;
Received: from [2a02:390:5023:0:cff6:a37d:c924:5411]
	by willow.solutium.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <btrfs-issue-2025@gavinwestwood.co.uk>)
	id 1vXgTl-000MNk-15
	for linux-btrfs@vger.kernel.org;
	Mon, 22 Dec 2025 14:01:43 +0000
Message-ID: <bfcf30d4-92df-41e7-b7a7-f3684196b616@gavinwestwood.co.uk>
Date: Mon, 22 Dec 2025 14:01:40 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gavin Westwood <btrfs-issue-2025@gavinwestwood.co.uk>
To: linux-btrfs@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:390:5023:0:cff6:a37d:c924:5411
X-SA-Exim-Mail-From: btrfs-issue-2025@gavinwestwood.co.uk
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Report: 
	*  -20 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	*  2.0 HK_MUCHMONEY Message refers to hundreds of thousands or millions
Subject: Request for assistance: Error on rerun of btrfstune
 convert-to-block-group-tree after accidental Ctrl-C
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on willow.solutium.co.uk)

Hello.

Before my main message below, I note that this is similar to the thread 
https://lore.kernel.org/linux-btrfs/a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com/. 
Am I correct that the fix discussed there was included in 
btrfs-progs-6.15 and, based on the information I have provided below, 
installing/building then running that version on my system should 
resolve my issue of not being able to resume converting the filesystem 
to use a block group tree?

Thanks.


This morning, while running `btrfstune --convert-to-block-group-tree` 
(hoping to speed up loading to resolve frequent issues with my 
8-disk ~48TB BTRFS filesystem in a RAID-1 configuration not being ready 
in time to mount on start-up), I accidentally hit Ctrl-C on the wrong 
keyboard, killing the process.

When I tried to switch back to view the terminal on my monitor there was 
some sort of video corruption issue (I'm ignoring that as that's beyond 
the scope of this list) which prevented me from viewing the screen, so I 
had to SSH in using my user account instead of root.  These are the 
messages logged when it tried to mount /home on the BTRFS filesystem as 
I logged in:

Dec 22 08:52:46 MyServerName systemd[1]: Starting user@1000.service - 
User Manager for UID 1000...
Dec 22 08:52:46 MyServerName mount[5110]: mount: /home: wrong fs type, 
bad option, bad superblock on /dev/sdh1, missing codepage or helper 
program, >
Dec 22 08:52:46 MyServerName mount[5110]:        dmesg(1) may have more 
information after failed mount system call.
Dec 22 08:52:46 MyServerName kernel: BTRFS info (device sdg1): first 
mount of filesystem a4e9dbbe-39c3-464b-a3f7-d85c43d02b62
Dec 22 08:52:46 MyServerName kernel: BTRFS info (device sdg1): using 
crc32c (crc32c-intel) checksum algorithm
Dec 22 08:52:46 MyServerName kernel: BTRFS error (device sdg1): 
unrecognized or unsupported super flag 0x4000000000
Dec 22 08:52:46 MyServerName kernel: BTRFS error (device sdg1): 
superblock contains fatal errors
Dec 22 08:52:46 MyServerName kernel: BTRFS error (device sdg1): 
open_ctree failed: -22
Dec 22 08:52:46 MyServerName systemd[1]: home.mount: Mount process 
exited, code=exited, status=32/n/a
Dec 22 08:52:46 MyServerName systemd[1]: home.mount: Failed with result 
'exit-code'.
Dec 22 08:52:46 MyServerName systemd[1]: Failed to mount home.mount - /home.

 From what I read (but perhaps misunderstood?) it sounded like I should 
be able to resume the conversion to a block-group-tree, however when I 
tried that, it failed:

# btrfstune --convert-to-block-group-tree /dev/sda4
ERROR: failed to find block group for bytenr 65736247017472
ERROR: failed to convert the filesystem to block group tree feature
ERROR: btrfstune failed
extent buffer leak: start 87456383107072 len 16384

This is on a (just upgraded and rebooted) Debian Trixie (13) server with 
kernel 6.12:

Linux MyServerName 6.12.57+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 
6.12.57-1 (2025-11-05) x86_64 GNU/Linux

I had also recently turned on the NO_HOLES feature, but not yet run a 
balance to apply it to existing data.

Below is some information that I hope may be useful for troubleshooting:

# btrfstune --version
btrfstune, part of btrfs-progs v6.14
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin

# btrfs inspect-internal dump-super /dev/sda4
superblock: bytenr=65536, device=/dev/sda4
---------------------------------------------------------
csum_type0 (crc32c)
csum_size4
csum0xe6d3472d [match]
bytenr65536
flags0x4000000001
( WRITTEN |
   CHANGING_BG_TREE )
magic_BHRfS_M [match]
fsida4e9dbbe-39c3-464b-a3f7-d85c43d02b62
metadata_uuid00000000-0000-0000-0000-000000000000
label
generation1017016
root87456383107072
sys_array_size161
chunk_root_generation1015446
root_level0
chunk_root94563239936000
chunk_root_level1
log_root0
log_root_transid (deprecated)0
log_root_level0
total_bytes53991121108992
bytes_used23180446068736
sectorsize4096
nodesize16384
leafsize (deprecated)16384
stripesize4096
root_dir6
num_devices8
compat_flags0x0
compat_ro_flags0x3
( FREE_SPACE_TREE |
   FREE_SPACE_TREE_VALID )
incompat_flags0xb61
( MIXED_BACKREF |
   BIG_METADATA |
   EXTENDED_IREF |
   SKINNY_METADATA |
   NO_HOLES |
   RAID1C34 )
cache_generation0
uuid_tree_generation1016405
dev_item.uuid3ad36dd8-6028-45d7-a6d8-2b0bb1d5a7ab
dev_item.fsida4e9dbbe-39c3-464b-a3f7-d85c43d02b62 [match]
dev_item.type0
dev_item.total_bytes3984677928960
dev_item.bytes_used3212635537408
dev_item.io_align4096
dev_item.io_width4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

Thanks,

Gavin



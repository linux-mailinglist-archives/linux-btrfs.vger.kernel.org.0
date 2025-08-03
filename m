Return-Path: <linux-btrfs+bounces-15813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D315B194D2
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 20:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A623B1318
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260011C8621;
	Sun,  3 Aug 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXlY4Cbq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CC1FDD
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754247530; cv=none; b=VJP6rvwhQv0QFX7YrCAwde/ExRsGVCbIqiJ+WuVbeinv34dW2ASi83wPpILDB3NJBvMwgomLC4/V57s6I82rlqiR/fRQhpGy1H0OJNGmRuiDZOxzuTkJlaTfT77VYoSxKE65ND8bZUld0m/5r2jaKCDPQwEillZOIXGYqDtwZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754247530; c=relaxed/simple;
	bh=eYj6Bw7F2fF+mrDYZVwLBP+jFWqpWEG9ggF1k8P+dHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVxAWC4xbP5uH/pc0ac4z3FZiE6IH+aSAr/AuFlT8M7QiUIVgypJlTW4rRvn/FWnNpUhzUZWCWW9ssXk2w6O00qqPXd+spRztUiGeLhE0FAw3a/cdEqAnDUwajKEaAGAxGRscnfTF1+G6wmCElRxPmYriNYN81GfeRfSalNFF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXlY4Cbq; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8e1f488b37so3464105276.2
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754247526; x=1754852326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tJuSjQzZrbsqLy5BcteiURgYnUzum16S1F14VdeAFQ=;
        b=gXlY4CbqYlCFxHiZPTCVvldgCqbyPyot3G/Zk6axppl43AWnG8ra5ZpwRmV3NtTTea
         6m6tnRtNqrPyG0U8Y44cu/81a0hRfKbalyT95NFN0ApXLI1pKTwrmWghIFHOhhdbYMQU
         ST1YYE40R0TWHBPkGXRWORkF2KQbIjbtdyP/Na5/z1JFwt3w5i9qqZTIv1S3J+VOjvwv
         HjBgwpT+vmFvsfOsqrOCwcTj2J2kaIvdW1i9uHO/kxW/CqLg1K3+dr/GZrf96xfVtuAC
         lTV75MIWvEnjPgpKX05BnuPkv9iNyjzynDYItERUnlWiE+XbJA/62j15xYGxTg0Sd9ED
         wgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754247526; x=1754852326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tJuSjQzZrbsqLy5BcteiURgYnUzum16S1F14VdeAFQ=;
        b=hXXzS120f9NSOvWe3m+I+JusUmHhIm87mQWAZ06KiV8+EEhUekg54zemba9YGpXS6g
         CvY4JMKJlsZzsunqMQOaCOKDxy/o8lu+VcR9VVuWTmVGusmoTbeyBIzdq+HaJ+/47QPg
         +HyOR479GV5F5nJ5/s4tvc3s0ENnI5M1YQv4wrHqn/ZoSTU0xn6fAOikNFVxyIVkyVP5
         Nr46wzEE+zuhnqNRuJbfGM9FED+aA/FZvASioHK1wbClEGg6t9VH/JDjkd2FtymtHyef
         tL54a2CLAu8zbGc16HyAYi3lPIFA4Ek/vTfrnEifSYdzTahmSHejuwV67mEqUTKpO7AO
         YrBw==
X-Gm-Message-State: AOJu0YwqxG+ilHZt+qdONPVs1i8fOr6Xh9/WEOpVaF2MXqDUS66EIR3K
	BwQojFDlO+62ccWUjnmRwWG9iia+kDJNgdv+e+oKHWkvDLibeeRAmk6MIKBfjOXQ0n/XJ98fqtm
	i6+W8bwjS7hC2TNcdFXZjhoTAS4e37FphFPmqPGw=
X-Gm-Gg: ASbGnctV0eY6Pv9SDMweSBiSM1PJKL0WHRexAk4CaCjZ6JODaMDMyXqGL4GiXoklnyq
	+RqF/WC05ACa4sByjAsR6D9N2zPgUp9tvCukYjFcz1Bw9rUwoEzQ2XP0B7kVDUGSIRisuxYRWfG
	sEDS1Ox7L5S+ip3Sz7bmOBwruH2gdbFd2P/OQRnXBXB6gvM/1HKY/NQvNg4B4J++2tHNY4jS3u/
	3+O3C4=
X-Google-Smtp-Source: AGHT+IHl75W55fsjq9IgzyROarAxfLhCznqc3vAW0jRK29iMWqmYjq1OIBPd9phKsOYk9QOX3tnTXbkKGYr4iTEpyT8=
X-Received: by 2002:a05:690c:ed0:b0:71a:fd6:64a with SMTP id
 00721157ae682-71b7ed74212mr93731177b3.14.1754247525712; Sun, 03 Aug 2025
 11:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
 <a9793ad6-1254-43d3-8a78-6bad7a27eaf1@gmx.com> <CAGdWbB4-4KkN_1P8WbnbkSM7mXfAh6CQhc8KHDHTvRFwA54hiQ@mail.gmail.com>
 <be2e4159-d8ae-4170-83c0-a79354cec001@gmx.com>
In-Reply-To: <be2e4159-d8ae-4170-83c0-a79354cec001@gmx.com>
From: Dave T <davestechshop@gmail.com>
Date: Sun, 3 Aug 2025 14:58:34 -0400
X-Gm-Features: Ac12FXwr3sdtaaQWLTESLpVfRawvcvKPYxuKQLIqdQ7uMN5j5XWDmXNfl98jTN0
Message-ID: <CAGdWbB7p3u5Hb9uxkS9u1mkZEmSOysuObHKd0F17m1Wgc0eTWA@mail.gmail.com>
Subject: Re: Filesystem corrupted
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. Yes, it had faulty RAM. I now moved the storage device (a Samsung
SSD 970 EVO Plus 2TB) to a server with Xeon CPUs & Samsung ECC RAM.

Here is the output from dmesg when I attempt to mount the device. I
will wait for your response before attempting any recovery steps. I
can provide more info if needed. Thank you.

[Aug 3 14:35] BTRFS: device label mr10ut devid 1 transid 33588
/dev/mapper/mr10utluks (253:4) scanned by mount (1482)
[  +0.000592] BTRFS info (device dm-4): first mount of filesystem
05ddba03-0192-49e3-8cea-325ae3d1c500
[  +0.000025] BTRFS info (device dm-4): using crc32c (crc32c-x86)
checksum algorithm
[  +0.000007] BTRFS info (device dm-4): using free-space-tree
[  +0.058262] BTRFS info (device dm-4): last unmount of filesystem
05ddba03-0192-49e3-8cea-325ae3d1c500
[Aug 3 14:36] BTRFS: device label mr10ut devid 1 transid 33588
/dev/mapper/mr10utluks (253:4) scanned by mount (1504)
[  +0.000531] BTRFS info (device dm-4): first mount of filesystem
05ddba03-0192-49e3-8cea-325ae3d1c500
[  +0.000019] BTRFS info (device dm-4): using crc32c (crc32c-x86)
checksum algorithm
[  +0.000006] BTRFS info (device dm-4): using free-space-tree
[  +0.061099] BTRFS info (device dm-4): last unmount of filesystem
05ddba03-0192-49e3-8cea-325ae3d1c500
[Aug 3 14:41] BTRFS: device label mr10ut devid 1 transid 33588
/dev/mapper/mr10utluks (253:4) scanned by mount (1531)
[  +0.000449] BTRFS info (device dm-4): first mount of filesystem
05ddba03-0192-49e3-8cea-325ae3d1c500
[  +0.000031] BTRFS info (device dm-4): using crc32c (crc32c-x86)
checksum algorithm
[  +0.000006] BTRFS info (device dm-4): using free-space-tree
[Aug 3 14:42] ------------[ cut here ]------------
[  +0.000005] WARNING: CPU: 15 PID: 1548 at
fs/btrfs/extent-tree.c:3198 __btrfs_free_extent.isra.0+0x7cd/0xcc0
[  +0.000011] Modules linked in: intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common sb_edac
x86_pkg_temp_thermal intel_pow>
[  +0.000062] CPU: 15 UID: 0 PID: 1548 Comm: btrfs-transacti Not
tainted 6.15.8-arch1-2 #1 PREEMPT(full)
7b804d8109e142013e8263acc2bd1ff1b0003d09
[  +0.000003] Hardware name: Supermicro Super Server/X10DAL-i, BIOS
3.2 11/26/2019
[  +0.000003] RIP: 0010:__btrfs_free_extent.isra.0+0x7cd/0xcc0
[  +0.000003] Code: 44 24 14 89 44 24 10 e9 5a fc ff ff 8d 45 01 41 39
46 40 0f 85 3c 02 00 00 41 89 6e 40 c7 44 24 18 02 00 00 00 e9 c0 fd
ff ff <0f> 0b f0 >
[  +0.000002] RSP: 0018:ffffd21c869a3c08 EFLAGS: 00010246
[  +0.000002] RAX: ffff8ef862a7b000 RBX: 00000034e4da1000 RCX: 000000000000=
0001
[  +0.000001] RDX: 0000000000000000 RSI: 00000000000000a9 RDI: ffff8ef84259=
6690
[  +0.000002] RBP: ffff8ef9068f0150 R08: 0000000000000000 R09: 000000000000=
0001
[  +0.000001] R10: fffff3f686acd040 R11: 00000000ffffffff R12: 000000000000=
0000
[  +0.000001] R13: 000000000006816a R14: ffff8ef8fda31a80 R15: ffff8ef90c3e=
fa00
[  +0.000002] FS:  0000000000000000(0000) GS:ffff8f3725cec000(0000)
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f3b7c39b070 CR3: 0000001b5d624002 CR4: 000000000037=
26f0
[  +0.000016] Call Trace:
[  +0.000003]  <TASK>
[  +0.000005]  ? kmem_cache_free+0x40c/0x4d0
[  +0.000007]  __btrfs_run_delayed_refs+0x2df/0xdf0
[  +0.000003]  ? finish_task_switch.isra.0+0x99/0x2e0
[  +0.000007]  ? __schedule+0x411/0x1330
[  +0.000006]  btrfs_run_delayed_refs+0x43/0x100
[  +0.000002]  ? start_transaction+0x152/0x830
[  +0.000006]  btrfs_commit_transaction+0x69/0xca0
[  +0.000003]  ? start_transaction+0x228/0x830
[  +0.000002]  transaction_kthread+0x157/0x1c0
[  +0.000003]  ? __pfx_transaction_kthread+0x10/0x10
[  +0.000002]  kthread+0xfc/0x240
[  +0.000004]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork+0x34/0x50
[  +0.000006]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork_asm+0x1a/0x30
[  +0.000007]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---
[  +0.000001] ------------[ cut here ]------------
[  +0.000001] BTRFS: Transaction aborted (error -117)
[  +0.000070] WARNING: CPU: 15 PID: 1548 at
fs/btrfs/extent-tree.c:3199 __btrfs_free_extent.isra.0+0x7f0/0xcc0
[  +0.000004] Modules linked in: intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common sb_edac
x86_pkg_temp_thermal intel_pow>
[  +0.000037] CPU: 15 UID: 0 PID: 1548 Comm: btrfs-transacti Tainted:
G        W           6.15.8-arch1-2 #1 PREEMPT(full)
7b804d8109e142013e8263acc2bd1ff1b>
[  +0.000002] Tainted: [W]=3DWARN
[  +0.000001] Hardware name: Supermicro Super Server/X10DAL-i, BIOS
3.2 11/26/2019
[  +0.000001] RIP: 0010:__btrfs_free_extent.isra.0+0x7f0/0xcc0
[  +0.000002] Code: 00 00 e9 c0 fd ff ff 0f 0b f0 48 0f ba a8 70 0a 00
00 02 0f 82 ac c4 94 ff be 8b ff ff ff 48 c7 c7 48 e5 3d 98 e8 50 c3
a7 ff <0f> 0b c6 >
[  +0.000002] RSP: 0018:ffffd21c869a3c08 EFLAGS: 00010246
[  +0.000001] RAX: 0000000000000000 RBX: 00000034e4da1000 RCX: 000000000000=
0027
[  +0.000001] RDX: ffff8f36bf7dcbc8 RSI: 0000000000000001 RDI: ffff8f36bf7d=
cbc0
[  +0.000002] RBP: ffff8ef9068f0150 R08: 0000000000000000 R09: 00000000ffff=
bfff
[  +0.000001] R10: ffffffff99b77b40 R11: ffffd21c869a3aa0 R12: 000000000000=
0000
[  +0.000001] R13: 000000000006816a R14: ffff8ef8fda31a80 R15: ffff8ef90c3e=
fa00
[  +0.000001] FS:  0000000000000000(0000) GS:ffff8f3725cec000(0000)
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f3b7c39b070 CR3: 0000001b5d624002 CR4: 000000000037=
26f0
[  +0.000001] Call Trace:
[  +0.000001]  <TASK>
[  +0.000002]  ? kmem_cache_free+0x40c/0x4d0
[  +0.000003]  __btrfs_run_delayed_refs+0x2df/0xdf0
[  +0.000003]  ? finish_task_switch.isra.0+0x99/0x2e0
[  +0.000003]  ? __schedule+0x411/0x1330
[  +0.000003]  btrfs_run_delayed_refs+0x43/0x100
[  +0.000002]  ? start_transaction+0x152/0x830
[  +0.000002]  btrfs_commit_transaction+0x69/0xca0
[  +0.000003]  ? start_transaction+0x228/0x830
[  +0.000003]  transaction_kthread+0x157/0x1c0
[  +0.000002]  ? __pfx_transaction_kthread+0x10/0x10
[  +0.000002]  kthread+0xfc/0x240
[  +0.000002]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork+0x34/0x50
[  +0.000002]  ? __pfx_kthread+0x10/0x10
[  +0.000002]  ret_from_fork_asm+0x1a/0x30
[  +0.000004]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---
[  +0.000002] BTRFS: error (device dm-4 state A) in
__btrfs_free_extent:3199: errno=3D-117 Filesystem corrupted
[  +0.000082] BTRFS info (device dm-4 state EA): forced readonly
[  +0.000003] BTRFS info (device dm-4 state EA): leaf 253860970496 gen
33589 total ptrs 44 free space 7040 owner 2
[  +0.000002]   item 0 key (227177136128 168 4096) itemoff 16165 itemsize 1=
18
[  +0.000003]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426314 offset 0 count 1
[  +0.000003]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 1 key (227177140224 168 4096) itemoff 16047 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426315 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 2 key (227177144320 168 4096) itemoff 15929 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426316 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 3 key (227177148416 168 4096) itemoff 15811 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426317 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000002]   item 4 key (227177152512 168 4096) itemoff 15693 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426318 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 5 key (227177156608 168 4096) itemoff 15575 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426319 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 6 key (227177160704 168 4096) itemoff 15457 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426320 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 7 key (227177164800 168 4096) itemoff 15339 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426325 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 8 key (227177168896 168 4096) itemoff 15221 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426326 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540040192 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489888768 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355113984 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191386624 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253776723968 coun=
t 1
[  +0.000001]   item 9 key (227177172992 168 4096) itemoff 15103 itemsize 1=
18
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426327 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000002]   item 10 key (227177177088 168 69632) itemoff 14985 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426328 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 11 key (227177246720 168 4096) itemoff 14867 itemsize =
118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426329 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 12 key (227177250816 168 4096) itemoff 14749 itemsize =
118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426330 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 13 key (227177254912 168 69632) itemoff 14631 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426334 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000002]   item 14 key (227177324544 168 69632) itemoff 14513 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426336 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 15 key (227177394176 168 69632) itemoff 14395 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426337 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000002]   item 16 key (227177463808 168 69632) itemoff 14277 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426338 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 17 key (227177533440 168 69632) itemoff 14159 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426339 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 18 key (227177603072 168 57344) itemoff 14041 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426340 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 19 key (227177660416 168 57344) itemoff 13923 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426341 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000002]   item 20 key (227177717760 168 77824) itemoff 13805 itemsize=
 118
[  +0.000001]           extent refs 6 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426342 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 266540023808 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 266489905152 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 266355130368 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 254191403008 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 253777035264 coun=
t 1
[  +0.000001]   item 21 key (227177795584 168 61440) itemoff 13596 itemsize=
 209
[  +0.000001]           extent refs 13 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426346 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent
18014665013673984 count 1
[  +0.000001]           ref#2: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000002]           ref#11: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 22 key (227177857024 168 77824) itemoff 13348 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426347 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000002]   item 23 key (227177934848 168 77824) itemoff 13100 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426348 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000002]   item 24 key (227178012672 168 77824) itemoff 12852 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426349 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000002]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 25 key (227178090496 168 77824) itemoff 12604 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426350 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 26 key (227178168320 168 77824) itemoff 12356 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426351 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000002]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000002]   item 27 key (227178246144 168 5492736) itemoff 12108
itemsize 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426352 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000002]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 28 key (227183738880 168 1945600) itemoff 11860
itemsize 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426353 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000002]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 29 key (227185684480 168 5492736) itemoff 11612
itemsize 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426354 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000002]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 30 key (227191177216 168 1945600) itemoff 11364
itemsize 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426355 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000009]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000002]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 31 key (227193122816 168 77824) itemoff 11116 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426356 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000002]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000002]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 32 key (227193200640 168 77824) itemoff 10868 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426357 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000002]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 33 key (227193278464 168 102400) itemoff 10620 itemsiz=
e 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426358 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 34 key (227193380864 168 77824) itemoff 10372 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426359 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000002]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000002]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 35 key (227193458688 168 77824) itemoff 10124 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426360 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000002]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000002]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 36 key (227193536512 168 102400) itemoff 9876 itemsize=
 248
[  +0.000002]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426364 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000002]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 37 key (227193638912 168 57344) itemoff 9628 itemsize =
248
[  +0.000002]           extent refs 16 gen 135 flags 1
[  +0.000000]           ref#0: extent data backref root 490 objectid
426366 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000002]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 38 key (227193696256 168 102400) itemoff 9380 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426367 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 39 key (227193798656 168 73728) itemoff 9132 itemsize =
248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426368 offset 0 count 1
[  +0.000002]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000002]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 40 key (227193872384 168 155648) itemoff 8884 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426369 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000002]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000002]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 41 key (227194028032 168 372736) itemoff 8636 itemsize=
 248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426370 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180048384 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147673600 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079155712 coun=
t 1
[  +0.000001]           ref#4: shared data backref parent 266967482368 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640375808 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567467008 coun=
t 1
[  +0.000002]           ref#7: shared data backref parent 266540056576 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504192000 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489921536 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355146752 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357405696 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230609920 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217502720 cou=
nt 1
[  +0.000002]           ref#14: shared data backref parent 254191419392 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777068032 cou=
nt 1
[  +0.000001]   item 42 key (227194400768 168 372736) itemoff 8388 itemsize=
 248
[  +0.000002]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426375 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180081152 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147689984 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079172096 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967515136 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640392192 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567483392 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540072960 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504208384 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489937920 coun=
t 1
[  +0.000002]           ref#10: shared data backref parent 266355163136 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357438464 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230626304 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217519104 cou=
nt 1
[  +0.000001]           ref#14: shared data backref parent 254191435776 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777051648 cou=
nt 1
[  +0.000001]   item 43 key (227194773504 168 61440) itemoff 8140 itemsize =
248
[  +0.000001]           extent refs 16 gen 135 flags 1
[  +0.000001]           ref#0: extent data backref root 490 objectid
426378 offset 0 count 1
[  +0.000001]           ref#1: shared data backref parent 267180081152 coun=
t 1
[  +0.000001]           ref#2: shared data backref parent 267147689984 coun=
t 1
[  +0.000001]           ref#3: shared data backref parent 267079172096 coun=
t 1
[  +0.000002]           ref#4: shared data backref parent 266967515136 coun=
t 1
[  +0.000001]           ref#5: shared data backref parent 266640392192 coun=
t 1
[  +0.000001]           ref#6: shared data backref parent 266567483392 coun=
t 1
[  +0.000001]           ref#7: shared data backref parent 266540072960 coun=
t 1
[  +0.000001]           ref#8: shared data backref parent 266504208384 coun=
t 1
[  +0.000001]           ref#9: shared data backref parent 266489937920 coun=
t 1
[  +0.000001]           ref#10: shared data backref parent 266355163136 cou=
nt 1
[  +0.000001]           ref#11: shared data backref parent 254357438464 cou=
nt 1
[  +0.000001]           ref#12: shared data backref parent 254230626304 cou=
nt 1
[  +0.000001]           ref#13: shared data backref parent 254217519104 cou=
nt 1
[  +0.000002]           ref#14: shared data backref parent 254191435776 cou=
nt 1
[  +0.000001]           ref#15: shared data backref parent 253777051648 cou=
nt 1
[  +0.000001] BTRFS critical (device dm-4 state EA): unable to find
ref byte nr 227177795584 parent 266504192000 root 490 owner 426346
offset 0 slot 22
[  +0.000087] BTRFS error (device dm-4 state EA): failed to run
delayed ref for logical 227177795584 num_bytes 61440 type 184 action 2
ref_mod 1: -2
[  +0.000083] BTRFS: error (device dm-4 state EA) in
btrfs_run_delayed_refs:2154: errno=3D-2 No such entry

On Tue, Sep 24, 2024 at 2:44=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/24 15:57, Dave T =E5=86=99=E9=81=93:
> > [  +0.000001] ---[ end trace 0000000000000000 ]---
> [...]
> > [  +0.000003]   item 21 key (227177795584 168 61440) itemoff 13596 item=
size 209
> > [  +0.000003]           extent refs 13 gen 135 flags 1
> > [  +0.000002]           ref#0: extent data backref root 490 objectid
> > 426346 offset 0 count 1
> > [  +0.000003]           ref#1: shared data backref parent
> > 18014665013673984 count 1
> > [  +0.000003]           ref#2: shared data backref parent 267180048384 =
count 1
> > [  +0.000003]           ref#3: shared data backref parent 267147673600 =
count 1
> > [  +0.000003]           ref#4: shared data backref parent 267079155712 =
count 1
> > [  +0.000002]           ref#5: shared data backref parent 266967482368 =
count 1
> > [  +0.000003]           ref#6: shared data backref parent 266640375808 =
count 1
> > [  +0.000003]           ref#7: shared data backref parent 266567467008 =
count 1
> > [  +0.000003]           ref#8: shared data backref parent 266540056576 =
count 1
> > [  +0.000003]           ref#9: shared data backref parent 266489921536 =
count 1
> > [  +0.000002]           ref#10: shared data backref parent 266355146752=
 count 1
> > [  +0.000003]           ref#11: shared data backref parent 254191419392=
 count 1
> > [  +0.000003]           ref#12: shared data backref parent 253777068032=
 count 1
>
> Above the is the offending slot of the bytenr.
>
> At ref#1, the slot has bytenr 18014665013673984, but our target is
> 266504192000.
>
> hex(18014665013673984) =3D 0x40003e0ce34000
> hex(266504192000)      =3D 0x00003e0ce34000
>
> This is a strong indication of bitflip.
>
> Thus it's strongly recommended to do a memtest before doing anything.
> Please report back about the memtest result.
>
> Thanks,
> Qu
>
> >>>       [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
> >>> find ref byte nr 227177795584 parent 266504192000 root 490 owner>
> >>>       [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
> >>> delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
> >>>       [  +0.000017] BTRFS: error (device dm-3 state EA) in
> >>> btrfs_run_delayed_refs:2207: errno=3D-2 No such entry
> >>>
> >>> The drive is a Samsung SSD 970 EVO Plus 2TB.
> >>>
> >>> Overall:
> >>>       Device size:                   1.82TiB
> >>>       Device allocated:           300.04GiB
> >>>       Device unallocated:            1.53TiB
> >>>       Device missing:                  0.00B
> >>>       Device slack:                    0.00B
> >>>       Used:                        299.07GiB
> >>>       Free (estimated):              1.53TiB      (min: 1.53TiB)
> >>>       Free (statfs, df):             1.53TiB
> >>>       Data ratio:                       1.00
> >>>       Metadata ratio:                   1.00
> >>>       Global reserve:              398.55MiB      (used: 16.00KiB)
> >>>       Multiple profiles:                  no
> >>>
> >>> Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
> >>>      /dev/mapper/userluks  298.01GiB
> >>>
> >>> Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
> >>>      /dev/mapper/userluks    2.00GiB
> >>>
> >>> System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
> >>>      /dev/mapper/userluks   32.00MiB
> >>>
> >>> What is the recommended course of action given this error?
> >>>
> >>> What other info do I need to share, if any?
> >>>
> >>> Thank you!
> >>>
> >>
>


Return-Path: <linux-btrfs+bounces-21120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pq+LsAMeWnyugEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21120-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:06:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B869999CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67283042990
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C73266565;
	Tue, 27 Jan 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cxPJJtus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKzUuRPL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665023D281
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540449; cv=none; b=ifqBFo+3kgKBJ55yrMco4NY4nvbmkzFniVHk2s/cGj6ZE5F4OnnCNoduT9t8ziO83ohKkQtdgpoBbPL3sQl/0Kq5G7AZIzase2uC/Mkme45WX78bncJN/w6lD4D8NC/5/RMY8z9JTvAYcP99F+Hk3KlIKV/YKlIASOYkw+JsxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540449; c=relaxed/simple;
	bh=oS/88Ev6l5eq8RqIi48XNhG3Pr0nMcVnoZaLwI+7NKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF9E5Lg3bYWi5SIBk12Z2MGxJ5/Q/Ld2EVtCZygc7HX3OXqNMJf9e45A/yUrry0SO3b8UYkAzmvDSE9NjTas8Pqhs2jxxmZnT7Z3sEuLpBwkcV7friGmgXNtqmRYIgpCAHn93DEQCvozEp8HEiKPsqtIDdaEFFPasrxJBcTnvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cxPJJtus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKzUuRPL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 48C04EC02A4;
	Tue, 27 Jan 2026 14:00:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 27 Jan 2026 14:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769540445;
	 x=1769626845; bh=Ib+tL2qIiHnTn7mRSWN09pwj3Ucplfl8KZ3/I+h76UE=; b=
	cxPJJtustOK7pyLOK7febTWWqGr5Ruams9qr3LasErHHPG9nytU8DZfPA0usQEqU
	KKY2CPHWNo+v0oYdwEAFWaPe3ja6vMCFKf4pQp2gdkfRAlTLvVTVMVfk/Hfoqxt1
	mrd+r19Mepl8xgSVLxByM6bFrO8XVadhziwjpge1sWsgnnMoF9o5qbH4pqWyT7tR
	hFUlxvoA+quhkVgcJJ7d8ji14zta3BSvLDGOa9dAu45h8lOValZSB03IejhARtqJ
	SVqtgc72oMbTaM9X/qkwHEiXxlbHoBgycwu5b58r0JAbBApO/WU2mUypTMvbiPrA
	ltjchCdj5fzAwDB1c4SCQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769540445; x=
	1769626845; bh=Ib+tL2qIiHnTn7mRSWN09pwj3Ucplfl8KZ3/I+h76UE=; b=u
	KzUuRPL5VDDBoa1jtlTcKoxGDpoaS2BPentnARRrOmQ3uvxEBvMqPTFvqYtJLBzG
	RDQ1RMI+ST/kK1yYelra4utf6amf+caVGVjQxvxfynq+B6STUBWbYPI5Idz9WN8U
	4ObIZYOWoJEYgAmJOYk5rGBIEc0C1nftgw/jqIOGDots1Pp3GyLpc3HLpsvcuZJb
	9FBJhcaM7RnojX6uFuztup+AoFXlJQn36BrnZ0+3XC5dhNKzyLsWxOx8qd1toHun
	zFyYxsGIBJFtWHnl81QI9ydHShUICCAMSjeioR/Ihj0zOs3Es8KicDuowEab88GI
	Je+3KYAtCiY8gUWbTehTQ==
X-ME-Sender: <xms:XAt5aZf5MZsJlrYnpqSwh0o0N6ov18VqSzqM9l121LbR2PNo4dEkKg>
    <xme:XAt5aermirUO5a8NYPr4t622b3EhoEit1RPW0jmfBIu140bD5e9biG4USB7k4_Vf4
    Isw2rhBPxyZGbAZLagFosIA5j2qacHMxLxC2H1ir_fywxwWMRRmJbQ>
X-ME-Received: <xmr:XAt5af6V0BcUV0xKiXF0J_XCMKpCngc040p8ClhJGpUbNypTDqlHDfRvqIx6P88Bvt1QsmRagt96lQ3ctPMzioPjIMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgv
    lhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:XAt5acqUhP0iGSqZ_8C5i15693h_lo4VY4gs4MpMuvh2Pzf-CuobqQ>
    <xmx:XAt5aZhRus_YI9RJqwr2N3N9VHxlsB_q5pJptIsVM-9-Wml01Vce6g>
    <xmx:XAt5aeLOVOoCjcdSvMoXI_ch1i-szWNADv6K-Xa2qvTtymsxFOR0ZA>
    <xmx:XAt5aRAsJhoohekkYRxkmNJI9MdaREOfguVvf70IVX15Kkxz1KfZnA>
    <xmx:XQt5aTL3j-K1PAbjr49-8u-ZjFkhB5OL88sN2nxD8yy5dMmfyH_NQUZS>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 14:00:44 -0500 (EST)
Date: Tue, 27 Jan 2026 11:00:20 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix block_group_tree dirty_list corruption
Message-ID: <20260127190020.GA3450664@zen.localdomain>
References: <3fd15bae79aae6bb366ecffced32775e8cb4f55a.1769468599.git.boris@bur.io>
 <CAL3q7H7SoLUDhUcQN=nvhKppb3eYWGCcLaa-Tg401DrVRMHQHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7SoLUDhUcQN=nvhKppb3eYWGCcLaa-Tg401DrVRMHQHA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-21120-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zen.localdomain:mid,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: 4B869999CF
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:15:42PM +0000, Filipe Manana wrote:
> On Mon, Jan 26, 2026 at 11:05 PM Boris Burkov <boris@bur.io> wrote:
> >
> > When the incompat flag EXTENT_TREE_V2 is set, we unconditionally add the
> > block group tree to the switch_commits list before calling
> > switch_commit_roots, as we do for the tree root and the chunk root.
> > However, the block group tree uses normal root dirty tracking and in any
> > transaction that does an allocation and dirties a block group, the block
> > group root will already be linked to a list by the dirty_list field and
> > this use of list_add_tail() is invalid and corrupts the prev/next
> > members of block_group_root->dirty_list.
> >
> > This is apparent on a subsequent list_del on the prev if we enable
> > CONFIG_DEBUG_LIST:
> > [   32.157161] ------------[ cut here ]------------
> > [   32.157298] list_del corruption. next->prev should be
> > ffff958890202538, but was ffff9588992bd538. (next=ffff958890201538)
> > [   32.157538] WARNING: lib/list_debug.c:65 at 0x0, CPU#3: sync/607
> > [   32.157712] Modules linked in: btrfs libblake2b xor zlib_deflate
> > zstd_compress raid6_pq xfs ahci libahci libata virtio_scsi scsi_mod nvme
> > virtio_net net_failover bsg nvme_core failover scsi_common evdev
> > sch_fq_codel loop dm_mod configfs nfnetlink bpf_preload dmi_sysfs
> > qemu_fw_cfg vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common
> > vsock virtio_rng rng_core ipv6 crc_ccitt autofs4
> > [   32.158368] CPU: 3 UID: 0 PID: 607 Comm: sync Not tainted 6.18.0 #24
> > PREEMPT(none)
> > [   32.158527] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > 1.17.0-4.fc41 04/01/2014
> > [   32.158708] RIP: 0010:__list_del_entry_valid_or_report+0x108/0x120
> > [   32.158870] Code: e9 48 89 ee 67 48 0f b9 3a 31 c0 e9 67 ff ff ff 4c
> > 89 e7 e8 3a fb c5 ff 48 8d 3d 03 f8 10 01 49 8b 54 24 08 4c 89 e1 48 89
> > ee <67> 48 0f b9 3a 31 c0 e9 41 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00
> > [   32.159309] RSP: 0018:ffffaa288287fdd0 EFLAGS: 00010202
> > [   32.159430] RAX: 0000000000000001 RBX: ffff95889326e800 RCX:
> > ffff958890201538
> > [   32.159609] RDX: ffff9588992bd538 RSI: ffff958890202538 RDI:
> > ffffffff82a41e00
> > [   32.159781] RBP: ffff958890202538 R08: ffffffff828fc1e8 R09:
> > 00000000ffffefff
> > [   32.159973] R10: ffffffff8288c200 R11: ffffffff828e4200 R12:
> > ffff958890201538
> > [   32.160153] R13: ffff95889326e958 R14: ffff958895c24000 R15:
> > ffff958890202538
> > [   32.160355] FS:  00007f0c28eb5740(0000) GS:ffff958af2bd2000(0000)
> > knlGS:0000000000000000
> > [   32.160574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   32.160723] CR2: 00007f0c28e8a3cc CR3: 0000000109942005 CR4:
> > 0000000000370ef0
> > [   32.160967] Call Trace:
> > [   32.161054]  <TASK>
> > [   32.161119]  switch_commit_roots+0x82/0x1d0 [btrfs]
> > [   32.161521]  btrfs_commit_transaction+0x968/0x1550 [btrfs]
> > [   32.161803]  ? btrfs_attach_transaction_barrier+0x23/0x60 [btrfs]
> > [   32.162114]  __iterate_supers+0xe8/0x190
> > [   32.162217]  ? __pfx_sync_fs_one_sb+0x10/0x10
> > [   32.162342]  ksys_sync+0x63/0xb0
> > [   32.162443]  __do_sys_sync+0xe/0x20
> > [   32.162535]  do_syscall_64+0x73/0x450
> > [   32.162641]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   32.162760] RIP: 0033:0x7f0c28d05d2b
> > [   32.162881] Code: c3 66 0f 1f 44 00 00 48 8b 15 e9 40 0f 00 f7 d8 64
> > 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3 0f 1e fa b8 a2 00 00 00 0f
> > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd 40 0f 00 f7 d8 64 89 01 48
> > [   32.163278] RSP: 002b:00007ffc9d988048 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000000a2
> > [   32.163452] RAX: ffffffffffffffda RBX: 00007ffc9d988228 RCX:
> > 00007f0c28d05d2b
> > [   32.163614] RDX: 00007f0c28e02301 RSI: 00007ffc9d989b21 RDI:
> > 00007f0c28dba90d
> > [   32.163780] RBP: 0000000000000001 R08: 0000000000000001 R09:
> > 0000000000000000
> > [   32.163954] R10: 0000000000000000 R11: 0000000000000246 R12:
> > 000055b96572cb80
> > [   32.164111] R13: 000055b96572b19f R14: 00007f0c28dfa434 R15:
> > 000055b96572b034
> > [   32.164337]  </TASK>
> > [   32.164404] irq event stamp: 0
> > [   32.164490] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [   32.164649] hardirqs last disabled at (0): [<ffffffff81298817>]
> > copy_process+0xb37/0x2260
> > [   32.164809] softirqs last  enabled at (0): [<ffffffff81298817>]
> > copy_process+0xb37/0x2260
> > [   32.165029] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [   32.165222] ---[ end trace 0000000000000000 ]---
> >
> > Furthermore, this list corruption eventually (when we happen to add a
> > new block group) results in getting the switch_commits and
> > dirty_cowonly_roots lists mixed up and attempting to call update_root
> > on the tree root which can't be found in the tree root, resulting in a
> > transaction abort:
> >
> > [   87.826960] BTRFS critical (device nvme1n1): unable to find root key (1 0 0) in tree 1
> > [   87.827271] ------------[ cut here ]------------
> > [   87.827418] BTRFS: Transaction aborted (error -117)
> > [   87.827540] WARNING: fs/btrfs/root-tree.c:153 at 0x0, CPU#4: sync/703
> > [   87.827722] Modules linked in: btrfs libblake2b xor zlib_deflate zstd_compress raid6_pq xfs ahci libahci libata virtio_scsi scsi_mod nvme nvme_core virtio_net bsg net_failover scsi_common failover evdev sch_fq_codel loop dm_mod configfs nfnetlink bpf_preload dmi_sysfs qemu_fw_cfg vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock virtio_rng rng_core ipv6 crc_ccitt autofs4
> > [   87.828568] CPU: 4 UID: 0 PID: 703 Comm: sync Not tainted 6.18.0 #25 PREEMPT(none)
> > [   87.828760] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-4.fc41 04/01/2014
> > [   87.828974] RIP: 0010:btrfs_update_root+0x296/0x790 [btrfs]
> > [   87.829218] Code: 99 00 00 00 48 c7 c6 10 5d e0 c0 4c 89 ef e8 81 7c 01 00 41 bc 8b ff ff ff e9 1a ff ff ff 48 8d 3d ff e9 ee ff be 8b ff ff ff <67> 48 0f b9 3a 41 b8 01 00 00 00 eb c3 e8 f8 c6 b4 d8 84 c0 75 8a
> > [   87.829583] RSP: 0018:ffffa58d035dfd60 EFLAGS: 00010282
> > [   87.829704] RAX: ffff9a59126ddb68 RBX: ffff9a59126dc000 RCX: 0000000000000000
> > [   87.829958] RDX: 0000000000000000 RSI: 00000000ffffff8b RDI: ffffffffc0b28270
> > [   87.830168] RBP: ffff9a5904aec000 R08: 0000000000000000 R09: 00000000ffffefff
> > [   87.830324] R10: ffffffff9ac8c200 R11: ffffffff9ace4200 R12: 0000000000000001
> > [   87.830550] R13: ffff9a59041740e8 R14: ffff9a5904aec1f7 R15: ffff9a590fdefaf0
> > [   87.830750] FS:  00007f54cde6b740(0000) GS:ffff9a5b5a81c000(0000) knlGS:0000000000000000
> > [   87.830924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   87.831078] CR2: 00007f54cde403cc CR3: 0000000112902004 CR4: 0000000000370ef0
> > [   87.831274] Call Trace:
> > [   87.831370]  <TASK>
> > [   87.831466]  ? _raw_spin_unlock+0x23/0x40
> > [   87.831575]  commit_cowonly_roots+0x1ad/0x250 [btrfs]
> > [   87.831787]  ? btrfs_commit_transaction+0x79b/0x1560 [btrfs]
> > [   87.832016]  btrfs_commit_transaction+0x8aa/0x1560 [btrfs]
> > [   87.832258]  ? btrfs_attach_transaction_barrier+0x23/0x60 [btrfs]
> > [   87.832523]  __iterate_supers+0xf1/0x170
> > [   87.832621]  ? __pfx_sync_fs_one_sb+0x10/0x10
> > [   87.832736]  ksys_sync+0x63/0xb0
> > [   87.832835]  __do_sys_sync+0xe/0x20
> > [   87.832940]  do_syscall_64+0x73/0x450
> > [   87.833035]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   87.833174] RIP: 0033:0x7f54cdd05d2b
> > [   87.833277] Code: c3 66 0f 1f 44 00 00 48 8b 15 e9 40 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3 0f 1e fa b8 a2 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd 40 0f 00 f7 d8 64 89 01 48
> > [   87.833697] RSP: 002b:00007fff1b58ff78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
> > [   87.833896] RAX: ffffffffffffffda RBX: 00007fff1b590158 RCX: 00007f54cdd05d2b
> > [   87.834072] RDX: 00007f54cde02301 RSI: 00007fff1b592b66 RDI: 00007f54cddba90d
> > [   87.834272] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> > [   87.834478] R10: 0000000000000000 R11: 0000000000000246 R12: 000055e07ca96b80
> > [   87.834646] R13: 000055e07ca9519f R14: 00007f54cddfa434 R15: 000055e07ca95034
> > [   87.834849]  </TASK>
> > [   87.834894] irq event stamp: 0
> > [   87.834997] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [   87.835165] hardirqs last disabled at (0): [<ffffffff99698797>] copy_process+0xb37/0x21e0
> > [   87.835338] softirqs last  enabled at (0): [<ffffffff99698797>] copy_process+0xb37/0x21e0
> > [   87.835557] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [   87.835709] ---[ end trace 0000000000000000 ]---
> > [   87.835824] BTRFS: error (device nvme1n1 state A) in btrfs_update_root:153: errno=-117 Filesystem corrupted
> > [   87.836040] BTRFS info (device nvme1n1 state EA): forced readonly
> > [   87.836221] BTRFS warning (device nvme1n1 state EA): Skipping commit of aborted transaction.
> > [   87.836437] BTRFS: error (device nvme1n1 state EA) in cleanup_transaction:2037: errno=-117 Filesystem corrupted
> >
> > Since the block group tree was pulled out of the extent tree and uses
> > normal root dirty tracking, remove the offending extra list_add. This
> > fixes the list corruption and the resulting fs corruption.
> >
> > Fixes: f7238e5094048 ("btrfs: add support for multiple global roots")
> 
> That's the commit that introduced the code this patch is removing,
> sure, but back then things were fine because the block group root was
> not getting the flag BTRFS_ROOT_TRACK_DIRTY set.
> 
> The correct commit should be the one that adds that flag to the block
> group root without removing the code that is being removed in this
> patch, which is:
> 
> 14033b08a02916 ("btrfs: don't save block group root into super block")

Good catch, thanks. Fixed that and pushed to for-next.

> 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> With the Fixes tag updated:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
> 
> 
> > ---
> >  fs/btrfs/transaction.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 8aa55cd8a0bf..0b2498749b1e 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -2508,13 +2508,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
> >         list_add_tail(&fs_info->chunk_root->dirty_list,
> >                       &cur_trans->switch_commits);
> >
> > -       if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> > -               btrfs_set_root_node(&fs_info->block_group_root->root_item,
> > -                                   fs_info->block_group_root->node);
> > -               list_add_tail(&fs_info->block_group_root->dirty_list,
> > -                             &cur_trans->switch_commits);
> > -       }
> > -
> >         switch_commit_roots(trans);
> >
> >         ASSERT(list_empty(&cur_trans->dirty_bgs));
> > --
> > 2.52.0
> >
> >


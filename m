Return-Path: <linux-btrfs+bounces-21066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 43pNHyGid2mWjgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21066-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CB8B635
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23353300AC96
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262C34B43D;
	Mon, 26 Jan 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qk/lzMM1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8B5i1g5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B634A796
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447964; cv=none; b=OTo+qze9p5CtvTp+SEb8LixvK5V0rlnJuFj7co2ji750vFeOrRfoQ7OSTj51nkv8kAGoL3wiz9EJZNdgpBC+oE8Eo/WdzNy98/foo/L7fIgj6i9yMwcGOT78V4ESwnAfYyPzc5+2vkSG4G4vTcsppa4SNU0923fXGGNX5gPtwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447964; c=relaxed/simple;
	bh=X7+E1Y7Ij8suAcZCFP+P6+44FMPr7W1AghMHQIQJZGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpM031Wjyd3ul9CSLCXucoV4TOuDQnS0V2swhjLt6e/69k1bEx51X+34bkDDp8gz5QN9iXa+LyOuHe+BSTttxjKy/+T8twOjGk1p2ZPbYg6DYHXZd9u0o/pxioWrdP48GG0K+/LB14zF+DcllbeGmgen4OcySOFgO/g07i0XqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qk/lzMM1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8B5i1g5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E8ABFEC0233;
	Mon, 26 Jan 2026 12:19:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 12:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769447961; x=
	1769534361; bh=jT1nEaAFrDel776yfifqhQrMNDq3JZpWmwQ+++8c5S8=; b=q
	k/lzMM1FDDoM2Kl/15fyEAyosROdWTPIpzAGeAd4YF8b5GvPWI3isqYat0KX0yTl
	eW6mFufmYhIoYJkKLkNGx6Z7DyQhKr8WW7qd4lUkNLfM+hmlSRBpgwK1sRwGaqNI
	DwnKZMtO+RFhSLGGWYur3UiQTxXJRz7mkiEJIstSPLbGZU54iQ72ahfDmqaCIX02
	t3XCdWnPYcHa+sbqcOQq2uV0LIESpcs87BLrLjSUFL6HiTgJUMznVfgStPXEbHgn
	VkXzJFrVvBVrkQsRcKuPSNOyRufUBIaA6u5Yk25Iv1E2V/BWhodLrvK1ZMWnzjhi
	1eZDgxzgMUgNRDScs/jNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1769447961; x=1769534361; bh=jT1nEaAFrDel776yfifqhQrMNDq3
	JZpWmwQ+++8c5S8=; b=L8B5i1g5LCtY/MvMbrPR0vtRUhILRGDpMkBjkkf58lDU
	qqmoSZPY1D3jSMCbgI78FAdmswfAr4Qal/NhKCQMqXZGcnXrD5zT0wAZzyNQV5r4
	+dtcShZ4+BfoNchlrnEAsPBljW2OZ9oqzfoVOQ2AzrK+u5luIjbNk4Dmao5G6EwN
	euUF2BHJQwAOmfPPSosojdZV/pwod8QumHKLqGkE30jj5zH8R0z51cIBVKlrbM+u
	9lWzIhlX97by81GXw8gXHaYicVr4nrEMVEyyW0UeToHYJz5Vi2ks4Idauz1TmgEw
	6yO8rInrtxWQFo5a+PQKHjkR3J1ChNnU0OChr7hS5g==
X-ME-Sender: <xms:GaJ3aXuR-XdFcyHPBdB9Cs4iHpjq40IAa2Q4fzqlrqy4WYw5Hv8uYQ>
    <xme:GaJ3aecS7-0CDH0XveqtLDWEyOVqhAARzjW6_FY-O5xD991U_EhoRr00NvlRZwkU2
    b0JscOVAQCA2Y_Ypt4kONtlBNtOGLLFrbqjb8aEqHxXPUMLhuCbOHA>
X-ME-Received: <xmr:GaJ3aYaMAw2tfQnbcU0M9knco8u43Gx6hnCYk6SWPdwwmDcRnLWy2sHSr5mT9oY0eBPcjcDK4cUAT_hmt_pis3hfDsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeffgffgkeekveevgeduffeuvdevtdekvedtledvfedule
    elgeevteelkedvhfeikeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:GaJ3aRWCJaLfQuMm_pfrg3R0gsNnTMvYY05QtrMoE9yzmzmFg1e_Kw>
    <xmx:GaJ3aai--cdW-0CFKgPBXWle8Ael3BRtkTPshfmq-8ulKk1FUAfpZQ>
    <xmx:GaJ3afUIGZcDgZgkHlfQyJyG47IMXWMgMkp81hzXxnmxVKZetY---g>
    <xmx:GaJ3aROhJWfPu0Xz_xoZSAB5LSZbb0-OsMqiKu1eyepEbCN_xdQOuA>
    <xmx:GaJ3afR6XHpYRo8ibCKGp7QzQTHLHCZmRIjej3uibh__nQSC_93mnNyp>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:19:21 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 1/3] btrfs: fix EEXIST abort due to non-consecutive gaps in chunk allocation
Date: Mon, 26 Jan 2026 09:18:51 -0800
Message-ID: <8139d137b56ae6b66cfca818b75e5bc30353ff17.1769447820.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769447820.git.boris@bur.io>
References: <cover.1769447820.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21066-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 184CB8B635
X-Rspamd-Action: no action

I have been observing a number of systems aborting at
insert_dev_extents() in btrfs_create_pending_block_groups(). The
following is a sample stack trace of such an abort coming from forced
chunk allocation (typically behind CONFIG_BTRFS_EXPERIMENTAL) but this
can theoretically happen to any DUP chunk allocation.

[   81.801251] ------------[ cut here ]------------
[   81.801587] BTRFS: Transaction aborted (error -17)
[   81.801924] WARNING: fs/btrfs/block-group.c:2876 at btrfs_create_pending_block_groups+0x721/0x770 [btrfs], CPU#1: bash/319
[   81.802764] Modules linked in: virtio_net btrfs xor zstd_compress raid6_pq null_blk
[   81.803310] CPU: 1 UID: 0 PID: 319 Comm: bash Kdump: loaded Not tainted 6.19.0-rc6+ #319 NONE
[   81.803916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[   81.804552] RIP: 0010:btrfs_create_pending_block_groups+0x723/0x770 [btrfs]
[   81.805074] Code: 0b 00 00 4c 89 ff 4c 89 54 24 10 48 c7 c6 00 30 6a c0 e8 c0 14 02 00 4c 8b 54 24 10 e9 4c fa ff ff 48 8d 3d ef c6 08 00 89 ee <67> 48 0f b9 3a 4c 8b 54 24 10 41 b8 01 00 00 00 e9 f4 5e 03 00 48
[   81.806305] RSP: 0018:ffffa36241a6bce8 EFLAGS: 00010282
[   81.806673] RAX: 000000000000000d RBX: ffff8e699921e400 RCX: 0000000000000000
[   81.807154] RDX: 0000000002040001 RSI: 00000000ffffffef RDI: ffffffffc0608bf0
[   81.807658] RBP: 00000000ffffffef R08: ffff8e69830f6000 R09: 0000000000000007
[   81.808145] R10: ffff8e699921e5e8 R11: 0000000000000000 R12: ffff8e6999228000
[   81.808676] R13: ffff8e6984d82000 R14: ffff8e69966a69c0 R15: ffff8e69aa47b000
[   81.809162] FS:  00007fec6bdd9740(0000) GS:ffff8e6b1b379000(0000) knlGS:0000000000000000
[   81.809725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.810114] CR2: 00005604833670f0 CR3: 0000000116679000 CR4: 00000000000006f0
[   81.810631] Call Trace:
[   81.810821]  <TASK>
[   81.810978]  __btrfs_end_transaction+0x3e/0x2b0 [btrfs]
[   81.811368]  btrfs_force_chunk_alloc_store+0xcd/0x140 [btrfs]
[   81.811823]  kernfs_fop_write_iter+0x15f/0x240
[   81.812128]  vfs_write+0x264/0x500
[   81.812365]  ksys_write+0x6c/0xe0
[   81.812640]  do_syscall_64+0x66/0x770
[   81.812909]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.813246] RIP: 0033:0x7fec6be66197
[   81.813521] Code: 48 89 fa 4c 89 df e8 98 af 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   81.814798] RSP: 002b:00007fffb159dd30 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   81.815292] RAX: ffffffffffffffda RBX: 00007fec6bdd9740 RCX: 00007fec6be66197
[   81.815822] RDX: 0000000000000002 RSI: 0000560483374f80 RDI: 0000000000000001
[   81.816289] RBP: 0000560483374f80 R08: 0000000000000000 R09: 0000000000000000
[   81.816861] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[   81.817327] R13: 00007fec6bfb85c0 R14: 00007fec6bfb5ee0 R15: 00005604833729c0
[   81.817837]  </TASK>
[   81.817993] irq event stamp: 20039
[   81.818224] hardirqs last  enabled at (20047): [<ffffffff99a68302>] __up_console_sem+0x52/0x60
[   81.818815] hardirqs last disabled at (20056): [<ffffffff99a682e7>] __up_console_sem+0x37/0x60
[   81.819375] softirqs last  enabled at (19470): [<ffffffff999d2b46>] __irq_exit_rcu+0x96/0xc0
[   81.819990] softirqs last disabled at (19463): [<ffffffff999d2b46>] __irq_exit_rcu+0x96/0xc0
[   81.820611] ---[ end trace 0000000000000000 ]---
[   81.820949] BTRFS: error (device dm-7 state A) in btrfs_create_pending_block_groups:2876: errno=-17 Object already exists

Inspecting these aborts with drgn, I observed a pattern of overlapping
chunk_maps. Note how stripe 1 of the first chunk overlaps in physical
address with stripe 0 of the second chunk.

Physical Start     Physical End       Length       Logical            Type                 Stripe
----------------------------------------------------------------------------------------------------
0x0000000102500000 0x0000000142500000 1.0G         0x0000000641d00000 META|DUP             0/2
0x0000000142500000 0x0000000182500000 1.0G         0x0000000641d00000 META|DUP             1/2
0x0000000142500000 0x0000000182500000 1.0G         0x0000000601d00000 META|DUP             0/2
0x0000000182500000 0x00000001c2500000 1.0G         0x0000000601d00000 META|DUP             1/2

Now how could this possibly happen? All chunk allocation is protected by
the chunk_mutex so racing allocations should see a consistent view of
the CHUNK_ALLOCATED bit in the chunk allocation extent-io-tree
(device->alloc_state as set by chunk_map_device_set_bits()) The tree
itself is protected by a spin lock, and clearing/setting the bits is
always protected by fs_info->mapping_tree_lock, so no race is apparent.

It turns out that there is a subtle bug in the logic regarding chunk
allocations that have happened in the current transaction, known as
"pending extents". The chunk allocation as defined in
find_free_dev_extent() is a loop which searches the commit root of the
dev_root and looks for gaps between DEV_EXTENT items. For those gaps, it
then checks alloc_state bitmap for any pending extents and adjusts the
hole that it finds accordingly. However, the logic in that adjustment
assumes that the first pending extent is the only one in that range.

e.g., given a layout with two non-consecutive pending extents in a hole
passed to dev_extent_hole_check() via *hole_start and *hole_size:

  |----pending A----|    real hole     |----pending B----|
           |           candidate hole        |
      *hole_start                         *hole_start + *hole_size

the code incorrectly returns a "hole" from the end of pending extent A
until the passed in hole end, failing to account for pending B.

However, it is not entirely obvious that it is actually possible to
produce such a layout. I was able to reproduce it, but with some
contortions: I continued to use the force chunk allocation sysfs file
and I introduced a long delay (10 seconds) into the start of the cleaner
thread. I also prevented the unused bgs cleaning logic from ever
deleting metadata bgs. These help make it easier to deterministically
produce the condition but shouldn't really matter if you imagine the
conditions happening by race/luck. Allocations/frees can happen
concurrently with the cleaner thread preparing to process an unused
extent and both create some used chunks with an unused chunk
interleaved, all during one transaction. Then btrfs_delete_unused_bgs()
sees the unused one and clears it, leaving a range with several pending
chunk allocations and a gap in the middle.

The basic idea is that the unused_bgs cleanup work happens on a worker
so if we allocate 3 block groups in one transaction, then the cleaner
work kicked off by the previous transaction comes through and deletes
the middle one of the 3, then the commit root shows no dev extents and
we have the bad pattern in the extent-io-tree. One final consideration
is that the code happens to loop to the next hole if there are no more
extents at all, so we need one more dev extent way past the area we are
working in. Something like the following demonstrates the technique:

 # push the BG frontier out to 20G
 fallocate -l 20G $mnt/foo
 # allocate one more that will prevent the "no more dev extents" luck
 fallocate -l 1G $mnt/sticky
 # sync
 sync
 # clear out the allocation area
 rm $mnt/foo
 sync
 _cleaner
 # let everything quiesce
 sleep 20
 sync

 # dev tree should have one bg 20G out and the rest at the beginning..
 # sort of like an empty FS but with a random sticky chunk.

 # kick off the cleaner in the background, remember it will sleep 10s
 # before doing interesting work
 _cleaner &

 sleep 3

 # create 3 trivial block groups, all empty, all immediately marked as unused.
 echo 1 > "$(_btrfs_sysfs_space_info $dev metadata)/force_chunk_alloc"
 echo 1 > "$(_btrfs_sysfs_space_info $dev data)/force_chunk_alloc"
 echo 1 > "$(_btrfs_sysfs_space_info $dev metadata)/force_chunk_alloc"

 # let the cleaner thread definitely finish, it will remove the data bg
 sleep 10

 # this allocation sees the non-consecutive pending metadata chunks with
 # data chunk gap of 1G and allocates a 2G extent in that hole. ENOSPC!
 echo 1 > "$(_btrfs_sysfs_space_info $dev metadata)/force_chunk_alloc"

As for the fix, it is not that obvious. I could not see a trivial way to
do it even by adding backup loops into find_free_dev_extent(), so I
opted to change the semantics of dev_extent_hole_check() to not stop
looping until it finds a sufficiently big hole. For clarity, this also
required changing the helper function contains_pending_extent() into two
new helpers which find the first pending extent and the first suitable
hole in a range.

I attempted to clean up the documentation and range calculations to be
as consistent and clear as possible for the future.

I also looked at the zoned case and concluded that the loop there is
different and not to be unified with this one. As far as I can tell, the
zoned check will only further constrain the hole so looping back to find
more holes is acceptable. Though given that zoned really only appends, I
find it highly unlikely that it is susceptible to this bug.

Fixes: 1b9845081633 ("Btrfs: fix find_free_dev_extent() malfunction in case device tree has hole")
Reported-by: Dimitrios Apostolou <jimis@gmx.net>
Closes: https://lore.kernel.org/linux-btrfs/q7760374-q1p4-029o-5149-26p28421s468@tzk.arg/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.c | 246 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 185 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cff2412bc879..2b632d238d4a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1509,30 +1509,157 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 }
 
 /*
- * Try to find a chunk that intersects [start, start + len] range and when one
- * such is found, record the end of it in *start
+ * Find the first pending extent intersecting a range.
+ *
+ * @device: the device to search
+ * @start: start of the range to check
+ * @len: length of the range to check
+ * @pending_start: output pointer for the start of the found pending extent
+ * @pending_end: output pointer for the end of the found pending extent (inclusive)
+ *
+ * Search for a pending chunk allocation that intersects the half-open range
+ * [start, start + len).
+ *
+ * Return: true if a pending extent was found, false otherwise.
+ * If the return value is true, store the first pending extent in
+ * [*pending_start, *pending_end]. Otherwise, the two output variables
+ * may still be modified, to something outside the range and should not
+ * be used.
  */
-static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
-				    u64 len)
+static bool first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
+				 u64 *pending_start, u64 *pending_end)
 {
-	u64 physical_start, physical_end;
-
 	lockdep_assert_held(&device->fs_info->chunk_mutex);
 
-	if (btrfs_find_first_extent_bit(&device->alloc_state, *start,
-					&physical_start, &physical_end,
+	if (btrfs_find_first_extent_bit(&device->alloc_state, start,
+					pending_start, pending_end,
 					CHUNK_ALLOCATED, NULL)) {
 
-		if (in_range(physical_start, *start, len) ||
-		    in_range(*start, physical_start,
-			     physical_end + 1 - physical_start)) {
-			*start = physical_end + 1;
+		if (in_range(*pending_start, start, len) ||
+		    in_range(start, *pending_start,
+			     *pending_end + 1 - *pending_start)) {
 			return true;
 		}
 	}
 	return false;
 }
 
+/*
+ * Find the first real hole accounting for pending extents.
+ *
+ * @device: the device containing the candidate hole
+ * @start: input/output pointer for the hole start position
+ * @len: input/output pointer for the hole length
+ * @min_hole_size: the size of hole we are looking for
+ *
+ * Given a potential hole specified by [*start, *start + *len), check for pending
+ * chunk allocations within that range. If pending extents are found, the hole is
+ * adjusted to represent the first true free space that is large enough when
+ * accounting for pending chunks.
+ *
+ * Note that this function must handle various cases involving non
+ * consecutive pending extents.
+ *
+ * Returns: true if a suitable hole was found and false otherwise.
+ * If the return value is true, then *start and *len are set to represent the hole.
+ * If the return value is false, then *start is set to the largest hole we
+ * found and *len is set to its length.
+ * If there are no holes at all, then *start is set to the end of the range and
+ * *len is set to 0.
+ */
+static bool find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
+					 u64 min_hole_size)
+{
+	u64 pending_start, pending_end;
+	u64 end;
+	u64 max_hole_start = 0;
+	u64 max_hole_len = 0;
+
+	lockdep_assert_held(&device->fs_info->chunk_mutex);
+
+	if (*len == 0)
+		return false;
+
+	end = *start + *len - 1;
+
+	/*
+	 * Loop until we either see a large enough hole or check every pending
+	 * extent overlapping the candidate hole.
+	 * At every hole that we observe, record it if it is the new max.
+	 * At the end of the iteration, set the output variables to the max hole.
+	 */
+	while (true) {
+		if (first_pending_extent(device, *start, *len, &pending_start, &pending_end)) {
+			/*
+			 * Case 1: the pending extent overlaps the start of
+			 * candidate hole. That means the true hole is after the
+			 * pending extent, but we need to find the next pending
+			 * extent to properly size the hole. In the next loop,
+			 * we will reduce to case 2 or 3.
+			 * e.g.,
+			 *   |----pending A----|    real hole     |----pending B----|
+			 *            |           candidate hole        |
+			 *         *start                              end
+			 */
+			if (pending_start <= *start) {
+				*start = pending_end + 1;
+				goto next;
+			}
+			/*
+			 * Case 2: The pending extent starts after *start (and overlaps
+			 * [*start, end), so the first hole just goes up to the start
+			 * of the pending extent.
+			 * e.g.,
+			 *   |    real hole    |----pending A----|
+			 *   |       candidate hole     |
+			 * *start                      end
+			 *
+			 */
+			*len = pending_start - *start;
+			if (*len > max_hole_len) {
+				max_hole_start = *start;
+				max_hole_len = *len;
+			}
+			if (*len >= min_hole_size)
+				break;
+			/*
+			 * If the hole wasn't big enough, then we advance past
+			 * the pending extent and keep looking.
+			 */
+			*start = pending_end + 1;
+			goto next;
+		} else {
+			/*
+			 * Case 3: There is no pending extent overlapping the
+			 * range [*start, *start + *len - 1], so the only remaining
+			 * hole is the remaining range.
+			 * e.g.,
+			 *   |       candidate hole           |
+			 *   |          real hole             |
+			 * *start                            end
+			 */
+
+			if (*len > max_hole_len) {
+				max_hole_start = *start;
+				max_hole_len = *len;
+			}
+			break;
+		}
+next:
+		if (*start > end)
+			break;
+		*len = end - *start + 1;
+	}
+	if (max_hole_len) {
+		*start = max_hole_start;
+		*len = max_hole_len;
+	} else {
+		*start = end + 1;
+		*len = 0;
+	}
+	return max_hole_len >= min_hole_size;
+}
+
 static u64 dev_extent_search_start(struct btrfs_device *device)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
@@ -1597,59 +1724,58 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 }
 
 /*
- * Check if specified hole is suitable for allocation.
+ * Validate and adjust a hole for chunk allocation
+ *
+ * @device: the device containing the candidate hole
+ * @hole_start: input/output pointer for the hole start position
+ * @hole_size: input/output pointer for the hole size
+ * @num_bytes: minimum allocation size required
  *
- * @device:	the device which we have the hole
- * @hole_start: starting position of the hole
- * @hole_size:	the size of the hole
- * @num_bytes:	the size of the free space that we need
+ * Check if the specified hole is suitable for allocation and adjust it if
+ * necessary. The hole may be modified to skip over pending chunk allocations
+ * and to satisfy stricter zoned requirements on zoned fs-es.
  *
- * This function may modify @hole_start and @hole_size to reflect the suitable
- * position for allocation. Returns 1 if hole position is updated, 0 otherwise.
+ * For regular (non-zoned) allocation, if the hole after adjustment is smaller
+ * than @num_bytes, the search continues past additional pending extents until
+ * either a sufficiently large hole is found or no more pending extents exist.
+ *
+ * Return: true if a suitable hole was found and false otherwise.
+ * If the return value is true, then *hole_start and *hole_size are set to
+ * represent the hole we found.
+ * If the return value is false, then *hole_start is set to the largest
+ * hole we found and *hole_size is set to its length.
+ * If there are no holes at all, then *hole_start is set to the end of the range
+ * and *hole_size is set to 0.
  */
 static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 				  u64 *hole_size, u64 num_bytes)
 {
-	bool changed = false;
-	u64 hole_end = *hole_start + *hole_size;
+	bool found = false;
+	u64 hole_end = *hole_start + *hole_size - 1;
 
-	for (;;) {
-		/*
-		 * Check before we set max_hole_start, otherwise we could end up
-		 * sending back this offset anyway.
-		 */
-		if (contains_pending_extent(device, hole_start, *hole_size)) {
-			if (hole_end >= *hole_start)
-				*hole_size = hole_end - *hole_start;
-			else
-				*hole_size = 0;
-			changed = true;
-		}
+	ASSERT(*hole_size > 0);
 
-		switch (device->fs_devices->chunk_alloc_policy) {
-		default:
-			btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc_policy);
-			fallthrough;
-		case BTRFS_CHUNK_ALLOC_REGULAR:
-			/* No extra check */
-			break;
-		case BTRFS_CHUNK_ALLOC_ZONED:
-			if (dev_extent_hole_check_zoned(device, hole_start,
-							hole_size, num_bytes)) {
-				changed = true;
-				/*
-				 * The changed hole can contain pending extent.
-				 * Loop again to check that.
-				 */
-				continue;
-			}
-			break;
-		}
+again:
+	*hole_size = hole_end - *hole_start + 1;
+	found = find_hole_in_pending_extents(device, hole_start, hole_size, num_bytes);
+	if (!found)
+		return found;
+	ASSERT(*hole_size >= num_bytes);
 
-		break;
+	switch (device->fs_devices->chunk_alloc_policy) {
+	default:
+		btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc_policy);
+		fallthrough;
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		return found;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		if (dev_extent_hole_check_zoned(device, hole_start,
+						hole_size, num_bytes)) {
+			goto again;
+		}
 	}
 
-	return changed;
+	return found;
 }
 
 /*
@@ -1708,7 +1834,7 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 		ret = -ENOMEM;
 		goto out;
 	}
-again:
+
 	if (search_start >= search_end ||
 		test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
 		ret = -ENOSPC;
@@ -1795,11 +1921,7 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	 */
 	if (search_end > search_start) {
 		hole_size = search_end - search_start;
-		if (dev_extent_hole_check(device, &search_start, &hole_size,
-					  num_bytes)) {
-			btrfs_release_path(path);
-			goto again;
-		}
+		dev_extent_hole_check(device, &search_start, &hole_size, num_bytes);
 
 		if (hole_size > max_hole_size) {
 			max_hole_start = search_start;
@@ -5023,6 +5145,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	u64 diff;
 	u64 start;
 	u64 free_diff = 0;
+	u64 pending_start, pending_end;
 
 	new_size = round_down(new_size, fs_info->sectorsize);
 	start = new_size;
@@ -5068,7 +5191,8 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	 * in-memory chunks are synced to disk so that the loop below sees them
 	 * and relocates them accordingly.
 	 */
-	if (contains_pending_extent(device, &start, diff)) {
+	if (first_pending_extent(device, start, diff,
+				 &pending_start, &pending_end)) {
 		mutex_unlock(&fs_info->chunk_mutex);
 		ret = btrfs_commit_transaction(trans);
 		if (ret)
-- 
2.52.0



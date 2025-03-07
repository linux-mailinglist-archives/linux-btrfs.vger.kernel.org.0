Return-Path: <linux-btrfs+bounces-12072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E6A55BFC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823C53B94EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1A610B;
	Fri,  7 Mar 2025 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Dh364Ji9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvv+rntb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB38F4A
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307296; cv=none; b=e/WPEuu37HlofegOGlYwHylqy+QxvZFWlYH0ZqXBAvkhE26nEVz/mlMEd/xIAKkdUpCihcmhIoZNYYoDDr3sMwwRZcvwWiVrC9BMEUkv+WUq28k+pZ9dI+tDUVzZ2YDKgLoSkb6tckzqgcrkzT3GK5E0Xl6QX4Vjv+nhAtM3mG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307296; c=relaxed/simple;
	bh=5Fo2OHag6NBEm/dVepz2haqPsR1WAIqJuls2LS9P26U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5HnAKO7fOmIRFM/S05Fa9Hd8qlGoBpDTGwpfR5JLUTlj4fvmqNaQQKDGR1jpvgKdf7EAuGgTAgQjAzdEVQHzeD+4B5W5z+20ldeDbrlSmLGV0xLHzuSG6hsQVlRasXdqheNK83k7lQJFaIbnARd90z2pY62lHHhc8c0wGcRqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Dh364Ji9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nvv+rntb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3648C1140152;
	Thu,  6 Mar 2025 19:28:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 19:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741307293; x=
	1741393693; bh=pXmfqm5ZlsKs691hu+4fmzp9bc8pYFVHp5iDm63cXxQ=; b=D
	h364Ji9t+Kv/WpVCxo0MBbATwX6tLXEn7nwTz5aN8Gfr5tKF3Sr9QBXUtpMbyAuO
	UhUnUf9Nk1pea2NqsNzcblKzn5Ku/+MS0qJXkurIJ2H9gnz+cm2iG30RfOlQ61Xx
	2SkCyRhbzyl9rlwBEnWsZZdhz0RatkGlQjMiRF9emjxkQ48hQF1eKk0FO09CUqRa
	gcvZip3IMzce25uTQhDhq+sCfvzkzh2rnPVed94QBRucCzLh+edBxHYTXlXpNlgx
	d1cZefhnBVFhzPb3CtnxOj879TmrBmReJWFcUwnzv0t2GbZ2M5wYSTROcPHjh7LV
	LFeve7onXfeAbHlNCj0Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741307293; x=1741393693; bh=pXmfqm5ZlsKs691hu+4fmzp9bc8p
	YFVHp5iDm63cXxQ=; b=nvv+rntbqkXRaZIfA7qdYUOZj9qHqbEzl7QoxnUlZ9zw
	PMrSzxpET0ILvtKJXBJJ4LSE40SDcKT7bdisfBvqfF8ELMEcSwwQcB5ugR4ifIJQ
	K7gxw5zi9p7dxpWmtSwQXxF1CxyD/ZVy+SUlVVWEf7ueSFBYv4Ps+8d16cuuWdsj
	o1yLKttmiF7crn/IFIPhUzmbPrTa1HaWa2x1byrGI7QGKCF/Hz0RchbaQW774Cri
	8mJP3TAiZtSkRhXL8fG//t0yWy6zCi12mRPK7TLABTDbFW7+2WiuS1suME8S3ThE
	h0PkJ6UANb3lnlR5eqzLpK4uNw+c0IWiEzwlCpzbvg==
X-ME-Sender: <xms:nT3KZ4OFFTVMTS6A4Gk_huGTs7SF-3uDa6SXN1EOXxNSuE4kpVVOZg>
    <xme:nT3KZ--m1-YUSdaf64v3LK_MxLe2EiXf2l6Ybss46sFXtOuEhznvemf9A5KCkkf9h
    a3CacURgGDJgJ00qk8>
X-ME-Received: <xmr:nT3KZ_QlgSdbVmGyV550omzVKxigHmu5RimSyR1x48HeS-24HQ26SvZcrzEYHCOhCjEzydihr49YIyooplqi5QB5aMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:nT3KZwvN6bPCSJ_BAXagTG7fsc-gy2SbdQFc8d8XotyN-16QDMwQFw>
    <xmx:nT3KZwf0K3XXiSXNUmcRQwHIq9gOf8nlJOgEaREffzqA59ZsmJGhtg>
    <xmx:nT3KZ03NT-o8LgZA1qU2e0FP23Q70XtcvkpOqmAqnNDKgJnRG3hKtQ>
    <xmx:nT3KZ08pB_IDtfSkEysuyEbBsWisWY5x_FxaFYHVRKgOcoKRduVkMw>
    <xmx:nT3KZxrbCMKwEcAEjEG9biNdkfv_8jzTuTdM_DSOuQgh_SCeZaj3JHBx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 19:28:12 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: fix bg refcount race in btrfs_create_pending_block_groups
Date: Thu,  6 Mar 2025 16:29:01 -0800
Message-ID: <f66e903dd583274967fcd45844e6444c4a49d98b.1741306938.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741306938.git.boris@bur.io>
References: <cover.1741306938.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid a race where mark_bg_unused spuriously "moved" the block_group
from one bg_list attachment to another without taking a ref, we mark a
new block group with the bit BLOCK_GROUP_FLAG_NEW.

However, this fix is not quite complete. Since it does not use the
unused_bg_lock, it is possible for the following race to occur:

create_pending_block_groups                     mark_bg_unused
                                           if list_empty // false
        list_del_init
        clear_bit
                                           else if (test_bit) // true
                                                list_move_tail

And we get into the exact same broken ref count situation.
Those look something like:
[ 1272.943113] ------------[ cut here ]------------
[ 1272.943527] refcount_t: underflow; use-after-free.
[ 1272.943967] WARNING: CPU: 1 PID: 61 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
[ 1272.944731] Modules linked in: btrfs virtio_net xor zstd_compress raid6_pq null_blk [last unloaded: btrfs]
[ 1272.945550] CPU: 1 UID: 0 PID: 61 Comm: kworker/u32:1 Kdump: loaded Tainted: G        W          6.14.0-rc5+ #108
[ 1272.946368] Tainted: [W]=WARN
[ 1272.946585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[ 1272.947273] Workqueue: btrfs_discard btrfs_discard_workfn [btrfs]
[ 1272.947788] RIP: 0010:refcount_warn_saturate+0xba/0x110
[ 1272.948180] Code: 01 01 e8 e9 c7 a9 ff 0f 0b c3 cc cc cc cc 80 3d 3f 4a de 01 00 75 85 48 c7 c7 00 9b 9f 8f c6 05 2f 4a de 01 01 e8 c6 c7 a9 ff <0f> 0b c3 cc cc cc cc 80 3d 1d 4a de 01 00 0f 85 5e ff ff ff 48 c7
[ 1272.949532] RSP: 0018:ffffbf1200247df0 EFLAGS: 00010282
[ 1272.949901] RAX: 0000000000000000 RBX: ffffa14b00e3f800 RCX: 0000000000000000
[ 1272.950437] RDX: 0000000000000000 RSI: ffffbf1200247c78 RDI: 00000000ffffdfff
[ 1272.950986] RBP: ffffa14b00dc2860 R08: 00000000ffffdfff R09: ffffffff90526268
[ 1272.951512] R10: ffffffff904762c0 R11: 0000000063666572 R12: ffffa14b00dc28c0
[ 1272.952024] R13: 0000000000000000 R14: ffffa14b00dc2868 R15: 000001285dcd12c0
[ 1272.952850] FS:  0000000000000000(0000) GS:ffffa14d33c40000(0000) knlGS:0000000000000000
[ 1272.953458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1272.953931] CR2: 00007f838cbda000 CR3: 000000010104e000 CR4: 00000000000006f0
[ 1272.954474] Call Trace:
[ 1272.954655]  <TASK>
[ 1272.954812]  ? refcount_warn_saturate+0xba/0x110
[ 1272.955173]  ? __warn.cold+0x93/0xd7
[ 1272.955487]  ? refcount_warn_saturate+0xba/0x110
[ 1272.955816]  ? report_bug+0xe7/0x120
[ 1272.956103]  ? handle_bug+0x53/0x90
[ 1272.956424]  ? exc_invalid_op+0x13/0x60
[ 1272.956700]  ? asm_exc_invalid_op+0x16/0x20
[ 1272.957011]  ? refcount_warn_saturate+0xba/0x110
[ 1272.957399]  btrfs_discard_cancel_work.cold+0x26/0x2b [btrfs]
[ 1272.957853]  btrfs_put_block_group.cold+0x5d/0x8e [btrfs]
[ 1272.958289]  btrfs_discard_workfn+0x194/0x380 [btrfs]
[ 1272.958729]  process_one_work+0x130/0x290
[ 1272.959026]  worker_thread+0x2ea/0x420
[ 1272.959335]  ? __pfx_worker_thread+0x10/0x10
[ 1272.959644]  kthread+0xd7/0x1c0
[ 1272.959872]  ? __pfx_kthread+0x10/0x10
[ 1272.960172]  ret_from_fork+0x30/0x50
[ 1272.960474]  ? __pfx_kthread+0x10/0x10
[ 1272.960745]  ret_from_fork_asm+0x1a/0x30
[ 1272.961035]  </TASK>
[ 1272.961238] ---[ end trace 0000000000000000 ]---

Though we have seen them in the async discard workfn as well. It is
most likely to happen after a relocation finishes which cancels discard,
tears down the block group, etc.

Fix this fully by taking the lock around the list_del_init + clear_bit
so that the two are done atomically.

Fixes: 0657b20c5a76 ("btrfs: fix use-after-free of new block group that became unused")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 64f0268dcf02..2db1497b58d9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2797,8 +2797,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		/* Already aborted the transaction if it failed. */
 next:
 		btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
 		 * If the block group is still unused, add it to the list of
-- 
2.48.1



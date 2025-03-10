Return-Path: <linux-btrfs+bounces-12158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011AA5A45E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B01A3AE2A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD81D88D7;
	Mon, 10 Mar 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oa84xG+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ltfjzk7H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F671D516F
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637182; cv=none; b=KXWhj0xYrhGjbQa0sTBF55ADsCZIt47+TyiWWpevfu9rvsJFnOom6s+1yLN0HbZnj5OsIcV2jumj30GLQiz2nbCWZ5AqTbRYHz2ZtqcZO29Iza3Gb/g4CX9FL6Fen/9NhMGnFrvO4tWfhbjTlYB1Zc3mK03aPaiDfnhvXx0avLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637182; c=relaxed/simple;
	bh=aBOccwu3njph4qI3KdmxQ73Wn4HiwIA1XiT3mWFDgPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMryFfl08G+/9J7I/7gLWqx8okxSgMUKKO7sym7Aa0NTPwzAdLGbUNmTIceHkGCbmf5W0k3mJW5f6yMIblMNougMSwGR+s2+6QCt1hvzMDOJkT38xOQ6Qj6zU75ccQL5BqluzpzO0/ruzbt4NJH6SggIo3E9cmDjuRIV6vXTbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oa84xG+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ltfjzk7H; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 572EB25401FD;
	Mon, 10 Mar 2025 16:06:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 16:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741637179; x=
	1741723579; bh=XOkQByygIMeEPz4kNTEJu6JOZwkpBTKy+JPLWK2W5T4=; b=o
	a84xG+K+GlAVq2EwvP0UfGZGRF9zH7Fgw5Ak/iBNZoZjNxScdC2TfBOI8HQQCWSW
	hqRMznWKUjrdxAK540Bo+YtgiGmZ+FyTzUYxqoDPxVGDvht2JK1MV+jkVUTZq2xk
	hCRH8iAno9hzqIBIY5N5UcrYMVGnAVkfxjPSJJoA+jDCoz7q2iSxP3j2PJcz9JgH
	t+wW5N6hzMSxFFULDImFAXhr/CWoy53Z0+G7E4MEmWvG8N07Vn6CGzg/skXrm7mp
	UmSRqw086Fi338BIhODpxecODg7JGqR9kEU5qw19AxYSKbKBtgorxXScuReuVAGE
	hMTuVCWBw8Fjb5YxuHKXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741637179; x=1741723579; bh=XOkQByygIMeEPz4kNTEJu6JOZwkp
	BTKy+JPLWK2W5T4=; b=ltfjzk7HCaPDi5qDzJTTNSGZb3eCWekDTFk9qdt/wtnR
	kSPo3Rclfbk6rG7sJUNc0rMdNK42MQc1hHCXw65FRVnTMRRhGqvMrjpeEbzdPV1G
	vBwhCqz20aCMdDYnT0mD2OmYyqIofkj8MS6veuUrBGxyL85Han5U4VK+sClm1SH4
	t6M70cA2DDhkhg3K3g8bkuhhmH5O9xcBp9OsvxYBIhZyopVBTEB/Vkc46kXhCt8r
	UjPpb4JKNebcWDoFm6n1oSdrcjm+1JIb2GcWr9ijUxJkd0oq6yFtrOy1nHdiLEpJ
	yq+rPr8zeG5BlJrowU3PsLhbLMQRM+vTwegJSEJJcQ==
X-ME-Sender: <xms:O0bPZ0qnF-5i94M8Itz6D9mxo7p1H7wsoUM7k8swIMpOBqTldK-o9w>
    <xme:O0bPZ6rSjEy3bcz0nDLWCfmTtNunnt8Fk6C_ovKEr5zoBjhNT9y4d7d3_trkf52bS
    PfnPBB-wcGv8HlCZbc>
X-ME-Received: <xmr:O0bPZ5PGUrVb-dMavThOeRuNuIXvv-gZyNBGNm9XcO_1L3MYxKTtNhM6QDG8JQy7-U66neYa_8xfzCSOypo81ZK2jOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:O0bPZ74KDmFMVdMIe_tMiNyMyKJGN6RahyBoDnZUepejvsen8FOIQw>
    <xmx:O0bPZz4LDdhB5RdYAct5wcaMeHzo5o_g1UxXOg5fIyzElocM0nzV_A>
    <xmx:O0bPZ7gZtlcQhTuU5Q1wfSRG3r3Yjw9nDszuPUK6K76saSLi99evEw>
    <xmx:O0bPZ97U4ataUOJ3fCNoWjpJwwFBrzxNn0x5h86jjT1TgO9cbzJ9HQ>
    <xmx:O0bPZzECa9J1s0rprucdg9-HQa0cWjLe0wpPppIjbfumwLpiIEA4VsyQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:06:18 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/5] btrfs: fix bg refcount race in btrfs_create_pending_block_groups
Date: Mon, 10 Mar 2025 13:07:01 -0700
Message-ID: <498b58b794722c70eca58bf3fe46003c43e60aff.1741636986.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741636986.git.boris@bur.io>
References: <cover.1741636986.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block group creation is done in two phases, which results in a slightly
unintiuitive property: a block group can be allocated/deallocated from
after btrfs_make_block_group adds it to the space_info with
btrfs_add_bg_to_space_info, but before creation is completely completed
in btrfs_create_pending_block_groups. As a result, it is possible for a
block group to go unused and have 'btrfs_mark_bg_unused' called on it
concurrently with 'btrfs_create_pending_block_groups'. This causes a
number of issues, which were fixed with the block group flag
'BLOCK_GROUP_FLAG_NEW'.

However, this fix is not quite complete. Since it does not use the
unused_bg_lock, it is possible for the following race to occur:

btrfs_create_pending_block_groups            btrfs_mark_bg_unused
                                           if list_empty // false
        list_del_init
        clear_bit
                                           else if (test_bit) // true
                                                list_move_tail

And we get into the exact same broken ref count and invalid new_bgs
state for transaction cleanup that BLOCK_GROUP_FLAG_NEW was designed to
prevent.

The broken refcount aspect will result in a warning like:
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
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



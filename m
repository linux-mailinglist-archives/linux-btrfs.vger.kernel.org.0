Return-Path: <linux-btrfs+bounces-8225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C4985896
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 13:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A08A1F2356C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291418FC83;
	Wed, 25 Sep 2024 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeCZ1cwo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1318F2FB;
	Wed, 25 Sep 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264270; cv=none; b=Fmb7anrqk9ZSNAUAKsdRjP7ISX8IszfBN1ezLLqSGpr9VOgF4f6pyTBC329olZmML+iZHncJ5Fl3YkJuQ7JlOjtTG+LZphp0MdaKguDTez8HRVPv3Gc4epRJ0tWdU5+0HiMlR2xIyPbqCtteaB+5cZvt1/GW6tJ8YiFK9JLi4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264270; c=relaxed/simple;
	bh=1tTVDgLw7Rm3X5pUHOpL916SUzK3+Ur11aNPQtmBTD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibP2udxSByOPfgCQFV0xc1Lyotju5M8eq5FIdyYEJzo3i4m4qEuApILLe0otVX7IKm+et/x/S2pGMI6kcdx7XriKJcpls8bXrSN321sWkRpFXaACJIetByGhLrY+BUCx4asO9/DyXzsSvOO1/iBDMszyypj6Ul2x6cR1ghoZrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeCZ1cwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F88EC4CEC3;
	Wed, 25 Sep 2024 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264269;
	bh=1tTVDgLw7Rm3X5pUHOpL916SUzK3+Ur11aNPQtmBTD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeCZ1cwo+beoxEFDQxBHiBha+7XI/jg9SjG/Pt2xjJLQEy9ecJLRfKLVxWSyKql9B
	 +6OE00elK+g7d+tPY21uUcW4Yquyo3VAUaui4y3WS6vXkbDbpcYPihzCqmjuT4qmIG
	 t+kt6W6mWW2dAW/H7+Ah8MFPj5N6j75e/PgAIP+rCmV+6TAnGi0T3gwS8u3M/g+JE1
	 q4AZ57mEJ1Qxsf/F9ZeLWNsjqDPr2v8p96kfepNYHNNKmYmcmOR7UijB2bXLAaS6im
	 CyNvBiZ5tbLDzdR1GX5LyxxUw7U6IGVlBcxhstZZdb0lKGjUqF7Wpg/F9yrfx1asDn
	 OVr6whwDuDQVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 031/244] btrfs: don't readahead the relocation inode on RST
Date: Wed, 25 Sep 2024 07:24:12 -0400
Message-ID: <20240925113641.1297102-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <jthumshirn@wdc.com>

[ Upstream commit 04915240e2c3a018e4c7f23418478d27226c8957 ]

On relocation we're doing readahead on the relocation inode, but if the
filesystem is backed by a RAID stripe tree we can get ENOENT (e.g. due to
preallocated extents not being mapped in the RST) from the lookup.

But readahead doesn't handle the error and submits invalid reads to the
device, causing an assertion in the scatter-gather list code:

  BTRFS info (device nvme1n1): balance: start -d -m -s
  BTRFS info (device nvme1n1): relocating block group 6480920576 flags data|raid0
  BTRFS error (device nvme1n1): cannot find raid-stripe for logical [6481928192, 6481969152] devid 2, profile raid0
  ------------[ cut here ]------------
  kernel BUG at include/linux/scatterlist.h:115!
  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 1012 Comm: btrfs Not tainted 6.10.0-rc7+ #567
  RIP: 0010:__blk_rq_map_sg+0x339/0x4a0
  RSP: 0018:ffffc90001a43820 EFLAGS: 00010202
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea00045d4802
  RDX: 0000000117520000 RSI: 0000000000000000 RDI: ffff8881027d1000
  RBP: 0000000000003000 R08: ffffea00045d4902 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000001000 R12: ffff8881003d10b8
  R13: ffffc90001a438f0 R14: 0000000000000000 R15: 0000000000003000
  FS:  00007fcc048a6900(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000002cd11000 CR3: 00000001109ea001 CR4: 0000000000370eb0
  Call Trace:
   <TASK>
   ? __die_body.cold+0x14/0x25
   ? die+0x2e/0x50
   ? do_trap+0xca/0x110
   ? do_error_trap+0x65/0x80
   ? __blk_rq_map_sg+0x339/0x4a0
   ? exc_invalid_op+0x50/0x70
   ? __blk_rq_map_sg+0x339/0x4a0
   ? asm_exc_invalid_op+0x1a/0x20
   ? __blk_rq_map_sg+0x339/0x4a0
   nvme_prep_rq.part.0+0x9d/0x770
   nvme_queue_rq+0x7d/0x1e0
   __blk_mq_issue_directly+0x2a/0x90
   ? blk_mq_get_budget_and_tag+0x61/0x90
   blk_mq_try_issue_list_directly+0x56/0xf0
   blk_mq_flush_plug_list.part.0+0x52b/0x5d0
   __blk_flush_plug+0xc6/0x110
   blk_finish_plug+0x28/0x40
   read_pages+0x160/0x1c0
   page_cache_ra_unbounded+0x109/0x180
   relocate_file_extent_cluster+0x611/0x6a0
   ? btrfs_search_slot+0xba4/0xd20
   ? balance_dirty_pages_ratelimited_flags+0x26/0xb00
   relocate_data_extent.constprop.0+0x134/0x160
   relocate_block_group+0x3f2/0x500
   btrfs_relocate_block_group+0x250/0x430
   btrfs_relocate_chunk+0x3f/0x130
   btrfs_balance+0x71b/0xef0
   ? kmalloc_trace_noprof+0x13b/0x280
   btrfs_ioctl+0x2c2e/0x3030
   ? kvfree_call_rcu+0x1e6/0x340
   ? list_lru_add_obj+0x66/0x80
   ? mntput_no_expire+0x3a/0x220
   __x64_sys_ioctl+0x96/0xc0
   do_syscall_64+0x54/0x110
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fcc04514f9b
  Code: Unable to access opcode bytes at 0x7fcc04514f71.
  RSP: 002b:00007ffeba923370 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcc04514f9b
  RDX: 00007ffeba923460 RSI: 00000000c4009420 RDI: 0000000000000003
  RBP: 0000000000000000 R08: 0000000000000013 R09: 0000000000000001
  R10: 00007fcc043fbba8 R11: 0000000000000246 R12: 00007ffeba924fc5
  R13: 00007ffeba923460 R14: 0000000000000002 R15: 00000000004d4bb0
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:__blk_rq_map_sg+0x339/0x4a0
  RSP: 0018:ffffc90001a43820 EFLAGS: 00010202
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffea00045d4802
  RDX: 0000000117520000 RSI: 0000000000000000 RDI: ffff8881027d1000
  RBP: 0000000000003000 R08: ffffea00045d4902 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000001000 R12: ffff8881003d10b8
  R13: ffffc90001a438f0 R14: 0000000000000000 R15: 0000000000003000
  FS:  00007fcc048a6900(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fcc04514f71 CR3: 00000001109ea001 CR4: 0000000000370eb0
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled
  ---[ end Kernel panic - not syncing: Fatal exception ]---

So in case of a relocation on a RAID stripe-tree based file system, skip
the readahead.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0533d0f82dc99..ea4ed85919ec8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -36,6 +36,7 @@
 #include "relocation.h"
 #include "super.h"
 #include "tree-checker.h"
+#include "raid-stripe-tree.h"
 
 /*
  * Relocation overview
@@ -2965,21 +2966,34 @@ static int relocate_one_folio(struct reloc_control *rc,
 	u64 folio_end;
 	u64 cur;
 	int ret;
+	const bool use_rst = btrfs_need_stripe_tree_update(fs_info, rc->block_group->flags);
 
 	ASSERT(index <= last_index);
 	folio = filemap_lock_folio(inode->i_mapping, index);
 	if (IS_ERR(folio)) {
-		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
-					  index, last_index + 1 - index);
+
+		/*
+		 * On relocation we're doing readahead on the relocation inode,
+		 * but if the filesystem is backed by a RAID stripe tree we can
+		 * get ENOENT (e.g. due to preallocated extents not being
+		 * mapped in the RST) from the lookup.
+		 *
+		 * But readahead doesn't handle the error and submits invalid
+		 * reads to the device, causing a assertion failures.
+		 */
+		if (!use_rst)
+			page_cache_sync_readahead(inode->i_mapping, ra, NULL,
+						  index, last_index + 1 - index);
 		folio = __filemap_get_folio(inode->i_mapping, index,
-					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					    mask);
 		if (IS_ERR(folio))
 			return PTR_ERR(folio);
 	}
 
 	WARN_ON(folio_order(folio));
 
-	if (folio_test_readahead(folio))
+	if (folio_test_readahead(folio) && !use_rst)
 		page_cache_async_readahead(inode->i_mapping, ra, NULL,
 					   folio, last_index + 1 - index);
 
-- 
2.43.0



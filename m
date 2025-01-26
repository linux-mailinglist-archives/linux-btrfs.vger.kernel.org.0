Return-Path: <linux-btrfs+bounces-11066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCDA1C88D
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF601885E12
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B818DF81;
	Sun, 26 Jan 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI5vFF7B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE518B47D;
	Sun, 26 Jan 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902933; cv=none; b=YPqazUMQchEpCiUGbWHzwPx8NMeGeKWKtcUhZWxCeoDJOwc5uNDT2dPRqoVWNKs5WpIYmpleVBk3fSNhABPt30+81R4KsxVQ9Su6iqbZacYibCfezCptRS2HRplb24PshFEGEx38rZHphddzoBROuRwmGoRvluZrRaZ139+yHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902933; c=relaxed/simple;
	bh=2gmemECWsndGRjQnD9PCwSWjA7xO5sA3iG5Euqso2kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLbvMXT75W9WEZJkuMvMfwbDxy2IZtYBJ3JA2slrOsZEUwWdvKSZdN9U3OM8WZ9EQn+qNBjo9DbmOB+LkLdZlE7/1ONpsq1OKtsXh9R8GItXgpObB8RtMb5lZ0S4FAyUoBX6YXWCCo/cIaOka4cUp5W/VcX2K2Qh9stk9Mg3FNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI5vFF7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0E2C4CEE3;
	Sun, 26 Jan 2025 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902932;
	bh=2gmemECWsndGRjQnD9PCwSWjA7xO5sA3iG5Euqso2kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rI5vFF7Bgu9E7ijhLDTnIZvPoDXbPHy0oTBju9dCK9Xytuc9ECkfSAEnjeWjDGMNB
	 qWNmuKYJwDExpSJaxPlbdAW1woTCK05P+//VvFdOjm0VUjw7YLUSkl1vTXyo3Wr341
	 xSIpud7BxvS4m5VwkqX1p9rb08fqZjKFlORUDHy/FyiocPf6kHfuUhq00NJSVPahzj
	 7MQIpW0iC0rWCaQqhil14jYuBiWRESFQQZ+yzKUddUzXHt1upXj1Bal0LG9rlLkhtH
	 lHNuMQ0N7AuNWUYsHU6fNj0KqeEjy5RPvFaojg8KHzYBzmbYH8Xuv/BwQ0HGmjLkqb
	 CaAT4Hd85G4QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 7/7] btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
Date: Sun, 26 Jan 2025 09:48:38 -0500
Message-Id: <20250126144839.925271-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144839.925271-1-sashal@kernel.org>
References: <20250126144839.925271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit dc14ba10781bd2629835696b7cc1febf914768e9 ]

Don't use btrfs_set_item_key_safe() to modify the keys in the RAID
stripe-tree, as this can lead to corruption of the tree, which is caught
by the checks in btrfs_set_item_key_safe():

 BTRFS info (device nvme1n1): leaf 49168384 gen 15 total ptrs 194 free space 8329 owner 12
 BTRFS info (device nvme1n1): refs 2 lock_owner 1030 current 1030
  [ snip ]
  item 105 key (354549760 230 20480) itemoff 14587 itemsize 16
                  stride 0 devid 5 physical 67502080
  item 106 key (354631680 230 4096) itemoff 14571 itemsize 16
                  stride 0 devid 1 physical 88559616
  item 107 key (354631680 230 32768) itemoff 14555 itemsize 16
                  stride 0 devid 1 physical 88555520
  item 108 key (354717696 230 28672) itemoff 14539 itemsize 16
                  stride 0 devid 2 physical 67604480
  [ snip ]
 BTRFS critical (device nvme1n1): slot 106 key (354631680 230 32768) new key (354635776 230 4096)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.c:2602!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 UID: 0 PID: 1055 Comm: fsstress Not tainted 6.13.0-rc1+ #1464
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 RIP: 0010:btrfs_set_item_key_safe+0xf7/0x270
 Code: <snip>
 RSP: 0018:ffffc90001337ab0 EFLAGS: 00010287
 RAX: 0000000000000000 RBX: ffff8881115fd000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000ffffffff
 RBP: ffff888110ed6f50 R08: 00000000ffffefff R09: ffffffff8244c500
 R10: 00000000ffffefff R11: 00000000ffffffff R12: ffff888100586000
 R13: 00000000000000c9 R14: ffffc90001337b1f R15: ffff888110f23b58
 FS:  00007f7d75c72740(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa811652c60 CR3: 0000000111398001 CR4: 0000000000370eb0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x14/0x1a
  ? die+0x2e/0x50
  ? do_trap+0xca/0x110
  ? do_error_trap+0x65/0x80
  ? btrfs_set_item_key_safe+0xf7/0x270
  ? exc_invalid_op+0x50/0x70
  ? btrfs_set_item_key_safe+0xf7/0x270
  ? asm_exc_invalid_op+0x1a/0x20
  ? btrfs_set_item_key_safe+0xf7/0x270
  btrfs_partially_delete_raid_extent+0xc4/0xe0
  btrfs_delete_raid_extent+0x227/0x240
  __btrfs_free_extent.isra.0+0x57f/0x9c0
  ? exc_coproc_segment_overrun+0x40/0x40
  __btrfs_run_delayed_refs+0x2fa/0xe80
  btrfs_run_delayed_refs+0x81/0xe0
  btrfs_commit_transaction+0x2dd/0xbe0
  ? preempt_count_add+0x52/0xb0
  btrfs_sync_file+0x375/0x4c0
  do_fsync+0x39/0x70
  __x64_sys_fsync+0x13/0x20
  do_syscall_64+0x54/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f7d7550ef90
 Code: <snip>
 RSP: 002b:00007ffd70237248 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
 RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d7550ef90
 RDX: 000000000000013a RSI: 000000000040eb28 RDI: 0000000000000004
 RBP: 000000000000001b R08: 0000000000000078 R09: 00007ffd7023725c
 R10: 00007f7d75400390 R11: 0000000000000202 R12: 028f5c28f5c28f5c
 R13: 8f5c28f5c28f5c29 R14: 000000000040b520 R15: 00007f7d75c726c8
  </TASK>

While the root cause of the tree order corruption isn't clear, using
btrfs_duplicate_item() to copy the item and then adjusting both the key
and the per-device physical addresses is a safe way to counter this
problem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9ffc79f250fbb..10781c015ee8d 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -13,12 +13,13 @@
 #include "volumes.h"
 #include "print-tree.h"
 
-static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
+static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 					       struct btrfs_path *path,
 					       const struct btrfs_key *oldkey,
 					       u64 newlen, u64 frontpad)
 {
-	struct btrfs_stripe_extent *extent;
+	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
+	struct btrfs_stripe_extent *extent, *newitem;
 	struct extent_buffer *leaf;
 	int slot;
 	size_t item_size;
@@ -27,23 +28,38 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.type = BTRFS_RAID_STRIPE_KEY,
 		.offset = newlen,
 	};
+	int ret;
 
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
 
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	item_size = btrfs_item_size(leaf, slot);
+
+	newitem = kzalloc(item_size, GFP_NOFS);
+	if (!newitem)
+		return -ENOMEM;
+
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
 
 	for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
 		struct btrfs_raid_stride *stride = &extent->strides[i];
 		u64 phys;
 
-		phys = btrfs_raid_stride_physical(leaf, stride);
-		btrfs_set_raid_stride_physical(leaf, stride, phys + frontpad);
+		phys = btrfs_raid_stride_physical(leaf, stride) + frontpad;
+		btrfs_set_stack_raid_stride_physical(&newitem->strides[i], phys);
 	}
 
-	btrfs_set_item_key_safe(trans, path, &newkey);
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto out;
+
+	btrfs_release_path(path);
+	ret = btrfs_insert_item(trans, stripe_root, &newkey, newitem, item_size);
+
+out:
+	kfree(newitem);
+	return ret;
 }
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
-- 
2.39.5



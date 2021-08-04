Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1573DF9C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 04:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhHDCta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 22:49:30 -0400
Received: from mail.synology.com ([211.23.38.101]:34024 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhHDCt3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Aug 2021 22:49:29 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id BCFDC2E7C7D6;
        Wed,  4 Aug 2021 10:49:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1628045356; bh=R8S6qBj9HXmslu6hVjv0JQs76b6GwuoypjvZXvVRyuQ=;
        h=From:To:Cc:Subject:Date;
        b=gyq6IuArVRwDoec7+WU7bbrIkHmQNywJvTcKY0XV7VLAiC+sHWqlTviT4EU9o6PT2
         DKo1vKc+u8SBDU/vaZVMyViS7d51PwhDIBMN2VDZwOF1ny/5ybLDc5xVs+Kc/S0e5T
         IRwsq0R6tMotZDyPUDjNPltAwgZc6ZKXiwuQBlrQ=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2] btrfs: fix root drop key inconsistent when drop subvolume/snapshot fails
Date:   Wed,  4 Aug 2021 10:49:04 +0800
Message-Id: <20210804024904.2598-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When walk down/up tree fails, we did not aborting the transaction,
nor did modify the root drop key, but the refs of some tree blocks
may have been removed in the transaction.

Therefore when we retry to delete the subvolume in the future,
we will fail due to the fact that some references were deleted
in the previous attempt.

------------[ cut here ]------------
WARNING: at fs/btrfs/extent-tree.c:898 btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]()
CPU: 2 PID: 11618 Comm: btrfs-cleaner Tainted: P
Hardware name: Synology Inc. RS3617xs Series/Type2 - Board Product Name1, BIOS M.017 2019/10/16
ffffffff814c2246 ffffffff81036536 ffff88024a911d08 ffff880262de45b0
ffff8802448b5f20 ffff88024a9c1ad8 0000000000000000 ffffffffa08eb05a
000008f84e72c000 0000000000000000 0000000000000001 0000000100000000
Call Trace:
[<ffffffff814c2246>] ? dump_stack+0xc/0x15
[<ffffffff81036536>] ? warn_slowpath_common+0x56/0x70
[<ffffffffa08eb05a>] ? btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]
[<ffffffffa08ee558>] ? do_walk_down+0x128/0x750 [btrfs]
[<ffffffffa08ebab4>] ? walk_down_proc+0x314/0x330 [btrfs]
[<ffffffffa08eec42>] ? walk_down_tree+0xc2/0xf0 [btrfs]
[<ffffffffa08f2bce>] ? btrfs_drop_snapshot+0x40e/0x9a0 [btrfs]
[<ffffffffa09096db>] ? btrfs_clean_one_deleted_snapshot+0xab/0xe0 [btrfs]
[<ffffffffa08fe970>] ? cleaner_kthread+0x280/0x320 [btrfs]
[<ffffffff81052eaf>] ? kthread+0xaf/0xc0
[<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
[<ffffffff814c8c0d>] ? ret_from_fork+0x5d/0xb0
[<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
------------[ end trace ]-----------
BTRFS error (device dm-1): Missing references.
BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=-5 IO failure

By not aborting the transaction, every future attempt to delete the
subvolume fails and we end up never freeing all the extents used by
the subvolume/snapshot.

By aborting the transaction we have a least the possibility to
succeeded after unmounting and mounting again the filesystem.

So we fix this problem by aborting the transaction when the walk down/up
tree fails, which is a safer approach.

In addition, we also added the initialization of drop_progress and
drop_level.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent-tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 268ce58d4569..032a257fdb65 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5539,10 +5539,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		path->locks[level] = BTRFS_WRITE_LOCK;
 		memset(&wc->update_progress, 0,
 		       sizeof(wc->update_progress));
+		memset(&wc->drop_progress, 0,
+		       sizeof(wc->drop_progress));
 	} else {
 		btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
 		memcpy(&wc->update_progress, &key,
 		       sizeof(wc->update_progress));
+		memcpy(&wc->drop_progress, &key,
+		       sizeof(wc->drop_progress));
 
 		level = btrfs_root_drop_level(root_item);
 		BUG_ON(level == 0);
@@ -5588,6 +5592,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 	wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 	wc->level = level;
+	wc->drop_level = level;
 	wc->shared_level = -1;
 	wc->stage = DROP_REFERENCE;
 	wc->update_ref = update_ref;
@@ -5659,8 +5664,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		}
 	}
 	btrfs_release_path(path);
-	if (err)
+	if (err) {
+		btrfs_abort_transaction(trans, err);
 		goto out_end_trans;
+	}
 
 	ret = btrfs_del_root(trans, &root->root_key);
 	if (ret) {
-- 
2.17.1


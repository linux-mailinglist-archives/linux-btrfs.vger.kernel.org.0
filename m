Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9E25F98
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfEVIdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728528AbfEVIdS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34388AF8C
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2019 08:33:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reloc: Also queue orphan reloc tree for cleanup to avoid BUG_ON()
Date:   Wed, 22 May 2019 16:33:11 +0800
Message-Id: <20190522083311.32105-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When a fs has orphan reloc tree along with unfinished balance:
  ...
        item 16 key (TREE_RELOC ROOT_ITEM FS_TREE) itemoff 12090 itemsize 439
                generation 12 root_dirid 256 bytenr 300400640 level 1 refs 0 <<<
                lastsnap 8 byte_limit 0 bytes_used 1359872 flags 0x0(none)
                uuid 7c48d938-33a3-4aae-ab19-6e5c9d406e46
        item 17 key (BALANCE TEMPORARY_ITEM 0) itemoff 11642 itemsize 448
                temporary item objectid BALANCE offset 0
                balance status flags 14

Then at mount time, we can hit the following kernel BUG_ON():
  BTRFS info (device dm-3): relocating block group 298844160 flags metadata|dup
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/relocation.c:1413!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 897 Comm: btrfs-balance Tainted: G           O      5.2.0-rc1-custom #15
  RIP: 0010:create_reloc_root+0x1eb/0x200 [btrfs]
  Call Trace:
   btrfs_init_reloc_root+0x96/0xb0 [btrfs]
   record_root_in_trans+0xb2/0xe0 [btrfs]
   btrfs_record_root_in_trans+0x55/0x70 [btrfs]
   select_reloc_root+0x7e/0x230 [btrfs]
   do_relocation+0xc4/0x620 [btrfs]
   relocate_tree_blocks+0x592/0x6a0 [btrfs]
   relocate_block_group+0x47b/0x5d0 [btrfs]
   btrfs_relocate_block_group+0x183/0x2f0 [btrfs]
   btrfs_relocate_chunk+0x4e/0xe0 [btrfs]
   btrfs_balance+0x864/0xfa0 [btrfs]
   balance_kthread+0x3b/0x50 [btrfs]
   kthread+0x123/0x140
   ret_from_fork+0x27/0x50

[CAUSE]
In btrfs, reloc trees are used to record swapped tree blocks during
balance.
Reloc tree either get merged (replace old tree blocks of its parent
subvolume) in next transaction if its ref is 1 (fresh).
Or is already merged and will be cleaned up if its ref is 0 (orphan).

After commit d2311e698578 ("btrfs: relocation: Delay reloc tree deletion
after merge_reloc_roots"), reloc tree cleanup is delayed until one block
group is balanced.

Since fresh reloc roots are recorded during merge, as long as there
is no power loss, those orphan reloc roots converted from fresh ones are
handled without problem.

However when power loss happens, orphan reloc roots can be recorded
on-disk, thus at next mount time, we will have orphan reloc roots from
on-disk data directly, and ignored by clean_dirty_subvols() routine.

Then when background balance starts to balance another block group, and
needs to create new reloc root for the same root, btrfs_insert_item()
returns -EEXIST, and trigger that BUG_ON().

[FIX]
For orphan reloc roots, also queue them to rc->dirty_subvol_roots, so
all reloc roots no matter orphan or not, can be cleaned up properly and
avoid above BUG_ON().

And to cooperate with above change, clean_dirty_subvols() will check if
the queued root is a reloc root or a subvol root.
For a subvol root, do the old work, and for a orphan reloc root, clean it
up.

Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a459ecddcce4..22a3c69864fa 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2177,22 +2177,30 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 	struct btrfs_root *root;
 	struct btrfs_root *next;
 	int ret = 0;
+	int ret2;
 
 	list_for_each_entry_safe(root, next, &rc->dirty_subvol_roots,
 				 reloc_dirty_list) {
-		struct btrfs_root *reloc_root = root->reloc_root;
+		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
+			/* Merged subvolume, cleanup its reloc root */
+			struct btrfs_root *reloc_root = root->reloc_root;
 
-		clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
-		list_del_init(&root->reloc_dirty_list);
-		root->reloc_root = NULL;
-		if (reloc_root) {
-			int ret2;
+			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+			list_del_init(&root->reloc_dirty_list);
+			root->reloc_root = NULL;
+			if (reloc_root) {
 
-			ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
+				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
+				if (ret2 < 0 && !ret)
+					ret = ret2;
+			}
+			btrfs_put_fs_root(root);
+		} else {
+			/* Orphan reloc tree, just clean it up */
+			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1);
 			if (ret2 < 0 && !ret)
 				ret = ret2;
 		}
-		btrfs_put_fs_root(root);
 	}
 	return ret;
 }
@@ -2480,6 +2488,9 @@ void merge_reloc_roots(struct reloc_control *rc)
 			}
 		} else {
 			list_del_init(&reloc_root->root_list);
+			/* Don't forget to queue this reloc root for cleanup */
+			list_add_tail(&reloc_root->reloc_dirty_list,
+				      &rc->dirty_subvol_roots);
 		}
 	}
 
-- 
2.21.0


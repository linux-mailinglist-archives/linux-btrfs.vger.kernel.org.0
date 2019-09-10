Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C958AE4C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfIJHk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 03:40:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729189AbfIJHkZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 03:40:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B98AB01D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:40:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: ctree: Reduce one indent level for btrfs_search_slot()
Date:   Tue, 10 Sep 2019 15:40:17 +0800
Message-Id: <20190910074019.23158-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910074019.23158-1-wqu@suse.com>
References: <20190910074019.23158-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_search_slot(), we something like:

	if (level != 0) {
		/* Do search inside tree nodes*/
	} else {
		/* Do search inside tree leaves */
		goto done;
	}

This caused extra indent for tree node search code.
Change it to something like:

	if (level == 0) {
		/* Do search inside tree leaves */
		goto done'
	}
	/* Do search inside tree nodes */

So we have more space to maneuver our code, this is especially useful as
the tree nodes search code is more complex than the leaves search code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c | 139 +++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5df76c17775a..1e29183cdf62 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2761,6 +2761,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 
 	while (b) {
+		int dec = 0;
 		level = btrfs_header_level(b);
 
 		/*
@@ -2837,75 +2838,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (ret < 0)
 			goto done;
 
-		if (level != 0) {
-			int dec = 0;
-			if (ret && slot > 0) {
-				dec = 1;
-				slot -= 1;
-			}
-			p->slots[level] = slot;
-			err = setup_nodes_for_search(trans, root, p, b, level,
-					     ins_len, &write_lock_level);
-			if (err == -EAGAIN)
-				goto again;
-			if (err) {
-				ret = err;
-				goto done;
-			}
-			b = p->nodes[level];
-			slot = p->slots[level];
-
-			/*
-			 * slot 0 is special, if we change the key
-			 * we have to update the parent pointer
-			 * which means we must have a write lock
-			 * on the parent
-			 */
-			if (slot == 0 && ins_len &&
-			    write_lock_level < level + 1) {
-				write_lock_level = level + 1;
-				btrfs_release_path(p);
-				goto again;
-			}
-
-			unlock_up(p, level, lowest_unlock,
-				  min_write_lock_level, &write_lock_level);
-
-			if (level == lowest_level) {
-				if (dec)
-					p->slots[level]++;
-				goto done;
-			}
-
-			err = read_block_for_search(root, p, &b, level,
-						    slot, key);
-			if (err == -EAGAIN)
-				goto again;
-			if (err) {
-				ret = err;
-				goto done;
-			}
-
-			if (!p->skip_locking) {
-				level = btrfs_header_level(b);
-				if (level <= write_lock_level) {
-					err = btrfs_try_tree_write_lock(b);
-					if (!err) {
-						btrfs_set_path_blocking(p);
-						btrfs_tree_lock(b);
-					}
-					p->locks[level] = BTRFS_WRITE_LOCK;
-				} else {
-					err = btrfs_tree_read_lock_atomic(b);
-					if (!err) {
-						btrfs_set_path_blocking(p);
-						btrfs_tree_read_lock(b);
-					}
-					p->locks[level] = BTRFS_READ_LOCK;
-				}
-				p->nodes[level] = b;
-			}
-		} else {
+		if (level == 0) {
 			p->slots[level] = slot;
 			if (ins_len > 0 &&
 			    btrfs_leaf_free_space(b) < ins_len) {
@@ -2916,8 +2849,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				}
 
 				btrfs_set_path_blocking(p);
-				err = split_leaf(trans, root, key,
-						 p, ins_len, ret == 0);
+				err = split_leaf(trans, root, key, p, ins_len,
+						 ret == 0);
 
 				BUG_ON(err > 0);
 				if (err) {
@@ -2930,6 +2863,70 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 					  min_write_lock_level, NULL);
 			goto done;
 		}
+
+		if (ret && slot > 0) {
+			dec = 1;
+			slot -= 1;
+		}
+		p->slots[level] = slot;
+		err = setup_nodes_for_search(trans, root, p, b, level, ins_len,
+					     &write_lock_level);
+		if (err == -EAGAIN)
+			goto again;
+		if (err) {
+			ret = err;
+			goto done;
+		}
+		b = p->nodes[level];
+		slot = p->slots[level];
+
+		/*
+		 * slot 0 is special, if we change the key we have to update
+		 * the parent pointer which means we must have a write lock
+		 * on the parent
+		 */
+		if (slot == 0 && ins_len && write_lock_level < level + 1) {
+			write_lock_level = level + 1;
+			btrfs_release_path(p);
+			goto again;
+		}
+
+		unlock_up(p, level, lowest_unlock, min_write_lock_level,
+			  &write_lock_level);
+
+		if (level == lowest_level) {
+			if (dec)
+				p->slots[level]++;
+			goto done;
+		}
+
+		err = read_block_for_search(root, p, &b, level, slot, key);
+		if (err == -EAGAIN)
+			goto again;
+		if (err) {
+			ret = err;
+			goto done;
+		}
+
+		if (!p->skip_locking) {
+			level = btrfs_header_level(b);
+			if (level <= write_lock_level) {
+				err = btrfs_try_tree_write_lock(b);
+				if (!err) {
+					btrfs_set_path_blocking(p);
+					btrfs_tree_lock(b);
+				}
+				p->locks[level] = BTRFS_WRITE_LOCK;
+			} else {
+				err = btrfs_tree_read_lock_atomic(b);
+				if (!err) {
+					btrfs_set_path_blocking(p);
+					btrfs_tree_read_lock(b);
+				}
+				p->locks[level] = BTRFS_READ_LOCK;
+			}
+			p->nodes[level] = b;
+		}
 	}
 	ret = 1;
 done:
-- 
2.23.0


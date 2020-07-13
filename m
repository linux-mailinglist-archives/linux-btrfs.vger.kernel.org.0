Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7E21D3F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGMKu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 06:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgGMKu5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 06:50:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2719AE53;
        Mon, 13 Jul 2020 10:50:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 1/3] btrfs: qgroup: allow btrfs_qgroup_reserve_data() to revert the range it just set without releasing other existing ranges
Date:   Mon, 13 Jul 2020 18:50:47 +0800
Message-Id: <20200713105049.90663-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713105049.90663-1-wqu@suse.com>
References: <20200713105049.90663-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
reserved space of the changeset.

For example:
	ret = btrfs_qgroup_reserve_data(inode, changeset, 0, SZ_1M);
	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_1M, SZ_1M);
	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_2M, SZ_1M);

If the last btrfs_qgroup_reserve_data() failed, it will release all [0,
3M) range.

This behavior is kinda OK for now, as when we hit -EDQUOT, we normally
go error handling and need to release all reserved ranges anyway.

But this also means the following call is not possible:
	ret = btrfs_qgroup_reserve_data();
	if (ret == -EDQUOT) {
		/* Do something to free some qgroup space */
		ret = btrfs_qgroup_reserve_data();
	}

As if the first btrfs_qgroup_reserve_data() fails, it will free all
reserved qgroup space.

[CAUSE]
This is because we release all reserved ranges when
btrfs_qgroup_reserve_data() fails.

[FIX]
This patch will implement a new function, qgroup_unreserve_range(), to
iterate through the ulist nodes, to find any nodes in the failure range,
and remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
the extent_changeset::bytes_changed, so that we can revert to previous
status.

This allows later patches to retry btrfs_qgroup_reserve_data() if EDQUOT
happens.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 90 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ee0ad33b659c..28bf9bb6746f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3447,6 +3447,71 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
 	}
 }
 
+#define rbtree_iterate_from_safe(node, next, start)			\
+	for (node = start; node && ({ next = rb_next(node); 1;});	\
+	     node = next)
+
+static int qgroup_unreserve_range(struct btrfs_inode *inode,
+				  struct extent_changeset *reserved, u64 start,
+				  u64 len)
+{
+	struct rb_node *node = reserved->range_changed.root.rb_node;
+	struct rb_node *next;
+	struct ulist_node *entry = NULL;
+	int ret = 0;
+
+	while (node) {
+		entry = rb_entry(node, struct ulist_node, rb_node);
+		if (entry->val < start)
+			node = node->rb_right;
+		else if (entry)
+			node = node->rb_left;
+		else
+			break;
+	}
+	/* Empty changeset */
+	if (!entry)
+		return ret;
+
+	if (entry->val > start && rb_prev(&entry->rb_node))
+		entry = rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
+				 rb_node);
+
+	rbtree_iterate_from_safe(node, next, &entry->rb_node) {
+		u64 entry_start;
+		u64 entry_end;
+		u64 entry_len;
+		int clear_ret;
+
+		entry = rb_entry(node, struct ulist_node, rb_node);
+		entry_start = entry->val;
+		entry_end = entry->aux;
+		entry_len = entry_end - entry_start + 1;
+
+		if (entry_start >= start + len)
+			break;
+		if (entry_start + entry_len <= start)
+			continue;
+		/*
+		 * Now the entry is in [start, start + len), revert the
+		 * EXTENT_QGROUP_RESERVED bit.
+		 */
+		clear_ret = clear_extent_bits(&inode->io_tree, entry_start,
+					      entry_end, EXTENT_QGROUP_RESERVED);
+		if (!ret && clear_ret < 0)
+			ret = clear_ret;
+
+		ulist_del(&reserved->range_changed, entry->val, entry->aux);
+		if (likely(reserved->bytes_changed >= entry_len)) {
+			reserved->bytes_changed -= entry_len;
+		} else {
+			WARN_ON(1);
+			reserved->bytes_changed = 0;
+		}
+	}
+	return ret;
+}
+
 /*
  * Reserve qgroup space for range [start, start + len).
  *
@@ -3457,18 +3522,14 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
  * Return <0 for error (including -EQUOT)
  *
  * NOTE: this function may sleep for memory allocation.
- *       if btrfs_qgroup_reserve_data() is called multiple times with
- *       same @reserved, caller must ensure when error happens it's OK
- *       to free *ALL* reserved space.
  */
 int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved_ret, u64 start,
 			u64 len)
 {
 	struct btrfs_root *root = inode->root;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
 	struct extent_changeset *reserved;
+	bool new_reserved = false;
 	u64 orig_reserved;
 	u64 to_reserve;
 	int ret;
@@ -3481,6 +3542,7 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	if (WARN_ON(!reserved_ret))
 		return -EINVAL;
 	if (!*reserved_ret) {
+		new_reserved = true;
 		*reserved_ret = extent_changeset_alloc();
 		if (!*reserved_ret)
 			return -ENOMEM;
@@ -3496,7 +3558,7 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	trace_btrfs_qgroup_reserve_data(&inode->vfs_inode, start, len,
 					to_reserve, QGROUP_RESERVE);
 	if (ret < 0)
-		goto cleanup;
+		goto out;
 	ret = qgroup_reserve(root, to_reserve, true, BTRFS_QGROUP_RSV_DATA);
 	if (ret < 0)
 		goto cleanup;
@@ -3504,15 +3566,13 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	return ret;
 
 cleanup:
-	/* cleanup *ALL* already reserved ranges */
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
-		clear_extent_bit(&inode->io_tree, unode->val,
-				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
-	/* Also free data bytes of already reserved one */
-	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
-				  orig_reserved, BTRFS_QGROUP_RSV_DATA);
-	extent_changeset_release(reserved);
+	qgroup_unreserve_range(inode, reserved, start, len);
+out:
+	if (new_reserved) {
+		extent_changeset_release(reserved);
+		kfree(reserved);
+		*reserved_ret = NULL;
+	}
 	return ret;
 }
 
-- 
2.27.0


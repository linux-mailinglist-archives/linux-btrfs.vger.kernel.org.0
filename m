Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B248A213406
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCGTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 02:19:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCGTL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 02:19:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 235CFB01D;
        Fri,  3 Jul 2020 06:19:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/3] btrfs: qgroup: Allow btrfs_qgroup_reserve_data() to revert EXTENT_QGROUP_RESERVED bits when it fails
Date:   Fri,  3 Jul 2020 14:19:00 +0800
Message-Id: <20200703061902.33350-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703061902.33350-1-wqu@suse.com>
References: <20200703061902.33350-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
reserved space of the changeset.

This means the following call is not possible:
	ret = btrfs_qgroup_reserve_data();
	if (ret == -EDQUOT) {
		/* Do something to free some qgroup space */
		ret = btrfs_qgroup_reserve_data();
	}

As if the first btrfs_qgroup_reserve_data() fails, it will free all
reserved qgroup space, so the next btrfs_qgroup_reserve_data() will
always success, and can go beyond qgroup limit.

[CAUSE]
This is caused by the fact that we didn't expect to call
btrfs_qgroup_reserve_data() again after error.

Thus btrfs_qgroup_reserve_data() frees all its reserved space.

[FIX]
This patch will implement a new function, qgroup_revert(), to iterate
through the ulist nodes, to find any nodes in the failure range, and
remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
the extent_changeset::bytes_changed, so that we can revert to previous
status.

This allows later patches to retry btrfs_qgroup_reserve_data() if EDQUOT
happens.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 89 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ee0ad33b659c..398de1145d2b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3447,6 +3447,70 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
 	}
 }
 
+static int qgroup_revert(struct btrfs_inode *inode,
+			struct extent_changeset *reserved, u64 start,
+			u64 len)
+{
+	struct rb_node *n = reserved->range_changed.root.rb_node;
+	struct ulist_node *entry = NULL;
+	int ret = 0;
+
+	while (n) {
+		entry = rb_entry(n, struct ulist_node, rb_node);
+		if (entry->val < start)
+			n = n->rb_right;
+		else if (entry)
+			n = n->rb_left;
+		else
+			break;
+	}
+	/* Empty changeset */
+	if (!entry)
+		goto out;
+
+	if (entry->val > start && rb_prev(&entry->rb_node))
+		entry = rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
+				 rb_node);
+
+	n = &entry->rb_node;
+	while (n) {
+		struct rb_node *tmp = rb_next(n);
+		u64 start;
+		u64 end;
+		u64 len;
+		int clear_ret;
+
+		entry = rb_entry(n, struct ulist_node, rb_node);
+		if (entry->val >= start + len)
+			break;
+		if (entry->val + entry->aux <= start)
+			goto next;
+		start = entry->val;
+		end = entry->aux;
+		len = end - start + 1;
+		/*
+		 * Now the entry is in [start, start + len), revert the
+		 * EXTENT_QGROUP_RESERVED bit.
+		 */
+		clear_ret = clear_extent_bits(&inode->io_tree, start, end,
+					      EXTENT_QGROUP_RESERVED);
+		if (!ret && clear_ret < 0)
+			ret = clear_ret;
+
+		ulist_del(&reserved->range_changed, entry->val, entry->aux);
+		if (likely(reserved->bytes_changed >= len)) {
+			reserved->bytes_changed -= len;
+		} else {
+			WARN_ON(1);
+			reserved->bytes_changed = 0;
+		}
+next:
+		n = tmp;
+	}
+out:
+	return ret;
+}
+
 /*
  * Reserve qgroup space for range [start, start + len).
  *
@@ -3457,18 +3521,14 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
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
@@ -3481,6 +3541,7 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	if (WARN_ON(!reserved_ret))
 		return -EINVAL;
 	if (!*reserved_ret) {
+		new_reserved = true;
 		*reserved_ret = extent_changeset_alloc();
 		if (!*reserved_ret)
 			return -ENOMEM;
@@ -3496,7 +3557,7 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	trace_btrfs_qgroup_reserve_data(&inode->vfs_inode, start, len,
 					to_reserve, QGROUP_RESERVE);
 	if (ret < 0)
-		goto cleanup;
+		goto out;
 	ret = qgroup_reserve(root, to_reserve, true, BTRFS_QGROUP_RSV_DATA);
 	if (ret < 0)
 		goto cleanup;
@@ -3504,15 +3565,13 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
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
+	qgroup_revert(inode, reserved, start, len);
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


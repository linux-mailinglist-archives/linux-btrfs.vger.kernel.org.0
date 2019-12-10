Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1285411812A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 08:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLJHOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 02:14:15 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:44059 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfLJHOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 02:14:15 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47XBBX17p3z8v9w;
        Tue, 10 Dec 2019 08:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575962052; bh=t8x90WwDzqKjL8OOuLCGaDmMyXaBu2eutDHibaupt6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=XP1mJ/3sCHc8TUu7bdd1Tt8ANta5iJXXApKYuCN6WX+xib/l6/x7zrFn6YBz6FZHa
         9zNwixTIdhP+ekLW+ezzBv81CFIi6r7AogB8nuneGQiOQJSkbmM2kksIk3QFXa2Un2
         I1NsKUIkbiIAaU1CzaOcUdyHTKrXIxneLzL+Jod8EIrNS61bqqTheMf9UnONu/szvQ
         QRAQRtpPx4n1fL+MhDNsyn1A6JhzXoqaPuL9D0RH7B7hdBMv+TkHyXrdafVgCsohdU
         GJnjVceGnhWAWRvtIo9uFoIY/DwDkfoA0yzosRmcRJEp/c45hz+k3PjQIaV//iIh5o
         YlQaE3bj5+Ykg==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/geYtmXJswcZ+y3l1qTA+wCwC4moKiEmo=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47XBBT2LxVz8t8v;
        Tue, 10 Dec 2019 08:14:09 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>,
        Ole Wiedemann <ole.wiedemann@fau.de>
Subject: [PATCH 4/5] fs_btrfs_qgroup: code cleanup
Date:   Tue, 10 Dec 2019 08:13:56 +0100
Message-Id: <20191210071357.5323-5-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210071357.5323-1-sebastian.scherbel@fau.de>
References: <20191210071357.5323-1-sebastian.scherbel@fau.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

This patch changes several instances in qgroup where the coding style
is not in line with the Linux kernel guidelines to improve readability.

1. block comment alignment fixed
2. unnecessary braces removed
3. consistent spacing around '-' added
4. trailing whitespace removed
5. lines with more than 80 characters are broken into sensible chunks,
unless exceeding the limit significantly increases readability
6. missing blank lines after declerations are added
7. tabs are used for indentations where possible

Signed-off-by: Sebastian Scherbel <sebastian.scherbel@fau.de>
Co-developed-by: Ole Wiedemann <ole.wiedemann@fau.de>
Signed-off-by: Ole Wiedemann <ole.wiedemann@fau.de>
---
 fs/btrfs/qgroup.c | 54 +++++++++++++++++++++++++++--------------------
 fs/btrfs/qgroup.h | 12 +++++------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 93aeb2e539a4..da3fbdd756ad 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -156,7 +156,7 @@ static inline u64 qgroup_to_aux(struct btrfs_qgroup *qg)
 	return (u64)(uintptr_t)qg;
 }
 
-static inline struct btrfs_qgroup* unode_aux_to_qgroup(struct ulist_node *n)
+static inline struct btrfs_qgroup *unode_aux_to_qgroup(struct ulist_node *n)
 {
 	return (struct btrfs_qgroup *)(uintptr_t)n->aux;
 }
@@ -1029,9 +1029,9 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 
 	ret = qgroup_rescan_init(fs_info, 0, 1);
 	if (!ret) {
-	        qgroup_rescan_zero_tracking(fs_info);
-	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
-	                         &fs_info->qgroup_rescan_work);
+		qgroup_rescan_zero_tracking(fs_info);
+		btrfs_queue_work(fs_info->qgroup_rescan_workers,
+				 &fs_info->qgroup_rescan_work);
 	}
 
 out_free_path:
@@ -1191,7 +1191,8 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info,
 		/* Add any parents of the parents */
 		list_for_each_entry(glist, &qgroup->groups, next_group) {
 			ret = ulist_add(tmp, glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
+					qgroup_to_aux(glist->group),
+					GFP_ATOMIC);
 			if (ret < 0)
 				goto out;
 		}
@@ -1781,7 +1782,7 @@ static int adjust_slots_upwards(struct btrfs_path *path, int root_level)
  * This function can free us from keeping two paths, thus later we only need
  * to care about how to iterate all new tree blocks in reloc tree.
  */
-static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
+static int qgroup_trace_extent_swap(struct btrfs_trans_handle *trans,
 				    struct extent_buffer *src_eb,
 				    struct btrfs_path *dst_path,
 				    int dst_level, int root_level,
@@ -1876,8 +1877,9 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 	 * Now both @dst_path and @src_path have been populated, record the tree
 	 * blocks for qgroup accounting.
 	 */
-	ret = btrfs_qgroup_trace_extent(trans, src_path->nodes[dst_level]->start,
-			nodesize, GFP_NOFS);
+	ret = btrfs_qgroup_trace_extent(trans,
+					src_path->nodes[dst_level]->start,
+					nodesize, GFP_NOFS);
 	if (ret < 0)
 		goto out;
 	ret = btrfs_qgroup_trace_extent(trans,
@@ -1920,7 +1922,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
  * While during search, old tree blocks OO(c) will be skipped as tree block swap
  * won't affect OO(c).
  */
-static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
+static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle *trans,
 					   struct extent_buffer *src_eb,
 					   struct btrfs_path *dst_path,
 					   int cur_level, int root_level,
@@ -1963,7 +1965,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		/*
 		 * We need to get child blockptr/gen from parent before we can
 		 * read it.
-		  */
+		 */
 		eb = dst_path->nodes[cur_level + 1];
 		parent_slot = dst_path->slots[cur_level + 1];
 		child_bytenr = btrfs_node_blockptr(eb, parent_slot);
@@ -2142,7 +2144,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			/*
 			 * We need to get child blockptr/gen from parent before
 			 * we can read it.
-			  */
+			 */
 			eb = path->nodes[level + 1];
 			parent_slot = path->slots[level + 1];
 			child_bytenr = btrfs_node_blockptr(eb, parent_slot);
@@ -2228,7 +2230,8 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
 				GFP_ATOMIC);
 		if (ret < 0)
 			return ret;
-		ret = ulist_add(tmp, qg->qgroupid, qgroup_to_aux(qg), GFP_ATOMIC);
+		ret = ulist_add(tmp, qg->qgroupid, qgroup_to_aux(qg),
+				GFP_ATOMIC);
 		if (ret < 0)
 			return ret;
 		ULIST_ITER_INIT(&tmp_uiter);
@@ -2406,7 +2409,8 @@ static int maybe_fs_roots(struct ulist *roots)
 	/*
 	 * If it contains fs tree roots, then it must belong to fs/subvol
 	 * trees.
-	 * If it contains a non-fs tree, it won't be shared with fs/subvol trees.
+	 * If it contains a non-fs tree, it won't be shared with fs/subvol
+	 * trees.
 	 */
 	return is_fstree(unode->val);
 }
@@ -2587,6 +2591,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 	spin_lock(&fs_info->qgroup_lock);
 	while (!list_empty(&fs_info->dirty_qgroups)) {
 		struct btrfs_qgroup *qgroup;
+
 		qgroup = list_first_entry(&fs_info->dirty_qgroups,
 					  struct btrfs_qgroup, dirty);
 		list_del_init(&qgroup->dirty);
@@ -2926,7 +2931,8 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 		list_for_each_entry(glist, &qg->groups, next_group) {
 			ret = ulist_add(fs_info->qgroup_ulist,
 					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
+					qgroup_to_aux(glist->group),
+					GFP_ATOMIC);
 			if (ret < 0)
 				goto out;
 		}
@@ -3012,7 +3018,8 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 		list_for_each_entry(glist, &qg->groups, next_group) {
 			ret = ulist_add(fs_info->qgroup_ulist,
 					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
+					qgroup_to_aux(glist->group),
+					GFP_ATOMIC);
 			if (ret < 0)
 				goto out;
 		}
@@ -3151,11 +3158,10 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 			err = PTR_ERR(trans);
 			break;
 		}
-		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 			err = -EINTR;
-		} else {
+		else
 			err = qgroup_rescan_leaf(trans, path);
-		}
 		if (err > 0)
 			btrfs_commit_transaction(trans);
 		else
@@ -3419,7 +3425,7 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
 	/* Record already reserved space */
 	orig_reserved = reserved->bytes_changed;
 	ret = set_record_extent_bits(&BTRFS_I(inode)->io_tree, start,
-			start + len -1, EXTENT_QGROUP_RESERVED, reserved);
+			start + len - 1, EXTENT_QGROUP_RESERVED, reserved);
 
 	/* Newly reserved space */
 	to_reserve = reserved->bytes_changed - orig_reserved;
@@ -3438,7 +3444,8 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
 	ULIST_ITER_INIT(&uiter);
 	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, unode->val,
-				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
+				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0,
+				 NULL);
 	/* Also free data bytes of already reserved one */
 	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
 				  orig_reserved, BTRFS_QGROUP_RSV_DATA);
@@ -3518,8 +3525,8 @@ static int __btrfs_qgroup_release_data(struct inode *inode,
 	if (free && reserved)
 		return qgroup_free_reserved_data(inode, reserved, start, len);
 	extent_changeset_init(&changeset);
-	ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree, start, 
-			start + len -1, EXTENT_QGROUP_RESERVED, &changeset);
+	ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree, start,
+			start + len - 1, EXTENT_QGROUP_RESERVED, &changeset);
 	if (ret < 0)
 		goto out;
 
@@ -3715,7 +3722,8 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 		list_for_each_entry(glist, &qg->groups, next_group) {
 			ret = ulist_add(fs_info->qgroup_ulist,
 					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
+					qgroup_to_aux(glist->group),
+					GFP_ATOMIC);
 			if (ret < 0)
 				goto out;
 		}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 236f12224d52..8d70bf3711a2 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -146,12 +146,12 @@ struct btrfs_qgroup_swapped_block {
  *	space reserved for data
  *
  * META_PERTRANS:
- * 	Space reserved for metadata (per-transaction)
- * 	Due to the fact that qgroup data is only updated at transaction commit
- * 	time, reserved space for metadata must be kept until transaction
- * 	commits.
- * 	Any metadata reserved that are used in btrfs_start_transaction() should
- * 	be of this type.
+ *	Space reserved for metadata (per-transaction)
+ *	Due to the fact that qgroup data is only updated at transaction commit
+ *	time, reserved space for metadata must be kept until transaction
+ *	commits.
+ *	Any metadata reserved that are used in btrfs_start_transaction() should
+ *	be of this type.
  *
  * META_PREALLOC:
  *	There are cases where metadata space is reserved before starting
-- 
2.20.1


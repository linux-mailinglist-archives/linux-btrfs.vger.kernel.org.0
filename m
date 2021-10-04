Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19807420990
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJDK6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 06:58:24 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:47899 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231167AbhJDK6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Oct 2021 06:58:24 -0400
Received: from MTA-14-3.privateemail.com (mta-14-1.privateemail.com [198.54.122.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 964B580C6C;
        Mon,  4 Oct 2021 06:56:34 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 89B5718000A4;
        Mon,  4 Oct 2021 06:56:33 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.236])
        by mta-14.privateemail.com (Postfix) with ESMTPA id C6F8118000A3;
        Mon,  4 Oct 2021 06:56:32 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use kmem cache to allocate struct btrfs_qgroup_extent_record
Date:   Mon,  4 Oct 2021 06:55:32 -0400
Message-Id: <20211004105533.1605-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 3368d001ba5d ("btrfs: qgroup: Record possible quota-related extent
for qgroup.") suggests that, struct btrfs_qgroup_extent_record should be
allocated using kmem cache.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 fs/btrfs/delayed-ref.c |  6 +++---
 fs/btrfs/qgroup.c      | 27 +++++++++++++++++++++++----
 fs/btrfs/qgroup.h      | 17 ++++++++++++++++-
 fs/btrfs/super.c       |  9 ++++++++-
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index ca848b183474..dbe490e0ef59 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -796,7 +796,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	if (qrecord) {
 		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
 					delayed_refs, qrecord))
-			kfree(qrecord);
+			btrfs_free_qgroup_extent_record(qrecord);
 		else
 			qrecord_inserted = 1;
 	}
@@ -924,7 +924,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	    is_fstree(generic_ref->real_root) &&
 	    is_fstree(generic_ref->tree_ref.root) &&
 	    !generic_ref->skip_qgroup) {
-		record = kzalloc(sizeof(*record), GFP_NOFS);
+		record = btrfs_alloc_qgroup_extent_record(GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
 			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
@@ -1029,7 +1029,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	    is_fstree(ref_root) &&
 	    is_fstree(generic_ref->real_root) &&
 	    !generic_ref->skip_qgroup) {
-		record = kzalloc(sizeof(*record), GFP_NOFS);
+		record = btrfs_alloc_qgroup_extent_record(GFP_NOFS);
 		if (!record) {
 			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
 			kmem_cache_free(btrfs_delayed_ref_head_cachep,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db680f5be745..a675498ae989 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -25,6 +25,7 @@
 #include "sysfs.h"
 #include "tree-mod-log.h"
 
+struct kmem_cache *btrfs_qgroup_extent_record_cachep;
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
  *  - reorganize keys
@@ -1764,7 +1765,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)
 	    || bytenr == 0 || num_bytes == 0)
 		return 0;
-	record = kzalloc(sizeof(*record), gfp_flag);
+	record = btrfs_alloc_qgroup_extent_record(gfp_flag);
 	if (!record)
 		return -ENOMEM;
 
@@ -1777,7 +1778,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record);
 	spin_unlock(&delayed_refs->lock);
 	if (ret > 0) {
-		kfree(record);
+		btrfs_free_qgroup_extent_record(record);
 		return 0;
 	}
 	return btrfs_qgroup_trace_extent_post(trans, record);
@@ -2687,7 +2688,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		ulist_free(new_roots);
 		new_roots = NULL;
 		rb_erase(node, &delayed_refs->dirty_extent_root);
-		kfree(record);
+		btrfs_free_qgroup_extent_record(record);
 
 	}
 	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
@@ -4269,6 +4270,24 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 	root = &trans->delayed_refs.dirty_extent_root;
 	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
 		ulist_free(entry->old_roots);
-		kfree(entry);
+		btrfs_free_qgroup_extent_record(entry);
 	}
 }
+
+void __cold btrfs_qgroup_exit(void)
+{
+	kmem_cache_destroy(btrfs_qgroup_extent_record_cachep);
+}
+
+int __init btrfs_qgroup_init(void)
+{
+	btrfs_qgroup_extent_record_cachep = kmem_cache_create(
+				"btrfs_qgroup_extent_record",
+				sizeof(struct btrfs_qgroup_extent_record), 0,
+				SLAB_MEM_SPREAD, NULL);
+
+	if (unlikely(!btrfs_qgroup_extent_record_cachep))
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 880e9df0dac1..b06fb52c7cee 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -12,6 +12,7 @@
 #include "ulist.h"
 #include "delayed-ref.h"
 
+extern struct kmem_cache *btrfs_qgroup_extent_record_cachep;
 /*
  * Btrfs qgroup overview
  *
@@ -102,7 +103,6 @@
 
 /*
  * Record a dirty extent, and info qgroup to update quota on it
- * TODO: Use kmem cache to alloc it.
  */
 struct btrfs_qgroup_extent_record {
 	struct rb_node node;
@@ -231,6 +231,19 @@ struct btrfs_qgroup {
 	struct kobject kobj;
 };
 
+static inline struct btrfs_qgroup_extent_record *
+btrfs_alloc_qgroup_extent_record(gfp_t gfp_flag)
+{
+	return kmem_cache_zalloc(btrfs_qgroup_extent_record_cachep, gfp_flag);
+}
+
+static inline void
+btrfs_free_qgroup_extent_record(struct btrfs_qgroup_extent_record *record)
+{
+	if (record)
+		kmem_cache_free(btrfs_qgroup_extent_record_cachep, record);
+}
+
 static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 {
 	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
@@ -243,6 +256,8 @@ static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 #define QGROUP_RELEASE		(1<<1)
 #define QGROUP_FREE		(1<<2)
 
+void __cold btrfs_qgroup_exit(void);
+int __init btrfs_qgroup_init(void);
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 537d90bf5d84..1c9b6a13d962 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2602,10 +2602,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_delayed_inode;
 
-	err = btrfs_delayed_ref_init();
+	err = btrfs_qgroup_init();
 	if (err)
 		goto free_auto_defrag;
 
+	err = btrfs_delayed_ref_init();
+	if (err)
+		goto free_qgroup;
+
 	err = btrfs_prelim_ref_init();
 	if (err)
 		goto free_delayed_ref;
@@ -2638,6 +2642,8 @@ static int __init init_btrfs_fs(void)
 	btrfs_prelim_ref_exit();
 free_delayed_ref:
 	btrfs_delayed_ref_exit();
+free_qgroup:
+	btrfs_qgroup_exit();
 free_auto_defrag:
 	btrfs_auto_defrag_exit();
 free_delayed_inode:
@@ -2662,6 +2668,7 @@ static int __init init_btrfs_fs(void)
 static void __exit exit_btrfs_fs(void)
 {
 	btrfs_destroy_cachep();
+	btrfs_qgroup_exit();
 	btrfs_delayed_ref_exit();
 	btrfs_auto_defrag_exit();
 	btrfs_delayed_inode_exit();
-- 
2.33.0


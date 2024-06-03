Return-Path: <linux-btrfs+bounces-5410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29188D8160
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 13:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347071F240C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420884A46;
	Mon,  3 Jun 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUUATtSJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2184A49
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414617; cv=none; b=kpSm5RnyVywSuyR8OVL2nRM/arpK6KEtp6ERSEIUXeywPbGy8WW8GxmOuhOuJvXJFkLTJeN+in7pdVyln3VBuqfcaf8i3R1aos0WEN+x7Qq1hrniVpnC2m3K27ZNptr/Pcr5+1NQRzMtTxz4SW7LrKrjF9x6ExK9JG9BVvunooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414617; c=relaxed/simple;
	bh=riaqteqRE+tvSE6FZLOyOFSUFIF7rn9VmdPnqvkj/7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByGiu2sXTx4bcJ7hFIa/muLzvcYpyEUShaifu33YMxSAG4o2NiPoalLcaR9Up9osHNYyU/u8JTm1lzyr8gxTrVZGzE6ipUK/mR2ALGX7f27VU2zavFf5M46tw5glU77jqdPJVdPccmrNxyZ85A7epWKLMngRfITmugEEwr23odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUUATtSJ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36dd6110186so17864225ab.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717414615; x=1718019415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJsAi6dXsNPSsQH0hkH812aMijBsZhYTIox4K2Gw/c8=;
        b=CUUATtSJa4+EBl8CXA/9pBs2ZHAFTAH4SuZ9GrsxIsAyQvCleeEYMc0k0Sl6mBVY4U
         S4PfBn5s4GKNBXYS+qLN2Zu931xgskjf249Ohc0P9Rg6c6ZRIXYV6dY5kEH/Oipvr6D9
         ZMlHjj7qm1axiF/Tv3N3omWtZo0Ae7dvsOc/ZnE93KCVR+A12dTGQ37s5Wjf5P0XiztB
         tF90qRPLeBiBJO+aEAPySiD0HV6aF2t+KbHxPae6+iPvHynfE8Vcuc9kws6srDprwsSg
         NoxgRVdBYeysQwv7N2ai2Ea1Cnx4eUrvTBdZWa08+Z2sqjRmwmPi/nu+jHNZsFwzj4zi
         MocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717414615; x=1718019415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJsAi6dXsNPSsQH0hkH812aMijBsZhYTIox4K2Gw/c8=;
        b=VymtM5nkqWD9jHLI7KHa4iSwM0aHoYUI7wcSEzkoMC6p7/7qLAMi7+uuONmKwqjkTV
         Ip+PRjEI6fDWBzOFi/XUgHq0DbQbFpsnFz9Op70+auruSPVumEy3LfLvwqBTlhA1NJML
         rJp/nFx3PlESy3M/jz35QJ4ncFBnVJw8/mbuugVJMM3INvr7q9CG9NXNfs4yWI4Evb0R
         pqqzGryeakDKIfMxhA7oiLk3hrmgP0zf0RtZj46+aVtI8dLAZtit0TmHFxp9ruhLbrMC
         mt1wEKW/53y8f6h+MVoZoGv4SDYmieWdXi/0P/qfDXU1YYiKW6KGJz9U5NG6U3g4P4zY
         fkrw==
X-Gm-Message-State: AOJu0Yy8RhDllSZwogZLc6hfwp1EEoKqChw5/YbedHPTTAYW72qDNznT
	twnr5fu5D8XhnKBfAEmt7ShLy6S1t0WnOmkrmcPr0zOlAcff5JWFsQp6JAYG
X-Google-Smtp-Source: AGHT+IGSlxgyAsdoXWXyapoDJ5hJEWo4VqNLvuOOnTyW2INeCpVHIAVj5yAv4Pp2gb84P1IIihaPDA==
X-Received: by 2002:a05:6e02:160b:b0:374:a2f2:54c6 with SMTP id e9e14a558f8ab-374a2f25549mr11870855ab.30.1717414614122;
        Mon, 03 Jun 2024 04:36:54 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c355cd393esm5212539a12.49.2024.06.03.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 04:36:53 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2] btrfs: qgroup: use xarray to track dirty extents in transaction.
Date: Mon,  3 Jun 2024 19:36:50 +0800
Message-Id: <20240603113650.279782-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
 - Use xa_load() to update existing entry instead of double
   xa_store().
 - Rename goto lables.
 - Remove unnecessary calls to xa_init().

Using xarray to track dirty extents can reduce the size of the
struct btrfs_qgroup_extent_record from 64 bytes to 40 bytes.
And xarray is more cache line friendly, it also reduces the
complexity of insertion and search code compared to rb tree.

Another change introduced is about error handling.
Before this patch, the result of btrfs_qgroup_trace_extent_nolock()
is always a success. In this patch, because of this function calls
the function xa_store() which has the possibility to fail, so mark
qgroup as inconsistent if error happened and then free preallocated
memory. Also we preallocate memory before spin_lock(), if memory
preallcation failed, error handling is the same the existing code.

This patch passed the check -g qgroup tests using xfstests and
checkpatch tests.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/delayed-ref.c | 57 ++++++++++++++++++++--------------
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/qgroup.c      | 69 +++++++++++++++++++++---------------------
 fs/btrfs/qgroup.h      |  1 -
 fs/btrfs/transaction.c |  6 ++--
 5 files changed, 73 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 891ea2fa263c..e5cbc91e9864 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -915,8 +915,11 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	/* Record qgroup extent info if provided */
 	if (qrecord) {
 		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
-					delayed_refs, qrecord))
+					delayed_refs, qrecord)) {
+			/* If insertion failed, free preallocated memory */
+			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
 			kfree(qrecord);
+		}
 		else
 			qrecord_inserted = true;
 	}
@@ -1029,6 +1032,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u8 ref_type;
 
 	is_system = (generic_ref->tree_ref.ref_root == BTRFS_CHUNK_TREE_OBJECTID);
+	delayed_refs = &trans->transaction->delayed_refs;
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
@@ -1036,18 +1040,15 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
-	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
-		return -ENOMEM;
-	}
+	if (!head_ref)
+		goto free_ref;
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record) {
-			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
-			return -ENOMEM;
-		}
+		if (!record)
+			goto free_head_ref;
+		if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS))
+			goto free_record;
 	}
 
 	if (parent)
@@ -1067,7 +1068,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			      false, is_system, generic_ref->owning_root);
 	head_ref->extent_op = extent_op;
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
 	/*
@@ -1096,6 +1096,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		btrfs_qgroup_trace_extent_post(trans, record);
 
 	return 0;
+
+free_record:
+	kfree(record);
+free_head_ref:
+	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+free_ref:
+	kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
+	return -ENOMEM;
 }
 
 /*
@@ -1137,28 +1145,23 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	ref->objectid = owner;
 	ref->offset = offset;
 
-
+	delayed_refs = &trans->transaction->delayed_refs;
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
-	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
-		return -ENOMEM;
-	}
+	if (!head_ref)
+		goto free_ref;
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record) {
-			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep,
-					head_ref);
-			return -ENOMEM;
-		}
+		if (!record)
+			goto free_head_ref;
+		if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS))
+			goto free_record;
 	}
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
 			      reserved, action, true, false, generic_ref->owning_root);
 	head_ref->extent_op = NULL;
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
 	/*
@@ -1187,6 +1190,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	if (qrecord_inserted)
 		return btrfs_qgroup_trace_extent_post(trans, record);
 	return 0;
+
+free_record:
+	kfree(record);
+free_head_ref:
+	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+free_ref:
+	kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
+	return -ENOMEM;
 }
 
 int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 62d679d40f4f..f9b20c0671c7 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -166,7 +166,7 @@ struct btrfs_delayed_ref_root {
 	struct rb_root_cached href_root;
 
 	/* dirty extent records */
-	struct rb_root dirty_extent_root;
+	struct xarray dirty_extents;
 
 	/* this spin lock protects the rbtree and the entries inside */
 	spinlock_t lock;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5470e1cdf10c..717e16da9679 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1890,16 +1890,13 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
  *
  * Return 0 for success insert
  * Return >0 for existing record, caller can free @record safely.
- * Error is not possible
  */
 int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 				struct btrfs_delayed_ref_root *delayed_refs,
 				struct btrfs_qgroup_extent_record *record)
 {
-	struct rb_node **p = &delayed_refs->dirty_extent_root.rb_node;
-	struct rb_node *parent_node = NULL;
-	struct btrfs_qgroup_extent_record *entry;
-	u64 bytenr = record->bytenr;
+	struct btrfs_qgroup_extent_record *existing, *ret;
+	unsigned long bytenr = record->bytenr;
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 1;
@@ -1907,26 +1904,27 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
 
-	while (*p) {
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct btrfs_qgroup_extent_record,
-				 node);
-		if (bytenr < entry->bytenr) {
-			p = &(*p)->rb_left;
-		} else if (bytenr > entry->bytenr) {
-			p = &(*p)->rb_right;
-		} else {
-			if (record->data_rsv && !entry->data_rsv) {
-				entry->data_rsv = record->data_rsv;
-				entry->data_rsv_refroot =
-					record->data_rsv_refroot;
-			}
-			return 1;
+	xa_lock(&delayed_refs->dirty_extents);
+	existing = xa_load(&delayed_refs->dirty_extents, bytenr);
+	if (existing) {
+		if (record->data_rsv && !existing->data_rsv) {
+			existing->data_rsv = record->data_rsv;
+			existing->data_rsv_refroot = record->data_rsv_refroot;
 		}
+		xa_unlock(&delayed_refs->dirty_extents);
+		return 1;
+	}
+
+	ret = __xa_store(&delayed_refs->dirty_extents, record->bytenr, record, GFP_ATOMIC);
+	xa_unlock(&delayed_refs->dirty_extents);
+	if (xa_is_err(ret)) {
+		spin_lock(&fs_info->qgroup_lock);
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		spin_unlock(&fs_info->qgroup_lock);
+
+		return 1;
 	}
 
-	rb_link_node(&record->node, parent_node, p);
-	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
 	return 0;
 }
 
@@ -2027,13 +2025,18 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret;
 
+	delayed_refs = &trans->transaction->delayed_refs;
 	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr == 0 || num_bytes == 0)
 		return 0;
 	record = kzalloc(sizeof(*record), GFP_NOFS);
 	if (!record)
 		return -ENOMEM;
 
-	delayed_refs = &trans->transaction->delayed_refs;
+	if (xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS)) {
+		kfree(record);
+		return -ENOMEM;
+	}
+
 	record->bytenr = bytenr;
 	record->num_bytes = num_bytes;
 	record->old_roots = NULL;
@@ -2042,9 +2045,12 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record);
 	spin_unlock(&delayed_refs->lock);
 	if (ret > 0) {
+		/* If insertion failed, free preallocated memory */
+		xa_release(&delayed_refs->dirty_extents, record->bytenr);
 		kfree(record);
 		return 0;
 	}
+
 	return btrfs_qgroup_trace_extent_post(trans, record);
 }
 
@@ -2912,7 +2918,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	struct btrfs_qgroup_extent_record *record;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct ulist *new_roots = NULL;
-	struct rb_node *node;
+	unsigned long index;
 	u64 num_dirty_extents = 0;
 	u64 qgroup_to_skip;
 	int ret = 0;
@@ -2922,10 +2928,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
-	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
-		record = rb_entry(node, struct btrfs_qgroup_extent_record,
-				  node);
-
+	xa_for_each(&delayed_refs->dirty_extents, index, record) {
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
@@ -2991,7 +2994,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		ulist_free(record->old_roots);
 		ulist_free(new_roots);
 		new_roots = NULL;
-		rb_erase(node, &delayed_refs->dirty_extent_root);
+		xa_erase(&delayed_refs->dirty_extents, index);
 		kfree(record);
 
 	}
@@ -4664,15 +4667,13 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 {
 	struct btrfs_qgroup_extent_record *entry;
-	struct btrfs_qgroup_extent_record *next;
-	struct rb_root *root;
+	unsigned long index;
 
-	root = &trans->delayed_refs.dirty_extent_root;
-	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
+	xa_for_each(&trans->delayed_refs.dirty_extents, index, entry) {
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
-	*root = RB_ROOT;
+	xa_destroy(&trans->delayed_refs.dirty_extents);
 }
 
 void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64 rsv_bytes)
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index be18c862e64e..f8165a27b885 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -116,7 +116,6 @@
  * TODO: Use kmem cache to alloc it.
  */
 struct btrfs_qgroup_extent_record {
-	struct rb_node node;
 	u64 bytenr;
 	u64 num_bytes;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index bf8e64c766b6..22e917f47452 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -145,8 +145,8 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 		BUG_ON(!list_empty(&transaction->list));
 		WARN_ON(!RB_EMPTY_ROOT(
 				&transaction->delayed_refs.href_root.rb_root));
-		WARN_ON(!RB_EMPTY_ROOT(
-				&transaction->delayed_refs.dirty_extent_root));
+		WARN_ON(!xa_empty(
+				&transaction->delayed_refs.dirty_extents));
 		if (transaction->delayed_refs.pending_csums)
 			btrfs_err(transaction->fs_info,
 				  "pending csums is %llu",
@@ -353,7 +353,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
 
 	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
-	cur_trans->delayed_refs.dirty_extent_root = RB_ROOT;
+	xa_init(&cur_trans->delayed_refs.dirty_extents);
 	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
 
 	/*
-- 
2.39.2



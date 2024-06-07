Return-Path: <linux-btrfs+bounces-5534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59699006AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7CA1C230B8
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D854660;
	Fri,  7 Jun 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc1kkQeH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3819309E
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770633; cv=none; b=BE5PonO6Fp4sBZPnZBMS3gt2YlLwbfhgkAmQEPi1ygUDpWP4PMkHiVe0RDx0ys7PViHr9tPZrRAli0p3Bc3/12ibTEe38NdL8m3Tlb4xwmxOS6FY+aO14MyMXvgRudrlWcIhw9eZ0e1EjXoy3Ygu1UgpkspveaGwVwKQGreTUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770633; c=relaxed/simple;
	bh=qlipwgax7A37XW5C4uC8LlP2eYHtG3WRRxLQNdUtPBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0uQsTOuCOL1/FAMZ+XVzEqHSdLOr8j8+RlV+6XF8YpOVAVfOO1VsYKClODkAA5T1qkGTgL45GQw1kyrI1p46XleiSMi/DJLA8hbxgYEAvKX6mV7XQAmovcqxJmiLjvJvT9ulm9DJZKVFxEXIHKLGeJwZC5lHo8f3IuV9oSgleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc1kkQeH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1a9b151bcso1756828a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717770630; x=1718375430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEHYLWQEUIVCXyiuMTmVsGHbg32N9EQuWebL2TcU3ng=;
        b=Sc1kkQeHvFlo3tAqmuV021MBsb3Spr7J710GoI/XSKqqzu2XRW7+D4POMhXXa3A9A1
         hV9g7+abP3ADj0HtJS5J76brpdxlnsLZtQ10m+6pokQdpQri7Bi3yMoFk6WpzdP2v18S
         koVoRb9fkVVd2974fjMAQV3Wo7pkVr3YiANYZodzIqTZGU0UkgI+FZQSYGUIgU1Y2w32
         d3K2YPvt+kn3zlk4Rcj2w2UqCRY3lfDLqTwPWTd/ipZDGqVXFD0XFo0SSeQ6BkzExn0f
         18zDNlVDKBfhE/cBl/I7WHP7CUMA6OyFnJNk4IFgukET2Vq0Q713aPt0y2rOzl1jUeB7
         XJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770630; x=1718375430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEHYLWQEUIVCXyiuMTmVsGHbg32N9EQuWebL2TcU3ng=;
        b=EZNir/Vyc65ZogaAS6yVFZEVzQ9EAk5JdyxuQVIjJyKZVX3QUNfvsMicA7a8JnN97D
         vhTFx9g2zWqRGuyVCL3Q6fIrNYWnHelEZZUIbwqLMf6fLXiiUKvQcS9Rq6hNGCk8g0vz
         YgWw+6ps3S2Y+CcdctmBFQhhPoun7acbjJvZkCoFn9b9A6BcVRJQkI1Z87lFLAnz2WnH
         jaWctFapbPuBHO6XEuyps4B54s6TYRazxpMj+gE2gHpg0QkNPRkEUroToVEPek2YAohh
         0gJ7saCtQJAco6Tk1ObWG/lcO6N8TlYZdj15+7xTiSuA2hNf4xdZjg6Mc9R6tUD0FyRw
         tQMQ==
X-Gm-Message-State: AOJu0YzhteT5tP4tpjlFOKCp+WjQM99UD7q+lCAQ+7e3cl4yqgxGHDOq
	xRUAPTqSAUAv+ai4fPcIPzPDZVc+NgF1LqrgMQKfN7lBZ/f4Fd827W5poPP3ffc=
X-Google-Smtp-Source: AGHT+IGPNyFUKNnIRUoPOKx1aHAPu+K1L7T/3ea2g3DwOHbLfEe7nuS33jdho1L+j1a8O6/wD/N+Wg==
X-Received: by 2002:a17:90a:12c2:b0:2c2:5341:7ed6 with SMTP id 98e67ed59e1d1-2c2bcc5a26emr2712689a91.38.1717770630065;
        Fri, 07 Jun 2024 07:30:30 -0700 (PDT)
Received: from localhost ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806d284bsm5561393a91.57.2024.06.07.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:30:29 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v3 2/2] btrfs: qgroup: use xarray to track dirty extents in transaction.
Date: Fri,  7 Jun 2024 22:30:21 +0800
Message-Id: <20240607143021.122220-2-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607143021.122220-1-sunjunchao2870@gmail.com>
References: <20240607143021.122220-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
  - Separate the cleanup code into a single patch.
  - Call qgroup_mark_inconsistent() when record insertion failed.
  - Return negative value when record insertion failed.

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
 fs/btrfs/delayed-ref.c | 14 +++++++--
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/qgroup.c      | 66 ++++++++++++++++++++----------------------
 fs/btrfs/transaction.c |  5 ++--
 4 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 1a41ab991738..ec78d4c7581c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -891,10 +891,13 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 
 	/* Record qgroup extent info if provided */
 	if (qrecord) {
-		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
-					delayed_refs, qrecord))
+		int ret = btrfs_qgroup_trace_extent_nolock(trans->fs_info,
+					delayed_refs, qrecord);
+		if (ret) {
+			/* Clean up if insertion fails or item exists. */
+			xa_release(&delayed_refs->dirty_extents, qrecord->bytenr);
 			kfree(qrecord);
-		else
+		} else
 			qrecord_inserted = true;
 	}
 
@@ -1048,6 +1051,9 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record)
 			goto free_head_ref;
+		if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents,
+			       generic_ref->bytenr, GFP_NOFS))
+			goto free_record;
 	}
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
@@ -1084,6 +1090,8 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		return btrfs_qgroup_trace_extent_post(trans, record);
 	return 0;
 
+free_record:
+	kfree(record);
 free_head_ref:
 	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 free_node:
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 04b180ebe1fe..a81d6f2aa799 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -201,7 +201,7 @@ struct btrfs_delayed_ref_root {
 	struct rb_root_cached href_root;
 
 	/* dirty extent records */
-	struct rb_root dirty_extent_root;
+	struct xarray dirty_extents;
 
 	/* this spin lock protects the rbtree and the entries inside */
 	spinlock_t lock;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index fc2a7ea26354..f75ed67a8edf 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1902,16 +1902,14 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
  *
  * Return 0 for success insert
  * Return >0 for existing record, caller can free @record safely.
- * Error is not possible
+ * Return <0 for insertion failed, caller can free @record safely.
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
@@ -1919,26 +1917,24 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
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
+		qgroup_mark_inconsistent(fs_info);
+		return xa_err(ret);
 	}
 
-	rb_link_node(&record->node, parent_node, p);
-	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
 	return 0;
 }
 
@@ -2045,6 +2041,11 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (!record)
 		return -ENOMEM;
 
+	if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents, bytenr, GFP_NOFS)) {
+		kfree(record);
+		return -ENOMEM;
+	}
+
 	delayed_refs = &trans->transaction->delayed_refs;
 	record->bytenr = bytenr;
 	record->num_bytes = num_bytes;
@@ -2053,7 +2054,9 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	spin_lock(&delayed_refs->lock);
 	ret = btrfs_qgroup_trace_extent_nolock(fs_info, delayed_refs, record);
 	spin_unlock(&delayed_refs->lock);
-	if (ret > 0) {
+	if (ret) {
+		/* Clean up if insertion fails or item exists. */
+		xa_release(&delayed_refs->dirty_extents, record->bytenr);
 		kfree(record);
 		return 0;
 	}
@@ -2922,7 +2925,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	struct btrfs_qgroup_extent_record *record;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct ulist *new_roots = NULL;
-	struct rb_node *node;
+	unsigned long index;
 	u64 num_dirty_extents = 0;
 	u64 qgroup_to_skip;
 	int ret = 0;
@@ -2932,10 +2935,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
-	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
-		record = rb_entry(node, struct btrfs_qgroup_extent_record,
-				  node);
-
+	xa_for_each(&delayed_refs->dirty_extents, index, record) {
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
@@ -3001,7 +3001,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		ulist_free(record->old_roots);
 		ulist_free(new_roots);
 		new_roots = NULL;
-		rb_erase(node, &delayed_refs->dirty_extent_root);
+		xa_erase(&delayed_refs->dirty_extents, index);
 		kfree(record);
 
 	}
@@ -4788,15 +4788,13 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
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
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3388c836b9a5..c473c049d37f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -143,8 +143,7 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 		BUG_ON(!list_empty(&transaction->list));
 		WARN_ON(!RB_EMPTY_ROOT(
 				&transaction->delayed_refs.href_root.rb_root));
-		WARN_ON(!RB_EMPTY_ROOT(
-				&transaction->delayed_refs.dirty_extent_root));
+		WARN_ON(!xa_empty(&transaction->delayed_refs.dirty_extents));
 		if (transaction->delayed_refs.pending_csums)
 			btrfs_err(transaction->fs_info,
 				  "pending csums is %llu",
@@ -351,7 +350,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
 
 	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
-	cur_trans->delayed_refs.dirty_extent_root = RB_ROOT;
+	xa_init(&cur_trans->delayed_refs.dirty_extents);
 	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
 
 	/*
-- 
2.39.2



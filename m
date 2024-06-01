Return-Path: <linux-btrfs+bounces-5384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D78D6F8B
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8D11C214F4
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF62514F13C;
	Sat,  1 Jun 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frtaKHyC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888C219EA
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Jun 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717242143; cv=none; b=qNczqzT2TKv8uj9dHYcWi1E3Oak04dDppwR7coQrlT4DkvwoA6rPRcJIce84ijZmRir5PM0eLumuTNbuppEtZTNmmD0zqtwTQYlxP4XP7JM3dcYO98gM33Tfdbwki0rF6ukC16ZW9I69ojqyDlRAxck3miV/Q2g912m7EnTd310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717242143; c=relaxed/simple;
	bh=5arH/s20AgRnu1JnzCRHfb6YDRgdTLCrBfnI5kf6kFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDQrCd6WxQ9GnEF50couFViHTIPQp++KXBWxZO05dwA+snPo+4170PUE/aqzWyZrVMRc+qyy8yNTNmEkvOf8u/ZJYOLsh+sNkWOFXGwH4HzVJPUrIKsnDMNrobb5GEG+1V37XLL0Q4WuxTdZINaSv2yGWHuS+r0ad0nD59fCnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frtaKHyC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a5344ec7so21686045ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jun 2024 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717242140; x=1717846940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V06dCYq95WyYcjpC7s92ioksMXZ5wYjIwjlvg5ba4M0=;
        b=frtaKHyCDB0WwFQBFu9TgyrDnjvqNYqsukPFcoQYUdxA9+NVwJKI7LLzBClEwwKmx9
         RHPYCtqIIqEGvfv9vseAwQpPXrUh8ZPHDyJ45yV3LQAg+493nyBaR21kq7Ux1bLvH6iZ
         pVdWltHIV+wJUwGzoJ+pLap75Zwu3QghHCN6zsWITbg/jykOh6ZdMxnpQrKL440nwlQu
         3F3FcwQUuYJlUJTaNspVBqcqI6XNgonDK/Elbs/JAN4CvXKOjz4RIMXNfPt89ad1eZ1n
         Hy+m71qdViYNeymIbKglEebdkgPwEtUz5mEte45c0Q3Ut4MZx3VfAjsr6IuCF5Ifqbpa
         NOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717242140; x=1717846940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V06dCYq95WyYcjpC7s92ioksMXZ5wYjIwjlvg5ba4M0=;
        b=V1JHILtFJon5YJRlpxnUusfKjaANa1GSPeblKK53wdoQVfqul6iprYHmw2n6DjX3LN
         /aDmUAtY3/CW010U/gNfzUkEJPnT+r0mlrQTMLpy/gxWypwD+RxbtJHrD+AxLaUj2BrG
         FtLGjhGPbTKQh/O6C8LLK5FE0aifnmmd1APuJnwYHjp/qj0Mqwd0Xinwyk86XSzcocQ5
         IDKRrIG6ZUBWrt8yH5Oc8bmL7C5bfMuDVLlvYkuOJ8Zt0REGMqfNuSt0gU/343NMQfUF
         YUWvILD/seLItE00M7MbD9MYW65t+x5wO+opUkhz3BhAPhbOSlaV0G2Fkyls/yq1l6n5
         MLUg==
X-Gm-Message-State: AOJu0YylbjYQhd34RFIrHDg4jtSUzINOP0rebNb5P9lY1Whh2x5l5N6G
	E5YqaTxhLWVfYBD4DzYQIzwNavk9aTdYw24W654loXgj4+dqimdVr6VdJDaW
X-Google-Smtp-Source: AGHT+IHYExCVsOgZzkjpwjH3fCH16/gSY2/+S23Gnm41ytngX4Au8d5hDe+fl8G2ZUm475UbEzYfug==
X-Received: by 2002:a17:902:e890:b0:1f6:2623:7078 with SMTP id d9443c01a7336-1f635993483mr70492245ad.6.1717242139711;
        Sat, 01 Jun 2024 04:42:19 -0700 (PDT)
Received: from localhost ([123.113.100.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323eb1fdsm31562865ad.204.2024.06.01.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 04:42:19 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] btrfs: qgroup: use xarray to track dirty extents in transaction.
Date: Sat,  1 Jun 2024 19:42:13 +0800
Message-Id: <20240601114213.1647115-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using xarray to track dirty extents can reduce the size of the
struct btrfs_qgroup_extent_record from 64 bytes to 40 bytes.
And xarray is more cache line friendly, it also reduces the
complexity of insertion and search code compared to rb tree.

Another change introduced is about error handling.
Before this patch, the result of btrfs_qgroup_trace_extent_nolock()
is always success. In this patch, because of this function calls
the function xa_store() which has the possibility to fail, so I
refactored some code to handle error correctly. Even though that
we preallocated memory in advance, here should not return an error
theorily. But for the sake of logical completeness, I still
refactored the error handling code. If you have any questions or
concerns about this part, feel free to let me know.

This patch passed the check -g qgroup tests using xfstests and
checkpatch tests.

Suggested-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/delayed-ref.c | 75 ++++++++++++++++++++++++++++--------------
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/qgroup.c      | 71 ++++++++++++++++++++-------------------
 fs/btrfs/qgroup.h      |  1 -
 fs/btrfs/transaction.c |  8 ++---
 5 files changed, 93 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 891ea2fa263c..02bdb2fda703 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -909,13 +909,18 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	bool qrecord_inserted = false;
+	int ret;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 
 	/* Record qgroup extent info if provided */
 	if (qrecord) {
-		if (btrfs_qgroup_trace_extent_nolock(trans->fs_info,
-					delayed_refs, qrecord))
+		ret = btrfs_qgroup_trace_extent_nolock(trans->fs_info,
+					delayed_refs, qrecord);
+
+		if (ret < 0)
+			return ERR_PTR(ret);
+		else if (ret > 0)
 			kfree(qrecord);
 		else
 			qrecord_inserted = true;
@@ -1027,8 +1032,10 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
 	u8 ref_type;
+	int ret = -ENOMEM;
 
 	is_system = (generic_ref->tree_ref.ref_root == BTRFS_CHUNK_TREE_OBJECTID);
+	delayed_refs = &trans->transaction->delayed_refs;
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
@@ -1036,18 +1043,16 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
-	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
-		return -ENOMEM;
-	}
+	if (!head_ref)
+		goto fail1;
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record) {
-			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
-			return -ENOMEM;
-		}
+		if (!record)
+			goto fail2;
+		ret = xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS);
+		if (ret)
+			goto fail3;
 	}
 
 	if (parent)
@@ -1067,7 +1072,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 			      false, is_system, generic_ref->owning_root);
 	head_ref->extent_op = extent_op;
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
 	/*
@@ -1076,6 +1080,11 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	 */
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
+	if (IS_ERR(head_ref)) {
+		spin_unlock(&delayed_refs->lock);
+		ret = PTR_ERR(head_ref);
+		goto fail3;
+	}
 
 	merged = insert_delayed_ref(trans, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
@@ -1096,6 +1105,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		btrfs_qgroup_trace_extent_post(trans, record);
 
 	return 0;
+
+fail3:
+	kfree(record);
+fail2:
+	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+fail1:
+	kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
+	return ret;
 }
 
 /*
@@ -1120,6 +1137,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 owner = generic_ref->data_ref.ino;
 	u64 offset = generic_ref->data_ref.offset;
 	u8 ref_type;
+	int ret = -ENOMEM;
 
 	ASSERT(generic_ref->type == BTRFS_REF_DATA && action);
 	ref = kmem_cache_alloc(btrfs_delayed_data_ref_cachep, GFP_NOFS);
@@ -1137,28 +1155,24 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
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
+		goto fail1;
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
-		if (!record) {
-			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
-			kmem_cache_free(btrfs_delayed_ref_head_cachep,
-					head_ref);
-			return -ENOMEM;
-		}
+		if (!record)
+			goto fail2;
+		ret = xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS);
+		if (ret)
+			goto fail3;
 	}
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
 			      reserved, action, true, false, generic_ref->owning_root);
 	head_ref->extent_op = NULL;
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
 	/*
@@ -1167,6 +1181,11 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	 */
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
+	if (IS_ERR(head_ref)) {
+		ret = PTR_ERR(head_ref);
+		spin_unlock(&delayed_refs->lock);
+		goto fail3;
+	}
 
 	merged = insert_delayed_ref(trans, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
@@ -1187,6 +1206,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	if (qrecord_inserted)
 		return btrfs_qgroup_trace_extent_post(trans, record);
 	return 0;
+
+fail3:
+	kfree(record);
+fail2:
+	kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+fail1:
+	kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
+	return ret;
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
index 5470e1cdf10c..3241d21a7121 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1890,16 +1890,14 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
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
+	struct btrfs_qgroup_extent_record *existing;
+	const u64 bytenr = record->bytenr;
+	int ret;
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 1;
@@ -1907,27 +1905,26 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
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
+	existing = xa_store(&delayed_refs->dirty_extents, bytenr, record, GFP_ATOMIC);
+	if (xa_is_err(existing))
+		goto out;
+	else if (existing) {
+		if (record->data_rsv && !existing->data_rsv) {
+			existing->data_rsv = record->data_rsv;
+			existing->data_rsv_refroot = record->data_rsv_refroot;
 		}
+		existing = xa_store(&delayed_refs->dirty_extents, bytenr, existing, GFP_ATOMIC);
+		if (xa_is_err(existing))
+			goto out;
+		return 1;
 	}
 
-	rb_link_node(&record->node, parent_node, p);
-	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
 	return 0;
+
+out:
+	ret = xa_err(existing);
+	ASSERT(ret != -ENOMEM);
+	return ret;
 }
 
 /*
@@ -2027,13 +2024,19 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret;
 
+	delayed_refs = &trans->transaction->delayed_refs;
 	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr == 0 || num_bytes == 0)
 		return 0;
 	record = kzalloc(sizeof(*record), GFP_NOFS);
 	if (!record)
 		return -ENOMEM;
 
-	delayed_refs = &trans->transaction->delayed_refs;
+	ret = xa_reserve(&delayed_refs->dirty_extents, bytenr, GFP_NOFS);
+	if (ret) {
+		kfree(record);
+		return ret;
+	}
+
 	record->bytenr = bytenr;
 	record->num_bytes = num_bytes;
 	record->old_roots = NULL;
@@ -2044,7 +2047,11 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (ret > 0) {
 		kfree(record);
 		return 0;
+	} else if (ret < 0) {
+		kfree(record);
+		return ret;
 	}
+
 	return btrfs_qgroup_trace_extent_post(trans, record);
 }
 
@@ -2912,7 +2919,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	struct btrfs_qgroup_extent_record *record;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct ulist *new_roots = NULL;
-	struct rb_node *node;
+	unsigned long index;
 	u64 num_dirty_extents = 0;
 	u64 qgroup_to_skip;
 	int ret = 0;
@@ -2922,10 +2929,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
-	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
-		record = rb_entry(node, struct btrfs_qgroup_extent_record,
-				  node);
-
+	xa_for_each(&delayed_refs->dirty_extents, index, record) {
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
@@ -2991,7 +2995,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		ulist_free(record->old_roots);
 		ulist_free(new_roots);
 		new_roots = NULL;
-		rb_erase(node, &delayed_refs->dirty_extent_root);
+		xa_erase(&delayed_refs->dirty_extents, record->bytenr);
 		kfree(record);
 
 	}
@@ -4664,15 +4668,14 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
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
+	xa_init(&trans->delayed_refs.dirty_extents);
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
index bf8e64c766b6..006080814ee5 100644
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
@@ -690,7 +690,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * and then we deadlock with somebody doing a freeze.
 	 *
 	 * If we are ATTACH, it means we just want to catch the current
-	 * transaction and commit it, so we needn't do sb_start_intwrite(). 
+	 * transaction and commit it, so we needn't do sb_start_intwrite().
 	 */
 	if (type & __TRANS_FREEZABLE)
 		sb_start_intwrite(fs_info->sb);
-- 
2.39.2



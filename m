Return-Path: <linux-btrfs+bounces-4224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B718A3FAE
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AC5B21B34
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACA5A0E3;
	Sat, 13 Apr 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EsXqWYOP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F95A110
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052428; cv=none; b=slONYN/xVejumjh5ls2HvPjZPap5dpDkqCwCcnhdA4uiRB9HuAKQzHWsG9mjCIzQRutUVVp12Vv8D8wvcPUmXhEsKMtOwbx+EfY3XToay1xDcTl3RsIw2OGHCjlbneqLuLeIOyYR9Dudn/mNx426Pn19Db8hDe/ohrJaAGqi2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052428; c=relaxed/simple;
	bh=wbhioR954HNBElXi9tHornoy3yOZ9U6J6ZRKsGMI5Jg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cymAtYBkXxWOlThJO15qsP4RWNzUDFmF11pd/0nABhHvprJ4nDIZLKIbJgktynSp+7mPGhdk9rGF9vXWA9RJ4+yWMAMCcjo7w0lmCc7cfVFmiZ+yNOF5XK5Eqr2H7uHNUcBCHlHg+UkZoJy/JkQ16i0Juhckw5dGioyKVWxomHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EsXqWYOP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78edc49861aso30932685a.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052425; x=1713657225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eL3N9mTd/Xo6KBv2BvagwqTZ/fWZ7Y0B+Z14Fr60G4=;
        b=EsXqWYOPPv4dVf2W+7z332DswWmXcNGKcnv5uGklA4DFdkQ+vUbqASX4wki3gmHcjJ
         kdGSbS2NuM5RxJeIDIAjH/0jtR9HA4sEtDag3Q+OZ8/38alpNOtz8oY0TBygytXOc0HO
         6kURcP0MJWAVJkF/sftieyPjINY8GXiGvxTaR9FraZStthWBKXP5GvekOqgRxgQR62P+
         fNISI0xSgYD4iMEg40nbrXVGoz5uBrVNs9Js8sqfewCMDRkziyV3DXNKu1n1UpMaWm6n
         5+LEKFZ+BI+yqLZIiu7o6jOrKRbSw3tN/ByLkGcOfxV6h1V2bV0Pp2YEspfGSm+j/R1e
         0EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052425; x=1713657225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eL3N9mTd/Xo6KBv2BvagwqTZ/fWZ7Y0B+Z14Fr60G4=;
        b=ZUq7MyCnLJRb0WAY7wDOHMJLHO3nsAHdTf4f8w9la51r8wEC1sHZlRZm1+gXdPBXwr
         n6tM9+VyKYPJZ97oZLeORDJRss1KbMBsBN4fOn8XM6PlDpcniy6CUqatQkemn34kFchB
         fd+hKLTfZGwfAMFfytzD6DVOCM8KEcM4CHUoP4CbtbCuldFShICX45EuQDN4218gTuQR
         afKydnAWpkbKwnKmb3dNwPT0ZgVScgMsVzuDEuRTU9iYK2cqbYOaimv65cFiXMaJMyRA
         v5MhPZyY/0CjDhd9hRUSSmtV8y/Wv6+rRtNnIwAMqhlib3Ac2J3XVooaDEyE12ikcWT5
         1F7g==
X-Gm-Message-State: AOJu0YzJdxlCo0NsjCx0YQlnZ3mvh0yxmm5QSBG7alD5ahoi8YoWKC9U
	akXveThTxmdmxdGKFKY9N534tBDFdGYz4ZZUrMf4m0ZuQQmYLXLFdvnoc+7rfVD19uV+JkKrnAb
	B
X-Google-Smtp-Source: AGHT+IEv6uPGhSlmUR8PZfNmZvHoQ/ztrzoEWH01ntXZstRxDD/OlZKYwsCz/hX/wTbemtfiRyZmqw==
X-Received: by 2002:a05:620a:47ed:b0:78d:436e:f0af with SMTP id du45-20020a05620a47ed00b0078d436ef0afmr6606453qkb.58.1713052425320;
        Sat, 13 Apr 2024 16:53:45 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b0078d735ca917sm4332767qkn.123.2024.04.13.16.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 11/19] btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node
Date: Sat, 13 Apr 2024 19:53:21 -0400
Message-ID: <b5d8f7677e5200ca546113804816fa811b502111.1713052088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713052088.git.josef@toxicpanda.com>
References: <cover.1713052088.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two members are shared by both the tree refs and data refs, so
move them into btrfs_delayed_ref_node proper.  This allows us to greatly
simplify the comparison code, as the shared refs always only sort on
parent, and the non shared refs always sort first on ref_root, and then
only data refs sort on their specific fields.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c           | 12 ++----
 fs/btrfs/delayed-ref.c       | 82 ++++++++++++------------------------
 fs/btrfs/delayed-ref.h       | 13 ++++--
 fs/btrfs/extent-tree.c       | 18 ++++----
 include/trace/events/btrfs.h |  8 ++--
 5 files changed, 52 insertions(+), 81 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index c1e6a5bbeeaf..98a0cf68d198 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -928,7 +928,7 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 			}
 
 			ref = btrfs_delayed_node_to_tree_ref(node);
-			ret = add_indirect_ref(fs_info, preftrees, ref->root,
+			ret = add_indirect_ref(fs_info, preftrees, node->ref_root,
 					       key_ptr, ref->level + 1,
 					       node->bytenr, count, sc,
 					       GFP_ATOMIC);
@@ -941,7 +941,7 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 			ref = btrfs_delayed_node_to_tree_ref(node);
 
 			ret = add_direct_ref(fs_info, preftrees, ref->level + 1,
-					     ref->parent, node->bytenr, count,
+					     node->parent, node->bytenr, count,
 					     sc, GFP_ATOMIC);
 			break;
 		}
@@ -972,18 +972,14 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 			if (sc && count < 0)
 				sc->have_delayed_delete_refs = true;
 
-			ret = add_indirect_ref(fs_info, preftrees, ref->root,
+			ret = add_indirect_ref(fs_info, preftrees, node->ref_root,
 					       &key, 0, node->bytenr, count, sc,
 					       GFP_ATOMIC);
 			break;
 		}
 		case BTRFS_SHARED_DATA_REF_KEY: {
 			/* SHARED DIRECT FULL backref */
-			struct btrfs_delayed_data_ref *ref;
-
-			ref = btrfs_delayed_node_to_data_ref(node);
-
-			ret = add_direct_ref(fs_info, preftrees, 0, ref->parent,
+			ret = add_direct_ref(fs_info, preftrees, 0, node->parent,
 					     node->bytenr, count, sc,
 					     GFP_ATOMIC);
 			break;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index a3eb3eb2f321..f9779142a174 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -303,55 +303,20 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-/*
- * compare two delayed tree backrefs with same bytenr and type
- */
-static int comp_tree_refs(struct btrfs_delayed_tree_ref *ref1,
-			  struct btrfs_delayed_tree_ref *ref2)
-{
-	struct btrfs_delayed_ref_node *node = btrfs_delayed_tree_ref_to_node(ref1);
-
-	if (node->type == BTRFS_TREE_BLOCK_REF_KEY) {
-		if (ref1->root < ref2->root)
-			return -1;
-		if (ref1->root > ref2->root)
-			return 1;
-	} else {
-		if (ref1->parent < ref2->parent)
-			return -1;
-		if (ref1->parent > ref2->parent)
-			return 1;
-	}
-	return 0;
-}
-
 /*
  * compare two delayed data backrefs with same bytenr and type
  */
-static int comp_data_refs(struct btrfs_delayed_data_ref *ref1,
-			  struct btrfs_delayed_data_ref *ref2)
+static int comp_data_refs(struct btrfs_delayed_ref_node *ref1,
+			  struct btrfs_delayed_ref_node *ref2)
 {
-	struct btrfs_delayed_ref_node *node = btrfs_delayed_data_ref_to_node(ref1);
-
-	if (node->type == BTRFS_EXTENT_DATA_REF_KEY) {
-		if (ref1->root < ref2->root)
-			return -1;
-		if (ref1->root > ref2->root)
-			return 1;
-		if (ref1->objectid < ref2->objectid)
-			return -1;
-		if (ref1->objectid > ref2->objectid)
-			return 1;
-		if (ref1->offset < ref2->offset)
-			return -1;
-		if (ref1->offset > ref2->offset)
-			return 1;
-	} else {
-		if (ref1->parent < ref2->parent)
-			return -1;
-		if (ref1->parent > ref2->parent)
-			return 1;
-	}
+	if (ref1->data_ref.objectid < ref2->data_ref.objectid)
+		return -1;
+	if (ref1->data_ref.objectid > ref2->data_ref.objectid)
+		return 1;
+	if (ref1->data_ref.offset < ref2->data_ref.offset)
+		return -1;
+	if (ref1->data_ref.offset > ref2->data_ref.offset)
+		return 1;
 	return 0;
 }
 
@@ -365,13 +330,20 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 		return -1;
 	if (ref1->type > ref2->type)
 		return 1;
-	if (ref1->type == BTRFS_TREE_BLOCK_REF_KEY ||
-	    ref1->type == BTRFS_SHARED_BLOCK_REF_KEY)
-		ret = comp_tree_refs(btrfs_delayed_node_to_tree_ref(ref1),
-				     btrfs_delayed_node_to_tree_ref(ref2));
-	else
-		ret = comp_data_refs(btrfs_delayed_node_to_data_ref(ref1),
-				     btrfs_delayed_node_to_data_ref(ref2));
+	if (ref1->type == BTRFS_SHARED_BLOCK_REF_KEY ||
+	    ref1->type == BTRFS_SHARED_DATA_REF_KEY) {
+		if (ref1->parent < ref2->parent)
+			return -1;
+		if (ref1->parent > ref2->parent)
+			return 1;
+	} else {
+		if (ref1->ref_root < ref2->ref_root)
+			return -1;
+		if (ref1->ref_root > ref2->ref_root)
+			return -1;
+		if (ref1->type == BTRFS_EXTENT_DATA_REF_KEY)
+			ret = comp_data_refs(ref1, ref2);
+	}
 	if (ret)
 		return ret;
 	if (check_seq) {
@@ -1005,17 +977,15 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	ref->action = action;
 	ref->seq = seq;
 	ref->type = btrfs_ref_type(generic_ref);
+	ref->ref_root = generic_ref->ref_root;
+	ref->parent = generic_ref->parent;
 	RB_CLEAR_NODE(&ref->ref_node);
 	INIT_LIST_HEAD(&ref->add_list);
 
 	if (generic_ref->type == BTRFS_REF_DATA) {
-		ref->data_ref.root = generic_ref->ref_root;
-		ref->data_ref.parent = generic_ref->parent;
 		ref->data_ref.objectid = generic_ref->data_ref.ino;
 		ref->data_ref.offset = generic_ref->data_ref.offset;
 	} else {
-		ref->tree_ref.root = generic_ref->ref_root;
-		ref->tree_ref.parent = generic_ref->parent;
 		ref->tree_ref.level = generic_ref->tree_ref.level;
 	}
 }
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 000fdcaf2314..6ad48e0a0a1a 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -31,14 +31,10 @@ enum btrfs_delayed_ref_action {
 } __packed;
 
 struct btrfs_delayed_tree_ref {
-	u64 root;
-	u64 parent;
 	int level;
 };
 
 struct btrfs_delayed_data_ref {
-	u64 root;
-	u64 parent;
 	u64 objectid;
 	u64 offset;
 };
@@ -61,6 +57,15 @@ struct btrfs_delayed_ref_node {
 	/* seq number to keep track of insertion order */
 	u64 seq;
 
+	/* the ref_root for this ref */
+	u64 ref_root;
+
+	/*
+	 * the parent for this ref, if this isn't set the ref_root is the
+	 * reference owner.
+	 */
+	u64 parent;
+
 	/* ref count on this data structure */
 	refcount_t refs;
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 268516003927..0e42c8bddc0c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1577,7 +1577,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	trace_run_delayed_data_ref(trans->fs_info, node);
 
 	if (node->type == BTRFS_SHARED_DATA_REF_KEY)
-		parent = ref->parent;
+		parent = node->parent;
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		struct btrfs_key key;
@@ -1596,7 +1596,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = node->num_bytes;
 
-		ret = alloc_reserved_file_extent(trans, parent, ref->root,
+		ret = alloc_reserved_file_extent(trans, parent, node->ref_root,
 						 flags, ref->objectid,
 						 ref->offset, &key,
 						 node->ref_mod, href->owning_root);
@@ -1604,12 +1604,12 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		if (!ret)
 			ret = btrfs_record_squota_delta(trans->fs_info, &delta);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
-		ret = __btrfs_inc_extent_ref(trans, node, parent, ref->root,
+		ret = __btrfs_inc_extent_ref(trans, node, parent, node->ref_root,
 					     ref->objectid, ref->offset,
 					     extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, href, node, parent,
-					  ref->root, ref->objectid,
+					  node->ref_root, ref->objectid,
 					  ref->offset, extent_op);
 	} else {
 		BUG();
@@ -1740,8 +1740,8 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	trace_run_delayed_tree_ref(trans->fs_info, node);
 
 	if (node->type == BTRFS_SHARED_BLOCK_REF_KEY)
-		parent = ref->parent;
-	ref_root = ref->root;
+		parent = node->parent;
+	ref_root = node->ref_root;
 
 	if (unlikely(node->ref_mod != 1)) {
 		btrfs_err(trans->fs_info,
@@ -2359,7 +2359,7 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 		 * If our ref doesn't match the one we're currently looking at
 		 * then we have a cross reference.
 		 */
-		if (data_ref->root != root->root_key.objectid ||
+		if (ref->ref_root != root->root_key.objectid ||
 		    data_ref->objectid != objectid ||
 		    data_ref->offset != offset) {
 			ret = 1;
@@ -4946,11 +4946,11 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
 		btrfs_set_extent_inline_ref_type(leaf, iref,
 						 BTRFS_SHARED_BLOCK_REF_KEY);
-		btrfs_set_extent_inline_ref_offset(leaf, iref, ref->parent);
+		btrfs_set_extent_inline_ref_offset(leaf, iref, node->parent);
 	} else {
 		btrfs_set_extent_inline_ref_type(leaf, iref,
 						 BTRFS_TREE_BLOCK_REF_KEY);
-		btrfs_set_extent_inline_ref_offset(leaf, iref, ref->root);
+		btrfs_set_extent_inline_ref_offset(leaf, iref, node->ref_root);
 	}
 
 	btrfs_mark_buffer_dirty(trans, leaf);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index dae29f6d6b4c..e6cee75c384c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -887,8 +887,8 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
 		__entry->bytenr		= ref->bytenr;
 		__entry->num_bytes	= ref->num_bytes;
 		__entry->action		= ref->action;
-		__entry->parent		= ref->tree_ref.parent;
-		__entry->ref_root	= ref->tree_ref.root;
+		__entry->parent		= ref->parent;
+		__entry->ref_root	= ref->ref_root;
 		__entry->level		= ref->tree_ref.level;
 		__entry->type		= ref->type;
 		__entry->seq		= ref->seq;
@@ -945,8 +945,8 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
 		__entry->bytenr		= ref->bytenr;
 		__entry->num_bytes	= ref->num_bytes;
 		__entry->action		= ref->action;
-		__entry->parent		= ref->data_ref.parent;
-		__entry->ref_root	= ref->data_ref.root;
+		__entry->parent		= ref->parent;
+		__entry->ref_root	= ref->ref_root;
 		__entry->owner		= ref->data_ref.objectid;
 		__entry->offset		= ref->data_ref.offset;
 		__entry->type		= ref->type;
-- 
2.43.0



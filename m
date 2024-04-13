Return-Path: <linux-btrfs+bounces-4215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF18A3FA5
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6551F21A37
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1C58AC6;
	Sat, 13 Apr 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="S+fRM9nc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670358231
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052418; cv=none; b=NVq77zRFad61MWJHY9WZA3qXku0rEL2CCLFBRjiZ3yi/3/6zvENphP7CfLbEI6cvmyKxIG95CymN85ibAO6sZM1ZVqy8Sl42iLVY9uwhG5t/Gclu2HrutGy2m+vEPLyI5TnZX1EX0XkJkV6jtFeE4omYT5mONnDE2Orzw5J1TRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052418; c=relaxed/simple;
	bh=ZGZQLhRVlU7QmWnkqSLmf4jobaWfAIdKwtSgnDjw6kM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq2CpPp/rvU3S+l3BoQXmnGeMp9ysz3XMysey1nImMx6e3zPFKGPqm1vRO8vXsXMjtE+98o+Wi/3wRo4wNqo6StYXxeYRVtXJsiLoG4Y5buvTeeloKFWBlPTW5xJoJ8hjImYhbTGlMqfupCKLsM8QNk3jKm7CUNMavkCg9pTisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=S+fRM9nc; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb7ac9e726so22126a34.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052416; x=1713657216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urlbATTuEl+t+KhnBDGM+Yb/BI4+ZWVVsEU4I7kpHNU=;
        b=S+fRM9ncCX0e9HUBPVLqGkkrM6qPBxQ+OqY+g28jOmeId09tEUgAAIZ3w3mnbFMVJi
         MaIrlK20vwsiejqzGljJQs0gX7J+mnykFVY/gOry9RV2rckCM34SbmYnVP29L8MHGBwO
         vYX3EZypbQ+E5gAUIN9o3bGrWZfYx5r/8Ez884ukXMK93b9SCElnmm7LDtOB3LHksPHR
         CQivFuVIXAPUcM0iPKsg3qTeGF9/v/D6XBxLnqRn22dS618RVLOF4zMS8tAGmTf5nqze
         9OxzndgadzVnpqc5aMl5m9aM6yEqAWiESTP6ko64C6p9YFcFfkj2fg2G6eVx+BtLJlva
         dKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052416; x=1713657216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urlbATTuEl+t+KhnBDGM+Yb/BI4+ZWVVsEU4I7kpHNU=;
        b=t+V6PvflkQE3HVL4aGfXxTSNwWKlGKDOB8d9B46Ahyy5B0Nw2VbLgOXgsOUCb9iDbr
         tCYsIQOC8Os1lhOXrlCUB5y4oPKVJjiLp1IqispaztIsUbkF3F7oVw5SZUZnU7wENvBE
         oAvV032Lk/YrGQdrvaAE8gOh1xRRVdYKaKkfpL+3E5dL6sBijfVpqmCZ8+utr+jSVKUV
         0EWFYdPRcSERnjGaUeiklDNUgAN7zPWcrtz9IH8AM4b1BDy/iVUUBRyiiwFXRyumlmCT
         soQu5c+aRxfTNL0Te+IHfGAEtkjnhd8kxZ5JPEfHhNiVr7Tk6Uryj3R2G9dvYCsD3jn3
         JsGw==
X-Gm-Message-State: AOJu0YxsKU/nk9XJXGQOOGG6HI3Shl7cQfwqUMAS0TCVp8nA2sZSVZFH
	je86k6KxJu4eHfNj4PIRktXcTpcOLk/ISFSAz1sk0MyA9L24UAjrnzEHB8Q+0kyq0vUl5F9d8WW
	+
X-Google-Smtp-Source: AGHT+IFnJQy2c7p3V9NzT1cnktqDRgYzn3FXzdS6c7EpFyaYtjfJuZtU1h2T9dcSK3tYWPwIyR6GJw==
X-Received: by 2002:aca:110a:0:b0:3c5:ee6e:5d6a with SMTP id 10-20020aca110a000000b003c5ee6e5d6amr7052646oir.21.1713052416090;
        Sat, 13 Apr 2024 16:53:36 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id he4-20020a05622a600400b00434efa0feaasm4070682qtb.1.2024.04.13.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 02/19] btrfs: embed data_ref and tree_ref in btrfs_delayed_ref_node
Date: Sat, 13 Apr 2024 19:53:12 -0400
Message-ID: <cb592516a71f62dd136bd858670d0ae6f54d8cdc.1713052088.git.josef@toxicpanda.com>
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

We have been embedding btrfs_delayed_ref_node in the
btrfs_delayed_data_ref and btrfs_delayed_tree_ref, and then we have two
sets of cachep's and a variety of handling that is awkward because of
this separation.

Instead union these two members inside of btrfs_delayed_ref_node and
make that the first class object.  This allows us to go down to one
cachep for our delayed ref nodes instead of two.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 51 ++++++++++++++----------------------------
 fs/btrfs/delayed-ref.h | 44 +++++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index d920663a18fd..9382f7c81c25 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -16,8 +16,7 @@
 #include "fs.h"
 
 struct kmem_cache *btrfs_delayed_ref_head_cachep;
-struct kmem_cache *btrfs_delayed_tree_ref_cachep;
-struct kmem_cache *btrfs_delayed_data_ref_cachep;
+struct kmem_cache *btrfs_delayed_ref_node_cachep;
 struct kmem_cache *btrfs_delayed_extent_op_cachep;
 /*
  * delayed back reference update tracking.  For subvolume trees
@@ -1082,26 +1081,26 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	is_system = (generic_ref->tree_ref.ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
-	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
-	if (!ref)
+	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
+	if (!node)
 		return -ENOMEM;
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
 	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
+		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 		return -ENOMEM;
 	}
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
-			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
+			kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 			kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 			return -ENOMEM;
 		}
 	}
 
-	node = btrfs_delayed_tree_ref_to_node(ref);
+	ref = btrfs_delayed_node_to_tree_ref(node);
 
 	if (parent)
 		ref_type = BTRFS_SHARED_BLOCK_REF_KEY;
@@ -1143,7 +1142,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 				   action == BTRFS_ADD_DELAYED_EXTENT ?
 				   BTRFS_ADD_DELAYED_REF : action);
 	if (merged)
-		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
+		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 	if (qrecord_inserted)
 		btrfs_qgroup_trace_extent_post(trans, record);
@@ -1176,11 +1175,11 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u8 ref_type;
 
 	ASSERT(generic_ref->type == BTRFS_REF_DATA && action);
-	ref = kmem_cache_alloc(btrfs_delayed_data_ref_cachep, GFP_NOFS);
-	if (!ref)
+	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
+	if (!node)
 		return -ENOMEM;
 
-	node = btrfs_delayed_data_ref_to_node(ref);
+	ref = btrfs_delayed_node_to_data_ref(node);
 
 	if (parent)
 	        ref_type = BTRFS_SHARED_DATA_REF_KEY;
@@ -1196,14 +1195,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
 	if (!head_ref) {
-		kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
+		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 		return -ENOMEM;
 	}
 
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
-			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
+			kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 			kmem_cache_free(btrfs_delayed_ref_head_cachep,
 					head_ref);
 			return -ENOMEM;
@@ -1237,7 +1236,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 				   action == BTRFS_ADD_DELAYED_EXTENT ?
 				   BTRFS_ADD_DELAYED_REF : action);
 	if (merged)
-		kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
+		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 
 	if (qrecord_inserted)
@@ -1280,18 +1279,7 @@ void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
 {
 	if (refcount_dec_and_test(&ref->refs)) {
 		WARN_ON(!RB_EMPTY_NODE(&ref->ref_node));
-		switch (ref->type) {
-		case BTRFS_TREE_BLOCK_REF_KEY:
-		case BTRFS_SHARED_BLOCK_REF_KEY:
-			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
-			break;
-		case BTRFS_EXTENT_DATA_REF_KEY:
-		case BTRFS_SHARED_DATA_REF_KEY:
-			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
-			break;
-		default:
-			BUG();
-		}
+		kmem_cache_free(btrfs_delayed_ref_node_cachep, ref);
 	}
 }
 
@@ -1310,8 +1298,7 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 byt
 void __cold btrfs_delayed_ref_exit(void)
 {
 	kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
-	kmem_cache_destroy(btrfs_delayed_tree_ref_cachep);
-	kmem_cache_destroy(btrfs_delayed_data_ref_cachep);
+	kmem_cache_destroy(btrfs_delayed_ref_node_cachep);
 	kmem_cache_destroy(btrfs_delayed_extent_op_cachep);
 }
 
@@ -1321,12 +1308,8 @@ int __init btrfs_delayed_ref_init(void)
 	if (!btrfs_delayed_ref_head_cachep)
 		goto fail;
 
-	btrfs_delayed_tree_ref_cachep = KMEM_CACHE(btrfs_delayed_tree_ref, 0);
-	if (!btrfs_delayed_tree_ref_cachep)
-		goto fail;
-
-	btrfs_delayed_data_ref_cachep = KMEM_CACHE(btrfs_delayed_data_ref, 0);
-	if (!btrfs_delayed_data_ref_cachep)
+	btrfs_delayed_ref_node_cachep = KMEM_CACHE(btrfs_delayed_ref_node, 0);
+	if (!btrfs_delayed_ref_node_cachep)
 		goto fail;
 
 	btrfs_delayed_extent_op_cachep = KMEM_CACHE(btrfs_delayed_extent_op, 0);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b3a78bf7b072..2de447d9aaba 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -30,6 +30,19 @@ enum btrfs_delayed_ref_action {
 	BTRFS_UPDATE_DELAYED_HEAD,
 } __packed;
 
+struct btrfs_delayed_tree_ref {
+	u64 root;
+	u64 parent;
+	int level;
+};
+
+struct btrfs_delayed_data_ref {
+	u64 root;
+	u64 parent;
+	u64 objectid;
+	u64 offset;
+};
+
 struct btrfs_delayed_ref_node {
 	struct rb_node ref_node;
 	/*
@@ -64,6 +77,11 @@ struct btrfs_delayed_ref_node {
 
 	unsigned int action:8;
 	unsigned int type:8;
+
+	union {
+		struct btrfs_delayed_tree_ref tree_ref;
+		struct btrfs_delayed_data_ref data_ref;
+	};
 };
 
 struct btrfs_delayed_extent_op {
@@ -151,21 +169,6 @@ struct btrfs_delayed_ref_head {
 	bool processing;
 };
 
-struct btrfs_delayed_tree_ref {
-	struct btrfs_delayed_ref_node node;
-	u64 root;
-	u64 parent;
-	int level;
-};
-
-struct btrfs_delayed_data_ref {
-	struct btrfs_delayed_ref_node node;
-	u64 root;
-	u64 parent;
-	u64 objectid;
-	u64 offset;
-};
-
 enum btrfs_delayed_ref_flags {
 	/* Indicate that we are flushing delayed refs for the commit */
 	BTRFS_DELAYED_REFS_FLUSHING,
@@ -279,8 +282,7 @@ struct btrfs_ref {
 };
 
 extern struct kmem_cache *btrfs_delayed_ref_head_cachep;
-extern struct kmem_cache *btrfs_delayed_tree_ref_cachep;
-extern struct kmem_cache *btrfs_delayed_data_ref_cachep;
+extern struct kmem_cache *btrfs_delayed_ref_node_cachep;
 extern struct kmem_cache *btrfs_delayed_extent_op_cachep;
 
 int __init btrfs_delayed_ref_init(void);
@@ -404,25 +406,25 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 static inline struct btrfs_delayed_tree_ref *
 btrfs_delayed_node_to_tree_ref(struct btrfs_delayed_ref_node *node)
 {
-	return container_of(node, struct btrfs_delayed_tree_ref, node);
+	return &node->tree_ref;
 }
 
 static inline struct btrfs_delayed_data_ref *
 btrfs_delayed_node_to_data_ref(struct btrfs_delayed_ref_node *node)
 {
-	return container_of(node, struct btrfs_delayed_data_ref, node);
+	return &node->data_ref;
 }
 
 static inline struct btrfs_delayed_ref_node *
 btrfs_delayed_tree_ref_to_node(struct btrfs_delayed_tree_ref *ref)
 {
-	return &ref->node;
+	return container_of(ref, struct btrfs_delayed_ref_node, tree_ref);
 }
 
 static inline struct btrfs_delayed_ref_node *
 btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
 {
-	return &ref->node;
+	return container_of(ref, struct btrfs_delayed_ref_node, data_ref);
 }
 
 #endif
-- 
2.43.0



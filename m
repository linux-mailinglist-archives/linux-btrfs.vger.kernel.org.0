Return-Path: <linux-btrfs+bounces-4223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8AD8A3FAD
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C21F21778
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A095823A;
	Sat, 13 Apr 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZGTPzhKl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A35A0F9
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052427; cv=none; b=Cg3fxI91BviAzbfmQ1ci0OmJ2RFdPId41YfbTqok1iisJv742DrBHG60L8QnnJNtuLRl8bNPgla+bYA7B7yi2lx3vXL5a6OHKU0wWSVxPwNFsUVMIe7T9lcUqeWN5H4YHImCB+5vNmOj+FdaQaS2DGxzNHbA/kviGiGt9JZ7duE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052427; c=relaxed/simple;
	bh=ww0Qlr5ue7paaBE7HHR4LGCK7khxcahLqc55HAAgGa0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO5naP2Az1ygPsRsE8r1XR1CCH5B8sBqqypcG19C83ZMk25euA2hGXggvc+FaxnaSxXCFjIej5tjGg6I8/Ua7knYwZDl7ZWhIsPoSGsxoLQ+butpLTAZCP+Ufntlxu2M7MD/D9mnQrNn388caWSki97mnyiE+Jq3N4AfYspSi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZGTPzhKl; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6962950c6bfso16737026d6.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052424; x=1713657224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtES1W97/Zau8nOpPCDm8rhmRxsz6ZU8DV4VRrzKyQc=;
        b=ZGTPzhKlkRkwhg4XrpyqvGXKvCFVcFukLrTcgeOT4DRPZXOkLOuBG9givb6ZZJVd1w
         SgTRMM5B/XNfCmj9kBUFJkpYrtPv0AvcgsFKez4k3eEHsMpcVC1yRBXv8kEemIk95Mon
         UaOoI0r5DNRnqJWq6UH7xReFjz5AhbdMtMVqAO1pp9vOO1zCv8Xg8fKfO7tZ0V8fACkK
         PiU+ZQUsGRiesK0wLA/rWu2/WJy6HFlUIIgJ+D9wN+TCbO2yzxO0/MeXQpjwEpLdPlaW
         a0mQ7hJYfkfjiwLsNG07UsU5XAMd9GmNcMkXQcRNix/xi8mHfgTVEV0ESQfLjIFVx+dU
         4/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052424; x=1713657224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtES1W97/Zau8nOpPCDm8rhmRxsz6ZU8DV4VRrzKyQc=;
        b=rBxLtVFYVuF0UiZoQYPZnQNudX8KiZHfjbtCgZES7PXlt43TDUNduBA1URdBPi2MV2
         25QmPAiSE/9g8ML7UMWZGBRTB85fv0TBEsgBVrAF8ekKBUrXaIGx69s01wL7ZHJVJB1j
         9PL2wQrPqpEc8aelIZ9K33xhpAvsWA+nkHsPvin0qsIHVXhExcdCUN85KpbkPQmkYQNZ
         pkln7GNT/pWzf93Ytyt0S5ZnPzwsSJipkdvKcnf3GL1qxLsE4fwkqShdHg6wF3Lukf+Y
         ANLPJWP+h2L4Xk09HRhUXncYop6JwxJs1vYsHeVIXQKH5uEQG6cIXgjnfR//kyrqZhOT
         SFjg==
X-Gm-Message-State: AOJu0Yx3IigOUr5YIjjTuBh1imGzYVQs9aJYSLiA/85bgpFYlYcKsbra
	6jChxMqlHFaZeopf67CNVmkzanS/bgphndizMerGDSqwoa0GqJGYYu8ovfEITIubAY7Nhahw8D6
	3
X-Google-Smtp-Source: AGHT+IGDlFjbb8rwntsmOD3n/71mCgxju0Oqy38pHCK5zVh4+lfMLsT+4f8vFxJNPUJfz26vM4+a1w==
X-Received: by 2002:a05:6214:21a9:b0:699:319b:f0fa with SMTP id t9-20020a05621421a900b00699319bf0famr7656494qvc.40.1713052424230;
        Sat, 13 Apr 2024 16:53:44 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g6-20020ad45106000000b0069b439190c8sm4205006qvp.64.2024.04.13.16.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 10/19] btrfs: rename ->len to ->num_bytes in btrfs_ref
Date: Sat, 13 Apr 2024 19:53:20 -0400
Message-ID: <62df4a1c018a2b6de344b4ed9db11a59df3a3448.1713052088.git.josef@toxicpanda.com>
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

We consistently use ->num_bytes everywhere through the delayed ref code,
except in btrfs_ref.  Rename btrfs_ref to match all the other code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c |  8 ++++----
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/extent-tree.c | 14 +++++++-------
 fs/btrfs/file.c        | 10 +++++-----
 fs/btrfs/inode-item.c  |  2 +-
 fs/btrfs/ref-verify.c  |  2 +-
 fs/btrfs/relocation.c  | 14 +++++++-------
 fs/btrfs/tree-log.c    |  2 +-
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 342f32ae08c9..a3eb3eb2f321 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -874,7 +874,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 
 	refcount_set(&head_ref->refs, 1);
 	head_ref->bytenr = generic_ref->bytenr;
-	head_ref->num_bytes = generic_ref->len;
+	head_ref->num_bytes = generic_ref->num_bytes;
 	head_ref->ref_mod = count_mod;
 	head_ref->reserved_bytes = reserved;
 	head_ref->must_insert_reserved = must_insert_reserved;
@@ -895,7 +895,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 			qrecord->data_rsv_refroot = generic_ref->ref_root;
 		}
 		qrecord->bytenr = generic_ref->bytenr;
-		qrecord->num_bytes = generic_ref->len;
+		qrecord->num_bytes = generic_ref->num_bytes;
 		qrecord->old_roots = NULL;
 	}
 }
@@ -1000,7 +1000,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 
 	refcount_set(&ref->refs, 1);
 	ref->bytenr = generic_ref->bytenr;
-	ref->num_bytes = generic_ref->len;
+	ref->num_bytes = generic_ref->num_bytes;
 	ref->ref_mod = 1;
 	ref->action = action;
 	ref->seq = seq;
@@ -1157,7 +1157,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		.type = BTRFS_REF_METADATA,
 		.action = BTRFS_UPDATE_DELAYED_HEAD,
 		.bytenr = bytenr,
-		.len = num_bytes,
+		.num_bytes = num_bytes,
 	};
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 83fcb32715a4..000fdcaf2314 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -260,7 +260,7 @@ struct btrfs_ref {
 	u64 real_root;
 #endif
 	u64 bytenr;
-	u64 len;
+	u64 num_bytes;
 	u64 owning_root;
 
 	/*
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 805e3e904368..268516003927 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2542,7 +2542,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			if (ref.bytenr == 0)
 				continue;
 
-			ref.len = btrfs_file_extent_disk_num_bytes(buf, fi);
+			ref.num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
 			ref.owning_root = ref_root;
 
 			key.offset -= btrfs_file_extent_offset(buf, fi);
@@ -2557,7 +2557,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 		} else {
 			/* We don't know the owning_root, leave as 0. */
 			ref.bytenr = btrfs_node_blockptr(buf, i);
-			ref.len = fs_info->nodesize;
+			ref.num_bytes = fs_info->nodesize;
 
 			btrfs_init_tree_ref(&ref, level - 1,
 					    root->root_key.objectid, for_reloc);
@@ -3466,7 +3466,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		struct btrfs_ref generic_ref = {
 			.action = BTRFS_DROP_DELAYED_REF,
 			.bytenr = buf->start,
-			.len = buf->len,
+			.num_bytes = buf->len,
 			.parent = parent,
 			.owning_root = btrfs_header_owner(buf),
 			.ref_root = root_id,
@@ -3560,7 +3560,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	 * tree, just update pinning info and exit early.
 	 */
 	if (ref->ref_root == BTRFS_TREE_LOG_OBJECTID) {
-		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
+		btrfs_pin_extent(trans, ref->bytenr, ref->num_bytes, 1);
 		ret = 0;
 	} else if (ref->type == BTRFS_REF_METADATA) {
 		ret = btrfs_add_delayed_tree_ref(trans, ref, NULL);
@@ -4967,7 +4967,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_ref generic_ref = {
 		.action = BTRFS_ADD_DELAYED_EXTENT,
 		.bytenr = ins->objectid,
-		.len = ins->offset,
+		.num_bytes = ins->offset,
 		.owning_root = root->root_key.objectid,
 		.ref_root = root->root_key.objectid,
 	};
@@ -5209,7 +5209,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		struct btrfs_ref generic_ref = {
 			.action = BTRFS_ADD_DELAYED_EXTENT,
 			.bytenr = ins.objectid,
-			.len = ins.offset,
+			.num_bytes = ins.offset,
 			.parent = parent,
 			.owning_root = owning_root,
 			.ref_root = root_objectid,
@@ -5594,7 +5594,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		struct btrfs_ref ref = {
 			.action = BTRFS_DROP_DELAYED_REF,
 			.bytenr = bytenr,
-			.len = fs_info->nodesize,
+			.num_bytes = fs_info->nodesize,
 			.owning_root = owner_root,
 			.ref_root = root->root_key.objectid,
 		};
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 416fa1f48fe5..c657dea23396 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -375,7 +375,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				struct btrfs_ref ref = {
 					.action = BTRFS_ADD_DELAYED_REF,
 					.bytenr = disk_bytenr,
-					.len = num_bytes,
+					.num_bytes = num_bytes,
 					.parent = 0,
 					.owning_root = root->root_key.objectid,
 					.ref_root = root->root_key.objectid,
@@ -468,7 +468,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				struct btrfs_ref ref = {
 					.action = BTRFS_DROP_DELAYED_REF,
 					.bytenr = disk_bytenr,
-					.len = num_bytes,
+					.num_bytes = num_bytes,
 					.parent = 0,
 					.owning_root = root->root_key.objectid,
 					.ref_root = root->root_key.objectid,
@@ -753,7 +753,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = bytenr;
-		ref.len = num_bytes;
+		ref.num_bytes = num_bytes;
 		ref.parent = 0;
 		ref.owning_root = root->root_key.objectid;
 		ref.ref_root = root->root_key.objectid;
@@ -783,7 +783,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 
 	ref.action = BTRFS_DROP_DELAYED_REF;
 	ref.bytenr = bytenr;
-	ref.len = num_bytes;
+	ref.num_bytes = num_bytes;
 	ref.parent = 0;
 	ref.owning_root = root->root_key.objectid;
 	ref.ref_root = root->root_key.objectid;
@@ -2326,7 +2326,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_ref ref = {
 			.action = BTRFS_ADD_DELAYED_REF,
 			.bytenr = extent_info->disk_offset,
-			.len = extent_info->disk_len,
+			.num_bytes = extent_info->disk_len,
 			.owning_root = root->root_key.objectid,
 			.ref_root = root->root_key.objectid,
 		};
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index e24605df35bb..7565ff15a69a 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -673,7 +673,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			struct btrfs_ref ref = {
 				.action = BTRFS_DROP_DELAYED_REF,
 				.bytenr = extent_start,
-				.len = extent_num_bytes,
+				.num_bytes = extent_num_bytes,
 				.owning_root = root->root_key.objectid,
 				.ref_root = btrfs_header_owner(leaf),
 			};
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 1108be7a050c..94bbb7ef9a13 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -673,7 +673,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	bool metadata;
 	u64 bytenr = generic_ref->bytenr;
-	u64 num_bytes = generic_ref->len;
+	u64 num_bytes = generic_ref->num_bytes;
 	u64 parent = generic_ref->parent;
 	u64 ref_root = 0;
 	u64 owner = 0;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9e460b79f8b2..9a5a9142ea53 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1162,7 +1162,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		key.offset -= btrfs_file_extent_offset(leaf, fi);
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = new_bytenr;
-		ref.len = num_bytes;
+		ref.num_bytes = num_bytes;
 		ref.parent = parent;
 		ref.owning_root = root->root_key.objectid;
 		ref.ref_root = btrfs_header_owner(leaf);
@@ -1176,7 +1176,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 
 		ref.action = BTRFS_DROP_DELAYED_REF;
 		ref.bytenr = bytenr;
-		ref.len = num_bytes;
+		ref.num_bytes = num_bytes;
 		ref.parent = parent;
 		ref.owning_root = root->root_key.objectid;
 		ref.ref_root = btrfs_header_owner(leaf);
@@ -1392,7 +1392,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = old_bytenr;
-		ref.len = blocksize;
+		ref.num_bytes = blocksize;
 		ref.parent = path->nodes[level]->start;
 		ref.owning_root = src->root_key.objectid;
 		ref.ref_root = src->root_key.objectid;
@@ -1405,7 +1405,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = new_bytenr;
-		ref.len = blocksize;
+		ref.num_bytes = blocksize;
 		ref.parent = 0;
 		ref.owning_root = dest->root_key.objectid;
 		ref.ref_root = dest->root_key.objectid;
@@ -1419,7 +1419,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		/* We don't know the real owning_root, use 0. */
 		ref.action = BTRFS_DROP_DELAYED_REF;
 		ref.bytenr = new_bytenr;
-		ref.len = blocksize;
+		ref.num_bytes = blocksize;
 		ref.parent = path->nodes[level]->start;
 		ref.owning_root = 0;
 		ref.ref_root = src->root_key.objectid;
@@ -1433,7 +1433,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		/* We don't know the real owning_root, use 0. */
 		ref.action = BTRFS_DROP_DELAYED_REF;
 		ref.bytenr = old_bytenr;
-		ref.len = blocksize;
+		ref.num_bytes = blocksize;
 		ref.parent = 0;
 		ref.owning_root = 0;
 		ref.ref_root = dest->root_key.objectid;
@@ -2537,7 +2537,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			struct btrfs_ref ref = {
 				.action = BTRFS_ADD_DELAYED_REF,
 				.bytenr = node->eb->start,
-				.len = blocksize,
+				.num_bytes = blocksize,
 				.parent = upper->eb->start,
 				.owning_root = btrfs_header_owner(upper->eb),
 				.ref_root = btrfs_header_owner(upper->eb),
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index da319ffda4ee..d8e7eb53cd0b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -764,7 +764,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_ref ref = {
 					.action = BTRFS_ADD_DELAYED_REF,
 					.bytenr = ins.objectid,
-					.len = ins.offset,
+					.num_bytes = ins.offset,
 					.owning_root = root->root_key.objectid,
 					.ref_root = root->root_key.objectid,
 				};
-- 
2.43.0



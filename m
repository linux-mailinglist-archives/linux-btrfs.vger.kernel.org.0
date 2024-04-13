Return-Path: <linux-btrfs+bounces-4217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A40C8A3FA7
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407E6B218E1
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6758559B40;
	Sat, 13 Apr 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="E7fuQAaz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB93FB1C
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052421; cv=none; b=MF9JUoWVnLTU1hbliV0R2mbK8nUZX6fsobOiCE+aw1zxgHzDQhIvyD+WvXNiSV4P+spJf8uYdqTN5vuFY40lKWZCvQ5wCjlxdBn1ohFuKAAsNfNtK0G67ZC9A87Tpinfh3BDxPdbK5NThMBuAMneFAtvWfIFyFOacZq3MSlm67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052421; c=relaxed/simple;
	bh=yYlhZPyhFrEnVdm0sPzNy8hbHirEhyx/ePhDSUtadLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ/5yHs9TUH/Fz89Bv7Bj/G5yrPK5fYBweLvdgtrLX4n+Zo44G6aRSmbBIcYRJsTwIDUf13NzYhNZGJC6qG/NWt+/1Ml88qU6m6fXK4jCLCeb8j8Hl9woagbjKRr8cZc69i+xe740Fk9v0zMX73iaG2xOrFXZMFq9GbFyFNd5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=E7fuQAaz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d5f0440d3so141118185a.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052418; x=1713657218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxLyv+SwfqRuzhpybYcNieZpSAW5T3fyoOSQd/1g9FY=;
        b=E7fuQAaz+m8TObybpGQCuazRCmy1Ogn74fAGL2yxfvrx+QY0qvux2L1b9Ia45+2Ixt
         3Pc8LeT8tQgF3RLHQephS4U6vgdZ40m/62bOMgkcCCVK1XZgPlJ05PY8QOfJ1Xf9+Igj
         fCAxvPSaPBwrJ4iPKgWJx4hHBM8gBuKqTNOCXGMjqqsU+oEwsZ6kCWvZdSOWoc+ikIGi
         O+gJL206LodY9LUXOcLBklbjVmDvmQg2kjdpmyKjw/3En/rVqsBNL8dw4wQoiNiqM2SD
         JJgUjf41Aq96S0Nb3Kpni5RPc47lBoYyBQyoDhMyS0Ozu7bsdEL3IsDzz0M+62ifQvLZ
         mneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052418; x=1713657218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxLyv+SwfqRuzhpybYcNieZpSAW5T3fyoOSQd/1g9FY=;
        b=ohv0iomlqsLF+e4wtfK1tJBmVC1GlfEINL+cOP45NPLynUyFBinVqGCeAO5qbWLtVW
         YFvT7CT+R3MPfr0Cb7uS5uHqP1+042N/27Qk+NhpHuOz6Ahi67Dwtc+3sGUhbBW3+JqA
         6AOK0+YlBPpF2I+NcxYAxmxY1Zva/EfCHho9nK8gov/rCPhwho7EpEI5ouU56eOvr3Xh
         ZXI2bf6LCLxzikiyU1eyYqhvappY3NFans6H5FPGYvL0TF68fQN9h0R7tBGA6wHjOYfK
         8M9r1ZmIf573GRPdcGnsCJOPo42O+UlaV3JDuvPgwJuzgsS/LtcMpcE8+qXHU8ZFgVdn
         IdWQ==
X-Gm-Message-State: AOJu0YwGXc1VJdPQztoWbtAxR2kR23mbbaNaAHuXpptqPljMjKdsjlxV
	qMgAf1atI0xgaK1GqSOmkff3+rBqZ4hSilqrLH6233uq4TKq6a2fDZ+VJXGFP03qXXfLOtj6++N
	N
X-Google-Smtp-Source: AGHT+IEaDwhcWCh6Ony6lPWdiCT2A9M2xkhBN3k8ppjpp0B0xxKsP9IZRSuoIyizUPL4JXhUmhPVvA==
X-Received: by 2002:a37:e207:0:b0:78d:6c33:445f with SMTP id g7-20020a37e207000000b0078d6c33445fmr7831036qki.77.1713052418149;
        Sat, 13 Apr 2024 16:53:38 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id az11-20020a05620a170b00b0078ec787147asm3566467qkb.3.2024.04.13.16.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 04/19] btrfs: move ref_root into btrfs_ref
Date: Sat, 13 Apr 2024 19:53:14 -0400
Message-ID: <c744c3adf986c3f2907492c33e3cfb88fb4d3aef.1713052088.git.josef@toxicpanda.com>
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

We have this in both btrfs_tree_ref and btrfs_data_ref, which is just
wasting space and making the code more complicated.  Move this into
btrfs_ref proper and update all the call sites to do the assignment in
btrfs_ref.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 29 +++++++++++++----------------
 fs/btrfs/delayed-ref.h | 22 +++++++++-------------
 fs/btrfs/extent-tree.c | 38 ++++++++++++++++----------------------
 fs/btrfs/file.c        | 30 ++++++++++++++----------------
 fs/btrfs/inode-item.c  |  6 +++---
 fs/btrfs/ref-verify.c  |  4 ++--
 fs/btrfs/relocation.c  | 26 +++++++++++++-------------
 fs/btrfs/tree-log.c    |  6 +++---
 8 files changed, 73 insertions(+), 88 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 1d0795aeba12..c6a1b6938654 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1007,17 +1007,16 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&ref->add_list);
 }
 
-void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
-			 u64 mod_root, bool skip_qgroup)
+void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
+			 bool skip_qgroup)
 {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
-	generic_ref->real_root = mod_root ?: root;
+	generic_ref->real_root = mod_root ?: generic_ref->ref_root;
 #endif
 	generic_ref->tree_ref.level = level;
-	generic_ref->tree_ref.ref_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
-	if (skip_qgroup || !(is_fstree(root) &&
+	if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
 			     (!mod_root || is_fstree(mod_root))))
 		generic_ref->skip_qgroup = true;
 	else
@@ -1025,18 +1024,17 @@ void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
 
 }
 
-void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u64 ino,
-			 u64 offset, u64 mod_root, bool skip_qgroup)
+void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
+			 u64 mod_root, bool skip_qgroup)
 {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	/* If @real_root not set, use @root as fallback */
-	generic_ref->real_root = mod_root ?: ref_root;
+	generic_ref->real_root = mod_root ?: generic_ref->ref_root;
 #endif
-	generic_ref->data_ref.ref_root = ref_root;
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
-	if (skip_qgroup || !(is_fstree(ref_root) &&
+	if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
 			     (!mod_root || is_fstree(mod_root))))
 		generic_ref->skip_qgroup = true;
 	else
@@ -1068,7 +1066,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 parent = generic_ref->parent;
 	u8 ref_type;
 
-	is_system = (generic_ref->tree_ref.ref_root == BTRFS_CHUNK_TREE_OBJECTID);
+	is_system = (generic_ref->ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
@@ -1098,14 +1096,13 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		ref_type = BTRFS_TREE_BLOCK_REF_KEY;
 
 	init_delayed_ref_common(fs_info, node, bytenr, num_bytes,
-				generic_ref->tree_ref.ref_root, action,
-				ref_type);
-	ref->root = generic_ref->tree_ref.ref_root;
+				generic_ref->ref_root, action, ref_type);
+	ref->root = generic_ref->ref_root;
 	ref->parent = parent;
 	ref->level = level;
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
-			      generic_ref->tree_ref.ref_root, 0, action,
+			      generic_ref->ref_root, 0, action,
 			      false, is_system, generic_ref->owning_root);
 	head_ref->extent_op = extent_op;
 
@@ -1159,7 +1156,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u64 ref_root = generic_ref->data_ref.ref_root;
+	u64 ref_root = generic_ref->ref_root;
 	u64 owner = generic_ref->data_ref.ino;
 	u64 offset = generic_ref->data_ref.offset;
 	u8 ref_type;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b0b2d0e93996..bf2916906bb8 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -220,9 +220,6 @@ enum btrfs_ref_type {
 struct btrfs_data_ref {
 	/* For EXTENT_DATA_REF */
 
-	/* Root which owns this data reference. */
-	u64 ref_root;
-
 	/* Inode which refers to this data extent */
 	u64 ino;
 
@@ -243,13 +240,6 @@ struct btrfs_tree_ref {
 	 */
 	int level;
 
-	/*
-	 * Root which owns this tree block reference.
-	 *
-	 * For TREE_BLOCK_REF (skinny metadata, either inline or keyed)
-	 */
-	u64 ref_root;
-
 	/* For non-skinny metadata, no special member needed */
 };
 
@@ -273,6 +263,12 @@ struct btrfs_ref {
 	u64 len;
 	u64 owning_root;
 
+	/*
+	 * The root that owns the reference for this reference, this will be set
+	 * or ->parent will be set, depending on what type of reference this is.
+	 */
+	u64 ref_root;
+
 	/* Bytenr of the parent tree block */
 	u64 parent;
 	union {
@@ -320,10 +316,10 @@ static inline u64 btrfs_calc_delayed_ref_csum_bytes(const struct btrfs_fs_info *
 	return btrfs_calc_metadata_size(fs_info, num_csum_items);
 }
 
-void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
+void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
+			 bool skip_qgroup);
+void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
 			 u64 mod_root, bool skip_qgroup);
-void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u64 ino,
-			 u64 offset, u64 mod_root, bool skip_qgroup);
 
 static inline struct btrfs_delayed_extent_op *
 btrfs_alloc_delayed_extent_op(void)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7d38f1c15a25..275e3141dc1e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1439,7 +1439,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
 	       generic_ref->action);
 	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
-	       generic_ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID);
+	       generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID);
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
 		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
@@ -2526,6 +2526,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 		struct btrfs_ref ref = {
 			.action = action,
 			.parent = parent,
+			.ref_root = ref_root,
 		};
 
 		if (level == 0) {
@@ -2545,9 +2546,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			ref.owning_root = ref_root;
 
 			key.offset -= btrfs_file_extent_offset(buf, fi);
-			btrfs_init_data_ref(&ref, ref_root, key.objectid,
-					    key.offset, root->root_key.objectid,
-					    for_reloc);
+			btrfs_init_data_ref(&ref, key.objectid, key.offset,
+					    root->root_key.objectid, for_reloc);
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &ref);
 			else
@@ -2559,7 +2559,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			ref.bytenr = btrfs_node_blockptr(buf, i);
 			ref.len = fs_info->nodesize;
 
-			btrfs_init_tree_ref(&ref, level - 1, ref_root,
+			btrfs_init_tree_ref(&ref, level - 1,
 					    root->root_key.objectid, for_reloc);
 			if (inc)
 				ret = btrfs_inc_extent_ref(trans, &ref);
@@ -3469,6 +3469,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			.len = buf->len,
 			.parent = parent,
 			.owning_root = btrfs_header_owner(buf),
+			.ref_root = root_id,
 		};
 
 		/*
@@ -3479,8 +3480,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		 */
 		ASSERT(btrfs_header_bytenr(buf) != 0);
 
-		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
-				    root_id, 0, false);
+		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf), 0, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
 		BUG_ON(ret); /* -ENOMEM */
@@ -3559,10 +3559,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	 * tree log blocks never actually go into the extent allocation
 	 * tree, just update pinning info and exit early.
 	 */
-	if ((ref->type == BTRFS_REF_METADATA &&
-	     ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID) ||
-	    (ref->type == BTRFS_REF_DATA &&
-	     ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)) {
+	if (ref->ref_root == BTRFS_TREE_LOG_OBJECTID) {
 		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
 		ret = 0;
 	} else if (ref->type == BTRFS_REF_METADATA) {
@@ -3571,10 +3568,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 		ret = btrfs_add_delayed_data_ref(trans, ref, 0);
 	}
 
-	if (!((ref->type == BTRFS_REF_METADATA &&
-	       ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID) ||
-	      (ref->type == BTRFS_REF_DATA &&
-	       ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)))
+	if (ref->ref_root != BTRFS_TREE_LOG_OBJECTID)
 		btrfs_ref_tree_mod(fs_info, ref);
 
 	return ret;
@@ -4975,16 +4969,15 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 		.bytenr = ins->objectid,
 		.len = ins->offset,
 		.owning_root = root->root_key.objectid,
+		.ref_root = root->root_key.objectid,
 	};
-	u64 root_objectid = root->root_key.objectid;
 
-	ASSERT(root_objectid != BTRFS_TREE_LOG_OBJECTID);
+	ASSERT(generic_ref.ref_root != BTRFS_TREE_LOG_OBJECTID);
 
 	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
 		generic_ref.owning_root = root->relocation_src_root;
 
-	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
-			    offset, 0, false);
+	btrfs_init_data_ref(&generic_ref, owner, offset, 0, false);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
 
 	return btrfs_add_delayed_data_ref(trans, &generic_ref, ram_bytes);
@@ -5219,6 +5212,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 			.len = ins.offset,
 			.parent = parent,
 			.owning_root = owning_root,
+			.ref_root = root_objectid,
 		};
 		extent_op = btrfs_alloc_delayed_extent_op();
 		if (!extent_op) {
@@ -5234,7 +5228,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->update_flags = true;
 		extent_op->level = level;
 
-		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
+		btrfs_init_tree_ref(&generic_ref, level,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, extent_op);
@@ -5602,6 +5596,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			.bytenr = bytenr,
 			.len = fs_info->nodesize,
 			.owning_root = owner_root,
+			.ref_root = root->root_key.objectid,
 		};
 		if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
 			ref.parent = path->nodes[level]->start;
@@ -5659,8 +5654,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->drop_level = level;
 		find_next_key(path, level, &wc->drop_progress);
 
-		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
-				    0, false);
+		btrfs_init_tree_ref(&ref, level - 1, 0, false);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret)
 			goto out_unlock;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 013bcd336215..416fa1f48fe5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -378,12 +378,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 					.len = num_bytes,
 					.parent = 0,
 					.owning_root = root->root_key.objectid,
+					.ref_root = root->root_key.objectid,
 				};
-				btrfs_init_data_ref(&ref,
-						root->root_key.objectid,
-						new_key.objectid,
-						args->start - extent_offset,
-						0, false);
+				btrfs_init_data_ref(&ref, new_key.objectid,
+						    args->start - extent_offset,
+						    0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
@@ -472,12 +471,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 					.len = num_bytes,
 					.parent = 0,
 					.owning_root = root->root_key.objectid,
+					.ref_root = root->root_key.objectid,
 				};
-				btrfs_init_data_ref(&ref,
-						root->root_key.objectid,
-						key.objectid,
-						key.offset - extent_offset, 0,
-						false);
+				btrfs_init_data_ref(&ref, key.objectid,
+						    key.offset - extent_offset,
+						    0, false);
 				ret = btrfs_free_extent(trans, &ref);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
@@ -758,8 +756,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		ref.len = num_bytes;
 		ref.parent = 0;
 		ref.owning_root = root->root_key.objectid;
-		btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
-				    orig_offset, 0, false);
+		ref.ref_root = root->root_key.objectid;
+		btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -788,8 +786,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	ref.len = num_bytes;
 	ref.parent = 0;
 	ref.owning_root = root->root_key.objectid;
-	btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offset,
-			    0, false);
+	ref.ref_root = root->root_key.objectid;
+	btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
 	if (extent_mergeable(leaf, path->slots[0] + 1,
 			     ino, bytenr, orig_offset,
 			     &other_start, &other_end)) {
@@ -2330,12 +2328,12 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 			.bytenr = extent_info->disk_offset,
 			.len = extent_info->disk_len,
 			.owning_root = root->root_key.objectid,
+			.ref_root = root->root_key.objectid,
 		};
 		u64 ref_offset;
 
 		ref_offset = extent_info->file_offset - extent_info->data_offset;
-		btrfs_init_data_ref(&ref, root->root_key.objectid,
-				    btrfs_ino(inode), ref_offset, 0, false);
+		btrfs_init_data_ref(&ref, btrfs_ino(inode), ref_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 	}
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index d61bb65859a5..e24605df35bb 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -675,13 +675,13 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				.bytenr = extent_start,
 				.len = extent_num_bytes,
 				.owning_root = root->root_key.objectid,
+				.ref_root = btrfs_header_owner(leaf),
 			};
 
 			bytes_deleted += extent_num_bytes;
 
-			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-					control->ino, extent_offset,
-					root->root_key.objectid, false);
+			btrfs_init_data_ref(&ref, control->ino, extent_offset,
+					    root->root_key.objectid, false);
 			ret = btrfs_free_extent(trans, &ref);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 8c4fc98ca9ce..1108be7a050c 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -684,10 +684,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 
 	if (generic_ref->type == BTRFS_REF_METADATA) {
 		if (!parent)
-			ref_root = generic_ref->tree_ref.ref_root;
+			ref_root = generic_ref->ref_root;
 		owner = generic_ref->tree_ref.level;
 	} else if (!parent) {
-		ref_root = generic_ref->data_ref.ref_root;
+		ref_root = generic_ref->ref_root;
 		owner = generic_ref->data_ref.ino;
 		offset = generic_ref->data_ref.offset;
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9a739e33a5fe..9e460b79f8b2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1165,8 +1165,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		ref.len = num_bytes;
 		ref.parent = parent;
 		ref.owning_root = root->root_key.objectid;
-		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-				    key.objectid, key.offset,
+		ref.ref_root = btrfs_header_owner(leaf);
+		btrfs_init_data_ref(&ref, key.objectid, key.offset,
 				    root->root_key.objectid, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
@@ -1179,8 +1179,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		ref.len = num_bytes;
 		ref.parent = parent;
 		ref.owning_root = root->root_key.objectid;
-		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-				    key.objectid, key.offset,
+		ref.ref_root = btrfs_header_owner(leaf);
+		btrfs_init_data_ref(&ref, key.objectid, key.offset,
 				    root->root_key.objectid, false);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
@@ -1395,8 +1395,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.len = blocksize;
 		ref.parent = path->nodes[level]->start;
 		ref.owning_root = src->root_key.objectid;
-		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
-				    0, true);
+		ref.ref_root = src->root_key.objectid;
+		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1408,8 +1408,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.len = blocksize;
 		ref.parent = 0;
 		ref.owning_root = dest->root_key.objectid;
-		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid, 0,
-				    true);
+		ref.ref_root = dest->root_key.objectid;
+		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1422,8 +1422,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.len = blocksize;
 		ref.parent = path->nodes[level]->start;
 		ref.owning_root = 0;
-		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
-				    0, true);
+		ref.ref_root = src->root_key.objectid;
+		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -1436,8 +1436,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.len = blocksize;
 		ref.parent = 0;
 		ref.owning_root = 0;
-		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
-				    0, true);
+		ref.ref_root = dest->root_key.objectid;
+		btrfs_init_tree_ref(&ref, level - 1, 0, true);
 		ret = btrfs_free_extent(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -2540,6 +2540,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 				.len = blocksize,
 				.parent = upper->eb->start,
 				.owning_root = btrfs_header_owner(upper->eb),
+				.ref_root = btrfs_header_owner(upper->eb),
 			};
 
 			btrfs_set_node_blockptr(upper->eb, slot,
@@ -2549,7 +2550,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_mark_buffer_dirty(trans, upper->eb);
 
 			btrfs_init_tree_ref(&ref, node->level,
-					    btrfs_header_owner(upper->eb),
 					    root->root_key.objectid, false);
 			ret = btrfs_inc_extent_ref(trans, &ref);
 			if (!ret)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 27084c7519f9..da319ffda4ee 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -766,10 +766,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 					.bytenr = ins.objectid,
 					.len = ins.offset,
 					.owning_root = root->root_key.objectid,
+					.ref_root = root->root_key.objectid,
 				};
-				btrfs_init_data_ref(&ref,
-						root->root_key.objectid,
-						key->objectid, offset, 0, false);
+				btrfs_init_data_ref(&ref, key->objectid, offset,
+						    0, false);
 				ret = btrfs_inc_extent_ref(trans, &ref);
 				if (ret)
 					goto out;
-- 
2.43.0



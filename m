Return-Path: <linux-btrfs+bounces-4216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E98A3FA6
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C794D1C21193
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85058ADD;
	Sat, 13 Apr 2024 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kvrq8Qvu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BD58AA6
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052420; cv=none; b=UIoTnj7PomySK4R0qIoY8kHVdWmYtWJRmUL8uwgNFeTWaRrdbeirYCYIB3sbf2n2gbEPlYQDk5/nNWW0FKsMz0BA4/P5CGfcC9NA5RRbS+FKtxcGucMEqjTaagteWaAGpZEqoDb6qJ8nWZk+Iesg6bVyjRNsHJ2H6aStd3rKfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052420; c=relaxed/simple;
	bh=PUnTWItf1h1HJg5UGY9Lu/KSQjUlTZp2maSR/qYMwpY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfDtYZgXSfszWXyvRjOTWNeeX3vQdHqkiAdx1pLTIoygWvOKWIlwap2P+UvrCiKa90uz6CWP/Xu9dPzyJmjsBApb8fxmp11mhIzJq/bFG9b3ln/YD8pZhxYmRn1uhAtX59SqZgZhgs0QAPpfv7wX++IvD+CNlocyNG3rnIkmGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kvrq8Qvu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b0f08a877so11502726d6.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052417; x=1713657217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jov1JEWZuQx21LKzVuB+znbCbkxu9MUIoET9we9ACdo=;
        b=kvrq8QvuR/KGXzPfBadYUumm5DcPKyS3iqbYnTDTZGpN0OG8hksWy8O5LTqIDFEusR
         JFSWD+IlwJRoANiAUOyeKRr/OTSqzO+EH2WVZNs3/kTy/rRNdaOBhQIKD+L0FGnaKTrT
         +5haPe4LslvbPnyOwW+QWooV4O1n0C7+Bdzbgu2ZoT56LHa0BTV3Pywl9f7M3g01fDQq
         uiPiaT4PawRExR5lkS7BWsFmx1CBj/mR4HlmBvhFC2Dt8SjA1ZFSs72Ay1ZDMuDaEcBt
         /YxmUi7bcrbMUg3kXE2NEGZgJyOQtclQAf8ThDuJkvEIzpsVn79VXeaNmXE8JgNBG+1y
         sHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052417; x=1713657217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jov1JEWZuQx21LKzVuB+znbCbkxu9MUIoET9we9ACdo=;
        b=jLNHJv1zr7+UQRKAv/aMTnqvXalhQMf3AwQTKZvDXdvFulr5wjOr53DnutBidOh6da
         k4ZiMjvtyVHJwNeoqSc4KUGg+yWZ7E98TQ0xKZQfjMsv5yb8r5m6T91QLK8zPu7Ucj2y
         A1oBtFp2n3WWQFDzdTN2+kUi7lxE9MKvLinjIKOrJMsZLjGJLBFN698c1kNEz3TPvZ+o
         IKuvEhijmi8jDi64zojClwThtrC+f3a5KOW6oq0pogzCvF+9VZwqN10QGLZv0NpMQbXz
         kmhelhoGaewfF1fbhsBg2T51GY2f2DcAVPr95UfikH8S4Eg2haNlTCrZnmUgQZoUzD6S
         nRDA==
X-Gm-Message-State: AOJu0YwkVgP41R5YhJJf3dMhIwLB/Bx16FkRRbrPGVwDiFZ7+6GrJtRV
	bt5rCA0bRuoEksUXoovJ2b6hYfZhrWAXocbu5sye7QM3mcg0P/CPC8kB3mhCAlRpp3jxyA0iEey
	o
X-Google-Smtp-Source: AGHT+IGJncp8xerI5OgKeUFufVQ5NmLQCJEdrLXD2TTFDE0DjdmohSf937w0UlUfPR0EjSJyrPe2og==
X-Received: by 2002:a05:6214:4c11:b0:699:24a7:387b with SMTP id qh17-20020a0562144c1100b0069924a7387bmr7429495qvb.39.1713052417079;
        Sat, 13 Apr 2024 16:53:37 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x18-20020a0ceb92000000b0069b5f04ff79sm2181666qvo.111.2024.04.13.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 03/19] btrfs: do not use a function to initialize btrfs_ref
Date: Sat, 13 Apr 2024 19:53:13 -0400
Message-ID: <81b0d80d231d4acf5896522f4e98218718f669b2.1713052088.git.josef@toxicpanda.com>
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

btrfs_ref currently has ->owning_root, and ->ref_root is shared between
the tree ref and data ref, so in order to move that into btrfs_ref
proper I would need to add another root parameter to the initialization
function.  This function has too many arguments, and adding another root
will make it easy to make mistakes about which root goes where.  Drop
the generic ref init function and statically initialize the btrfs_ref in
every usage.  This makes the code easier to read because we can see what
elements we're assigning, and will make the upcoming change moving the
ref_root into the btrfs_ref more clear and less error prone than adding
a new element to the initialization function.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 10 -----
 fs/btrfs/delayed-ref.h |  2 -
 fs/btrfs/extent-tree.c | 87 ++++++++++++++++++++++++------------------
 fs/btrfs/file.c        | 49 +++++++++++++++---------
 fs/btrfs/inode-item.c  | 10 +++--
 fs/btrfs/relocation.c  | 58 +++++++++++++++++++---------
 fs/btrfs/tree-log.c    | 11 +++---
 7 files changed, 131 insertions(+), 96 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 9382f7c81c25..1d0795aeba12 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1007,16 +1007,6 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&ref->add_list);
 }
 
-void btrfs_init_generic_ref(struct btrfs_ref *generic_ref, int action, u64 bytenr,
-			    u64 len, u64 parent, u64 owning_root)
-{
-	generic_ref->action = action;
-	generic_ref->bytenr = bytenr;
-	generic_ref->len = len;
-	generic_ref->parent = parent;
-	generic_ref->owning_root = owning_root;
-}
-
 void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
 			 u64 mod_root, bool skip_qgroup)
 {
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 2de447d9aaba..b0b2d0e93996 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -320,8 +320,6 @@ static inline u64 btrfs_calc_delayed_ref_csum_bytes(const struct btrfs_fs_info *
 	return btrfs_calc_metadata_size(fs_info, num_csum_items);
 }
 
-void btrfs_init_generic_ref(struct btrfs_ref *generic_ref, int action, u64 bytenr,
-			    u64 len, u64 parent, u64 owning_root);
 void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
 			 u64 mod_root, bool skip_qgroup);
 void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u64 ino,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 42314604906a..7d38f1c15a25 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2492,14 +2492,11 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			   int full_backref, int inc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 bytenr;
-	u64 num_bytes;
 	u64 parent;
 	u64 ref_root;
 	u32 nritems;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_ref generic_ref = { 0 };
 	bool for_reloc = btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC);
 	int i;
 	int action;
@@ -2526,6 +2523,11 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 		action = BTRFS_DROP_DELAYED_REF;
 
 	for (i = 0; i < nritems; i++) {
+		struct btrfs_ref ref = {
+			.action = action,
+			.parent = parent,
+		};
+
 		if (level == 0) {
 			btrfs_item_key_to_cpu(buf, &key, i);
 			if (key.type != BTRFS_EXTENT_DATA_KEY)
@@ -2535,35 +2537,34 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 			if (btrfs_file_extent_type(buf, fi) ==
 			    BTRFS_FILE_EXTENT_INLINE)
 				continue;
-			bytenr = btrfs_file_extent_disk_bytenr(buf, fi);
-			if (bytenr == 0)
+			ref.bytenr = btrfs_file_extent_disk_bytenr(buf, fi);
+			if (ref.bytenr == 0)
 				continue;
 
-			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
+			ref.len = btrfs_file_extent_disk_num_bytes(buf, fi);
+			ref.owning_root = ref_root;
+
 			key.offset -= btrfs_file_extent_offset(buf, fi);
-			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent, ref_root);
-			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
+			btrfs_init_data_ref(&ref, ref_root, key.objectid,
 					    key.offset, root->root_key.objectid,
 					    for_reloc);
 			if (inc)
-				ret = btrfs_inc_extent_ref(trans, &generic_ref);
+				ret = btrfs_inc_extent_ref(trans, &ref);
 			else
-				ret = btrfs_free_extent(trans, &generic_ref);
+				ret = btrfs_free_extent(trans, &ref);
 			if (ret)
 				goto fail;
 		} else {
-			bytenr = btrfs_node_blockptr(buf, i);
-			num_bytes = fs_info->nodesize;
-			/* We don't know the owning_root, use 0. */
-			btrfs_init_generic_ref(&generic_ref, action, bytenr,
-					       num_bytes, parent, 0);
-			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
+			/* We don't know the owning_root, leave as 0. */
+			ref.bytenr = btrfs_node_blockptr(buf, i);
+			ref.len = fs_info->nodesize;
+
+			btrfs_init_tree_ref(&ref, level - 1, ref_root,
 					    root->root_key.objectid, for_reloc);
 			if (inc)
-				ret = btrfs_inc_extent_ref(trans, &generic_ref);
+				ret = btrfs_inc_extent_ref(trans, &ref);
 			else
-				ret = btrfs_free_extent(trans, &generic_ref);
+				ret = btrfs_free_extent(trans, &ref);
 			if (ret)
 				goto fail;
 		}
@@ -3462,7 +3463,13 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
-		struct btrfs_ref generic_ref = { 0 };
+		struct btrfs_ref generic_ref = {
+			.action = BTRFS_DROP_DELAYED_REF,
+			.bytenr = buf->start,
+			.len = buf->len,
+			.parent = parent,
+			.owning_root = btrfs_header_owner(buf),
+		};
 
 		/*
 		 * Assert that the extent buffer is not cleared due to
@@ -3472,9 +3479,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		 */
 		ASSERT(btrfs_header_bytenr(buf) != 0);
 
-		btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
-				       buf->start, buf->len, parent,
-				       btrfs_header_owner(buf));
 		btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
 				    root_id, 0, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -4966,17 +4970,19 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     u64 offset, u64 ram_bytes,
 				     struct btrfs_key *ins)
 {
-	struct btrfs_ref generic_ref = { 0 };
+	struct btrfs_ref generic_ref = {
+		.action = BTRFS_ADD_DELAYED_EXTENT,
+		.bytenr = ins->objectid,
+		.len = ins->offset,
+		.owning_root = root->root_key.objectid,
+	};
 	u64 root_objectid = root->root_key.objectid;
-	u64 owning_root = root_objectid;
 
 	ASSERT(root_objectid != BTRFS_TREE_LOG_OBJECTID);
 
 	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
-		owning_root = root->relocation_src_root;
+		generic_ref.owning_root = root->relocation_src_root;
 
-	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-			       ins->objectid, ins->offset, 0, owning_root);
 	btrfs_init_data_ref(&generic_ref, root_objectid, owner,
 			    offset, 0, false);
 	btrfs_ref_tree_mod(root->fs_info, &generic_ref);
@@ -5157,7 +5163,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_block_rsv *block_rsv;
 	struct extent_buffer *buf;
 	struct btrfs_delayed_extent_op *extent_op;
-	struct btrfs_ref generic_ref = { 0 };
 	u64 flags = 0;
 	int ret;
 	u32 blocksize = fs_info->nodesize;
@@ -5208,6 +5213,13 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	}
 
 	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
+		struct btrfs_ref generic_ref = {
+			.action = BTRFS_ADD_DELAYED_EXTENT,
+			.bytenr = ins.objectid,
+			.len = ins.offset,
+			.parent = parent,
+			.owning_root = owning_root,
+		};
 		extent_op = btrfs_alloc_delayed_extent_op();
 		if (!extent_op) {
 			ret = -ENOMEM;
@@ -5222,8 +5234,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->update_flags = true;
 		extent_op->level = level;
 
-		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-				       ins.objectid, ins.offset, parent, owning_root);
 		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
 				    root->root_key.objectid, false);
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
@@ -5468,11 +5478,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 bytenr;
 	u64 generation;
-	u64 parent;
 	u64 owner_root = 0;
 	struct btrfs_tree_parent_check check = { 0 };
 	struct btrfs_key key;
-	struct btrfs_ref ref = { 0 };
 	struct extent_buffer *next;
 	int level = wc->level;
 	int reada = 0;
@@ -5589,8 +5597,14 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	wc->refs[level - 1] = 0;
 	wc->flags[level - 1] = 0;
 	if (wc->stage == DROP_REFERENCE) {
+		struct btrfs_ref ref = {
+			.action = BTRFS_DROP_DELAYED_REF,
+			.bytenr = bytenr,
+			.len = fs_info->nodesize,
+			.owning_root = owner_root,
+		};
 		if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-			parent = path->nodes[level]->start;
+			ref.parent = path->nodes[level]->start;
 		} else {
 			ASSERT(root->root_key.objectid ==
 			       btrfs_header_owner(path->nodes[level]));
@@ -5601,7 +5615,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 				ret = -EIO;
 				goto out_unlock;
 			}
-			parent = 0;
 		}
 
 		/*
@@ -5611,7 +5624,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		 * ->restarted flag.
 		 */
 		if (wc->restarted) {
-			ret = check_ref_exists(trans, root, bytenr, parent,
+			ret = check_ref_exists(trans, root, bytenr, ref.parent,
 					       level - 1);
 			if (ret < 0)
 				goto out_unlock;
@@ -5646,8 +5659,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->drop_level = level;
 		find_next_key(path, level, &wc->drop_progress);
 
-		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       fs_info->nodesize, parent, owner_root);
 		btrfs_init_tree_ref(&ref, level - 1, root->root_key.objectid,
 				    0, false);
 		ret = btrfs_free_extent(trans, &ref);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0c23053951be..013bcd336215 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -206,7 +206,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_ref ref = { 0 };
 	struct btrfs_key key;
 	struct btrfs_key new_key;
 	u64 ino = btrfs_ino(inode);
@@ -373,10 +372,13 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			btrfs_mark_buffer_dirty(trans, leaf);
 
 			if (update_refs && disk_bytenr > 0) {
-				btrfs_init_generic_ref(&ref,
-						BTRFS_ADD_DELAYED_REF,
-						disk_bytenr, num_bytes, 0,
-						root->root_key.objectid);
+				struct btrfs_ref ref = {
+					.action = BTRFS_ADD_DELAYED_REF,
+					.bytenr = disk_bytenr,
+					.len = num_bytes,
+					.parent = 0,
+					.owning_root = root->root_key.objectid,
+				};
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						new_key.objectid,
@@ -464,10 +466,13 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				extent_end = ALIGN(extent_end,
 						   fs_info->sectorsize);
 			} else if (update_refs && disk_bytenr > 0) {
-				btrfs_init_generic_ref(&ref,
-						BTRFS_DROP_DELAYED_REF,
-						disk_bytenr, num_bytes, 0,
-						root->root_key.objectid);
+				struct btrfs_ref ref = {
+					.action = BTRFS_DROP_DELAYED_REF,
+					.bytenr = disk_bytenr,
+					.len = num_bytes,
+					.parent = 0,
+					.owning_root = root->root_key.objectid,
+				};
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						key.objectid,
@@ -748,8 +753,11 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 						extent_end - split);
 		btrfs_mark_buffer_dirty(trans, leaf);
 
-		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, bytenr,
-				       num_bytes, 0, root->root_key.objectid);
+		ref.action = BTRFS_ADD_DELAYED_REF;
+		ref.bytenr = bytenr;
+		ref.len = num_bytes;
+		ref.parent = 0;
+		ref.owning_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
 				    orig_offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -774,8 +782,12 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 
 	other_start = end;
 	other_end = 0;
-	btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-			       num_bytes, 0, root->root_key.objectid);
+
+	ref.action = BTRFS_DROP_DELAYED_REF;
+	ref.bytenr = bytenr;
+	ref.len = num_bytes;
+	ref.parent = 0;
+	ref.owning_root = root->root_key.objectid;
 	btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offset,
 			    0, false);
 	if (extent_mergeable(leaf, path->slots[0] + 1,
@@ -2258,7 +2270,6 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int slot;
-	struct btrfs_ref ref = { 0 };
 	int ret;
 
 	if (replace_len == 0)
@@ -2314,12 +2325,14 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 						       extent_info->qgroup_reserved,
 						       &key);
 	} else {
+		struct btrfs_ref ref = {
+			.action = BTRFS_ADD_DELAYED_REF,
+			.bytenr = extent_info->disk_offset,
+			.len = extent_info->disk_len,
+			.owning_root = root->root_key.objectid,
+		};
 		u64 ref_offset;
 
-		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
-				       extent_info->disk_offset,
-				       extent_info->disk_len, 0,
-				       root->root_key.objectid);
 		ref_offset = extent_info->file_offset - extent_info->data_offset;
 		btrfs_init_data_ref(&ref, root->root_key.objectid,
 				    btrfs_ino(inode), ref_offset, 0, false);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 9c1394c0a6d7..d61bb65859a5 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -670,13 +670,15 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		}
 
 		if (del_item && extent_start != 0 && !control->skip_ref_updates) {
-			struct btrfs_ref ref = { 0 };
+			struct btrfs_ref ref = {
+				.action = BTRFS_DROP_DELAYED_REF,
+				.bytenr = extent_start,
+				.len = extent_num_bytes,
+				.owning_root = root->root_key.objectid,
+			};
 
 			bytes_deleted += extent_num_bytes;
 
-			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
-					extent_start, extent_num_bytes, 0,
-					root->root_key.objectid);
 			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 					control->ino, extent_offset,
 					root->root_key.objectid, false);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5c9ef6717f84..9a739e33a5fe 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1160,8 +1160,11 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		dirty = 1;
 
 		key.offset -= btrfs_file_extent_offset(leaf, fi);
-		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
-				       num_bytes, parent, root->root_key.objectid);
+		ref.action = BTRFS_ADD_DELAYED_REF;
+		ref.bytenr = new_bytenr;
+		ref.len = num_bytes;
+		ref.parent = parent;
+		ref.owning_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 				    key.objectid, key.offset,
 				    root->root_key.objectid, false);
@@ -1171,8 +1174,11 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
-				       num_bytes, parent, root->root_key.objectid);
+		ref.action = BTRFS_DROP_DELAYED_REF;
+		ref.bytenr = bytenr;
+		ref.len = num_bytes;
+		ref.parent = parent;
+		ref.owning_root = root->root_key.objectid;
 		btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
 				    key.objectid, key.offset,
 				    root->root_key.objectid, false);
@@ -1384,9 +1390,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 					      path->slots[level], old_ptr_gen);
 		btrfs_mark_buffer_dirty(trans, path->nodes[level]);
 
-		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_bytenr,
-				       blocksize, path->nodes[level]->start,
-				       src->root_key.objectid);
+		ref.action = BTRFS_ADD_DELAYED_REF;
+		ref.bytenr = old_bytenr;
+		ref.len = blocksize;
+		ref.parent = path->nodes[level]->start;
+		ref.owning_root = src->root_key.objectid;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -1394,8 +1402,12 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
-		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
-				       blocksize, 0, dest->root_key.objectid);
+
+		ref.action = BTRFS_ADD_DELAYED_REF;
+		ref.bytenr = new_bytenr;
+		ref.len = blocksize;
+		ref.parent = 0;
+		ref.owning_root = dest->root_key.objectid;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid, 0,
 				    true);
 		ret = btrfs_inc_extent_ref(trans, &ref);
@@ -1405,8 +1417,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		}
 
 		/* We don't know the real owning_root, use 0. */
-		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
-				       blocksize, path->nodes[level]->start, 0);
+		ref.action = BTRFS_DROP_DELAYED_REF;
+		ref.bytenr = new_bytenr;
+		ref.len = blocksize;
+		ref.parent = path->nodes[level]->start;
+		ref.owning_root = 0;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid,
 				    0, true);
 		ret = btrfs_free_extent(trans, &ref);
@@ -1416,8 +1431,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		}
 
 		/* We don't know the real owning_root, use 0. */
-		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
-				       blocksize, 0, 0);
+		ref.action = BTRFS_DROP_DELAYED_REF;
+		ref.bytenr = old_bytenr;
+		ref.len = blocksize;
+		ref.parent = 0;
+		ref.owning_root = 0;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid,
 				    0, true);
 		ret = btrfs_free_extent(trans, &ref);
@@ -2429,8 +2447,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	path->lowest_level = node->level + 1;
 	rc->backref_cache.path[node->level] = node;
 	list_for_each_entry(edge, &node->upper, list[LOWER]) {
-		struct btrfs_ref ref = { 0 };
-
 		cond_resched();
 
 		upper = edge->node[UPPER];
@@ -2518,16 +2534,20 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			 */
 			ASSERT(node->eb == eb);
 		} else {
+			struct btrfs_ref ref = {
+				.action = BTRFS_ADD_DELAYED_REF,
+				.bytenr = node->eb->start,
+				.len = blocksize,
+				.parent = upper->eb->start,
+				.owning_root = btrfs_header_owner(upper->eb),
+			};
+
 			btrfs_set_node_blockptr(upper->eb, slot,
 						node->eb->start);
 			btrfs_set_node_ptr_generation(upper->eb, slot,
 						      trans->transid);
 			btrfs_mark_buffer_dirty(trans, upper->eb);
 
-			btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
-					       node->eb->start, blocksize,
-					       upper->eb->start,
-					       btrfs_header_owner(upper->eb));
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb),
 					    root->root_key.objectid, false);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d9777649e170..27084c7519f9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -748,7 +748,6 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 
 		if (ins.objectid > 0) {
-			struct btrfs_ref ref = { 0 };
 			u64 csum_start;
 			u64 csum_end;
 			LIST_HEAD(ordered_sums);
@@ -762,10 +761,12 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			if (ret < 0) {
 				goto out;
 			} else if (ret == 0) {
-				btrfs_init_generic_ref(&ref,
-						BTRFS_ADD_DELAYED_REF,
-						ins.objectid, ins.offset, 0,
-						root->root_key.objectid);
+				struct btrfs_ref ref = {
+					.action = BTRFS_ADD_DELAYED_REF,
+					.bytenr = ins.objectid,
+					.len = ins.offset,
+					.owning_root = root->root_key.objectid,
+				};
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						key->objectid, offset, 0, false);
-- 
2.43.0



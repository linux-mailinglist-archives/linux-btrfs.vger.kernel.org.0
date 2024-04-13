Return-Path: <linux-btrfs+bounces-4230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C98A3FB4
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D991F21AB9
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B995BACB;
	Sat, 13 Apr 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Fobal9Ow"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702A5B209
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052433; cv=none; b=ZeDturWOchmdqzXMC7/1mDLCXSY4Wwge2LwLWpljOBBDk2pMlW9NPG15InIE+uGg8IloAi/pBfVUVH3hhqN8eHgeY7/iMccG+WofNadnqsnwAjRvcvFYQjzTEAnsxiAiB8Kn9iOzl6qbZlubsjQUb3ef3ron7HvgImfvmqVS0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052433; c=relaxed/simple;
	bh=ILGC7F/URfIBGG3g4tutxIgOQbT1OwNUr21vkNncrUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyLOaU/Vz1xR0UgMG7vXBApMjrIFZpa5TleVmO/iUqxklJNisTuh2tSzMIFoOkvNYCfzqtcJXDN9cL4C49+o45hJwY2hpQD+0TdJJA+ShBMzdnYXTfZLr3NKEwpGZUfDD9hrBGjB5t6KgjBpDISErkaGBGhpXYSEd/11rabzLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Fobal9Ow; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78edc49861aso30935385a.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052431; x=1713657231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLrsqFV6zGQusgpBYLqnjKAysNOA8iObVTBM6YLQuiw=;
        b=Fobal9Ow0z5A5EAzRZdskHCKognVbJs+9b1Lx40wYFEQvvJM0y+HrQQy3zY44r32gB
         OG35rGaYRf2fYEveG0iy4yQ4gvfpStVAixfxSF77ikvLzHIaRSB+MamHCfi9h8DgZfCp
         Q9hAma8Go5COwVH4NlfL/arY7coMq1RiwNyIspfFM+dq6u0GVOlbTvKuCzGY8FZR0Gyo
         GWo8OU7Xqa5BYn0kdIK5Djt3chPEMgB2s2EQfc+asoY/cSWdn1AP3YM0+cjEB++3gtg6
         VUtrKbv4XNBVse6kSdwjj1OQfI82PaFoLEOZufejAGAGlPXDmwDja94SLEAYKbvR14IW
         wRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052431; x=1713657231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLrsqFV6zGQusgpBYLqnjKAysNOA8iObVTBM6YLQuiw=;
        b=k35ppdoIxP5jt/14J63MM3EpxGMl0EAVr6vl5Sa+Bpt6N4A5/FwpmEcnyNZge70WsB
         EwRFbd4i62nAXQlnsifqAIMTNdJa6TCnjxg3Hh5YWQvNoP2qvE+USNAoKztxHJh3sYBl
         gfaK/TGJmH5YT9xUI8fOzjOjOODnXYYvgL5izNb6mHZ7DHX40fd+HjTRdISPz5TY9HAJ
         YLBBrm64lhMQ4Ozsg8eCx3FqbrnOstjA+rwtzIdulY7wRF80QL9K0kOvPIYLZgqGljRv
         VK0AMgHrDPoD/jAJCjAv0FjriyGbC24tiNCyXbtALjsBmjiLHhu8W9GLNOQ0pSioZuLk
         9Cow==
X-Gm-Message-State: AOJu0YxJ3yX2Ve3CFWmMUbjbo/K3kXROSQVWmRW2vdp/8KRqzaZf1awB
	orNRqTOW76065yB9gcwC034Um1QgcKgL84YRUQUoQM7driLfTm6buPm07ycC5cWCCICFcr7otj6
	i
X-Google-Smtp-Source: AGHT+IGOa8K+YnTGrZKYIWKT37OTxMaml15pSPJ/j5QTfjH0nnQQGWt0iNPz56jD03g6p10q0Hm82w==
X-Received: by 2002:ad4:514a:0:b0:699:129c:ba5f with SMTP id g10-20020ad4514a000000b00699129cba5fmr6814219qvq.38.1713052431270;
        Sat, 13 Apr 2024 16:53:51 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b0069b57111a98sm2888002qvv.79.2024.04.13.16.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 17/19] btrfs: stop referencing btrfs_delayed_tree_ref directly
Date: Sat, 13 Apr 2024 19:53:27 -0400
Message-ID: <ad30ad3095fe61d755fc6233e5334f953a68f495.1713052088.git.josef@toxicpanda.com>
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

We only ever need to use this to get the level of the tree block ref, so
use the btrfs_delayed_ref_owner() helper, which returns the level for
the given reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c           | 21 +++++++++++----------
 fs/btrfs/extent-tree.c       | 10 +++++-----
 include/trace/events/btrfs.h |  1 -
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index eb9f2f078a26..574fb1d515b3 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -919,28 +919,29 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 		switch (node->type) {
 		case BTRFS_TREE_BLOCK_REF_KEY: {
 			/* NORMAL INDIRECT METADATA backref */
-			struct btrfs_delayed_tree_ref *ref;
 			struct btrfs_key *key_ptr = NULL;
+			/* The owner of a tree block ref is the level. */
+			int level = btrfs_delayed_ref_owner(node);
 
 			if (head->extent_op && head->extent_op->update_key) {
 				btrfs_disk_key_to_cpu(&key, &head->extent_op->key);
 				key_ptr = &key;
 			}
 
-			ref = btrfs_delayed_node_to_tree_ref(node);
 			ret = add_indirect_ref(fs_info, preftrees, node->ref_root,
-					       key_ptr, ref->level + 1,
-					       node->bytenr, count, sc,
-					       GFP_ATOMIC);
+					       key_ptr, level + 1, node->bytenr,
+					       count, sc, GFP_ATOMIC);
 			break;
 		}
 		case BTRFS_SHARED_BLOCK_REF_KEY: {
-			/* SHARED DIRECT METADATA backref */
-			struct btrfs_delayed_tree_ref *ref;
+			/*
+			 * SHARED DIRECT METADATA backref
+			 *
+			 * The owner of a tree block ref is the level.
+			 */
+			int level = btrfs_delayed_ref_owner(node);
 
-			ref = btrfs_delayed_node_to_tree_ref(node);
-
-			ret = add_direct_ref(fs_info, preftrees, ref->level + 1,
+			ret = add_direct_ref(fs_info, preftrees, level + 1,
 					     node->parent, node->bytenr, count,
 					     sc, GFP_ATOMIC);
 			break;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 839c64d5a12d..4fb3c466bbfc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4865,16 +4865,16 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
-	struct btrfs_delayed_tree_ref *ref;
 	u32 size = sizeof(*extent_item) + sizeof(*iref);
 	u64 flags = extent_op->flags_to_set;
+	/* The owner of a tree block is the level. */
+	int level = btrfs_delayed_ref_owner(node);
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
-	ref = btrfs_delayed_node_to_tree_ref(node);
-
 	extent_key.objectid = node->bytenr;
 	if (skinny_metadata) {
-		extent_key.offset = ref->level;
+		/* The owner of a tree block is the level. */
+		extent_key.offset = level;
 		extent_key.type = BTRFS_METADATA_ITEM_KEY;
 	} else {
 		extent_key.offset = node->num_bytes;
@@ -4907,7 +4907,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	} else {
 		block_info = (struct btrfs_tree_block_info *)(extent_item + 1);
 		btrfs_set_tree_block_key(leaf, block_info, &extent_op->key);
-		btrfs_set_tree_block_level(leaf, block_info, ref->level);
+		btrfs_set_tree_block_level(leaf, block_info, level);
 		iref = (struct btrfs_extent_inline_ref *)(block_info + 1);
 	}
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 89fa96fd95b4..8f2497603cb5 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -16,7 +16,6 @@ struct extent_map;
 struct btrfs_file_extent_item;
 struct btrfs_ordered_extent;
 struct btrfs_delayed_ref_node;
-struct btrfs_delayed_tree_ref;
 struct btrfs_delayed_ref_head;
 struct btrfs_block_group;
 struct btrfs_free_cluster;
-- 
2.43.0



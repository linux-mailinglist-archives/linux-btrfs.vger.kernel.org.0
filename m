Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212B75BAD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGTWzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGTWzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA12D4B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CBAD05C01BA;
        Thu, 20 Jul 2023 18:54:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893682; x=
        1689980082; bh=c/1h5x7nXgXAcZs5rb1gjOxbOML5UPVOtoHdeWbqhQg=; b=P
        RG6wLednCqr59xU5TB0v6tPleR4W6C5lgsuofyl/U0sJNusr2NwoNbwkAhsqDiP4
        jondaNMSxUV05VL/oOfnTiLTt9SaNAFQR2szsqfFHZAyBf6rRaLu0ZDHPzSQbpWQ
        yrVAX6UhnVsW4vlAQC2KjeBh5KzijZ8NCYGU8JSpeTMxF4OopK2d7i1PuhFotzhc
        a53Fk4f8C8t5pecVdLx5Z1cs3M20M9hb9DNnjUgdEykUc+5q7ZRZxtq4kRyjGrVY
        LNlZiSUxBTfdMPkFudcRmMOzyvsbWS1NFV/zsVbZk49pqmmsAfXWe1SIZaU7aFpY
        FAeTKIjKgA/K6F5i+38Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893682; x=1689980082; bh=c
        /1h5x7nXgXAcZs5rb1gjOxbOML5UPVOtoHdeWbqhQg=; b=WhbS9mmSDZjyY7W8e
        sT2qhIN3Sgc88Ue4BoTofUOhxhkhOT5o7TE0DfpZLEgT6dfmu51a9/uxIsfjGM4Z
        61fcmoNCOdhcyg3Md2ZkTHg5iqeUMnbVH0w5z/oHpLdER5wAtlOdcdGKjmmBLzOf
        U9Q7CqfZ5WG4UfD57K4sB08oShZO8XR/iFdDbZOgG2WDld3LYOdb2p9nGpUYmUCF
        +0wxVE8O7672oi7h95/xBSOiyqDD9QbFu8ARb/h3cepDH6u7vWXbYjWzsjVlnH3p
        qHjnamvsH6WVyKG0xSxqlGEGXNg8cfWI3uvDOnPXTqeS8mOfpfcLejPWz7/0/TFR
        4SbmA==
X-ME-Sender: <xms:Mru5ZCEk_eP6cuHosRrzPfFZE4jdyxnh70uSzQYG_Qm6dw0oPl0CiA>
    <xme:Mru5ZDUkoLX00rudSDEf8C7-1QQBrQ59DvDRXw8TjQimh3NrXIgKpcgxN8SSXnVJx
    bBv1EKbm4rYR5zgCbQ>
X-ME-Received: <xmr:Mru5ZMJg84OCa8pHxFzRIfvoO63ek-jRLbn6pKSCM73-Z13G9Q2miZSgRtYK-Ybss5VSi-4ayza2qAzGY9ityEKl9O8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Mru5ZMHqSYtIuqNXdYctPZvcc9EkS15ah7ounQWnPo4Ko4qD6FtZNw>
    <xmx:Mru5ZIUekrtOO5HMpVZGmmCgEhRT3ugvhTUbbJm8zDavfvbN-R14hA>
    <xmx:Mru5ZPMYJR76LTmGAhK0ngYGNTU7shQABcrXThtdqwCKAcfKaugmLA>
    <xmx:Mru5ZBcUz80dkB8FaIat8nik_zIvO058RMeLzmyS3uTBiRyZxd_MEw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:42 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/20] btrfs: rename tree_ref and data_ref owning_root
Date:   Thu, 20 Jul 2023 15:52:38 -0700
Message-ID: <e9258cdb0b495710d7866e2e0d39b738802b5c41.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit 113479d5b8eb ("btrfs: rename root fields in delayed refs structs")
changed these from ref_root to owning_root. However, there are many
circumstances where that name is not really accurate and the root on the
ref struct _is_ the referring root. In general, these are not the owning
root, though it does happen in some ref merging cases involving
overwrites during snapshots and similar.

Simple quotas cares quite a bit about tracking the original owner of an
extent through delayed refs, so rename these back to free up the name
for the real owning root (which will live on the generic btrfs_ref and
the head ref)

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 10 +++++-----
 fs/btrfs/delayed-ref.h | 12 ++++++------
 fs/btrfs/extent-tree.c | 10 +++++-----
 fs/btrfs/ref-verify.c  |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index a9b938d3a531..f0bae1e1c455 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -885,7 +885,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 parent = generic_ref->parent;
 	u8 ref_type;
 
-	is_system = (generic_ref->tree_ref.owning_root == BTRFS_CHUNK_TREE_OBJECTID);
+	is_system = (generic_ref->tree_ref.ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
@@ -914,14 +914,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		ref_type = BTRFS_TREE_BLOCK_REF_KEY;
 
 	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
-				generic_ref->tree_ref.owning_root, action,
+				generic_ref->tree_ref.ref_root, action,
 				ref_type);
-	ref->root = generic_ref->tree_ref.owning_root;
+	ref->root = generic_ref->tree_ref.ref_root;
 	ref->parent = parent;
 	ref->level = level;
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
-			      generic_ref->tree_ref.owning_root, 0, action,
+			      generic_ref->tree_ref.ref_root, 0, action,
 			      false, is_system);
 	head_ref->extent_op = extent_op;
 
@@ -974,7 +974,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u64 ref_root = generic_ref->data_ref.owning_root;
+	u64 ref_root = generic_ref->data_ref.ref_root;
 	u64 owner = generic_ref->data_ref.ino;
 	u64 offset = generic_ref->data_ref.offset;
 	u8 ref_type;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b8e14b0ba5f1..a71eff78469c 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -188,8 +188,8 @@ enum btrfs_ref_type {
 struct btrfs_data_ref {
 	/* For EXTENT_DATA_REF */
 
-	/* Original root this data extent belongs to */
-	u64 owning_root;
+	/* Root which owns this data reference */
+	u64 ref_root;
 
 	/* Inode which refers to this data extent */
 	u64 ino;
@@ -212,11 +212,11 @@ struct btrfs_tree_ref {
 	int level;
 
 	/*
-	 * Root which owns this tree block.
+	 * Root which owns this tree block reference.
 	 *
 	 * For TREE_BLOCK_REF (skinny metadata, either inline or keyed)
 	 */
-	u64 owning_root;
+	u64 ref_root;
 
 	/* For non-skinny metadata, no special member needed */
 };
@@ -294,7 +294,7 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 	generic_ref->real_root = mod_root ?: root;
 #endif
 	generic_ref->tree_ref.level = level;
-	generic_ref->tree_ref.owning_root = root;
+	generic_ref->tree_ref.ref_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
 	if (skip_qgroup || !(is_fstree(root) &&
 			     (!mod_root || is_fstree(mod_root))))
@@ -312,7 +312,7 @@ static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
 	/* If @real_root not set, use @root as fallback */
 	generic_ref->real_root = mod_root ?: ref_root;
 #endif
-	generic_ref->data_ref.owning_root = ref_root;
+	generic_ref->data_ref.ref_root = ref_root;
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 04ceb9d25d3e..018e288ccf7d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1365,7 +1365,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
 	       generic_ref->action);
 	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
-	       generic_ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID);
+	       generic_ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID);
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
 		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
@@ -3307,9 +3307,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	 * tree, just update pinning info and exit early.
 	 */
 	if ((ref->type == BTRFS_REF_METADATA &&
-	     ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID) ||
+	     ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID) ||
 	    (ref->type == BTRFS_REF_DATA &&
-	     ref->data_ref.owning_root == BTRFS_TREE_LOG_OBJECTID)) {
+	     ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)) {
 		/* unlocks the pinned mutex */
 		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
 		ret = 0;
@@ -3320,9 +3320,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	}
 
 	if (!((ref->type == BTRFS_REF_METADATA &&
-	       ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID) ||
+	       ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID) ||
 	      (ref->type == BTRFS_REF_DATA &&
-	       ref->data_ref.owning_root == BTRFS_TREE_LOG_OBJECTID)))
+	       ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)))
 		btrfs_ref_tree_mod(fs_info, ref);
 
 	return ret;
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 95d28497de7c..b7b3bd86f5e2 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -681,10 +681,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 
 	if (generic_ref->type == BTRFS_REF_METADATA) {
 		if (!parent)
-			ref_root = generic_ref->tree_ref.owning_root;
+			ref_root = generic_ref->tree_ref.ref_root;
 		owner = generic_ref->tree_ref.level;
 	} else if (!parent) {
-		ref_root = generic_ref->data_ref.owning_root;
+		ref_root = generic_ref->data_ref.ref_root;
 		owner = generic_ref->data_ref.ino;
 		offset = generic_ref->data_ref.offset;
 	}
-- 
2.41.0


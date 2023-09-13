Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18779DD08
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjIMANJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjIMANI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:08 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD751706
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B645E32005D8;
        Tue, 12 Sep 2023 20:13:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Sep 2023 20:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563983; x=
        1694650383; bh=itcokK/KDzUBf93gLC5j0YCNwJjfjhXdBk3PAYsEFvg=; b=C
        5y8lfy7IfwN/TIuGD5buN0wYs2Qf7edmPamNThCw6g4vD1D1UDwmQU2bX0ho2oJT
        dLFw/+Wl2hWzKRDw90U27AWMktzaki2+oQzWfvdqrm/J504Qeb6hgj7WwqLReJ1Q
        QEVBnwuPwyERkhGnKqjqbq3qgqjDg96FFDQyY6h0Y/l868soEkbgMvxrmiXVtvO4
        YZq0X6KDXvlaLi+uu45VOxOdfEqPIH5DPCpTmTWowvR8ClUruAJa7OmCHzuW/kz1
        Q+VEMKtKnrS1fGLgVrZF+Prgk/5hpe+5LLNXrQX9JxAJkYJhH9i0qfX6USoPv44r
        OKy1O3uVoan7LU8GGuA5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563983; x=1694650383; bh=i
        tcokK/KDzUBf93gLC5j0YCNwJjfjhXdBk3PAYsEFvg=; b=BGLntnfY7xqJ5tBzj
        UzwWqHj9ZCL7E7rrRRhwuFLcuGXKAFPCwqB5Fa9oLsAecqEA7EOcoydwzp8peBSn
        03Z2CdXEhUHhfXh9kPGcFoNFzppIB7KcPZHEr/YdX35fMs5oooM23fFerarivkcG
        rK9MRPANhYl0g18mrxuOhZfaFUDriVwjFm7LaRdZ5+7dVR0UywKsvNKxvJ+9gpNA
        EdcQi548GxQzO+Pegf1kTF7UWLeDNFpD02Vw/CjyjvBY2QYv3NMm8ovinZoAZqKK
        DnuegVWWELoH/8MeANrM55wjZHi9WdSQ+pYtxSALGlIPhbKfI64mXV85S5UUVzMl
        1Qu9Q==
X-ME-Sender: <xms:j_4AZRo_q8zhKymhjsC_5fnwTArFPawBqPInq_bUYkZtm1c2_L8JuA>
    <xme:j_4AZTpWif-T_IIDi7YWh4mHOazRVK7a_r0rGpuj3GgAlPUMbE8uODiFcg2N_tarF
    ugsBXlMZqle_l-177k>
X-ME-Received: <xmr:j_4AZeMqyvFjM4_pngFiA1X_FwRb9t8Y_nJof3cEZZgMw0V0HJl51-EwtMiEM_n3H5bo8Xk_6p41xNAukXHkuiSFCwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:j_4AZc6gwz1u1iu9HSOuilFeXTr5B55tRg_X9yDVmxcGiVaehUpWOA>
    <xmx:j_4AZQ5Q8CzFXHE9mCn9efAv7gP5iGug50G3VvCNuJsIU6vwGFHuwQ>
    <xmx:j_4AZUhGDXy0TOU7YJTkV6BvMYj3VDpDr5a3eIUxDmBKvrYE1rthQw>
    <xmx:j_4AZVihzhO0hmsZU_Y8YDucxtN6ueLCKxWgT2UA9T82_oJl4LDy3g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:02 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 08/18] btrfs: rename tree_ref and data_ref owning_root
Date:   Tue, 12 Sep 2023 17:13:19 -0700
Message-ID: <41364ddd9f0def9ddd73f7a560e1a9ccb33939d7.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0a80224c8784..9d6a5dafd9b8 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -946,7 +946,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	u64 parent = generic_ref->parent;
 	u8 ref_type;
 
-	is_system = (generic_ref->tree_ref.owning_root == BTRFS_CHUNK_TREE_OBJECTID);
+	is_system = (generic_ref->tree_ref.ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
 	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
@@ -974,14 +974,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
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
 
@@ -1034,7 +1034,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u64 ref_root = generic_ref->data_ref.owning_root;
+	u64 ref_root = generic_ref->data_ref.ref_root;
 	u64 owner = generic_ref->data_ref.ino;
 	u64 offset = generic_ref->data_ref.offset;
 	u8 ref_type;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 783f84c9f2f4..1b4d16864d97 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -194,8 +194,8 @@ enum btrfs_ref_type {
 struct btrfs_data_ref {
 	/* For EXTENT_DATA_REF */
 
-	/* Original root this data extent belongs to */
-	u64 owning_root;
+	/* Root which owns this data reference */
+	u64 ref_root;
 
 	/* Inode which refers to this data extent */
 	u64 ino;
@@ -218,11 +218,11 @@ struct btrfs_tree_ref {
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
@@ -311,7 +311,7 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 	generic_ref->real_root = mod_root ?: root;
 #endif
 	generic_ref->tree_ref.level = level;
-	generic_ref->tree_ref.owning_root = root;
+	generic_ref->tree_ref.ref_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
 	if (skip_qgroup || !(is_fstree(root) &&
 			     (!mod_root || is_fstree(mod_root))))
@@ -329,7 +329,7 @@ static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
 	/* If @real_root not set, use @root as fallback */
 	generic_ref->real_root = mod_root ?: ref_root;
 #endif
-	generic_ref->data_ref.owning_root = ref_root;
+	generic_ref->data_ref.ref_root = ref_root;
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4135e6ec3d7c..ab13d2cd0ed5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1419,7 +1419,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
 	       generic_ref->action);
 	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
-	       generic_ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID);
+	       generic_ref->tree_ref.ref_root == BTRFS_TREE_LOG_OBJECTID);
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
 		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
@@ -3368,9 +3368,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
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
@@ -3381,9 +3381,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
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
index 26a7fb655f71..e9e1ebd8dd6a 100644
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


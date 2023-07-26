Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503FC7640A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGZUk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGZUk6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:40:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E81EC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:40:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A28B5C0101;
        Wed, 26 Jul 2023 16:40:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Jul 2023 16:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404057; x=
        1690490457; bh=c/1h5x7nXgXAcZs5rb1gjOxbOML5UPVOtoHdeWbqhQg=; b=o
        HuziD1HjbXT44ajHByN8MiIUW2fQsJ72oyv3Djg8RC464xgMMlgFzCx10NwzeajJ
        lSOpZmOg6rN8fmBsCKWj3+frvJeA0yezU/HkcoBJnT2d9dHUY3lfJi0PuqKQ87nB
        zpuGfe1w1edMFD++x/xzafuiNvY95rwKlzukFKE2IJ3fC7Nw2pAMRN8pZDFIl6Wb
        NgjtqVXYxnOm4E6Dqo+7X3LsJQaMp+oDGXhSAddLf26EqSj9FXuUur1Qdm2G1MxV
        4VdZzKjpMDAa2AN3+fiQVIKQiCyzCh+soQN/eSw99FhdMuXpxwTXhhHc5YbCyKWK
        A0r5QMsSA16NQw6SSGGtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404057; x=1690490457; bh=c
        /1h5x7nXgXAcZs5rb1gjOxbOML5UPVOtoHdeWbqhQg=; b=xKWQpMQc3qiD/Ks85
        J7KOY3yENBNn1l2t5X9pfbhwUIYDJDvqhNe+BzkSBBHaB42b0Ifn7vEe6iDAeIAW
        SFGRiKF+AVBctqnNeAnmGRBKGb6DpOgBrQ4JJtTwX0BwfLW86+KHD9oMBokAF/Aq
        idf+HaYx1JTVxOXRbNwshVTsenO31TPM+voQagP12il0biW2MvdBlvTvZ2ojZRdf
        GC3158yPSbopNrTasclMo7DTVd05iyR5KK6MsI9MpD0JAm0AMCsBB100SXJTRp5F
        BOTDeB1v87V409nBotLZ9tKIgdAVHZkuQnhVORC5VeJ3OtfpWNBKhKaFo7e12Xib
        XVMpQ==
X-ME-Sender: <xms:2ITBZGUOngqqf25vlfN-mEMqrl0V-ZBTnqJ-Ro1f0YAaqK3C9tmRZw>
    <xme:2ITBZCn7TKmcpO7w5K8UENtZgClO83z263eheYiftzr23GiXGBw63qPicC2983ys2
    sD545O9KBRybb7pMuY>
X-ME-Received: <xmr:2ITBZKYemk6t939Q-mj_UL5n9wy2UbFvIMHrzo3fJhP0mXyIEI0WHSQRufQ1W_oVzNQ-HBXDPX20Prt0j-IqNO3coIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:2ITBZNWcE2lMzvi_kS1c2JiOKmhN5nBoq5N8eISeQ7M8LNwEJv7DJg>
    <xmx:2ITBZAnp4OKiebUdPe-afEQhloxJqnV4e1m_UjA_Rv-ePHbdVxq_pw>
    <xmx:2ITBZCfrU85jKHP67yB36CKOuNTRJ1Aj489PxJk7Zq-ek33ACFrlbw>
    <xmx:2YTBZHsqMosrZjKwGVV7ql-q469H13Bf5LRxsd-DnAUquAUCNun17A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:56 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 08/18] btrfs: rename tree_ref and data_ref owning_root
Date:   Wed, 26 Jul 2023 13:38:35 -0700
Message-ID: <115764725f728e22a54dc355be875f9ae0ed4de3.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690403768.git.boris@bur.io>
References: <cover.1690403768.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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


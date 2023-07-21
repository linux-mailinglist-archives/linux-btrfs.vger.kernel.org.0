Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1495975CD11
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjGUQEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGUQEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A62D50
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 22F9332009A3;
        Fri, 21 Jul 2023 12:04:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955469; x=
        1690041869; bh=c/1h5x7nXgXAcZs5rb1gjOxbOML5UPVOtoHdeWbqhQg=; b=H
        Ix7XCdnBnTejTd1iz1zayu0fEgrPLZsoOTs3mosZsaZFfXi6N30KeuCdJ2UaDw10
        ro/hRwuD4ogTypyqHxdyPrGPkqR/VNp5gKSiQCe2TExSNX977AXKgtyU2Xb0dpZX
        r0OfPhkI3LNLuQjA0s8ZqDa04vJCRkNxPzIATxriljHrAPJ/2mjA6ktzlN5Alv2Q
        0Qzl0zIQH3xy5itI7T8PUgO3IOP4sHyzJS3dwexL2ygG61JpMU8M1j2G6OEjEZbV
        7Tf1P90ehzH7EGCwWIqZFAI/NYZweseIu/bFid0HzVEKBTed1OYO7KYYWNTLjarc
        OtveyumW7Q5nH+mpT/k7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955469; x=1690041869; bh=c
        /1h5x7nXgXAcZs5rb1gjOxbOML5UPVOtoHdeWbqhQg=; b=orL62MlerJTH7M5aj
        nwj1Nhsp2Rfet7uO3NPkpToHr+o046HKW+jIvF3GlNg/qaF4PeKRWpYl2tIioxx7
        jHvBEaXxwfunVWDXoHVmb48k4hFigMa/DdG0shMw3XIAawV6MN2eky9fF0czXS2f
        JXtxKk4mIddvuzm85L0Xhfrv2nbRdyadqBULX286NNIFO47hK5gRq5rp1IldF5jZ
        hhYQAP1WocDnlnwm5XPUgjFpe7lqrCgOinONdq5phrqNVZhoCXvusQPC0eRjHI5Y
        /vecqYD8NlIF7XfZirowGgOlJRhzLyEev1dRWLL2ZG1H9t3TTNnjHEbdzx8Yg6o1
        KkH8w==
X-ME-Sender: <xms:jay6ZO26BfBTe_kTbkyeSryEuoX-_X80D5mUmZ7mSr45ZI6KOpCvQg>
    <xme:jay6ZBGh03jb_pjW_ZvyQvOwZwAD9jqM1xwGryEeqYuy736YvsS8NYxK28_fon0Hn
    OGxqO-lPrnfixD4Ho0>
X-ME-Received: <xmr:jay6ZG4y3cWom1-sfrq5pEQsFRrVGHszHqdI5eO2mbcQ02XWI9xGl5Iv8LRF7JDw4yTDThf18G8TJtgVcA-9LBJFzt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:jay6ZP24yCAThOSZ4K0WJXfASORWkhbCZyoRlRAEGjhbE04gn8n8gQ>
    <xmx:jay6ZBHWKXdO5b_pgk_8iI2QYNnp62-o8WnLIeKPfZljm9fn4aOTiQ>
    <xmx:jay6ZI8HtumXSjXy0xCzj2TGJYLKszpcw94-_gbCqcJHV6D9wdb6ew>
    <xmx:jay6ZEPvCKhCQQiuwpUWvEJMIaC-b6T9GZqyWZLx4poVI-mSZ1swuQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:29 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 10/20] btrfs: rename tree_ref and data_ref owning_root
Date:   Fri, 21 Jul 2023 09:02:15 -0700
Message-ID: <e9258cdb0b495710d7866e2e0d39b738802b5c41.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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


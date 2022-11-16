Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3662C8DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKPTWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 14:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKPTWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 14:22:11 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E5B25
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 11:22:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BBD35C00E8;
        Wed, 16 Nov 2022 14:22:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Nov 2022 14:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668626529; x=1668712929; bh=lV
        Up3xPSzjKKrGna7C3oXogFTWSSib0fAakpKHTOH9c=; b=e4HL7ljGCCgg3k8emI
        jeSN3jbPnuMuoyqFXdBELVXqAZDjbPVq3ec46i1LLMl6Z+xvXx/u9Q1tmkDVpHNS
        SsD+M8M2yEBSlSilLv/Z2LgTnVtBd4dyL072ARMiUBUS6JN/qxB0Idtb3kbwfujG
        e2whAj8obKaup8mv3C1CPVIxM+qZodbh0ZARWXIiyD+wzX1zJ+W9S9dMKVbwnyFv
        EPH2kCnKdWXTLSZGkhvkNlgSpkiOsCJ4Sryg/d2KrAaTAdP/c95ylIeQ6Xn83ij6
        Cy90pGO0aM4yZH+cJzMz8QZgrbKwowEJYODg2MdfaPFSYUQ5RBH+IB34l0KhcQbr
        0oGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668626529; x=1668712929; bh=lVUp3xPSzjKKr
        Gna7C3oXogFTWSSib0fAakpKHTOH9c=; b=k3YMvjVxEr9nPVOCqBby5bSStqiwq
        sFlRKhs61LqikVcfgy4WqjtgCvKVvt7eANil8oPRbUbdXbvSMJHB49PhtclBp/6z
        2ybBYMGgw+fum4JLoWLDYzzzV94qR80uHVBuLaqaOqKFKsHMs7pyYoZSbF7FExuM
        EzOjqWjAZ/pPUAXx6f9zdY1FhbIwBN0/ohv9KpthSJWKtxRwf2TwS/C1IS+N5dRJ
        OF0aLoBlh6psXT+k/ffi4y+6NJFe712oi/2JV3r4MGK3GEgSUVJE56BRZyArjUrA
        xqc8Oph3fStfxuhVn5kSy2LD9TGe/wQMdWRdUPWMjB7vUHB4uYK7HcZEQ==
X-ME-Sender: <xms:YDh1Y-yoFcZ4eDjQmpf3sv1hQfTKyXSQwh-wT7JNIZpzJGYro1LRiQ>
    <xme:YDh1Y6QQg3bfgxl3p2abD7wBX_3c_fLp-6WpRGqN72CQl64oqKBeikNo_0yD3AISI
    Pb03v00eAjTfLi8H6I>
X-ME-Received: <xmr:YDh1YwXGUb37nyD96zmvt1ox0Nj3X0-NKa67bgfH3ovezfVoFaEvg1oG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeigdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:YDh1Y0g6OTtTxsp4-42N7a3H7GePRqJCbuY4HLXJsUNdyQwXDxsuww>
    <xmx:YDh1YwBFXgiMEzzfMz1nHhAMxWKQj2DjMoAnl9V5WPQBTxqerxJ8-Q>
    <xmx:YDh1Y1L9B19n1Bp2snF75M4jAfFEKHBXVHJR7xZkCuABVABT0uz9WQ>
    <xmx:YTh1Y7q-jRMG6lZiCz42vyLpDv12m0Q6-6nrqYVbrrtig_V8OlNt1g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 14:22:08 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/4] btrfs: use ffe_ctl in btrfs allocator tracepoints
Date:   Wed, 16 Nov 2022 11:22:02 -0800
Message-Id: <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668626092.git.boris@bur.io>
References: <cover.1668626092.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The allocator tracepoints currently have a pile of values from ffe_ctl.
In modifying the allocator and adding more tracepoints, I found myself
adding to the already long argument list of the tracepoints. It makes it
a lot simpler to just send in the ffe_ctl itself.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c       | 91 ++----------------------------------
 fs/btrfs/extent-tree.h       | 75 +++++++++++++++++++++++++++++
 fs/btrfs/super.c             |  1 +
 include/trace/events/btrfs.h | 41 ++++++++--------
 4 files changed, 102 insertions(+), 106 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 17f599027c3d..defef7caddbb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -16,7 +16,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/lockdep.h>
 #include <linux/crc32c.h>
-#include "misc.h"
+#include "extent-tree.h"
 #include "tree-log.h"
 #include "disk-io.h"
 #include "print-tree.h"
@@ -31,7 +31,6 @@
 #include "space-info.h"
 #include "block-rsv.h"
 #include "delalloc-space.h"
-#include "block-group.h"
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
@@ -3449,81 +3448,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 	btrfs_put_block_group(cache);
 }
 
-enum btrfs_extent_allocation_policy {
-	BTRFS_EXTENT_ALLOC_CLUSTERED,
-	BTRFS_EXTENT_ALLOC_ZONED,
-};
-
-/*
- * Structure used internally for find_free_extent() function.  Wraps needed
- * parameters.
- */
-struct find_free_extent_ctl {
-	/* Basic allocation info */
-	u64 ram_bytes;
-	u64 num_bytes;
-	u64 min_alloc_size;
-	u64 empty_size;
-	u64 flags;
-	int delalloc;
-
-	/* Where to start the search inside the bg */
-	u64 search_start;
-
-	/* For clustered allocation */
-	u64 empty_cluster;
-	struct btrfs_free_cluster *last_ptr;
-	bool use_cluster;
-
-	bool have_caching_bg;
-	bool orig_have_caching_bg;
-
-	/* Allocation is called for tree-log */
-	bool for_treelog;
-
-	/* Allocation is called for data relocation */
-	bool for_data_reloc;
-
-	/* RAID index, converted from flags */
-	int index;
-
-	/*
-	 * Current loop number, check find_free_extent_update_loop() for details
-	 */
-	int loop;
-
-	/*
-	 * Whether we're refilling a cluster, if true we need to re-search
-	 * current block group but don't try to refill the cluster again.
-	 */
-	bool retry_clustered;
-
-	/*
-	 * Whether we're updating free space cache, if true we need to re-search
-	 * current block group but don't try updating free space cache again.
-	 */
-	bool retry_unclustered;
-
-	/* If current block group is cached */
-	int cached;
-
-	/* Max contiguous hole found */
-	u64 max_extent_size;
-
-	/* Total free space from free space cache, not always contiguous */
-	u64 total_free_space;
-
-	/* Found result */
-	u64 found_offset;
-
-	/* Hint where to start looking for an empty space */
-	u64 hint_byte;
-
-	/* Allocation policy */
-	enum btrfs_extent_allocation_policy policy;
-};
-
-
 /*
  * Helper function for find_free_extent().
  *
@@ -3555,8 +3479,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 	if (offset) {
 		/* We have a block, we're done */
 		spin_unlock(&last_ptr->refill_lock);
-		trace_btrfs_reserve_extent_cluster(cluster_bg,
-				ffe_ctl->search_start, ffe_ctl->num_bytes);
+		trace_btrfs_reserve_extent_cluster(cluster_bg, ffe_ctl);
 		*cluster_bg_ret = cluster_bg;
 		ffe_ctl->found_offset = offset;
 		return 0;
@@ -3606,10 +3529,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 		if (offset) {
 			/* We found one, proceed */
 			spin_unlock(&last_ptr->refill_lock);
-			trace_btrfs_reserve_extent_cluster(bg,
-					ffe_ctl->search_start,
-					ffe_ctl->num_bytes);
 			ffe_ctl->found_offset = offset;
+			trace_btrfs_reserve_extent_cluster(bg, ffe_ctl);
 			return 0;
 		}
 	} else if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
@@ -4292,8 +4213,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ins->objectid = 0;
 	ins->offset = 0;
 
-	trace_find_free_extent(root, ffe_ctl->num_bytes, ffe_ctl->empty_size,
-			       ffe_ctl->flags);
+	trace_find_free_extent(root, ffe_ctl);
 
 	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
 	if (!space_info) {
@@ -4464,8 +4384,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ins->objectid = ffe_ctl->search_start;
 		ins->offset = ffe_ctl->num_bytes;
 
-		trace_btrfs_reserve_extent(block_group, ffe_ctl->search_start,
-					   ffe_ctl->num_bytes);
+		trace_btrfs_reserve_extent(block_group, ffe_ctl);
 		btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 		break;
 loop:
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index ae5425253603..f1085226d785 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -3,6 +3,81 @@
 #ifndef BTRFS_EXTENT_TREE_H
 #define BTRFS_EXTENT_TREE_H
 
+#include "ctree.h"
+#include "misc.h"
+#include "block-group.h"
+
+enum btrfs_extent_allocation_policy {
+	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
+};
+
+struct find_free_extent_ctl {
+	/* Basic allocation info */
+	u64 ram_bytes;
+	u64 num_bytes;
+	u64 min_alloc_size;
+	u64 empty_size;
+	u64 flags;
+	int delalloc;
+
+	/* Where to start the search inside the bg */
+	u64 search_start;
+
+	/* For clustered allocation */
+	u64 empty_cluster;
+	struct btrfs_free_cluster *last_ptr;
+	bool use_cluster;
+
+	bool have_caching_bg;
+	bool orig_have_caching_bg;
+
+	/* Allocation is called for tree-log */
+	bool for_treelog;
+
+	/* Allocation is called for data relocation */
+	bool for_data_reloc;
+
+	/* RAID index, converted from flags */
+	int index;
+
+	/*
+	 * Current loop number, check find_free_extent_update_loop() for details
+	 */
+	int loop;
+
+	/*
+	 * Whether we're refilling a cluster, if true we need to re-search
+	 * current block group but don't try to refill the cluster again.
+	 */
+	bool retry_clustered;
+
+	/*
+	 * Whether we're updating free space cache, if true we need to re-search
+	 * current block group but don't try updating free space cache again.
+	 */
+	bool retry_unclustered;
+
+	/* If current block group is cached */
+	int cached;
+
+	/* Max contiguous hole found */
+	u64 max_extent_size;
+
+	/* Total free space from free space cache, not always contiguous */
+	u64 total_free_space;
+
+	/* Found result */
+	u64 found_offset;
+
+	/* Hint where to start looking for an empty space */
+	u64 hint_byte;
+
+	/* Allocation policy */
+	enum btrfs_extent_allocation_policy policy;
+};
+
+
 enum btrfs_inline_ref_type {
 	BTRFS_REF_TYPE_INVALID,
 	BTRFS_REF_TYPE_BLOCK,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ea83dd9f735a..e4e844f5fe8d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -58,6 +58,7 @@
 #include "scrub.h"
 #include "verity.h"
 #include "super.h"
+#include "extent-tree.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0bce0b4ff2fa..423baed891d8 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -32,6 +32,7 @@ struct prelim_ref;
 struct btrfs_space_info;
 struct btrfs_raid_bio;
 struct raid56_bio_trace_info;
+struct find_free_extent_ctl;
 
 #define show_ref_type(type)						\
 	__print_symbolic(type,						\
@@ -1241,38 +1242,38 @@ DEFINE_EVENT(btrfs__reserved_extent,  btrfs_reserved_extent_free,
 
 TRACE_EVENT(find_free_extent,
 
-	TP_PROTO(const struct btrfs_root *root, u64 num_bytes,
-		 u64 empty_size, u64 data),
+	TP_PROTO(const struct btrfs_root *root,
+		 const struct find_free_extent_ctl *ffe_ctl),
 
-	TP_ARGS(root, num_bytes, empty_size, data),
+	TP_ARGS(root, ffe_ctl),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	root_objectid		)
 		__field(	u64,	num_bytes		)
 		__field(	u64,	empty_size		)
-		__field(	u64,	data			)
+		__field(	u64,	flags			)
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->root_objectid	= root->root_key.objectid;
-		__entry->num_bytes	= num_bytes;
-		__entry->empty_size	= empty_size;
-		__entry->data		= data;
+		__entry->num_bytes	= ffe_ctl->num_bytes;
+		__entry->empty_size	= ffe_ctl->empty_size;
+		__entry->flags		= ffe_ctl->flags;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) len=%llu empty_size=%llu flags=%llu(%s)",
 		  show_root_type(__entry->root_objectid),
-		  __entry->num_bytes, __entry->empty_size, __entry->data,
-		  __print_flags((unsigned long)__entry->data, "|",
+		  __entry->num_bytes, __entry->empty_size, __entry->flags,
+		  __print_flags((unsigned long)__entry->flags, "|",
 				 BTRFS_GROUP_FLAGS))
 );
 
 DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 
-	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
-		 u64 len),
+	TP_PROTO(const struct btrfs_block_group *block_group,
+		 const struct find_free_extent_ctl *ffe_ctl),
 
-	TP_ARGS(block_group, start, len),
+	TP_ARGS(block_group, ffe_ctl),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	bg_objectid		)
@@ -1284,8 +1285,8 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 	TP_fast_assign_btrfs(block_group->fs_info,
 		__entry->bg_objectid	= block_group->start;
 		__entry->flags		= block_group->flags;
-		__entry->start		= start;
-		__entry->len		= len;
+		__entry->start		= ffe_ctl->search_start;
+		__entry->len		= ffe_ctl->num_bytes;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) block_group=%llu flags=%llu(%s) "
@@ -1299,18 +1300,18 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 
 DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent,
 
-	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
-		 u64 len),
+	TP_PROTO(const struct btrfs_block_group *block_group,
+		 const struct find_free_extent_ctl *ffe_ctl),
 
-	TP_ARGS(block_group, start, len)
+	TP_ARGS(block_group, ffe_ctl)
 );
 
 DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
 
-	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
-		 u64 len),
+	TP_PROTO(const struct btrfs_block_group *block_group,
+		 const struct find_free_extent_ctl *ffe_ctl),
 
-	TP_ARGS(block_group, start, len)
+	TP_ARGS(block_group, ffe_ctl)
 );
 
 TRACE_EVENT(btrfs_find_cluster,
-- 
2.38.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6017562FCBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 19:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbiKRS3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiKRS3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 13:29:18 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA499EA9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 10:28:07 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AB0A55C01C9;
        Fri, 18 Nov 2022 13:28:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 18 Nov 2022 13:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668796086; x=1668882486; bh=Lx
        YJblIxZLQaPhDfiCYj9Thkq5HH4hLTpSYt5UBAOHc=; b=VqgENJ0H3aLp/mOzNR
        BXyA58H1DT7ljmEqSyDJAfaBDDXWN822/ST2zjDX3/vYMGi/VXDhPRU76czwDJTN
        U2nbUar4kouhPgygtE/rnp9DcHAWxP3n9JnNFMEIi0J1ILpl4tbUV4h7/eKz+xkO
        /TZwI9BsLYxX9Dh1P1K5aA+DcZQCMVeACbZeddtdgfn5wZtnMuNpNbHMkzX2EQyy
        6gdIHIHkfxNyeDBaFqXjSJQV6SuiLxPUzTIjbi/5X6gwTy92IO89H94vjauHyUmj
        ukPrFEnt/G901CB3j6b8xGXYWRZlxavwP2F/vNuVQ1ALCKKTebO4VJWuVMmQhe+W
        jNOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668796086; x=1668882486; bh=LxYJblIxZLQaP
        hDfiCYj9Thkq5HH4hLTpSYt5UBAOHc=; b=XAHwA5IuClQb4vBsC5VtJa8Kt+fb/
        MdGc7INJoKqpPxgRZG/D2rTMwslnAzyYtkCDW14bKGejP5A2DXeVLsMvOpSHQjzx
        ylXgZCjvsYYdiBv1CiWwwXs82n+v/9F7SCPJQd4+S8g0EwVf5jeO38vMbMPgmfWY
        Q5WV4HJUxlxOIGOt4jwfFIGGn8LUxtGchOaaZmpe3MeYa8TjhP6HEKwMDivChZeh
        6pE89UHhORCim0eDl9f35XfUrfTbHw7RGo0CEgBEnhsxL0JkSD4wpzFUWgwrpGbQ
        kAJ5u1nWqIQIDHQFSTbP9koklLnWIpRvvLYFG+4kmojv7Q04Pl1GTxHBQ==
X-ME-Sender: <xms:tc53Y0a85Wd-GUhB89hv7A68ZznFwtGEi__tPxaosSQ9-AIUKU4W0w>
    <xme:tc53Y_YpdjAN7Yu_kJ_i3iKjD2nZaOMkjyhHvO2XUrmBvzYaJGV_nuoOkTWesguSi
    siXtAQNo9zU-GAiaIs>
X-ME-Received: <xmr:tc53Y-85K8abL_lGRBjZrbZRhP73scKlJu9pxmA_oBHiS7Hgkf7NVdAh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:tc53Y-rQqyXpU9zSTEF4QH7QSsHeCFqacGuavj3Wjb4otM5a8thdPg>
    <xmx:tc53Y_rz1Seswx_0Wzqzx7H8qkaE0FN5Sx5tk0Mo18_X4ZiWNszsaw>
    <xmx:tc53Y8QZqmZ-gYBNF3109SEO4zGG_aZxjgfT4aRsEo5ad96rSbEt1w>
    <xmx:ts53Y-QFZl0LgXcbfSPeHl-L3u8od1-tfBxNvLJfOi2XSgcXtdPXSw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 13:28:05 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/4] btrfs: use ffe_ctl in btrfs allocator tracepoints
Date:   Fri, 18 Nov 2022 10:27:58 -0800
Message-Id: <99b37b4c2fcf373055bb04e6b83e27d64e91294a.1668795992.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668795992.git.boris@bur.io>
References: <cover.1668795992.git.boris@bur.io>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c       | 92 +++---------------------------------
 fs/btrfs/extent-tree.h       | 75 +++++++++++++++++++++++++++++
 fs/btrfs/super.c             |  1 +
 include/trace/events/btrfs.h | 41 ++++++++--------
 4 files changed, 103 insertions(+), 106 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 892d78c1853c..a53f90677fbc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -16,7 +16,8 @@
 #include <linux/percpu_counter.h>
 #include <linux/lockdep.h>
 #include <linux/crc32c.h>
-#include "misc.h"
+#include "ctree.h"
+#include "extent-tree.h"
 #include "tree-log.h"
 #include "disk-io.h"
 #include "print-tree.h"
@@ -31,7 +32,6 @@
 #include "space-info.h"
 #include "block-rsv.h"
 #include "delalloc-space.h"
-#include "block-group.h"
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
@@ -3450,81 +3450,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
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
@@ -3556,8 +3481,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 	if (offset) {
 		/* We have a block, we're done */
 		spin_unlock(&last_ptr->refill_lock);
-		trace_btrfs_reserve_extent_cluster(cluster_bg,
-				ffe_ctl->search_start, ffe_ctl->num_bytes);
+		trace_btrfs_reserve_extent_cluster(cluster_bg, ffe_ctl);
 		*cluster_bg_ret = cluster_bg;
 		ffe_ctl->found_offset = offset;
 		return 0;
@@ -3607,10 +3531,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
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
@@ -4293,8 +4215,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ins->objectid = 0;
 	ins->offset = 0;
 
-	trace_find_free_extent(root, ffe_ctl->num_bytes, ffe_ctl->empty_size,
-			       ffe_ctl->flags);
+	trace_find_free_extent(root, ffe_ctl);
 
 	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
 	if (!space_info) {
@@ -4465,8 +4386,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ins->objectid = ffe_ctl->search_start;
 		ins->offset = ffe_ctl->num_bytes;
 
-		trace_btrfs_reserve_extent(block_group, ffe_ctl->search_start,
-					   ffe_ctl->num_bytes);
+		trace_btrfs_reserve_extent(block_group, ffe_ctl);
 		btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 		break;
 loop:
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index ae5425253603..64fa8ad7914a 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -3,6 +3,81 @@
 #ifndef BTRFS_EXTENT_TREE_H
 #define BTRFS_EXTENT_TREE_H
 
+#include "misc.h"
+#include "block-group.h"
+
+struct btrfs_free_cluster;
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
 enum btrfs_inline_ref_type {
 	BTRFS_REF_TYPE_INVALID,
 	BTRFS_REF_TYPE_BLOCK,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 93f52ee85f6f..ddd4767fcd87 100644
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


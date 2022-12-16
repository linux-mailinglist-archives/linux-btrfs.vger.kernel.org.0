Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25764E4F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiLPAGn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 19:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLPAGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 19:06:41 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D10C5C0CA
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 16:06:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 97C975C0061;
        Thu, 15 Dec 2022 19:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Dec 2022 19:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671149198; x=1671235598; bh=Yx
        BGKcGxtOneKq/D1PAKhrpn8J4xCMzVjUZTxEiOS6U=; b=AZ1TgqulrzbB74rH5W
        R00BhtrAojB/dDdC+FliBLGlzjdYrztprm11RICDEArPiAc7AAyxuFGOh8A5gWDx
        nOpkrX7fJ2/gW1kBqDZC0nIy6CQ4b37HrqAwxnRx8ANWIfrL3C6ffr1nDVzjqGmo
        PvvKh7ZSUHPRejW0BEi645bCnm8DO+5HeTqNrU9j/beCHzYuaCVkOOCB7A8bKf3I
        MIuuhLU7LyZyhVnHus4cKvVRAi55m1qtgQGr+ztjLkP4myI97VfJw7cF+4fz7EZF
        fOmntnlUl78rp3nb803lJkzgEVB2Uvt5f65i+wVyoXp/yWfGsNFnRs3NedYIjdZg
        GNkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671149198; x=1671235598; bh=YxBGKcGxtOneK
        q/D1PAKhrpn8J4xCMzVjUZTxEiOS6U=; b=EqKtBPGFFMkmVVWwE0gcwe6sl3bXN
        Q1NZPwMoIT1zp4L/TUuEUak1VtmyvF8L92su5BhqOIEsbiUMSQpp0/0ubu5ZrrTL
        HnANphPcg8HzZXL0ObvprwB9cXlBYq2DzxDbixltgvbqGrp48Lxz873tJoBIH2Co
        NrjJGTwtUQOTq6MkJgOSDZ3fd7jQKRe7vZbttSaPl9YF521CMTyDbgq9K1esXj6N
        k9foOvI8OYJLQM8S2Ki35pnpmtzFFobdN97iPWy9N/eBg+3xEsQDUm6H3XU5MPAu
        FEL4+k4EefhWGKxgr5kUNRcUD7dW0NXvzWgib/ipvZhT/BN9dgiL51T1Q==
X-ME-Sender: <xms:jrabY3YwHpRhGNOCggvhDpDxKQ8NQpQt7TE80MB20q6zpAO9NE6lGg>
    <xme:jrabY2bCInmXiwYnRh8BUqmEx0bx3dwfWFuWGp9leXh7fMWUdDkvgTxcNNrm0_2do
    OvGw89hwxY-8e1kZc8>
X-ME-Received: <xmr:jrabY5_B3G8XnY41ePnNeaHO3XSkQcsj7e2Lb-fSK7-01tL4ZJTYaAUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:jrabY9q2apz9ofAub6B_OyDz-QvEuRnVwEhMnUcQd7C5TMKYXMixxw>
    <xmx:jrabYyp781IydEDiimfx7Gu5vqImBdNyaoymmLYCwOy4wfuy-HPR5w>
    <xmx:jrabYzTJ8YksnLq7yzeUj-wgWJXILLcCZTXas5QYiEwnLSBpGXc1iw>
    <xmx:jrabY5TT_mzNJ2bg-L4Jcfk_VDM-sWtulRswhJIDpeBzBOH0Qjk99Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 19:06:38 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 1/5] btrfs: use ffe_ctl in btrfs allocator tracepoints
Date:   Thu, 15 Dec 2022 16:06:31 -0800
Message-Id: <0bdfb69d48494bf2ac884c7a434981df2afcee54.1671149056.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671149056.git.boris@bur.io>
References: <cover.1671149056.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 82fe303f73c1..3ef70c9bb124 100644
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
index d8f738771b29..ce07d1db79b5 100644
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
index d5de18d6517e..6bd97b29887a 100644
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
index 6548b5b5aa60..8a422e29d064 100644
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


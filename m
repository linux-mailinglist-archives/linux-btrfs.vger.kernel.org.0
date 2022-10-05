Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412AD5F5ABB
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 21:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJETtb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 15:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJETt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 15:49:29 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7037F271
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 12:49:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 87EC55C01A4;
        Wed,  5 Oct 2022 15:49:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Oct 2022 15:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664999367; x=1665085767; bh=yK
        Ak63ynkVxTGplMWXJbjJiT2C7+t5fRaoihgCz+Nsc=; b=VfEJBwRFrpBAVYyT20
        3O3QUiwCgAxA6G09Lb8+8LvC9Q6+vNeDsED6sEhrq6aZXJMFUwcFB2Ta6+ZWVU0p
        YMf1o5ElScQTXwRcYGD3gZP1bYhzHmDanpXcCOq9R0lcsf5FIgEUeoc50D+xCyFE
        RFkkEybyEeInUhXOvcPTbLBM5H7ZoK9Fv6fL7qfPIGLHJR784wvKz8ufHX3eILmM
        4uG34XRrad8pjo2sr+U4wqBGENpVGTZUdYHgWDDfk3L91JB+sEqr7qG52SJoy2pX
        qS0oYttbXiaXlMiL8SdEyaazC7Iiiw0LZT1P9wLsdw8H2zju60WE67saFKDDnkdP
        QAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664999367; x=1665085767; bh=yKAk63ynkVxTG
        plMWXJbjJiT2C7+t5fRaoihgCz+Nsc=; b=JtAVLepJFMBNjr67h+4wOqcPMXY0c
        1hjIaf+1EXCJoiuTx/fbHqiXwzeNbc2zynwr08HK/+uL/aFYXBz0iEWvlNp2B765
        m5pp0JYvDQAhMoOrdO5Dipi8Tsq/OccHE1Sl1cAsHu4D+OidlKjf8md10ZtlmOme
        1Qukas3nalEXDvtWzc5huflfgkBrvjLRwPrKv+Qtte4N+8ZydUi+YJCe6czDaVhq
        VKgSpVvZdbLlrba24zi8y7Wm5cKA+icQGVSsv5W3hnp2t4llv4vols1fzj1AS1/1
        aiGXgYp/Z8DEeWGJ02BsBkhxoeo/RwsMS7k9ncCDnMJGH2zA19Z660J7A==
X-ME-Sender: <xms:x989Ywy2dIYN_YCKasSQUqsJVgDYQVmywPQMEj6AOAZPz3AR5nPdwQ>
    <xme:x989Y0RnRp44RDFklGw8l5dlX-bbkmkDiT8XihFXkfAsbLIM1YyCQqTVoGwYX63gF
    VblgDK5yfc0qnQ3izQ>
X-ME-Received: <xmr:x989YyVo0caeQXO3aH6V4xdGOxgG9OIY5J9v_EVo0XNodyj13p-UUapnf8Ub_Sge4X3Jbo7-yy8e7RV2WFl39bXC6tCdAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:x989Y-gBuieDT7KWxk81TWsVID7OIygkmCtKME55OntVq0kV7JaEJw>
    <xmx:x989YyAEDTapjfA5IUJfS6Fjd7gZY67Lu6hf6JjeVKTPwVD-OXMXIA>
    <xmx:x989Y_IdpsOqntf3o70XrA2k5lrCrbOyvO_NIPPVvWrFFooUnG-VzA>
    <xmx:x989Y9qEU-HDTEcEiCb4IIp2cXuXa5US3wpVhbUKYcPKn9Cq5-fXGg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 15:49:27 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: use ffe_ctl in btrfs allocator tracepoints
Date:   Wed,  5 Oct 2022 12:49:19 -0700
Message-Id: <22c0c12d9fb7750d21fe2e7ad566bcc49856bf5a.1664999303.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1664999303.git.boris@bur.io>
References: <cover.1664999303.git.boris@bur.io>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c       | 91 ++----------------------------------
 fs/btrfs/extent-tree.h       | 80 +++++++++++++++++++++++++++++++
 fs/btrfs/super.c             |  1 +
 include/trace/events/btrfs.h | 41 ++++++++--------
 4 files changed, 107 insertions(+), 106 deletions(-)
 create mode 100644 fs/btrfs/extent-tree.h

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cd2d36580f1a..0fe1e8eb10cf 100644
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
@@ -3442,81 +3441,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
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
@@ -3548,8 +3472,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 	if (offset) {
 		/* We have a block, we're done */
 		spin_unlock(&last_ptr->refill_lock);
-		trace_btrfs_reserve_extent_cluster(cluster_bg,
-				ffe_ctl->search_start, ffe_ctl->num_bytes);
+		trace_btrfs_reserve_extent_cluster(cluster_bg, ffe_ctl);
 		*cluster_bg_ret = cluster_bg;
 		ffe_ctl->found_offset = offset;
 		return 0;
@@ -3599,10 +3522,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
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
@@ -4285,8 +4206,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ins->objectid = 0;
 	ins->offset = 0;
 
-	trace_find_free_extent(root, ffe_ctl->num_bytes, ffe_ctl->empty_size,
-			       ffe_ctl->flags);
+	trace_find_free_extent(root, ffe_ctl);
 
 	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
 	if (!space_info) {
@@ -4457,8 +4377,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ins->objectid = ffe_ctl->search_start;
 		ins->offset = ffe_ctl->num_bytes;
 
-		trace_btrfs_reserve_extent(block_group, ffe_ctl->search_start,
-					   ffe_ctl->num_bytes);
+		trace_btrfs_reserve_extent(block_group, ffe_ctl);
 		btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 		break;
 loop:
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
new file mode 100644
index 000000000000..7d3bb9c60fbe
--- /dev/null
+++ b/fs/btrfs/extent-tree.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_EXTENT_TREE_H
+#define BTRFS_EXTENT_TREE_H
+
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
+#endif /* BTRFS_EXTENT_TREE_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9be4fd2db0f4..2bf1fadcb94e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -49,6 +49,7 @@
 #include "discard.h"
 #include "qgroup.h"
 #include "raid56.h"
+#include "extent-tree.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ed50e81174bf..ad50af497e59 100644
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
2.37.2


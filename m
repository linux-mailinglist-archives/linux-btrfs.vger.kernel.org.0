Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89A362FCC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiKRS3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 13:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242774AbiKRS3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 13:29:21 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89779A5DF
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 10:28:09 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1E98732004CE;
        Fri, 18 Nov 2022 13:28:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Nov 2022 13:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668796088; x=1668882488; bh=xW
        iDlbcpbtz3x0DRn/hrYEtnapPsnbPvl7Gf0p/tjA0=; b=BzM2uzUGSgzWcSWOY0
        vKNhYi28WObrjqy4KunXflhH6HNeSmeDyoNHUo2+a2IeXGRf2EYJNYNYk0D9Hlv5
        K4Rk/v47r8EBJNMiGOfcPTQV099GMO4qhauE+7jjpAsp+HKbao2GVTXGgcyUzJMQ
        9x+292AAQ18VhwLNti8wgxnFnHeLfpH1itpHBxoa6sVQUpSGcB8NZV0V4Q6INqWA
        vry/NQr3T6c7T6UQfv/bLHWa2ogHNVyBsZnZUWiSd3vn18TFgC3AN8yhzBQdmY++
        ASkeQv3bsngvnVSrsST1P9VwExAW7vdy2ItZbxZLInudj8cdzBWvEVR8CFXoUZ30
        k4aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668796088; x=1668882488; bh=xWiDlbcpbtz3x
        0DRn/hrYEtnapPsnbPvl7Gf0p/tjA0=; b=lNsr84zgkxlmt6tlneR4BRJ+8c6AB
        N0NUvnfPEqAPS+YLZ8To4bMt/FP7cux66O1RUE+61+2IBaBj69rGNTsKTPeExD9o
        HZpA0kXPmarAt3AyLO95z86BtrsDYyaG3PMxXdhpWLMMiUbDsM66J9h3i7oDPJsS
        4wwEUwJosfUsAtMj8kH8gx47jn5ul9srFD+bDvYJ6G/EbN1DbC5Hupk/lx7P6zSZ
        VH/Iql/zFcLW42eGV8BbpZT98KAYP4/6KvnN5rH3urrkeBNRIbM6e+5J2P6w7wjx
        6cLD+QiUkA4hgSFMwyPcFjsqjBeL08IafV6oKdBZPxuPqVxHBLt8AAg7Q==
X-ME-Sender: <xms:uM53YyFXiIrMYkDz5L1lko71WNvyc4CAk2AsdkkvJy-siyUXI9etqA>
    <xme:uM53YzXbtrJY-iUWiN3nQwp7E3cOvKX5PjPxhhujHVUEwdsT4Qevh0PVm7f-Z2pie
    QhWiLXOk1BOqZDkLys>
X-ME-Received: <xmr:uM53Y8JLCWMX8ScMjyxgyLurlhUySusvtLEG1exq7vcheJVeIS1ld7k6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:uM53Y8H5wNwsjw7Q1h7V7GztdYqFj_Tj59Hvw_83O4ybjvZKF-WHTw>
    <xmx:uM53Y4WBvTZs803G_Meq0ttITqhHPQqlzgIwyv6Dbj3JBUWNANsBZw>
    <xmx:uM53Y_M_kM4SMLonItSOTIASclVdxov5onQVOuf72YhfV3yHBw4Xpg>
    <xmx:uM53YxdflyNmmyqXAR8unqqKTUtR94sbVei89ZTz4_AiiJM6tY1YIQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 13:28:08 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/4] btrfs: add more ffe tracepoints
Date:   Fri, 18 Nov 2022 10:27:59 -0800
Message-Id: <1720f8a786a41791e512c0bf58c1c6da20cd3857.1668795992.git.boris@bur.io>
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

find_free_extent is a complicated function. It consists (at least) of:
- a hint that jumps into the middle of a for loop macro
- a middle loop trying every raid level
- an outer loop ascending through ffe loop levels
- complicated logic for skipping some of those ffe loop levels
- multiple underlying in-bg allocators (zoned, cluster, no cluster)

Which is all to say that more tracing is helpful for debugging its
behavior. Add two new tracepoints: at the entrance to the block_groups
loop (hit for every raid level and every ffe_ctl loop) and at the point
we seriously consider a block_group for allocation. This way we can see
the whole path through the algorithm, including hints, multiple loops,
etc.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c       |  4 ++
 fs/btrfs/extent-tree.h       |  3 ++
 include/trace/events/btrfs.h | 81 +++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a53f90677fbc..0eca8fe4604b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4258,6 +4258,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 							block_group->flags);
 				btrfs_lock_block_group(block_group,
 						       ffe_ctl->delalloc);
+				ffe_ctl->hinted = true;
 				goto have_block_group;
 			}
 		} else if (block_group) {
@@ -4265,6 +4266,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 	}
 search:
+	trace_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
 	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
 	    ffe_ctl->index == 0)
@@ -4274,6 +4276,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			    &space_info->block_groups[ffe_ctl->index], list) {
 		struct btrfs_block_group *bg_ret;
 
+		ffe_ctl->hinted = false;
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro)) {
 			if (ffe_ctl->for_treelog)
@@ -4315,6 +4318,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 have_block_group:
+		trace_find_free_extent_have_block_group(root, ffe_ctl, block_group);
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
 			ffe_ctl->have_caching_bg = true;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 64fa8ad7914a..daa5e3505886 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -76,6 +76,9 @@ struct find_free_extent_ctl {
 
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
+
+	/* Whether or not the allocator is currently following a hint */
+	bool hinted;
 };
 
 enum btrfs_inline_ref_type {
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 423baed891d8..1c02614cd98c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1268,6 +1268,79 @@ TRACE_EVENT(find_free_extent,
 				 BTRFS_GROUP_FLAGS))
 );
 
+TRACE_EVENT(find_free_extent_search_loop,
+
+	TP_PROTO(const struct btrfs_root *root,
+		 const struct find_free_extent_ctl *ffe_ctl),
+
+	TP_ARGS(root, ffe_ctl),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root_objectid		)
+		__field(	u64,	num_bytes		)
+		__field(	u64,	empty_size		)
+		__field(	u64,	flags			)
+		__field(	u64,	loop			)
+	),
+
+	TP_fast_assign_btrfs(root->fs_info,
+		__entry->root_objectid	= root->root_key.objectid;
+		__entry->num_bytes	= ffe_ctl->num_bytes;
+		__entry->empty_size	= ffe_ctl->empty_size;
+		__entry->flags		= ffe_ctl->flags;
+		__entry->loop		= ffe_ctl->loop;
+	),
+
+	TP_printk_btrfs("root=%llu(%s) len=%llu empty_size=%llu flags=%llu(%s) loop=%llu",
+		  show_root_type(__entry->root_objectid),
+		  __entry->num_bytes, __entry->empty_size, __entry->flags,
+		  __print_flags((unsigned long)__entry->flags, "|",
+				 BTRFS_GROUP_FLAGS),
+		  __entry->loop)
+);
+
+TRACE_EVENT(find_free_extent_have_block_group,
+
+	TP_PROTO(const struct btrfs_root *root,
+		 const struct find_free_extent_ctl *ffe_ctl,
+		 const struct btrfs_block_group *block_group),
+
+	TP_ARGS(root, ffe_ctl, block_group),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root_objectid		)
+		__field(	u64,	num_bytes		)
+		__field(	u64,	empty_size		)
+		__field(	u64,	flags			)
+		__field(	u64,	loop			)
+		__field(	bool,	hinted			)
+		__field(	u64,	bg_start		)
+		__field(	u64,	bg_flags		)
+	),
+
+	TP_fast_assign_btrfs(root->fs_info,
+		__entry->root_objectid	= root->root_key.objectid;
+		__entry->num_bytes	= ffe_ctl->num_bytes;
+		__entry->empty_size	= ffe_ctl->empty_size;
+		__entry->flags		= ffe_ctl->flags;
+		__entry->loop		= ffe_ctl->loop;
+		__entry->hinted		= ffe_ctl->hinted;
+		__entry->bg_start	= block_group->start;
+		__entry->bg_flags	= block_group->flags;
+	),
+
+	TP_printk_btrfs("root=%llu(%s) len=%llu empty_size=%llu flags=%llu(%s) "
+			"loop=%llu hinted=%d block_group=%llu bg_flags=%llu(%s)",
+		  show_root_type(__entry->root_objectid),
+		  __entry->num_bytes, __entry->empty_size, __entry->flags,
+		  __print_flags((unsigned long)__entry->flags, "|",
+				 BTRFS_GROUP_FLAGS),
+		  __entry->loop, __entry->hinted,
+		  __entry->bg_start, __entry->bg_flags,
+		  __print_flags((unsigned long)__entry->bg_flags, "|",
+				 BTRFS_GROUP_FLAGS))
+);
+
 DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 
 	TP_PROTO(const struct btrfs_block_group *block_group,
@@ -1280,6 +1353,8 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 		__field(	u64,	flags			)
 		__field(	u64,	start			)
 		__field(	u64,	len			)
+		__field(	u64,	loop			)
+		__field(	bool,	hinted			)
 	),
 
 	TP_fast_assign_btrfs(block_group->fs_info,
@@ -1287,15 +1362,17 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 		__entry->flags		= block_group->flags;
 		__entry->start		= ffe_ctl->search_start;
 		__entry->len		= ffe_ctl->num_bytes;
+		__entry->loop		= ffe_ctl->loop;
+		__entry->hinted		= ffe_ctl->hinted;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) block_group=%llu flags=%llu(%s) "
-		  "start=%llu len=%llu",
+			"start=%llu len=%llu loop=%llu hinted=%d",
 		  show_root_type(BTRFS_EXTENT_TREE_OBJECTID),
 		  __entry->bg_objectid,
 		  __entry->flags, __print_flags((unsigned long)__entry->flags,
 						"|", BTRFS_GROUP_FLAGS),
-		  __entry->start, __entry->len)
+		  __entry->start, __entry->len, __entry->loop, __entry->hinted)
 );
 
 DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent,
-- 
2.38.1


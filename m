Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A04F5F5ABC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJETte (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJETtb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 15:49:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED07F246
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 12:49:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DE505C00A3;
        Wed,  5 Oct 2022 15:49:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Oct 2022 15:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664999369; x=1665085769; bh=wa
        pGKDGJGFsFZz0rEaiFzOvxhiqBvhhrrrt3A4CXCzA=; b=IVJwrdff/dcbkM2hQG
        UBr3NDY6xW5hUG3BooDhTCtq0KTBL1gMr31KpxjNMAPa8a7TSVrwIauKLtBIWu0e
        82UIhgQ7f2JK8yWS3X/TmE73N9gwvz1PRtNjvvyW/nXAhizb+24FCXFiP74K7NOX
        NmJ7PExwHK+RrEJ4p/oR9eO4pcUsGDBIy41F/eNNgnCLExSt2boR1yPgFBH8VKlG
        6nDBjCxrQG4gs+jkBoFtFKewdmYFm/uUmtL3826GXyZdGpgpqcdZsFvnCPVB2RqL
        I0P/nUg+GTaTmc0cySFCdiA4rnBFlfDNiJDazmm8QqfwacJ2CprbXEWtkl2JtdxG
        jlFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664999369; x=1665085769; bh=wapGKDGJGFsFZ
        z0rEaiFzOvxhiqBvhhrrrt3A4CXCzA=; b=wgwHqU0FarP1DCEDumVaUvYCLCjQL
        AQSUl/UszDEhum9YctJVdIzzlaHy2wvVXNxp6nO0B6mhaX1Zm2isdEAj3egie5j0
        jBYHhcPk84wMBuEGuJ8EBgqrvDBc9DV7JBbzscU1J1RuG/vzLXp8EXvH/fBIWyyV
        uZ4m/xHeX9MRXLfUjQEHC5gq/tzTtY+1RLQqkM2D8C3sZygeVxdtgLs4VdAVeemA
        ATQ6tdTZOdudb7m4VccZpZdUjzo74F8GhT6VeBgkBCCwqCfd8Rf9wIv1UzXlLgEG
        HXa8nbh0cKM/Lp/LW7oImT5prpfwlJ+auvnhH5lmzOhU5bBypSw5jro7w==
X-ME-Sender: <xms:yd89YzeA3LTnLopTjI3EbstmRycrtg3lv3bykwW2CqZJCtCpCI1BHA>
    <xme:yd89Y5MdvknTXt8I60JP24iifyoas4xfB98CJoQuSYHl6_u6W5NpTUxQdKq1ySelS
    Tq2U-Mpvs7LuiICgpA>
X-ME-Received: <xmr:yd89Y8gBaemYg4nLon2mkWv6aUYmSTCRJ_HvhRdaj3AfZbmcZAX2HwmmrwtX4oWcB0pJ2DgGww2n_YamjZd8dzLZpJVYvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:yd89Y0_ekhIEvDeOB1Z54-vgV_Hnc1uasRm6lncua8-4japhYxEC8w>
    <xmx:yd89Y_tlW4vDpOOw_GD6aXldTuA5_QPzVbJybdWzWZ2i-oQRvBSVWA>
    <xmx:yd89YzGK1KEF_Kwwg0mqQYyFAJWl9RbToQ2xyyK6gT9gJyME2kw1dQ>
    <xmx:yd89Y92P2fCOnhLRWX5gGUxW7sPrLDOXGh6P59B_h1xxfLqXzMu17g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 15:49:28 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: add more ffe tracepoints
Date:   Wed,  5 Oct 2022 12:49:20 -0700
Message-Id: <068ceb5b24da5ef6b1b68afb210a2e294bb31e5b.1664999303.git.boris@bur.io>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-tree.c       |  4 ++
 fs/btrfs/extent-tree.h       |  3 ++
 include/trace/events/btrfs.h | 81 +++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0fe1e8eb10cf..069761529398 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4249,6 +4249,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 							block_group->flags);
 				btrfs_lock_block_group(block_group,
 						       ffe_ctl->delalloc);
+				ffe_ctl->hinted = true;
 				goto have_block_group;
 			}
 		} else if (block_group) {
@@ -4256,6 +4257,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 	}
 search:
+	trace_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
 	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
 	    ffe_ctl->index == 0)
@@ -4265,6 +4267,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			    &space_info->block_groups[ffe_ctl->index], list) {
 		struct btrfs_block_group *bg_ret;
 
+		ffe_ctl->hinted = false;
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro)) {
 			if (ffe_ctl->for_treelog)
@@ -4306,6 +4309,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 have_block_group:
+		trace_find_free_extent_have_block_group(root, ffe_ctl, block_group);
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
 			ffe_ctl->have_caching_bg = true;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 7d3bb9c60fbe..38bddb3ed224 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -75,6 +75,9 @@ struct find_free_extent_ctl {
 
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
+
+	/* Whether or not the allocator is currently following a hint */
+	bool hinted;
 };
 
 #endif /* BTRFS_EXTENT_TREE_H */
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ad50af497e59..caf0ce6ce718 100644
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
2.37.2


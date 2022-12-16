Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F064E4F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLPAGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLPAGm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 19:06:42 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69F5C0DD
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 16:06:41 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F76A5C0111;
        Thu, 15 Dec 2022 19:06:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Dec 2022 19:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671149200; x=1671235600; bh=d9
        NlOqYFJaTJ6Pas2An1IY+y1YcfhTo2GlniVvL85ms=; b=EP3hbiusxIDtYwydfF
        EEBz+d4vDf0+tcgopcx+FGAx8I649wP9bNCmS0Pwyf22pLYSCvhhzsCjk3nykYSg
        90eN/RZAlCq1Q2nlqZftoZBBtxiKDPsH+pLFCkKfpha1ry5zKM1mLY4Vojr54lAh
        R1hKx6EnjtUTXrPvONpSZi9S7eFlecqMzNayemxx4syXgre+ud3OP9Ep9MwlZtNW
        9A8xQa4SdDHHPPdq/eVIT5ZTeYopzV6KcV8Z8twdhFOxq4WXO3C4tb6dgDJR1cxT
        7oz0wF4SoUSky1Dhq9Oy7t1hm1wbwlrh7yBRoDUYe0wlc30FkJk2Dux5lpk4UDrj
        1agA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671149200; x=1671235600; bh=d9NlOqYFJaTJ6
        Pas2An1IY+y1YcfhTo2GlniVvL85ms=; b=YL0/OHekGolWh/HrFufsXLPNWpHzn
        Ipv6qjX/tjzVz8gvO2r+bBmK8Ob5e8vOj3NaiyAx8x7T8K4cwxiOzs25aKMvYS+W
        GEV5moTb78FY1XWaq/CvRBjgw8C4gEymesR3rUO2k9nGk2Pa9Smk6m9ZGJ3XbUVr
        dPKqz5vnK98HCTIwhBRAH7ckx0mHTSs+ZwaeBaVc+az57Cb4K2bmpl8SaQc12tyh
        AvtNYMJokq1JiNMRI+QkPtXj5rLltFKPEDwUofj2TVjiIHr00cPOmZMCv7feWwou
        SbcAmLfzL1dZ7jg+uMtTnmrbPJXnzLBtVW+aNso66rQYXdrjLB96jifpw==
X-ME-Sender: <xms:kLabY0U0BhixX5dd8ePHRzUTmKDE02ihuSJvNUMg-soep-O5Wj8wtQ>
    <xme:kLabY4lbLBucaGoQj2LrBjCQkj8Cabps-4XdGSK74eqJnLCFBrWTF4fT73qm4aGLT
    -b4MCBrgMZ_k6GLMGU>
X-ME-Received: <xmr:kLabY4ZnzJMnibGTitKwnCyAb-MoxC6c0o0AZjpzAhOl9xZVVQyqb21a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:kLabYzXkdXtQtvT3oH-wMavFuMxPwTCwkSup20J77y52_HD4GONUZw>
    <xmx:kLabY-mMWQ_Ic3jCb6mWs2obA2m7D3dIJq4ipc4mtegpC_YhMcmxTA>
    <xmx:kLabY4fxbHO-ACYZiM7Dq1z7-QjJEtZ1Eb1g3SYhbPdSxP5JpvPCLw>
    <xmx:kLabY1uvUFrqo91T7kHI9VUiAolWsIQAOCohXoF9Mwb3711MvWnW1g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 19:06:39 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 2/5] btrfs: add more ffe tracepoints
Date:   Thu, 15 Dec 2022 16:06:32 -0800
Message-Id: <d4b82e5541643119806b7ba565d47782d9bff0c1.1671149056.git.boris@bur.io>
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
index 3ef70c9bb124..4f5cbdfc0fe5 100644
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
index ce07d1db79b5..14a697bed422 100644
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
index 8a422e29d064..48cb0025313a 100644
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


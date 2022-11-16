Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6E62C8E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiKPTWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 14:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKPTWM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 14:22:12 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2385587
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 11:22:11 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1726A5C00C7;
        Wed, 16 Nov 2022 14:22:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 16 Nov 2022 14:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668626531; x=1668712931; bh=dn
        bEUXQnx+nELcL72EQ+mGfSB1cgXtnH+/ovI9jI/44=; b=cgjBjtp/yRv29UAatS
        uDoGWpCA0NfPFmV4em+39Ch+mxtdUlmnc3XhWXMQBSsYYpVIMpfYmUxFmBUjFa5Z
        bnxhETfb43dtdINfoM98kvAYkSRpkK+F4tdLBnjqNb7Tb9rDAz/njE+kzQuntuxK
        Zx2xRjpStQU2tDk2r3y0fDUfo+xN8yZManIYtwmzPhJFJOfJnyCVQN+fDpf2DSgC
        g59pcC6QCYN1YBADILNwyXXkoFl1+RAjEwl76ON1IKLIBpIAEDDYaf0e51x5mf+1
        GyWGIWZxLEBnhZbuksDEQkRcbPy56HXvsRkpZ/iGIFoRI4k1dztemjlCiBSXE9Gg
        hphw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668626531; x=1668712931; bh=dnbEUXQnx+nEL
        cL72EQ+mGfSB1cgXtnH+/ovI9jI/44=; b=exx7ARCNZfiFaw95Mfw/ZDGtEEncn
        9/ag0HjfVTczUPV9MiArpt2rP8bR4eKYgDIJ2LhNotanc/URI1mBT0NCdgtU0OCh
        mKvqSOhvUEg4mo3N2S6QN1fVi1vEt33SHyy8r+zyPb/g0NdQNeZqeE1BaSocjeL6
        nKF8eJSzRWLQv3E3pXs5bsJo2XWHxU+5bV+fq99yrnWDSpmgFCJ2gLR8FZ5VEAtE
        KTDopZ5mNZlfH643Dcp4zGO1Zmu/9e7BmdakB0VHpqskYDVgrGEfA+MEFHGNAjjk
        1BARpjCuFxD69OGpaDROS5p2JSh30/H1SpNSwxGdJfIA5i71hzTMuDuqQ==
X-ME-Sender: <xms:Yjh1YyW5QayzM1MNZmyw42TcLYwXGoPCSIomBHrqzQ3jW0cRaDuifg>
    <xme:Yjh1Y-kuZXDAR6zzokGSeYu7xrHlZfgMn3cDv2yrAuaSSjGbqMI_vE0Jhr_TvOgiL
    k0Z68flN-RDCjL_XYw>
X-ME-Received: <xmr:Yjh1Y2anZgfn4M0j_WK_zRlWNYfPFv6Gif4-T545Rh4wymo9s5elBCed>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeigdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Yjh1Y5VWBmzdRVgbQMOQPkwLXziRLdgSM5A-yDCLP6-HX-03pOmWEg>
    <xmx:Yjh1Y8l_HPR9yOxQp7lS43SjiR4BPrfsEYhpOqEK2FtSgzoO6X9AGA>
    <xmx:Yjh1Y-eaIycB7V2Yy-RFBpZjlyDIOnT0qg0YJy-zen-284XDG0kcuQ>
    <xmx:Yzh1YzsLP2peSCt72EzriscNbJjNvNDuTDkRpu5aEDfDkdhegdgTOA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 14:22:10 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/4] btrfs: add more ffe tracepoints
Date:   Wed, 16 Nov 2022 11:22:03 -0800
Message-Id: <6663e2f60698f2cb42106b97aa83cfd2a88682f8.1668626092.git.boris@bur.io>
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
index defef7caddbb..aeda5d8f6068 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4256,6 +4256,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 							block_group->flags);
 				btrfs_lock_block_group(block_group,
 						       ffe_ctl->delalloc);
+				ffe_ctl->hinted = true;
 				goto have_block_group;
 			}
 		} else if (block_group) {
@@ -4263,6 +4264,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 	}
 search:
+	trace_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
 	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
 	    ffe_ctl->index == 0)
@@ -4272,6 +4274,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			    &space_info->block_groups[ffe_ctl->index], list) {
 		struct btrfs_block_group *bg_ret;
 
+		ffe_ctl->hinted = false;
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro)) {
 			if (ffe_ctl->for_treelog)
@@ -4313,6 +4316,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 have_block_group:
+		trace_find_free_extent_have_block_group(root, ffe_ctl, block_group);
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
 			ffe_ctl->have_caching_bg = true;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index f1085226d785..a19e83c2d00a 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -75,6 +75,9 @@ struct find_free_extent_ctl {
 
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
+
+	/* Whether or not the allocator is currently following a hint */
+	bool hinted;
 };
 
 
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


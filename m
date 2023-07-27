Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491A765F17
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjG0WPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjG0WP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:15:29 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97ED13E
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:15:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F2C423200319;
        Thu, 27 Jul 2023 18:15:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 27 Jul 2023 18:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690496127; x=
        1690582527; bh=JMSz53CxljA4xKvs9rDR+UIeuGIWaMFbjmmFYeLAgZ8=; b=V
        HG6jtlX9g1R6DRayXX9OPKPX9y+NnjVHFQxiRfntxNcUY03NWkacBBMnJ45ZHZOU
        0D92L0OS1Oin8XdJH51O8zyi/8Eht9CD2diRgqsfO5HGLxeAt222w5ea4davqpeA
        J65g72S8rGC5vXpFYi1Y6hhc6x9murNQ1qmiosthyQm951sIZs7Ora2vTrDTsDwF
        GyjACwcskcSqpw8r1dxbEMgQS/HWOKsFBi7qc0NJr8b8gctP/wIlT6TrtZfSDeSQ
        l8B50K+7cYjDncsEo+opTVd+7/52F0JrQMZyH2hzI5xcbNjKfnckrDZuGvdHHF1k
        +CuxJN+8YRg5nPz53/W7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690496127; x=1690582527; bh=J
        MSz53CxljA4xKvs9rDR+UIeuGIWaMFbjmmFYeLAgZ8=; b=naBgDg5QTK8H7XW52
        Xd1TIZLW3/1OqrcinwziXtirILe7jjYbodytCO1DHxWMg4aKSH4JCH8rnA6bV5ps
        N56VralC1tPPDa15Tir4Af97lPFIYdtSilv4WkiazGcl7fJSrvv7n8b9gbxn3e9Z
        bPa+8Dqgm16QDpG7SAuCOP7cC/cZPMJxsBO2lBZNWQ/Yr2WvVV+VNvQwc6cMWOdJ
        sltsZKu3Y9FXB2p1fwYg2w9zVaRRbwiYkwC2gU/0C5oLxLvqfMY5CRy/sG+Q7kHC
        BgzHek2kCQOrsefh8ArYYfpEetT/LSXHAVWHsCEJ1p5sDEQeDyqXeHh6fn9jjhFz
        2qvhg==
X-ME-Sender: <xms:f-zCZC_6Q2wzv8erH9zvcoV-wC7UzWFmnjkW4zligNKoydVNyzqUmQ>
    <xme:f-zCZCvcAdmpm5XMzDjgAOw2f2sbx62y6D4H5tUX2js93FQeoBeDFRxeTyk_lEE6a
    Rj0qSO9uAGrKNRitd0>
X-ME-Received: <xmr:f-zCZIC4nUpz-rV9OA0FUUHVM04p_onYuYaYP3SAu07xPlbs7z4qM3CYy6TgZapeEDHjna44nfmgSDC9-xKJr61vG-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:f-zCZKf6zdO0POoLq9_BV0eqoaVJOwBNAW4lbgyJPl0r8BcrRG-sGQ>
    <xmx:f-zCZHOHHV7Cg2ZwqYMQkTpe21uwXHwPx2C2UihK46VpqcrVzsqfUw>
    <xmx:f-zCZEmaLrPWR5szx5RbjLqqAkLU9CCjVECK2-GBM-ZLf7NF8vaNRg>
    <xmx:f-zCZJVluea31bz2jRrFgea9RRDQd5xoWs8FkjdMHNmsLl2PppymyA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 18:15:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 10/18] btrfs: track original extent owner in head_ref
Date:   Thu, 27 Jul 2023 15:12:57 -0700
Message-ID: <1e87e9b6be869c41c9f4f8faab803c9391b5502e.1690495785.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690495785.git.boris@bur.io>
References: <cover.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simple quotas requires tracking the original creating root of any given
extent. This gets complicated when multiple subvolumes create
overlapping/contradictory refs in the same transaction. For example,
due to modifying or deleting an extent while also snapshotting it.

To resolve this in a general way, take advantage of the fact that we are
essentially already tracking this for handling releasing reservations.
The head ref coalesces the various refs and uses must_insert_reserved to
check if it needs to create an extent/free reservation. Store the ref
that set must_insert_reserved as the owning ref on the head ref.

Note that this can result in writing an extent for the very first time
with an owner different from its only ref, but it will look the same as
if you first created it with the original owning ref, then added the
other ref, then removed the owning ref.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-ref.c | 20 ++++++++++++++++----
 fs/btrfs/delayed-ref.h |  7 +++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f0bae1e1c455..28ba7a9eb3c3 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -623,6 +623,16 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	BUG_ON(existing->is_data != update->is_data);
 
 	spin_lock(&existing->lock);
+
+	/*
+	 * When freeing an extent, we may not know the owning root
+	 * when we first create the head_ref. However, some deref before the
+	 * last deref will know it, so we just need to update the head_ref
+	 * accordingly
+	 */
+	if (!existing->owning_root)
+		existing->owning_root = update->owning_root;
+
 	if (update->must_insert_reserved) {
 		/* if the extent was freed and then
 		 * reallocated before the delayed ref
@@ -632,6 +642,7 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 		 * Set it again here
 		 */
 		existing->must_insert_reserved = update->must_insert_reserved;
+		existing->owning_root = update->owning_root;
 
 		/*
 		 * update the num_bytes so we make sure the accounting
@@ -694,7 +705,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 				  struct btrfs_qgroup_extent_record *qrecord,
 				  u64 bytenr, u64 num_bytes, u64 ref_root,
 				  u64 reserved, int action, bool is_data,
-				  bool is_system)
+				  bool is_system, u64 owning_root)
 {
 	int count_mod = 1;
 	bool must_insert_reserved = false;
@@ -735,6 +746,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
 	head_ref->must_insert_reserved = must_insert_reserved;
+	head_ref->owning_root = owning_root;
 	head_ref->is_data = is_data;
 	head_ref->is_system = is_system;
 	head_ref->ref_tree = RB_ROOT_CACHED;
@@ -922,7 +934,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
 			      generic_ref->tree_ref.ref_root, 0, action,
-			      false, is_system);
+			      false, is_system, generic_ref->owning_root);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1014,7 +1026,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	}
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
-			      reserved, action, true, false);
+			      reserved, action, true, false, generic_ref->owning_root);
 	head_ref->extent_op = NULL;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1060,7 +1072,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
-			      BTRFS_UPDATE_DELAYED_HEAD, false, false);
+			      BTRFS_UPDATE_DELAYED_HEAD, false, false, 0);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 0729850a9193..71f0a6e5d583 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -117,6 +117,13 @@ struct btrfs_delayed_ref_head {
 	 * the free has happened.
 	 */
 	bool must_insert_reserved;
+
+	/*
+	 * The root which triggered the allocation when
+	 * must_insert_reserved is true
+	 */
+	u64 owning_root;
+
 	bool is_data;
 	bool is_system;
 	bool processing;
-- 
2.41.0


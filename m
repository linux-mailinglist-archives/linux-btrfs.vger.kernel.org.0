Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC34C7491CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGEXXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjGEXXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24A1995
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 275D85C0283;
        Wed,  5 Jul 2023 19:23:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599402; x=
        1688685802; bh=+4u02dRquDZRbDAXWJOGiTdYcK26uXD+Fleby38+UAo=; b=C
        n3BdY/0bXsH1MGABYD2GVAie6N6wM0CHg20MKoEK7rQWk2uGSIhKZXe3YQhptScr
        qbKIwaxUchVFF9UhJ9R80VCvrWM2USs2uXpkV23WXOfj7SfanYDXGLCNYe5zEyWx
        CijSSH3iHWOrwpRK8sc+owL06QqVUq9zw0ohA1AIDl9U5lQWlzL0OQmLEq5+I5Et
        ZWyqCL969PNFu5x3jO0qGMbwdcC4KXrol2+8PAz9ANZyw+e6SzLjan+U6VFzYWyt
        wtrH1Mi1hgDQ1RXuZtNxcuj51pf+62j726ooLM8cYgjBVwFoE72yyBY2h9uRPYL5
        JK7aZsgt2oizCvb6U745w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599402; x=1688685802; bh=+
        4u02dRquDZRbDAXWJOGiTdYcK26uXD+Fleby38+UAo=; b=h3+GhIQkbilDrDf/w
        8BVwy82Qo3nYWthiRJ/lyrUjtHQVm6+/EXhRD5qqh/n8xPrmiZwvRJaKXtd03+O3
        NUa4N1eksQndmpVGZ6trX186vSJ3kJV9eVthzG/gPCeAOe0albd98bfguhgF0B9p
        2uT8kMjVE2uV77W76IVCqhydp9hdajm5Ch1awUwf9GePv0Ag5o2lCsFThNlUHbh9
        9G3GJZhKCjiLXNmjVW5RTRo457BOGyPO5PNJVHhIShRmQNL54bnCPT15rlOOD6Mh
        ZTpcs9Lh4hlMtlJA3M7LOnISSiL0eWqC0KWEAZhsg3KMJ5SZifeIlhwgB/Aezcl7
        XYCNA==
X-ME-Sender: <xms:afulZG3Ho6849rMpmPjknPCWVem6CuGCLJU-RKraSoepD-51rrre8A>
    <xme:afulZJHzWZSw4h7ZJwKiTH9MEBMJtDJzCCjkA70dteTPVUpFbm1oHkXDp5NBOQFz4
    nwX-0nd8nmbMthLoq8>
X-ME-Received: <xmr:afulZO5SLTqp7w9LKLU7IIFrSYp5F8HSlLYRgKgwysvApb5VBK4Xno2LmORbYD-LMqvEJsekwmBI08cujO2erysxERg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:avulZH2PGZpOJcfBbEYQMY7G2kI66SQzENgRfzbkAyeDIHc1aGggkg>
    <xmx:avulZJEqTH3x4Q-JHSfLC-gLpO39qtlBKs5xux3whQeBbsEW3VIRFA>
    <xmx:avulZA8CP0RsJRYX1otj8L_2aD2sFBUEhAR_QAr4b0x7Qxr08m1UNQ>
    <xmx:avulZMOfDJ0uNFKpHeAzVUsdhIO5siRQFrcRo8mXGTqW_pK0KmgfUQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:21 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/18] btrfs: track original extent owner in head_ref
Date:   Wed,  5 Jul 2023 16:20:48 -0700
Message-ID: <3ab4ae0d6690a8d69cee48e107ee87102ce5f070.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/btrfs/delayed-ref.c | 10 ++++++----
 fs/btrfs/delayed-ref.h |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 49c320f2334b..89641bcd6841 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -632,6 +632,7 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 		 * Set it again here
 		 */
 		existing->must_insert_reserved = update->must_insert_reserved;
+		existing->owning_root = update->owning_root;
 
 		/*
 		 * update the num_bytes so we make sure the accounting
@@ -694,7 +695,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 				  struct btrfs_qgroup_extent_record *qrecord,
 				  u64 bytenr, u64 num_bytes, u64 ref_root,
 				  u64 reserved, int action, bool is_data,
-				  bool is_system)
+				  bool is_system, u64 owning_root)
 {
 	int count_mod = 1;
 	bool must_insert_reserved = false;
@@ -735,6 +736,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
 	head_ref->must_insert_reserved = must_insert_reserved;
+	head_ref->owning_root = owning_root;
 	head_ref->is_data = is_data;
 	head_ref->is_system = is_system;
 	head_ref->ref_tree = RB_ROOT_CACHED;
@@ -923,7 +925,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
 			      generic_ref->tree_ref.ref_root, 0, action,
-			      false, is_system);
+			      false, is_system, generic_ref->owning_root);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1015,7 +1017,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	}
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
-			      reserved, action, true, false);
+			      reserved, action, true, false, generic_ref->owning_root);
 	head_ref->extent_op = NULL;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1061,7 +1063,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
-			      BTRFS_UPDATE_DELAYED_HEAD, false, false);
+			      BTRFS_UPDATE_DELAYED_HEAD, false, false, 0);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 336c33c28191..0af3b7395aba 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -123,6 +123,13 @@ struct btrfs_delayed_ref_head {
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


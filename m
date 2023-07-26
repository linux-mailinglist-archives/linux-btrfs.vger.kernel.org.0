Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA07640AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGZUlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGZUlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 16:41:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42426EC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 13:41:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F3CE5C00DD;
        Wed, 26 Jul 2023 16:41:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 16:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1690404060; x=
        1690490460; bh=tVW77rt0DNjfTC1JZhpK72ZOg7v4WfSq0mHPDLhdIEc=; b=b
        kqx5z4m347rj+iMSO3pf3/C/0wqfAvWmjhlzuDt+mgqtuh0e/mTgfpuj/sthepPA
        Q9+idgezjXa4yY0VuJZ+0ZqXaUQeRIkij4j33fJiGoSEg9sGr/PjuiQg0kgo0Vvf
        QLvcoctp5c+5wo7k/wManyd3aru02A1J+sfo8w1mx3sPTXjy/9mTijCVY+aiYdmU
        81O2hYtMtjDx6OBnfggmRbACwjjafOFL/1INW/31y1IxgAHHNWIc35HI+BXfhugo
        7JB69enMZI1UK8HNK3xZ9mlAHr4GkYeU8K5ZRnauTFKWcxq7yHTCb1SkDp39lBV6
        P7llyQijeBo2p3ewJ/IIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1690404060; x=1690490460; bh=t
        VW77rt0DNjfTC1JZhpK72ZOg7v4WfSq0mHPDLhdIEc=; b=rZPd80el3N895qWkc
        Hve6st6D1bJndoec+OhE2bWhJBWdwUyqJZEHkLvG652I2bYEnLToFP1Cg5JLkdbL
        ejGPssxKEHhWXbrh/Mg2rpjuABRIj2cEPy4kFrmNRH5qfDsliKBzAXyZNFwhc8bl
        WpXbZs5NyiszNBNKFri3U9gkVa/Kz+D+s6uw2NjJdMor9A9ckmDdukHhv2h0ZDC+
        DVxyaWCXyPSK5mzbOQcbvPc0B2k89Fte/TOtQeUTizc9hYCMSsZmzuuvW5zXT+DZ
        NuNTRt0Gm/R10eyUpfohgZcEKvdZyUMuUs0gX3FAyDQzxtcCrdaMoGQ6Lp0pG8N7
        V2gkQ==
X-ME-Sender: <xms:3ITBZEMvbfYvyZEXV2SOWOS9x8zZO6TLZqZlljuzjZyULKYuBWZD2g>
    <xme:3ITBZK9trfi8S5ImjmBar5nBtOUS6Fhuc2F8ppx_C8SF7RigHON4cz_tvyIJR5NyY
    8bIhihdY1mei2MRIwY>
X-ME-Received: <xmr:3ITBZLRFF4ncqmGB7RpAUO_cJIgmoTPie17bnDRBfzRA_zw50to7nYeNHNEBkJ3oOtogVwil9gkZtfLczd7lvMDOQWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:3ITBZMvRW-anxrQUxtnPKzOo-QEMnB8RYrTKDno17HprfHY6WTU3qQ>
    <xmx:3ITBZMd5_ECbdTV1CYc2kODxQVPxIdZdc5zBkxehbgIl03L2HR9rVA>
    <xmx:3ITBZA1AQ9fYuqu1MAApUEJosRIS7erOlIVK1cdl8w_o0r2aKzuhXg>
    <xmx:3ITBZEnlmyf6G4F4X5COkeRm6Neh_63nqIubwYKGBrIduPGKdkeN4Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 16:40:59 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 10/18] btrfs: track original extent owner in head_ref
Date:   Wed, 26 Jul 2023 13:38:37 -0700
Message-ID: <8aa451837a4813f621c1698171a93f504f3c796e.1690403768.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690403768.git.boris@bur.io>
References: <cover.1690403768.git.boris@bur.io>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3178775BAD9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGTWzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjGTWzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077D2D51
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A0B15C00EA;
        Thu, 20 Jul 2023 18:54:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Jul 2023 18:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893686; x=
        1689980086; bh=tVW77rt0DNjfTC1JZhpK72ZOg7v4WfSq0mHPDLhdIEc=; b=T
        Z65FxuJFaHY26NCJZBwk6A3W9mQOWjkR4JtUVur06r/LE5CVJZ3PDlixKq8o13xl
        qpoM97azNYvdc8N1sFfAmvODSnezM0bCaPIWPReTXUBCyj7L8k8F6ylpGOZuclKe
        U1AJPEyE7tWB12f4/Tsb5NBMGCEuJ499sodGU5gvL5WmuiyYJw8ipqEzhqB+hoNy
        oIvX30YsScaR3uR0wEKTRyPnYc/yzjkMq47+imep+hzgvHxWxI/M0FCGizPfoOVd
        w5oFQ1CljD7GMJaG4tVL/TkWMpZl5s5TMMSdYVn51wsqyyj9Ya7Iy6vmu2qe/CDH
        ayurhBgTzTTsv7vhIc4jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893686; x=1689980086; bh=t
        VW77rt0DNjfTC1JZhpK72ZOg7v4WfSq0mHPDLhdIEc=; b=1c5YjeoFYxNbJz2zX
        GicwAFELQYk+AoWTMTGpk1ITF2wnPzN3eWt4BZQZfDy+xMKgjrjNtwBYtoDBlM5a
        SSJtsiJfy/QRL1cxn2mhRiOnH/6PWtxRASyUdHTcqLj4pX91c6V6lSWL2MzcEicb
        xH0oIB/7Li3ZeKxiV43cNX2W9JiMc5q7745h7qt5TcXWPuIXYi6e2VgdKM6LhEL4
        7qWT5VlqhIMmqOeI02dRvMs2w0IXjLBeJaMFCzVDt5gStpEmpetp4F7A8WnaK73u
        rWIOByNPFmePXctTw1XyX2y862YVbalUEvcTrUestFhhnZdFgZge/sjTxKEuAG/7
        y/Dpw==
X-ME-Sender: <xms:Nru5ZJNngnEZQD5lDO8bVpYckm05D9G7mGI995PrZx4vFkZQYD8kAg>
    <xme:Nru5ZL9HDrvRpFoO3QBAdAY63II4wDNJkSPCYQBKmfB1psY-aBqnGAzlCphGrpKfr
    rdqgFzGPvxyYBo1Cx8>
X-ME-Received: <xmr:Nru5ZIR-_jZt21fXBUc3ItAOVhdS0tR2PaHM-6ujeIuW1hw5JprN7YNqRnfGqiIV0zgnz6CIJ4PzZkGyLHDduuimHrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Nru5ZFvimW52QszPiSffGGl1wP3CLJt71HqnJ5fTvWAceOZIJr8j4w>
    <xmx:Nru5ZBfnCislnVKKOAZm2rLet5IO0Rb56r41vr_nRHHrbT-o8yRBCg>
    <xmx:Nru5ZB2rXZuDjYoGnU9sX-k5WeDk55XWixcuhZT1GE8vXDonNibtzg>
    <xmx:Nru5ZBlow5TZdzcoLNtCBt6xWbMlWh2_Zczg5AvfSejBnsfTTmbSWg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/20] btrfs: track original extent owner in head_ref
Date:   Thu, 20 Jul 2023 15:52:40 -0700
Message-ID: <f654eedc281c5c258f6b15a980edccc54c9d7065.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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


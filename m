Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3D75CD13
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjGUQEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjGUQEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:38 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB32D51
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8C42C32009AB;
        Fri, 21 Jul 2023 12:04:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 12:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955475; x=
        1690041875; bh=tVW77rt0DNjfTC1JZhpK72ZOg7v4WfSq0mHPDLhdIEc=; b=G
        cw3fjeQb9Eo8qu0DbJa6rY+0pdR39g0k7PKAH6tdX1BP0AMTmBI9SfrNbLIO+Uf7
        A/dxEg952FfWvjHzssEvlVIVRX+oAk1eXYp50gFOsrBuiJ1mgmtlLTWRDmK69BDt
        3AKFPtOghQcg6SDWAjTvCs5w7tfJh6desQJJpVY8tBFcdRbVseM6T1kWnkEPmK/D
        Xwl4Q8tkofnHuYfrdnZA+/V9m8kSFF8DlNwGnmBT9qASFZ3eysGzumYCgL7H2kh0
        hfnsmswIRaqcmsLFCmRdQPy9873eWjNXccyc9C+R7hbPmwfLevN1Mp2cI/CEyYfx
        0dgJ5Nr3M5ziBtnm7LTOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955475; x=1690041875; bh=t
        VW77rt0DNjfTC1JZhpK72ZOg7v4WfSq0mHPDLhdIEc=; b=r0a/XXgdfzWWO5L9X
        7RlGxz6i+eFlvIoragFCC53wUkRvrTKD5ZWEYJ3PUbQYb6yoc647yKgnL3vUrcdH
        kwIhDF06jl52N1jc5SID63xGQzsRw6vnsOouHYWkaYXRVFTAEsoj6MVZItSiQeuV
        1AlbGXJpErPVrpjy7M/X2u8JsVhhqPS0dNlK6Zd+AufNjBS94h8LqLLP5uUxfCAL
        Xlq7b7lFKJMveYmomlOy6SYbZtIVKQtyOXEingL99TwnbEJQJNAep5XfXwkWIaO/
        jBRoVri/QIGNd+cQ5IyBgK2HL7wfbZ2Y/UONZM2TVw6BSE83uC30WYvIrPDUX7rD
        aOzfw==
X-ME-Sender: <xms:kqy6ZLrIc-OXJyNukh7BsCRhtAVxE2YtTY_kkzouOA3CSppp86ii5Q>
    <xme:kqy6ZFqvEX7-SKuLzTARhoLuMm9stml6KKZCzNfcqcqxxuh3-oWR29U8KoBpjZEmS
    s5MmKRL04ngIFeqOnc>
X-ME-Received: <xmr:kqy6ZIPdajsjfrAFOmhx03blE1nIUc4JRsO9tggXZqYF5x1eqpnGbDFNfZ9Xm_gpcWgCQy4-wu2YVrdxNFNx5CrjdaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:kqy6ZO5uK2N-Uu6B969wv_07WKOnlnEUZvwB82ZmjVeoWZLLj7i4PQ>
    <xmx:kqy6ZK7T0yKrPNsS0bUG-Zwv5Ggpb3gI3V_zcbUsB4wq8xKuViS-Gw>
    <xmx:kqy6ZGgRrq1_ryTRk2zjg5TZ0UFpBXIwyMGGZUeLmW2G9jnWSmDiuA>
    <xmx:k6y6ZPgHl5FuqP6-GzRTF2nk0oGsPsxyL3Yr2g_MI2oMEDZXc2NTLQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:34 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 12/20] btrfs: track original extent owner in head_ref
Date:   Fri, 21 Jul 2023 09:02:17 -0700
Message-ID: <f654eedc281c5c258f6b15a980edccc54c9d7065.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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


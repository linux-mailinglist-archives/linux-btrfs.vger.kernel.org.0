Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478CE79DD0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbjIMANP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbjIMANN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:13:13 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834D10F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:13:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0B907320093C;
        Tue, 12 Sep 2023 20:13:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Sep 2023 20:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694563988; x=
        1694650388; bh=SGEDFssxFE2fKFxdbDm9hL15NcHIRG/cKEcaI3dyB3k=; b=o
        PBrWEoMWqy/DQwlRsWwlLL1TAqG9SQpGGweyL0qqUV3umaX1gTUg8uJCBLGUgJ8y
        PHEeKFtElSQJCRy4tPArmonzJwkZdxeSi/kSgunyx/y3q9IGelbLfJVXBH2iyR43
        Kmcf7xqCNXQTpfQLBEj33lpgV33v3xtxLTttqSPfELHnEg0Ybs348tLtxZAeDA83
        XDaEgvM6H/zlnM8jfpGo/irVhazyCeV0bXRKhraXAyjO/Cz1JPVreUurklS6A1Li
        l4WtV4Obp+tgg6pZMNG26qJCCk8RDmA51IGaDL0D7zi4BmDbmg8TT80QRiV25LWc
        WbDzKzeJXyb4N+PCH3qrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694563988; x=1694650388; bh=S
        GEDFssxFE2fKFxdbDm9hL15NcHIRG/cKEcaI3dyB3k=; b=QX+s+WKmHV8nxV1ba
        2B7VchtJxdleX9GMQmPN/tUhezGbQBhEIowestemyhL5CVQ0fJPoVlud9na4A7Jl
        oDxr5eCRKdnm71n31xt6OgyLyd7nq9dX8rp0dZb8dDhutoautCuTlypB9SnmUCqb
        xWPJSUp1smvUeNio0k2+NTex1EUN2O95ocnH5QQ79hPFbrWbFYlDmJ7rPgG3IDCF
        /K3rINczKoNdqAWuEb/Auk/0p/2FxPBn9VAtbdxcxDpvYH9awiwQw+Xy5WlLrelu
        3riN2ztVlS/7j3saDeseni3i/s6vOddMRdssprcrCDSiRAkWkldAOYlwAjpEtaD3
        208Jg==
X-ME-Sender: <xms:lP4AZVWL3GlDMxnsidyWoS3wmBInfgVzbYYV1z57SDNe4TsTSIC-Bg>
    <xme:lP4AZVnNZ6iMvZ84Qp9dCj6hJZHk8SiSk0yKkE-1PVXW8REF9ZfkJ7cePWTpI7DOM
    1zhLWz6QUiEDjoa22M>
X-ME-Received: <xmr:lP4AZRa9HGoOHPkf9xwrP8vIua-hc87Ipz8Hsm1_63i6b0cIr7r0RSh-Qo_juSg2wlsc0IY_IgdAHhgXoLMm5LXWCYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:lP4AZYWySamdPeeCiIyVpbHo0mg1FjDYAm1IzU80i3VWp8SudQMKJA>
    <xmx:lP4AZflEpG_vVSo4Am1han3BNNAwXowLp7YLE4E2MaLzo_DqP948eA>
    <xmx:lP4AZVewWyMx78ywKK0KYL5LnxsP2H46FtbX6p6bXun_O30YYXAd3w>
    <xmx:lP4AZesmoK10HUvytNmcML-5D7cR_JbaQiCnXeEGZpzZjNIqX0z7dQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:13:08 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 10/18] btrfs: track original extent owner in head_ref
Date:   Tue, 12 Sep 2023 17:13:21 -0700
Message-ID: <c3b497f7c310f860471067c9c79c870b7376a88a.1694563454.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694563454.git.boris@bur.io>
References: <cover.1694563454.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 9d6a5dafd9b8..b8ae48e8a63b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -678,6 +678,16 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	BUG_ON(existing->is_data != update->is_data);
 
 	spin_lock(&existing->lock);
+
+	/*
+	 * When freeing an extent, we may not know the owning root
+	 * when we first create the head_ref. However, some deref before the
+	 * last deref will know it, so we just need to update the head_ref
+	 * accordingly.
+	 */
+	if (!existing->owning_root)
+		existing->owning_root = update->owning_root;
+
 	if (update->must_insert_reserved) {
 		/* if the extent was freed and then
 		 * reallocated before the delayed ref
@@ -687,6 +697,7 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 		 * Set it again here
 		 */
 		existing->must_insert_reserved = update->must_insert_reserved;
+		existing->owning_root = update->owning_root;
 
 		/*
 		 * update the num_bytes so we make sure the accounting
@@ -751,7 +762,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 				  struct btrfs_qgroup_extent_record *qrecord,
 				  u64 bytenr, u64 num_bytes, u64 ref_root,
 				  u64 reserved, int action, bool is_data,
-				  bool is_system)
+				  bool is_system, u64 owning_root)
 {
 	int count_mod = 1;
 	bool must_insert_reserved = false;
@@ -792,6 +803,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->num_bytes = num_bytes;
 	head_ref->ref_mod = count_mod;
 	head_ref->must_insert_reserved = must_insert_reserved;
+	head_ref->owning_root = owning_root;
 	head_ref->is_data = is_data;
 	head_ref->is_system = is_system;
 	head_ref->ref_tree = RB_ROOT_CACHED;
@@ -982,7 +994,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
 			      generic_ref->tree_ref.ref_root, 0, action,
-			      false, is_system);
+			      false, is_system, generic_ref->owning_root);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1073,7 +1085,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	}
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
-			      reserved, action, true, false);
+			      reserved, action, true, false, generic_ref->owning_root);
 	head_ref->extent_op = NULL;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1119,7 +1131,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
-			      BTRFS_UPDATE_DELAYED_HEAD, false, false);
+			      BTRFS_UPDATE_DELAYED_HEAD, false, false, 0);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 2c384862110e..faa2e000dadc 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -110,6 +110,12 @@ struct btrfs_delayed_ref_head {
 	 */
 	int ref_mod;
 
+	/*
+	 * The root that triggered the allocation when must_insert_reserved is
+	 * set to true.
+	 */
+	u64 owning_root;
+
 	/*
 	 * when a new extent is allocated, it is just reserved in memory
 	 * The actual extent isn't inserted into the extent allocation tree
@@ -123,6 +129,7 @@ struct btrfs_delayed_ref_head {
 	 * the free has happened.
 	 */
 	bool must_insert_reserved;
+
 	bool is_data;
 	bool is_system;
 	bool processing;
-- 
2.41.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FEE7491EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGEXhj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEXhi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1912A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E1295C011C;
        Wed,  5 Jul 2023 19:37:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Jul 2023 19:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600256; x=
        1688686656; bh=8fhQPx6Zr9cmHuSArlpJxpXZUEBA4e9EbrP07W05rMg=; b=J
        BiYNM/VRPlENob2tz+ih7Ae3N0FizM8ukFV4tbWCqT425+yInYhCYScTYgxmNR2I
        ZqX2bDpeslRx/QwR6PV8KbcrIxdYNiRFPxBfArTRjbMi0ZoCctFvPrqFzm39Z57z
        Kj4VNlCLBlsHfctPAvR1n3onZVnIZ4A56VXyXgaKB+bI7b0U5X+00OfgvJtcUhy+
        o8s84znzkbTyX3eTFP1hCOUL6Zyyk3exirvIwnFSJKCIuT4yjTJ6PJzsT8HOj35u
        9RoALYBW/SW8pRkE0r8ncOPvHkJXHaXpc7zLC8N7l9Uv5L3JGkUHTTBKu4BDkbr+
        a0t+jJkxUE3C0ILykSPdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600256; x=1688686656; bh=8
        fhQPx6Zr9cmHuSArlpJxpXZUEBA4e9EbrP07W05rMg=; b=TsQljGmcskg/w44Lr
        bPkRVDaZVroL16rIPOpkq8BqFKB77ZQIlFb6VgPeEmC/WzvETvhzTeF6lEtEL/7T
        lefQ5hgkheF7yzfZrVO8QlUt/7QH9bbVeBSc0mXSPVUXbNDHWNGbP51RPkES5UDv
        Ur9yw3eSFFFxq+kkb/xL0b9yQj+DLN8Hfcsr/GJZaPwSfQbiiIZOYevzCRpTxtcq
        Ffnd3xhFdDOzMswt4+SG3HxOKcvwgM7lA6fPfR5KmZ6DC7kcwrRNE8R05AbbEH3h
        JHxJ51MWPZCfCN+Ocx9GujU9cgHRNafguxzVKH/zB6Af3Cqqm349abkosItGkLiF
        hBD5Q==
X-ME-Sender: <xms:wP6lZDzqCgGxpLfNda2b9tyKxBfoNhBedEmn_k3mT-3FhzakhADx1g>
    <xme:wP6lZLS_XX-AMGTtDf3HsAIuu5KponsnlpDDsHky8xqEsl3VcN1rNORU9dby-GQ5Z
    q9w2x010sJBNtX2Ck4>
X-ME-Received: <xmr:wP6lZNWvdj7K0XT0j8Q9MchtAeCbiTXHHgpQJFhtxCpZAGAFgCFniOITztaJidYH2-eAx8uLaj0AFM7j_jsYZt3cf1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:wP6lZNinwU1LbZsgZtdstlxb-TNnJP5H3PJV6h2Bi3vKI2ZtUOUjoQ>
    <xmx:wP6lZFBLpF9ZKQ9S0tSyP-si4IuaAot6Wy9tyeMYxkSifCjKusSW1w>
    <xmx:wP6lZGKNRKPntrAT1W4HPrZngoagG5ZhZjlHKLg63fA2B-pVJqXcVQ>
    <xmx:wP6lZIoSmKEArA1epJLxYD04Q4JOIdXWk6QWe8DUyS4o_TRB6BTXvA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:35 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs-progs: simple quotas kernel definitions
Date:   Wed,  5 Jul 2023 16:36:21 -0700
Message-ID: <d0a83da0b9f182e080fc693512d35f3476ab4395.1688599734.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688599734.git.boris@bur.io>
References: <cover.1688599734.git.boris@bur.io>
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

Copy over structs, accessors, and constants for simple quotas

Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/accessors.h       |  9 +++++++++
 kernel-shared/ctree.h           |  6 ++++--
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 12 ++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 539c20d09..ab8c2d337 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -379,9 +379,13 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
 	if (type == BTRFS_EXTENT_DATA_REF_KEY)
 		return sizeof(struct btrfs_extent_data_ref) +
 		       offsetof(struct btrfs_extent_inline_ref, offset);
+	if (type == BTRFS_EXTENT_OWNER_REF_KEY)
+		return sizeof(struct btrfs_extent_inline_ref);
 	return 0;
 }
 
+BTRFS_SETGET_FUNCS(extent_owner_ref_root_id, struct btrfs_extent_owner_ref, root_id, 64);
+
 /* struct btrfs_node */
 BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
 BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
@@ -979,6 +983,9 @@ BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
 		   flags, 64);
 BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
 		   rescan, 64);
+BTRFS_SETGET_FUNCS(qgroup_status_enable_gen, struct btrfs_qgroup_status_item,
+		   enable_gen, 64);
+
 BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_generation,
 			 struct btrfs_qgroup_status_item, generation, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_version,
@@ -987,6 +994,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_flags,
 			 struct btrfs_qgroup_status_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_rescan,
 			 struct btrfs_qgroup_status_item, rescan, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_qgroup_status_enable_gen,
+			 struct btrfs_qgroup_status_item, enable_gen, 64);
 
 /* btrfs_qgroup_info_item */
 BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5d3392ae8..3b283b21e 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -102,7 +102,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
@@ -117,7 +118,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
+	 BTRFS_FEATURE_INCOMPAT_ZONED | \
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 #endif
 
 /*
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89a..d312b9f4f 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -356,6 +356,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index ad555e705..a9fdbbb1e 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -227,6 +227,8 @@
 
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
+#define BTRFS_EXTENT_OWNER_REF_KEY	190
+
 /*
  * block groups give us hints into the extent allocation trees.  Which
  * blocks are free etc etc
@@ -783,6 +785,10 @@ struct btrfs_shared_data_ref {
 	__le32 count;
 } __attribute__ ((__packed__));
 
+struct btrfs_extent_owner_ref {
+	__le64 root_id;
+} __attribute__ ((__packed__));
+
 struct btrfs_extent_inline_ref {
 	__u8 type;
 	__le64 offset;
@@ -1224,6 +1230,12 @@ struct btrfs_qgroup_status_item {
 	 * of the scan. It contains a logical address
 	 */
 	__le64 rescan;
+
+	/*
+	 * Used by simple quotas to ignore old extent deletions
+	 * Present iff incompat flag SIMPLE_QUOTA is set
+	 */
+	__le64 enable_gen;
 } __attribute__ ((__packed__));
 
 struct btrfs_qgroup_info_item {
-- 
2.41.0


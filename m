Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EA17B0B42
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjI0Rp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0Rp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:45:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8536BF5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:45:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AA7D6320094C;
        Wed, 27 Sep 2023 13:45:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836756; x=
        1695923156; bh=GQZL2z8JNLswgRqQXPROAzG4h6fcUbinjS35PqXh9MA=; b=u
        +hhppwIE3i1wWCcdYU4UBEs2lab4sh0OpaPraepSR+EIbkjjytuKaXoTjWfumkBs
        Ua05YG7lOf2+MbyWUfPQIYW+ZDQ/J2wpzwNDUt9sgv9UKCxs101sGWBUANK+hhQ1
        kLI09ZJpeObEvzAg4EOIcr1qTTfmy2HIu1R3F/IrsueM6jlXgzwXEgzG/aFcJue5
        P5H9APoTF4PEJb0PD2Nv8PsRAUalb+VltB1CEUao3xUYG8V+dHHv0yYmca4iNWSk
        TaHFPURU5zU/24eZs3l1To8Yb0ZgIdC570BkwNECew6LoYs8Y/bvrLiOZeBtKwfq
        /cHWl/OxJuSxjUsYczngw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836756; x=1695923156; bh=G
        QZL2z8JNLswgRqQXPROAzG4h6fcUbinjS35PqXh9MA=; b=bmmOQsWeyB00TfAKI
        Z6Vdt10r+zj9p7Bw3fZBGQclzt++xI8/tUdtbzjmXFtaG6reUl+rDji2WKShNxlP
        PMLhEs1qkDglrnJJgqXK0yx76oDZAP5pYXfAOWGMmJ1Beg96kEz7p3zPE/XtkWyT
        6XnSPnkP6uMlehApmcwGYf0Tn0fZhmc7R4wuxlzy6lfEXQiPPebindSaNn1ydcq9
        CgudoNKCYZx5I9OEKkW+kgogkOByy0BSY6FzmVFXy8AtR3IJlb7CZyyLyIqfDPUJ
        6dLuvEDlTukzIgMO24/6sq7qGJYOonPf19SuTyPbFiqUgoiwNI+tMUdF7d99tZ00
        KHAVA==
X-ME-Sender: <xms:VGoUZdIKN3a9oW_qcp-rgduw1yvnNTvZHkvY2jEqU4xQcdmucRbshg>
    <xme:VGoUZZJjtiZ8tmdT5tXJ5gWX1yUyBOlFzOGcvV-_Kn94xiFCKpWUx1V7izQay4tnT
    CrOcehg3fWjbONEutA>
X-ME-Received: <xmr:VGoUZVvpFbfcjr-uBg8y0t-48mJoRbmvioW-GWz505CrkLoarRUVswtI4D4-56IjA1uFE31d9yroVdd4OcJesFKJ7NI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:VGoUZeaJw_JJYCFm8RAzS-se3G0nq_4TI1g_xBNb8jsKDGeNAOj2hA>
    <xmx:VGoUZUYfctv4IsJMy6tKIinn3lJ9GimpkMCikcV137FSyMN5WlWKNA>
    <xmx:VGoUZSDRHgERrwU91R-ykIbZVdlFDTjW6lbNEdIFddsQQyA4_e9NeA>
    <xmx:VGoUZdC2Np3iGP2fTtSDEwOHEPfPZx_C0DTg0Pl0e07Izs-0v62Neg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:45:55 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/8] btrfs-progs: simple quotas kernel definitions
Date:   Wed, 27 Sep 2023 10:46:43 -0700
Message-ID: <88ca4f96ddc75dcb52f15b9b175bb31f6f6a331f.1695836680.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695836680.git.boris@bur.io>
References: <cover.1695836680.git.boris@bur.io>
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

Copy over structs, accessors, and constants for simple quotas

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/accessors.h       |  9 +++++++++
 kernel-shared/ctree.h           |  6 ++++--
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 16 +++++++++++++++-
 4 files changed, 29 insertions(+), 3 deletions(-)

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
index 59533879b..bdfebd665 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -103,7 +103,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
@@ -118,7 +119,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
-	 BTRFS_FEATURE_INCOMPAT_ZONED)
+	 BTRFS_FEATURE_INCOMPAT_ZONED | \
+	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 #endif
 
 /*
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89a..7e0078a5d 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -356,6 +356,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index ad555e705..29cf2f3d3 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -227,6 +227,8 @@
 
 #define BTRFS_SHARED_DATA_REF_KEY	184
 
+#define BTRFS_EXTENT_OWNER_REF_KEY	188
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
@@ -1199,10 +1205,12 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  * Turning qouta off and on again makes it inconsistent, too.
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
+#define BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE	(1ULL << 3)
 
 #define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |		\
 					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |	\
-					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |	\
+					 BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE)
 
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
@@ -1224,6 +1232,12 @@ struct btrfs_qgroup_status_item {
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
2.42.0


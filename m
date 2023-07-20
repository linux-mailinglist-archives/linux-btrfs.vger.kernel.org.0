Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7416175BAEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGTW67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTW66 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:58:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81B92
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:58:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 421C65C0166;
        Thu, 20 Jul 2023 18:58:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893937; x=
        1689980337; bh=pC5O/GjSwg5IDlqKUIXN0rC3/iUf5tu71uiY9Z5dckQ=; b=R
        Hg0952+GADOHfcmYd9oAxAtCo9Ed9BxqTwLP49skqSl2dIYJNgf4JEtz/Ign+36V
        IWyCr0IVXDkuXjsNuuxXnYhN8uN700uGByZ2puPTqtV/e6co6FkTsueNiraGLCSk
        p262EWGxAlHDNOcsND290k1Wk3FF7laYO6ugjLz8q6vqiq/AzSAIdnjUWvpLpDd+
        ApW4/ZrHQvQRx88vWyzlhC9dR8/CrNmiY5L3YzvIj4S9TRqnYy6QaVSqXXQECmcQ
        Uw7ankGqAjPt6mPXCM3a3CpFcf2U/6YPhY3++7GIaF4PydR0Ku0f7pV8PDfzHz02
        lrjuicCpD/n+cWp//l2tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893937; x=1689980337; bh=p
        C5O/GjSwg5IDlqKUIXN0rC3/iUf5tu71uiY9Z5dckQ=; b=fzT+N+MTdpQ9zW92v
        JibTVKBYkzAVUMfBTN2GgmHDBexXzLRPPx9DX+tnFpJlWSzuaRXuOGTS5m776wLi
        OADh6MBUFmxWtd2Sj2dVfnMxT5MvnbRkUUBmrPeG6ug4Chfcamx+wVT+gxMslWSa
        67UyY2zaDaInPpmZB+7Q2bSNiob+M92WwtT4u0YkrMuON87CAqTAJjfhxujtAqW8
        /JnvEJg+bZWRVvAsoiUMLwLaeoXtGB2uDgdiW0tm2uwbm3asly3+rA6iuAYti47n
        Ea2JJxKmRLit6O6dJ9vGpH/PahLE/qJEKPhJo9nnFkwJbMV7EESx2xYGzDqFORLl
        0tSeg==
X-ME-Sender: <xms:Mby5ZDsx583ArncKfCXhpSTuqVSHdmdUOMBD-VAo6OmRGtxTdikMiQ>
    <xme:Mby5ZEcUBTYsqIJg36PwvnnHse_Nk7-2WZ0z6oTTLv2nkIRIW7cLB-Wx_KoJPwFlI
    O0VXTzjotAcctA6vbs>
X-ME-Received: <xmr:Mby5ZGzENct0nlGj-6TbQ27PWeRZy6JfWk-kiE94hskTFbcygX72RMzxjmiOPE7WFWFtMfiE2PjrzMPaABoAQNqcRTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Mby5ZCMW0dTFHrFxlbv5TBDQR74UAv7mW5CvV3s3q6d7DiS1dAbakw>
    <xmx:Mby5ZD-jcXXCFil95hoAhxHw214Q1rhaiJsshw2WkekhZ0JV7m7NUw>
    <xmx:Mby5ZCW4B7t2B8sdHcV1fxgV7ol4LCE0CM0r9L01zfLxlXYLtjP29A>
    <xmx:Mby5ZAGD1jZhGS9XwaO-6YfAb0dCIiT0aE3la9i7ge71H5jhJV1bHA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:58:56 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/8] btrfs-progs: simple quotas kernel definitions
Date:   Thu, 20 Jul 2023 15:57:18 -0700
Message-ID: <6344f891404f2493a2b196489cbcb1920d4cb81b.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893698.git.boris@bur.io>
References: <cover.1689893698.git.boris@bur.io>
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

Copy over structs, accessors, and constants for simple quotas

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/accessors.h       |  9 +++++++++
 kernel-shared/ctree.h           |  6 ++++--
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h | 17 ++++++++++++++++-
 4 files changed, 30 insertions(+), 3 deletions(-)

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
index ad555e705..56b6c92f5 100644
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
@@ -1199,10 +1205,13 @@ static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
  * Turning qouta off and on again makes it inconsistent, too.
  */
 #define BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT	(1ULL << 2)
+/* bits 3 and 4 taken by runtime qgroup flags */
+#define BTRFS_QGROUP_STATUS_FLAG_SIMPLE	(1ULL << 5)
 
 #define BTRFS_QGROUP_STATUS_FLAGS_MASK	(BTRFS_QGROUP_STATUS_FLAG_ON |		\
 					 BTRFS_QGROUP_STATUS_FLAG_RESCAN |	\
-					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)
+					 BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |	\
+					 BTRFS_QGROUP_STATUS_FLAG_SIMPLE)
 
 #define BTRFS_QGROUP_STATUS_VERSION        1
 
@@ -1224,6 +1233,12 @@ struct btrfs_qgroup_status_item {
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


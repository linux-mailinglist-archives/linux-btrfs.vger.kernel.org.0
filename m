Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F37491EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGEXhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGEXhm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:42 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5B1990
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 64E875C00B4;
        Wed,  5 Jul 2023 19:37:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600261; x=
        1688686661; bh=vHVNKV1iQqpPa4eszV6eL6oG+RGHvuHd55kGwqH8imE=; b=d
        QeqnsFHzOzYbe6Q1vZ068FhnsgD6fZXlgPfrFMty+2Bm4WgH0m0TBP1Jmbl6zoEE
        rID6JWvbwjZ6dNyFRi4hzP7Tb4885AG3L5nZwar7i7wr8syyNMus4DEpDYQ/KQWQ
        PkwySSjTRsXk8xlNVgRlrv0D+FU0dqGYTryv5TRLpRGR07tvL0XVwM6LAw6iMDfV
        VPeMgnB1Rd14Y2MyS7qvaJWSM3Y5cVGlvtAtwFYsp2ju9qm3g/wAchzs9+prFCRs
        fYiHk8lAR1hJsLmLhdWqwlRAF1aUfc3bgC164K3GXAnknSZg1jIMENVV9rS28cRw
        Fsyqvaic2b62ABtje3gGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600261; x=1688686661; bh=v
        HVNKV1iQqpPa4eszV6eL6oG+RGHvuHd55kGwqH8imE=; b=OCOAm+Nj91+O4s4ZQ
        c6kWxBD4D6d2HVmKtlFxWGi4zmVPl9dmuH1y7Ng3A8lG4x3VUsWjzmIgOufOqt7L
        A2Nv3jYfTkVe+YMUG3sZnSegl0Kdi1RPHJXuRPjO9jB3sWOFQ5x3qEtOxXudLE/P
        4hubNog8oerdaRCUXAK5mF2vlw47OtGOnsjFK8Fi5lRg9orGY9vUCmp0B4y0Axjp
        74GXFjiyhLb9fGal0GSJkAV2EVBCmlcPwivyX1MRraar2yp0Tj66VEzYVC2EM52k
        6xxUoKffyigsnRL0nBD1vOwj7SCv0LeQSOoywK8sEpWRAXhP1MRF9aerFY+IvHCi
        hbiXw==
X-ME-Sender: <xms:xf6lZCV4MpY52pBMnf-s6aPA4rDsWdCwBoeRh3k6QfxRWgVSysHHYQ>
    <xme:xf6lZOmBgGstdMIMUcd1In-_-CcS8l2dtDEh3XfTGM7xoc3XDm1bieeEynbHs6XTu
    tc68C8ua10hJ4GcJIo>
X-ME-Received: <xmr:xf6lZGb-mgKbmZI87Ni3vjS29Hc-njLnhrwmwglzllcXwxYCffwPFy_6Nqz2clRdzQK9cONixzbn1q6AOe-f5oRo3rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:xf6lZJVheZvNtF9fw7-z8AazigBf8MD2ajr1dC8AxFOoET9KAJ03Tw>
    <xmx:xf6lZMku-qfUM4YgoKLjP96q0BZOSbp0-PO0Zr2gFIvbnEOrwH_E8w>
    <xmx:xf6lZOcdwTsq6jcb0HtjYpDB2JFx87OB05qjwwBsB0Yk6hg-d9qHmA>
    <xmx:xf6lZDtCB-EDLqMpSs7o78xHV0phw4u_unw8lSiU8MR6jMu9EUJmzg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs-progs: simple quotas mkfs
Date:   Wed,  5 Jul 2023 16:36:24 -0700
Message-ID: <19ca469539472675b8cdb0d807e59cbd4e081fd4.1688599734.git.boris@bur.io>
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

Add the ability to enable simple quotas from mkfs with '-O squota'

There is some complication around handling enable gen while still
counting the root node of an fs. To handle this, employ a hack of doing
a no-op write on the root node to bump its generation up above that of
the qgroup enable generation, which results in counting it properly.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/fsfeatures.c |  9 +++++++
 mkfs/main.c         | 63 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 00658fa51..584ecb5fc 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -108,6 +108,15 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "quota support (qgroups)"
 	},
+	{
+		.name		= "squota",
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA,
+		.sysfs_name	= "squota",
+		VERSION_TO_STRING2(compat, 6,5),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "squota support (simple qgroups)"
+	},
 	{
 		.name		= "extref",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
diff --git a/mkfs/main.c b/mkfs/main.c
index 7acd39ec6..2f0b563a0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -59,6 +59,8 @@
 #include "mkfs/common.h"
 #include "mkfs/rootdir.h"
 
+#include "libbtrfs/ctree.h"
+
 struct mkfs_allocation {
 	u64 data;
 	u64 metadata;
@@ -882,6 +884,39 @@ static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int touch_root_subvol(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_inode_item *inode_item;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FIRST_FREE_OBJECTID,
+		.type = BTRFS_INODE_ITEM_KEY,
+		.offset = 0,
+	};
+	struct extent_buffer *leaf;
+	int slot;
+	struct btrfs_path path;
+	int ret;
+
+	trans = btrfs_start_transaction(fs_info->fs_root, 1);
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(trans, fs_info->fs_root, &key, &path, 0, 1);
+	if (ret)
+		goto fail;
+	leaf = path.nodes[0];
+	slot = path.slots[0];
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	inode_item = btrfs_item_ptr(leaf, slot, struct btrfs_inode_item);
+	btrfs_mark_buffer_dirty(leaf);
+	btrfs_commit_transaction(trans, fs_info->fs_root);
+	btrfs_release_path(&path);
+	return 0;
+fail:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int setup_quota_root(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
@@ -890,8 +925,11 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 	struct btrfs_path path;
 	struct btrfs_key key;
 	int qgroup_repaired = 0;
+	bool simple = btrfs_fs_incompat(fs_info, SIMPLE_QUOTA);
+	int flags;
 	int ret;
 
+
 	/* One to modify tree root, one for quota root */
 	trans = btrfs_start_transaction(fs_info->tree_root, 2);
 	if (IS_ERR(trans)) {
@@ -921,13 +959,16 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 
 	qsi = btrfs_item_ptr(path.nodes[0], path.slots[0],
 			     struct btrfs_qgroup_status_item);
-	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, 0);
+	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, trans->transid);
 	btrfs_set_qgroup_status_rescan(path.nodes[0], qsi, 0);
+	flags = BTRFS_QGROUP_STATUS_FLAG_ON;
+	if (simple)
+		btrfs_set_qgroup_status_enable_gen(path.nodes[0], qsi, trans->transid);
+	else
+		flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 
-	/* Mark current status info inconsistent, and fix it later */
-	btrfs_set_qgroup_status_flags(path.nodes[0], qsi,
-			BTRFS_QGROUP_STATUS_FLAG_ON |
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
+	btrfs_set_qgroup_status_version(path.nodes[0], qsi, 1);
+	btrfs_set_qgroup_status_flags(path.nodes[0], qsi, flags);
 	btrfs_release_path(&path);
 
 	/* Currently mkfs will only create one subvolume */
@@ -944,6 +985,15 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 		return ret;
 	}
 
+	/* Hack to count the default subvol metadata by dirtying it */
+	if (simple) {
+		ret = touch_root_subvol(fs_info);
+		if (ret) {
+			error("failed to touch root dir for simple quota accounting %d (%m)", ret);
+			goto fail;
+		}
+	}
+
 	/*
 	 * Qgroup is setup but with wrong info, use qgroup-verify
 	 * infrastructure to repair them.  (Just acts as offline rescan)
@@ -1743,7 +1793,8 @@ raid_groups:
 		}
 	}
 
-	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA) {
+	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
+	    features.incompat_flags & BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA) {
 		ret = setup_quota_root(fs_info);
 		if (ret < 0) {
 			error("failed to initialize quota: %d (%m)", ret);
-- 
2.41.0


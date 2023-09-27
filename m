Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFE7B0B45
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI0RqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0RqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:46:07 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FABA1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:46:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0CC573200906;
        Wed, 27 Sep 2023 13:46:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 27 Sep 2023 13:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836764; x=
        1695923164; bh=nfacq4SjVU+70Uf1Je2tz9agFZq5yx7t4DA/p7b/ZNk=; b=V
        Qs63xAKJTrvLxFosRT7cAJdz7jb9SlxOQETWE+dbTHrbGK2oBQH3QfLtjyh+u+9L
        n7Q13jiUdwQ8eUjK9fSzd6AzyKeJ3BddjqFaU4oh41365bS+KwV2aWNWFXTWAy1T
        v9ZXdF/kveaTqA1hDZlbXJsxievIHjVp5ycr04VS10CDoiy6BSMVrX3+1p0OBA0z
        6ojVY6IMPARJl4jdDRmg9s2+1K+r9Fn7NfKd4T6iK+7w1fuYTVjsGt5DaySzdUxx
        nSeO1RjeFPEVMsSRTAYYmJ9NfpAgZKp/iw9Ox96/jVH4NraK3ahleB0Ue7Xo9zff
        ZG2EnpSbM8uWZzyh1XuJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836764; x=1695923164; bh=n
        facq4SjVU+70Uf1Je2tz9agFZq5yx7t4DA/p7b/ZNk=; b=eA+pQUUnVCTxzSf+S
        wsauE4gCACVNZnbyuz2UKyAw0HVMN2uSdhGEalHzE8pqhB4AiXxbxg07TSbkd52Z
        fZjR0TlSLa17DRaorSmwHVuUNASUUKTTpxRrIcEhY8YPhHcTax9e0SEcr8n7BoaV
        oLsmERLaygIiRV+00Yof/p/bR7YU7hM+rHGFrArXe4R0O9eppSvZ6L/I+3oYpLdN
        pQmAhI+0aeXnd1Mi96CA+E+dGHeMRZCC9i2Ys6iKYXzFkd3X8dUxR23HYTc2C8gg
        VKTn8dE0vTHhdSgqwrFztd+tiTs3sq9tDbUHHzK+Ob/nm5KqKuyVEFrWJxFeE6yI
        e08Dw==
X-ME-Sender: <xms:XGoUZVyUu6RIdsVHYRd0CPkGEUOA1Xhfd8I5yUgNN2FINdy3TTCGIA>
    <xme:XGoUZVTv7n9JLx2L2NbWNasMYQm2P9Cnx--TPbZTThju37R9tHhImq67P0B3TXUGe
    OfY4n4cOfnwrqQXpVo>
X-ME-Received: <xmr:XGoUZfW2kZR0rTAL4upMj2YoUkhxqi13zYd_IEMuLZ_kHN_0Fhl2cHV4UcpRDjYy2jUJE2iOq_wOQ2BrhjATItUMYjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:XGoUZXhwKpGyWBFcMRmF03ksowLoONEinaHQWHwLerYCZAWvOrCa4A>
    <xmx:XGoUZXB3AeuWqgm11kfADSmf3UhfFQuCDWkcwGo8WZDw4x-Iijsn6Q>
    <xmx:XGoUZQIXFR29wuGFHJnkW7jrHMYUKv5_hl0fYqGxzeUyDyVVULrBfA>
    <xmx:XGoUZardIGzcVRHja7MrqvnXK1LlCccY3unbaxTLtg6R2oNBFEwKrg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:46:04 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/8] btrfs-progs: simple quotas mkfs
Date:   Wed, 27 Sep 2023 10:46:46 -0700
Message-ID: <3b69a29059b051962e556f4ce3aa53e4d00466a2.1695836680.git.boris@bur.io>
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

Add the ability to enable simple quotas from mkfs with '-O squota'

There is some complication around handling enable gen while still
counting the root node of an fs. To handle this, employ a hack of doing
a no-op write on the root node to bump its generation up above that of
the qgroup enable generation, which results in counting it properly.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c |  7 +++--
 common/fsfeatures.c   |  9 ++++++
 mkfs/main.c           | 64 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index c95e6f806..1cf01d2d0 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1695,6 +1695,8 @@ static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
 	struct btrfs_path path;
 	struct btrfs_key key;
 	struct btrfs_qgroup_status_item *status_item;
+	bool simple = btrfs_fs_incompat(info, SIMPLE_QUOTA);
+	int flags = BTRFS_QGROUP_STATUS_FLAG_ON;
 
 	if (!silent)
 		printf("Repair qgroup status item\n");
@@ -1717,8 +1719,9 @@ static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
 
 	status_item = btrfs_item_ptr(path.nodes[0], path.slots[0],
 				     struct btrfs_qgroup_status_item);
-	btrfs_set_qgroup_status_flags(path.nodes[0], status_item,
-				      BTRFS_QGROUP_STATUS_FLAG_ON);
+	if (simple)
+		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+	btrfs_set_qgroup_status_flags(path.nodes[0], status_item, flags);
 	btrfs_set_qgroup_status_rescan(path.nodes[0], status_item, 0);
 	btrfs_set_qgroup_status_generation(path.nodes[0], status_item,
 					   trans->transid);
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 1c993b594..6bf87937b 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -109,6 +109,15 @@ static const struct btrfs_feature mkfs_features[] = {
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
index 1c5d668e1..5bb4d1a21 100644
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
@@ -882,6 +884,37 @@ static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int touch_root_subvol(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
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
@@ -890,8 +923,11 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
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
@@ -921,13 +957,19 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 
 	qsi = btrfs_item_ptr(path.nodes[0], path.slots[0],
 			     struct btrfs_qgroup_status_item);
-	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, 0);
+	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, trans->transid);
 	btrfs_set_qgroup_status_rescan(path.nodes[0], qsi, 0);
+	flags = BTRFS_QGROUP_STATUS_FLAG_ON;
+	if (simple) {
+		btrfs_set_qgroup_status_enable_gen(path.nodes[0], qsi, trans->transid);
+		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+	}
+	else {
+		flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	}
 
-	/* Mark current status info inconsistent, and fix it later */
-	btrfs_set_qgroup_status_flags(path.nodes[0], qsi,
-			BTRFS_QGROUP_STATUS_FLAG_ON |
-			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
+	btrfs_set_qgroup_status_version(path.nodes[0], qsi, 1);
+	btrfs_set_qgroup_status_flags(path.nodes[0], qsi, flags);
 	btrfs_release_path(&path);
 
 	/* Currently mkfs will only create one subvolume */
@@ -944,6 +986,15 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
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
@@ -1743,7 +1794,8 @@ raid_groups:
 		}
 	}
 
-	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA) {
+	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
+	    features.incompat_flags & BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA) {
 		ret = setup_quota_root(fs_info);
 		if (ret < 0) {
 			error("failed to initialize quota: %d (%m)", ret);
-- 
2.42.0


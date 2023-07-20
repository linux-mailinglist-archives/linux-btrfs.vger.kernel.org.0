Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1BF75BAED
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGTW7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTW7D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:59:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAB392
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:59:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 269F95C0113;
        Thu, 20 Jul 2023 18:59:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 Jul 2023 18:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893942; x=
        1689980342; bh=cXqNOKAQXfe4bIkJWQHqHnC4KJxLx0QSfwrJwUUEU4Y=; b=m
        hseqQDAfwRUv5PLE+jU13Vv9GGoNhpwSb0nnISJCh31FnzBLSw/YowtCkgEd4E9T
        psYG1YchuDBZkNkWHo3AVrPXE5DF1m27RetJOyDMZjxGvV+GvNjo1xT7Q60lxNff
        lDir6N6NQbC/wS3Ki5CQfhDDATJ5SEQlig4S9loD9CeXF5EO1gHG01C2JsYC6dAc
        kmHctlIrYZYV+bHMPucVRYElXkD1zNfARbC0rx1qhYH/nh5Ha67Y+Vax5cSdI3qU
        h+zFPdAjuZu3XqcGNHs0C8MHJs0GXOmXUcTuFsie/WDBw03A2PkCAv5T6RQc+qKp
        leANrEKakssCr29uMJ9Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893942; x=1689980342; bh=c
        XqNOKAQXfe4bIkJWQHqHnC4KJxLx0QSfwrJwUUEU4Y=; b=QQX7NNi6mmKNTM4As
        yJrvlDHZcZcWiPlGDp+b3QKv+w5vtAXrGX9cvuiv1VoI1Jk5t86+nSjvO3RAhwlj
        27nZg/wWL6W+k5ucYPnjZLZUjgjlDun2X/5OrNNSGU+gOwoMUCsSwI4AdlCjIrJN
        4UQo8Z5ikJO+3vftGhInZlrDOYZ7yW8lg1HNDNpyWCzRN/SDbTPUJUln5RBqqg3s
        24Q/aPzql2hdWWFZ9Yqx2fSp/Yt5NLylOGoGd7VY05egDmNu6oaN7KgGmhA7sZrz
        W+rHtuuySoBHMnmaaeGphS4F4MWSoskqzlia21yXkt6/Gn9+YFufQqd/NmV0FciN
        jQUlg==
X-ME-Sender: <xms:Nby5ZDYYzyyaOf2hx9W6S-A1UWqFVooZ0nTxsknonqVPhWXmVVIIyQ>
    <xme:Nby5ZCbvq5H6nND_MjhRPRAB0I87Q4IIM0maW0ahCr2bNDtnIZajA9p4CdbuBUGga
    ZyKonI9yeUT_NgPIHo>
X-ME-Received: <xmr:Nby5ZF9PeeF7ddLNHlZJiIJi8AroWQGGcsHwmDmn3bZUuMaLIOCbnenZCV_RIrwKKEacSZV83dT-hYMcIlsxxBQl3OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Nry5ZJqRbdAxzzwqOyEWbTjGDTkHnwmyLIqvHUDZTWxFrI36KlpH7A>
    <xmx:Nry5ZOoeszGz7c6yUIsF9wDYME0z-Zq8NrOuRhu0coD1y7FOLHCP7w>
    <xmx:Nry5ZPQBqQNpJ5Zaf6LnGqAYVHZk2XdHLarZKWs5OR_086X64tP-qw>
    <xmx:Nry5ZFRZ9wpb0X__XBdco6RgDW_twYzWEmr5PR4QyM8nJRVDk4hHmw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:59:01 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/8] btrfs-progs: simple quotas mkfs
Date:   Thu, 20 Jul 2023 15:57:21 -0700
Message-ID: <5c1ec94a8bf33e3f145ddb53f2fefafffd9b8f6a.1689893698.git.boris@bur.io>
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
index c95e6f806..7b32d7b5c 100644
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
+		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
+	btrfs_set_qgroup_status_flags(path.nodes[0], status_item, flags);
 	btrfs_set_qgroup_status_rescan(path.nodes[0], status_item, 0);
 	btrfs_set_qgroup_status_generation(path.nodes[0], status_item,
 					   trans->transid);
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
index 7acd39ec6..e0b20063d 100644
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
+		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
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
2.41.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2417B0B46
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjI0RqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0RqK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:46:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F156A1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:46:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 959923200906;
        Wed, 27 Sep 2023 13:46:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 27 Sep 2023 13:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836767; x=
        1695923167; bh=GCpiqOET8qxMOhlnmiHhXbbYxN2P5Tnq6TO5JNIhLrE=; b=q
        p2d9ebYb4FeOot8+L6s19+UGbsT7+4BcirjddD4qQfL36rakdk34UXdUcpodEWS9
        doqSgRI/oEib3Q9n8QOz+HFr8EZPBdDCe5vrmseZQYMO+HxlikBj3uksIgiH+R7S
        YpMIKHIq3/gS9VtS9rwhpwiSeaJVglRuzIILQ625sO1HWWhA3lnMK+lq9hQ//gSB
        qCNaYn+rMhw0o3R/JhDHNHfRdrkxhDqqLmKABLMaRu8aZlcb/S9IOlBSq+lD5udW
        ptUwZo+n/Y4xB7kXQyEKG/9SPSp1MMLVA/CI42fBz4zp1HfRD+NqxnZttPNF1AYT
        ZfnkRGGDKyOuwOPQmsy7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836767; x=1695923167; bh=G
        CpiqOET8qxMOhlnmiHhXbbYxN2P5Tnq6TO5JNIhLrE=; b=MG0j0R9UruiYSpq5m
        vpx1n9Q3aLkKlEScTNEtFb1SCwYy2a1C1WhlAF897uAotj5fqtrBrcl5k5n7atjA
        ZviB2nbsD2aFCLvi/AqF8YKV4C4+kLLLX9yO900YB1mcLpmH/NGxlE42XlMkLK+Y
        tXURofad/deJuIUJAihN5MNBlzRVtMKEaBwAT8ruNU4HuxotIostCXO2bY8PvM/+
        HutA53FWQ6jCu3OSfTFvQalytV/h6Koa968FwfVwGt+yRGtE+uL9lTxLeqAuRMkt
        8raMedo8vdBRs0LkbCkLS80CilTh5YQBCV4dXqOfk9oN/rx0ZsH0fkpoOx6zVTDz
        PiDkw==
X-ME-Sender: <xms:X2oUZWUgMa2tC4UOy94kcQSH1fzXvBk1C_REOJXY3HjZn6MsmFt20g>
    <xme:X2oUZSmlF5yfkfFxHY_IM4cjhXC9iNImOh1m3zQxWGDn9_nYYmZ1WL-cEraZ-ScoL
    hoH53iJksl2DeUWLZ4>
X-ME-Received: <xmr:X2oUZaaAoHsiXjD1kiQjXTUJJGrOMbQ_KjUjyyzTPaEEEN6rEuWUBOsYR26YrGBC0ZAaPg-G7WMq4EA6q4I5ywFro58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:X2oUZdVW16ittfIONriAIcSzMovs9hUqtpG1pHMuYidbl8CrYGztyg>
    <xmx:X2oUZQkbU1pX6GILfRxkrdHURnsbi-cZXZZA5ug2jEbWC3bFw8TItg>
    <xmx:X2oUZSc131p3-8s68rYYUOZbLB4Hs__8j-i3a0k3NRxkmsOwRUJfPA>
    <xmx:X2oUZXvM4nkq84GsstGA71GnKNokdMtl83g2mBlecuoMeAuAggSYCw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:46:06 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 6/8] btrfs-progs: simple quotas btrfstune
Date:   Wed, 27 Sep 2023 10:46:47 -0700
Message-ID: <4c3729d6ecf4537e77865da4b044453ae3ef2d8a.1695836680.git.boris@bur.io>
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

Add the ability to enable simple quotas on an existing file system at
rest with btrfstune.

This is similar to the functionality in mkfs, except it must also find
all the roots for which it must create qgroups. Note that this *does
not* retroactively compute usage for existing extents as that is
impossible for data. This is consistent with the behavior of the live
enable ioctl.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile     |   2 +-
 tune/main.c  |  18 +++++-
 tune/quota.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tune/tune.h  |   3 +
 4 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 tune/quota.c

diff --git a/Makefile b/Makefile
index 5dfd3c01d..7419475dd 100644
--- a/Makefile
+++ b/Makefile
@@ -265,7 +265,7 @@ mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o image/image-create.o image/common.o \
 		image/image-restore.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
-	       tune/convert-bgt.o tune/change-csum.o check/clear-cache.o
+	       tune/convert-bgt.o tune/change-csum.o tune/quota.o check/clear-cache.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
 
diff --git a/tune/main.c b/tune/main.c
index 63539b991..895e4da03 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -103,6 +103,7 @@ static const char * const tune_usage[] = {
 	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
 	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
 	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
+	OPTLINE("-q", "enable simple quotas on the file system. (mkfs: squota)"),
 	OPTLINE("--convert-to-block-group-tree", "convert filesystem to track block groups in "
 			"the separate block-group-tree instead of extent tree (sets the incompat bit)"),
 	OPTLINE("--convert-from-block-group-tree",
@@ -153,6 +154,9 @@ enum btrfstune_group_enum {
 	 */
 	LEGACY,
 
+	/* Qgroup options */
+	QGROUP,
+
 	BTRFSTUNE_NR_GROUPS,
 };
 
@@ -189,6 +193,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	char *new_fsid_str = NULL;
 	int ret;
 	u64 super_flags = 0;
+	int quota = 0;
 	int fd = -1;
 
 	btrfs_config_init();
@@ -211,7 +216,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
+		int c = getopt_long(argc, argv, "S:rxqfuU:nmM:", long_options, NULL);
 
 		if (c < 0)
 			break;
@@ -229,6 +234,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			super_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
 			btrfstune_cmd_groups[LEGACY] = true;
 			break;
+		case 'q':
+			quota = 1;
+			btrfstune_cmd_groups[QGROUP] = true;
+			break;
 		case 'n':
 			super_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
 			btrfstune_cmd_groups[LEGACY] = true;
@@ -499,6 +508,13 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		ret = change_uuid(fs_info, new_fsid_str);
 		goto out;
 	}
+
+	if (quota) {
+		ret = enable_quota(root->fs_info, true);
+		if (ret)
+			goto out;
+	}
+
 out:
 	if (ret < 0) {
 		fs_info->readonly = 1;
diff --git a/tune/quota.c b/tune/quota.c
new file mode 100644
index 000000000..949cfc409
--- /dev/null
+++ b/tune/quota.c
@@ -0,0 +1,172 @@
+#include <errno.h>
+
+#include "common/messages.h"
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/transaction.h"
+#include "kernel-shared/uapi/btrfs_tree.h"
+#include "tune/tune.h"
+
+static int create_qgroup(struct btrfs_fs_info *fs_info,
+			 struct btrfs_trans_handle *trans,
+			 u64 qgroupid)
+{
+	struct btrfs_path path;
+	struct btrfs_root *quota_root = fs_info->quota_root;
+	struct btrfs_key key;
+	int ret;
+
+	if (qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT) {
+		error("qgroup level other than 0 is not supported yet");
+		return -ENOTTY;
+	}
+
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_INFO_KEY;
+	key.offset = qgroupid;
+
+	btrfs_init_path(&path);
+	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
+				      sizeof(struct btrfs_qgroup_info_item));
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_LIMIT_KEY;
+	key.offset = qgroupid;
+	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
+				      sizeof(struct btrfs_qgroup_limit_item));
+	btrfs_release_path(&path);
+
+	printf("created qgroup for %llu\n", qgroupid);
+	return ret;
+}
+
+static int create_qgroups(struct btrfs_fs_info *fs_info,
+			  struct btrfs_trans_handle *trans)
+{
+	struct btrfs_key key = {
+		.objectid = 0,
+		.type = BTRFS_ROOT_REF_KEY,
+		.offset = 0,
+	};
+	struct btrfs_path path;
+	struct extent_buffer *leaf;
+	int slot;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	int ret;
+
+
+	ret = create_qgroup(fs_info, trans, BTRFS_FS_TREE_OBJECTID);
+	if (ret)
+		goto out;
+
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot_for_read(tree_root, &key, &path, 1, 0);
+	if (ret)
+		goto out;
+
+	while (1) {
+		slot = path.slots[0];
+		leaf = path.nodes[0];
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		if (key.type == BTRFS_ROOT_REF_KEY) {
+			ret = create_qgroup(fs_info, trans, key.offset);
+			if (ret)
+				goto out;
+		}
+		ret = btrfs_next_item(tree_root, &path);
+		if (ret < 0) {
+			error("failed to advance to next item");
+			goto out;
+		}
+		if (ret)
+			break;
+	}
+
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+int enable_quota(struct btrfs_fs_info *fs_info, bool simple)
+{
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	struct btrfs_trans_handle *trans;
+	int super_flags = btrfs_super_incompat_flags(sb);
+	struct btrfs_qgroup_status_item *qsi;
+	struct btrfs_root *quota_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int flags;
+	int ret;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 2);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		return ret;
+	}
+
+	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
+	if (ret < 0) {
+		error("failed to create quota root: %d (%m)", ret);
+		goto fail;
+	}
+	quota_root = fs_info->quota_root;
+
+	/* Create the qgroup status item */
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_STATUS_KEY;
+	key.offset = 0;
+
+	btrfs_init_path(&path);
+	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
+				      sizeof(*qsi));
+	if (ret < 0) {
+		error("failed to insert qgroup status item: %d (%m)", ret);
+		goto fail;
+	}
+
+	qsi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			     struct btrfs_qgroup_status_item);
+	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, trans->transid);
+	btrfs_set_qgroup_status_rescan(path.nodes[0], qsi, 0);
+	flags = BTRFS_QGROUP_STATUS_FLAG_ON;
+	if (simple) {
+		btrfs_set_qgroup_status_enable_gen(path.nodes[0], qsi, trans->transid);
+		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+	} else {
+		flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	}
+
+	btrfs_set_qgroup_status_version(path.nodes[0], qsi, 1);
+	btrfs_set_qgroup_status_flags(path.nodes[0], qsi, flags);
+	btrfs_release_path(&path);
+
+	/* Create the qgroup items */
+	ret = create_qgroups(fs_info, trans);
+	if (ret < 0) {
+		error("failed to create qgroup items for subvols %d (%m)", ret);
+		goto fail;
+	}
+
+	/* Set squota incompat flag */
+	if (simple) {
+		super_flags |= BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA;
+		btrfs_set_super_incompat_flags(sb, super_flags);
+	}
+
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+		return ret;
+	}
+	return ret;
+fail:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/tune/tune.h b/tune/tune.h
index 0ef249d89..cbf33b2e7 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -33,4 +33,7 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info);
 int convert_to_extent_tree(struct btrfs_fs_info *fs_info);
 
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type);
+
+int enable_quota(struct btrfs_fs_info *fs_info, bool simple);
+
 #endif
-- 
2.42.0


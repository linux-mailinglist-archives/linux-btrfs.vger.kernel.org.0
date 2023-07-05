Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2B7491F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGEXhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGEXho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A512A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 08C965C0056;
        Wed,  5 Jul 2023 19:37:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 19:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600263; x=
        1688686663; bh=1xzdKvzy3sMHeu+eRDpJi09YRWXqrdn9Pq2QDJ7KYmg=; b=V
        MRZmK80X4qYUZGjYJUELn1929M8JkYKplN4s51rz/91jDkXtTlBFkMnSEAJFR2ev
        g3YbKo7JiCT2CY48OJoJQzGf1Ug7BNz6kbb0FOlBl7mzdSV4d21zpdRXAtmTXobt
        dJYsqLTNzQNxl/r9Lk9H0yQiGb/NKNLNfcdWxe5g5KZt19qSRMVWZIi2A+pZPU8z
        tWBFxp2KIdrJiF1v00keIkuCH/gFSoAqwCLu5E2mdyGn2ovTYb2mQHUGhO0FUcon
        Ah1BVTQVpF67ps+Lvjbex77j5AlJHJKLQ4RRWyuDjd/gtHFK57EkL46OYeNDXfza
        C3TiTmNoX5sGx1n8BnVNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600263; x=1688686663; bh=1
        xzdKvzy3sMHeu+eRDpJi09YRWXqrdn9Pq2QDJ7KYmg=; b=mnQg41/1BMfEjqCDx
        +wlf86GNRW1RqX8RGXAmP2XyncT8SFmBz5xgMdFkhnOEvjbZNRfkxkl8lrSeQWHg
        RQAiFn/NB+DqtkclgtzzxaIKj0MuXSCPwaGs39q9Q2obcmU1FCh2h00hvm8lOvkh
        r/BohAUzFXeZ1MM3Bk9bfaUi36KsshV6djLMLZqHIXGIYzhRgak3Kw8rroGFUXPt
        Ptk+naSx3CBr+Z1cHsEXJv86he8kmFAtuksUG3QCTz1vJs6Sc2zYoW4OL8pdMCoL
        CpOYmo3FCpcq6FCFh/kQ79TJr9wKNgqzQHPQhJY7/2bJh2cOHJEHY0Rt0cNkEWIn
        S5CaQ==
X-ME-Sender: <xms:xv6lZEALBq0WU9zzMjK20i5m9drbh6BvrhjLIFKHLyZYDr2XVaAkyg>
    <xme:xv6lZGhmpEAqUnWmAOiQK49hD3Guf9rX2uxxGwh8xHD422-eXMpKc0y0LwjjHNdLt
    eFIbXNNGUxwDU3pS3o>
X-ME-Received: <xmr:xv6lZHliQclSPYA56VLa5JPNeNnz2J0rdvcRGXU-l4br-9I7SvYxlj_HOQbm62a4gT-lKsxXDoi3AGTxGH34x8os62c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:xv6lZKwPv2kbB6Mcy9LXxP6FFn76gOFsv9cfVcNKo62M5VPaqH70Jw>
    <xmx:xv6lZJT4QYVWs8eV14VyUNPSK1YYbqxEEIZww_X6WD4W0D0fAzZ0BA>
    <xmx:xv6lZFZrwgM0Jqx9-cmtOiiJX-KHTWW8m9sPWU-N288AwbsG3thHpw>
    <xmx:x_6lZK71YBiT7EcpSyplfjUjcLb0b1uBrFtQXzJuogl5VAXcXpTV1w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:42 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs-progs: simple quotas btrfstune
Date:   Wed,  5 Jul 2023 16:36:25 -0700
Message-ID: <97a649f080eef409746d4a4cd59f4c27e0bbb287.1688599734.git.boris@bur.io>
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

Add the ability to enable simple quotas on an existing file system at
rest with btrfstune.

This is similar to the functionality in mkfs, except it must also find
all the roots for which it must create qgroups. Note that this *does
not* retroactively compute usage for existing extents as that is
impossible for data. This is consistent with the behavior of the live
enable ioctl.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Makefile     |   2 +-
 tune/main.c  |  13 +++-
 tune/quota.c | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tune/tune.h  |   3 +
 4 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 tune/quota.c

diff --git a/Makefile b/Makefile
index 86c73590d..74862ff32 100644
--- a/Makefile
+++ b/Makefile
@@ -257,7 +257,7 @@ convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
-	       tune/convert-bgt.o tune/change-csum.o check/clear-cache.o
+	       tune/convert-bgt.o tune/change-csum.o tune/quota.o check/clear-cache.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
 
diff --git a/tune/main.c b/tune/main.c
index e38c1f6d3..b694d0da0 100644
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
@@ -147,6 +148,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	char *new_fsid_str = NULL;
 	int ret;
 	u64 super_flags = 0;
+	int quota = 0;
 	int fd = -1;
 
 	btrfs_config_init();
@@ -169,7 +171,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
+		int c = getopt_long(argc, argv, "S:rxqfuU:nmM:", long_options, NULL);
 
 		if (c < 0)
 			break;
@@ -184,6 +186,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case 'x':
 			super_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
 			break;
+		case 'q':
+			quota = 1;
+			break;
 		case 'n':
 			super_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
 			break;
@@ -241,7 +246,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
 	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
-	    !to_extent_tree && !to_fst) {
+	    !to_extent_tree && !to_fst && !quota) {
 		error("at least one option should be specified");
 		usage(&tune_cmd, 1);
 		return 1;
@@ -420,6 +425,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		total++;
 	}
 
+	if (quota) {
+		ret = enable_quota(root->fs_info, true);
+	}
+
 	if (success == total) {
 		ret = 0;
 	} else {
diff --git a/tune/quota.c b/tune/quota.c
new file mode 100644
index 000000000..7de5ef827
--- /dev/null
+++ b/tune/quota.c
@@ -0,0 +1,169 @@
+#include <errno.h>
+
+#include "common/messages.h"
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/transaction.h"
+#include "kernel-shared/uapi/btrfs_tree.h"
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
+	if (simple)
+		btrfs_set_qgroup_status_enable_gen(path.nodes[0], qsi, trans->transid);
+	else
+		flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
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
2.41.0


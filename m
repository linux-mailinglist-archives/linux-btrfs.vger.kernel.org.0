Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8101DEDFA5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfKDME1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbfKDME0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B19A8AF21
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:04:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 7/7] btrfs-progs: btrfstune: Allow to enable bg-tree feature offline
Date:   Mon,  4 Nov 2019 20:04:01 +0800
Message-Id: <20191104120401.56408-8-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120401.56408-1-wqu@suse.com>
References: <20191104120401.56408-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new option '-b' for btrfstune, to enable bg-tree feature for a
unmounted fs.

This feature will convert all BLOCK_GROUP_ITEMs in extent tree to bg
tree, by reusing the existing btrfs_convert_to_bg_tree() function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfstune.asciidoc |  6 +++++
 btrfstune.c                      | 45 ++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfstune.asciidoc b/Documentation/btrfstune.asciidoc
index 1d6bc98deed8..ccb89b44a701 100644
--- a/Documentation/btrfstune.asciidoc
+++ b/Documentation/btrfstune.asciidoc
@@ -26,6 +26,12 @@ means.  Please refer to the 'FILESYSTEM FEATURES' in `btrfs`(5).
 OPTIONS
 -------
 
+-b::
+(since kernel: 5.x)
++
+enable skinny-bg-tree feature (faster mount time for large fs), enabled by mkfs
+feature 'skinny-bg-tree'.
+
 -f::
 Allow dangerous changes, e.g. clear the seeding flag or change fsid. Make sure
 that you are aware of the dangers.
diff --git a/btrfstune.c b/btrfstune.c
index afa3aae35412..ba8b628a2f71 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -476,11 +476,40 @@ static void print_usage(void)
 	printf("\t-m          change fsid in metadata_uuid to a random UUID\n");
 	printf("\t            (incompat change, more lightweight than -u|-U)\n");
 	printf("\t-M UUID     change fsid in metadata_uuid to UUID\n");
+	printf("\t-b          enable skinny-bg-tree feature (mkfs: skinny-bg-tree)");
+	printf("\t            for faster mount time\n");
 	printf("  general:\n");
 	printf("\t-f          allow dangerous operations, make sure that you are aware of the dangers\n");
 	printf("\t--help      print this help\n");
 }
 
+static int convert_to_skinny_bg_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	ret = btrfs_convert_to_skinny_bg_tree(trans);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to convert: %m");
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+	}
+	return ret;
+}
+
 int BOX_MAIN(btrfstune)(int argc, char *argv[])
 {
 	struct btrfs_root *root;
@@ -491,6 +520,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	u64 seeding_value = 0;
 	int random_fsid = 0;
 	int change_metadata_uuid = 0;
+	bool to_skinny_bg_tree = false;
 	char *new_fsid_str = NULL;
 	int ret;
 	u64 super_flags = 0;
@@ -501,7 +531,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
+		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
 
 		if (c < 0)
 			break;
@@ -539,6 +569,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
 			change_metadata_uuid = 1;
 			break;
+		case 'b':
+			to_skinny_bg_tree = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			print_usage();
@@ -556,7 +589,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
-	    !change_metadata_uuid) {
+	    !change_metadata_uuid && !to_skinny_bg_tree) {
 		error("at least one option should be specified");
 		print_usage();
 		return 1;
@@ -602,6 +635,14 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		return 1;
 	}
 
+	if (to_skinny_bg_tree) {
+		ret = convert_to_skinny_bg_tree(root->fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to convert to bg-tree feature: %m");
+			goto out;
+		}
+	}
 	if (seeding_flag) {
 		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
 			fprintf(stderr, "SEED flag cannot be changed on a metadata-uuid changed fs\n");
-- 
2.23.0


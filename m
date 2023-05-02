Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624E76F3B96
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjEBBCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 21:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjEBBCS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 21:02:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774B3581
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 18:02:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5391022516
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682989327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TUcJVh/B4eJCR+B/LCdw6Xc0ScSbXPQUcD+61xs5nCU=;
        b=XmT5imTwmIuX/2kvmdgWLvT5Glhzs8TLfsGmHgkZ5CHaY8wa58Wa+EHruiEyI+H5JUSfjU
        snn6ynMz6akQdWNYxmg+wZjp4P/TSjjjbCaFsOUQIq138xkKkeUnKz9CcMAQTiC/ghFv+f
        0K8kvGUzXLuDVRsfA8V6BD4n66W0qTQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E7AD13580
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 01:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDdTGQ5hUGTldQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 01:02:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: tune: add --convert-to-free-space-tree option
Date:   Tue,  2 May 2023 09:01:45 +0800
Message-Id: <e37a2d335f50b94d19f993f24fe385930a61fc88.1682988988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682988988.git.wqu@suse.com>
References: <cover.1682988988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the very beginning of free-space-tree feature, we allow mount
option "space_cache=v2" to convert the filesystem to the new feature.

But this is not the proper practice for new features (no matter if it's
incompat or compat_ro).

This is already making the clear_cache/space_cache mount option more
complex.

Thus this patch introduces the proper way to enable free-space-tree, and
I hope one day we can deprecate the "space_cache=" mount option.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfstune.rst |  5 ++++
 Makefile                    |  2 +-
 check/clear-cache.c         |  4 +--
 check/clear-cache.h         |  1 +
 tune/main.c                 | 57 +++++++++++++++++++++++++++++++++++--
 5 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index d3543a47012e..9907c0535e4e 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -37,6 +37,11 @@ OPTIONS
         Convert block groups tracked in standalone block group tree back to
         extent tree and remove 'block-group-tree' feature bit from the filesystem.
 
+--convert-to-free-space-tree
+        (since kernel 4.5)
+
+        Convert to free space cache feature (v2 space cache).
+
 -f
         Allow dangerous changes, e.g. clear the seeding flag or change fsid.
         Make sure that you are aware of the dangers.
diff --git a/Makefile b/Makefile
index 4b0a869b6ca5..b03367f26158 100644
--- a/Makefile
+++ b/Makefile
@@ -250,7 +250,7 @@ convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
-	       tune/convert-bgt.o tune/change-csum.o
+	       tune/convert-bgt.o tune/change-csum.o check/clear-cache.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
 
diff --git a/check/clear-cache.c b/check/clear-cache.c
index 772d920fd397..8d06640cb826 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -35,7 +35,7 @@
  */
 #define NR_BLOCK_GROUP_CLUSTER		(16)
 
-static int clear_free_space_cache(struct btrfs_fs_info *fs_info)
+int btrfs_clear_v1_cache(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_group *bg_cache;
@@ -100,7 +100,7 @@ int do_clear_free_space_cache(struct btrfs_fs_info *fs_info,
 			warning(
 "free space cache v2 detected, use --clear-space-cache v2, proceeding with clearing v1");
 
-		ret = clear_free_space_cache(fs_info);
+		ret = btrfs_clear_v1_cache(fs_info);
 		if (ret) {
 			error("failed to clear free space cache");
 			ret = 1;
diff --git a/check/clear-cache.h b/check/clear-cache.h
index 78845e8d9557..1cdf49051244 100644
--- a/check/clear-cache.h
+++ b/check/clear-cache.h
@@ -21,6 +21,7 @@ struct btrfs_fs_info;
 struct btrfs_root;
 struct task_ctx;
 
+int btrfs_clear_v1_cache(struct btrfs_fs_info *fs_info);
 int do_clear_free_space_cache(struct btrfs_fs_info *fs_info, int clear_version);
 int validate_free_space_cache(struct btrfs_root *root, struct task_ctx *task_ctx);
 int truncate_free_ino_items(struct btrfs_root *root);
diff --git a/tune/main.c b/tune/main.c
index 891bea14ee5e..55ecae784ada 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -28,6 +28,8 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/free-space-cache.h"
+#include "kernel-shared/free-space-tree.h"
 #include "common/utils.h"
 #include "common/open-utils.h"
 #include "common/parse-utils.h"
@@ -38,6 +40,7 @@
 #include "common/box.h"
 #include "cmds/commands.h"
 #include "tune/tune.h"
+#include "check/clear-cache.h"
 
 static char *device;
 static int force = 0;
@@ -60,6 +63,36 @@ static int set_super_incompat_flags(struct btrfs_root *root, u64 flags)
 	return ret;
 }
 
+static int convert_to_fst(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	/* We may have invalid old v2 cache, clear them first. */
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		ret = btrfs_clear_free_space_tree(fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to clear stale v2 free space cache: %m");
+			return ret;
+		}
+	}
+	ret = btrfs_clear_v1_cache(fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to clear v1 free space cache: %m");
+		return ret;
+	}
+
+	ret = btrfs_create_free_space_tree(fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to create free space tree: %m");
+		return ret;
+	}
+	printf("Converted to free space tree feature\n");
+	return ret;
+}
+
 static const char * const tune_usage[] = {
 	"btrfstune [options] device",
 	"Tune settings of filesystem features on an unmounted device",
@@ -75,6 +108,8 @@ static const char * const tune_usage[] = {
 	OPTLINE("--convert-from-block-group-tree",
 			"convert the block group tree back to extent tree (remove the incompat bit)"),
 	"",
+	OPTLINE("--convert-to-free-space-tree",
+			"convert filesystem to use free space tree (v2 cache)"),
 	"UUID changes:",
 	OPTLINE("-u", "rewrite fsid, use a random one"),
 	OPTLINE("-U UUID", "rewrite fsid to UUID"),
@@ -108,6 +143,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	int change_metadata_uuid = 0;
 	bool to_extent_tree = false;
 	bool to_bg_tree = false;
+	bool to_fst = false;
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
 	int ret;
@@ -119,13 +155,16 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	while(1) {
 		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
 		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
-		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE };
+		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
+		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ "convert-to-block-group-tree", no_argument, NULL,
 				GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
 			{ "convert-from-block-group-tree", no_argument, NULL,
 				GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE},
+			{ "convert-to-free-space-tree", no_argument, NULL,
+				GETOPT_VAL_ENABLE_FREE_SPACE_TREE},
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
@@ -175,6 +214,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE:
 			to_extent_tree = true;
 			break;
+		case GETOPT_VAL_ENABLE_FREE_SPACE_TREE:
+			to_fst = true;
+			break;
 #if EXPERIMENTAL
 		case GETOPT_VAL_CSUM:
 			btrfs_warn_experimental(
@@ -200,7 +242,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
 	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
-	    !to_extent_tree) {
+	    !to_extent_tree && !to_fst) {
 		error("at least one option should be specified");
 		usage(&tune_cmd, 1);
 		return 1;
@@ -269,6 +311,17 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		}
 		goto out;
 	}
+	if (to_fst) {
+		if (btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
+			error("filesystem already has free-space-tree feature");
+			ret = 1;
+			goto out;
+		}
+		ret = convert_to_fst(root->fs_info);
+		if (ret < 0)
+			error("failed to convert the filesystem to free-space-tree feature");
+		goto out;
+	}
 	if (to_extent_tree) {
 		if (to_bg_tree) {
 			error("option --convert-to-block-group-tree conflicts with --convert-from-block-group-tree");
-- 
2.39.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56427C9E48
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 06:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjJPEjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 00:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjJPEjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 00:39:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD6D9
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Oct 2023 21:39:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A65E21C1C
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697431158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1WbWBJI8+MQoy8NMN3+1j6RhuNEp+sLJ5jGICa9haQ=;
        b=IRSoxDWMJu4w+Ok6MD5VnRNN/bs3xVVgaRdrlXPMHfVgzMcO2mpXhO9PZHlWu0gy6c1JaF
        zYq73QCmRvyAV8xxz1xssZu7kcNQ3xZzwsjyCixhqFLoD3drayG5L4gLDrrQ9Cc5PIM964
        OL5dOH5pr5OepqB/dsP+14zr/R+PPJ0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5796B138EF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6IxdBXW+LGUaFgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs-progs: mkfs: introduce experimental --subvol option
Date:   Mon, 16 Oct 2023 15:08:51 +1030
Message-ID: <bcb175042cb8b4036f532269235af02e10a69de5.1697430866.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697430866.git.wqu@suse.com>
References: <cover.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although mkfs.btrfs supports --rootdir to fill the target filesystem, it
doesn't have the ability to create any subvolume.

This patch introduce a very basic version of --subvol for mkfs.btrfs,
the limits are:

- No co-operation with --rootdir
  This requires --rootdir to have extra handling for any existing
  inodes.
  (Currently --rootdir assumes the fs tree is completely empty)

- No multiple --subvol options supports
  This requires us to collect and sort all the paths and start creating
  subvolumes from the shortest path.
  Furthermore this requires us to create subvolume under another
  subvolume.

For now, this patch focus on the basic checks on the provided subvolume
path, to wipe out any invalid things like ".." or something like "//////".

We support something like "//dir1/dir2///subvol///" just like VFS path
(duplicated '/' would just be ignored).

Issue: #42
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c    |  23 ++++++++
 mkfs/rootdir.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/rootdir.h |   1 +
 3 files changed, 181 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 42aa68b7ecf4..6bf30b758572 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -434,6 +434,9 @@ static const char * const mkfs_usage[] = {
 	"Creation:",
 	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (filesystem size is sum of all device sizes)"),
 	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root directory"),
+#if EXPERIMENTAL
+	OPTLINE("--subvol SUBVOL_NAME", "create a subvolume and all its parent directory"),
+#endif
 	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
 	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
@@ -1107,6 +1110,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *label = NULL;
 	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
 	char *source_dir = NULL;
+	char *subvol = NULL;
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1119,6 +1123,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			GETOPT_VAL_SHRINK = GETOPT_VAL_FIRST,
 			GETOPT_VAL_CHECKSUM,
 			GETOPT_VAL_GLOBAL_ROOTS,
+			GETOPT_VAL_SUBVOL,
 		};
 		static const struct option long_options[] = {
 			{ "byte-count", required_argument, NULL, 'b' },
@@ -1145,6 +1150,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
 #if EXPERIMENTAL
 			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },
+			{ "subvol", required_argument, NULL, GETOPT_VAL_SUBVOL},
 #endif
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
 			{ NULL, 0, NULL, 0}
@@ -1274,6 +1280,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				btrfs_warn_experimental("Feature: num-global-roots is part of exten-tree-v2");
 				nr_global_roots = (int)arg_strtou64(optarg);
 				break;
+			case GETOPT_VAL_SUBVOL:
+				btrfs_warn_experimental("Option --subvol is still experimental");
+				subvol = optarg;
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				usage(&mkfs_cmd, c != GETOPT_VAL_HELP);
@@ -1310,6 +1320,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if (source_dir && subvol) {
+		error("--subvol is not yet supported with --rootdir");
+		goto error;
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -1846,6 +1861,14 @@ raid_groups:
 		goto out;
 	}
 
+	/* Create the subvolumes. */
+	ret = btrfs_make_subvolume_at(fs_info, subvol);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to create subvolume \"%s\": %m", subvol);
+		goto out;
+	}
+
 	if (source_dir) {
 		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
 		ret = btrfs_mkfs_fill_dir(source_dir, root);
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index f6328c9df2ec..9c06f0a81593 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -36,6 +36,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/messages.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/path-utils.h"
@@ -975,3 +976,159 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 	}
 	return ret;
 }
+
+/*
+ * Create a subvolume at the path specififed by @full_path.
+ *
+ * The @full_path always starts at fs_tree root.
+ * All the parent directories would be created.
+ */
+int btrfs_make_subvolume_at(struct btrfs_fs_info *fs_info, const char *full_path)
+{
+	struct btrfs_root *root = fs_info->fs_root;
+	struct btrfs_root *subvol;
+	struct btrfs_trans_handle *trans;
+	u64 parent_ino = btrfs_root_dirid(&root->root_item);
+	u64 subvolid;
+	char *dump = strdup(full_path);
+	char *orig = dump;
+	char *filename;
+	int nr_filenames = 0;
+	int cur_filename = 0;
+	int ret = 0;
+
+	if (!dump)
+		return -ENOMEM;
+
+	/*
+	 * Get the number of valid filenames, this is to determine
+	 * if we're at the last filename (and needs to create a subvolume
+	 * other than a direcotry).
+	 */
+	while ((filename = strsep(&dump, "/")) != NULL) {
+		if (strlen(filename) == 0)
+			continue;
+		if (!strcmp(filename, "."))
+			continue;
+		if (!strcmp(filename, "..")) {
+			error("can not use \"..\" for subvolume path");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (strlen(filename) > NAME_MAX) {
+			error("direcotry name \"%s\" is too long, limit is %d",
+			      filename, NAME_MAX);
+			ret = -EINVAL;
+			goto out;
+		}
+		nr_filenames++;
+	}
+	free(orig);
+	orig = NULL;
+	dump = NULL;
+
+	/* Just some garbage full of '/'. */
+	if (nr_filenames == 0) {
+		error("'%s' contains no valid subvolume name", full_path);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dump = strdup(full_path);
+	orig = dump;
+
+	while ((filename = strsep(&dump, "/")) != NULL) {
+		u64 child_ino = 0;
+
+		if (strlen(filename) == 0)
+			continue;
+		if (!strcmp(filename, "."))
+			continue;
+		ASSERT(strcmp(filename, ".."));
+
+		if (cur_filename == nr_filenames - 1)
+			break;
+		/*
+		 * Need to modify the following items:
+		 * - Parent inode item
+		 *   Increase the size
+		 *
+		 * - Parent 1x DIR_INDEX and 1x DIR_ITEM items
+		 *
+		 * - New child inode item
+		 * - New child inode ref
+		 */
+		trans = btrfs_start_transaction(root, 4);
+		if (IS_ERR(trans)) {
+			errno = -ret;
+			error("failed to start transaction: %m");
+			ret = PTR_ERR(trans);
+			goto out;
+		}
+		ret = btrfs_mkdir(trans, root, filename, strlen(filename),
+				  parent_ino, &child_ino, 0755);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to create direcotry %s in root %lld: %m",
+			      filename, root->root_key.objectid);
+			goto out;
+		}
+		ret = btrfs_commit_transaction(trans, root);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to commit trans for direcotry %s in root %lld: %m",
+			      filename, root->root_key.objectid);
+			goto out;
+		}
+		parent_ino = child_ino;
+		cur_filename++;
+	}
+	if (!filename) {
+		ret = -EUCLEAN;
+		error("No valid subvolume name found");
+		goto out;
+	}
+
+	/* Create the final subvolume. */
+	trans = btrfs_start_transaction(fs_info->tree_root, 4);
+	if (IS_ERR(trans)) {
+		errno = -ret;
+		error("failed to start transaction for subvolume creation %s: %m",
+		      filename);
+		goto out;
+	}
+	ret = btrfs_find_free_objectid(NULL, fs_info->tree_root,
+				       BTRFS_FIRST_FREE_OBJECTID, &subvolid);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to find a free objectid for subvolume %s: %m",
+		      filename);
+		goto out;
+	}
+	subvol = btrfs_create_subvol(trans, subvolid);
+	if (IS_ERR(subvol)) {
+		ret = PTR_ERR(subvol);
+		errno = -ret;
+		error("failed to create subvolume %s: %m",
+		      filename);
+		goto out;
+	}
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		goto out;
+	}
+	subvol = btrfs_link_subvol(fs_info->fs_root, parent_ino, filename,
+				   subvol->root_key.objectid, false);
+	if (IS_ERR(subvol)) {
+		ret = PTR_ERR(subvol);
+		errno = -ret;
+		error("failed to link subvol %s: %m", filename);
+		goto out;
+	}
+	ret = 0;
+out:
+	free(orig);
+	return ret;
+}
diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
index 8d5f6896c3d9..1b21f30e80b5 100644
--- a/mkfs/rootdir.h
+++ b/mkfs/rootdir.h
@@ -41,5 +41,6 @@ u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 			u64 meta_profile, u64 data_profile);
 int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 			 bool shrink_file_size);
+int btrfs_make_subvolume_at(struct btrfs_fs_info *fs_info, const char *full_path);
 
 #endif
-- 
2.42.0


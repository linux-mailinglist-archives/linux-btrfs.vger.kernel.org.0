Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0485DE845
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfJUJiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 05:38:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfJUJiI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 05:38:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0055DB777
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 09:38:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: check: Introduce optional argument for -b|--backup
Date:   Mon, 21 Oct 2019 17:37:55 +0800
Message-Id: <20191021093755.56835-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021093755.56835-1-wqu@suse.com>
References: <20191021093755.56835-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an optional argument, <gen_diff> for -b|--backup.

This optional argument allow user to specify the generation difference
to search for the best backup root.

The value values are: -3, -2, -1.

To co-operate with this change, the following modifications are made:
- Man page and help string update

- New OPEN_CTREE flags and helpers are introduced
  OPEN_CTREE_BACKUP_GEN_DIFF[123] are introduced to replace old single
  bit OPEN_CTREE_BACKUP_ROOT.
  New helpers backup_gen_diff_to_cflags() and
  cflags_to_backup_gen_diff() are introduced to do the convert.
  So that we can keep the old open_ctree() interface without introducing
  new parameters.

- New arg_strol() helper to get negative int

- New btrfs_fs_info::backup_gen_diff member
  Now btrfs_setup_all_roots() uses that member to search backup roots.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-check.asciidoc |  6 ++++--
 check/main.c                       | 33 ++++++++++++++++++++++++++----
 common/utils.h                     |  1 +
 ctree.h                            |  8 ++++++++
 disk-io.c                          | 25 ++++++++++++++++++----
 disk-io.h                          | 33 ++++++++++++++++++------------
 utils-lib.c                        | 17 +++++++++++++++
 7 files changed, 100 insertions(+), 23 deletions(-)

diff --git a/Documentation/btrfs-check.asciidoc b/Documentation/btrfs-check.asciidoc
index b963eae5cdce..84a4241069cf 100644
--- a/Documentation/btrfs-check.asciidoc
+++ b/Documentation/btrfs-check.asciidoc
@@ -41,8 +41,10 @@ filesystem, similarly the run time.
 SAFE OR ADVISORY OPTIONS
 ------------------------
 
--b|--backup::
-use the first valid set of backup roots stored in the superblock
+-b[<gen_diff>] | --backup[=<gen_diff>]::
+use the newest valid set of backup roots which is no older than 'generation + <gen_diff>'
++
+'<gen_diff>' is optional, if not given, default value is -1. Valid values are -3, -2 ,-1.
 +
 This can be combined with '--super' if some of the superblocks are damaged.
 
diff --git a/check/main.c b/check/main.c
index c2d0f3949c5e..46f3e3d4c5b5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9773,7 +9773,9 @@ static const char * const cmd_check_usage[] = {
 	"Options:",
 	"  starting point selection:",
 	"       -s|--super <superblock>     use this superblock copy",
-	"       -b|--backup                 use the first valid backup root copy",
+	"       -b|--backup[=<gen_diff>]    use the backup root with <gen_diff>",
+	"                                   <gen_diff> is an optional parameter,",
+	"                                   valid values are -3, -2, -1 (default).",
 	"       -r|--tree-root <bytenr>     use the given bytenr for the tree root",
 	"       --chunk-root <bytenr>       use the given bytenr for the chunk tree root",
 	"  operation modes:",
@@ -9799,6 +9801,17 @@ static const char * const cmd_check_usage[] = {
 	NULL
 };
 
+static unsigned backup_gen_diff_to_cflags(int backup_gen_diff)
+{
+	ASSERT(-3 <= backup_gen_diff && backup_gen_diff <= -1);
+
+	if (backup_gen_diff == -3)
+		return OPEN_CTREE_BACKUP_GEN_DIFF3;
+	if (backup_gen_diff == -2)
+		return OPEN_CTREE_BACKUP_GEN_DIFF2;
+	return OPEN_CTREE_BACKUP_GEN_DIFF1;
+}
+
 static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	struct cache_tree root_cache;
@@ -9818,6 +9831,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int qgroup_report = 0;
 	int qgroups_repaired = 0;
 	int qgroup_report_ret;
+	int backup_gen_diff;
 	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE;
 	int force = 0;
 
@@ -9838,7 +9852,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				GETOPT_VAL_INIT_EXTENT },
 			{ "check-data-csum", no_argument, NULL,
 				GETOPT_VAL_CHECK_CSUM },
-			{ "backup", no_argument, NULL, 'b' },
+			{ "backup", optional_argument, NULL, 'b' },
 			{ "subvol-extents", required_argument, NULL, 'E' },
 			{ "qgroup-report", no_argument, NULL, 'Q' },
 			{ "tree-root", required_argument, NULL, 'r' },
@@ -9853,13 +9867,24 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "as:br:pE:Q", long_options, NULL);
+		c = getopt_long(argc, argv, "as:b::r:pE:Q", long_options, NULL);
 		if (c < 0)
 			break;
 		switch(c) {
 			case 'a': /* ignored */ break;
 			case 'b':
-				ctree_flags |= OPEN_CTREE_BACKUP_ROOT;
+				if (optarg) {
+					backup_gen_diff = arg_strtol(optarg);
+				} else
+					backup_gen_diff = -1;
+				if (!(-3 <= backup_gen_diff &&
+				      backup_gen_diff <= -1)) {
+					error(
+					"backup_gen_diff must be in [-3, -1]");
+					exit(1);
+				}
+				ctree_flags |= backup_gen_diff_to_cflags(
+						backup_gen_diff);
 				break;
 			case 's':
 				num = arg_strtou64(optarg);
diff --git a/common/utils.h b/common/utils.h
index 7867fb0a35d9..26bc2b081356 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -68,6 +68,7 @@ const char *pretty_size_mode(u64 size, unsigned mode);
 u64 parse_size(char *s);
 u64 parse_qgroupid(const char *p);
 u64 arg_strtou64(const char *str);
+int long arg_strtol(const char *str);
 int open_file_or_dir(const char *fname, DIR **dirstream);
 int open_file_or_dir3(const char *fname, DIR **dirstream, int open_flags);
 void close_file_or_dir(int fd, DIR *dirstream);
diff --git a/ctree.h b/ctree.h
index 0d12563b7261..5f83d9631678 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1176,6 +1176,14 @@ struct btrfs_fs_info {
 	unsigned int finalize_on_close:1;
 
 	int transaction_aborted;
+	/*
+	 * The generation diff for backup root use.
+	 * Valid values are [-3, 0]
+	 * [-3, -1]:	Use backup root whose generation is no newer than
+	 *		current_gen + diff
+	 * 0:		Don't use backup root at all.
+	 */
+	int backup_gen_diff;
 
 	int (*free_extent_hook)(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 num_bytes, u64 parent,
diff --git a/disk-io.c b/disk-io.c
index 36db1be264cd..4186a6544dce 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -909,14 +909,18 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 	btrfs_setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
 	generation = btrfs_super_generation(sb);
 
-	if (!root_tree_bytenr && !(flags & OPEN_CTREE_BACKUP_ROOT)) {
+	if (!root_tree_bytenr && !fs_info->backup_gen_diff) {
 		root_tree_bytenr = btrfs_super_root(sb);
-	} else if (flags & OPEN_CTREE_BACKUP_ROOT) {
+	} else if (fs_info->backup_gen_diff) {
 		struct btrfs_root_backup *backup;
 		int index = find_best_backup_root(sb,
-					btrfs_super_generation(sb) - 1);
+					btrfs_super_generation(sb) +
+					fs_info->backup_gen_diff);
 		if (index < 0) {
-			error("can't find any valid backup root");
+			error(
+		"can't find valid backup root with no newer than gen %llu",
+			      btrfs_super_generation(sb) +
+			      fs_info->backup_gen_diff);
 			return -EIO;
 		}
 		backup = fs_info->super_copy->super_roots + index;
@@ -1150,6 +1154,17 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int cflags_to_backup_gen_diff(unsigned flags)
+{
+	if (flags & OPEN_CTREE_BACKUP_GEN_DIFF3)
+		return -3;
+	if (flags & OPEN_CTREE_BACKUP_GEN_DIFF2)
+		return -2;
+	if (flags & OPEN_CTREE_BACKUP_GEN_DIFF1)
+		return -1;
+	return 0;
+}
+
 static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 					     u64 sb_bytenr,
 					     u64 root_tree_bytenr,
@@ -1261,6 +1276,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 			   btrfs_header_chunk_tree_uuid(eb),
 			   BTRFS_UUID_SIZE);
 
+	fs_info->backup_gen_diff = cflags_to_backup_gen_diff(flags);
+
 	ret = btrfs_setup_all_roots(fs_info, root_tree_bytenr, flags);
 	if (ret && !(flags & __OPEN_CTREE_RETURN_CHUNK_ROOT) &&
 	    !fs_info->ignore_chunk_tree_error)
diff --git a/disk-io.h b/disk-io.h
index 7b5c3806ba98..cebedf8ff408 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -34,25 +34,23 @@ enum btrfs_open_ctree_flags {
 	OPEN_CTREE_WRITES		= (1U << 0),
 	/* Allow to open filesystem with some broken tree roots (eg log root) */
 	OPEN_CTREE_PARTIAL		= (1U << 1),
-	/* If primary root pinters are invalid, try backup copies */
-	OPEN_CTREE_BACKUP_ROOT		= (1U << 2),
 	/* Allow reading all superblock copies if the primary is damaged */
-	OPEN_CTREE_RECOVER_SUPER	= (1U << 3),
+	OPEN_CTREE_RECOVER_SUPER	= (1U << 2),
 	/* Restoring filesystem image */
-	OPEN_CTREE_RESTORE		= (1U << 4),
+	OPEN_CTREE_RESTORE		= (1U << 3),
 	/* Do not read block groups (extent tree) */
-	OPEN_CTREE_NO_BLOCK_GROUPS	= (1U << 5),
+	OPEN_CTREE_NO_BLOCK_GROUPS	= (1U << 4),
 	/* Open all devices in O_EXCL mode */
-	OPEN_CTREE_EXCLUSIVE		= (1U << 6),
+	OPEN_CTREE_EXCLUSIVE		= (1U << 5),
 	/* Do not scan devices */
-	OPEN_CTREE_NO_DEVICES		= (1U << 7),
+	OPEN_CTREE_NO_DEVICES		= (1U << 6),
 	/*
 	 * Don't print error messages if bytenr or checksums do not match in
 	 * tree block headers. Turn on by OPEN_CTREE_SUPPRESS_ERROR
 	 */
-	OPEN_CTREE_SUPPRESS_CHECK_BLOCK_ERRORS	= (1U << 8),
+	OPEN_CTREE_SUPPRESS_CHECK_BLOCK_ERRORS	= (1U << 7),
 	/* Return the chunk root */
-	__OPEN_CTREE_RETURN_CHUNK_ROOT	= (1U << 9),
+	__OPEN_CTREE_RETURN_CHUNK_ROOT	= (1U << 8),
 	OPEN_CTREE_CHUNK_ROOT_ONLY	= OPEN_CTREE_PARTIAL +
 					  OPEN_CTREE_SUPPRESS_CHECK_BLOCK_ERRORS +
 					  __OPEN_CTREE_RETURN_CHUNK_ROOT,
@@ -63,7 +61,7 @@ enum btrfs_open_ctree_flags {
 	 */
 
 	/* Ignore UUID mismatches */
-	OPEN_CTREE_IGNORE_FSID_MISMATCH	= (1U << 10),
+	OPEN_CTREE_IGNORE_FSID_MISMATCH	= (1U << 9),
 
 	/*
 	 * Allow open_ctree_fs_info() to return an incomplete fs_info with
@@ -71,20 +69,29 @@ enum btrfs_open_ctree_flags {
 	 * It's useful when chunks are corrupted.
 	 * Makes no sense for open_ctree variants returning btrfs_root.
 	 */
-	OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR = (1U << 11),
+	OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR = (1U << 10),
 
 	/*
 	 * Allow to open fs with temporary superblock (BTRFS_MAGIC_PARTIAL),
 	 * such fs contains very basic tree layout, just able to be opened.
 	 * Such temporary super is used for mkfs or convert.
 	 */
-	OPEN_CTREE_TEMPORARY_SUPER = (1U << 12),
+	OPEN_CTREE_TEMPORARY_SUPER = (1U << 11),
 
 	/*
 	 * Invalidate the free space tree (i.e., clear the FREE_SPACE_TREE_VALID
 	 * compat_ro bit).
 	 */
-	OPEN_CTREE_INVALIDATE_FST = (1U << 13),
+	OPEN_CTREE_INVALIDATE_FST = (1U << 12),
+
+	/*
+	 * If primary root pinters are invalid, try backup copies
+	 * The tailing number is the generation diff, for better
+	 * backup root control.
+	 */
+	OPEN_CTREE_BACKUP_GEN_DIFF1	= (1U << 13),
+	OPEN_CTREE_BACKUP_GEN_DIFF2	= (1U << 14),
+	OPEN_CTREE_BACKUP_GEN_DIFF3	= (1U << 15),
 };
 
 /*
diff --git a/utils-lib.c b/utils-lib.c
index 0202dd7677f0..2eb2bc8bbd0d 100644
--- a/utils-lib.c
+++ b/utils-lib.c
@@ -42,6 +42,23 @@ u64 arg_strtou64(const char *str)
 	return value;
 }
 
+int long arg_strtol(const char *str)
+{
+	int long value;
+	char *ptr_parse_end = NULL;
+
+	value = strtol(str, &ptr_parse_end, 0);
+	if (ptr_parse_end && *ptr_parse_end != '\0') {
+		error("%s is not a valid numeric value.", str);
+		exit(1);
+	}
+	if (errno == ERANGE) {
+		error("%s is out of valid range.", str);
+		exit(1);
+	}
+	return value;
+}
+
 /*
  * For a given:
  * - file or directory return the containing tree root id
-- 
2.23.0


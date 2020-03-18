Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD518965C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 08:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgCRHyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 03:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:58550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCRHyu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 03:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5630ADFF
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 07:54:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/4] btrfs-progs: image: Introduce -d option to dump data
Date:   Wed, 18 Mar 2020 15:54:32 +0800
Message-Id: <20200318075434.27258-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318075434.27258-1-wqu@suse.com>
References: <20200318075434.27258-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new data dump feature will dump the whole image, not long the
existing tree blocks but also all its data extents(*).

This feature will rely on the new dump format (_DUmP_v1), as it needs
extra large extent size limit, and older btrfs-image dump can't handle
such large item/cluster size.

Since we're dumping all extents including data extents, for the restored
image there is no need to use any extra super block flags to inform
kernel.
Kernel should just treat the restored image as any ordinary btrfs.

*: The data extents will be dumped as is, that's to say, even for
preallocated extent, its (meaningless) data will be read out and
dumpped.
This behavior will cause extra space usage for the image, but we can
skip all the complex partially shared preallocated extent check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c     | 53 +++++++++++++++++++++++++++++++++++++-----------
 image/metadump.h |  2 +-
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/image/main.c b/image/main.c
index 12faf5350566..3dadaf1a8617 100644
--- a/image/main.c
+++ b/image/main.c
@@ -52,7 +52,15 @@ const struct dump_version dump_versions[NR_DUMP_VERSIONS] = {
 	{ .version = 0,
 	  .max_pending_size = SZ_256K,
 	  .magic_cpu = 0xbd5c25e27295668bULL,
-	  .extra_sb_flags = 1 }
+	  .extra_sb_flags = 1 },
+	/*
+	 * The newer format, with much larger item size to contain
+	 * any data extent.
+	 */
+	{ .version = 1,
+	  .max_pending_size = SZ_256M,
+	  .magic_cpu = 0x31765f506d55445fULL, /* ascii _DUmP_v1, no null */
+	  .extra_sb_flags = 0 },
 };
 
 const struct dump_version *current_version = &dump_versions[0];
@@ -453,10 +461,14 @@ static void metadump_destroy(struct metadump_struct *md, int num_threads)
 
 static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
 			 FILE *out, int num_threads, int compress_level,
-			 enum sanitize_mode sanitize_names)
+			 bool dump_data, enum sanitize_mode sanitize_names)
 {
 	int i, ret = 0;
 
+	/* We need larger item/cluster limit for data extents */
+	if (dump_data)
+		current_version = &dump_versions[1];
+
 	memset(md, 0, sizeof(*md));
 	INIT_LIST_HEAD(&md->list);
 	INIT_LIST_HEAD(&md->ordered);
@@ -884,7 +896,7 @@ static int copy_space_cache(struct btrfs_root *root,
 }
 
 static int copy_from_extent_tree(struct metadump_struct *metadump,
-				 struct btrfs_path *path)
+				 struct btrfs_path *path, bool dump_data)
 {
 	struct btrfs_root *extent_root;
 	struct extent_buffer *leaf;
@@ -949,9 +961,15 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			if (btrfs_extent_flags(leaf, ei) &
-			    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+			    BTRFS_EXTENT_FLAG_TREE_BLOCK ||
+			    (dump_data && (btrfs_extent_flags(leaf, ei) &
+			     		   BTRFS_EXTENT_FLAG_DATA))) {
+				bool is_data;
+
+				is_data = btrfs_extent_flags(leaf, ei) &
+					  BTRFS_EXTENT_FLAG_DATA;
 				ret = add_extent(bytenr, num_bytes, metadump,
-						 0);
+						 is_data);
 				if (ret) {
 					error("unable to add block %llu: %d",
 						(unsigned long long)bytenr, ret);
@@ -974,7 +992,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 
 static int create_metadump(const char *input, FILE *out, int num_threads,
 			   int compress_level, enum sanitize_mode sanitize,
-			   int walk_trees)
+			   int walk_trees, bool dump_data)
 {
 	struct btrfs_root *root;
 	struct btrfs_path path;
@@ -989,7 +1007,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 	}
 
 	ret = metadump_init(&metadump, root, out, num_threads,
-			    compress_level, sanitize);
+			    compress_level, dump_data, sanitize);
 	if (ret) {
 		error("failed to initialize metadump: %d", ret);
 		close_ctree(root);
@@ -1021,7 +1039,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 			goto out;
 		}
 	} else {
-		ret = copy_from_extent_tree(&metadump, &path);
+		ret = copy_from_extent_tree(&metadump, &path, dump_data);
 		if (ret) {
 			err = ret;
 			goto out;
@@ -2808,6 +2826,7 @@ static void print_usage(int ret)
 	printf("\t-s      \tsanitize file names, use once to just use garbage, use twice if you want crc collisions\n");
 	printf("\t-w      \twalk all trees instead of using extent tree, do this if your extent tree is broken\n");
 	printf("\t-m	   \trestore for multiple devices\n");
+	printf("\t-d	   \talso dump data, conflicts with -w\n");
 	printf("\n");
 	printf("\tIn the dump mode, source is the btrfs device and target is the output file (use '-' for stdout).\n");
 	printf("\tIn the restore mode, source is the dumped image and target is the btrfs device/file.\n");
@@ -2827,6 +2846,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 	int ret;
 	enum sanitize_mode sanitize = SANITIZE_NONE;
 	int dev_cnt = 0;
+	bool dump_data = false;
 	int usage_error = 0;
 	FILE *out;
 
@@ -2835,7 +2855,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "rc:t:oswm", long_options, NULL);
+		int c = getopt_long(argc, argv, "rc:t:oswmd", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -2875,6 +2895,9 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			create = 0;
 			multi_devices = 1;
 			break;
+		case 'd':
+			dump_data = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			print_usage(c != GETOPT_VAL_HELP);
@@ -2893,10 +2916,15 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			"create and restore cannot be used at the same time");
 			usage_error++;
 		}
+		if (dump_data && walk_trees) {
+			error("-d conflicts with -w option");
+			usage_error++;
+		}
 	} else {
-		if (walk_trees || sanitize != SANITIZE_NONE || compress_level) {
+		if (walk_trees || sanitize != SANITIZE_NONE || compress_level ||
+		    dump_data) {
 			error(
-			"using -w, -s, -c options for restore makes no sense");
+		"using -w, -s, -c, -d options for restore makes no sense");
 			usage_error++;
 		}
 		if (multi_devices && dev_cnt < 2) {
@@ -2949,7 +2977,8 @@ int BOX_MAIN(image)(int argc, char *argv[])
 		}
 
 		ret = create_metadump(source, out, num_threads,
-				      compress_level, sanitize, walk_trees);
+				      compress_level, sanitize, walk_trees,
+				      dump_data);
 	} else {
 		ret = restore_metadump(source, out, old_restore, num_threads,
 				       0, target, multi_devices);
diff --git a/image/metadump.h b/image/metadump.h
index 941d4b827a24..a04f63a910d6 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -38,7 +38,7 @@ struct dump_version {
 	unsigned int extra_sb_flags:1;
 };
 
-#define NR_DUMP_VERSIONS	1
+#define NR_DUMP_VERSIONS	2
 extern const struct dump_version dump_versions[NR_DUMP_VERSIONS];
 const extern struct dump_version *current_version;
 
-- 
2.25.1


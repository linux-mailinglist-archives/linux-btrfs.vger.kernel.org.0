Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24DD3F593D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhHXHnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:43:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55630 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbhHXHmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:42:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7610020044
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629790876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4tZDm7DJwLoIorGaGOMRB4LBxQYySaLV4hNDnJHsJ8=;
        b=Mi9I9BxEmxtfmY0+R1eopoUl6PuWtzCUDb4LNLVShnyEeQrxpJOQA4y2C8SSu454fpZL6O
        +gXxysOMrq/AMVuPx1hdLfqq+ICgWRrqGRciZxlibEGaKgf1E9WAlVcWF30H7pLsmE5tsJ
        q0a/0I8LhC7Cbo3E6zJn7aJCiTwaMv8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7053C13942
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0PiTB5uiJGF8bwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 2/4] btrfs-progs: image: introduce -d option to dump data
Date:   Tue, 24 Aug 2021 15:41:06 +0800
Message-Id: <20210824074108.44759-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824074108.44759-1-wqu@suse.com>
References: <20210824074108.44759-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new experimental data dump feature will dump the whole image, not
only the existing tree blocks but also all its data extents(*).

This feature will rely on the new dump format (_DUmP_v1), as it needs
extra large extent size limit, and older btrfs-image dump can't handle
such large item/cluster size.

Since we're dumping all extents including data extents, for the restored
image there is no need to use any extra super block flags to inform
kernel.
Kernel should just treat the restored image as any ordinary btrfs.

This new feature will be hidden behind the experimental features, that's
to say, if --enable-experimental is not enabled, although we still have
the option, it will not do anything but output an error message.

*: The data extents will be dumped as is, that's to say, even for
preallocated extent, its (meaningless) data will be read out and
dumpped.
This behavior will cause extra space usage for the image, but we can
skip all the complex partially shared preallocated extent check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 62 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/image/main.c b/image/main.c
index 65a42ad7d85d..b57120875f72 100644
--- a/image/main.c
+++ b/image/main.c
@@ -53,7 +53,17 @@ const struct dump_version dump_versions[] = {
 	{ .version = 0,
 	  .max_pending_size = SZ_256K,
 	  .magic_cpu = 0xbd5c25e27295668bULL,
-	  .extra_sb_flags = 1 }
+	  .extra_sb_flags = 1 },
+#if EXPERIMENTAL
+	/*
+	 * The newer format, with much larger item size to contain
+	 * any data extent.
+	 */
+	{ .version = 1,
+	  .max_pending_size = SZ_256M,
+	  .magic_cpu = 0x31765f506d55445fULL, /* ascii _DUmP_v1, no null */
+	  .extra_sb_flags = 0 },
+#endif
 };
 
 const struct dump_version *current_version = &dump_versions[0];
@@ -455,10 +465,14 @@ static void metadump_destroy(struct metadump_struct *md, int num_threads)
 
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
@@ -886,7 +900,7 @@ static int copy_space_cache(struct btrfs_root *root,
 }
 
 static int copy_from_extent_tree(struct metadump_struct *metadump,
-				 struct btrfs_path *path)
+				 struct btrfs_path *path, bool dump_data)
 {
 	struct btrfs_root *extent_root;
 	struct extent_buffer *leaf;
@@ -951,9 +965,15 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			if (btrfs_extent_flags(leaf, ei) &
-			    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+			    BTRFS_EXTENT_FLAG_TREE_BLOCK ||
+			    (dump_data && (btrfs_extent_flags(leaf, ei) &
+					   BTRFS_EXTENT_FLAG_DATA))) {
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
@@ -976,7 +996,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 
 static int create_metadump(const char *input, FILE *out, int num_threads,
 			   int compress_level, enum sanitize_mode sanitize,
-			   int walk_trees)
+			   int walk_trees, bool dump_data)
 {
 	struct btrfs_root *root;
 	struct btrfs_path path;
@@ -991,7 +1011,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 	}
 
 	ret = metadump_init(&metadump, root, out, num_threads,
-			    compress_level, sanitize);
+			    compress_level, dump_data, sanitize);
 	if (ret) {
 		error("failed to initialize metadump: %d", ret);
 		close_ctree(root);
@@ -1023,7 +1043,7 @@ static int create_metadump(const char *input, FILE *out, int num_threads,
 			goto out;
 		}
 	} else {
-		ret = copy_from_extent_tree(&metadump, &path);
+		ret = copy_from_extent_tree(&metadump, &path, dump_data);
 		if (ret) {
 			err = ret;
 			goto out;
@@ -2929,6 +2949,7 @@ static void print_usage(int ret)
 	printf("\t-s      \tsanitize file names, use once to just use garbage, use twice if you want crc collisions\n");
 	printf("\t-w      \twalk all trees instead of using extent tree, do this if your extent tree is broken\n");
 	printf("\t-m	   \trestore for multiple devices\n");
+	printf("\t-d	   \talso dump data, conflicts with -w\n");
 	printf("\n");
 	printf("\tIn the dump mode, source is the btrfs device and target is the output file (use '-' for stdout).\n");
 	printf("\tIn the restore mode, source is the dumped image and target is the btrfs device/file.\n");
@@ -2948,6 +2969,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 	int ret;
 	enum sanitize_mode sanitize = SANITIZE_NONE;
 	int dev_cnt = 0;
+	bool dump_data = false;
 	int usage_error = 0;
 	FILE *out;
 
@@ -2956,7 +2978,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "rc:t:oswm", long_options, NULL);
+		int c = getopt_long(argc, argv, "rc:t:oswmd", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -2996,6 +3018,9 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			create = 0;
 			multi_devices = 1;
 			break;
+		case 'd':
+			dump_data = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			print_usage(c != GETOPT_VAL_HELP);
@@ -3008,16 +3033,28 @@ int BOX_MAIN(image)(int argc, char *argv[])
 
 	dev_cnt = argc - optind - 1;
 
+#if !EXPERIMENTAL
+	if (dump_data) {
+		error(
+"data dump feature is experimental and is not configured in this build");
+		print_usage(1);
+	}
+#endif
 	if (create) {
 		if (old_restore) {
 			error(
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
@@ -3070,7 +3107,8 @@ int BOX_MAIN(image)(int argc, char *argv[])
 		}
 
 		ret = create_metadump(source, out, num_threads,
-				      compress_level, sanitize, walk_trees);
+				      compress_level, sanitize, walk_trees,
+				      dump_data);
 	} else {
 		ret = restore_metadump(source, out, old_restore, num_threads,
 				       0, target, multi_devices);
-- 
2.32.0


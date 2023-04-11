Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E76DCFBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 04:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDKCb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 22:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKCb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 22:31:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0089270D
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 19:31:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B0811FDFE
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681180286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qnBM7DClDz1r4nDxQmy4gfkSeOL3vTGQlZ/PxSMxcs=;
        b=GzOj7p3T+IwgqY7Em3KI0VV5DP58vSRskSXIv/srYYIx3n7jAjTiHyqkR9BlXCzyu8DSLT
        vsoUkZ9e18z3GYMrnKTqzznO7lrTvJSZT30txPYgSSPG/YVAgEiN4bkOBFrrlXMS6N2NFz
        MYxAWgC39ZV9f9TnWNVm+vq51pmKlC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B13A13638
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eAAYM33GNGRWDgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: move block-group-tree out of experimental features
Date:   Tue, 11 Apr 2023 10:31:06 +0800
Message-Id: <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681180159.git.wqu@suse.com>
References: <cover.1681180159.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The feedback from the community on block group tree is very positive,
the only complain is, end users need to recompile btrfs-progs with
experimental features to enjoy the new feature.

So let's move it out of experimental features and let more people enjoy
faster mount speed.

Also change the option of btrfstune, from `-b` to
`--enable-block-group-tree` to avoid short option.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-man5.rst |  6 ++++++
 Documentation/btrfstune.rst  |  4 ++--
 Documentation/mkfs.btrfs.rst |  5 +++++
 common/fsfeatures.c          |  4 +---
 tune/main.c                  | 18 ++++++++----------
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
index b50064fe9931..c625a9585457 100644
--- a/Documentation/btrfs-man5.rst
+++ b/Documentation/btrfs-man5.rst
@@ -66,6 +66,12 @@ big_metadata
         the filesystem uses *nodesize* for metadata blocks, this can be bigger than the
         page size
 
+block_group_tree
+        (since: 6.1)
+
+        block group item representation using a dedicated b-tree, this can greatly
+        reduce mount time for large filesystems.
+
 compress_lzo
         (since: 2.6.38)
 
diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index f4400f1f527a..c84c1e7e7092 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -24,8 +24,8 @@ means.  Please refer to the *FILESYSTEM FEATURES* in :doc:`btrfs(5)<btrfs-man5>`
 OPTIONS
 -------
 
--b
-        (since kernel 6.1, needs experimental build of btrfs-progs)
+--enable-block-group-tree
+        (since kernel 6.1)
         Enable block group tree feature (greatly reduce mount time),
         enabled by mkfs feature *block-group-tree*.
 
diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index e80f4c5c83ee..fe52f4406bf2 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -283,6 +283,11 @@ free-space-tree
         Enable the free space tree (mount option *space_cache=v2*) for persisting the
         free space cache.
 
+block-group-tree
+        (kernel support since 6.1)
+
+        Enable the block group tree to greatly reduce mount time for large filesystems.
+
 BLOCK GROUPS, CHUNKS, RAID
 --------------------------
 
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 4aca96f6e4fe..50500c652265 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -171,7 +171,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "support zoned devices"
 	},
 #endif
-#if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
@@ -181,6 +180,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
+#if EXPERIMENTAL
 	{
 		.name		= "extent-tree-v2",
 		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
@@ -222,7 +222,6 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
 	},
-#if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
@@ -232,7 +231,6 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
-#endif
 	/* Keep this one last */
 	{
 		.name		= "list-all",
diff --git a/tune/main.c b/tune/main.c
index c5d2e37aef3d..f5a94cdbdb5f 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
 	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
 	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
 	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
+	OPTLINE("--enable-block-group-tree", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
 	"",
 	"UUID changes:",
 	OPTLINE("-u", "rewrite fsid, use a random one"),
@@ -84,7 +85,6 @@ static const char * const tune_usage[] = {
 	"",
 	"EXPERIMENTAL FEATURES:",
 	OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
-	OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
 #endif
 	NULL
 };
@@ -113,27 +113,22 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	btrfs_config_init();
 
 	while(1) {
-		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST };
+		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
+		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
+			{ "enable-block-group-tree", no_argument, NULL,
+				GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
-#if EXPERIMENTAL
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
-#else
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
-#endif
 
 		if (c < 0)
 			break;
 		switch(c) {
-		case 'b':
-			btrfs_warn_experimental("Feature: conversion to block-group-tree");
-			to_bg_tree = true;
-			break;
 		case 'S':
 			seeding_flag = 1;
 			seeding_value = arg_strtou64(optarg);
@@ -167,6 +162,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
 			change_metadata_uuid = 1;
 			break;
+		case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
+			to_bg_tree = true;
+			break;
 #if EXPERIMENTAL
 		case GETOPT_VAL_CSUM:
 			btrfs_warn_experimental(
-- 
2.39.2


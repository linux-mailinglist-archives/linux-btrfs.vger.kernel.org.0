Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7DA695B61
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 08:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBNH4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 02:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjBNH4C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 02:56:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07221A25
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 23:55:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1ABE20C43
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676361346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xkrosVPzr6xfdburQe52dwOXW/ay6S9oumwMjavj/xM=;
        b=bugWFzxa/N8c14qPLxsJdLWjP3E6c3L2dW/VCeA/IKYDe54vYfRwb6G4qzQRXNVwxmtblZ
        HohIXWmDi8RBiaWCKtVp8iust6PcrTvyLdYj88okkrZ/7u/BmSmjMcjVy+oaLWsThlETsf
        Eebztiph22AraWDC8waByhnSQn+TaW8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DDE013A21
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 07:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hr+YAII+62N4HQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 07:55:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: fsfeatures: remove the EXPERIMENTAL flags for block group tree runtime feature
Date:   Tue, 14 Feb 2023 15:55:28 +0800
Message-Id: <facda201bc63edb92c2cc58339a172479ff4eb95.1676361293.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This block group tree support is already in the v6.1 kernel, and I know
some adventurous users are already recompiling their progs to take
advantage of the new feature.

Especially the block group tree feature would reduce the mount time from
several minutes to several seconds for one of my friend.
(Of course, he is doing an offline convert using btrfstune)

I see now reason to hide this feature behind experimental flags.

This patch would:

- Remove EXPERIMENTAL tag for "block-group-tree" features
  This includes both -R and -O

- Remove EXPERIMENTAL tag for "btrfstune -b" option

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Also enable btrfstune support for block-group-tree
---
 common/fsfeatures.c | 4 ----
 tune/main.c         | 7 +------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 169e47e92582..ddd9c9419e84 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -175,7 +175,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "support zoned devices"
 	},
 #endif
-#if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
@@ -185,7 +184,6 @@ static const struct btrfs_feature mkfs_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
-#endif
 #if EXPERIMENTAL
 	{
 		.name		= "extent-tree-v2",
@@ -228,7 +226,6 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
 	},
-#if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
 		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
@@ -238,7 +235,6 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
 	},
-#endif
 	/* Keep this one last */
 	{
 		.name		= "list-all",
diff --git a/tune/main.c b/tune/main.c
index 79b676972b50..3bb6ed58b01d 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
 	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
 	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
 	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
+	OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
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
@@ -124,17 +124,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
-#if EXPERIMENTAL
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
-#else
-		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
-#endif
 
 		if (c < 0)
 			break;
 		switch(c) {
 		case 'b':
-			btrfs_warn_experimental("Feature: conversion to block-group-tree");
 			to_bg_tree = true;
 			break;
 		case 'S':
-- 
2.39.1


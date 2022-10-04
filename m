Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBC5F3C73
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Oct 2022 07:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJDF2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 01:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDF2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 01:28:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7E2AE03
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 22:28:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E102C1F8F3
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 05:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664861328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rDn2j1Q3NhvmM1OA2X7ngJeCCfCUpgknYlxhyN0OVYg=;
        b=kXzP6UrlHSlEFUaNLEtGBW1TLN+yGH4Y7bp1IFZbzEcgvOp3toBROcEtXhXBkFNkPV13wT
        duUkZBXlY9tC6jvjEeiHc1zDlGjibq3WdRNfPIWPuwW6StCizssvV02/yans1PDB3p8VWB
        U1eu5LBYwNGFqxxWmIQiL74AZQaTLlQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E665813A8F
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 05:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kTMhKo/EO2MVBgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Oct 2022 05:28:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: fsfeatures: properly merge -O and -R options
Date:   Tue,  4 Oct 2022 13:28:30 +0800
Message-Id: <adfa0e435cd68f6d107f7fb9fad1846880fd1c97.1664861095.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Commit "btrfs-progs: prepare merging compat feature lists" tries to
merged "-O" and "-R" options, as they don't correctly represents
btrfs features.

But that commit caused the following bug during mkfs:

  $ mkfs.btrfs -f -O block-group-tree  /dev/nvme0n1
  btrfs-progs v5.19.1
  See http://btrfs.wiki.kernel.org for more information.

  ERROR: superblock magic doesn't match
  ERROR: illegal nodesize 16384 (not equal to 4096 for mixed block group)

[CAUSE]
Currently btrfs_parse_fs_features() will return a u64, and reuse the
same u64 for both incompat and compat RO flags for experimental branch.

This can easily leads to conflicts, as
BTRFS_FEATURE_INCOMPAT_MIXED_BLOCK_GROUP and
BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE both share the same bit
(1 << 2).

Thus for above case, mkfs.btrfs believe it has set MIXED_BLOCK_GROUP
feature, but what we really want is BLOCK_GROUP_TREE.

[FIX]
Instead of incorrectly re-using the same bits in btrfs_feature, split
the old flags into 3 flags:

- incompat_flag
- compat_ro_flag
- generic_flag

The new @generic_flag will represent a unified fs feature, so we can
return a single u64 to represent all features, no matter if it's a pure
runtime one (like quota tree), or a incompat one (most features), or a
compat RO one (like free space tree, block group tree).

This also means, any caller of btrfs_parse_fs_features() should use
BTRFS_FEATURE_GENERIC_* flags to check if one feature is enabled, not
the direct BTRFS_FEATURE_INCOMPAT_* nor BTRFS_FEATURE_COMPAT_RO_* flags.

Also we introduce two new helpers:

- btrfs_generic_features_to_incompat_flags()
- btrfs_generic_features_to_compat_ro_flags()

So mkfs/convert can easily grab the needed flags.

Finally, since we now have a generic features, update mkfs to properly
output the features.

If we have experimental features enabled, we just output a unified
"Features:" line, while keep the old separate one for non-experimental
build.
As btrfs_parse_runtime_features() and btrfs_parse_fs_features() can all
handle the output correctly, for both experimental and non-experimental
builds.

Please fold this patch into the offending one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix convert test failure due to missing allowed features
---
 common/fsfeatures.c | 180 ++++++++++++++++++++++++++------------------
 common/fsfeatures.h |  59 +++++++++------
 convert/common.c    |  10 ++-
 convert/main.c      |  32 ++++----
 mkfs/common.c       |  41 +++++-----
 mkfs/common.h       |   9 ++-
 mkfs/main.c         |  66 +++++++++-------
 7 files changed, 228 insertions(+), 169 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 6dc7207e9800..92373278c35b 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -51,22 +51,22 @@ enum feature_source {
 	RUNTIME_FEATURES,
 };
 
-enum feature_compat {
-	/* Feature is backward compatible, read-write */
-	FEATURE_COMPAT,
-	/* Feature is backward compatible, read-only, filesystem can be mounted */
-	FEATURE_COMPAT_RO,
-	/* Feature is backward incompatible, filesystem cannot be mounted */
-	FEATURE_INCOMPAT
-};
-
 /*
  * Feature stability status and versions: compat <= safe <= default
  */
 struct btrfs_feature {
 	const char *name;
-	u64 flag;
-	enum feature_compat compat;
+	/*
+	 * Normally at least one of the flag should be set for
+	 * incompat/compat_ro_flags.
+	 * Although there are exceptions like QUOTA and LIST_ALL.
+	 */
+	u64 incompat_flag;
+	u64 compat_ro_flag;
+
+	/* This is the real flag mkfs should check. */
+	u64 generic_flag;
+
 	const char *sysfs_name;
 	/*
 	 * Compatibility with kernel of given version. Filesystem can be
@@ -92,8 +92,8 @@ struct btrfs_feature {
 static const struct btrfs_feature mkfs_features[] = {
 	{
 		.name		= "mixed-bg",
-		.flag		= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_MIXED_GROUPS,
 		.sysfs_name	= "mixed_groups",
 		VERSION_TO_STRING3(compat, 2,6,37),
 		VERSION_TO_STRING3(safe, 2,6,37),
@@ -103,8 +103,7 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "quota",
-		.flag		= BTRFS_RUNTIME_FEATURE_QUOTA,
-		.compat		= FEATURE_COMPAT_RO,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_QUOTA,
 		.sysfs_name	= NULL,
 		VERSION_TO_STRING2(compat, 3,4),
 		VERSION_NULL(safe),
@@ -114,8 +113,8 @@ static const struct btrfs_feature mkfs_features[] = {
 #endif
 	{
 		.name		= "extref",
-		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_EXTENDED_IREF,
 		.sysfs_name	= "extended_iref",
 		VERSION_TO_STRING2(compat, 3,7),
 		VERSION_TO_STRING2(safe, 3,12),
@@ -123,8 +122,8 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "increased hardlink limit per file to 65536"
 	}, {
 		.name		= "raid56",
-		.flag		= BTRFS_FEATURE_INCOMPAT_RAID56,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID56,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_RAID56,
 		.sysfs_name	= "raid56",
 		VERSION_TO_STRING2(compat, 3,9),
 		VERSION_NULL(safe),
@@ -132,8 +131,8 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "raid56 extended format"
 	}, {
 		.name		= "skinny-metadata",
-		.flag		= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_SKINNY_METADATA,
 		.sysfs_name	= "skinny_metadata",
 		VERSION_TO_STRING2(compat, 3,10),
 		VERSION_TO_STRING2(safe, 3,18),
@@ -141,8 +140,8 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "reduced-size metadata extent refs"
 	}, {
 		.name		= "no-holes",
-		.flag		= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_NO_HOLES,
 		.sysfs_name	= "no_holes",
 		VERSION_TO_STRING2(compat, 3,14),
 		VERSION_TO_STRING2(safe, 4,0),
@@ -152,8 +151,9 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "free-space-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE,
-		.compat		= FEATURE_COMPAT_RO,
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE,
 		.sysfs_name = "free_space_tree",
 		VERSION_TO_STRING2(compat, 4,5),
 		VERSION_TO_STRING2(safe, 4,9),
@@ -163,8 +163,8 @@ static const struct btrfs_feature mkfs_features[] = {
 #endif
 	{
 		.name		= "raid1c34",
-		.flag		= BTRFS_FEATURE_INCOMPAT_RAID1C34,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID1C34,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_RAID1C34,
 		.sysfs_name	= "raid1c34",
 		VERSION_TO_STRING2(compat, 5,5),
 		VERSION_NULL(safe),
@@ -174,8 +174,8 @@ static const struct btrfs_feature mkfs_features[] = {
 #ifdef BTRFS_ZONED
 	{
 		.name		= "zoned",
-		.flag		= BTRFS_FEATURE_INCOMPAT_ZONED,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_ZONED,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_ZONED,
 		.sysfs_name	= "zoned",
 		VERSION_TO_STRING2(compat, 5,12),
 		VERSION_NULL(safe),
@@ -186,9 +186,9 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
-		.compat		= FEATURE_COMPAT_RO,
-		.sysfs_name = "block_group_tree",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE,
+		.sysfs_name	= "block_group_tree",
 		VERSION_TO_STRING2(compat, 6,0),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
@@ -198,8 +198,8 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "extent-tree-v2",
-		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2,
 		.sysfs_name	= "extent_tree_v2",
 		VERSION_TO_STRING2(compat, 5,15),
 		VERSION_NULL(safe),
@@ -209,10 +209,9 @@ static const struct btrfs_feature mkfs_features[] = {
 #endif
 	/* Keep this one last */
 	{
-		.name = "list-all",
-		.flag = BTRFS_FEATURE_LIST_ALL,
-		.compat	= FEATURE_INCOMPAT,
-		.sysfs_name = NULL,
+		.name		= "list-all",
+		.generic_flag	= BTRFS_FEATURE_GENERIC_LIST_ALL,
+		.sysfs_name	= NULL,
 		VERSION_NULL(compat),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
@@ -223,15 +222,17 @@ static const struct btrfs_feature mkfs_features[] = {
 static const struct btrfs_feature runtime_features[] = {
 	{
 		.name		= "quota",
-		.flag		= BTRFS_RUNTIME_FEATURE_QUOTA,
 		.sysfs_name	= NULL,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_QUOTA,
 		VERSION_TO_STRING2(compat, 3,4),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
 		.desc		= "quota support (qgroups)"
 	}, {
 		.name		= "free-space-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE,
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE,
 		.sysfs_name = "free_space_tree",
 		VERSION_TO_STRING2(compat, 4,5),
 		VERSION_TO_STRING2(safe, 4,9),
@@ -241,9 +242,10 @@ static const struct btrfs_feature runtime_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
-		.sysfs_name	= "block_group_tree",
-		VERSION_TO_STRING2(compat, 6,1),
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
+		.generic_flag	= BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE,
+		.sysfs_name = "block_group_tree",
+		VERSION_TO_STRING2(compat, 6,0),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
@@ -251,10 +253,9 @@ static const struct btrfs_feature runtime_features[] = {
 #endif
 	/* Keep this one last */
 	{
-		.name = "list-all",
-		.flag = BTRFS_FEATURE_LIST_ALL,
-		.compat	= FEATURE_COMPAT_RO,
-		.sysfs_name = NULL,
+		.name		= "list-all",
+		.generic_flag	= BTRFS_FEATURE_GENERIC_LIST_ALL,
+		.sysfs_name	= NULL,
 		VERSION_NULL(compat),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
@@ -280,7 +281,7 @@ static const struct btrfs_feature *get_feature(int i, enum feature_source source
 	return NULL;
 }
 
-static int parse_one_fs_feature(const char *name, u64 *flags,
+static int parse_one_fs_feature(const char *name, u64 *generic_flags,
 				enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
@@ -291,10 +292,10 @@ static int parse_one_fs_feature(const char *name, u64 *flags,
 		const struct btrfs_feature *feat = get_feature(i, source);
 
 		if (name[0] == '^' && !strcmp(feat->name, name + 1)) {
-			*flags &= ~feat->flag;
+			*generic_flags &= ~feat->generic_flag;
 			found = 1;
 		} else if (!strcmp(feat->name, name)) {
-			*flags |= feat->flag;
+			*generic_flags |= feat->generic_flag;
 			found = 1;
 		}
 	}
@@ -302,7 +303,7 @@ static int parse_one_fs_feature(const char *name, u64 *flags,
 	return !found;
 }
 
-static void parse_features_to_string(char *buf, u64 flags,
+static void parse_features_to_string(char *buf, u64 generic_flags,
 				     enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
@@ -313,7 +314,7 @@ static void parse_features_to_string(char *buf, u64 flags,
 	for (i = 0; i < array_size; i++) {
 		const struct btrfs_feature *feat = get_feature(i, source);
 
-		if (flags & feat->flag) {
+		if (generic_flags & feat->generic_flag) {
 			if (*buf)
 				strcat(buf, ", ");
 			strcat(buf, feat->name);
@@ -321,17 +322,17 @@ static void parse_features_to_string(char *buf, u64 flags,
 	}
 }
 
-void btrfs_parse_fs_features_to_string(char *buf, u64 flags)
+void btrfs_parse_fs_features_to_string(char *buf, u64 generic_flags)
 {
-	parse_features_to_string(buf, flags, FS_FEATURES);
+	parse_features_to_string(buf, generic_flags, FS_FEATURES);
 }
 
-void btrfs_parse_runtime_features_to_string(char *buf, u64 flags)
+void btrfs_parse_runtime_features_to_string(char *buf, u64 generic_flags)
 {
-	parse_features_to_string(buf, flags, RUNTIME_FEATURES);
+	parse_features_to_string(buf, generic_flags, RUNTIME_FEATURES);
 }
 
-static void process_features(u64 flags, enum feature_source source)
+static void process_features(u64 generic_flags, enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
 	int i;
@@ -339,43 +340,45 @@ static void process_features(u64 flags, enum feature_source source)
 	for (i = 0; i < array_size; i++) {
 		const struct btrfs_feature *feat = get_feature(i, source);
 
-		if (flags & feat->flag && feat->name && feat->desc) {
-			printf("Turning ON incompat feature '%s': %s\n",
-				feat->name, feat->desc);
+		if (generic_flags & feat->generic_flag && feat->name && feat->desc) {
+			char *type_str;
+
+			if (feat->compat_ro_flag)
+				type_str = "compat ro";
+			else if (feat->incompat_flag)
+				type_str = "incompat";
+			else
+				type_str = "runtime";
+
+			printf("Turning ON %s feature '%s': %s\n",
+				type_str, feat->name, feat->desc);
 		}
 	}
 }
 
-void btrfs_process_fs_features(u64 flags)
+void btrfs_process_fs_features(u64 generic_flags)
 {
-	process_features(flags, FS_FEATURES);
+	process_features(generic_flags, FS_FEATURES);
 }
 
-void btrfs_process_runtime_features(u64 flags)
+void btrfs_process_runtime_features(u64 generic_flags)
 {
-	process_features(flags, RUNTIME_FEATURES);
+	process_features(generic_flags, RUNTIME_FEATURES);
 }
 
 static void list_all_features(u64 mask_disallowed, enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
 	int i;
-	char *prefix;
-
-	if (source == FS_FEATURES)
-		prefix = "Filesystem";
-	else if (source == RUNTIME_FEATURES)
-		prefix = "Runtime";
-	else
-		prefix = "UNKNOWN";
 
-	fprintf(stderr, "%s features available:\n", prefix);
+	fprintf(stderr, "features available:\n");
 	for (i = 0; i < array_size - 1; i++) {
 		const struct btrfs_feature *feat = get_feature(i, source);
 		const char *sep = "";
 
-		if (feat->flag & mask_disallowed)
+		if (feat->generic_flag & mask_disallowed)
 			continue;
+
 		fprintf(stderr, "%-20s- %s (", feat->name, feat->desc);
 		if (feat->compat_ver) {
 			fprintf(stderr, "compat=%s", feat->compat_str);
@@ -556,7 +559,7 @@ int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features)
 		error("illegal nodesize %u (not aligned to %u)",
 			nodesize, sectorsize);
 		return -1;
-	} else if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS &&
+	} else if (features & BTRFS_FEATURE_GENERIC_MIXED_GROUPS &&
 		   nodesize != sectorsize) {
 		error(
 		"illegal nodesize %u (not equal to %u for mixed block group)",
@@ -603,3 +606,30 @@ int btrfs_tree_search2_ioctl_supported(int fd)
 	return ret;
 }
 
+u64 btrfs_generic_features_to_incompat_flags(u64 generic_features)
+{
+	u64 ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mkfs_features); i++) {
+		const struct btrfs_feature *feature = &mkfs_features[i];
+
+		if (generic_features & feature->generic_flag)
+			ret |= feature->incompat_flag;
+	}
+	return ret;
+}
+
+u64 btrfs_generic_features_to_compat_ro_flags(u64 generic_features)
+{
+	u64 ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mkfs_features); i++) {
+		const struct btrfs_feature *feature = &mkfs_features[i];
+
+		if (generic_features & feature->generic_flag)
+			ret |= feature->compat_ro_flag;
+	}
+	return ret;
+}
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index fd7defc14031..44cad72c8285 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -21,34 +21,42 @@
 #include <stdio.h>
 #include "kernel-lib/sizes.h"
 
-#define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
-#define BTRFS_MKFS_DEFAULT_FEATURES 				\
-		(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF		\
-		| BTRFS_FEATURE_INCOMPAT_NO_HOLES		\
-		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
-
-#define BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES			\
-	(BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE)
-
 /*
- * Avoid multi-device features (RAID56), mixed block groups, and zoned mode
+ * Since our fsfeatures can contain both incompat and compat_ro flags,
+ * there has to be a generic feature flags.
  */
-#define BTRFS_CONVERT_ALLOWED_FEATURES				\
-	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
-	| BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL			\
-	| BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO			\
-	| BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD			\
-	| BTRFS_FEATURE_INCOMPAT_BIG_METADATA			\
-	| BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF			\
-	| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA		\
-	| BTRFS_FEATURE_INCOMPAT_NO_HOLES)
+#define BTRFS_FEATURE_GENERIC_MIXED_GROUPS	(1 << 0)
+#define BTRFS_FEATURE_GENERIC_QUOTA		(1 << 1)
+#define BTRFS_FEATURE_GENERIC_EXTENDED_IREF	(1 << 2)
+#define BTRFS_FEATURE_GENERIC_RAID56		(1 << 3)
+#define BTRFS_FEATURE_GENERIC_SKINNY_METADATA	(1 << 4)
+#define BTRFS_FEATURE_GENERIC_NO_HOLES		(1 << 5)
+#define BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE	(1 << 6)
+#define BTRFS_FEATURE_GENERIC_RAID1C34		(1 << 7)
+#define BTRFS_FEATURE_GENERIC_ZONED		(1 << 8)
+#define BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE	(1 << 9)
+#define BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2	(1 << 10)
+/* This should be the last one. */
+#define BTRFS_FEATURE_GENERIC_LIST_ALL		(1 << 15)
 
-#define BTRFS_FEATURE_LIST_ALL		(1ULL << 63)
+#define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
+#define BTRFS_MKFS_DEFAULT_GENERIC_FEATURES 		\
+	(BTRFS_FEATURE_GENERIC_EXTENDED_IREF |		\
+	 BTRFS_FEATURE_GENERIC_NO_HOLES |		\
+	 BTRFS_FEATURE_GENERIC_SKINNY_METADATA |	\
+	 BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE)
 
-#define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
-#define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
-#define BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE	(1ULL << 2)
+#define BTRFS_MKFS_DEFAULT_RUNTIME_GENERIC_FEATURES	\
+	(BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE)
 
+/* Avoid multi-device features, mixed block groups, and zoned mode */
+#define BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES		\
+       (BTRFS_FEATURE_GENERIC_QUOTA |			\
+        BTRFS_FEATURE_GENERIC_EXTENDED_IREF |		\
+        BTRFS_FEATURE_GENERIC_SKINNY_METADATA |		\
+        BTRFS_FEATURE_GENERIC_NO_HOLES |		\
+        BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE |		\
+        BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE)
 
 void btrfs_list_all_fs_features(u64 mask_disallowed);
 void btrfs_list_all_runtime_features(u64 mask_disallowed);
@@ -60,8 +68,11 @@ void btrfs_parse_fs_features_to_string(char *buf, u64 flags);
 void btrfs_parse_runtime_features_to_string(char *buf, u64 flags);
 void print_kernel_version(FILE *stream, u32 version);
 u32 get_running_kernel_version(void);
-int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features);
+int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 generic_features);
 int btrfs_check_sectorsize(u32 sectorsize);
 int btrfs_tree_search2_ioctl_supported(int fd);
 
+u64 btrfs_generic_features_to_incompat_flags(u64 generic_features);
+u64 btrfs_generic_features_to_compat_ro_flags(u64 generic_features);
+
 #endif
diff --git a/convert/common.c b/convert/common.c
index 6d5720083192..6589df6914ed 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -27,6 +27,7 @@
 #include "kernel-shared/volumes.h"
 #include "common/path-utils.h"
 #include "common/messages.h"
+#include "common/fsfeatures.h"
 #include "mkfs/common.h"
 #include "convert/common.h"
 #include "ioctl.h"
@@ -143,7 +144,10 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root(&super, chunk_bytenr);
 	btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
+	btrfs_set_super_incompat_flags(&super,
+			BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |
+			btrfs_generic_features_to_incompat_flags(
+				cfg->generic_features));
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
@@ -582,8 +586,8 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 	struct btrfs_disk_key tree_info_key;
 	struct btrfs_tree_block_info *info;
 	int itemsize;
-	int skinny_metadata = cfg->features &
-			      BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
+	int skinny_metadata = cfg->generic_features &
+			      BTRFS_FEATURE_GENERIC_SKINNY_METADATA;
 	int ret;
 
 	if (skinny_metadata)
diff --git a/convert/main.c b/convert/main.c
index 471580721e80..f3ab33fecb85 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1129,8 +1129,8 @@ static int convert_open_fs(const char *devname,
 }
 
 static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
-		const char *fslabel, int progress, u64 features, u16 csum_type,
-		char fsid[BTRFS_UUID_UNPARSED_SIZE])
+		const char *fslabel, int progress, u64 generic_features,
+		u16 csum_type, char fsid[BTRFS_UUID_UNPARSED_SIZE])
 {
 	int ret;
 	int fd = -1;
@@ -1170,15 +1170,15 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 "blocksize %u is not equal to the page size %u, converted filesystem won't mount on this system",
 			blocksize, getpagesize());
 
-	if (btrfs_check_nodesize(nodesize, blocksize, features))
+	if (btrfs_check_nodesize(nodesize, blocksize, generic_features))
 		goto fail;
 	fd = open(devname, O_RDWR);
 	if (fd < 0) {
 		error("unable to open %s: %m", devname);
 		goto fail;
 	}
-	btrfs_parse_fs_features_to_string(features_buf, features);
-	if (features == BTRFS_MKFS_DEFAULT_FEATURES)
+	btrfs_parse_fs_features_to_string(features_buf, generic_features);
+	if (generic_features == BTRFS_MKFS_DEFAULT_GENERIC_FEATURES)
 		strcat(features_buf, " (default)");
 
 	if (convert_flags & CONVERT_FLAG_COPY_FSID) {
@@ -1226,7 +1226,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = blocksize;
 	mkfs_cfg.stripesize = blocksize;
-	mkfs_cfg.features = features;
+	mkfs_cfg.generic_features = generic_features;
 	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
 
 	printf("Create initial btrfs filesystem\n");
@@ -1822,7 +1822,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 	int progress = 1;
 	char *file;
 	char fslabel[BTRFS_LABEL_SIZE] = { 0 };
-	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
+	u64 generic_features = BTRFS_MKFS_DEFAULT_GENERIC_FEATURES;
 	u16 csum_type = BTRFS_CSUM_TYPE_CRC32;
 	u32 copy_fsid = 0;
 	char fsid[BTRFS_UUID_UNPARSED_SIZE] = {0};
@@ -1892,7 +1892,8 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 				char *orig = strdup(optarg);
 				char *tmp = orig;
 
-				tmp = btrfs_parse_fs_features(tmp, &features);
+				tmp = btrfs_parse_fs_features(tmp,
+						&generic_features);
 				if (tmp) {
 					error("unrecognized filesystem feature: %s",
 							tmp);
@@ -1900,16 +1901,19 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 					exit(1);
 				}
 				free(orig);
-				if (features & BTRFS_FEATURE_LIST_ALL) {
+				if (generic_features &
+						BTRFS_FEATURE_GENERIC_LIST_ALL) {
 					btrfs_list_all_fs_features(
-						~BTRFS_CONVERT_ALLOWED_FEATURES);
+						~BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES);
 					exit(0);
 				}
-				if (features & ~BTRFS_CONVERT_ALLOWED_FEATURES) {
+				if (generic_features &
+				    ~BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES) {
 					char buf[64];
 
 					btrfs_parse_fs_features_to_string(buf,
-						features & ~BTRFS_CONVERT_ALLOWED_FEATURES);
+						generic_features &
+						~BTRFS_CONVERT_ALLOWED_GENERIC_FEATURES);
 					error("features not allowed for convert: %s",
 						buf);
 					exit(1);
@@ -1984,8 +1988,8 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 		cf |= noxattr ? 0 : CONVERT_FLAG_XATTR;
 		cf |= copy_fsid;
 		cf |= copylabel;
-		ret = do_convert(file, cf, nodesize, fslabel, progress, features,
-				 csum_type, fsid);
+		ret = do_convert(file, cf, nodesize, fslabel, progress,
+				 generic_features, csum_type, fsid);
 	}
 	if (ret)
 		return 1;
diff --git a/mkfs/common.c b/mkfs/common.c
index 1e8bf4d599e3..047c67d85cdf 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -84,8 +84,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	int blk;
 	int i;
 	u8 uuid[BTRFS_UUID_SIZE];
-	bool block_group_tree = !!(cfg->runtime_features &
-				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
+	bool block_group_tree = !!(cfg->generic_features &
+				   BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE);
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
@@ -372,19 +372,18 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u32 array_size;
 	u32 item_size;
 	u64 total_used = 0;
-	u64 ro_flags = 0;
-	int skinny_metadata = !!(cfg->features &
-				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
+	int skinny_metadata = !!(cfg->generic_features &
+				 BTRFS_FEATURE_GENERIC_SKINNY_METADATA);
 	u64 num_bytes;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	bool add_block_group = true;
-	bool free_space_tree = !!(cfg->runtime_features &
-				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
-	bool block_group_tree = !!(cfg->runtime_features &
-				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
-	bool extent_tree_v2 = !!(cfg->features &
-				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
+	bool free_space_tree = !!(cfg->generic_features &
+				  BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE);
+	bool block_group_tree = !!(cfg->generic_features &
+				   BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE);
+	bool extent_tree_v2 = !!(cfg->generic_features &
+				 BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2);
 
 	memcpy(blocks, default_blocks,
 	       sizeof(enum btrfs_mkfs_block) * ARRAY_SIZE(default_blocks));
@@ -405,7 +404,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (!free_space_tree)
 		mkfs_blocks_remove(blocks, &blocks_nr, MKFS_FREE_SPACE_TREE);
 
-	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
+	if ((cfg->generic_features & BTRFS_FEATURE_GENERIC_ZONED)) {
 		system_group_offset = zoned_system_group_offset(cfg->zone_size);
 		system_group_size = cfg->zone_size;
 	}
@@ -449,20 +448,18 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
-	if (cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)
+	if (cfg->generic_features & BTRFS_FEATURE_GENERIC_ZONED)
 		btrfs_set_super_cache_generation(&super, 0);
 	else
 		btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
-	if (free_space_tree) {
-		ro_flags |= (BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-			     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
-
+	btrfs_set_super_incompat_flags(&super,
+			btrfs_generic_features_to_incompat_flags(
+				cfg->generic_features));
+	if (free_space_tree)
 		btrfs_set_super_cache_generation(&super, 0);
-	}
-	if (block_group_tree)
-		ro_flags |= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
-	btrfs_set_super_compat_ro_flags(&super, ro_flags);
+	btrfs_set_super_compat_ro_flags(&super,
+			btrfs_generic_features_to_compat_ro_flags(
+				cfg->generic_features));
 
 	if (extent_tree_v2)
 		btrfs_set_super_nr_global_roots(&super, 1);
diff --git a/mkfs/common.h b/mkfs/common.h
index fbacc25e0012..0a020e7775a7 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -78,10 +78,11 @@ struct btrfs_mkfs_config {
 	u32 sectorsize;
 	u32 stripesize;
 	u32 leaf_data_size;
-	/* Bitfield of incompat features, BTRFS_FEATURE_INCOMPAT_* */
-	u64 features;
-	/* Bitfield of BTRFS_RUNTIME_FEATURE_* */
-	u64 runtime_features;
+	/*
+	 * Bitfield of generic features, BTRFS_FEATURE_GENERIC_*.
+	 * This covers all incompat and compat_ro flags.
+	 */
+	u64 generic_features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
 	/* checksum algorithm to use */
diff --git a/mkfs/main.c b/mkfs/main.c
index 228c4431fd9e..e71eb4b53103 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -998,8 +998,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 system_group_size;
 	/* Options */
 	bool force_overwrite = false;
-	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
-	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
+	u64 generic_features = BTRFS_MKFS_DEFAULT_GENERIC_FEATURES;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u32 nodesize = 0;
@@ -1108,7 +1107,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				char *orig = strdup(optarg);
 				char *tmp = orig;
 
-				tmp = btrfs_parse_fs_features(tmp, &features);
+				tmp = btrfs_parse_fs_features(tmp,
+						&generic_features);
 				if (tmp) {
 					error("unrecognized filesystem feature '%s'",
 							tmp);
@@ -1116,7 +1116,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					goto error;
 				}
 				free(orig);
-				if (features & BTRFS_FEATURE_LIST_ALL) {
+				if (generic_features &
+						BTRFS_FEATURE_GENERIC_LIST_ALL) {
 					btrfs_list_all_fs_features(0);
 					goto success;
 				}
@@ -1125,9 +1126,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case 'R': {
 				char *orig = strdup(optarg);
 				char *tmp = orig;
+				u64 runtime_generic_features = 0;
 
 				tmp = btrfs_parse_runtime_features(tmp,
-						&runtime_features);
+						&runtime_generic_features);
 				if (tmp) {
 					error("unrecognized runtime feature '%s'",
 					      tmp);
@@ -1135,10 +1137,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					goto error;
 				}
 				free(orig);
-				if (runtime_features & BTRFS_FEATURE_LIST_ALL) {
+				if (runtime_generic_features &
+				    BTRFS_FEATURE_GENERIC_LIST_ALL) {
 					btrfs_list_all_runtime_features(0);
 					goto success;
 				}
+				generic_features |= runtime_generic_features;
 				break;
 				}
 			case 's':
@@ -1204,7 +1208,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (device_count == 0)
 		print_usage(1);
 
-	opt_zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
+	opt_zoned = !!(generic_features & BTRFS_FEATURE_GENERIC_ZONED);
 
 	if (source_dir_set && device_count > 1) {
 		error("the option -r is limited to a single device");
@@ -1257,7 +1261,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	"Zoned: %s: host-managed device detected, setting zoned feature\n",
 			       file);
 		opt_zoned = true;
-		features |= BTRFS_FEATURE_INCOMPAT_ZONED;
+		generic_features |= BTRFS_FEATURE_GENERIC_ZONED;
 	}
 
 	/*
@@ -1295,27 +1299,28 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/*
-	 * FS features that can be set by other means than -O
+	 * Generic features that can be set by other means than -O
 	 * just set the bit here
 	 */
 	if (mixed)
-		features |= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS;
+		generic_features |= BTRFS_FEATURE_GENERIC_MIXED_GROUPS;
 
 	if ((data_profile | metadata_profile) & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		features |= BTRFS_FEATURE_INCOMPAT_RAID56;
+		generic_features |= BTRFS_FEATURE_GENERIC_RAID56;
 		warning("RAID5/6 support has known problems is strongly discouraged\n"
 			"\t to be used besides testing or evaluation.\n");
 	}
 
 	if ((data_profile | metadata_profile) &
 	    (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)) {
-		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
+		generic_features |= BTRFS_FEATURE_GENERIC_RAID1C34;
 	}
 
 	/* Extent tree v2 comes with a set of mandatory features. */
-	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
-		features |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
-		runtime_features |= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE;
+	if (generic_features & BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2) {
+		generic_features |= BTRFS_FEATURE_GENERIC_NO_HOLES;
+		generic_features |= BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE;
+		generic_features |= BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE;
 
 		if (!nr_global_roots) {
 			error("you must set a non-zero num-global-roots value");
@@ -1324,9 +1329,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* Block group tree feature requires no-holes and free-space-tree. */
-	if (runtime_features & BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE &&
-	    (!(features & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
-	     !(runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE))) {
+	if (generic_features & BTRFS_FEATURE_GENERIC_BLOCK_GROUP_TREE &&
+	    (!(generic_features & BTRFS_FEATURE_GENERIC_NO_HOLES) ||
+	     !(generic_features & BTRFS_FEATURE_GENERIC_FREE_SPACE_TREE))) {
 		error("block group tree requires no-holes and free-space-tree features");
 		exit(1);
 	}
@@ -1336,19 +1341,19 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			exit(1);
 		}
 
-		if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) {
+		if (generic_features & BTRFS_FEATURE_GENERIC_MIXED_GROUPS) {
 			error("cannot enable mixed-bg in zoned mode");
 			exit(1);
 		}
 
-		if (features & BTRFS_FEATURE_INCOMPAT_RAID56) {
+		if (generic_features & BTRFS_FEATURE_GENERIC_RAID56) {
 			error("cannot enable RAID5/6 in zoned mode");
 			exit(1);
 		}
 	}
 
 	if (btrfs_check_nodesize(nodesize, sectorsize,
-				 features))
+				 generic_features))
 		goto error;
 
 	if (sectorsize < sizeof(struct btrfs_super_block)) {
@@ -1537,8 +1542,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
-	mkfs_cfg.features = features;
-	mkfs_cfg.runtime_features = runtime_features;
+	mkfs_cfg.generic_features = generic_features;
 	mkfs_cfg.csum_type = csum_type;
 	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
 	if (opt_zoned)
@@ -1583,7 +1587,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+	if (generic_features & BTRFS_FEATURE_GENERIC_EXTENT_TREE_V2) {
 		ret = create_global_roots(trans, nr_global_roots);
 		if (ret) {
 			error("failed to create global roots: %d", ret);
@@ -1733,7 +1737,7 @@ raid_groups:
 		}
 	}
 
-	if (runtime_features & BTRFS_RUNTIME_FEATURE_QUOTA) {
+	if (generic_features & BTRFS_FEATURE_GENERIC_QUOTA) {
 		ret = setup_quota_root(fs_info);
 		if (ret < 0) {
 			error("failed to initialize quota: %d (%m)", ret);
@@ -1771,11 +1775,19 @@ raid_groups:
 		if (opt_zoned)
 			printf("  Zone size:        %s\n",
 			       pretty_size(fs_info->zone_size));
-		btrfs_parse_fs_features_to_string(features_buf, features);
+		btrfs_parse_fs_features_to_string(features_buf,
+						  generic_features);
+
+#if !EXPERIMENTAL
+		printf("Features:           %s\n", features_buf);
+		btrfs_parse_runtime_features_to_string(features_buf,
+				generic_features);
+#else
 		printf("Incompat features:  %s\n", features_buf);
 		btrfs_parse_runtime_features_to_string(features_buf,
-				runtime_features);
+				generic_features);
 		printf("Runtime features:   %s\n", features_buf);
+#endif
 		printf("Checksum:           %s",
 		       btrfs_super_csum_name(mkfs_cfg.csum_type));
 		printf("\n");
-- 
2.37.3


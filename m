Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33835F4D86
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJEBsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Oct 2022 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJEBse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Oct 2022 21:48:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284567C80
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Oct 2022 18:48:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7F131F8FF
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 01:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664934505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+2N1aYwfWS6XEnggZSQXOfHSCy/DER6bhmRlkJYJeRY=;
        b=UKXxhGf95eFIq3bIxPJ7GM6kwxss1eZ60pqCkk6W/FGZy30rtWNvGNChAuFJPt5c6XIpK7
        awv9992d2wQGEJiFNs6YTizDInSo8qr5SyqTnfe+pLFCMFRU2JkQmKS0fr3+bOfkfvgFfu
        vwytCF6mHZSfRZt2VScR+jeW3ykldL0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0226313345
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 01:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hReFLmjiPGNZawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Oct 2022 01:48:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4] btrfs-progs: fsfeatures: properly merge -O and -R options
Date:   Wed,  5 Oct 2022 09:48:07 +0800
Message-Id: <6df72bf7175552fb966a9529783febdf62bce971.1664934441.git.wqu@suse.com>
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

But that commit caused the following bug during mkfs for experimental
build:

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
- runtime_flag

The first two flags are easy to understand, the corresponding flag of
each feature.
The last runtime_flag is to compensate features which doesn't have any
on-disk flag set, like QUOTA and LIST_ALL.

And since we're no longer using a single u64 as features, we have to
introduce a new structure, btrfs_mkfs_features, to contain above 3
flags.

This also mean, things like default mkfs features must be converted to
use the new structure, thus those old macros are all converted to
const static structures:

- BTRFS_MKFS_DEFAULT_FEATURES + BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES
  -> btrfs_mkfs_default_features

- BTRFS_CONVERT_ALLOWED_FEATURES -> btrfs_convert_allowed_features

And since we're using a structure, it's not longer as easy to implement
a disallowed mask.

Thus functions with @mask_disallowed are all changed to using
an @allowed structure pointer (which can be NULL).

Finally if we have experimental features enabled, all features can be
specified by -O options, and we can output a unified feature list,
instead of the old split ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix convert test failure due to missing allowed features

v3:
- Fix a bug that we can not unset free-space-tree for non-experimental
  build

- Fix a bug that free-space-tree compat RO flags are not properly set
  for non-experimental build

v4:
- Address David's concern of new BTRFS_FEATURE_GENERIC_* defines
  By introducing a new btrfs_mkfs_features structure, so we don't need
  extra re-definitions.

  The amount of code change is still the same as v3, since we have a
  larger interface change.
---
 common/fsfeatures.c | 182 +++++++++++++++++++++++++-------------------
 common/fsfeatures.h |  83 ++++++++++++--------
 convert/common.c    |   4 +-
 convert/main.c      |  22 +++---
 mkfs/common.c       |  33 ++++----
 mkfs/common.h       |   6 +-
 mkfs/main.c         |  61 ++++++++-------
 7 files changed, 220 insertions(+), 171 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 6dc7207e9800..dc4b346c040a 100644
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
+
+	/*
+	 * At least one of the bit must be set in the following *_flag member.
+	 *
+	 * For features like list-all and quota which don't have any
+	 * incompat/compat_ro bit set, it go to runtime_flag.
+	 */
+	u64 incompat_flag;
+	u64 compat_ro_flag;
+	u64 runtime_flag;
+
 	const char *sysfs_name;
 	/*
 	 * Compatibility with kernel of given version. Filesystem can be
@@ -92,8 +92,7 @@ struct btrfs_feature {
 static const struct btrfs_feature mkfs_features[] = {
 	{
 		.name		= "mixed-bg",
-		.flag		= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS,
 		.sysfs_name	= "mixed_groups",
 		VERSION_TO_STRING3(compat, 2,6,37),
 		VERSION_TO_STRING3(safe, 2,6,37),
@@ -103,8 +102,7 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "quota",
-		.flag		= BTRFS_RUNTIME_FEATURE_QUOTA,
-		.compat		= FEATURE_COMPAT_RO,
+		.runtime_flag	= BTRFS_FEATURE_RUNTIME_QUOTA,
 		.sysfs_name	= NULL,
 		VERSION_TO_STRING2(compat, 3,4),
 		VERSION_NULL(safe),
@@ -114,8 +112,7 @@ static const struct btrfs_feature mkfs_features[] = {
 #endif
 	{
 		.name		= "extref",
-		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
 		.sysfs_name	= "extended_iref",
 		VERSION_TO_STRING2(compat, 3,7),
 		VERSION_TO_STRING2(safe, 3,12),
@@ -123,8 +120,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "increased hardlink limit per file to 65536"
 	}, {
 		.name		= "raid56",
-		.flag		= BTRFS_FEATURE_INCOMPAT_RAID56,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID56,
 		.sysfs_name	= "raid56",
 		VERSION_TO_STRING2(compat, 3,9),
 		VERSION_NULL(safe),
@@ -132,8 +128,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "raid56 extended format"
 	}, {
 		.name		= "skinny-metadata",
-		.flag		= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
 		.sysfs_name	= "skinny_metadata",
 		VERSION_TO_STRING2(compat, 3,10),
 		VERSION_TO_STRING2(safe, 3,18),
@@ -141,8 +136,7 @@ static const struct btrfs_feature mkfs_features[] = {
 		.desc		= "reduced-size metadata extent refs"
 	}, {
 		.name		= "no-holes",
-		.flag		= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
 		.sysfs_name	= "no_holes",
 		VERSION_TO_STRING2(compat, 3,14),
 		VERSION_TO_STRING2(safe, 4,0),
@@ -152,8 +146,8 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "free-space-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE,
-		.compat		= FEATURE_COMPAT_RO,
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
 		.sysfs_name = "free_space_tree",
 		VERSION_TO_STRING2(compat, 4,5),
 		VERSION_TO_STRING2(safe, 4,9),
@@ -163,8 +157,7 @@ static const struct btrfs_feature mkfs_features[] = {
 #endif
 	{
 		.name		= "raid1c34",
-		.flag		= BTRFS_FEATURE_INCOMPAT_RAID1C34,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID1C34,
 		.sysfs_name	= "raid1c34",
 		VERSION_TO_STRING2(compat, 5,5),
 		VERSION_NULL(safe),
@@ -174,8 +167,7 @@ static const struct btrfs_feature mkfs_features[] = {
 #ifdef BTRFS_ZONED
 	{
 		.name		= "zoned",
-		.flag		= BTRFS_FEATURE_INCOMPAT_ZONED,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_ZONED,
 		.sysfs_name	= "zoned",
 		VERSION_TO_STRING2(compat, 5,12),
 		VERSION_NULL(safe),
@@ -186,9 +178,8 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
-		.compat		= FEATURE_COMPAT_RO,
-		.sysfs_name = "block_group_tree",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
+		.sysfs_name	= "block_group_tree",
 		VERSION_TO_STRING2(compat, 6,0),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
@@ -198,8 +189,7 @@ static const struct btrfs_feature mkfs_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "extent-tree-v2",
-		.flag		= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
-		.compat		= FEATURE_INCOMPAT,
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
 		.sysfs_name	= "extent_tree_v2",
 		VERSION_TO_STRING2(compat, 5,15),
 		VERSION_NULL(safe),
@@ -209,21 +199,20 @@ static const struct btrfs_feature mkfs_features[] = {
 #endif
 	/* Keep this one last */
 	{
-		.name = "list-all",
-		.flag = BTRFS_FEATURE_LIST_ALL,
-		.compat	= FEATURE_INCOMPAT,
-		.sysfs_name = NULL,
+		.name		= "list-all",
+		.runtime_flag	= BTRFS_FEATURE_RUNTIME_LIST_ALL,
+		.sysfs_name	= NULL,
 		VERSION_NULL(compat),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
-		.desc = NULL
+		.desc		= NULL
 	}
 };
 
 static const struct btrfs_feature runtime_features[] = {
 	{
 		.name		= "quota",
-		.flag		= BTRFS_RUNTIME_FEATURE_QUOTA,
+		.runtime_flag	= BTRFS_FEATURE_RUNTIME_QUOTA,
 		.sysfs_name	= NULL,
 		VERSION_TO_STRING2(compat, 3,4),
 		VERSION_NULL(safe),
@@ -231,8 +220,9 @@ static const struct btrfs_feature runtime_features[] = {
 		.desc		= "quota support (qgroups)"
 	}, {
 		.name		= "free-space-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE,
-		.sysfs_name = "free_space_tree",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
+		.sysfs_name	= "free_space_tree",
 		VERSION_TO_STRING2(compat, 4,5),
 		VERSION_TO_STRING2(safe, 4,9),
 		VERSION_TO_STRING2(default, 5,15),
@@ -241,9 +231,9 @@ static const struct btrfs_feature runtime_features[] = {
 #if EXPERIMENTAL
 	{
 		.name		= "block-group-tree",
-		.flag		= BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
 		.sysfs_name	= "block_group_tree",
-		VERSION_TO_STRING2(compat, 6,1),
+		VERSION_TO_STRING2(compat, 6,0),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
@@ -251,14 +241,13 @@ static const struct btrfs_feature runtime_features[] = {
 #endif
 	/* Keep this one last */
 	{
-		.name = "list-all",
-		.flag = BTRFS_FEATURE_LIST_ALL,
-		.compat	= FEATURE_COMPAT_RO,
-		.sysfs_name = NULL,
+		.name		= "list-all",
+		.runtime_flag	= BTRFS_FEATURE_RUNTIME_LIST_ALL,
+		.sysfs_name	= NULL,
 		VERSION_NULL(compat),
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
-		.desc = NULL
+		.desc		= NULL
 	}
 };
 
@@ -280,7 +269,8 @@ static const struct btrfs_feature *get_feature(int i, enum feature_source source
 	return NULL;
 }
 
-static int parse_one_fs_feature(const char *name, u64 *flags,
+static int parse_one_fs_feature(const char *name,
+				struct btrfs_mkfs_features *features,
 				enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
@@ -291,10 +281,14 @@ static int parse_one_fs_feature(const char *name, u64 *flags,
 		const struct btrfs_feature *feat = get_feature(i, source);
 
 		if (name[0] == '^' && !strcmp(feat->name, name + 1)) {
-			*flags &= ~feat->flag;
+			features->compat_ro_flags &= ~feat->compat_ro_flag;
+			features->incompat_flags &= ~feat->incompat_flag;
+			features->runtime_flags &= ~feat->runtime_flag;
 			found = 1;
 		} else if (!strcmp(feat->name, name)) {
-			*flags |= feat->flag;
+			features->compat_ro_flags |= feat->compat_ro_flag;
+			features->incompat_flags |= feat->incompat_flag;
+			features->runtime_flags |= feat->runtime_flag;
 			found = 1;
 		}
 	}
@@ -302,7 +296,8 @@ static int parse_one_fs_feature(const char *name, u64 *flags,
 	return !found;
 }
 
-static void parse_features_to_string(char *buf, u64 flags,
+static void parse_features_to_string(char *buf,
+				     const struct btrfs_mkfs_features *features,
 				     enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
@@ -313,7 +308,9 @@ static void parse_features_to_string(char *buf, u64 flags,
 	for (i = 0; i < array_size; i++) {
 		const struct btrfs_feature *feat = get_feature(i, source);
 
-		if (flags & feat->flag) {
+		if (features->compat_ro_flags & feat->compat_ro_flag ||
+		    features->incompat_flags & feat->incompat_flag ||
+		    features->runtime_flags & feat->runtime_flag) {
 			if (*buf)
 				strcat(buf, ", ");
 			strcat(buf, feat->name);
@@ -321,17 +318,20 @@ static void parse_features_to_string(char *buf, u64 flags,
 	}
 }
 
-void btrfs_parse_fs_features_to_string(char *buf, u64 flags)
+void btrfs_parse_fs_features_to_string(char *buf,
+		const struct btrfs_mkfs_features *features)
 {
-	parse_features_to_string(buf, flags, FS_FEATURES);
+	parse_features_to_string(buf, features, FS_FEATURES);
 }
 
-void btrfs_parse_runtime_features_to_string(char *buf, u64 flags)
+void btrfs_parse_runtime_features_to_string(char *buf,
+		const struct btrfs_mkfs_features *features)
 {
-	parse_features_to_string(buf, flags, RUNTIME_FEATURES);
+	parse_features_to_string(buf, features, RUNTIME_FEATURES);
 }
 
-static void process_features(u64 flags, enum feature_source source)
+static void process_features(struct btrfs_mkfs_features *features,
+			     enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
 	int i;
@@ -339,24 +339,28 @@ static void process_features(u64 flags, enum feature_source source)
 	for (i = 0; i < array_size; i++) {
 		const struct btrfs_feature *feat = get_feature(i, source);
 
-		if (flags & feat->flag && feat->name && feat->desc) {
+		if ((features->compat_ro_flags & feat->compat_ro_flag ||
+		     features->incompat_flags & feat->incompat_flag ||
+		     features->runtime_flags & feat->runtime_flag) &&
+		    feat->name && feat->desc) {
 			printf("Turning ON incompat feature '%s': %s\n",
 				feat->name, feat->desc);
 		}
 	}
 }
 
-void btrfs_process_fs_features(u64 flags)
+void btrfs_process_fs_features(struct btrfs_mkfs_features *features)
 {
-	process_features(flags, FS_FEATURES);
+	process_features(features, FS_FEATURES);
 }
 
-void btrfs_process_runtime_features(u64 flags)
+void btrfs_process_runtime_features(struct btrfs_mkfs_features *features)
 {
-	process_features(flags, RUNTIME_FEATURES);
+	process_features(features, RUNTIME_FEATURES);
 }
 
-static void list_all_features(u64 mask_disallowed, enum feature_source source)
+static void list_all_features(const struct btrfs_mkfs_features *allowed,
+			      enum feature_source source)
 {
 	const int array_size = get_feature_array_size(source);
 	int i;
@@ -374,8 +378,13 @@ static void list_all_features(u64 mask_disallowed, enum feature_source source)
 		const struct btrfs_feature *feat = get_feature(i, source);
 		const char *sep = "";
 
-		if (feat->flag & mask_disallowed)
+		/* The feature is not in the allowed one, skip it. */
+		if (allowed &&
+		    !(feat->compat_ro_flag & allowed->compat_ro_flags ||
+		      feat->incompat_flag & allowed->incompat_flags ||
+		      feat->runtime_flag & allowed->runtime_flags))
 			continue;
+
 		fprintf(stderr, "%-20s- %s (", feat->name, feat->desc);
 		if (feat->compat_ver) {
 			fprintf(stderr, "compat=%s", feat->compat_str);
@@ -391,21 +400,24 @@ static void list_all_features(u64 mask_disallowed, enum feature_source source)
 	}
 }
 
-void btrfs_list_all_fs_features(u64 mask_disallowed)
+/* @allowed can be null, then all features will be listed. */
+void btrfs_list_all_fs_features(const struct btrfs_mkfs_features *allowed)
 {
-	list_all_features(mask_disallowed, FS_FEATURES);
+	list_all_features(allowed, FS_FEATURES);
 }
 
-void btrfs_list_all_runtime_features(u64 mask_disallowed)
+/* @allowed can be null, then all runtime features will be listed. */
+void btrfs_list_all_runtime_features(const struct btrfs_mkfs_features *allowed)
 {
-	list_all_features(mask_disallowed, RUNTIME_FEATURES);
+	list_all_features(allowed, RUNTIME_FEATURES);
 }
 
 /*
  * Return NULL if all features were parsed fine, otherwise return the name of
  * the first unparsed.
  */
-static char *parse_features(char *namelist, u64 *flags,
+static char *parse_features(char *namelist,
+			    struct btrfs_mkfs_features *features,
 			    enum feature_source source)
 {
 	char *this_char;
@@ -414,21 +426,23 @@ static char *parse_features(char *namelist, u64 *flags,
 	for (this_char = strtok_r(namelist, ",", &save_ptr);
 	     this_char != NULL;
 	     this_char = strtok_r(NULL, ",", &save_ptr)) {
-		if (parse_one_fs_feature(this_char, flags, source))
+		if (parse_one_fs_feature(this_char, features, source))
 			return this_char;
 	}
 
 	return NULL;
 }
 
-char *btrfs_parse_fs_features(char *namelist, u64 *flags)
+char *btrfs_parse_fs_features(char *namelist,
+		struct btrfs_mkfs_features *features)
 {
-	return parse_features(namelist, flags, FS_FEATURES);
+	return parse_features(namelist, features, FS_FEATURES);
 }
 
-char *btrfs_parse_runtime_features(char *namelist, u64 *flags)
+char *btrfs_parse_runtime_features(char *namelist,
+		struct btrfs_mkfs_features *features)
 {
-	return parse_features(namelist, flags, RUNTIME_FEATURES);
+	return parse_features(namelist, features, RUNTIME_FEATURES);
 }
 
 void print_kernel_version(FILE *stream, u32 version)
@@ -542,7 +556,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
 	return 0;
 }
 
-int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features)
+int btrfs_check_nodesize(u32 nodesize, u32 sectorsize,
+			 struct btrfs_mkfs_features *features)
 {
 	if (nodesize < sectorsize) {
 		error("illegal nodesize %u (smaller than %u)",
@@ -556,7 +571,8 @@ int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features)
 		error("illegal nodesize %u (not aligned to %u)",
 			nodesize, sectorsize);
 		return -1;
-	} else if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS &&
+	} else if (features->incompat_flags &
+		   BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS &&
 		   nodesize != sectorsize) {
 		error(
 		"illegal nodesize %u (not equal to %u for mixed block group)",
@@ -566,6 +582,16 @@ int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features)
 	return 0;
 }
 
+int btrfs_check_features(const struct btrfs_mkfs_features *features,
+			 const struct btrfs_mkfs_features *allowed)
+{
+	if (features->compat_ro_flags & ~allowed->compat_ro_flags ||
+	    features->incompat_flags & ~allowed->incompat_flags ||
+	    features->runtime_flags & ~allowed->runtime_flags)
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * Check if the BTRFS_IOC_TREE_SEARCH_V2 ioctl is supported on a given
  * filesystem, opened at fd
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index fd7defc14031..3b5a915c6012 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -22,46 +22,69 @@
 #include "kernel-lib/sizes.h"
 
 #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
-#define BTRFS_MKFS_DEFAULT_FEATURES 				\
-		(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF		\
-		| BTRFS_FEATURE_INCOMPAT_NO_HOLES		\
-		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
-
-#define BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES			\
-	(BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE)
 
 /*
- * Avoid multi-device features (RAID56), mixed block groups, and zoned mode
+ * Since one feature can set at least one bit in either
+ * incompat/compat_or/runtime flags, all mkfs features users should
+ * use this structure to parse the features.
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
+struct btrfs_mkfs_features {
+	u64 incompat_flags;
+	u64 compat_ro_flags;
+	u64 runtime_flags;
+};
 
-#define BTRFS_FEATURE_LIST_ALL		(1ULL << 63)
+#define BTRFS_FEATURE_RUNTIME_QUOTA		(1ULL << 0)
+#define BTRFS_FEATURE_RUNTIME_LIST_ALL		(1ULL << 1)
 
-#define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
-#define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
-#define BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE	(1ULL << 2)
+static const struct btrfs_mkfs_features btrfs_mkfs_default_features = {
+	.compat_ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
+	.incompat_flags	 = BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |
+			   BTRFS_FEATURE_INCOMPAT_NO_HOLES |
+			   BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
+};
 
+/*
+ * Avoid multi-device features (RAID56 and RAID1C34), mixed bgs, and zoned
+ * mode for btrfs-convert, as all supported fses are single device fses.
+ *
+ * Features like compression is disabled in btrfs-convert by default, as
+ * data is reusing the old data from the source fs.
+ * Corresponding flag will be set when the first compression write happens.
+ */
+static const struct btrfs_mkfs_features btrfs_convert_allowed_features = {
+	.compat_ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
+			   BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
+	.incompat_flags  = BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |
+			   BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL |
+			   BTRFS_FEATURE_INCOMPAT_BIG_METADATA |
+			   BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |
+			   BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |
+			   BTRFS_FEATURE_INCOMPAT_NO_HOLES,
+	.runtime_flags   = BTRFS_FEATURE_RUNTIME_QUOTA,
+};
 
-void btrfs_list_all_fs_features(u64 mask_disallowed);
-void btrfs_list_all_runtime_features(u64 mask_disallowed);
-char *btrfs_parse_fs_features(char *namelist, u64 *flags);
-char *btrfs_parse_runtime_features(char *namelist, u64 *flags);
-void btrfs_process_fs_features(u64 flags);
-void btrfs_process_runtime_features(u64 flags);
-void btrfs_parse_fs_features_to_string(char *buf, u64 flags);
-void btrfs_parse_runtime_features_to_string(char *buf, u64 flags);
+void btrfs_list_all_fs_features(const struct btrfs_mkfs_features *allowed);
+void btrfs_list_all_runtime_features(const struct btrfs_mkfs_features *allowed);
+char *btrfs_parse_fs_features(char *namelist,
+		struct btrfs_mkfs_features *features);
+char *btrfs_parse_runtime_features(char *namelist,
+		struct btrfs_mkfs_features *features);
+void btrfs_process_fs_features(struct btrfs_mkfs_features *features);
+void btrfs_process_runtime_features(struct btrfs_mkfs_features *features);
+void btrfs_parse_fs_features_to_string(char *buf,
+		const struct btrfs_mkfs_features *features);
+void btrfs_parse_runtime_features_to_string(char *buf,
+		const struct btrfs_mkfs_features *features);
 void print_kernel_version(FILE *stream, u32 version);
 u32 get_running_kernel_version(void);
-int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features);
+int btrfs_check_nodesize(u32 nodesize, u32 sectorsize,
+			 struct btrfs_mkfs_features *features);
 int btrfs_check_sectorsize(u32 sectorsize);
+int btrfs_check_features(const struct btrfs_mkfs_features *features,
+			 const struct btrfs_mkfs_features *allowed);
 int btrfs_tree_search2_ioctl_supported(int fd);
 
 #endif
diff --git a/convert/common.c b/convert/common.c
index 6d5720083192..1a85085f2e74 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -143,7 +143,7 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root(&super, chunk_bytenr);
 	btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
+	btrfs_set_super_incompat_flags(&super, cfg->features.incompat_flags);
 	if (cfg->label)
 		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
@@ -582,7 +582,7 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 	struct btrfs_disk_key tree_info_key;
 	struct btrfs_tree_block_info *info;
 	int itemsize;
-	int skinny_metadata = cfg->features &
+	int skinny_metadata = cfg->features.incompat_flags &
 			      BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
 	int ret;
 
diff --git a/convert/main.c b/convert/main.c
index 471580721e80..ca33de2cfb1b 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1129,7 +1129,8 @@ static int convert_open_fs(const char *devname,
 }
 
 static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
-		const char *fslabel, int progress, u64 features, u16 csum_type,
+		const char *fslabel, int progress,
+		struct btrfs_mkfs_features *features, u16 csum_type,
 		char fsid[BTRFS_UUID_UNPARSED_SIZE])
 {
 	int ret;
@@ -1178,7 +1179,8 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		goto fail;
 	}
 	btrfs_parse_fs_features_to_string(features_buf, features);
-	if (features == BTRFS_MKFS_DEFAULT_FEATURES)
+	if (!memcmp(features, &btrfs_mkfs_default_features,
+		   sizeof(struct btrfs_mkfs_features)))
 		strcat(features_buf, " (default)");
 
 	if (convert_flags & CONVERT_FLAG_COPY_FSID) {
@@ -1226,7 +1228,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = blocksize;
 	mkfs_cfg.stripesize = blocksize;
-	mkfs_cfg.features = features;
+	memcpy(&mkfs_cfg.features, features, sizeof(struct btrfs_mkfs_features));
 	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
 
 	printf("Create initial btrfs filesystem\n");
@@ -1822,7 +1824,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 	int progress = 1;
 	char *file;
 	char fslabel[BTRFS_LABEL_SIZE] = { 0 };
-	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
+	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
 	u16 csum_type = BTRFS_CSUM_TYPE_CRC32;
 	u32 copy_fsid = 0;
 	char fsid[BTRFS_UUID_UNPARSED_SIZE] = {0};
@@ -1900,16 +1902,18 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 					exit(1);
 				}
 				free(orig);
-				if (features & BTRFS_FEATURE_LIST_ALL) {
+				if (features.runtime_flags &
+				    BTRFS_FEATURE_RUNTIME_LIST_ALL) {
 					btrfs_list_all_fs_features(
-						~BTRFS_CONVERT_ALLOWED_FEATURES);
+						&btrfs_convert_allowed_features);
 					exit(0);
 				}
-				if (features & ~BTRFS_CONVERT_ALLOWED_FEATURES) {
+				if (btrfs_check_features(&features,
+						&btrfs_convert_allowed_features)) {
 					char buf[64];
 
 					btrfs_parse_fs_features_to_string(buf,
-						features & ~BTRFS_CONVERT_ALLOWED_FEATURES);
+						&btrfs_convert_allowed_features);
 					error("features not allowed for convert: %s",
 						buf);
 					exit(1);
@@ -1984,7 +1988,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 		cf |= noxattr ? 0 : CONVERT_FLAG_XATTR;
 		cf |= copy_fsid;
 		cf |= copylabel;
-		ret = do_convert(file, cf, nodesize, fslabel, progress, features,
+		ret = do_convert(file, cf, nodesize, fslabel, progress, &features,
 				 csum_type, fsid);
 	}
 	if (ret)
diff --git a/mkfs/common.c b/mkfs/common.c
index 1e8bf4d599e3..28aa79cb18f4 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -84,8 +84,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	int blk;
 	int i;
 	u8 uuid[BTRFS_UUID_SIZE];
-	bool block_group_tree = !!(cfg->runtime_features &
-				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
+	bool block_group_tree = !!(cfg->features.compat_ro_flags &
+				   BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE);
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
@@ -372,18 +372,17 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u32 array_size;
 	u32 item_size;
 	u64 total_used = 0;
-	u64 ro_flags = 0;
-	int skinny_metadata = !!(cfg->features &
+	int skinny_metadata = !!(cfg->features.incompat_flags &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	bool add_block_group = true;
-	bool free_space_tree = !!(cfg->runtime_features &
-				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
-	bool block_group_tree = !!(cfg->runtime_features &
-				   BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE);
-	bool extent_tree_v2 = !!(cfg->features &
+	bool free_space_tree = !!(cfg->features.compat_ro_flags &
+				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
+	bool block_group_tree = !!(cfg->features.compat_ro_flags &
+				   BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE);
+	bool extent_tree_v2 = !!(cfg->features.incompat_flags &
 				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
 	memcpy(blocks, default_blocks,
@@ -405,7 +404,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (!free_space_tree)
 		mkfs_blocks_remove(blocks, &blocks_nr, MKFS_FREE_SPACE_TREE);
 
-	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
+	if ((cfg->features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = zoned_system_group_offset(cfg->zone_size);
 		system_group_size = cfg->zone_size;
 	}
@@ -449,20 +448,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
 	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
-	if (cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)
+	if (cfg->features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED)
 		btrfs_set_super_cache_generation(&super, 0);
 	else
 		btrfs_set_super_cache_generation(&super, -1);
-	btrfs_set_super_incompat_flags(&super, cfg->features);
-	if (free_space_tree) {
-		ro_flags |= (BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-			     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
-
+	btrfs_set_super_incompat_flags(&super, cfg->features.incompat_flags);
+	if (free_space_tree)
 		btrfs_set_super_cache_generation(&super, 0);
-	}
-	if (block_group_tree)
-		ro_flags |= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
-	btrfs_set_super_compat_ro_flags(&super, ro_flags);
+	btrfs_set_super_compat_ro_flags(&super, cfg->features.compat_ro_flags);
 
 	if (extent_tree_v2)
 		btrfs_set_super_nr_global_roots(&super, 1);
diff --git a/mkfs/common.h b/mkfs/common.h
index fbacc25e0012..2a356301f878 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -27,6 +27,7 @@
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/ctree.h"
 #include "common/defs.h"
+#include "common/fsfeatures.h"
 
 struct btrfs_root;
 struct btrfs_trans_handle;
@@ -78,10 +79,7 @@ struct btrfs_mkfs_config {
 	u32 sectorsize;
 	u32 stripesize;
 	u32 leaf_data_size;
-	/* Bitfield of incompat features, BTRFS_FEATURE_INCOMPAT_* */
-	u64 features;
-	/* Bitfield of BTRFS_RUNTIME_FEATURE_* */
-	u64 runtime_features;
+	struct btrfs_mkfs_features features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
 	/* checksum algorithm to use */
diff --git a/mkfs/main.c b/mkfs/main.c
index 228c4431fd9e..90733c52c1bc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -998,8 +998,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 system_group_size;
 	/* Options */
 	bool force_overwrite = false;
-	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
-	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
+	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u32 nodesize = 0;
@@ -1116,8 +1115,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					goto error;
 				}
 				free(orig);
-				if (features & BTRFS_FEATURE_LIST_ALL) {
-					btrfs_list_all_fs_features(0);
+				if (features.runtime_flags &
+				    BTRFS_FEATURE_RUNTIME_LIST_ALL) {
+					btrfs_list_all_fs_features(NULL);
 					goto success;
 				}
 				break;
@@ -1127,7 +1127,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				char *tmp = orig;
 
 				tmp = btrfs_parse_runtime_features(tmp,
-						&runtime_features);
+						&features);
 				if (tmp) {
 					error("unrecognized runtime feature '%s'",
 					      tmp);
@@ -1135,8 +1135,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					goto error;
 				}
 				free(orig);
-				if (runtime_features & BTRFS_FEATURE_LIST_ALL) {
-					btrfs_list_all_runtime_features(0);
+				if (features.runtime_flags &
+				    BTRFS_FEATURE_RUNTIME_LIST_ALL) {
+					btrfs_list_all_runtime_features(NULL);
 					goto success;
 				}
 				break;
@@ -1204,7 +1205,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (device_count == 0)
 		print_usage(1);
 
-	opt_zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
+	opt_zoned = !!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED);
 
 	if (source_dir_set && device_count > 1) {
 		error("the option -r is limited to a single device");
@@ -1257,7 +1258,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	"Zoned: %s: host-managed device detected, setting zoned feature\n",
 			       file);
 		opt_zoned = true;
-		features |= BTRFS_FEATURE_INCOMPAT_ZONED;
+		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_ZONED;
 	}
 
 	/*
@@ -1299,23 +1300,26 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	 * just set the bit here
 	 */
 	if (mixed)
-		features |= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS;
+		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS;
 
 	if ((data_profile | metadata_profile) & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		features |= BTRFS_FEATURE_INCOMPAT_RAID56;
+		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_RAID56;
 		warning("RAID5/6 support has known problems is strongly discouraged\n"
 			"\t to be used besides testing or evaluation.\n");
 	}
 
 	if ((data_profile | metadata_profile) &
 	    (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)) {
-		features |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
+		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_RAID1C34;
 	}
 
 	/* Extent tree v2 comes with a set of mandatory features. */
-	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
-		features |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
-		runtime_features |= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE;
+	if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+		features.compat_ro_flags |=
+			BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+			BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
+			BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
 
 		if (!nr_global_roots) {
 			error("you must set a non-zero num-global-roots value");
@@ -1324,9 +1328,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* Block group tree feature requires no-holes and free-space-tree. */
-	if (runtime_features & BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE &&
-	    (!(features & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
-	     !(runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE))) {
+	if (features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE &&
+	    (!(features.incompat_flags & BTRFS_FEATURE_INCOMPAT_NO_HOLES) ||
+	     !(features.compat_ro_flags & BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE))) {
 		error("block group tree requires no-holes and free-space-tree features");
 		exit(1);
 	}
@@ -1336,19 +1340,18 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			exit(1);
 		}
 
-		if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) {
+		if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) {
 			error("cannot enable mixed-bg in zoned mode");
 			exit(1);
 		}
 
-		if (features & BTRFS_FEATURE_INCOMPAT_RAID56) {
+		if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_RAID56) {
 			error("cannot enable RAID5/6 in zoned mode");
 			exit(1);
 		}
 	}
 
-	if (btrfs_check_nodesize(nodesize, sectorsize,
-				 features))
+	if (btrfs_check_nodesize(nodesize, sectorsize, &features))
 		goto error;
 
 	if (sectorsize < sizeof(struct btrfs_super_block)) {
@@ -1538,7 +1541,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
-	mkfs_cfg.runtime_features = runtime_features;
 	mkfs_cfg.csum_type = csum_type;
 	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
 	if (opt_zoned)
@@ -1583,7 +1585,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+	if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
 		ret = create_global_roots(trans, nr_global_roots);
 		if (ret) {
 			error("failed to create global roots: %d", ret);
@@ -1733,7 +1735,7 @@ raid_groups:
 		}
 	}
 
-	if (runtime_features & BTRFS_RUNTIME_FEATURE_QUOTA) {
+	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA) {
 		ret = setup_quota_root(fs_info);
 		if (ret < 0) {
 			error("failed to initialize quota: %d (%m)", ret);
@@ -1771,11 +1773,14 @@ raid_groups:
 		if (opt_zoned)
 			printf("  Zone size:        %s\n",
 			       pretty_size(fs_info->zone_size));
-		btrfs_parse_fs_features_to_string(features_buf, features);
+		btrfs_parse_fs_features_to_string(features_buf, &features);
+#if EXPERIMENTAL
+		printf("Features:           %s\n", features_buf);
+#else
 		printf("Incompat features:  %s\n", features_buf);
-		btrfs_parse_runtime_features_to_string(features_buf,
-				runtime_features);
+		btrfs_parse_runtime_features_to_string(features_buf, &features);
 		printf("Runtime features:   %s\n", features_buf);
+#endif
 		printf("Checksum:           %s",
 		       btrfs_super_csum_name(mkfs_cfg.csum_type));
 		printf("\n");
-- 
2.37.3


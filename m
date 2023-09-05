Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33737926F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbjIEQDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353747AbjIEHwQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CACD2
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E084121832
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGb+raeZtxI4N5w3xxi6a4RHWlxDqp69uNMLWcchL30=;
        b=HMrPxud65983PtzLJ2uDOXiqZySi7e+8g4oHFRcqJ8V+wISy+DDBiCgloxvtLkB4stBkR1
        ey6btCZNZrhhn9+YtD5pIbsVFBr8eLdf0jnex1spGjhu65Tr8Uew8hm2Sr6xPVxi0Jr2wp
        sJst3AuI/hr8KT5u5+T2TJ4G1lOOR+4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3681D13911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0D9fOyne9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs-progs: cmds: add "btrfs tune set" subcommand group
Date:   Tue,  5 Sep 2023 15:51:44 +0800
Message-ID: <1c294f739f028da499cf7f57deb334f419979097.1693900169.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
References: <cover.1693900169.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As the first step to convert btrfstune into "btrfs tune" subcommand
group, this patch would add the following subcommand group:

 btrfs tune set <feature> [<device>]

For now the following features are supported:

- extref
- skinny-metadata
- no-holes
  All those are simple super block flags toggle.

- list-all
  This acts the same way as "mkfs.btrfs -O list-all", the difference is
  it would only list the supported features.
  (In the future, there will be "btrfs tune clear" subcommand, which
   would support a different set of features).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-tune.rst |  40 ++++++
 Documentation/btrfs.rst      |   5 +
 Documentation/conf.py        |   1 +
 Documentation/man-index.rst  |   1 +
 Makefile                     |   2 +-
 btrfs.c                      |   1 +
 cmds/commands.h              |   1 +
 cmds/tune.c                  | 227 +++++++++++++++++++++++++++++++++++
 8 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/btrfs-tune.rst
 create mode 100644 cmds/tune.c

diff --git a/Documentation/btrfs-tune.rst b/Documentation/btrfs-tune.rst
new file mode 100644
index 000000000000..827c92eadb72
--- /dev/null
+++ b/Documentation/btrfs-tune.rst
@@ -0,0 +1,40 @@
+btrfs-tune(8)
+==================
+
+SYNOPSIS
+--------
+
+**btrfs tune** <subcommand> [<args>]
+
+DESCRIPTION
+-----------
+
+:command:`btrfs tune` is used to tweak various btrfs features on a
+unmounted filesystem.
+
+SUBCOMMAND
+-----------
+
+set <feature> [<device>]
+        Set/enable a feature.
+
+        If *feature* is `list-all`, all supported features would be listed, and
+	no *device* parameter is needed.
+
+EXIT STATUS
+-----------
+
+**btrfs tune** returns a zero exit status if it succeeds. A non-zero value is
+returned in case of failure.
+
+AVAILABILITY
+------------
+
+**btrfs** is part of btrfs-progs.  Please refer to the documentation at
+`https://btrfs.readthedocs.io <https://btrfs.readthedocs.io>`_.
+
+SEE ALSO
+--------
+
+:doc:`mkfs.btrfs`,
+``mount(8)``
diff --git a/Documentation/btrfs.rst b/Documentation/btrfs.rst
index e878f158aaa1..5aea0d1a208c 100644
--- a/Documentation/btrfs.rst
+++ b/Documentation/btrfs.rst
@@ -134,6 +134,10 @@ subvolume
 	Create/delete/list/manage btrfs subvolume.
 	See :doc:`btrfs-subvolume` for details.
 
+tune
+	Change various btrfs features.
+	See :doc:`btrfs-tune` for details.
+
 .. _man-btrfs8-standalone-tools:
 
 STANDALONE TOOLS
@@ -150,6 +154,7 @@ btrfs-convert
         in-place conversion from ext2/3/4 filesystems to btrfs
 btrfstune
         tweak some filesystem properties on a unmounted filesystem
+	(will be replaced by `btrfs-tune`)
 btrfs-select-super
         rescue tool to overwrite primary superblock from a spare copy
 btrfs-find-root
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 1025e10d7206..e0801bca4686 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -66,6 +66,7 @@ man_pages = [
     ('btrfs-check', 'btrfs-check', 'check or repair a btrfs filesystem', '', 8),
     ('btrfs-balance', 'btrfs-balance', 'balance block groups on a btrfs filesystem', '', 8),
     ('btrfs-subvolume', 'btrfs-subvolume', 'manage btrfs subvolumes', '', 8),
+    ('btrfs-tune', 'btrfs-tune', 'tweak btrfs features', '', 8),
     ('btrfs-map-logical', 'btrfs-map-logical', 'map btrfs logical extent to physical extent', '', 8),
     ('btrfs', 'btrfs', 'a toolbox to manage btrfs filesystems', '', 8),
     ('mkfs.btrfs', 'mkfs.btrfs', 'create a btrfs filesystem', '', 8),
diff --git a/Documentation/man-index.rst b/Documentation/man-index.rst
index 36d45d2903ea..5fcd4cbc4bee 100644
--- a/Documentation/man-index.rst
+++ b/Documentation/man-index.rst
@@ -28,6 +28,7 @@ Manual pages
    btrfs-select-super
    btrfs-send
    btrfs-subvolume
+   btrfs-tune
    btrfstune
    fsck.btrfs
    mkfs.btrfs
diff --git a/Makefile b/Makefile
index f4feb1fff8e1..9857daaa42ac 100644
--- a/Makefile
+++ b/Makefile
@@ -239,7 +239,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/rescue-super-recover.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
-	       cmds/reflink.o \
+	       cmds/reflink.o cmds/tune.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o \
 	       check/clear-cache.o
 
diff --git a/btrfs.c b/btrfs.c
index 751f193ee2e0..c2dae0303ffe 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -389,6 +389,7 @@ static const struct cmd_group btrfs_cmd_group = {
 		&cmd_struct_scrub,
 		&cmd_struct_send,
 		&cmd_struct_subvolume,
+		&cmd_struct_tune,
 
 		/* Help and version stay last */
 		&cmd_struct_help,
diff --git a/cmds/commands.h b/cmds/commands.h
index 5ab7c881f634..aebacd718a7b 100644
--- a/cmds/commands.h
+++ b/cmds/commands.h
@@ -151,5 +151,6 @@ DECLARE_COMMAND(qgroup);
 DECLARE_COMMAND(replace);
 DECLARE_COMMAND(restore);
 DECLARE_COMMAND(rescue);
+DECLARE_COMMAND(tune);
 
 #endif
diff --git a/cmds/tune.c b/cmds/tune.c
new file mode 100644
index 000000000000..92c7b9f1502c
--- /dev/null
+++ b/cmds/tune.c
@@ -0,0 +1,227 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <unistd.h>
+#include "kerncompat.h"
+#include "cmds/commands.h"
+#include "common/help.h"
+#include "common/fsfeatures.h"
+#include "kernel-shared/messages.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/transaction.h"
+
+static const char * const cmd_tune_set_usage[] = {
+	"btrfs tune set <feature> [<device>]",
+	"Set/enable specified feature for the unmounted filesystem",
+	"",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
+	NULL,
+};
+
+static const struct btrfs_feature set_features[] = {
+	{
+		.name		= "extref",
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
+		.sysfs_name	= "extended_iref",
+		VERSION_TO_STRING2(compat, 3,7),
+		VERSION_TO_STRING2(safe, 3,12),
+		VERSION_TO_STRING2(default, 3,12),
+		.desc		= "increased hardlink limit per file to 65536"
+	}, {
+		.name		= "skinny-metadata",
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
+		.sysfs_name	= "skinny_metadata",
+		VERSION_TO_STRING2(compat, 3,10),
+		VERSION_TO_STRING2(safe, 3,18),
+		VERSION_TO_STRING2(default, 3,18),
+		.desc		= "reduced-size metadata extent refs"
+	}, {
+		.name		= "no-holes",
+		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
+		.sysfs_name	= "no_holes",
+		VERSION_TO_STRING2(compat, 3,14),
+		VERSION_TO_STRING2(safe, 4,0),
+		VERSION_TO_STRING2(default, 5,15),
+		.desc		= "no explicit hole extents for files"
+	},
+	/* Keep this one last */
+	{
+		.name		= "list-all",
+		.runtime_flag	= BTRFS_FEATURE_RUNTIME_LIST_ALL,
+		.sysfs_name	= NULL,
+		VERSION_NULL(compat),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= NULL
+	}
+};
+
+static void list_all_features(const char *prefix,
+			      const struct btrfs_feature *features,
+			      int nr_features)
+{
+	/* We should have at least one empty feature. */
+	ASSERT(nr_features > 1);
+
+	printf("features available to %s:\n", prefix);
+	for (int i = 0; i < nr_features - 1; i++) {
+		const struct btrfs_feature *feat = features + i;
+		const char *sep = "";
+
+		fprintf(stderr, "%-20s- %s (", feat->name, feat->desc);
+		if (feat->compat_ver) {
+			fprintf(stderr, "compat=%s", feat->compat_str);
+			sep = ", ";
+		}
+		if (feat->safe_ver) {
+			fprintf(stderr, "%ssafe=%s", sep, feat->safe_str);
+			sep = ", ";
+		}
+		if (feat->default_ver)
+			fprintf(stderr, "%sdefault=%s", sep, feat->default_str);
+		fprintf(stderr, ")\n");
+	}
+}
+
+static int check_features(const char *name, const struct btrfs_feature *features,
+			  int nr_features)
+{
+	bool found = false;
+
+	for (int i = 0; i < nr_features; i++) {
+		const struct btrfs_feature *feat = features + i;
+
+		if (!strcmp(feat->name, name)) {
+			found = true;
+			break;
+		}
+	}
+	if (found)
+		return 0;
+	return -EINVAL;
+}
+
+static int set_super_incompat_flags(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	struct btrfs_root *root = fs_info->tree_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_super_block *disk_super;
+	u64 super_flags;
+	int ret;
+
+	disk_super = fs_info->super_copy;
+	super_flags = btrfs_super_incompat_flags(disk_super);
+	super_flags |= flags;
+	trans = btrfs_start_transaction(root, 1);
+	BUG_ON(IS_ERR(trans));
+	btrfs_set_super_incompat_flags(disk_super, super_flags);
+	ret = btrfs_commit_transaction(trans, root);
+
+	return ret;
+}
+
+static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
+{
+	struct btrfs_fs_info *fs_info;
+	struct open_ctree_args oca = { 0 };
+	char *feature;
+	char *path;
+	int ret = 0;
+
+	optind = 0;
+	while (1) {
+		int c = getopt(argc, argv, "");
+		if (c < 0)
+			break;
+
+		switch (c) {
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+
+	if (check_argc_min(argc - optind, 1))
+		return 1;
+
+	feature = argv[optind];
+
+	if (check_features(feature, set_features, ARRAY_SIZE(set_features))) {
+		error("Unknown feature to set: %s", feature);
+		return 1;
+	}
+	if (!strcmp(feature, "list-all")) {
+		list_all_features("set", set_features, ARRAY_SIZE(set_features));
+		return 0;
+	}
+
+	if (check_argc_exact(argc - optind, 2))
+		return 1;
+
+	path = argv[optind + 1];
+	oca.flags = OPEN_CTREE_WRITES;
+	oca.filename = path;
+	fs_info = open_ctree_fs_info(&oca);
+	if (!fs_info) {
+		error("failed to open btrfs");
+		ret = -EIO;
+		goto out;
+	}
+	/*
+	 * For those 3 features, we only need to update the superblock to add
+	 * the new feature flags.
+	 */
+	if (!strcmp(feature, "extref") ||
+	    !strcmp(feature, "skinny-metadata") ||
+	    !strcmp(feature, "no-holes")) {
+		u64 incompat_flags = 0;
+
+		if (!strcmp(feature, "extref"))
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
+		if (!strcmp(feature, "skinny-metadata"))
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
+		if (!strcmp(feature, "no-holes"))
+			incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
+		ret = set_super_incompat_flags(fs_info, incompat_flags);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to set feature '%s': %m", feature);
+		}
+		goto out;
+	}
+
+out:
+	if (fs_info)
+		close_ctree_fs_info(fs_info);
+	return !!ret;
+}
+
+static DEFINE_SIMPLE_COMMAND(tune_set, "set");
+
+static const char * const tune_cmd_group_usage[] = {
+	"btrfs tune <command> <args>",
+	NULL,
+};
+
+static const char tune_cmd_group_info[] = "change various btrfs features";
+
+static const struct cmd_group tune_cmd_group = {
+	tune_cmd_group_usage, tune_cmd_group_info, {
+		&cmd_struct_tune_set,
+		NULL
+	}
+};
+DEFINE_GROUP_COMMAND_TOKEN(tune);
-- 
2.42.0


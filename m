Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC22792628
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbjIEQDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353751AbjIEHwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D033CCB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5206C1F750
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcgjDA8p9OrjoteXCujfMYZVyk8q/PBXrDbhLk7dj1c=;
        b=SbCbSXH8ynU8xqZhy3krVMmdcahM+DDbd3HA1yE6urkg/5FXT7G+q/2eXpM3fe/Optet3A
        jxYseCDmmf4ZrDC8D4nrWTgIc9I8+D5RlTxSre3bu4I0MGNszp7tmamDZ/jqSoHRJtNwGi
        fmZwkN/o/oPHjO0OQDoba14wBQv02lQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ADE313911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uEdgGC/e9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs-progs: cmds/tune: add "btrfs tune clear" subcommand
Date:   Tue,  5 Sep 2023 15:51:48 +0800
Message-ID: <d881bafa9ff5e902275e3188af52e73d2f5c0854.1693900169.git.wqu@suse.com>
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

This new "btrfs tune clear" subcommand is mostly the same as "btrfs tune
set", but with much less features supported:

- seed
- block-group-tree

For the features in "btrfs tune set" but not in "btrfs tune clear", they
are mostly default features now, and we won't support disabling those
features anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-tune.rst |   7 +++
 cmds/tune.c                  | 111 +++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/Documentation/btrfs-tune.rst b/Documentation/btrfs-tune.rst
index 827c92eadb72..4a556a197540 100644
--- a/Documentation/btrfs-tune.rst
+++ b/Documentation/btrfs-tune.rst
@@ -21,6 +21,13 @@ set <feature> [<device>]
         If *feature* is `list-all`, all supported features would be listed, and
 	no *device* parameter is needed.
 
+clear <feature> [<device>]
+        Set/enable a feature.
+
+        If *feature* is `list-all`, all supported features would be listed, and
+	no *device* parameter is needed. And the listed features may be different
+	compared to the ones from `btrfs tune set list-all`.
+
 EXIT STATUS
 -----------
 
diff --git a/cmds/tune.c b/cmds/tune.c
index 195d0a235fc8..a85d017ba2e1 100644
--- a/cmds/tune.c
+++ b/cmds/tune.c
@@ -321,6 +321,116 @@ out:
 
 static DEFINE_SIMPLE_COMMAND(tune_set, "set");
 
+static const struct btrfs_feature clear_features[] = {
+	{
+		.name		= "block-group-tree",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
+		.sysfs_name	= "block_group_tree",
+		VERSION_TO_STRING2(compat, 6,1),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "block group tree to reduce mount time"
+	}, {
+		.name		= "seed",
+		.sysfs_name	= NULL,
+		VERSION_TO_STRING3(compat, 2,6,29),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "seeding device support"
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
+static int cmd_tune_clear(const struct cmd_struct *cmd, int argc, char **argv)
+{
+	struct btrfs_fs_info *fs_info;
+	struct open_ctree_args oca = { 0 };
+	char *feature;
+	char *path;
+	int ret = 0;
+
+	optind = 0;
+	while (1) {
+		int c = getopt(argc, argv, "f");
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
+	if (check_features(feature, clear_features, ARRAY_SIZE(clear_features))) {
+		error("Unknown feature to clear: %s", feature);
+		return 1;
+	}
+
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
+	if (!strcmp(feature, "seed")) {
+		ret = update_seeding_flag(fs_info->tree_root, path, 0, 0);
+		goto out;
+	}
+	if (!strcmp(feature, "block-group-tree")) {
+		if (!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+			error("filesystem doesn't have block-group-tree feature");
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = convert_to_extent_tree(fs_info);
+		if (ret < 0) {
+			error("failed to convert the filesystem from block group tree feature");
+			goto out;
+		}
+		goto out;
+	}
+out:
+	if (fs_info)
+		close_ctree_fs_info(fs_info);
+	return !!ret;
+}
+
+static const char * const cmd_tune_clear_usage[] = {
+	"btrfs tune clear <feature> [<device>]",
+	"Clear/disable specified feature for the unmounted filesystem",
+	"",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
+	NULL,
+};
+
+static DEFINE_SIMPLE_COMMAND(tune_clear, "clear");
+
 static const char * const tune_cmd_group_usage[] = {
 	"btrfs tune <command> <args>",
 	NULL,
@@ -331,6 +441,7 @@ static const char tune_cmd_group_info[] = "change various btrfs features";
 static const struct cmd_group tune_cmd_group = {
 	tune_cmd_group_usage, tune_cmd_group_info, {
 		&cmd_struct_tune_set,
+		&cmd_struct_tune_clear,
 		NULL
 	}
 };
-- 
2.42.0


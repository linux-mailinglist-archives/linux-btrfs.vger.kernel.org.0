Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2C79259B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjIEQDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353750AbjIEHwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C4CCB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30B4F211B7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/i0Oqpqih/65E1Joi65FTQE0z70TQd5YJ+G4nDOq1Sg=;
        b=q//8CYt7In8mq+vLsjQnRVFdw78+906JEFT15/WIKJhKrtDK07N+49jJK4WsAnoH6vD3BL
        enCv/ohes+qgFI8pGElTIFcuzHW/OPSvAcWXHTvPjgIcG6IBeSEKJ/B9UDm/TvePBVZ3jT
        nuP/XbjfWhXdy6QQ5TO7FYSNGOrneBU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B66E13911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEehEC7e9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs-progs: cmds/tune: add set support for seeding device
Date:   Tue,  5 Sep 2023 15:51:47 +0800
Message-ID: <4b517844b96bab15e8c446da25fe24e6ec4cf2ce.1693900169.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
References: <cover.1693900169.git.wqu@suse.com>
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

With the new "btrfs tune set" command, seeding device support can be
added just like all other features.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile    |  2 +-
 cmds/tune.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 45d64129352c..b502336d7441 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       cmds/reflink.o cmds/tune.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o \
-	       check/clear-cache.o tune/convert-bgt.o
+	       check/clear-cache.o tune/convert-bgt.o tune/seeding.o
 
 libbtrfs_objects = \
 		kernel-lib/rbtree.o	\
diff --git a/cmds/tune.c b/cmds/tune.c
index 76ad9ebfc39e..195d0a235fc8 100644
--- a/cmds/tune.c
+++ b/cmds/tune.c
@@ -19,6 +19,7 @@
 #include "cmds/commands.h"
 #include "check/clear-cache.h"
 #include "common/help.h"
+#include "common/utils.h"
 #include "common/fsfeatures.h"
 #include "kernel-shared/messages.h"
 #include "kernel-shared/disk-io.h"
@@ -30,6 +31,7 @@ static const char * const cmd_tune_set_usage[] = {
 	"btrfs tune set <feature> [<device>]",
 	"Set/enable specified feature for the unmounted filesystem",
 	"",
+	OPTLINE("-f", "force dangerous operations."),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
 	NULL,
@@ -77,6 +79,13 @@ static const struct btrfs_feature set_features[] = {
 		VERSION_NULL(safe),
 		VERSION_NULL(default),
 		.desc		= "block group tree to reduce mount time"
+	}, {
+		.name		= "seed",
+		.sysfs_name	= NULL,
+		VERSION_TO_STRING3(compat, 2,6,29),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "seeding device support"
 	},
 	/* Keep this one last */
 	{
@@ -190,15 +199,19 @@ static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
 	struct open_ctree_args oca = { 0 };
 	char *feature;
 	char *path;
+	bool force = false;
 	int ret = 0;
 
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "");
+		int c = getopt(argc, argv, "f");
 		if (c < 0)
 			break;
 
 		switch (c) {
+		case 'f':
+			force = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -279,6 +292,26 @@ static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
 			error("failed to convert the filesystem to free-space-tree feature");
 		goto out;
 	}
+	if (!strcmp(feature, "seed")) {
+		if (btrfs_fs_incompat(fs_info, METADATA_UUID)) {
+			error("SEED flag cannot be changed on a metadata-uuid changed fs");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (!force) {
+			warning(
+"this is dangerous, clearing the seeding flag may cause the derived device not to be mountable!");
+			ret = ask_user("We are going to clear the seeding flag, are you sure?");
+			if (!ret) {
+				error("clear seeding flag canceled");
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
+		ret = update_seeding_flag(fs_info->tree_root, path, 1, force);
+		goto out;
+	}
 
 out:
 	if (fs_info)
-- 
2.42.0


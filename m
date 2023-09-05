Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A847925AA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjIEQCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353749AbjIEHwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3ACCF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10E7321832
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fDVBTEsm7FR57aEl2RYMUzC1tNIzw0LejU5BQx6NGY=;
        b=tGiUif+/Ofv7G7aTuxhuKC/oVvLvOUhg6eourtzXahXPNRpKoGmj8SRdZdAS0hyJhF03BD
        4bw2eO2kVMa1WQTruzWMuX/eOTIGLDvXE4UIpwaIL/eNrrLLKZvMK/Ai+e41am8igwgqjh
        usr68LfPF6cgFVyh8giUrWkL/1p/Xhc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C45113911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GCIXCS3e9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs-progs: cmds/tune: add set support for block-group-tree feature
Date:   Tue,  5 Sep 2023 15:51:46 +0800
Message-ID: <663028b35ff393f8aa88126edba8aa2763a11a22.1693900169.git.wqu@suse.com>
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

Most of the code is reusing the existing code from btrfs-tune, only
needs to add extra linkage dependency on tune/convert-bgt.o.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile    |  2 +-
 cmds/tune.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9857daaa42ac..45d64129352c 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       cmds/reflink.o cmds/tune.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o \
-	       check/clear-cache.o
+	       check/clear-cache.o tune/convert-bgt.o
 
 libbtrfs_objects = \
 		kernel-lib/rbtree.o	\
diff --git a/cmds/tune.c b/cmds/tune.c
index 9906cde393f4..76ad9ebfc39e 100644
--- a/cmds/tune.c
+++ b/cmds/tune.c
@@ -24,6 +24,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/free-space-tree.h"
+#include "tune/tune.h"
 
 static const char * const cmd_tune_set_usage[] = {
 	"btrfs tune set <feature> [<device>]",
@@ -68,6 +69,14 @@ static const struct btrfs_feature set_features[] = {
 		VERSION_TO_STRING2(safe, 4,9),
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
+	}, {
+		.name		= "block-group-tree",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
+		.sysfs_name	= "block_group_tree",
+		VERSION_TO_STRING2(compat, 6,1),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "block group tree to reduce mount time"
 	},
 	/* Keep this one last */
 	{
@@ -254,6 +263,22 @@ static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
 			error("failed to convert the filesystem to free-space-tree feature");
 		goto out;
 	}
+	if (!strcmp(feature, "block-group-tree")) {
+		if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+			error("filesystem already has block-group-tree feature");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
+			error("the filesystem doesn't have free-space-tree feature, please enable it first");
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = convert_to_bg_tree(fs_info);
+		if (ret < 0)
+			error("failed to convert the filesystem to free-space-tree feature");
+		goto out;
+	}
 
 out:
 	if (fs_info)
-- 
2.42.0


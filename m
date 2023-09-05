Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3582A79285C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjIEQCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353748AbjIEHwR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4ACCB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E68C71F750
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXeiofhD6/uQWs8zTtqC1cqw4m7gtmDRadkYyuDODU0=;
        b=s+PDzae5HFgbx3ZWdkchKSKuueuCMvItcwbc9qwFBI8LhXajDclrKwv3DSiZIF7rj5QOGI
        zoXo1hymCd0QYyht4vz548ifFtakowjBHQCgVNoeC1A8gYY8hjLPu7dbjqRhCtvRri++c0
        IvxdAOeaKceUq+1z/idoxOsT/AaeshU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2A3513911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0O/TByve9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs-progs: cmds/tune: add set support for free-space-tree feature
Date:   Tue,  5 Sep 2023 15:51:45 +0800
Message-ID: <5bee36f6d2bac339edb47d6c7dede061fa3a12f3.1693900169.git.wqu@suse.com>
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

This patch allows "btrfs tune set" to enable free-space-tree feature,
using pretty much the same code from btrfstune.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/tune.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/cmds/tune.c b/cmds/tune.c
index 92c7b9f1502c..9906cde393f4 100644
--- a/cmds/tune.c
+++ b/cmds/tune.c
@@ -17,11 +17,13 @@
 #include <unistd.h>
 #include "kerncompat.h"
 #include "cmds/commands.h"
+#include "check/clear-cache.h"
 #include "common/help.h"
 #include "common/fsfeatures.h"
 #include "kernel-shared/messages.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/free-space-tree.h"
 
 static const char * const cmd_tune_set_usage[] = {
 	"btrfs tune set <feature> [<device>]",
@@ -57,6 +59,15 @@ static const struct btrfs_feature set_features[] = {
 		VERSION_TO_STRING2(safe, 4,0),
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "no explicit hole extents for files"
+	}, {
+		.name		= "free-space-tree",
+		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+				  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
+		.sysfs_name = "free_space_tree",
+		VERSION_TO_STRING2(compat, 4,5),
+		VERSION_TO_STRING2(safe, 4,9),
+		VERSION_TO_STRING2(default, 5,15),
+		.desc		= "free space tree (space_cache=v2)"
 	},
 	/* Keep this one last */
 	{
@@ -134,6 +145,36 @@ static int set_super_incompat_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	return ret;
 }
 
+static int convert_to_fst(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	/* We may have invalid old v2 cache, clear them first. */
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+		ret = btrfs_clear_free_space_tree(fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to clear stale v2 free space cache: %m");
+			return ret;
+		}
+	}
+	ret = btrfs_clear_v1_cache(fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to clear v1 free space cache: %m");
+		return ret;
+	}
+
+	ret = btrfs_create_free_space_tree(fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to create free space tree: %m");
+		return ret;
+	}
+	pr_verbose(LOG_DEFAULT, "Converted to free space tree feature\n");
+	return ret;
+}
+
 static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
@@ -202,6 +243,17 @@ static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 		goto out;
 	}
+	if (!strcmp(feature, "free-space-tree")) {
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
+			error("filesystem already has free-space-tree feature");
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = convert_to_fst(fs_info);
+		if (ret < 0)
+			error("failed to convert the filesystem to free-space-tree feature");
+		goto out;
+	}
 
 out:
 	if (fs_info)
-- 
2.42.0


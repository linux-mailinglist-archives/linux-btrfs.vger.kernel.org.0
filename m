Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202D5E56F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIVAHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIVAHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29D3A00E8
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80B2921A78
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gObbcDuIU3kf12U6bIb/bMj3I/QF93m9pC5XWZYtxa8=;
        b=AdnvtgaV1HECFWtLyrwP1u1O1GmWyqxBz6voz380o76uviTjC4eeZwMJiuKAKSkrVOZcOw
        4nbvQG5yAwcan6faTSaPmqctzGAVO9aHQTZDA0CfbEB7ucQtRQXETW/YaPGHgYlEAiorWJ
        WrvopY5Z/O6CfMNXObmcGyfHe69YOjs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC548139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0I6pKTKnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/16] btrfs: extract sysfs init into its own helper
Date:   Thu, 22 Sep 2022 08:06:28 +0800
Message-Id: <e766bbc32554e0f437152e6c1d76707438a29db6.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663804335.git.wqu@suse.com>
References: <cover.1663804335.git.wqu@suse.com>
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

The three functions, btrfs_sysfs_add_fsid(), btrfs_sysfs_add_mounted()
and btrfs_init_space_info() are all doing sysfs related code.

The last one can only be called after fsid sysfs entry created, thus
they are all put into the same helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 66 ++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6e96829b8140..8f8a5fa62d1b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3728,6 +3728,44 @@ static int open_ctree_load_items_init(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static int open_ctree_sysfs_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = btrfs_sysfs_add_fsid(fs_info->fs_devices);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
+				ret);
+		return ret;
+	}
+
+	ret = btrfs_sysfs_add_mounted(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
+		goto free_fsid;
+	}
+
+	/* This can only be called after the fsid entry being added. */
+	ret = btrfs_init_space_info(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to initialize space info: %d", ret);
+		goto free_mounted;
+	}
+	return 0;
+
+free_mounted:
+	btrfs_sysfs_remove_mounted(fs_info);
+free_fsid:
+	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
+	return ret;
+}
+
+static void open_ctree_sysfs_exit(struct btrfs_fs_info *fs_info)
+{
+	btrfs_sysfs_remove_mounted(fs_info);
+	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3755,6 +3793,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_load_items_init,
 		.exit_func = NULL,
+	}, {
+		.init_func = open_ctree_sysfs_init,
+		.exit_func = open_ctree_sysfs_exit,
 	}
 };
 
@@ -3780,25 +3821,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_sysfs_add_fsid(fs_devices);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
-				ret);
-		goto fail_block_groups;
-	}
-
-	ret = btrfs_sysfs_add_mounted(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
-		goto fail_fsdev_sysfs;
-	}
-
-	ret = btrfs_init_space_info(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to initialize space info: %d", ret);
-		goto fail_sysfs;
-	}
-
 	ret = btrfs_read_block_groups(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read block groups: %d", ret);
@@ -3898,12 +3920,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	filemap_write_and_wait(fs_info->btree_inode->i_mapping);
 
 fail_sysfs:
-	btrfs_sysfs_remove_mounted(fs_info);
-
-fail_fsdev_sysfs:
-	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
-
-fail_block_groups:
 	btrfs_put_block_group_cache(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail:
-- 
2.37.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C35FC2C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJLJNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJLJNl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE20140F0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5772621DB9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYvOeAag2/SEuwSpPAI1LcmqOGjjaZNlyC4Luw8Rmlw=;
        b=DYr99lMOIh1rcKAXIt9Qkb+Q1b4A2jzme0k5AnQxQlxy5ePzh5DtvZesbUdMh7neSgJihn
        R/91OIhcefQ2+OEVw1r1Nh9ksDhw5XivA79vqDG9EjeU+XlnZVlpw/jCONHHzPl+4P4SjW
        0e4jvA4uCFxgZwBQuvJhTyRcjLTCdoY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFB6D13A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mOR9HkGFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/15] btrfs: extract mount time checks and items load code into its init helper
Date:   Wed, 12 Oct 2022 17:13:05 +0800
Message-Id: <0d5a59495b60dfcc65e0d476e298b5ad2b9dfc89.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
References: <cover.1665565866.git.wqu@suse.com>
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

One thing to notice is, since we're also initializing zoned mode, also
move later btrfs_free_zone_cache() call into the helper to concentrace
the zoned code.

As later I found it pretty hard to find any logical connection around
that btrfs_free_zone_cache() call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 81 +++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cfed53675359..bee6204d357d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3733,6 +3733,50 @@ static void open_ctree_tree_roots_exit(struct btrfs_fs_info *fs_info)
 	free_root_pointers(fs_info, true);
 }
 
+/* Load various items for balance/replace, and do various mount time check. */
+static int open_ctree_load_items_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	/*
+	 * Dev extents can only be verified after both dev tree and chunk tree
+	 * being initialized.
+	 */
+	ret = btrfs_verify_dev_extents(fs_info);
+	if (ret) {
+		btrfs_err(fs_info,
+			  "failed to verify dev extents against chunks: %d",
+			  ret);
+		return ret;
+	}
+	ret = btrfs_recover_balance(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to recover balance: %d", ret);
+		return ret;
+	}
+
+	ret = btrfs_init_dev_stats(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init dev_stats: %d", ret);
+		return ret;
+	}
+
+	ret = btrfs_init_dev_replace(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init dev_replace: %d", ret);
+		return ret;
+	}
+
+	ret = btrfs_check_zoned_mode(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to initialize zoned mode: %d", ret);
+		return ret;
+	}
+	btrfs_free_zone_cache(fs_info);
+
+	return 0;
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3757,6 +3801,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_tree_roots_init,
 		.exit_func = open_ctree_tree_roots_exit,
+	}, {
+		.init_func = open_ctree_load_items_init,
+		.exit_func = NULL,
 	}
 };
 
@@ -3782,38 +3829,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_verify_dev_extents(fs_info);
-	if (ret) {
-		btrfs_err(fs_info,
-			  "failed to verify dev extents against chunks: %d",
-			  ret);
-		goto fail_block_groups;
-	}
-	ret = btrfs_recover_balance(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to recover balance: %d", ret);
-		goto fail_block_groups;
-	}
-
-	ret = btrfs_init_dev_stats(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init dev_stats: %d", ret);
-		goto fail_block_groups;
-	}
-
-	ret = btrfs_init_dev_replace(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to init dev_replace: %d", ret);
-		goto fail_block_groups;
-	}
-
-	ret = btrfs_check_zoned_mode(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to initialize zoned mode: %d",
-			  ret);
-		goto fail_block_groups;
-	}
-
 	ret = btrfs_sysfs_add_fsid(fs_devices);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
@@ -3839,8 +3854,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_sysfs;
 	}
 
-	btrfs_free_zone_cache(fs_info);
-
 	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
-- 
2.37.3


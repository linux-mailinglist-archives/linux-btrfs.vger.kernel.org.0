Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7435E56F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIVAHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIVAHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C90A0270
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D2E41F8E5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9j5bLIf5jIAn5xP5Trs7yjPcgdjoUDqi3VJzElaJ90=;
        b=mL1hqSOBUw+KzUr16MEtoKsiHQyP/T8RmXNZwvT2eARhpxPyEcDRbejYS2sE7e6Qv5Pi9k
        xTAAQqEYJeQ9JMyA+T/GaZkmZLrpRdZu4QJlky6r6iRxAFw0mT9nVsLwd9Wd6oXJUN4NJ/
        JAx4whm8UWqwymzSsFAQkO+x2gayIFM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6A17139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eA4uKDGnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs: extract mount time checks and items load code into its init helper
Date:   Thu, 22 Sep 2022 08:06:27 +0800
Message-Id: <33990683c4b04c4be2cfb3464b757ef400a73c18.1663804335.git.wqu@suse.com>
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
index e03927cb00b8..6e96829b8140 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3684,6 +3684,50 @@ static void open_ctree_tree_roots_exit(struct btrfs_fs_info *fs_info)
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
@@ -3708,6 +3752,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_tree_roots_init,
 		.exit_func = open_ctree_tree_roots_exit,
+	}, {
+		.init_func = open_ctree_load_items_init,
+		.exit_func = NULL,
 	}
 };
 
@@ -3733,38 +3780,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
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
@@ -3790,8 +3805,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		goto fail_sysfs;
 	}
 
-	btrfs_free_zone_cache(fs_info);
-
 	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
-- 
2.37.3


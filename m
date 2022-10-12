Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226DD5FC2C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJLJNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJLJNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4FEBBF01
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 659C221DD1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xg4xvp5VhQXAt94VPid4U1mmbLaZKZdYJB15Y1yBnqA=;
        b=eRiLgJ2Sd4qznxjqUwLV1NBsLbV6Fw63A/a/d7p34HFTJO1L/VkHG9tT+xm8212cO8oksm
        DrBhbIBaqc5wvJ1je4WuVu3y7kukApIU4emryPalBr0U9WpDKsx0LrTVA6k4LKzTIQMKtd
        3JN4c1XsCXcEcrxqwn6yJyCu7M22jo8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B952113A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mIkSIUOFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/15] btrfs: extra block groups read code into its own init/exit helpers
Date:   Wed, 12 Oct 2022 17:13:07 +0800
Message-Id: <b137ce78fca59f65ab34b44fa7ecb3754ffe9249.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
References: <cover.1665565866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only special handling is:

- Need error cleanup even in open_ctree_block_group_init()
  As btrfs_read_block_groups() can error out with some block groups
  already inserted.

  Thus here we have to do the cleanup manually, as exit helper will
  not be called if the init helper failed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3fa618c25e60..33700753f915 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3815,6 +3815,31 @@ static void open_ctree_sysfs_exit(struct btrfs_fs_info *fs_info)
 	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
 }
 
+static int open_ctree_block_groups_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = btrfs_read_block_groups(fs_info);
+
+	/*
+	 * Even if btrfs_read_block_groups() failed, we may still have
+	 * inserted some block groups.
+	 * Thus we have to do cleanup here manually for error path, as
+	 * our exit function won't be executed for error path.
+	 */
+	if (ret < 0) {
+		btrfs_put_block_group_cache(fs_info);
+		btrfs_free_block_groups(fs_info);
+	}
+	return ret;
+}
+
+static void open_ctree_block_groups_exit(struct btrfs_fs_info *fs_info)
+{
+	btrfs_put_block_group_cache(fs_info);
+	btrfs_free_block_groups(fs_info);
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3845,6 +3870,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_sysfs_init,
 		.exit_func = open_ctree_sysfs_exit,
+	}, {
+		.init_func = open_ctree_block_groups_init,
+		.exit_func = open_ctree_block_groups_exit,
 	}
 };
 
@@ -3870,16 +3898,10 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_read_block_groups(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to read block groups: %d", ret);
-		goto fail_sysfs;
-	}
-
 	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
-		goto fail_sysfs;
+		goto fail;
 
 	fs_info->transaction_kthread = kthread_run(transaction_kthread,
 						   fs_info->tree_root,
@@ -3968,9 +3990,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	 */
 	filemap_write_and_wait(fs_info->btree_inode->i_mapping);
 
-fail_sysfs:
-	btrfs_put_block_group_cache(fs_info);
-	btrfs_free_block_groups(fs_info);
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
 		if (!open_ctree_res[i] || !open_ctree_seq[i].exit_func)
-- 
2.37.3


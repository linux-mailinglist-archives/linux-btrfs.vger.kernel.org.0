Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06D15E56F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIVAHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIVAHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E57A4B36
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8267D1F8F6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlksPiKKhhHo22XjsG3Ygt4xWPWo9Wij/ha52HrT1EQ=;
        b=C+YJGOYYOcI7Equ33Bi5/9FCYWtmzcpxe01fLwC2qw4ehMg2fksvBnQKOaLoRprMWZdYxQ
        48f5lMkpxZN+J3qq30ojcEj5PHkoC8T1BMCAtuMPEdxVBBWFlQubLgvAseYAP7uz9GF+M0
        8SH3cNpO5Mbkb7f9+UghRJ9xL3GneS4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF1FF139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MJN2KjOnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs: extra block groups read code into its own init/exit helpers
Date:   Thu, 22 Sep 2022 08:06:29 +0800
Message-Id: <36da7bf9929be5b00a276ff88ca7a6b6d09ecb23.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663804335.git.wqu@suse.com>
References: <cover.1663804335.git.wqu@suse.com>
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
index 8f8a5fa62d1b..c034b017c316 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3766,6 +3766,31 @@ static void open_ctree_sysfs_exit(struct btrfs_fs_info *fs_info)
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
@@ -3796,6 +3821,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_sysfs_init,
 		.exit_func = open_ctree_sysfs_exit,
+	}, {
+		.init_func = open_ctree_block_groups_init,
+		.exit_func = open_ctree_block_groups_exit,
 	}
 };
 
@@ -3821,16 +3849,10 @@ int __cold open_ctree(struct super_block *sb, char *options)
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
@@ -3919,9 +3941,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
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


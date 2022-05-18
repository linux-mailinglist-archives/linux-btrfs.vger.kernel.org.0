Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0152B8DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiERLXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiERLXX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 07:23:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CE16D5C3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 04:23:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 879071F37F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 11:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652872998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5ofKgkigc8rgJDSy+9zBlf3fnXHjy34R9COdc4rlJwQ=;
        b=W4sqU3z4FWpNCxHvRFGjzomG/9PMw+5mJQFSrnt9sza1rUJk7Pg8OvweAa3UUPqBa4CSj3
        lf176edGtqc+LA2r9Bxbrszg5QmD9d+RUyH2SDHV+KCJItPfipH5pSYEL/IwzHlJ2RW5xF
        qtVjVPNwFhkKSlgT/yaViTbU9mV9P98=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0B6313A6D
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 11:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VCIOMCXXhGK3TQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 11:23:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: do not abuse btrfs_commit_transaction() just to update super blocks
Date:   Wed, 18 May 2022 19:23:00 +0800
Message-Id: <4ee1030eb7d24d13ffa1bda98364de07258ca079.1652872975.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several call sites utilizing btrfs_commit_transaction() just
to update members in super blocks, without any metadata update.

This can be problematic for some simple call sites, like zero_log_tree()
or check_and_repair_super_num_devs().

If we have big problems preventing the fs to be mounted in the first
place, and need to clear the log or super block size, but by some other
problems in extent tree, we're unable to allocate new blocks.

Then we fall into a deadlock that, we need to mount (even
ro,rescue=all) to collect extra info, but btrfs-progs can not do any
super block updates.

Fix the problem by allowing the following super blocks only operations
to be done without using btrfs_commit_transaction():

- btrfs_fix_super_size()
- check_and_repair_super_num_devs()
- zero_log_tree().

There are some exceptions in btrfstune.c, related to the csum type
conversion and seed flags.

In those btrfstune cases, we in fact wants to proper error report in
btrfs_commit_transaction(), as those operations are not mount critical,
and any early error can be helpful to expose any problems in the fs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c            |  8 +-------
 check/mode-common.c     | 16 +++-------------
 kernel-shared/volumes.c | 14 ++------------
 3 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/check/main.c b/check/main.c
index bcb016964e7a..03df343796c2 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9659,17 +9659,11 @@ out:
 
 static int zero_log_tree(struct btrfs_root *root)
 {
-	struct btrfs_trans_handle *trans;
 	int ret;
 
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		return ret;
-	}
 	btrfs_set_super_log_root(gfs_info->super_copy, 0);
 	btrfs_set_super_log_root_level(gfs_info->super_copy, 0);
-	ret = btrfs_commit_transaction(trans, root);
+	ret = write_all_supers(fs_info);
 	return ret;
 }
 
diff --git a/check/mode-common.c b/check/mode-common.c
index 2a3018428fc8..f7cb00c0f7b2 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1628,7 +1628,6 @@ static int get_num_devs_in_chunk_tree(struct btrfs_fs_info *fs_info)
 
 int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_trans_handle *trans;
 	int found_devs;
 	int ret;
 
@@ -1651,22 +1650,13 @@ int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * Repair is pretty simple, just reset the super block value and
-	 * commit a new transaction.
+	 * write back all the super blocks.
 	 */
-	trans = btrfs_start_transaction(fs_info->tree_root, 0);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error("failed to start trans: %m");
-		return ret;
-	}
-
 	btrfs_set_super_num_devices(fs_info->super_copy, found_devs);
-	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	ret = write_all_supers(fs_info);
 	if (ret < 0) {
 		errno = -ret;
-		error("failed to commit trans: %m");
-		btrfs_abort_transaction(trans, ret);
+		error("failed to write super blocks: %m");
 		return ret;
 	}
 	printf("Successfully reset super num devices to %u\n", found_devs);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 97c09a1a4931..9a3b69903d32 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2861,7 +2861,6 @@ err:
  */
 int btrfs_fix_super_size(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
 	struct list_head *dev_list = &fs_info->fs_devices->devices;
 	u64 total_bytes = 0;
@@ -2886,19 +2885,10 @@ int btrfs_fix_super_size(struct btrfs_fs_info *fs_info)
 		return 0;
 
 	btrfs_set_super_total_bytes(fs_info->super_copy, total_bytes);
-
-	/* Commit transaction to update all super blocks */
-	trans = btrfs_start_transaction(fs_info->tree_root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error("error starting transaction: %d (%m)", ret);
-		return ret;
-	}
-	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	ret = write_all_supers(fs_info);
 	if (ret < 0) {
 		errno = -ret;
-		error("failed to commit current transaction: %d (%m)", ret);
+		error("failed to write super blocks: %d (%m)", ret);
 		return ret;
 	}
 	printf("Fixed super total bytes, old size: %llu new size: %llu\n",
-- 
2.36.1


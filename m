Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2B5FC2CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJLJN7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJLJNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275ABBF01
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F2C421CEF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tb8gYBGa3ls3wpRxosXfh30Rhp+0RzKh9Geq46Pu1g=;
        b=gC2qdmi+6IW7Ub8lwv2riYuL/o/yooIP30REiuDedesAiZ/ZpD8SUI4p+E0b6bBySp9zn7
        RXkapVPrkj+S4Qcf9NUJ/tuSNsbnDNujumRBmEsgOhoKk6bkim2S6uPjdceG8WLQVx3qBA
        DjtPXtnQ8E5el5E70Hi/SSOb4eXd1Os=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4D0C13A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EAQTJEWFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/15] btrfs: extract kthread code into its own init/exit helpers
Date:   Wed, 12 Oct 2022 17:13:09 +0800
Message-Id: <90ec1e748fca5b07dde97f5c0df877d16632cd61.1665565866.git.wqu@suse.com>
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

There are several changes involved:

- Change the timing of btrfs_cleanup_transaction()
  That call is to address any unfinished transaction mostly caused by
  the cleaner/commit kthread.

  Thus at exit function and error handling path, we should stop all
  kthread, then cleanup the unfinished transaction.

  Not calling it before stopping cleaner thread.

- Remove the filemap_write_and_wait() call
  Now we have open_ctree_btree_inode_exit() call, which will invalidate
  all dirty pages of btree inode.
  Thus there is no need to writeback those dirtied tree blocks anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 79 +++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 71a9572b45f9..2d1f178cdecd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3853,6 +3853,52 @@ static int open_ctree_fs_root_init(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static int open_ctree_kthread_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
+					       "btrfs-cleaner");
+	if (IS_ERR(fs_info->cleaner_kthread)) {
+		ret = PTR_ERR(fs_info->cleaner_kthread);
+		return ret;
+	}
+
+	fs_info->transaction_kthread = kthread_run(transaction_kthread,
+						   fs_info->tree_root,
+						   "btrfs-transaction");
+	if (IS_ERR(fs_info->transaction_kthread)) {
+		kthread_stop(fs_info->cleaner_kthread);
+
+		/*
+		 * Cleanup thread may have already started a trans.
+		 * The dirtied tree blocks will be invalidated at
+		 * open_ctree_btree_inode_exit() thus we don't need to bother.
+		 */
+		btrfs_cleanup_transaction(fs_info);
+
+		ret = PTR_ERR(fs_info->cleaner_kthread);
+		return ret;
+	}
+	/*
+	 * Mount does not set all options immediately, we can do it now and do
+	 * not have to wait for transaction commit
+	 */
+	btrfs_apply_pending_changes(fs_info);
+	return 0;
+}
+
+static void open_ctree_kthread_exit(struct btrfs_fs_info *fs_info)
+{
+	kthread_stop(fs_info->transaction_kthread);
+	kthread_stop(fs_info->cleaner_kthread);
+	/*
+	 * Cleanup any unfinished transaction started by transaction/cleaner
+	 * kthread.
+	 */
+	btrfs_cleanup_transaction(fs_info);
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3897,6 +3943,9 @@ static const struct init_sequence open_ctree_seq[] = {
 		 */
 		.init_func = open_ctree_fs_root_init,
 		.exit_func = btrfs_free_fs_roots,
+	}, {
+		.init_func = open_ctree_kthread_init,
+		.exit_func = open_ctree_kthread_exit,
 	}
 };
 
@@ -3922,26 +3971,9 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
-					       "btrfs-cleaner");
-	if (IS_ERR(fs_info->cleaner_kthread))
-		goto fail;
-
-	fs_info->transaction_kthread = kthread_run(transaction_kthread,
-						   fs_info->tree_root,
-						   "btrfs-transaction");
-	if (IS_ERR(fs_info->transaction_kthread))
-		goto fail_cleaner;
-
-	/*
-	 * Mount does not set all options immediately, we can do it now and do
-	 * not have to wait for transaction commit
-	 */
-	btrfs_apply_pending_changes(fs_info);
-
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
-		goto fail_trans_kthread;
+		goto fail;
 
 	if (btrfs_build_ref_tree(fs_info))
 		btrfs_err(fs_info, "couldn't build ref tree");
@@ -3993,17 +4025,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
 fail_qgroup:
 	btrfs_free_qgroup_config(fs_info);
-fail_trans_kthread:
-	kthread_stop(fs_info->transaction_kthread);
-	btrfs_cleanup_transaction(fs_info);
-fail_cleaner:
-	kthread_stop(fs_info->cleaner_kthread);
-
-	/*
-	 * make sure we're done with the btree inode before we stop our
-	 * kthreads
-	 */
-	filemap_write_and_wait(fs_info->btree_inode->i_mapping);
 
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
-- 
2.37.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD595E56F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIVAHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIVAHT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1702A0604
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 849D31F8E5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFZK7MLIItZbiDzpLJ8Ye0STcwk+hlwxo18kCMqFLxI=;
        b=PE80DBs0+Gs5ZBoWdWPSWVLod4YoZhrfOWceIRfZsdqWQxLlfFge+HHYKSEZemh79137Cx
        GQpa9j1xPhTBSLCzuVlfcNrBtbkXZEygSW2T7eemqk8B2O7sLV9+Jv5PdTLt2dXWoZeQcD
        QfS0RCJrop++0+PreSot7Qp6yULcaNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1598139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sMQKKzSnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs: move the fs root related code into its own init/exit helpers
Date:   Thu, 22 Sep 2022 08:06:30 +0800
Message-Id: <d0de9ae54fbaa3312cf1515a04cf62c816aa7986.1663804335.git.wqu@suse.com>
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

The most important change in this patch is the timing change.

The existing code put fs root read very late, after
kthread/qgroup-rescan/log-replay, but put btrfs_free_fs_roots() very
early, as kthread/qgroup/log-replacey can all populate the fs roots.

Thus this patch will change the timing, by reading fs root early.
The fs root read part is not that important, but the cleanup part is.

After the timing change, the fs root would be the first subvolume to be
read, and its exit call can be ensured to cover all later possible
subvolume loads.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c034b017c316..a152899fa21a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3791,6 +3791,19 @@ static void open_ctree_block_groups_exit(struct btrfs_fs_info *fs_info)
 	btrfs_free_block_groups(fs_info);
 }
 
+static int open_ctree_fs_root_init(struct btrfs_fs_info *fs_info)
+{
+	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
+	if (IS_ERR(fs_info->fs_root)) {
+		int ret = PTR_ERR(fs_info->fs_root);
+
+		btrfs_warn(fs_info, "failed to read fs tree: %d", ret);
+		fs_info->fs_root = NULL;
+		return ret;
+	}
+	return 0;
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3824,6 +3837,17 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_block_groups_init,
 		.exit_func = open_ctree_block_groups_exit,
+	}, {
+		/*
+		 * This fs roots related code should be called before anything
+		 * which may try to read a subvolume, including cleanup/commit
+		 * kthread, qgroup rescan, log replay etc.
+		 *
+		 * The main reason is for the exit function to be called for
+		 * any stage which may read some subvolume trees.
+		 */
+		.init_func = open_ctree_fs_root_init,
+		.exit_func = btrfs_free_fs_roots,
 	}
 };
 
@@ -3884,14 +3908,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		}
 	}
 
-	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
-	if (IS_ERR(fs_info->fs_root)) {
-		err = PTR_ERR(fs_info->fs_root);
-		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
-		fs_info->fs_root = NULL;
-		goto fail_qgroup;
-	}
-
 	if (sb_rdonly(fs_info->sb))
 		goto clear_oneshot;
 
@@ -3931,7 +3947,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 fail_trans_kthread:
 	kthread_stop(fs_info->transaction_kthread);
 	btrfs_cleanup_transaction(fs_info);
-	btrfs_free_fs_roots(fs_info);
 fail_cleaner:
 	kthread_stop(fs_info->cleaner_kthread);
 
-- 
2.37.3


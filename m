Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F219577841
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGQVFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGQVFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 17:05:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508412742
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 14:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 373A1B80E6D
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 21:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6A7C3411E
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 21:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658091908;
        bh=tstnJ+yufm+bEclzY/qyPCr6xg3/iBH7N7r5DCMtAac=;
        h=From:To:Subject:Date:From;
        b=CbQUWMl/w77WaZcxMlodk1aOLnIh8G62z4OETRgM59Ep1mI58BdoEaE/w07vDaQjo
         v7HBX/M+i2J25fzQFyA9qz/tpkraOP9ggcurOnVhU5gkRe0LGT4nQa3m67ISli5/ir
         oVJ63iRwlcNm6h/8ld8ffLt9JMtTcXKSX2PptGZcjNDEV4emV0qmT9xsgYTqx1MSlO
         9WQDCSqzfxOo2m7/zwyoowfmk/IkD3xejPhZpNEn4z8gJ/1YnGU60qC7THBSuDAR56
         bqrPGvtb4VDjf65UG59gSarjK2BBl++jHJl/8hSQ58kyjEZLN0qdw4kpku8SNBKC4b
         KjJkOUStId74Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: join running log transaction when logging new name
Date:   Sun, 17 Jul 2022 22:05:05 +0100
Message-Id: <502f1d2cc23000b8585ad87122b7f6c0a8c2c6ab.1658091704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a new name, in case of a rename, we pin the log before
changing it. We then either delete a directory entry from the log or
insert a key range item to mark the old name for deletion on log replay.

However when doing one of those log changes we may have another task that
started writing out the log (at btrfs_sync_log()) and it started before
we pinned the log root. So we may end up changing a log tree while its
writeback is being started by another task syncing the log. This can lead
to inconsistencies in a log tree and other unexpected results during log
replay, because we can get some committed node pointing to a node/leaf
that ends up not getting written to disk before the next log commit.

The problem, conceptually, started to happen in commit 88d2beec7e53fc
("btrfs: avoid logging all directory changes during renames"), because
there we started to update the log without joining its current transaction
first.

However the problem only became visible with commit 259c4b96d78dda
("btrfs: stop doing unnecessary log updates during a rename"), and that is
because we used to pin the log at btrfs_rename() and then before entering
btrfs_log_new_name(), when unlinking the old dentry, we ended up at
btrfs_del_inode_ref_in_log() and btrfs_del_dir_entries_in_log(). Both
of them join the current log transaction, effectively waiting for any log
transaction writeout (due to acquiring the root's log_mutex). This made it
safe even after leaving the current log transaction, because we remained
with the log pinned when we called btrfs_log_new_name().

Then in commit 259c4b96d78dda ("btrfs: stop doing unnecessary log updates
during a rename"), we removed the log pinning from btrfs_rename() and
stopped calling btrfs_del_inode_ref_in_log() and
btrfs_del_dir_entries_in_log() during the rename, and started to do all
the needed work at btrfs_log_new_name(), but without joining the current
log transaction, only pinning the log, which is racy because another task
may have started writeout of the log tree right before we pinned the log.

Both commits landed in kernel 5.18, so it doesn't make any practical
difference which should be blamed, but I'm blaming the second commit only
because with the first one, by chance, the problem did not happen due to
the fact we joined the log transaction after pinning the log and unpinned
it only after calling btrfs_log_new_name().

So make btrfs_log_new_name() join the current log transaction instead of
pinning it, so that we never do log updates if it's writeout is starting.

Fixes: 259c4b96d78dda ("btrfs: stop doing unnecessary log updates during a rename")
CC: stable@vger.kernel.org # 5.18+
Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Tested-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1201f083d4db..9acf68ef4a49 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7029,8 +7029,15 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		 * anyone from syncing the log until we have updated both inodes
 		 * in the log.
 		 */
+		ret = join_running_log_trans(root);
+		/*
+		 * At least one of the inodes was logged before, so this should
+		 * not fail, but if it does, it's not serious, just bail out and
+		 * mark the log for a full commit.
+		 */
+		if (WARN_ON_ONCE(ret < 0))
+			goto out;
 		log_pinned = true;
-		btrfs_pin_log_trans(root);
 
 		path = btrfs_alloc_path();
 		if (!path) {
-- 
2.35.1


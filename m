Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C501C273F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfI3UvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 16:51:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46610 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3UvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 16:51:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so9085306qkd.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGkJf1GTYDU2ae9IJvbSbvh17mHGDRcf4FtC+g4Zhxo=;
        b=s0C2rE9Wm5SpdA9rwt0bjS9v0xFxk4aipZcIh4ThHfhXcSwQ4Vw8Bl9hUyT2KlmbTB
         pGJNiY1J9njNmNFP7JfDAyZtj4rfQSxQcXASgObr7LRbSoWIt/zd2absQyRMD6Pjq6eL
         rvPPR9WAkJYj76RuSqAtWok1mZAYVfKfTDNLTc3RukQKCwJ4QWM0xLNJTBKK4Vvmc17j
         J4ZLczrA2pYlI28aezrqQZvPe4f2fBzVf2VfQ4guazIW/QveShYCE9/SSaCrEke7ztO0
         363PadmrqphViC37SJxR6lx/JgaNa5oGKZVrCuu7ugd3cAkfqbn9+2OFbWbkfoml4Wd0
         OEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGkJf1GTYDU2ae9IJvbSbvh17mHGDRcf4FtC+g4Zhxo=;
        b=KZkmGLHvjrHzu+0y6h68z7vSwYY6MM3sMIXgnEgOWtLGfvAZsyl+tQ2JsnwffiM+EJ
         EWSyGUDF/CDw2iv+yukqBU19f4vALKis/74IA0w4oIlrCdHFKogWQcTpfk9mC8TG5iz5
         ReooqUcIwNrIewv8pLOFkxUgYubNY1Itm41/j/zgyzjrXtu08oW8F2JmnKZBgl5v5iy1
         8A+1OCIWc6aiAdpxLzoTbGaDoB4LN7TiQuvrdv07CqPpabcEKcHClO7V39QmgsoQ/PdN
         QDwn/WM55TsZBxpIrp7Chooa0JELm3rJZgna0TMAToBGnVAV+b0vXXRFnwJbmR2Dt2+o
         xvIw==
X-Gm-Message-State: APjAAAXhHrRhoDT9cito46ZbmCm33nWUfugu5ymtbnydjA37CEtjveB9
        BJiitd5oyq2hukPUTy6uaW6WmmKB+EduQA==
X-Google-Smtp-Source: APXvYqwMUsHi77CjHjrgcuOCW4vFVME5QNrUNkmoHGOPjgrdlvQSoWLNypOnpuTQWW+7Qc5BoHVKtQ==
X-Received: by 2002:a37:a695:: with SMTP id p143mr2213866qke.144.1569875247759;
        Mon, 30 Sep 2019 13:27:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n21sm6346506qka.83.2019.09.30.13.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:27:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: fix incorrect updating of log root tree
Date:   Mon, 30 Sep 2019 16:27:25 -0400
Message-Id: <20190930202725.1317-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've historically had reports of being unable to mount file systems
because the tree log root couldn't be read.  Usually this is the "parent
transid failure", but could be any of the related errors, including
"fsid mismatch" or "bad tree block", depending on which block got
allocated.

The modification of the individual log root items are serialized on the
per-log root root_mutex.  This means that any modification to the
per-subvol log root_item is completely protected.

However we update the root item in the log root tree outside of the log
root tree log_mutex.  We do this in order to allow multiple subvolumes
to be updated in each log transaction.

This is problematic however because when we are writing the log root
tree out we update the super block with the _current_ log root node
information.  Since these two operations happen independently of each
other, you can end up updating the log root tree in between writing out
the dirty blocks and setting the super block to point at the current
root.

This means we'll point at the new root node that hasn't been written
out, instead of the one we should be pointing at.  Thus whatever garbage
or old block we end up pointing at complains when we mount the file
system later and try to replay the log.

Fix this by copying the log's root item into a local root item copy.
Then once we're safely under the log_root_tree->log_mutex we update the
root item in the log_root_tree.  This way we do not modify the
log_root_tree while we're committing it, fixing the problem.

cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/tree-log.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7cac09a6f007..1d7f22951ef2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2908,7 +2908,8 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
  * in the tree of log roots
  */
 static int update_log_root(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *log)
+			   struct btrfs_root *log,
+			   struct btrfs_root_item *root_item)
 {
 	struct btrfs_fs_info *fs_info = log->fs_info;
 	int ret;
@@ -2916,10 +2917,10 @@ static int update_log_root(struct btrfs_trans_handle *trans,
 	if (log->log_transid == 1) {
 		/* insert root item on the first sync */
 		ret = btrfs_insert_root(trans, fs_info->log_root_tree,
-				&log->root_key, &log->root_item);
+				&log->root_key, root_item);
 	} else {
 		ret = btrfs_update_root(trans, fs_info->log_root_tree,
-				&log->root_key, &log->root_item);
+				&log->root_key, root_item);
 	}
 	return ret;
 }
@@ -3017,6 +3018,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *log = root->log_root;
 	struct btrfs_root *log_root_tree = fs_info->log_root_tree;
+	struct btrfs_root_item new_root_item;
 	int log_transid = 0;
 	struct btrfs_log_ctx root_log_ctx;
 	struct blk_plug plug;
@@ -3080,17 +3082,25 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	/*
+	 * We _must_ update under the root->log_mutex in order to make sure we
+	 * have a consistent view of the log root we are trying to commit at
+	 * this moment.
+	 *
+	 * We _must_ copy this into a local copy, because we are not holding the
+	 * log_root_tree->log_mutex yet.  This is important because when we
+	 * commit the log_root_tree we must have a consistent view of the
+	 * log_root_tree when we update the super block to point at the
+	 * log_root_tree bytenr.  If we update the log_root_tree here we'll race
+	 * with the commit and possibly point at the new block which we may not
+	 * have written out.
+	 */
 	btrfs_set_root_node(&log->root_item, log->node);
+	memcpy(&new_root_item, &log->root_item, sizeof(new_root_item));
 
 	root->log_transid++;
 	log->log_transid = root->log_transid;
 	root->log_start_pid = 0;
-	/*
-	 * Update or create log root item under the root's log_mutex to prevent
-	 * races with concurrent log syncs that can lead to failure to update
-	 * log root item because it was not created yet.
-	 */
-	ret = update_log_root(trans, log);
 	/*
 	 * IO has been started, blocks of the log tree have WRITTEN flag set
 	 * in their headers. new modifications of the log will be written to
@@ -3111,6 +3121,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	mutex_unlock(&log_root_tree->log_mutex);
 
 	mutex_lock(&log_root_tree->log_mutex);
+
+	/*
+	 * Now we are safe to update the log_root_tree because we're under the
+	 * log_mutex, and we're a current writer so we're holding the commit
+	 * open until we drop the log_mutex.
+	 */
+	ret = update_log_root(trans, log, &new_root_item);
+
 	if (atomic_dec_and_test(&log_root_tree->log_writers)) {
 		/* atomic_dec_and_test implies a barrier */
 		cond_wake_up_nomb(&log_root_tree->log_writer_wait);
-- 
2.21.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E81EF245
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 09:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFEHlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 03:41:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEHlS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jun 2020 03:41:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BAFC8B1BE;
        Fri,  5 Jun 2020 07:41:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 45/46] btrfs: make btrfs_set_inode_last_trans take btrfs_inode
Date:   Fri,  5 Jun 2020 10:41:13 +0300
Message-Id: <20200605074113.13447-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-46-nborisov@suse.com>
References: <20200603055546.3889-46-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of making multiple calls to BTRFS_I simply take btrfs_inode
as an input paramter.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V3:
 * Added missing : after btrfs in subject line
 * Remove extra newline between changelog and SOB line.

 fs/btrfs/inode.c       |  6 +++---
 fs/btrfs/transaction.h | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39161a440125..df1a347c1814 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3468,7 +3468,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,

 	fill_inode_item(trans, leaf, inode_item, inode);
 	btrfs_mark_buffer_dirty(leaf);
-	btrfs_set_inode_last_trans(trans, inode);
+	btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
 	ret = 0;
 failed:
 	btrfs_free_path(path);
@@ -3498,7 +3498,7 @@ noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,

 		ret = btrfs_delayed_update_inode(trans, root, inode);
 		if (!ret)
-			btrfs_set_inode_last_trans(trans, inode);
+			btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
 		return ret;
 	}

@@ -6010,7 +6010,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	inode_tree_add(inode);

 	trace_btrfs_inode_new(inode);
-	btrfs_set_inode_last_trans(trans, inode);
+	btrfs_set_inode_last_trans(trans, BTRFS_I(inode));

 	btrfs_update_root_times(trans, root);

diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index bf102e64bfb2..6f65fff6cf50 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -156,13 +156,13 @@ struct btrfs_pending_snapshot {
 };

 static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
-					      struct inode *inode)
+					      struct btrfs_inode *inode)
 {
-	spin_lock(&BTRFS_I(inode)->lock);
-	BTRFS_I(inode)->last_trans = trans->transaction->transid;
-	BTRFS_I(inode)->last_sub_trans = BTRFS_I(inode)->root->log_transid;
-	BTRFS_I(inode)->last_log_commit = BTRFS_I(inode)->root->last_log_commit;
-	spin_unlock(&BTRFS_I(inode)->lock);
+	spin_lock(&inode->lock);
+	inode->last_trans = trans->transaction->transid;
+	inode->last_sub_trans = inode->root->log_transid;
+	inode->last_log_commit = inode->root->last_log_commit;
+	spin_unlock(&inode->lock);
 }

 /*
--
2.17.1


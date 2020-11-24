Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415A52C2BCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbgKXPtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 10:49:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbgKXPtg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 10:49:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606232974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fObc9FZu3LS5h3uCWSPw4H76FQ6w9ItyEKtm4xa00Xo=;
        b=Xo/R4xjti4FvlHj2EiIn2BAiuajd8GQNxtQgGOR1Lfi7ffPVfg06SXg2uA7gRuwJIhtcZR
        YbqP3gwE8zxKCO2boSUSQhEXEjTMo3WH7SLPjeA3ZWeabYm1MP156BBE7LRvXulzV2Z7op
        +MU1XuGgFGS4dkdL1OrcWcOXNl5kotc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E048AC55;
        Tue, 24 Nov 2020 15:49:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Remove err variable from btrfs_delete_subvolume
Date:   Tue, 24 Nov 2020 17:49:30 +0200
Message-Id: <20201124154932.3180539-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124154932.3180539-1-nborisov@suse.com>
References: <20201124154932.3180539-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use only a single 'ret' to control whether we should abort the
transaction or not. That's fine, because  if we abort a transaction then
btrfs_end_transaction will return the same value as passed to
btrfs_abort_transaction. No semantic changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed120c09acf6..875ba51839cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4083,7 +4083,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	struct btrfs_block_rsv block_rsv;
 	u64 root_flags;
 	int ret;
-	int err;
 
 	/*
 	 * Don't allow to delete a subvolume with send in progress. This is
@@ -4105,8 +4104,8 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 
 	down_write(&fs_info->subvol_sem);
 
-	err = may_destroy_subvol(dest);
-	if (err)
+	ret = may_destroy_subvol(dest);
+	if (ret)
 		goto out_up_write;
 
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
@@ -4115,13 +4114,13 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	 * two for dir entries,
 	 * two for root ref/backref.
 	 */
-	err = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
-	if (err)
+	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
+	if (ret)
 		goto out_up_write;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_release;
 	}
 	trans->block_rsv = &block_rsv;
@@ -4131,7 +4130,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 
 	ret = btrfs_unlink_subvol(trans, dir, dentry);
 	if (ret) {
-		err = ret;
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
 	}
@@ -4149,7 +4147,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 					dest->root_key.objectid);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			goto out_end_trans;
 		}
 	}
@@ -4159,7 +4156,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 				  dest->root_key.objectid);
 	if (ret && ret != -ENOENT) {
 		btrfs_abort_transaction(trans, ret);
-		err = ret;
 		goto out_end_trans;
 	}
 	if (!btrfs_is_empty_uuid(dest->root_item.received_uuid)) {
@@ -4169,7 +4165,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 					  dest->root_key.objectid);
 		if (ret && ret != -ENOENT) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			goto out_end_trans;
 		}
 	}
@@ -4180,14 +4175,12 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
 	ret = btrfs_end_transaction(trans);
-	if (ret && !err)
-		err = ret;
 	inode->i_flags |= S_DEAD;
 out_release:
 	btrfs_subvolume_release_metadata(root, &block_rsv);
 out_up_write:
 	up_write(&fs_info->subvol_sem);
-	if (err) {
+	if (ret) {
 		spin_lock(&dest->root_item_lock);
 		root_flags = btrfs_root_flags(&dest->root_item);
 		btrfs_set_root_flags(&dest->root_item,
@@ -4205,7 +4198,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		}
 	}
 
-	return err;
+	return ret;
 }
 
 static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
-- 
2.25.1


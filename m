Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76106152E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKAUNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKAUMx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E51E3D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 294A4336F4;
        Tue,  1 Nov 2022 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QzSWSGraQOa4eaqcUToldPHsCsjUNb1iVWMuDxDRyU=;
        b=LgkTOjfH73KYCFUYoO1pjDfaLt5N+FwST/ZH2iQxwwzvrZUJfnoGxDWvCkTrvZUPcS1JST
        agwsObwYo7IhCI1x1DZ+7HW9Pyw1FP+9nvEgEt5/UcowXsxLC7Oj2gIsQ528oG/0aOq7qw
        6CHDrWwxMsZnOvB8v8LMUAtDxe+tZ+0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 22CB62C141;
        Tue,  1 Nov 2022 20:12:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 730B1DA79D; Tue,  1 Nov 2022 21:12:34 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 25/40] btrfs: pass btrfs_inode to btrfs_delete_subvolume
Date:   Tue,  1 Nov 2022 21:12:34 +0100
Message-Id: <77d6ecc8e207c8097872ce8e888ee5f740f9df7a.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       | 10 +++++-----
 fs/btrfs/ioctl.c       |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ba0dbdc91ec5..481c75c47fc4 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -439,7 +439,7 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const struct fscrypt_str *name, int add_backref, u64 index);
-int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
+int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry);
 int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			 int front);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3307564c80e7..203298546c7e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4697,10 +4697,10 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 	spin_unlock(&root->inode_lock);
 }
 
-int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
+int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dentry->d_sb);
-	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_root *root = dir->root;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *dest = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
@@ -4757,9 +4757,9 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
-	btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
+	btrfs_record_snapshot_destroy(trans, dir);
 
-	ret = btrfs_unlink_subvol(trans, dir, dentry);
+	ret = btrfs_unlink_subvol(trans, &dir->vfs_inode, dentry);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
@@ -4847,7 +4847,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 			"extent tree v2 doesn't support snapshot deletion yet");
 			return -EOPNOTSUPP;
 		}
-		return btrfs_delete_subvolume(dir, dentry);
+		return btrfs_delete_subvolume(BTRFS_I(dir), dentry);
 	}
 
 	err = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0873eae20f63..a64a71d882dc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2526,7 +2526,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	}
 
 	btrfs_inode_lock(BTRFS_I(inode), 0);
-	err = btrfs_delete_subvolume(dir, dentry);
+	err = btrfs_delete_subvolume(BTRFS_I(dir), dentry);
 	btrfs_inode_unlock(BTRFS_I(inode), 0);
 	if (!err)
 		d_delete_notify(dir, dentry);
-- 
2.37.3


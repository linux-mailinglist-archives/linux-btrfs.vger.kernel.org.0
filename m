Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44D6152EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKAUNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKAUNI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D01D0F3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2BEE71F88E;
        Tue,  1 Nov 2022 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ms1/e5R1SYDk1OC3sUJZChuOts0RiWSphat5REPrs64=;
        b=Ll/rbvUmZD7CFOguQy5xSk4EPnmld16VE7b/ae4H6+Yg/OYL7DDYxq2uRs6dLVE63tFIS3
        0BuzQYHgTQpFbxKxB2r9l7ChZ61JwDlpaBmRaHgF6ikBq1iV0zUET5B42kXhmwBdWJPQZz
        CxXoYOkbST2MtItkohEyH8OnwHbTTKc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2581F2C141;
        Tue,  1 Nov 2022 20:13:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7559ADA79D; Tue,  1 Nov 2022 21:12:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 32/40] btrfs: pass btrfs_inode to btrfs_unlink_subvol
Date:   Tue,  1 Nov 2022 21:12:49 +0100
Message-Id: <f9b7127ff717c15354b5a8eba0abcc7f18ccfcd2.1667331829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
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
 fs/btrfs/inode.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a609b2071c99..240a95c90b9b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4469,9 +4469,9 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
-			       struct inode *dir, struct dentry *dentry)
+			       struct btrfs_inode *dir, struct dentry *dentry)
 {
-	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_root *root = dir->root;
 	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
@@ -4480,10 +4480,10 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	u64 index;
 	int ret;
 	u64 objectid;
-	u64 dir_ino = btrfs_ino(BTRFS_I(dir));
+	u64 dir_ino = btrfs_ino(dir);
 	struct fscrypt_name fname;
 
-	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
 	if (ret)
 		return ret;
 
@@ -4556,17 +4556,17 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_delete_delayed_dir_index(trans, BTRFS_I(dir), index);
+	ret = btrfs_delete_delayed_dir_index(trans, dir, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - fname.disk_name.len * 2);
-	inode_inc_iversion(dir);
-	dir->i_mtime = current_time(dir);
-	dir->i_ctime = dir->i_mtime;
-	ret = btrfs_update_inode_fallback(trans, root, BTRFS_I(dir));
+	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
+	inode_inc_iversion(&dir->vfs_inode);
+	dir->vfs_inode.i_mtime = current_time(&dir->vfs_inode);
+	dir->vfs_inode.i_ctime = dir->vfs_inode.i_mtime;
+	ret = btrfs_update_inode_fallback(trans, root, dir);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
@@ -4757,7 +4757,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 
 	btrfs_record_snapshot_destroy(trans, dir);
 
-	ret = btrfs_unlink_subvol(trans, &dir->vfs_inode, dentry);
+	ret = btrfs_unlink_subvol(trans, dir, dentry);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
@@ -4861,7 +4861,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-		err = btrfs_unlink_subvol(trans, dir, dentry);
+		err = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
 		goto out;
 	}
 
@@ -9207,7 +9207,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 	/* src is a subvolume */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
-		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
+		ret = btrfs_unlink_subvol(trans, BTRFS_I(old_dir), old_dentry);
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
@@ -9222,7 +9222,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 	/* dest is a subvolume */
 	if (new_ino == BTRFS_FIRST_FREE_OBJECTID) {
-		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
+		ret = btrfs_unlink_subvol(trans, BTRFS_I(new_dir), new_dentry);
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
@@ -9469,7 +9469,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 				BTRFS_I(old_inode), 1);
 
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
-		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
+		ret = btrfs_unlink_subvol(trans, BTRFS_I(old_dir), old_dentry);
 	} else {
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(d_inode(old_dentry)),
@@ -9487,7 +9487,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		new_inode->i_ctime = current_time(new_inode);
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-			ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
+			ret = btrfs_unlink_subvol(trans, BTRFS_I(new_dir), new_dentry);
 			BUG_ON(new_inode->i_nlink == 0);
 		} else {
 			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
-- 
2.37.3


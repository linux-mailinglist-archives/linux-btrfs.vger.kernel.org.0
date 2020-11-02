Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC72A2D50
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgKBOtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:39906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKBOtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5PltmuNFQkXQ5OASElTVRmChdeRxxpUZxLtd6fXOfE=;
        b=gRVWOGTW5XTGI7bKg2sm+QPTbpEWkYhwEx/2Vu3VojuFfME3YElffb1G6ggYbMzhDc4fxL
        Et5qeSb7wQoMKas1nDsgFzOH6sLUhy2RzvPkeQXQSypQk18qzxsR32m8gb4S2HWCYyOqbS
        tlQ78j2OtqFyN6kWsL9J8OqOBHBrj+0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C46BEAE61;
        Mon,  2 Nov 2020 14:49:10 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/14] btrfs: Make btrfs_insert_replace_extent take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:02 +0200
Message-Id: <20201102144906.3767963-11-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1baf69f012fe..0f3b9fb842e7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2550,13 +2550,13 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 }

 static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
-				     struct inode *inode,
-				     struct btrfs_path *path,
-				     struct btrfs_replace_extent_info *extent_info,
-				     const u64 replace_len)
+				       struct btrfs_inode *inode,
+				       struct btrfs_path *path,
+				       struct btrfs_replace_extent_info *extent_info,
+				       const u64 replace_len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_file_extent_item *extent;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
@@ -2571,7 +2571,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	    btrfs_fs_incompat(fs_info, NO_HOLES))
 		return 0;

-	key.objectid = btrfs_ino(BTRFS_I(inode));
+	key.objectid = btrfs_ino(inode);
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = extent_info->file_offset;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
@@ -2592,8 +2592,8 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);

-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
-			extent_info->file_offset, replace_len);
+	ret = btrfs_inode_set_file_extent_range(inode, extent_info->file_offset,
+						replace_len);
 	if (ret)
 		return ret;

@@ -2601,14 +2601,14 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	if (extent_info->disk_offset == 0)
 		return 0;

-	inode_add_bytes(inode, replace_len);
+	inode_add_bytes(&inode->vfs_inode, replace_len);

 	if (extent_info->is_new_extent && extent_info->insertions == 0) {
 		key.objectid = extent_info->disk_offset;
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = extent_info->disk_len;
 		ret = btrfs_alloc_reserved_file_extent(trans, root,
-						       btrfs_ino(BTRFS_I(inode)),
+						       btrfs_ino(inode),
 						       extent_info->file_offset,
 						       extent_info->qgroup_reserved,
 						       &key);
@@ -2620,7 +2620,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 				       extent_info->disk_len, 0);
 		ref_offset = extent_info->file_offset - extent_info->data_offset;
 		btrfs_init_data_ref(&ref, root->root_key.objectid,
-				    btrfs_ino(BTRFS_I(inode)), ref_offset);
+				    btrfs_ino(inode), ref_offset);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 	}

@@ -2747,8 +2747,9 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 		if (extent_info && drop_end > extent_info->file_offset) {
 			u64 replace_len = drop_end - extent_info->file_offset;

-			ret = btrfs_insert_replace_extent(trans, inode, path,
-							extent_info, replace_len);
+			ret = btrfs_insert_replace_extent(trans, BTRFS_I(inode),
+							  path,	extent_info,
+							  replace_len);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				break;
@@ -2844,8 +2845,9 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,

 	}
 	if (extent_info) {
-		ret = btrfs_insert_replace_extent(trans, inode, path, extent_info,
-						extent_info->data_len);
+		ret = btrfs_insert_replace_extent(trans, BTRFS_I(inode), path,
+						  extent_info,
+						  extent_info->data_len);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
--
2.25.1


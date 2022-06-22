Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8984E555406
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiFVTLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiFVTLY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 15:11:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4717062
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 12:11:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DDA021B26;
        Wed, 22 Jun 2022 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655925081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ThOaLff2fLV9R+ymfCFzJ1GJx3OO755+rnVm11QbWmg=;
        b=SSHx9DWGhNHzmz5SZAGWmOEJu02o1cWq4rw8kbbr3ZCSXw7+YWN67POMwCe4ANMf+qxq/e
        OrYUGoq6RhcDSCKrgy/lTJbDPgIKuPC0rS8k8vZOzLht4Sp6VNGuY1uOdtOApQQwIHsxCB
        D7CKDby23ygSGuIarscNfy1TN8uqgMA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 447C02C141;
        Wed, 22 Jun 2022 19:11:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9A96DA82F; Wed, 22 Jun 2022 21:06:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: clean up chained assignments
Date:   Wed, 22 Jun 2022 21:06:43 +0200
Message-Id: <20220622190643.7087-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The chained assignments may be convenient to write, but make readability
a bit worse as it's too easy to overlook that there are several values
set on the same line while this is rather an exception.  Making it
consistent everywhere avoids surprises.

The pattern where inode times are initialized reuses the first value and
the order is mtime, ctime. In other blocks the assignments are expanded
so the order of variables is similar to the neighboring code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c               |  3 +-
 fs/btrfs/file.c                      |  9 ++++--
 fs/btrfs/free-space-cache.c          |  3 +-
 fs/btrfs/inode.c                     | 41 ++++++++++++++++++----------
 fs/btrfs/reflink.c                   |  6 ++--
 fs/btrfs/tests/extent-buffer-tests.c |  3 +-
 fs/btrfs/transaction.c               |  4 +--
 fs/btrfs/volumes.c                   |  3 +-
 8 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index a7dd6ba25e99..f43196a893ca 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -587,7 +587,8 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 	ASSERT(!IS_ERR(em));
 	map = em->map_lookup;
 
-	num_extents = cur_extent = 0;
+	num_extents = 0;
+	cur_extent = 0;
 	for (i = 0; i < map->num_stripes; i++) {
 		/* We have more device extent to copy */
 		if (srcdev != map->stripes[i].dev)
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 89c6d7ff1987..734baa729cd3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2058,9 +2058,11 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		num_written = btrfs_encoded_write(iocb, from, encoded);
 		num_sync = encoded->len;
 	} else if (iocb->ki_flags & IOCB_DIRECT) {
-		num_written = num_sync = btrfs_direct_write(iocb, from);
+		num_written = btrfs_direct_write(iocb, from);
+		num_sync = num_written;
 	} else {
-		num_written = num_sync = btrfs_buffered_write(iocb, from);
+		num_written = btrfs_buffered_write(iocb, from);
+		num_sync = num_written;
 	}
 
 	btrfs_set_inode_last_sub_trans(inode);
@@ -3100,7 +3102,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 
 	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = current_time(inode);
+	inode->i_ctime = inode->i_mtime;
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	updated_inode = true;
 	btrfs_end_transaction(trans);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b1ae3ba2ca2c..996da650ecdc 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3536,7 +3536,8 @@ int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
 	 * data, keep it dense.
 	 */
 	if (btrfs_test_opt(fs_info, SSD_SPREAD)) {
-		cont1_bytes = min_bytes = bytes + empty_size;
+		cont1_bytes = bytes + empty_size;
+		min_bytes = cont1_bytes;
 	} else if (block_group->flags & BTRFS_BLOCK_GROUP_METADATA) {
 		cont1_bytes = bytes;
 		min_bytes = fs_info->sectorsize;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 07b3fb90b621..9890782fe932 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3129,8 +3129,10 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
 						   oe->disk_num_bytes);
 	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
-	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
-		num_bytes = ram_bytes = oe->truncated_len;
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
+		num_bytes = oe->truncated_len;
+		ram_bytes = num_bytes;
+	}
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
@@ -4318,8 +4320,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name_len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
-	inode->vfs_inode.i_ctime = dir->vfs_inode.i_mtime =
-		dir->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+	dir->vfs_inode.i_mtime = inode->vfs_inode.i_ctime;
+	dir->vfs_inode.i_ctime = inode->vfs_inode.i_ctime;
 	ret = btrfs_update_inode(trans, root, dir);
 out:
 	return ret;
@@ -4481,7 +4484,8 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name_len * 2);
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = current_time(dir);
+	dir->i_ctime = dir->i_mtime;
 	ret = btrfs_update_inode_fallback(trans, root, BTRFS_I(dir));
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
@@ -5122,9 +5126,10 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	 */
 	if (newsize != oldsize) {
 		inode_inc_iversion(inode);
-		if (!(mask & (ATTR_CTIME | ATTR_MTIME)))
-			inode->i_ctime = inode->i_mtime =
-				current_time(inode);
+		if (!(mask & (ATTR_CTIME | ATTR_MTIME))) {
+			inode->i_mtime = current_time(inode);
+			inode->i_ctime = inode->i_mtime;
+		}
 	}
 
 	if (newsize > oldsize) {
@@ -7572,7 +7577,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
-			*map = em = em2;
+			*map = em2;
+			em = em2;
 		}
 
 		if (IS_ERR(em2)) {
@@ -9197,8 +9203,10 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	inode_inc_iversion(new_dir);
 	inode_inc_iversion(old_inode);
 	inode_inc_iversion(new_inode);
-	old_dir->i_ctime = old_dir->i_mtime = ctime;
-	new_dir->i_ctime = new_dir->i_mtime = ctime;
+	old_dir->i_mtime = ctime;
+	old_dir->i_ctime = ctime;
+	new_dir->i_mtime = ctime;
+	new_dir->i_ctime = ctime;
 	old_inode->i_ctime = ctime;
 	new_inode->i_ctime = ctime;
 
@@ -9461,9 +9469,11 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	inode_inc_iversion(old_inode);
-	old_dir->i_ctime = old_dir->i_mtime =
-	new_dir->i_ctime = new_dir->i_mtime =
-	old_inode->i_ctime = current_time(old_dir);
+	old_dir->i_mtime = current_time(old_dir);
+	old_dir->i_ctime = old_dir->i_mtime;
+	new_dir->i_mtime = old_dir->i_mtime;
+	new_dir->i_ctime = old_dir->i_mtime;
+	old_inode->i_ctime = old_dir->i_mtime;
 
 	if (old_dentry->d_parent != new_dentry->d_parent)
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
@@ -10618,7 +10628,8 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			ret = -ENOBUFS;
 			goto out_em;
 		}
-		disk_io_size = count = em->block_len;
+		disk_io_size = em->block_len;
+		count = em->block_len;
 		encoded->unencoded_len = em->ram_bytes;
 		encoded->unencoded_offset = iocb->ki_pos - em->orig_start;
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 8a6cabdb8f93..9acf47b11fe6 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -23,8 +23,10 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	int ret;
 
 	inode_inc_iversion(inode);
-	if (!no_time_update)
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+	if (!no_time_update) {
+		inode->i_mtime = current_time(inode);
+		inode->i_ctime = inode->i_mtime;
+	}
 	/*
 	 * We round up to the block size at eof when determining which
 	 * extents to clone above, but shouldn't round up the file size.
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index 51a8b075c259..b7d181a08eab 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -47,7 +47,8 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	path->nodes[0] = eb = alloc_dummy_extent_buffer(fs_info, nodesize);
+	eb = alloc_dummy_extent_buffer(fs_info, nodesize);
+	path->nodes[0] = eb;
 	if (!eb) {
 		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
 		ret = -ENOMEM;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4280676f7279..0a50d5746f6f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1818,8 +1818,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
 					 dentry->d_name.len * 2);
-	parent_inode->i_mtime = parent_inode->i_ctime =
-		current_time(parent_inode);
+	parent_inode->i_mtime = current_time(parent_inode);
+	parent_inode->i_ctime = parent_inode->i_mtime;
 	ret = btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 076040310f6f..2d788a351c1f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7211,7 +7211,8 @@ static int read_one_dev(struct extent_buffer *leaf,
 	u8 fs_uuid[BTRFS_FSID_SIZE];
 	u8 dev_uuid[BTRFS_UUID_SIZE];
 
-	devid = args.devid = btrfs_device_id(leaf, dev_item);
+	devid = btrfs_device_id(leaf, dev_item);
+	args.devid = devid;
 	read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
 			   BTRFS_UUID_SIZE);
 	read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
-- 
2.36.1


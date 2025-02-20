Return-Path: <linux-btrfs+bounces-11615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54CA3D5D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082EC3BAE00
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3421F193C;
	Thu, 20 Feb 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qHH+Bqsm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qHH+Bqsm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483341F153E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045660; cv=none; b=NP8hrmcl1Iqi4xSBy4kzUPhR8B4p5DX+HiG3nWJtZhc+gyoJPIq98QECMUKHZN1hSySl71zNCyXOzacZZEfPMtFe9zJyKwO79wY83mDOGlPl+AKQCrLP1wFMFSggYdfntBvJpv+zm/nf3uQfVRA4FNjCno2TUSy4uAixBDomO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045660; c=relaxed/simple;
	bh=Tlq2XC4cU2RZJNXNeriWhZHE8TtNU4nmagpjj8ReVjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6JCdBkrMBfmeNx6TJ34I3lF4ogJgVe3nMdK2wDmKXWq0V5ke06WDf9exd0w6is4NjyTgpV9UA968lWbOWQemQ6tGXPhUPkooO5+GpHnjtbIQSj4Nvk9dOuULgLgaoPSVGo8+WMkYi9ziB+GbprNYslFg6QpV5LXkjt0a74ixso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qHH+Bqsm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qHH+Bqsm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 492ED21181;
	Thu, 20 Feb 2025 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boYIqYVFrLeggIVjEbDz9ETWlLoLB6qsHz6Xw7Cj8qs=;
	b=qHH+BqsmIoStx61OnBs3ZTsZV531L1SOW5atMjd+vO65ZXQtwbCWWgqoDyi+rAM/wDiJU3
	P4IKp7T7ivw3wN1G3FjVEHBQYZ0UFq2/UXDzcQWttGPsUXwFhgePX1RfWJ4aIuOsRAPLuQ
	luHSx/Ar0VH/bmjEqlINNU0Xr6AvOTU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boYIqYVFrLeggIVjEbDz9ETWlLoLB6qsHz6Xw7Cj8qs=;
	b=qHH+BqsmIoStx61OnBs3ZTsZV531L1SOW5atMjd+vO65ZXQtwbCWWgqoDyi+rAM/wDiJU3
	P4IKp7T7ivw3wN1G3FjVEHBQYZ0UFq2/UXDzcQWttGPsUXwFhgePX1RfWJ4aIuOsRAPLuQ
	luHSx/Ar0VH/bmjEqlINNU0Xr6AvOTU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42A9F13301;
	Thu, 20 Feb 2025 10:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k3hDEFP9tmdPfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:00:51 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/22] btrfs: pass struct btrfs_inode to btrfs_read_locked_inode()
Date: Thu, 20 Feb 2025 11:00:50 +0100
Message-ID: <fe0e9242167099eced485d82baf51c26c2ebc8b0.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_read_locked_inode() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 117 +++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2311d1b0d5a9..01fd8a5fc21c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3846,12 +3846,13 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
  *
  * On failure clean up the inode.
  */
-static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
+static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *inode_item;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct inode *vfs_inode = &inode->vfs_inode;
 	struct btrfs_key location;
 	unsigned long ptr;
 	int maybe_acls;
@@ -3860,17 +3861,17 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	bool filled = false;
 	int first_xattr_slot;
 
-	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
+	ret = btrfs_init_file_extent_tree(inode);
 	if (ret)
 		goto out;
 
-	ret = btrfs_fill_inode(inode, &rdev);
+	ret = btrfs_fill_inode(vfs_inode, &rdev);
 	if (!ret)
 		filled = true;
 
 	ASSERT(path);
 
-	btrfs_get_inode_key(BTRFS_I(inode), &location);
+	btrfs_get_inode_key(inode, &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
 	if (ret) {
@@ -3890,42 +3891,41 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_inode_item);
-	inode->i_mode = btrfs_inode_mode(leaf, inode_item);
-	set_nlink(inode, btrfs_inode_nlink(leaf, inode_item));
-	i_uid_write(inode, btrfs_inode_uid(leaf, inode_item));
-	i_gid_write(inode, btrfs_inode_gid(leaf, inode_item));
-	btrfs_i_size_write(BTRFS_I(inode), btrfs_inode_size(leaf, inode_item));
-	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
-			round_up(i_size_read(inode), fs_info->sectorsize));
+	vfs_inode->i_mode = btrfs_inode_mode(leaf, inode_item);
+	set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
+	i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
+	i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
+	btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
+	btrfs_inode_set_file_extent_range(inode, 0,
+			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
 
-	inode_set_atime(inode, btrfs_timespec_sec(leaf, &inode_item->atime),
+	inode_set_atime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->atime),
 			btrfs_timespec_nsec(leaf, &inode_item->atime));
 
-	inode_set_mtime(inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
+	inode_set_mtime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
 			btrfs_timespec_nsec(leaf, &inode_item->mtime));
 
-	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
+	inode_set_ctime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
 			btrfs_timespec_nsec(leaf, &inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
-	BTRFS_I(inode)->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
+	inode->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
+	inode->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
 
-	inode_set_bytes(inode, btrfs_inode_nbytes(leaf, inode_item));
-	BTRFS_I(inode)->generation = btrfs_inode_generation(leaf, inode_item);
-	BTRFS_I(inode)->last_trans = btrfs_inode_transid(leaf, inode_item);
+	inode_set_bytes(vfs_inode, btrfs_inode_nbytes(leaf, inode_item));
+	inode->generation = btrfs_inode_generation(leaf, inode_item);
+	inode->last_trans = btrfs_inode_transid(leaf, inode_item);
 
-	inode_set_iversion_queried(inode,
-				   btrfs_inode_sequence(leaf, inode_item));
-	inode->i_generation = BTRFS_I(inode)->generation;
-	inode->i_rdev = 0;
+	inode_set_iversion_queried(vfs_inode, btrfs_inode_sequence(leaf, inode_item));
+	vfs_inode->i_generation = inode->generation;
+	vfs_inode->i_rdev = 0;
 	rdev = btrfs_inode_rdev(leaf, inode_item);
 
-	if (S_ISDIR(inode->i_mode))
-		BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(vfs_inode->i_mode))
+		inode->index_cnt = (u64)-1;
 
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
-				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
-	btrfs_update_inode_mapping_flags(BTRFS_I(inode));
+				&inode->flags, &inode->ro_flags);
+	btrfs_update_inode_mapping_flags(inode);
 
 cache_index:
 	/*
@@ -3937,9 +3937,8 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * This is required for both inode re-read from disk and delayed inode
 	 * in the delayed_nodes xarray.
 	 */
-	if (BTRFS_I(inode)->last_trans == btrfs_get_fs_generation(fs_info))
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			&BTRFS_I(inode)->runtime_flags);
+	if (inode->last_trans == btrfs_get_fs_generation(fs_info))
+		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 
 	/*
 	 * We don't persist the id of the transaction where an unlink operation
@@ -3968,7 +3967,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * transaction commits on fsync if our inode is a directory, or if our
 	 * inode is not a directory, logging its parent unnecessarily.
 	 */
-	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
+	inode->last_unlink_trans = inode->last_trans;
 
 	/*
 	 * Same logic as for last_unlink_trans. We don't persist the generation
@@ -3976,15 +3975,15 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * operation, so after eviction and reloading the inode we must be
 	 * pessimistic and assume the last transaction that modified the inode.
 	 */
-	BTRFS_I(inode)->last_reflink_trans = BTRFS_I(inode)->last_trans;
+	inode->last_reflink_trans = inode->last_trans;
 
 	path->slots[0]++;
-	if (inode->i_nlink != 1 ||
+	if (vfs_inode->i_nlink != 1 ||
 	    path->slots[0] >= btrfs_header_nritems(leaf))
 		goto cache_acl;
 
 	btrfs_item_key_to_cpu(leaf, &location, path->slots[0]);
-	if (location.objectid != btrfs_ino(BTRFS_I(inode)))
+	if (location.objectid != btrfs_ino(inode))
 		goto cache_acl;
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
@@ -3992,13 +3991,12 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 		struct btrfs_inode_ref *ref;
 
 		ref = (struct btrfs_inode_ref *)ptr;
-		BTRFS_I(inode)->dir_index = btrfs_inode_ref_index(leaf, ref);
+		inode->dir_index = btrfs_inode_ref_index(leaf, ref);
 	} else if (location.type == BTRFS_INODE_EXTREF_KEY) {
 		struct btrfs_inode_extref *extref;
 
 		extref = (struct btrfs_inode_extref *)ptr;
-		BTRFS_I(inode)->dir_index = btrfs_inode_extref_index(leaf,
-								     extref);
+		inode->dir_index = btrfs_inode_extref_index(leaf, extref);
 	}
 cache_acl:
 	/*
@@ -4006,50 +4004,49 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * any xattrs or acls
 	 */
 	maybe_acls = acls_after_inode_item(leaf, path->slots[0],
-			btrfs_ino(BTRFS_I(inode)), &first_xattr_slot);
+					   btrfs_ino(inode), &first_xattr_slot);
 	if (first_xattr_slot != -1) {
 		path->slots[0] = first_xattr_slot;
-		ret = btrfs_load_inode_props(inode, path);
+		ret = btrfs_load_inode_props(vfs_inode, path);
 		if (ret)
 			btrfs_err(fs_info,
 				  "error loading props for ino %llu (root %llu): %d",
-				  btrfs_ino(BTRFS_I(inode)),
-				  btrfs_root_id(root), ret);
+				  btrfs_ino(inode), btrfs_root_id(root), ret);
 	}
 
 	if (!maybe_acls)
-		cache_no_acl(inode);
+		cache_no_acl(vfs_inode);
 
-	switch (inode->i_mode & S_IFMT) {
+	switch (vfs_inode->i_mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_mapping->a_ops = &btrfs_aops;
-		inode->i_fop = &btrfs_file_operations;
-		inode->i_op = &btrfs_file_inode_operations;
+		vfs_inode->i_mapping->a_ops = &btrfs_aops;
+		vfs_inode->i_fop = &btrfs_file_operations;
+		vfs_inode->i_op = &btrfs_file_inode_operations;
 		break;
 	case S_IFDIR:
-		inode->i_fop = &btrfs_dir_file_operations;
-		inode->i_op = &btrfs_dir_inode_operations;
+		vfs_inode->i_fop = &btrfs_dir_file_operations;
+		vfs_inode->i_op = &btrfs_dir_inode_operations;
 		break;
 	case S_IFLNK:
-		inode->i_op = &btrfs_symlink_inode_operations;
-		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &btrfs_aops;
+		vfs_inode->i_op = &btrfs_symlink_inode_operations;
+		inode_nohighmem(vfs_inode);
+		vfs_inode->i_mapping->a_ops = &btrfs_aops;
 		break;
 	default:
-		inode->i_op = &btrfs_special_inode_operations;
-		init_special_inode(inode, inode->i_mode, rdev);
+		vfs_inode->i_op = &btrfs_special_inode_operations;
+		init_special_inode(vfs_inode, vfs_inode->i_mode, rdev);
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(vfs_inode);
 
-	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	ret = btrfs_add_inode_to_root(inode, true);
 	if (ret)
 		goto out;
 
 	return 0;
 out:
-	iget_failed(inode);
+	iget_failed(vfs_inode);
 	return ret;
 }
 
@@ -5636,7 +5633,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	ret = btrfs_read_locked_inode(inode, path);
+	ret = btrfs_read_locked_inode(BTRFS_I(inode), path);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -5664,7 +5661,7 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	ret = btrfs_read_locked_inode(inode, path);
+	ret = btrfs_read_locked_inode(BTRFS_I(inode), path);
 	btrfs_free_path(path);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.47.1



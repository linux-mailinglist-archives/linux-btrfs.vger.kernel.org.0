Return-Path: <linux-btrfs+bounces-12737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1EA7852D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EC83AF768
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C50219A90;
	Tue,  1 Apr 2025 23:18:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB51A5BB0
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549510; cv=none; b=p/07jSsFitfgE6q2HvzArNNlWQUhDDtWljpA6nqnZ7UHeAlIVZkwHFruh3djdKa9RhSb0U5ZMa3FEuKmYenEKR/Efi8sNGar368PD+Ao7nfjRWaIVJSkV0dRsTYqBwymtPHgos0OqV7/JFB/N7TazHHsEeCwJmiesUbS0P6GYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549510; c=relaxed/simple;
	bh=1MP+sANNLPIzZJW1L3qvO9Oqgxs8evnF9O/Du2jnTME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktHgOghZ9QmWvYeVg+4hGgOTYRuA/69lObE2+HVGGZxjrVMTAqKJaj2IdiXa8CPFUwOcK52XEZUmdJMHXjTRGGLEqF1/5pmbMXP1yX700sV7Ujwl5on3CpgpXeVf29UyUWzXX04hhV2k+5V3rrf1rQfbEmD6Psr/NYZZ1uMKHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A1E61F445;
	Tue,  1 Apr 2025 23:18:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0300C13691;
	Tue,  1 Apr 2025 23:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0eK+AD507GepewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/7] btrfs: do more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Wed,  2 Apr 2025 01:18:06 +0200
Message-ID: <b4a20aa684dc9f0324c7fe4728c1829a8b996f71.1743549291.git.dsterba@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1743549291.git.dsterba@suse.com>
References: <cover.1743549291.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 0A1E61F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The most trivial pattern for the auto freeing when the variable is
declared with the macro and the final btrfs_free_path() is removed.
There are almost none goto -> return conversions and there's no other
function cleanup.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c      |  3 +--
 fs/btrfs/fiemap.c           |  3 +--
 fs/btrfs/file-item.c        |  3 +--
 fs/btrfs/file.c             |  3 +--
 fs/btrfs/free-space-cache.c |  3 +--
 fs/btrfs/inode.c            | 27 +++++++++------------------
 6 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a38578c60f34e6..3eba00da9fc7a5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -700,7 +700,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 	struct btrfs_block_group *block_group = caching_ctl->block_group;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *extent_root;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	u64 total_found = 0;
@@ -827,7 +827,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 				       block_group->start + block_group->length,
 				       NULL);
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index b80c07ad8c5e71..7715e30508c575 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -634,7 +634,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	const u64 ino = btrfs_ino(inode);
 	struct extent_state *cached_state = NULL;
 	struct extent_state *delalloc_cached_state = NULL;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
 	u64 last_extent_end = 0;
@@ -874,7 +874,6 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	free_extent_state(delalloc_cached_state);
 	kfree(cache.entries);
 	btrfs_free_backref_share_ctx(backref_ctx);
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 344b4db487a0c6..c191be6bcefbd2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1048,7 +1048,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key file_key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_csum_item *item;
 	struct btrfs_csum_item *item_end;
 	struct extent_buffer *leaf = NULL;
@@ -1259,7 +1259,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		goto again;
 	}
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fe81129cfbf1b7..e7e8c477f83701 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -553,7 +553,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_ref ref = { 0 };
 	struct btrfs_key key;
@@ -791,7 +791,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		}
 	}
 out:
-	btrfs_free_path(path);
 	return ret;
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 1b3082e81220d2..f66a0a6e505079 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -308,7 +308,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	bool locked = false;
 
 	if (block_group) {
-		struct btrfs_path *path = btrfs_alloc_path();
+		BTRFS_PATH_AUTO_FREE(path);
 
 		if (!path) {
 			ret = -ENOMEM;
@@ -330,7 +330,6 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 		spin_lock(&block_group->lock);
 		block_group->disk_cache_state = BTRFS_DC_CLEAR;
 		spin_unlock(&block_group->lock);
-		btrfs_free_path(path);
 	}
 
 	btrfs_i_size_write(inode, 0);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 520b12638ee49c..db989572cba419 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2933,7 +2933,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	const u64 sectorsize = root->fs_info->sectorsize;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key ins;
 	u64 disk_num_bytes = btrfs_stack_file_extent_disk_num_bytes(stack_fi);
@@ -3015,8 +3015,6 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 					       file_pos - offset,
 					       qgroup_reserved, &ins);
 out:
-	btrfs_free_path(path);
-
 	return ret;
 }
 
@@ -3540,7 +3538,7 @@ static int btrfs_orphan_del(struct btrfs_trans_handle *trans,
 int btrfs_orphan_cleanup(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key, found_key;
 	struct btrfs_trans_handle *trans;
@@ -3730,7 +3728,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 out:
 	if (ret)
 		btrfs_err(fs_info, "could not do orphan cleanup %d", ret);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -4123,7 +4120,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 					    struct btrfs_inode *inode)
 {
 	struct btrfs_inode_item *inode_item;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int ret;
@@ -4137,7 +4134,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		goto failed;
+		return ret;
 	}
 
 	leaf = path->nodes[0];
@@ -4146,10 +4143,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 
 	fill_inode_item(trans, leaf, inode_item, &inode->vfs_inode);
 	btrfs_set_inode_last_trans(trans, inode);
-	ret = 0;
-failed:
-	btrfs_free_path(path);
-	return ret;
+	return 0;
 }
 
 /*
@@ -5456,7 +5450,7 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 			       struct btrfs_key *location, u8 *type)
 {
 	struct btrfs_dir_item *di;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *root = dir->root;
 	int ret = 0;
 	struct fscrypt_name fname;
@@ -5467,7 +5461,7 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 
 	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
 	if (ret < 0)
-		goto out;
+		return ret;
 	/*
 	 * fscrypt_setup_filename() should never return a positive value, but
 	 * gcc on sparc/parisc thinks it can, so assert that doesn't happen.
@@ -5496,7 +5490,6 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 		*type = btrfs_dir_ftype(path->nodes[0], di);
 out:
 	fscrypt_free_filename(&fname);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -5511,7 +5504,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 				    struct btrfs_key *location,
 				    struct btrfs_root **sub_root)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_root *new_root;
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
@@ -5567,7 +5560,6 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	location->offset = 0;
 	err = 0;
 out:
-	btrfs_free_path(path);
 	fscrypt_free_filename(&fname);
 	return err;
 }
@@ -5988,7 +5980,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	void *addr;
 	LIST_HEAD(ins_list);
 	LIST_HEAD(del_list);
@@ -6101,7 +6093,6 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 err:
 	if (put)
 		btrfs_readdir_put_delayed_items(BTRFS_I(inode), &ins_list, &del_list);
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.48.1



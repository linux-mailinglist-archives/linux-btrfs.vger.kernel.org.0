Return-Path: <linux-btrfs+bounces-5366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00E8D50B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E08F281BF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BEB4596F;
	Thu, 30 May 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m0wg4wqP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m0wg4wqP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CD405FB
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089267; cv=none; b=CGXZ4Qwiy2YGKEeB0I06YalUiNbmEQgwyBHln7Fb+citkf8KxjT1DEnk/JccYDkuPwap2wV+tR0WKottG5KZt+W1YHiTvnGc1H6QNh0lo3mY4sBTyjUKZkckavyj1qfYe4gU2HdlgRWDjWh9quW8cDLujp4xJE4Mh5BhzYmt8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089267; c=relaxed/simple;
	bh=4ww74grZMHWR1qk7cUjQtAa3POH59yCGgaCv6h0j4Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fj3HGjYIASpfFhgGZULMvJJf3TzKG2muEiKDU9c2/LNFwb/9fKhBwcTp6o8NP9Vs1iezSCUnElWB+PdH3ghRwXxXvoGwJz1JBTi1FSz64fB/4uIGdZxxlUKq1VQNQYpzj1cXqS4lcpWWqCIVlG4fNEAHZZo9V3PQzbKVFNCjfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m0wg4wqP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m0wg4wqP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B203A219FF;
	Thu, 30 May 2024 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717089261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cydmoieO1pg7RkrQmUohx6NHPbxqAupJajvZtgoq+XE=;
	b=m0wg4wqPPrMPyMEHlANvgmDAKnYwf4OnwjyFJBeYpouwRKiWQ6UjiFWQo2B/BzS/D9F4B/
	ewJxuwnRPVNZGhXs1SyAhQOS2V5J6UtyO1BohB6+xtz5HvOH3W1ZMOsj0TK4NdYYCgzlWN
	M/b8Q5R7UtheLL6PaiHZca1ULUsEKUI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717089261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cydmoieO1pg7RkrQmUohx6NHPbxqAupJajvZtgoq+XE=;
	b=m0wg4wqPPrMPyMEHlANvgmDAKnYwf4OnwjyFJBeYpouwRKiWQ6UjiFWQo2B/BzS/D9F4B/
	ewJxuwnRPVNZGhXs1SyAhQOS2V5J6UtyO1BohB6+xtz5HvOH3W1ZMOsj0TK4NdYYCgzlWN
	M/b8Q5R7UtheLL6PaiHZca1ULUsEKUI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6FCC13A42;
	Thu, 30 May 2024 17:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M394KO2zWGYRGQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 30 May 2024 17:14:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: constify pointer parameters where applicable
Date: Thu, 30 May 2024 19:14:12 +0200
Message-ID: <20240530171413.25866-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

We can add const to many parameters, this is for clarity and minor
addition to safety. There are some minor effects, in the assembly
code and .ko measured on release config. This patch does not cover all
possible conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h    |  4 ++--
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delalloc-space.h |  2 +-
 fs/btrfs/delayed-inode.c  |  6 +++---
 fs/btrfs/delayed-inode.h  |  6 +++---
 fs/btrfs/dir-item.c       |  8 ++++----
 fs/btrfs/dir-item.h       |  6 +++---
 fs/btrfs/disk-io.c        | 18 +++++++++---------
 fs/btrfs/disk-io.h        | 17 ++++++++---------
 fs/btrfs/extent_io.c      | 26 +++++++++++++-------------
 fs/btrfs/extent_io.h      |  6 +++---
 fs/btrfs/fs.h             | 10 +++++-----
 fs/btrfs/ioctl.c          |  2 +-
 fs/btrfs/ioctl.h          |  2 +-
 fs/btrfs/misc.h           |  4 ++--
 fs/btrfs/props.c          |  6 +++---
 fs/btrfs/props.h          |  2 +-
 fs/btrfs/qgroup.c         | 22 +++++++++++-----------
 fs/btrfs/qgroup.h         | 12 ++++++------
 fs/btrfs/send.c           |  2 +-
 fs/btrfs/send.h           |  2 +-
 fs/btrfs/super.c          |  4 ++--
 fs/btrfs/super.h          |  2 +-
 fs/btrfs/uuid-tree.c      | 10 +++++-----
 fs/btrfs/uuid-tree.h      |  4 ++--
 fs/btrfs/volumes.c        |  2 +-
 fs/btrfs/volumes.h        |  2 +-
 fs/btrfs/xattr.c          |  2 +-
 fs/btrfs/xattr.h          |  2 +-
 fs/btrfs/zoned.c          |  2 +-
 fs/btrfs/zoned.h          |  4 ++--
 31 files changed, 99 insertions(+), 100 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 156384a28904..e0deab2cde7f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -413,12 +413,12 @@ static inline void btrfs_i_size_write(struct btrfs_inode *inode, u64 size)
 	inode->disk_i_size = size;
 }
 
-static inline bool btrfs_is_free_space_inode(struct btrfs_inode *inode)
+static inline bool btrfs_is_free_space_inode(const struct btrfs_inode *inode)
 {
 	return test_bit(BTRFS_INODE_FREE_SPACE_INODE, &inode->runtime_flags);
 }
 
-static inline bool is_data_inode(struct inode *inode)
+static inline bool is_data_inode(const struct inode *inode)
 {
 	return btrfs_ino(BTRFS_I(inode)) != BTRFS_BTREE_INODE_OBJECTID;
 }
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index b3527efd0b4b..7aa8a395d838 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -111,7 +111,7 @@
  *  making error handling and cleanup easier.
  */
 
-int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
+int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index ce4f889e4f17..3f32953c0a80 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -9,7 +9,7 @@ struct extent_changeset;
 struct btrfs_inode;
 struct btrfs_fs_info;
 
-int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
+int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes);
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len,
 			bool noflush);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 483c141dc488..7b8b1bd0ca39 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1469,7 +1469,7 @@ static void btrfs_release_dir_index_item_space(struct btrfs_trans_handle *trans)
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
 				   struct btrfs_inode *dir,
-				   struct btrfs_disk_key *disk_key, u8 flags,
+				   const struct btrfs_disk_key *disk_key, u8 flags,
 				   u64 index)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1755,7 +1755,7 @@ void btrfs_readdir_put_delayed_items(struct inode *inode,
 	downgrade_write(&inode->i_rwsem);
 }
 
-int btrfs_should_delete_dir_index(struct list_head *del_list,
+int btrfs_should_delete_dir_index(const struct list_head *del_list,
 				  u64 index)
 {
 	struct btrfs_delayed_item *curr;
@@ -1776,7 +1776,7 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
  * Read dir info stored in the delayed tree.
  */
 int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
-				    struct list_head *ins_list)
+				    const struct list_head *ins_list)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_delayed_item *curr, *next;
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 64e115d97499..654c04d38fb3 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -110,7 +110,7 @@ void btrfs_init_delayed_root(struct btrfs_delayed_root *delayed_root);
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
 				   struct btrfs_inode *dir,
-				   struct btrfs_disk_key *disk_key, u8 flags,
+				   const struct btrfs_disk_key *disk_key, u8 flags,
 				   u64 index);
 
 int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
@@ -150,10 +150,10 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 void btrfs_readdir_put_delayed_items(struct inode *inode,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
-int btrfs_should_delete_dir_index(struct list_head *del_list,
+int btrfs_should_delete_dir_index(const struct list_head *del_list,
 				  u64 index);
 int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
-				    struct list_head *ins_list);
+				    const struct list_head *ins_list);
 
 /* Used during directory logging. */
 void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 9c07d5c3e5ad..001c0c2f872c 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -22,7 +22,7 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 						   *trans,
 						   struct btrfs_root *root,
 						   struct btrfs_path *path,
-						   struct btrfs_key *cpu_key,
+						   const struct btrfs_key *cpu_key,
 						   u32 data_size,
 						   const char *name,
 						   int name_len)
@@ -108,7 +108,7 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
  */
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 			  const struct fscrypt_str *name, struct btrfs_inode *dir,
-			  struct btrfs_key *location, u8 type, u64 index)
+			  const struct btrfs_key *location, u8 type, u64 index)
 {
 	int ret = 0;
 	int ret2 = 0;
@@ -379,7 +379,7 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
  * for a specific name.
  */
 struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
-						 struct btrfs_path *path,
+						 const struct btrfs_path *path,
 						 const char *name, int name_len)
 {
 	struct btrfs_dir_item *dir_item;
@@ -417,7 +417,7 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
-			      struct btrfs_dir_item *di)
+			      const struct btrfs_dir_item *di)
 {
 
 	struct extent_buffer *leaf;
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 00b3d83d7569..5f6dfafc91f1 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -17,7 +17,7 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 			  const struct fscrypt_str *name, struct btrfs_inode *dir,
-			  struct btrfs_key *location, u8 type, u64 index);
+			  const struct btrfs_key *location, u8 type, u64 index);
 struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
@@ -33,7 +33,7 @@ struct btrfs_dir_item *btrfs_search_dir_index_item(struct btrfs_root *root,
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
-			      struct btrfs_dir_item *di);
+			      const struct btrfs_dir_item *di);
 int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
 			    struct btrfs_path *path, u64 objectid,
@@ -45,7 +45,7 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 					  const char *name, u16 name_len,
 					  int mod);
 struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
-						 struct btrfs_path *path,
+						 const struct btrfs_path *path,
 						 const char *name,
 						 int name_len);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ef94dca7a7f1..e7ec8a9fdd98 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -213,7 +213,7 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
  *			structure for details.
  */
 int btrfs_read_extent_buffer(struct extent_buffer *eb,
-			     struct btrfs_tree_parent_check *check)
+			     const struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int failed = 0;
@@ -358,7 +358,7 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
 
 /* Do basic extent buffer checks at read time */
 int btrfs_validate_extent_buffer(struct extent_buffer *eb,
-				 struct btrfs_tree_parent_check *check)
+				 const struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 found_start;
@@ -425,7 +425,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 		goto out;
 	}
 	if (check->has_first_key) {
-		struct btrfs_key *expect_key = &check->first_key;
+		const struct btrfs_key *expect_key = &check->first_key;
 		struct btrfs_key found_key;
 
 		if (found_level)
@@ -1021,7 +1021,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 
 static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 					      struct btrfs_path *path,
-					      struct btrfs_key *key)
+					      const struct btrfs_key *key)
 {
 	struct btrfs_root *root;
 	struct btrfs_tree_parent_check check = { 0 };
@@ -1083,7 +1083,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 }
 
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
-					struct btrfs_key *key)
+					const struct btrfs_key *key)
 {
 	struct btrfs_root *root;
 	struct btrfs_path *path;
@@ -1218,7 +1218,7 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
+void btrfs_check_leaked_roots(const struct btrfs_fs_info *fs_info)
 {
 #ifdef CONFIG_BTRFS_DEBUG
 	struct btrfs_root *root;
@@ -2335,8 +2335,8 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
  * 		1, 2	2nd and 3rd backup copy
  * 	       -1	skip bytenr check
  */
-int btrfs_validate_super(struct btrfs_fs_info *fs_info,
-			 struct btrfs_super_block *sb, int mirror_num)
+int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
+			 const struct btrfs_super_block *sb, int mirror_num)
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
@@ -3188,7 +3188,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 }
 
 int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
-		      char *options)
+		      const char *options)
 {
 	u32 sectorsize;
 	u32 nodesize;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 1f93feae1872..99af64d3f277 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -41,7 +41,7 @@ static inline u64 btrfs_sb_offset(int mirror)
 	return BTRFS_SUPER_INFO_OFFSET;
 }
 
-void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info);
+void btrfs_check_leaked_roots(const struct btrfs_fs_info *fs_info);
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				      struct btrfs_tree_parent_check *check);
@@ -52,12 +52,11 @@ struct extent_buffer *btrfs_find_create_tree_block(
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
-int __cold open_ctree(struct super_block *sb,
-	       struct btrfs_fs_devices *fs_devices,
-	       char *options);
+int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
+		      const char *options);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
-int btrfs_validate_super(struct btrfs_fs_info *fs_info,
-			 struct btrfs_super_block *sb, int mirror_num);
+int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
+			 const struct btrfs_super_block *sb, int mirror_num);
 int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
@@ -65,7 +64,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 						   int copy_num, bool drop_cache);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
-					struct btrfs_key *key);
+					const struct btrfs_key *key);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root);
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
@@ -90,7 +89,7 @@ void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 				 struct btrfs_root *root);
 int btrfs_validate_extent_buffer(struct extent_buffer *eb,
-				 struct btrfs_tree_parent_check *check);
+				 const struct btrfs_tree_parent_check *check);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
@@ -117,7 +116,7 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_extent_buffer(struct extent_buffer *buf,
-			     struct btrfs_tree_parent_check *check);
+			     const struct btrfs_tree_parent_check *check);
 
 blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c74f7df2e8b..ea9a96f1e001 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -180,7 +180,7 @@ void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 }
 
 static void process_one_page(struct btrfs_fs_info *fs_info,
-			     struct page *page, struct page *locked_page,
+			     struct page *page, const struct page *locked_page,
 			     unsigned long page_ops, u64 start, u64 end)
 {
 	struct folio *folio = page_folio(page);
@@ -203,7 +203,7 @@ static void process_one_page(struct btrfs_fs_info *fs_info,
 }
 
 static void __process_pages_contig(struct address_space *mapping,
-				   struct page *locked_page, u64 start, u64 end,
+				   const struct page *locked_page, u64 start, u64 end,
 				   unsigned long page_ops)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
@@ -230,8 +230,8 @@ static void __process_pages_contig(struct address_space *mapping,
 	}
 }
 
-static noinline void __unlock_for_delalloc(struct inode *inode,
-					   struct page *locked_page,
+static noinline void __unlock_for_delalloc(const struct inode *inode,
+					   const struct page *locked_page,
 					   u64 start, u64 end)
 {
 	unsigned long index = start >> PAGE_SHIFT;
@@ -246,7 +246,7 @@ static noinline void __unlock_for_delalloc(struct inode *inode,
 }
 
 static noinline int lock_delalloc_pages(struct inode *inode,
-					struct page *locked_page,
+					const struct page *locked_page,
 					u64 start,
 					u64 end)
 {
@@ -411,7 +411,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 }
 
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-				  struct page *locked_page,
+				  const struct page *locked_page,
 				  struct extent_state **cached,
 				  u32 clear_bits, unsigned long page_ops)
 {
@@ -1382,7 +1382,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
  * Return the next dirty range in [@start, @end).
  * If no dirty range is found, @start will be page_offset(page) + PAGE_SIZE.
  */
-static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
+static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
 				 struct page *page, u64 *start, u64 *end)
 {
 	struct folio *folio = page_folio(page);
@@ -1743,7 +1743,7 @@ static void set_btree_ioerr(struct extent_buffer *eb)
  * context.
  */
 static struct extent_buffer *find_extent_buffer_nolock(
-		struct btrfs_fs_info *fs_info, u64 start)
+		const struct btrfs_fs_info *fs_info, u64 start)
 {
 	struct extent_buffer *eb;
 
@@ -2312,7 +2312,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-void extent_write_locked_range(struct inode *inode, struct page *locked_page,
+void extent_write_locked_range(struct inode *inode, const struct page *locked_page,
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty)
 {
@@ -2597,7 +2597,7 @@ static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *foli
 	return false;
 }
 
-static void detach_extent_buffer_folio(struct extent_buffer *eb, struct folio *folio)
+static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
@@ -2658,7 +2658,7 @@ static void detach_extent_buffer_folio(struct extent_buffer *eb, struct folio *f
 }
 
 /* Release all pages attached to the extent buffer */
-static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+static void btrfs_release_extent_buffer_pages(const struct extent_buffer *eb)
 {
 	ASSERT(!extent_buffer_under_io(eb));
 
@@ -3573,7 +3573,7 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 }
 
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
-			     struct btrfs_tree_parent_check *check)
+			     const struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_bio *bbio;
 	bool ret;
@@ -4186,7 +4186,7 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 
 #define GANG_LOOKUP_SIZE	16
 static struct extent_buffer *get_next_extent_buffer(
-		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
+		const struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
 {
 	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
 	struct extent_buffer *found = NULL;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index ecf89424502e..96c6bbdcd5d6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -235,7 +235,7 @@ bool try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-void extent_write_locked_range(struct inode *inode, struct page *locked_page,
+void extent_write_locked_range(struct inode *inode, const struct page *locked_page,
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty);
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
@@ -261,7 +261,7 @@ void free_extent_buffer_stale(struct extent_buffer *eb);
 #define WAIT_COMPLETE	1
 #define WAIT_PAGE_LOCK	2
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
-			     struct btrfs_tree_parent_check *parent_check);
+			     const struct btrfs_tree_parent_check *parent_check);
 void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level);
@@ -350,7 +350,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-				  struct page *locked_page,
+				  const struct page *locked_page,
 				  struct extent_state **cached,
 				  u32 bits_to_clear, unsigned long page_ops);
 int extent_invalidate_folio(struct extent_io_tree *tree,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index e6b1903f6c32..18e0d3539496 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -956,7 +956,7 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 /*
  * Count how many fs_info->max_extent_size cover the @size
  */
-static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
+static inline u32 count_max_extents(const struct btrfs_fs_info *fs_info, u64 size)
 {
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (!fs_info)
@@ -1017,7 +1017,7 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 #define btrfs_test_opt(fs_info, opt)	((fs_info)->mount_opt & \
 					 BTRFS_MOUNT_##opt)
 
-static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
+static inline int btrfs_fs_closing(const struct btrfs_fs_info *fs_info)
 {
 	/* Do it this way so we only ever do one test_bit in the normal case. */
 	if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)) {
@@ -1036,7 +1036,7 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
  * since setting and checking for SB_RDONLY in the superblock's flags is not
  * atomic.
  */
-static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
+static inline int btrfs_need_cleaner_sleep(const struct btrfs_fs_info *fs_info)
 {
 	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
 		btrfs_fs_closing(fs_info);
@@ -1057,7 +1057,7 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 
 #define EXPORT_FOR_TESTS
 
-static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
+static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
 {
 	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 }
@@ -1068,7 +1068,7 @@ void btrfs_test_destroy_inode(struct inode *inode);
 
 #define EXPORT_FOR_TESTS static
 
-static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
+static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
 {
 	return 0;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6e24cced6f0d..5e3cb0210869 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -552,7 +552,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-int __pure btrfs_is_empty_uuid(u8 *uuid)
+int __pure btrfs_is_empty_uuid(const u8 *uuid)
 {
 	int i;
 
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 2c5dc25ec670..19cd26b0244a 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -19,7 +19,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
-int __pure btrfs_is_empty_uuid(u8 *uuid);
+int __pure btrfs_is_empty_uuid(const u8 *uuid);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 				     struct btrfs_ioctl_balance_args *bargs);
 
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index dde4904aead9..0d599fd847c9 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -66,7 +66,7 @@ struct rb_simple_node {
 	u64 bytenr;
 };
 
-static inline struct rb_node *rb_simple_search(struct rb_root *root, u64 bytenr)
+static inline struct rb_node *rb_simple_search(const struct rb_root *root, u64 bytenr)
 {
 	struct rb_node *node = root->rb_node;
 	struct rb_simple_node *entry;
@@ -93,7 +93,7 @@ static inline struct rb_node *rb_simple_search(struct rb_root *root, u64 bytenr)
  * Return the rb_node that start at or after @bytenr.  If there is no entry at
  * or after @bytner return NULL.
  */
-static inline struct rb_node *rb_simple_search_first(struct rb_root *root,
+static inline struct rb_node *rb_simple_search_first(const struct rb_root *root,
 						     u64 bytenr)
 {
 	struct rb_node *node = root->rb_node, *ret = NULL;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 155570e20f45..5c8e64eaf48b 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -27,7 +27,7 @@ struct prop_handler {
 	int (*validate)(const struct btrfs_inode *inode, const char *value,
 			size_t len);
 	int (*apply)(struct inode *inode, const char *value, size_t len);
-	const char *(*extract)(struct inode *inode);
+	const char *(*extract)(const struct inode *inode);
 	bool (*ignore)(const struct btrfs_inode *inode);
 	int inheritable;
 };
@@ -359,7 +359,7 @@ static bool prop_compression_ignore(const struct btrfs_inode *inode)
 	return false;
 }
 
-static const char *prop_compression_extract(struct inode *inode)
+static const char *prop_compression_extract(const struct inode *inode)
 {
 	switch (BTRFS_I(inode)->prop_compress) {
 	case BTRFS_COMPRESS_ZLIB:
@@ -385,7 +385,7 @@ static struct prop_handler prop_handlers[] = {
 };
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
-			      struct inode *inode, struct inode *parent)
+			      struct inode *inode, const struct inode *parent)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index f60cd89feb29..24131b29d842 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -26,6 +26,6 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 			      struct inode *inode,
-			      struct inode *dir);
+			      const struct inode *dir);
 
 #endif
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7dac4028e3ba..dfe79534139e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -30,7 +30,7 @@
 #include "root-tree.h"
 #include "tree-checker.h"
 
-enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
+enum btrfs_qgroup_mode btrfs_qgroup_mode(const struct btrfs_fs_info *fs_info)
 {
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		return BTRFS_QGROUP_MODE_DISABLED;
@@ -39,12 +39,12 @@ enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info)
 	return BTRFS_QGROUP_MODE_FULL;
 }
 
-bool btrfs_qgroup_enabled(struct btrfs_fs_info *fs_info)
+bool btrfs_qgroup_enabled(const struct btrfs_fs_info *fs_info)
 {
 	return btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED;
 }
 
-bool btrfs_qgroup_full_accounting(struct btrfs_fs_info *fs_info)
+bool btrfs_qgroup_full_accounting(const struct btrfs_fs_info *fs_info)
 {
 	return btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL;
 }
@@ -107,7 +107,7 @@ static void qgroup_rsv_release(struct btrfs_fs_info *fs_info,
 
 static void qgroup_rsv_add_by_qgroup(struct btrfs_fs_info *fs_info,
 				     struct btrfs_qgroup *dest,
-				     struct btrfs_qgroup *src)
+				     const struct btrfs_qgroup *src)
 {
 	int i;
 
@@ -117,7 +117,7 @@ static void qgroup_rsv_add_by_qgroup(struct btrfs_fs_info *fs_info,
 
 static void qgroup_rsv_release_by_qgroup(struct btrfs_fs_info *fs_info,
 					 struct btrfs_qgroup *dest,
-					  struct btrfs_qgroup *src)
+					 const struct btrfs_qgroup *src)
 {
 	int i;
 
@@ -141,14 +141,14 @@ static void btrfs_qgroup_update_new_refcnt(struct btrfs_qgroup *qg, u64 seq,
 	qg->new_refcnt += mod;
 }
 
-static inline u64 btrfs_qgroup_get_old_refcnt(struct btrfs_qgroup *qg, u64 seq)
+static inline u64 btrfs_qgroup_get_old_refcnt(const struct btrfs_qgroup *qg, u64 seq)
 {
 	if (qg->old_refcnt < seq)
 		return 0;
 	return qg->old_refcnt - seq;
 }
 
-static inline u64 btrfs_qgroup_get_new_refcnt(struct btrfs_qgroup *qg, u64 seq)
+static inline u64 btrfs_qgroup_get_new_refcnt(const struct btrfs_qgroup *qg, u64 seq)
 {
 	if (qg->new_refcnt < seq)
 		return 0;
@@ -171,7 +171,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info);
 
 /* must be called with qgroup_ioctl_lock held */
-static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+static struct btrfs_qgroup *find_qgroup_rb(const struct btrfs_fs_info *fs_info,
 					   u64 qgroupid)
 {
 	struct rb_node *n = fs_info->qgroup_tree.rb_node;
@@ -346,7 +346,7 @@ static int del_relation_rb(struct btrfs_fs_info *fs_info,
 }
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
+int btrfs_verify_qgroup_counts(const struct btrfs_fs_info *fs_info, u64 qgroupid,
 			       u64 rfer, u64 excl)
 {
 	struct btrfs_qgroup *qgroup;
@@ -608,7 +608,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
  * Return false if no reserved space is left.
  * Return true if some reserved space is leaked.
  */
-bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
+bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
 	bool ret = false;
@@ -4897,7 +4897,7 @@ void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64 rsv_byte
 }
 
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
-			      struct btrfs_squota_delta *delta)
+			      const struct btrfs_squota_delta *delta)
 {
 	int ret;
 	struct btrfs_qgroup *qgroup;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7c535710efa5..95881dcab684 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -311,9 +311,9 @@ enum btrfs_qgroup_mode {
 	BTRFS_QGROUP_MODE_SIMPLE
 };
 
-enum btrfs_qgroup_mode btrfs_qgroup_mode(struct btrfs_fs_info *fs_info);
-bool btrfs_qgroup_enabled(struct btrfs_fs_info *fs_info);
-bool btrfs_qgroup_full_accounting(struct btrfs_fs_info *fs_info);
+enum btrfs_qgroup_mode btrfs_qgroup_mode(const struct btrfs_fs_info *fs_info);
+bool btrfs_qgroup_enabled(const struct btrfs_fs_info *fs_info);
+bool btrfs_qgroup_full_accounting(const struct btrfs_fs_info *fs_info);
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 		       struct btrfs_ioctl_quota_ctl_args *quota_ctl_args);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
@@ -361,7 +361,7 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 			       enum btrfs_qgroup_rsv_type type);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
+int btrfs_verify_qgroup_counts(const struct btrfs_fs_info *fs_info, u64 qgroupid,
 			       u64 rfer, u64 excl);
 #endif
 
@@ -431,9 +431,9 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
-bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
+bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
 void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64 rsv_bytes);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
-			      struct btrfs_squota_delta *delta);
+			      const struct btrfs_squota_delta *delta);
 
 #endif
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2099b5f8c022..8159695ef69c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8066,7 +8066,7 @@ static void dedupe_in_progress_warn(const struct btrfs_root *root)
 		      btrfs_root_id(root), root->dedupe_in_progress);
 }
 
-long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
+long btrfs_ioctl_send(struct inode *inode, const struct btrfs_ioctl_send_args *arg)
 {
 	int ret = 0;
 	struct btrfs_root *send_root = BTRFS_I(inode)->root;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index dd1c9f02b011..8bd5aeafb6f5 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -182,6 +182,6 @@ enum {
 	__BTRFS_SEND_A_MAX		= 35,
 };
 
-long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg);
+long btrfs_ioctl_send(struct inode *inode, const struct btrfs_ioctl_send_args *arg);
 
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 70274a438049..549ad700e49e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -629,7 +629,7 @@ static void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
 }
 
-static bool check_ro_option(struct btrfs_fs_info *fs_info,
+static bool check_ro_option(const struct btrfs_fs_info *fs_info,
 			    unsigned long mount_opt, unsigned long opt,
 			    const char *opt_name)
 {
@@ -641,7 +641,7 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_opt,
 			 unsigned long flags)
 {
 	bool ret = true;
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index cbcab434b5ec..d2b8ebb46bc6 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -10,7 +10,7 @@
 struct super_block;
 struct btrfs_fs_info;
 
-bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_opt,
 			 unsigned long flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index b0aff297d67d..eae75bb572b9 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -13,7 +13,7 @@
 #include "accessors.h"
 #include "uuid-tree.h"
 
-static void btrfs_uuid_to_key(u8 *uuid, u8 type, struct btrfs_key *key)
+static void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key)
 {
 	key->type = type;
 	key->objectid = get_unaligned_le64(uuid);
@@ -21,7 +21,7 @@ static void btrfs_uuid_to_key(u8 *uuid, u8 type, struct btrfs_key *key)
 }
 
 /* return -ENOENT for !found, < 0 for errors, or 0 if an item was found */
-static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, u8 *uuid,
+static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
 				  u8 type, u64 subid)
 {
 	int ret;
@@ -81,7 +81,7 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, u8 *uuid,
 	return ret;
 }
 
-int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid_cpu)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -145,7 +145,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	return ret;
 }
 
-int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -256,7 +256,7 @@ static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
  * < 0	if an error occurred
  */
 static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
-				       u8 *uuid, u8 type, u64 subvolid)
+				       const u8 *uuid, u8 type, u64 subvolid)
 {
 	int ret = 0;
 	struct btrfs_root *subvol_root;
diff --git a/fs/btrfs/uuid-tree.h b/fs/btrfs/uuid-tree.h
index 080ede0227ae..a3f5757cc7cf 100644
--- a/fs/btrfs/uuid-tree.h
+++ b/fs/btrfs/uuid-tree.h
@@ -8,9 +8,9 @@
 struct btrfs_trans_handle;
 struct btrfs_fs_info;
 
-int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid);
-int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f11ceaeace37..5640038e9b61 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -722,7 +722,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	return -EINVAL;
 }
 
-u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
 {
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
 				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 66e6fc481ecd..37a09ebb34dd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -834,6 +834,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
-u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb);
+const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
 
 #endif
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 15d0999e340e..0288fe541dca 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -24,7 +24,7 @@
 #include "accessors.h"
 #include "dir-item.h"
 
-int btrfs_getxattr(struct inode *inode, const char *name,
+int btrfs_getxattr(const struct inode *inode, const char *name,
 				void *buffer, size_t size)
 {
 	struct btrfs_dir_item *di;
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index b9376ea258ff..8dc4cf49f6f0 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -14,7 +14,7 @@ struct btrfs_trans_handle;
 
 extern const struct xattr_handler * const btrfs_xattr_handlers[];
 
-int btrfs_getxattr(struct inode *inode, const char *name,
+int btrfs_getxattr(const struct inode *inode, const char *name,
 		void *buffer, size_t size);
 int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		   const char *name, const void *value, size_t size, int flags);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c8b5f51e94cc..59e4546caf84 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -767,7 +767,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount_opt)
+int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsigned long *mount_opt)
 {
 	if (!btrfs_is_zoned(info))
 		return 0;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index ff605beb84ef..d66d00c08001 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,7 +58,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
-int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount_opt);
+int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsigned long *mount_opt);
 int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -129,7 +129,7 @@ static inline int btrfs_check_zoned_mode(const struct btrfs_fs_info *fs_info)
 	return -EOPNOTSUPP;
 }
 
-static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
+static inline int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info,
 					      unsigned long *mount_opt)
 {
 	return 0;
-- 
2.45.0



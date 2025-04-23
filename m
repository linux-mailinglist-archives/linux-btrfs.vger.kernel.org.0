Return-Path: <linux-btrfs+bounces-13339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2794A995CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9872188F656
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD527F4DB;
	Wed, 23 Apr 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xh66SWJ0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xh66SWJ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC7EEAB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427260; cv=none; b=hj/bVWw1KedaoLEtGhSYNMywgcjA2NsVceonCl7NaqTxPqhAVjMLVmcjVVNqRQkWVeooPgTw9mirtuXUvYRMqKLO8v0y3GpRMneHZlyd2i5m7vgc0E4nvIpaBJN1KPV/j82gQPRWgfQJPKldrpWznbiThUT+kByjuqXnlS2+bjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427260; c=relaxed/simple;
	bh=NhdOiWZRgLDYVVssv0h8y1sC34FQO6loGsWzOg3tC3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqgE1YAsvHUq0FrUgoxwuVQYzYNprdU/XWREyg5r4BymkNSZPM7fSE+sslA9zgQDWNVicW9J6ctn+rwei7Cs3V4CGJBQgVNIS7FRPPU8TtwZ9qcdjXTLYgGjaDD06wjXBzUU5dpOSW5P2ss5V87dS7hQscScT6adGfN8Bfp4NFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xh66SWJ0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xh66SWJ0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40FAC1F449;
	Wed, 23 Apr 2025 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc0DvcpbYveZsnipba66VmH9Lb1Hdq3YWdTtBIsX8F8=;
	b=Xh66SWJ0L+62P1aKtghuB+08Bf9sOkGa7179Ta+hXVzplyHLBSkshBxIlZa8OVt6ja9k0f
	IT9DZfoKEuyOaiasKciKBtGvoSk4UK1E4oqGMxiFBNI8CeuSTyTxXq1p7Jui/E9B5bl0KF
	Pc/upUyBzC4xNE+bUamNR4YIM3TupdM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc0DvcpbYveZsnipba66VmH9Lb1Hdq3YWdTtBIsX8F8=;
	b=Xh66SWJ0L+62P1aKtghuB+08Bf9sOkGa7179Ta+hXVzplyHLBSkshBxIlZa8OVt6ja9k0f
	IT9DZfoKEuyOaiasKciKBtGvoSk4UK1E4oqGMxiFBNI8CeuSTyTxXq1p7Jui/E9B5bl0KF
	Pc/upUyBzC4xNE+bUamNR4YIM3TupdM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3993A13A3D;
	Wed, 23 Apr 2025 16:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NWcMDjcbCWhHGQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 16:54:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: trivial conversion to return bool instead of int
Date: Wed, 23 Apr 2025 18:53:57 +0200
Message-ID: <5ac4a1b26a0c22fd648ef8498674587a216c5371.1745426584.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745426584.git.dsterba@suse.com>
References: <cover.1745426584.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Old code has a lot of int for bool return values, bool is recommended
and done in new code. Convert the trivial cases that do simple 0/false
and 1/true. Functions comment are updated if needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c   |  12 ++---
 fs/btrfs/defrag.c        |   8 ++--
 fs/btrfs/delayed-inode.c |   8 ++--
 fs/btrfs/dev-replace.c   |   8 ++--
 fs/btrfs/dev-replace.h   |   2 +-
 fs/btrfs/extent-tree.c   |  10 ++--
 fs/btrfs/file.c          |  33 +++++++------
 fs/btrfs/inode.c         |  14 +++---
 fs/btrfs/ioctl.c         |  10 ++--
 fs/btrfs/locking.c       |   8 ++--
 fs/btrfs/locking.h       |   2 +-
 fs/btrfs/super.c         |   6 +--
 fs/btrfs/transaction.c   |   8 ++--
 fs/btrfs/volumes.c       | 100 ++++++++++++++++++---------------------
 14 files changed, 111 insertions(+), 118 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bdde09f74fe282..4dbcba817ee4d7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3873,14 +3873,14 @@ static void force_metadata_allocation(struct btrfs_fs_info *info)
 	}
 }
 
-static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
-			      const struct btrfs_space_info *sinfo, int force)
+static bool should_alloc_chunk(const struct btrfs_fs_info *fs_info,
+			       const struct btrfs_space_info *sinfo, int force)
 {
 	u64 bytes_used = btrfs_space_info_used(sinfo, false);
 	u64 thresh;
 
 	if (force == CHUNK_ALLOC_FORCE)
-		return 1;
+		return true;
 
 	/*
 	 * in limited mode, we want to have some free space up to
@@ -3891,12 +3891,12 @@ static int should_alloc_chunk(const struct btrfs_fs_info *fs_info,
 		thresh = max_t(u64, SZ_64M, mult_perc(thresh, 1));
 
 		if (sinfo->total_bytes - bytes_used < thresh)
-			return 1;
+			return true;
 	}
 
 	if (bytes_used + SZ_2M < mult_perc(sinfo->total_bytes, 80))
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 3741a56e21145f..a3b6d49950eba4 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -105,15 +105,15 @@ static int btrfs_insert_inode_defrag(struct btrfs_inode *inode,
 	return 0;
 }
 
-static inline int need_auto_defrag(struct btrfs_fs_info *fs_info)
+static inline bool need_auto_defrag(struct btrfs_fs_info *fs_info)
 {
 	if (!btrfs_test_opt(fs_info, AUTO_DEFRAG))
-		return 0;
+		return false;
 
 	if (btrfs_fs_closing(fs_info))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 4aa7e4dd34fa11..6ba1b60aba8875 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1384,17 +1384,17 @@ void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 	WARN_ON(btrfs_first_delayed_node(fs_info->delayed_root));
 }
 
-static int could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
+static bool could_end_wait(struct btrfs_delayed_root *delayed_root, int seq)
 {
 	int val = atomic_read(&delayed_root->items_seq);
 
 	if (val < seq || val >= seq + BTRFS_DELAYED_BATCH)
-		return 1;
+		return true;
 
 	if (atomic_read(&delayed_root->items) < BTRFS_DELAYED_BACKGROUND)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5c26f0fcf0d500..2decb9fff44519 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1265,16 +1265,16 @@ static int btrfs_dev_replace_kthread(void *data)
 	return 0;
 }
 
-int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
+bool __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
 {
 	if (!dev_replace->is_valid)
-		return 0;
+		return false;
 
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED:
-		return 0;
+		return false;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
 		/*
@@ -1289,7 +1289,7 @@ int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
 		 */
 		break;
 	}
-	return 1;
+	return true;
 }
 
 void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount)
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 23e480efe5e6e4..b35cecf388f295 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -25,7 +25,7 @@ void btrfs_dev_replace_status(struct btrfs_fs_info *fs_info,
 int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
 void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
 int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
-int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
+bool __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
 bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      struct btrfs_block_group *cache,
 				      u64 physical);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e0811a86d0cbdd..f27cd3b41104ef 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -409,15 +409,15 @@ static u64 hash_extent_data_ref_item(struct extent_buffer *leaf,
 				    btrfs_extent_data_ref_offset(leaf, ref));
 }
 
-static int match_extent_data_ref(struct extent_buffer *leaf,
-				 struct btrfs_extent_data_ref *ref,
-				 u64 root_objectid, u64 owner, u64 offset)
+static bool match_extent_data_ref(struct extent_buffer *leaf,
+				  struct btrfs_extent_data_ref *ref,
+				  u64 root_objectid, u64 owner, u64 offset)
 {
 	if (btrfs_extent_data_ref_root(leaf, ref) != root_objectid ||
 	    btrfs_extent_data_ref_objectid(leaf, ref) != owner ||
 	    btrfs_extent_data_ref_offset(leaf, ref) != offset)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1e164530d9dc2a..5898d17041e822 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -508,20 +508,19 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int extent_mergeable(struct extent_buffer *leaf, int slot,
-			    u64 objectid, u64 bytenr, u64 orig_offset,
-			    u64 *start, u64 *end)
+static bool extent_mergeable(struct extent_buffer *leaf, int slot, u64 objectid,
+			     u64 bytenr, u64 orig_offset, u64 *start, u64 *end)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 	u64 extent_end;
 
 	if (slot < 0 || slot >= btrfs_header_nritems(leaf))
-		return 0;
+		return false;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	if (key.objectid != objectid || key.type != BTRFS_EXTENT_DATA_KEY)
-		return 0;
+		return false;
 
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG ||
@@ -530,15 +529,15 @@ static int extent_mergeable(struct extent_buffer *leaf, int slot,
 	    btrfs_file_extent_compression(leaf, fi) ||
 	    btrfs_file_extent_encryption(leaf, fi) ||
 	    btrfs_file_extent_other_encoding(leaf, fi))
-		return 0;
+		return false;
 
 	extent_end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
 	if ((*start && *start != key.offset) || (*end && *end != extent_end))
-		return 0;
+		return false;
 
 	*start = key.offset;
 	*end = extent_end;
-	return 1;
+	return true;
 }
 
 /*
@@ -2004,33 +2003,33 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int hole_mergeable(struct btrfs_inode *inode, struct extent_buffer *leaf,
-			  int slot, u64 start, u64 end)
+static bool hole_mergeable(struct btrfs_inode *inode, struct extent_buffer *leaf,
+			   int slot, u64 start, u64 end)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 
 	if (slot < 0 || slot >= btrfs_header_nritems(leaf))
-		return 0;
+		return false;
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	if (key.objectid != btrfs_ino(inode) ||
 	    key.type != BTRFS_EXTENT_DATA_KEY)
-		return 0;
+		return false;
 
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
 	if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
-		return 0;
+		return false;
 
 	if (btrfs_file_extent_disk_bytenr(leaf, fi))
-		return 0;
+		return false;
 
 	if (key.offset == end)
-		return 1;
+		return true;
 	if (key.offset + btrfs_file_extent_num_bytes(leaf, fi) == start)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static int fill_holes(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9186729a00308f..e3bbe348ac91e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3726,9 +3726,9 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
  *
  * slot is the slot the inode is in, objectid is the objectid of the inode
  */
-static noinline int acls_after_inode_item(struct extent_buffer *leaf,
-					  int slot, u64 objectid,
-					  int *first_xattr_slot)
+static noinline bool acls_after_inode_item(struct extent_buffer *leaf,
+					   int slot, u64 objectid,
+					   int *first_xattr_slot)
 {
 	u32 nritems = btrfs_header_nritems(leaf);
 	struct btrfs_key found_key;
@@ -3750,7 +3750,7 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 
 		/* we found a different objectid, there must not be acls */
 		if (found_key.objectid != objectid)
-			return 0;
+			return false;
 
 		/* we found an xattr, assume we've got an acl */
 		if (found_key.type == BTRFS_XATTR_ITEM_KEY) {
@@ -3758,7 +3758,7 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 				*first_xattr_slot = slot;
 			if (found_key.offset == xattr_access ||
 			    found_key.offset == xattr_default)
-				return 1;
+				return true;
 		}
 
 		/*
@@ -3766,7 +3766,7 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 		 * be any acls later on
 		 */
 		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
-			return 0;
+			return false;
 
 		slot++;
 		scanned++;
@@ -3786,7 +3786,7 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 	 */
 	if (*first_xattr_slot == -1)
 		*first_xattr_slot = slot;
-	return 1;
+	return true;
 }
 
 static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 68fac77fb95d1d..6bfb0a8c40af53 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1446,8 +1446,8 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	return ret;
 }
 
-static noinline int key_in_sk(const struct btrfs_key *key,
-			      const struct btrfs_ioctl_search_key *sk)
+static noinline bool key_in_sk(const struct btrfs_key *key,
+			       const struct btrfs_ioctl_search_key *sk)
 {
 	struct btrfs_key test;
 	int ret;
@@ -1458,7 +1458,7 @@ static noinline int key_in_sk(const struct btrfs_key *key,
 
 	ret = btrfs_comp_cpu_keys(key, &test);
 	if (ret < 0)
-		return 0;
+		return false;
 
 	test.objectid = sk->max_objectid;
 	test.type = sk->max_type;
@@ -1466,8 +1466,8 @@ static noinline int key_in_sk(const struct btrfs_key *key,
 
 	ret = btrfs_comp_cpu_keys(key, &test);
 	if (ret > 0)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 static noinline int copy_to_sk(struct btrfs_path *path,
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 81e62b652e2104..a3e6d9616e60bf 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -149,15 +149,15 @@ void btrfs_tree_read_lock_nested(struct extent_buffer *eb, enum btrfs_lock_nesti
 /*
  * Try-lock for read.
  *
- * Return 1 if the rwlock has been taken, 0 otherwise
+ * Return true if the rwlock has been taken, false otherwise
  */
-int btrfs_try_tree_read_lock(struct extent_buffer *eb)
+bool btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
 	if (down_read_trylock(&eb->lock)) {
 		trace_btrfs_try_tree_read_lock(eb);
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index c69e57ff804bcf..af29df98ac1454 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -189,7 +189,7 @@ static inline void btrfs_tree_read_lock(struct extent_buffer *eb)
 }
 
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
-int btrfs_try_tree_read_lock(struct extent_buffer *eb);
+bool btrfs_try_tree_read_lock(struct extent_buffer *eb);
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eb92465536f36d..ed9173d5eefbe4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1148,11 +1148,11 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 /*
  * subvolumes are identified by ino 256
  */
-static inline int is_subvolume_inode(struct inode *inode)
+static inline bool is_subvolume_inode(struct inode *inode)
 {
 	if (inode && inode->i_ino == BTRFS_FIRST_FREE_OBJECTID)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2a8e0ce859edb2..7f6ea4abcdd7b6 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -538,15 +538,15 @@ static void wait_current_trans(struct btrfs_fs_info *fs_info)
 	}
 }
 
-static int may_wait_transaction(struct btrfs_fs_info *fs_info, int type)
+static bool may_wait_transaction(struct btrfs_fs_info *fs_info, int type)
 {
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
-		return 0;
+		return false;
 
 	if (type == TRANS_START)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static inline bool need_reserve_reloc_root(struct btrfs_root *root)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 81bccab5376a5d..c120f82dccdf59 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3896,26 +3896,25 @@ static void reset_balance_state(struct btrfs_fs_info *fs_info)
  * Balance filters.  Return 1 if chunk should be filtered out
  * (should not be balanced).
  */
-static int chunk_profiles_filter(u64 chunk_type,
-				 struct btrfs_balance_args *bargs)
+static bool chunk_profiles_filter(u64 chunk_type, struct btrfs_balance_args *bargs)
 {
 	chunk_type = chunk_to_extended(chunk_type) &
 				BTRFS_EXTENDED_PROFILE_MASK;
 
 	if (bargs->profiles & chunk_type)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
-			      struct btrfs_balance_args *bargs)
+static bool chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
+				     struct btrfs_balance_args *bargs)
 {
 	struct btrfs_block_group *cache;
 	u64 chunk_used;
 	u64 user_thresh_min;
 	u64 user_thresh_max;
-	int ret = 1;
+	bool ret = true;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
 	chunk_used = cache->used;
@@ -3933,18 +3932,18 @@ static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_off
 		user_thresh_max = mult_perc(cache->length, bargs->usage_max);
 
 	if (user_thresh_min <= chunk_used && chunk_used < user_thresh_max)
-		ret = 0;
+		ret = false;
 
 	btrfs_put_block_group(cache);
 	return ret;
 }
 
-static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
-		u64 chunk_offset, struct btrfs_balance_args *bargs)
+static bool chunk_usage_filter(struct btrfs_fs_info *fs_info, u64 chunk_offset,
+			       struct btrfs_balance_args *bargs)
 {
 	struct btrfs_block_group *cache;
 	u64 chunk_used, user_thresh;
-	int ret = 1;
+	bool ret = true;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
 	chunk_used = cache->used;
@@ -3957,15 +3956,14 @@ static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
 		user_thresh = mult_perc(cache->length, bargs->usage);
 
 	if (chunk_used < user_thresh)
-		ret = 0;
+		ret = false;
 
 	btrfs_put_block_group(cache);
 	return ret;
 }
 
-static int chunk_devid_filter(struct extent_buffer *leaf,
-			      struct btrfs_chunk *chunk,
-			      struct btrfs_balance_args *bargs)
+static bool chunk_devid_filter(struct extent_buffer *leaf, struct btrfs_chunk *chunk,
+			       struct btrfs_balance_args *bargs)
 {
 	struct btrfs_stripe *stripe;
 	int num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
@@ -3974,10 +3972,10 @@ static int chunk_devid_filter(struct extent_buffer *leaf,
 	for (i = 0; i < num_stripes; i++) {
 		stripe = btrfs_stripe_nr(chunk, i);
 		if (btrfs_stripe_devid(leaf, stripe) == bargs->devid)
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static u64 calc_data_stripes(u64 type, int num_stripes)
@@ -3990,9 +3988,8 @@ static u64 calc_data_stripes(u64 type, int num_stripes)
 }
 
 /* [pstart, pend) */
-static int chunk_drange_filter(struct extent_buffer *leaf,
-			       struct btrfs_chunk *chunk,
-			       struct btrfs_balance_args *bargs)
+static bool chunk_drange_filter(struct extent_buffer *leaf, struct btrfs_chunk *chunk,
+				struct btrfs_balance_args *bargs)
 {
 	struct btrfs_stripe *stripe;
 	int num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
@@ -4003,7 +4000,7 @@ static int chunk_drange_filter(struct extent_buffer *leaf,
 	int i;
 
 	if (!(bargs->flags & BTRFS_BALANCE_ARGS_DEVID))
-		return 0;
+		return false;
 
 	type = btrfs_chunk_type(leaf, chunk);
 	factor = calc_data_stripes(type, num_stripes);
@@ -4019,56 +4016,53 @@ static int chunk_drange_filter(struct extent_buffer *leaf,
 
 		if (stripe_offset < bargs->pend &&
 		    stripe_offset + stripe_length > bargs->pstart)
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* [vstart, vend) */
-static int chunk_vrange_filter(struct extent_buffer *leaf,
-			       struct btrfs_chunk *chunk,
-			       u64 chunk_offset,
-			       struct btrfs_balance_args *bargs)
+static bool chunk_vrange_filter(struct extent_buffer *leaf, struct btrfs_chunk *chunk,
+				u64 chunk_offset, struct btrfs_balance_args *bargs)
 {
 	if (chunk_offset < bargs->vend &&
 	    chunk_offset + btrfs_chunk_length(leaf, chunk) > bargs->vstart)
 		/* at least part of the chunk is inside this vrange */
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int chunk_stripes_range_filter(struct extent_buffer *leaf,
-			       struct btrfs_chunk *chunk,
-			       struct btrfs_balance_args *bargs)
+static bool chunk_stripes_range_filter(struct extent_buffer *leaf,
+				       struct btrfs_chunk *chunk,
+				       struct btrfs_balance_args *bargs)
 {
 	int num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 
 	if (bargs->stripes_min <= num_stripes
 			&& num_stripes <= bargs->stripes_max)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int chunk_soft_convert_filter(u64 chunk_type,
-				     struct btrfs_balance_args *bargs)
+static bool chunk_soft_convert_filter(u64 chunk_type, struct btrfs_balance_args *bargs)
 {
 	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
-		return 0;
+		return false;
 
 	chunk_type = chunk_to_extended(chunk_type) &
 				BTRFS_EXTENDED_PROFILE_MASK;
 
 	if (bargs->target == chunk_type)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
-static int should_balance_chunk(struct extent_buffer *leaf,
-				struct btrfs_chunk *chunk, u64 chunk_offset)
+static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk *chunk,
+				 u64 chunk_offset)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
@@ -4078,7 +4072,7 @@ static int should_balance_chunk(struct extent_buffer *leaf,
 	/* type filter */
 	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
 	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
-		return 0;
+		return false;
 	}
 
 	if (chunk_type & BTRFS_BLOCK_GROUP_DATA)
@@ -4091,46 +4085,46 @@ static int should_balance_chunk(struct extent_buffer *leaf,
 	/* profiles filter */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_PROFILES) &&
 	    chunk_profiles_filter(chunk_type, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/* usage filter */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_USAGE) &&
 	    chunk_usage_filter(fs_info, chunk_offset, bargs)) {
-		return 0;
+		return false;
 	} else if ((bargs->flags & BTRFS_BALANCE_ARGS_USAGE_RANGE) &&
 	    chunk_usage_range_filter(fs_info, chunk_offset, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/* devid filter */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_DEVID) &&
 	    chunk_devid_filter(leaf, chunk, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/* drange filter, makes sense only with devid filter */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_DRANGE) &&
 	    chunk_drange_filter(leaf, chunk, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/* vrange filter */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_VRANGE) &&
 	    chunk_vrange_filter(leaf, chunk, chunk_offset, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/* stripes filter */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_STRIPES_RANGE) &&
 	    chunk_stripes_range_filter(leaf, chunk, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/* soft profile changing mode */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_SOFT) &&
 	    chunk_soft_convert_filter(chunk_type, bargs)) {
-		return 0;
+		return false;
 	}
 
 	/*
@@ -4138,7 +4132,7 @@ static int should_balance_chunk(struct extent_buffer *leaf,
 	 */
 	if ((bargs->flags & BTRFS_BALANCE_ARGS_LIMIT)) {
 		if (bargs->limit == 0)
-			return 0;
+			return false;
 		else
 			bargs->limit--;
 	} else if ((bargs->flags & BTRFS_BALANCE_ARGS_LIMIT_RANGE)) {
@@ -4148,12 +4142,12 @@ static int should_balance_chunk(struct extent_buffer *leaf,
 		 * about the count of all chunks that satisfy the filters.
 		 */
 		if (bargs->limit_max == 0)
-			return 0;
+			return false;
 		else
 			bargs->limit_max--;
 	}
 
-	return 1;
+	return true;
 }
 
 static int __btrfs_balance(struct btrfs_fs_info *fs_info)
-- 
2.49.0



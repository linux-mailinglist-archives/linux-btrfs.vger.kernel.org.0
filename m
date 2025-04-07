Return-Path: <linux-btrfs+bounces-12852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B665A7E8C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDABE1899C34
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805D253F1B;
	Mon,  7 Apr 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4T0jyNr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63276253F09
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047401; cv=none; b=AU9DJB29s2vvBhAPHMjnaVnGiy3cYqnpWl47TCPX4ZcUDCU2kUJ8NvYPDNg4s4fWu9zaptAa4LvDjNoOG8eAaKN90Y+Dk5nagzrjgqBGkYai1boNhVW4GKQmYqqCnvsk2AP0SKMK+7CoJRJ/RZnNpWaexwo2dG72NRsYlZCQCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047401; c=relaxed/simple;
	bh=EadZquzAjxLMMPuFr9X87E16TGxo7X21CBee1bUIzag=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XgRUH0mSRFinohoPcxRRMtt7OheVzWnt/IyE1Feec95HJX4SK6OkyqheLb2M2Ly7Oo+6emWwp6meO/itKSQ7lCOh7ryFuNxR22l4PyLzOSJbp7WL5N0CY0u4CtTzX8d3Jj6W2gC9PIerXQHwta0vNR2ZMSRNLavA50d9DZQwYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4T0jyNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA07C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047401;
	bh=EadZquzAjxLMMPuFr9X87E16TGxo7X21CBee1bUIzag=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W4T0jyNrTTTrP7kKnTcX/GKj53BQNDmVr+T/yoBZsu2VzUZtkI2TH9rqJUaAaylqW
	 sBcG2rhP4WObMZ+nuXOeyYfVl7JB6Add1lJGObgL4UJVXVsfKnLwQiSlPzeYQSM4MO
	 cSgwUxpo8sfEH0tRfyevicpb+B0LCNuNlfOYEYRg+9ksbF5elqdxm8o92ZHeMLRiaM
	 ljeloRNyvFg+d/YyEzG/25OUk/9cOqEJyxjasQXtWNXbDKU+wWAf+3WwsVkDXe99EL
	 LsRjJfd1g5hsLg6xRDaOfA9OxVlbNc9y33FS6pMUFYgusd2Z31ujHT329fbtDXpRef
	 6frUGX6gL/WGw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs: rename remaining exported functions from extent-io-tree.h
Date: Mon,  7 Apr 2025 18:36:21 +0100
Message-Id: <54b59f589b98a94c90ea6bc61d3975567fc57b0f.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Rename the remaning exported functions that don't have a 'btrfs_' prefix.
By convention exported functions should have such prefix to make it clear
they are btrfs specific and to avoid collisions with functions from
elsewhere in the kernel.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 18 +++++++++---------
 fs/btrfs/extent-io-tree.h | 18 +++++++++---------
 fs/btrfs/qgroup.c         | 26 ++++++++++++++------------
 fs/btrfs/super.c          |  4 ++--
 fs/btrfs/transaction.c    |  6 +++---
 5 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6317004f36c4..503bb387e7a2 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1280,9 +1280,9 @@ int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
  *
  * All allocations are done with GFP_NOFS.
  */
-int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, u32 clear_bits,
-		       struct extent_state **cached_state)
+int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			     u32 bits, u32 clear_bits,
+			     struct extent_state **cached_state)
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
@@ -1805,8 +1805,8 @@ bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 b
 }
 
 /* Wrappers around set/clear extent bit */
-int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   u32 bits, struct extent_changeset *changeset)
+int btrfs_set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+				 u32 bits, struct extent_changeset *changeset)
 {
 	/*
 	 * We don't support EXTENT_LOCK_BITS yet, as current changeset will
@@ -1818,8 +1818,8 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL, changeset);
 }
 
-int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			     u32 bits, struct extent_changeset *changeset)
+int btrfs_clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+				   u32 bits, struct extent_changeset *changeset)
 {
 	/*
 	 * Don't support EXTENT_LOCK_BITS case, same reason as
@@ -1873,13 +1873,13 @@ int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32
 	return err;
 }
 
-void __cold extent_state_free_cachep(void)
+void __cold btrfs_extent_state_free_cachep(void)
 {
 	btrfs_extent_state_leak_debug_check();
 	kmem_cache_destroy(extent_state_cache);
 }
 
-int __init extent_state_init_cachep(void)
+int __init btrfs_extent_state_init_cachep(void)
 {
 	extent_state_cache = kmem_cache_create("btrfs_extent_state",
 					       sizeof(struct extent_state), 0, 0,
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 238732b23e93..625f4cd3debd 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -157,8 +157,8 @@ static inline bool btrfs_try_lock_extent(struct extent_io_tree *tree, u64 start,
 	return btrfs_try_lock_extent_bits(tree, start, end, EXTENT_LOCKED, cached);
 }
 
-int __init extent_state_init_cachep(void);
-void __cold extent_state_free_cachep(void);
+int __init btrfs_extent_state_init_cachep(void);
+void __cold btrfs_extent_state_free_cachep(void);
 
 u64 btrfs_count_range_bits(struct extent_io_tree *tree,
 			   u64 *start, u64 search_end,
@@ -171,8 +171,8 @@ bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 b
 bool btrfs_test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
 void btrfs_get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits,
 			  struct extent_state **cached_state);
-int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			     u32 bits, struct extent_changeset *changeset);
+int btrfs_clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+				   u32 bits, struct extent_changeset *changeset);
 int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64 end,
 				     u32 bits, struct extent_state **cached,
 				     struct extent_changeset *changeset);
@@ -197,8 +197,8 @@ static inline int btrfs_clear_extent_bits(struct extent_io_tree *tree, u64 start
 	return btrfs_clear_extent_bit(tree, start, end, bits, NULL);
 }
 
-int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   u32 bits, struct extent_changeset *changeset);
+int btrfs_set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+				 u32 bits, struct extent_changeset *changeset);
 int btrfs_set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			 u32 bits, struct extent_state **cached_state);
 
@@ -210,9 +210,9 @@ static inline int btrfs_clear_extent_dirty(struct extent_io_tree *tree, u64 star
 				      EXTENT_DO_ACCOUNTING, cached);
 }
 
-int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, u32 clear_bits,
-		       struct extent_state **cached_state);
+int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			     u32 bits, u32 clear_bits,
+			     struct extent_state **cached_state);
 
 bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, u32 bits,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a982fd64b814..34d1920a51e2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4232,8 +4232,9 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
 	reserved = *reserved_ret;
 	/* Record already reserved space */
 	orig_reserved = reserved->bytes_changed;
-	ret = set_record_extent_bits(&inode->io_tree, start,
-			start + len -1, EXTENT_QGROUP_RESERVED, reserved);
+	ret = btrfs_set_record_extent_bits(&inode->io_tree, start,
+					   start + len - 1, EXTENT_QGROUP_RESERVED,
+					   reserved);
 
 	/* Newly reserved space */
 	to_reserve = reserved->bytes_changed - orig_reserved;
@@ -4326,9 +4327,10 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 		 * EXTENT_QGROUP_RESERVED, we won't double free.
 		 * So not need to rush.
 		 */
-		ret = clear_record_extent_bits(&inode->io_tree, free_start,
-				free_start + free_len - 1,
-				EXTENT_QGROUP_RESERVED, &changeset);
+		ret = btrfs_clear_record_extent_bits(&inode->io_tree, free_start,
+						     free_start + free_len - 1,
+						     EXTENT_QGROUP_RESERVED,
+						     &changeset);
 		if (ret < 0)
 			goto out;
 		freed += changeset.bytes_changed;
@@ -4352,9 +4354,9 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	int ret;
 
 	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
-		return clear_record_extent_bits(&inode->io_tree, start,
-						start + len - 1,
-						EXTENT_QGROUP_RESERVED, NULL);
+		return btrfs_clear_record_extent_bits(&inode->io_tree, start,
+						      start + len - 1,
+						      EXTENT_QGROUP_RESERVED, NULL);
 	}
 
 	/* In release case, we shouldn't have @reserved */
@@ -4362,8 +4364,8 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	if (free && reserved)
 		return qgroup_free_reserved_data(inode, reserved, start, len, released);
 	extent_changeset_init(&changeset);
-	ret = clear_record_extent_bits(&inode->io_tree, start, start + len -1,
-				       EXTENT_QGROUP_RESERVED, &changeset);
+	ret = btrfs_clear_record_extent_bits(&inode->io_tree, start, start + len - 1,
+					     EXTENT_QGROUP_RESERVED, &changeset);
 	if (ret < 0)
 		goto out;
 
@@ -4611,8 +4613,8 @@ void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode)
 	int ret;
 
 	extent_changeset_init(&changeset);
-	ret = clear_record_extent_bits(&inode->io_tree, 0, (u64)-1,
-			EXTENT_QGROUP_RESERVED, &changeset);
+	ret = btrfs_clear_record_extent_bits(&inode->io_tree, 0, (u64)-1,
+					     EXTENT_QGROUP_RESERVED, &changeset);
 
 	WARN_ON(ret < 0);
 	if (WARN_ON(changeset.bytes_changed)) {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7121d8c7a318..344cc0812ef7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2525,8 +2525,8 @@ static const struct init_sequence mod_init_seq[] = {
 		.init_func = btrfs_free_space_init,
 		.exit_func = btrfs_free_space_exit,
 	}, {
-		.init_func = extent_state_init_cachep,
-		.exit_func = extent_state_free_cachep,
+		.init_func = btrfs_extent_state_init_cachep,
+		.exit_func = btrfs_extent_state_free_cachep,
 	}, {
 		.init_func = extent_buffer_init_cachep,
 		.exit_func = extent_buffer_free_cachep,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ad6a7a25b9d9..39e48bf610a1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1132,9 +1132,9 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 					   mark, &cached_state)) {
 		bool wait_writeback = false;
 
-		ret = convert_extent_bit(dirty_pages, start, end,
-					 EXTENT_NEED_WAIT,
-					 mark, &cached_state);
+		ret = btrfs_convert_extent_bit(dirty_pages, start, end,
+					       EXTENT_NEED_WAIT,
+					       mark, &cached_state);
 		/*
 		 * convert_extent_bit can return -ENOMEM, which is most of the
 		 * time a temporary error. So when it happens, ignore the error
-- 
2.45.2



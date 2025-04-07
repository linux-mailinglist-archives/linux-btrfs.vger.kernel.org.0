Return-Path: <linux-btrfs+bounces-12842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB78A7E8B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469721899594
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900722FE18;
	Mon,  7 Apr 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV2D+ehd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED422B8A2
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047391; cv=none; b=t2ZWW0F5mPrAoaDvrpE2RJXfXd3ITJuIR7lOWJIQ9T+P96+iiDJtRKyBCQka8ZEkH6G4G+tdsXRQj6346/YObhFk6NXASnkL0ics2wzLRliHmT6l1iiTRB7cU0LSwAZ7rEfA+6BluNvgq+o3gngOoMNJV0BWyxz/t3ynr/0c68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047391; c=relaxed/simple;
	bh=DJeXqnbUavYvENf5Me7xQzvd+RjVOFVQljj0Ce9YWy0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxKyJuTaltqDbSUuATiW0BU4VfpABYbNkyPDLS5cZPE5d1dVq8O1jbzeuVjYMAsIHCYCh+gITl0Ws/lHvx3My63IZ+qe5Pl/NVdd+GmYDGe3lGBkl1/xO9WqN+AdgQjtjhcE/oXXbWZEdhqwIw4saXkDMTh1X35Quo0dJmcb1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV2D+ehd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429BAC4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047390;
	bh=DJeXqnbUavYvENf5Me7xQzvd+RjVOFVQljj0Ce9YWy0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jV2D+ehdd6zQF7CVZDnolIsrOutlpefdKYjkAlF91fbtDcZOj4rUarFNWw81aVZhd
	 3aCP7k8xAnh8xyArQ7WXJYVJXymWQ/wOzSih61Dfcda0measIGooRZrS6EAVAHsBKc
	 gakZ+2LT07GCu/JC9N80P/tzNXjwvWqnkQ19telVNk/ZMbWuP5mQFWgvNGhSWWWmqp
	 kfTZbsvUnk/tXhcSBdSfuqU1T+L3soqpznxmlYQ94rUCtcu+FWW+wkSFCwEj92Ryhy
	 pcDTsX7W2QHyB8VrwnaMj/cQgwpAPCjXCAXHhxIXrdcU2x8M+bwEB2J3AnL4DZHYIN
	 v5jBhhg0IaVjA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: add btrfs prefix to dio lock and unlock extent functions
Date: Mon,  7 Apr 2025 18:36:11 +0100
Message-Id: <7af33be3a6c579b6b0f9d44d9c708ab16259cc6a.1744046765.git.fdmanana@suse.com>
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

These functions are exported so they should have a 'btrfs_' prefix by
convention, to make it clear they are btrfs specific and to avoid
collisions with functions from elsewhere in the kernel. So add a prefix to
their name.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/direct-io.c      | 22 +++++++++++-----------
 fs/btrfs/extent-io-tree.h | 12 ++++++------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index f87b5eac6323..4a0abf0751b4 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -42,10 +42,10 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 	/* Direct lock must be taken before the extent lock. */
 	if (nowait) {
-		if (!try_lock_dio_extent(io_tree, lockstart, lockend, cached_state))
+		if (!btrfs_try_lock_dio_extent(io_tree, lockstart, lockend, cached_state))
 			return -EAGAIN;
 	} else {
-		lock_dio_extent(io_tree, lockstart, lockend, cached_state);
+		btrfs_lock_dio_extent(io_tree, lockstart, lockend, cached_state);
 	}
 
 	while (1) {
@@ -131,7 +131,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 	}
 
 	if (ret)
-		unlock_dio_extent(io_tree, lockstart, lockend, cached_state);
+		btrfs_unlock_dio_extent(io_tree, lockstart, lockend, cached_state);
 	return ret;
 }
 
@@ -580,8 +580,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 
 	/* We didn't use everything, unlock the dio extent for the remainder. */
 	if (!write && (start + len) < lockend)
-		unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len,
-				  lockend, NULL);
+		btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len,
+					lockend, NULL);
 
 	return 0;
 
@@ -615,8 +615,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (!write && (iomap->type == IOMAP_HOLE)) {
 		/* If reading from a hole, unlock and return */
-		unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
-				  pos + length - 1, NULL);
+		btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
+					pos + length - 1, NULL);
 		return 0;
 	}
 
@@ -627,8 +627,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
 						    pos, length, false);
 		else
-			unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
-					  pos + length - 1, NULL);
+			btrfs_unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
+						pos + length - 1, NULL);
 		ret = -ENOTBLK;
 	}
 	if (write) {
@@ -660,8 +660,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 					    dip->file_offset, dip->bytes,
 					    !bio->bi_status);
 	} else {
-		unlock_dio_extent(&inode->io_tree, dip->file_offset,
-				  dip->file_offset + dip->bytes - 1, NULL);
+		btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
+					dip->file_offset + dip->bytes - 1, NULL);
 	}
 
 	bbio->bio.bi_private = bbio->private;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 86436ed37ad6..83e9c2e0134b 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -223,20 +223,20 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
-static inline int lock_dio_extent(struct extent_io_tree *tree, u64 start,
-				  u64 end, struct extent_state **cached)
+static inline int btrfs_lock_dio_extent(struct extent_io_tree *tree, u64 start,
+					u64 end, struct extent_state **cached)
 {
 	return __lock_extent(tree, start, end, EXTENT_DIO_LOCKED, cached);
 }
 
-static inline bool try_lock_dio_extent(struct extent_io_tree *tree, u64 start,
-				       u64 end, struct extent_state **cached)
+static inline bool btrfs_try_lock_dio_extent(struct extent_io_tree *tree, u64 start,
+					     u64 end, struct extent_state **cached)
 {
 	return __try_lock_extent(tree, start, end, EXTENT_DIO_LOCKED, cached);
 }
 
-static inline int unlock_dio_extent(struct extent_io_tree *tree, u64 start,
-				    u64 end, struct extent_state **cached)
+static inline int btrfs_unlock_dio_extent(struct extent_io_tree *tree, u64 start,
+					  u64 end, struct extent_state **cached)
 {
 	return __clear_extent_bit(tree, start, end, EXTENT_DIO_LOCKED, cached, NULL);
 }
-- 
2.45.2



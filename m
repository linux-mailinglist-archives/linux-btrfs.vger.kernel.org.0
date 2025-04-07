Return-Path: <linux-btrfs+bounces-12843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63125A7E8BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14815189E944
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B9238D34;
	Mon,  7 Apr 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKsobySU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB122A4D6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047392; cv=none; b=ociOeWfJJtxVS1y3a+QCVxGsLlDCzOyiucvVq9KZV5PQh8JPR3Zv5kRn5YinETUFIGWtwC6uh/KZFfLm/Vi3xEa7cLMyxvddOyXdJiahg1bsX+emxzllHEKeqMODHVo+wODfY6aYdZl05wyiL877hnszVblosNC1YdMosfTldgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047392; c=relaxed/simple;
	bh=/QTFb8zfVpv7zkGJfiVLxcFX+Uwg+VsZWwmy9X2v2mY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0IHcRt06iOajgbAaHR+gz3dmu7IAN9qPfQa3AduZfoEdwV1GgzaPQSZkHDOHVrqZglFQUuP7gv4FuzXpliAgnV6KfodYZi0MFl41d59M9AhuI1nUXX8JvoCNrSlbqv+KJEr29XLhYERfS6QWE0X1KAJRXLv0js/QzR9Z4zslM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKsobySU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD07C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047391;
	bh=/QTFb8zfVpv7zkGJfiVLxcFX+Uwg+VsZWwmy9X2v2mY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LKsobySUcWcsZ5NyYr2m6phLyAVZP6AlWRF+uu24jEURr4TuysoOAsZI+VYoFucZp
	 TFZFlk1AjdFIyEaRRH18eZl/sDcvlTgcha4m+dwPqmkW7xl+/UR/hJLIafpTFAeOms
	 U+WphCBVGOLQu81/ua5beDt0zDyAxH020qsyplwpHNKkGF6IZ0c0TVAa2OhzqiYu74
	 SuDo2ZYpVU2HT/tLosOfUd68OjYGaIkC2Su5VK73eZDRD3V4ZHBFEknvXw/SN1jd+a
	 p9DwOrwHfmpj/6G6N+IZeAw8uM2/SNXg+rccjM+nDN3+rmcRgoPURN3ZLXo9KW6FNK
	 qipDAWTljZoZQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/16] btrfs: rename __lock_extent() and __try_lock_extent()
Date: Mon,  7 Apr 2025 18:36:12 +0100
Message-Id: <53fd493a2aec8643ec3ac8ad506c541627e8193e.1744046765.git.fdmanana@suse.com>
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
collisions with functions from elsewhere in the kernel. Their double
underscore prefix is also discouraged.

So remove their double underscore prefix, add a 'btrfs_' prefix to their
name to make it clear they are from btrfs and a '_bits' suffix to avoid
collision with btrfs_lock_extent() and btrfs_try_lock_extent().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c |  8 ++++----
 fs/btrfs/extent-io-tree.h | 16 ++++++++--------
 fs/btrfs/inode.c          |  6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 59448d3028d3..dad092a1f81c 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1831,8 +1831,8 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	return __clear_extent_bit(tree, start, end, bits, NULL, changeset);
 }
 
-bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		       struct extent_state **cached)
+bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+				u32 bits, struct extent_state **cached)
 {
 	int err;
 	u64 failed_start;
@@ -1851,8 +1851,8 @@ bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits
  * Either insert or lock state struct between start and end use mask to tell
  * us if waiting is desired.
  */
-int __lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		  struct extent_state **cached_state)
+int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+			   struct extent_state **cached_state)
 {
 	struct extent_state *failed_state = NULL;
 	int err;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 83e9c2e0134b..518caf666bb0 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -140,21 +140,21 @@ const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tre
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner);
 void extent_io_tree_release(struct extent_io_tree *tree);
-int __lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		  struct extent_state **cached);
-bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		       struct extent_state **cached);
+int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+			   struct extent_state **cached);
+bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+				u32 bits, struct extent_state **cached);
 
 static inline int btrfs_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				    struct extent_state **cached)
 {
-	return __lock_extent(tree, start, end, EXTENT_LOCKED, cached);
+	return btrfs_lock_extent_bits(tree, start, end, EXTENT_LOCKED, cached);
 }
 
 static inline bool btrfs_try_lock_extent(struct extent_io_tree *tree, u64 start,
 					 u64 end, struct extent_state **cached)
 {
-	return __try_lock_extent(tree, start, end, EXTENT_LOCKED, cached);
+	return btrfs_try_lock_extent_bits(tree, start, end, EXTENT_LOCKED, cached);
 }
 
 int __init extent_state_init_cachep(void);
@@ -226,13 +226,13 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 static inline int btrfs_lock_dio_extent(struct extent_io_tree *tree, u64 start,
 					u64 end, struct extent_state **cached)
 {
-	return __lock_extent(tree, start, end, EXTENT_DIO_LOCKED, cached);
+	return btrfs_lock_extent_bits(tree, start, end, EXTENT_DIO_LOCKED, cached);
 }
 
 static inline bool btrfs_try_lock_dio_extent(struct extent_io_tree *tree, u64 start,
 					     u64 end, struct extent_state **cached)
 {
-	return __try_lock_extent(tree, start, end, EXTENT_DIO_LOCKED, cached);
+	return btrfs_try_lock_extent_bits(tree, start, end, EXTENT_DIO_LOCKED, cached);
 }
 
 static inline int btrfs_unlock_dio_extent(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b3194cdb8ec2..462b92c33930 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3128,9 +3128,9 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	 */
 	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		clear_bits |= EXTENT_LOCKED | EXTENT_FINISHING_ORDERED;
-		__lock_extent(io_tree, start, end,
-			      EXTENT_LOCKED | EXTENT_FINISHING_ORDERED,
-			      &cached_state);
+		btrfs_lock_extent_bits(io_tree, start, end,
+				       EXTENT_LOCKED | EXTENT_FINISHING_ORDERED,
+				       &cached_state);
 	}
 
 	if (freespace_inode)
-- 
2.45.2



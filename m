Return-Path: <linux-btrfs+bounces-13802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F000DAAE7BD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CCF1C2832F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B728CF5D;
	Wed,  7 May 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq5DgZF8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2228C850
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638605; cv=none; b=j8pL0ulYTFd8kK8pIgjasPUTKNrQZA7NfhHtWsiDCE1owJu8zTNjXO3spoe0DnHLxSw/dLoiB+3bZpwrgb8gZVAGU7rq+Ky3wks3dAtra1kF/yK/pYz4LVFabpCu4NIpB+XAz72P8JBce0XARb2cD/GCmJ/rpRzx5YxN8wrVJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638605; c=relaxed/simple;
	bh=sdEPSUINMbqs3GjL/oTAF3Rtofa+97mG+lkDwKJwCAo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFrtMASm0E2AQUD44pvB8tAMHyNmzjP/Iy9XPSC9zptTscW0VTq4eoYSlPyIntRL3d9K5HrM18XraGuE6KSELhCDzYCFWMdv1lx9h76iEGlsZ+m6Rg7684WyNDOkZ27QOGMsmONkIG0XDDRFizQxQ+Q83Pp9wpcHTudN32H1mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq5DgZF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E44C4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746638605;
	bh=sdEPSUINMbqs3GjL/oTAF3Rtofa+97mG+lkDwKJwCAo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rq5DgZF8areYg7P9X8KpuacIxRZjz1GNIPuykRLUWoBCJd66FIFw8x7L19Z0ZWw1q
	 5gMgC66anGxskZAKQU5RATlKFXHOnoQmrCxHsyMxOLg+w3ZzQkWlI02qOBQQtd+FYa
	 QI6tMg39PL39TLGFAUQ4aCARF7REwcrZLM7NoEOIGGn8zGyZQsj0TElAgKynSG5tDP
	 LbvgMxcYfTr8MQEEnB69NIcA79vwwa9OqrrKZ/355QNFVJDbwgFAqH+/jm/QwkTrWg
	 bZdph7eJQgHY/273xkc2+PKKU34Ox5HWXCq9tdSxGbr0d/VnbcG65WFkqBfHiEY8Dp
	 VXj2s3znsnD5g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: use boolean for delalloc argument to btrfs_free_reserved_bytes()
Date: Wed,  7 May 2025 18:23:16 +0100
Message-Id: <0544ef5a4c02da3c4acb5b38b527883e94b4d261.1746638347.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746638347.git.fdmanana@suse.com>
References: <cover.1746638347.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are using an integer for the 'delalloc' argument but all we need is a
boolean, so switch the type to 'bool' and rename the parameter to
'is_delalloc' to better match the fact that it's a boolean.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 10 +++++-----
 fs/btrfs/block-group.h |  2 +-
 fs/btrfs/extent-tree.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 034182fd9b91..20f238dd8d96 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3829,9 +3829,9 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 /*
  * Update the block_group and space info counters.
  *
- * @cache:      The cache we are manipulating
- * @num_bytes:  The number of bytes in question
- * @delalloc:   The blocks are allocated for the delalloc write
+ * @cache:       The cache we are manipulating.
+ * @num_bytes:   The number of bytes in question.
+ * @is_delalloc: Whether the blocks are allocated for a delalloc write.
  *
  * This is called by somebody who is freeing space that was never actually used
  * on disk.  For example if you reserve some space for a new leaf in transaction
@@ -3839,7 +3839,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
  * reserve set to 0 in order to clear the reservation.
  */
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
-			       u64 num_bytes, int delalloc)
+			       u64 num_bytes, bool is_delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
 
@@ -3853,7 +3853,7 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
 
-	if (delalloc)
+	if (is_delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
 
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 35309b690d6f..f1cbd6643787 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -341,7 +341,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 			     u64 ram_bytes, u64 num_bytes, int delalloc,
 			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
-			       u64 num_bytes, int delalloc);
+			       u64 num_bytes, bool is_delalloc);
 int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 64e8c653ae8f..ca229381d448 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3508,7 +3508,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
 
 	btrfs_add_free_space(bg, buf->start, buf->len);
-	btrfs_free_reserved_bytes(bg, buf->len, 0);
+	btrfs_free_reserved_bytes(bg, buf->len, false);
 	btrfs_put_block_group(bg);
 	trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
 
-- 
2.47.2



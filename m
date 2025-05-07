Return-Path: <linux-btrfs+bounces-13803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833BAAE7BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56179C073C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF47028CF4F;
	Wed,  7 May 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxpIFIfK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF928C850
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638607; cv=none; b=YCOYFqQcFI1hKTXm3lta1kr0PyNnGUu3WlWP+mmQOTPsu0jCN2DHCyvbbgcSvCCoQTRnpFIsL83++1WXOKFVuTPEvN1sYRPaPBsh6ApKF4Txj5pIXlUh/mtve1HPO0xSVE8V89XNTE0Ne9HENSlKcvYMqnQqlJiXLnIaaMhIyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638607; c=relaxed/simple;
	bh=RSo/G+x6sH9GWQgOTd0VrICrTlNZLPO5EPdxaBfcG6I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXc1SvUKGtTST4VwZlbmOYnP3Pc8Y+0bofWBxw5r61e1BwhGF5vhR3QKDLEG+pMyJu8LzwUE+Vlvd3gmEhwZ2mZT5k6kkDv3TFtticExjd8JyMU2MTbo8MFc+5biRKEzTRforC5fFH3D4P43/D3ndPiWLQB1gqxQPWo2kiIeAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxpIFIfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EBEC4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746638606;
	bh=RSo/G+x6sH9GWQgOTd0VrICrTlNZLPO5EPdxaBfcG6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NxpIFIfKSdLiDpWkkynzEtz9Cp/fjMRuOpA2jhOJDWupcm+p9VvsYCPIoc32Kg6nq
	 0xUhbPKH0xHP3u9PCH2EPyv2nILYGQBOhsXIK0T3ANkBAfqXwPJDywttiIZvffgJZ+
	 t/X89TUYgSZB7ddupAemzA1Zj67NpqlPgyXQqHSInjbFH2OH/gB34a6GxHiqgnKn34
	 Jxwonw4/9c0cvCTNhFWEyXr3n3tKApUi6zhN1e3TlE9hUmF6hJqmBQ0hyp5GZ9EOSr
	 whcRKVtcyxsXRkHmvWkp+iVkgkqgkgE5yfR1IC8z1TXTY4BLNhXrv0jWfgJl1az9bF
	 3HYMggQSgaqpA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: use boolean for delalloc argument to btrfs_free_reserved_extent()
Date: Wed,  7 May 2025 18:23:17 +0100
Message-Id: <98932c27a72969eb1adf2dd668fe8d70c03c1d31.1746638347.git.fdmanana@suse.com>
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
 fs/btrfs/direct-io.c   |  3 +--
 fs/btrfs/extent-tree.c |  6 +++---
 fs/btrfs/extent-tree.h |  2 +-
 fs/btrfs/inode.c       | 10 +++++-----
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index fde612d9b077..546410c8fac0 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -204,8 +204,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
-		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
-					   1);
+		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
 
 	return em;
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ca229381d448..14589d1a5f49 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4734,7 +4734,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 }
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-			       u64 start, u64 len, int delalloc)
+			       u64 start, u64 len, bool is_delalloc)
 {
 	struct btrfs_block_group *cache;
 
@@ -4746,7 +4746,7 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	btrfs_add_free_space(cache, start, len);
-	btrfs_free_reserved_bytes(cache, len, delalloc);
+	btrfs_free_reserved_bytes(cache, len, is_delalloc);
 	trace_btrfs_reserved_extent_free(fs_info, start, len);
 
 	btrfs_put_block_group(cache);
@@ -5220,7 +5220,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_tree_unlock(buf);
 	free_extent_buffer(buf);
 out_free_reserved:
-	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 0);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, false);
 out_unuse:
 	btrfs_unuse_block_rsv(fs_info, block_rsv, blocksize);
 	return ERR_PTR(ret);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 0ed682d9ed7b..88e19f9b87e2 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -150,7 +150,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
 				struct extent_buffer *leaf, int slot);
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-			       u64 start, u64 len, int delalloc);
+			       u64 start, u64 len, bool is_delalloc);
 int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
 			      const struct extent_buffer *eb);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2666b0f73452..f0b31691e766 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1174,7 +1174,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
 	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
 	extent_clear_unlock_delalloc(inode, start, end,
 				     NULL, &cached,
@@ -1452,7 +1452,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size - 1, false);
 out_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
 out_unlock:
 	/*
 	 * Now, we have three regions to clean up:
@@ -3282,7 +3282,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						NULL);
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
-					ordered_extent->disk_num_bytes, 1);
+					ordered_extent->disk_num_bytes, true);
 			/*
 			 * Actually free the qgroup rsv which was released when
 			 * the ordered extent was created.
@@ -8886,7 +8886,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
-						   ins.offset, 0);
+						   ins.offset, false);
 			break;
 		}
 
@@ -9714,7 +9714,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 out_free_reserved:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
 out_delalloc_release:
 	btrfs_delalloc_release_extents(inode, num_bytes);
 	btrfs_delalloc_release_metadata(inode, disk_num_bytes, ret < 0);
-- 
2.47.2



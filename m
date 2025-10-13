Return-Path: <linux-btrfs+bounces-17718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1580BD5894
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CD618A5B81
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5040A3081CF;
	Mon, 13 Oct 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGx+mKct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231326FD86
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377096; cv=none; b=RJcjSD6L74Y2wTIZyfGQ+ZYNDkHVYO0n7Ojrp1BxwiDWLAWc1l6tsWOdqjRv/i0ifA/OUAnkosXKrT8E51Ei8DSNltPeg0GYy7tUGBxRrWf/MKTmOFC1nPW2NYB+FNmEWCQkQDrSla+Z4vBgrPqkTUp7bjZ3ZonvwM5D5oEm5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377096; c=relaxed/simple;
	bh=VUXeqFxc5fpf9DJmNfDheZlhkmT55YWuRd+v7pbXM9Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqpV0qBp2tMaydzsIoWPm+fp7FTg4W6y0pHLiQFvg9QtFXzeowWXz8ZiFKCVCCJfV+hkCp178ys/C+w3TAfDlfQOvGvpNvcpb0U8zgBhFoF4bt6v37upR9mKm3s7HgIVvzdwQVBNFMv6VTTD8kaYVixsJaPyVcJrF4Yk/vtnHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGx+mKct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C56C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377096;
	bh=VUXeqFxc5fpf9DJmNfDheZlhkmT55YWuRd+v7pbXM9Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gGx+mKctmcOSjcNB3ru9yWdArMMnF2FvsgfM36uF/xEpTO/EBUKtj6mhVQ8FsxetS
	 cjn9N4mLX1617fICZp6Ws+UH4KFhNXY1qI2ALncU64NVoatONqIKUlw3WEnBjheLGQ
	 Fc6jmjy0OlJ2s6XosP4k5+kbikH//hNytgUSomjEAZbE7d67op1fP9Pzg3J/SzS80p
	 r+0EzwdlZNaAD/WI2xXGboDJTnqwsjXzdAiTx0kielEwqK4+572mBKIsELZXW165Ov
	 0BkYMGJhGbIeGZKdb0Meltk6O/vt1tT4DAtDcqzuSNc3jee6G6thDEsPj+UgrUKyA7
	 5E2B9CP7Fnzfw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs: remove fs_info argument from btrfs_try_granting_tickets()
Date: Mon, 13 Oct 2025 18:37:56 +0100
Message-ID: <17d19116ac393b7b1dd83cb7197bae22541ee891.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  4 ++--
 fs/btrfs/block-rsv.c   |  2 +-
 fs/btrfs/space-info.c  | 14 +++++++-------
 fs/btrfs/space-info.h  |  5 ++---
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index cd51f50a7c8b..07fc75f481ff 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3836,7 +3836,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 	 * that happens.
 	 */
 	if (num_bytes < ram_bytes)
-		btrfs_try_granting_tickets(cache->fs_info, space_info);
+		btrfs_try_granting_tickets(space_info);
 out:
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
@@ -3874,7 +3874,7 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
 
-	btrfs_try_granting_tickets(cache->fs_info, space_info);
+	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
 
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 5ad6de738aee..75cd35570a28 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -387,7 +387,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 		num_bytes = block_rsv->reserved - block_rsv->size;
 		btrfs_space_info_update_bytes_may_use(sinfo, -num_bytes);
 		block_rsv->reserved = block_rsv->size;
-		btrfs_try_granting_tickets(fs_info, sinfo);
+		btrfs_try_granting_tickets(sinfo);
 	}
 
 	block_rsv->full = (block_rsv->reserved == block_rsv->size);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 04a07d6f8537..50c7c240bb51 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -373,7 +373,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	btrfs_space_info_update_bytes_zone_unusable(space_info, block_group->zone_unusable);
 	if (block_group->length > 0)
 		space_info->full = false;
-	btrfs_try_granting_tickets(info, space_info);
+	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 
 	block_group->space_info = space_info;
@@ -523,9 +523,9 @@ static void remove_ticket(struct btrfs_space_info *space_info,
  * This is for space we already have accounted in space_info->bytes_may_use, so
  * basically when we're returning space from block_rsv's.
  */
-void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info)
+void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct list_head *head;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
 
@@ -1124,7 +1124,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		 * the list.
 		 */
 		if (!aborted)
-			btrfs_try_granting_tickets(fs_info, space_info);
+			btrfs_try_granting_tickets(space_info);
 	}
 	return (tickets_id != space_info->tickets_id);
 }
@@ -1544,7 +1544,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	 * ticket in front of a smaller ticket that can now be satisfied with
 	 * the available space.
 	 */
-	btrfs_try_granting_tickets(fs_info, space_info);
+	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
 
@@ -1572,7 +1572,7 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 
 	ticket->error = -ENOSPC;
 	remove_ticket(space_info, ticket);
-	btrfs_try_granting_tickets(fs_info, space_info);
+	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
 
@@ -2195,5 +2195,5 @@ void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len)
 grant:
 	/* Add to any tickets we may have. */
 	if (len)
-		btrfs_try_granting_tickets(fs_info, space_info);
+		btrfs_try_granting_tickets(space_info);
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a846f63585c9..596a1e923ddf 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -283,8 +283,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				 struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
-void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info);
+void btrfs_try_granting_tickets(struct btrfs_space_info *space_info);
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 			 const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush);
@@ -295,7 +294,7 @@ static inline void btrfs_space_info_free_bytes_may_use(
 {
 	spin_lock(&space_info->lock);
 	btrfs_space_info_update_bytes_may_use(space_info, -num_bytes);
-	btrfs_try_granting_tickets(space_info->fs_info, space_info);
+	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
 int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
-- 
2.47.2



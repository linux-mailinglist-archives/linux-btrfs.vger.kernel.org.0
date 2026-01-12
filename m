Return-Path: <linux-btrfs+bounces-20417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC5D13F3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9488930B975E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560D1365A0E;
	Mon, 12 Jan 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="bFmOjkhz";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Ng6NquJz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-4.smtp-out.eu-west-1.amazonses.com (a4-4.smtp-out.eu-west-1.amazonses.com [54.240.4.4])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD23659F9
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234644; cv=none; b=eMkuZJXfxAraHytfNTZiS4ypne5ZqrAIn5J44ZRVY0FI3GVwbn60howSn8A2DYYcN/wLf4tQZznQaSeOkTapyQPL/Hq8RxmlddShSpQJVl2563RLAh1U4INvw3ffyATwYXjNQinE1oInFHQvqc0mDQPM96ELVAqWAFjlD1cdzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234644; c=relaxed/simple;
	bh=37tpzfPMaQMRcOiL3GwnoEK2zcapU952sLtSF/+EymU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJFhzz3WM2b23DCl76XlNJW3IUyx6CCkFjMvxAqiSeF0iIoFvKIzqU1jY+2UBmlaHv2FCP9Ykyx/reoq1Q2IYK9i3zJKLOpECrxuMynUc/Zyhj3bFUA8yABM29Pw4b6gGGfNaOfjh/qWIrwXDfiw6wGu2TUo1/dgx4aEHjQEI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=bFmOjkhz; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Ng6NquJz; arc=none smtp.client-ip=54.240.4.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234638;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=37tpzfPMaQMRcOiL3GwnoEK2zcapU952sLtSF/+EymU=;
	b=bFmOjkhzoZcaBDtvIjSJgdh03ZehibRfgYyDKmaEZGWXvcIDr7iqxPFhOkkxmVea
	C1n0c2Q8OAbPUaN0OTcen3lTLwVKpG7lIU7gwSfUxT1e/mBIEL5qPXYbxkNKXQ0pLke
	m0eiC8FCJQQXGczk6aq60u4IrCyy7N6fpdATuCH4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234638;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=37tpzfPMaQMRcOiL3GwnoEK2zcapU952sLtSF/+EymU=;
	b=Ng6NquJzGxSB4lboZcALa75NySFijw+Cx6QstVBoKIG1sEEnLoTIq0Mg7tPH15Go
	f04CXigLUse32LE5CPAyLLXXPPV3dJy7icO1cpoNKdmPKQmrk1VTOxxYfZT2VxDGt3S
	LZ7Gg4PsgNbs9RD7iHdinLzBc8YgYUNQOcItuMeg=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 5/7] btrfs: Skip locking percpu semaphores on mount
Date: Mon, 12 Jan 2026 16:17:18 +0000
Message-ID: <0102019bb2ff5c32-cdc2c938-b09e-4bab-842a-17ec8c7d2420-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112161549.2786827-1-martin@urbackup.org>
References: <20260112161549.2786827-1-martin@urbackup.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.12-54.240.4.4

We are adding block groups rapidly on mount and locking the
percpu semaphores for each block group addition. This is
quite slow.
Since mount/open_ctree is currently single-threaded we
can simply not lock in this case, removing the percpu
write lock overhead.

Signed-off-by: Martin Raiber <martin@urbackup.org>
---
 fs/btrfs/block-group.c | 20 +++++++++++---------
 fs/btrfs/space-info.c  |  8 +++++---
 fs/btrfs/space-info.h  |  2 +-
 fs/btrfs/zoned.c       |  2 +-
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 702b8e7a67a4..85038c33f3ac 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -211,7 +211,7 @@ static int btrfs_bg_start_cmp(const struct rb_node *new,
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
-static int btrfs_add_block_group_cache(struct btrfs_block_group *block_group)
+static int btrfs_add_block_group_cache(struct btrfs_block_group *block_group, int lock)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct rb_node *exist;
@@ -219,13 +219,15 @@ static int btrfs_add_block_group_cache(struct btrfs_block_group *block_group)
 
 	ASSERT(block_group->length != 0);
 
-	percpu_down_write(&fs_info->block_group_cache_lock);
+	if (lock)
+		percpu_down_write(&fs_info->block_group_cache_lock);
 
 	exist = rb_find_add_cached(&block_group->cache_node,
 			&fs_info->block_group_cache_tree, btrfs_bg_start_cmp);
 	if (exist)
 		ret = -EEXIST;
-	percpu_up_write(&fs_info->block_group_cache_lock);
+	if (lock)
+		percpu_up_write(&fs_info->block_group_cache_lock);
 
 	return ret;
 }
@@ -2467,14 +2469,14 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
-	ret = btrfs_add_block_group_cache(cache);
+	ret = btrfs_add_block_group_cache(cache, 0);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		goto error;
 	}
 
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_add_bg_to_space_info(info, cache);
+	btrfs_add_bg_to_space_info(info, cache, 0);
 
 	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_writeable(info, cache->start)) {
@@ -2518,7 +2520,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		bg->used = map->chunk_len;
 		bg->flags = map->type;
 		bg->space_info = btrfs_find_space_info(fs_info, bg->flags);
-		ret = btrfs_add_block_group_cache(bg);
+		ret = btrfs_add_block_group_cache(bg, 1);
 		/*
 		 * We may have some valid block group cache added already, in
 		 * that case we skip to the next one.
@@ -2535,7 +2537,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 
-		btrfs_add_bg_to_space_info(fs_info, bg);
+		btrfs_add_bg_to_space_info(fs_info, bg, 1);
 
 		set_avail_alloc_bits(fs_info, bg->flags);
 	}
@@ -2949,7 +2951,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	cache->space_info = space_info;
 	ASSERT(cache->space_info);
 
-	ret = btrfs_add_block_group_cache(cache);
+	ret = btrfs_add_block_group_cache(cache, 1);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		btrfs_put_block_group(cache);
@@ -2961,7 +2963,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_add_bg_to_space_info(fs_info, cache);
+	btrfs_add_bg_to_space_info(fs_info, cache, 1);
 	btrfs_update_global_block_rsv(fs_info);
 
 #ifdef CONFIG_BTRFS_DEBUG
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ddedeccbdade..b2605c9d79b4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -371,7 +371,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 }
 
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
-				struct btrfs_block_group *block_group)
+				struct btrfs_block_group *block_group, int lock)
 {
 	struct btrfs_space_info *space_info = block_group->space_info;
 	int factor, index;
@@ -393,9 +393,11 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	block_group->space_info = space_info;
 
 	index = btrfs_bg_flags_to_raid_index(block_group->flags);
-	percpu_down_write(&space_info->groups_sem);
+	if (lock)
+		percpu_down_write(&space_info->groups_sem);
 	list_add_tail(&block_group->list, &space_info->block_groups[index]);
-	percpu_up_write(&space_info->groups_sem);
+	if (lock)
+		percpu_up_write(&space_info->groups_sem);
 }
 
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index f99624069391..7baa335f63fb 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -271,7 +271,7 @@ static inline u64 btrfs_space_info_used(const struct btrfs_space_info *s_info,
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
-				struct btrfs_block_group *block_group);
+				struct btrfs_block_group *block_group, int lock);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index da92b0d38a1b..46938385ad15 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2607,7 +2607,7 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 			if (reloc_sinfo->block_group_kobjs[index] == NULL)
 				btrfs_sysfs_add_block_group_type(bg);
 
-			btrfs_add_bg_to_space_info(fs_info, bg);
+			btrfs_add_bg_to_space_info(fs_info, bg, 1);
 		}
 
 		fs_info->data_reloc_bg = bg->start;
-- 
2.39.5



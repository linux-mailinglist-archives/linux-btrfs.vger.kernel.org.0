Return-Path: <linux-btrfs+bounces-20597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C2D28BA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145B83055718
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E2932861E;
	Thu, 15 Jan 2026 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAPcbt0+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1598327C1D
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512557; cv=none; b=dQ29LJhqLeOFFo8PU+zp3/R4GKBVxy+3hzW5zKFK5KhNR1CGl9kQvRhnbWUyOBeX16oUGzaAqrDZ8nMS7xV6qrI8XPuln3VlzBEUTDN9cUF5tjKKGCzbYhP5MJM8PKdQR7ohKD+xudhevOunHJJXcR26PiObfGrc2O5g1q0ugaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512557; c=relaxed/simple;
	bh=5QqHj/ysxDK3QRzG92gW7ETNLoKEyo1IAhfFoXmlWE8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DRuJ3h8g3dK2kM/IEYfQOyYngQztNWCuNRBxR21ZWfI5aAKPBLHjUdQjH7kjr+pHXoz9ssRuTcj5nkXGs/0uAuU5lkl1NJEmDE1ZJcSErhWvpgCU4it9eV9MJ42HKetAQ0Lxy91YIP7znMHafOjpMFHiPTULsw1LEjGneW+DQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAPcbt0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6274C116D0
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768512557;
	bh=5QqHj/ysxDK3QRzG92gW7ETNLoKEyo1IAhfFoXmlWE8=;
	h=From:To:Subject:Date:From;
	b=uAPcbt0+k/RR3GtxOdhu/HraV/9bDruw7heGbcfQWCKwOJse2/MqZDdhhmeD4TsWw
	 qeMLwFv91Khkxmx9HdRtVK+XjEgujfEJhtnhUk5jLmVEduv3AdyPu43lMmwJngFm59
	 +N5pjan8qPKGz36poGZUkijXtrDzrCo1yTX405L2aQREyV7C8S3NCgFbYr5VdlRiAE
	 nOlaFSm3QctNj1F8H38LmBlKjx2PPVj73U11V0q2xxycbmRdPnleoAnGIpdrcry4hi
	 kpNciBnVrnONmE83tEXuHasG00iK+QTfwVIq5dsFJrlNQfcpEzCEaL2ccx3wvPde0n
	 6ZPs0AFZZtNBQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add and use helper to compute the free space for a block group
Date: Thu, 15 Jan 2026 21:29:01 +0000
Message-ID: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have currently three places that compute how much free space a block
group has. Add a helper function for this and use it in those places.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 9 ++-------
 fs/btrfs/block-group.h | 8 ++++++++
 fs/btrfs/space-info.c  | 3 +--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a1119f06b6d1..d17fe777b727 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1376,8 +1376,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, bool force)
 		goto out;
 	}
 
-	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->zone_unusable - cache->used;
+	num_bytes = btrfs_block_group_free_space(cache);
 
 	/*
 	 * Data never overcommits, even in mixed mode, so do just the straight
@@ -3089,7 +3088,6 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
-	u64 num_bytes;
 
 	BUG_ON(!cache->ro);
 
@@ -3105,10 +3103,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 			btrfs_space_info_update_bytes_zone_unusable(sinfo, cache->zone_unusable);
 			sinfo->bytes_readonly -= cache->zone_unusable;
 		}
-		num_bytes = cache->length - cache->reserved -
-			    cache->pinned - cache->bytes_super -
-			    cache->zone_unusable - cache->used;
-		sinfo->bytes_readonly -= num_bytes;
+		sinfo->bytes_readonly -= btrfs_block_group_free_space(cache);
 		list_del_init(&cache->ro_list);
 	}
 	spin_unlock(&cache->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5f933455118c..17a987f7fff3 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -295,6 +295,14 @@ static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group
 	       !(block_group->flags & BTRFS_BLOCK_GROUP_METADATA);
 }
 
+static inline u64 btrfs_block_group_free_space(const struct btrfs_block_group *bg)
+{
+	lockdep_assert_held(&bg->lock);
+
+	return (bg->length - bg->used - bg->pinned - bg->reserved -
+		bg->bytes->super - bg->unusable);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group);
 #endif
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 857e4fd2c77e..a9fe6b66c5e1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -656,8 +656,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
 		u64 avail;
 
 		spin_lock(&cache->lock);
-		avail = cache->length - cache->used - cache->pinned -
-			cache->reserved - cache->bytes_super - cache->zone_unusable;
+		avail = btrfs_block_group_free_space(cache);
 		btrfs_info(fs_info,
 "block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
 			   cache->start, cache->length, cache->used, cache->pinned,
-- 
2.47.2



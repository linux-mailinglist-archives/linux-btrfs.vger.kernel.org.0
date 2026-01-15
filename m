Return-Path: <linux-btrfs+bounces-20600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F183D28E73
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D710330080CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4532E141;
	Thu, 15 Jan 2026 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4lX239z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A632D7EC
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513933; cv=none; b=thoePYb7prO+MA6v0g9XZznMYvzTdwCvzSzG3f1f/oKLYEPYAzOJ17AyHgVAZWj7vx4O09ERTa0VdFat7XPSkkYG2LLNFL600CCps3gYxo/OzIo43jVXBgFqwcETErl2p3j5DwKI2MrECUXU+asjK8hKN33qSQahS3SYxikmqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513933; c=relaxed/simple;
	bh=KToLOMao+NF0RCKMiJrHHxT37faRq/TyQND3y2GRKjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUAOaS6CoGME1PLKdtp8Jay/EPPjPOwvyDI4+ujiXXMKza/6HeOt8/ZomBZUN9DfKneh7FQx764PHWxNNU1WzFBuXqp1oUhg0qE0j53EYsCy/8xkUgY/G7yxNvrMBV3MXYTMLlVi4VjdbBFPAmcfXjRIQCYcIYlO7ixQcrgHJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4lX239z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81449C19422
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513929;
	bh=KToLOMao+NF0RCKMiJrHHxT37faRq/TyQND3y2GRKjE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W4lX239zan222lscYvdPWX+t2UXSx5+PFNAmpUqn8ogs30hEq2AVokuoLkLHu6tgt
	 SRKndRQwjhdz4kpufJ/l5/OFKWJ9SbxN8OLNYQ2poIexnccB5Mr9v3o3Ne+EjkgPoh
	 E+B+4MQJVbqotgLWZYpr6wtGZbJoyZhrEsN2ZmRnRBEYMURSKKGO2nT9ho69iA2eeO
	 653dQPqKXNNyFcAi/kxitoI4tgdQF31D4u8Bi4YoOvCFxAWEu5pE+eBverVhtWKONU
	 IzxASL+qkzD6ff5G8GPlF0uwwW7e+Qr7oOethYLxhr1/t+8YoqsD8areYoYVt9KLvR
	 AYVoAXN51CsCA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add and use helper to compute the free space for a block group
Date: Thu, 15 Jan 2026 21:52:06 +0000
Message-ID: <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
References: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
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

V2: Fix typos leading to compilation failure.

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
index 5f933455118c..6662e644199a 100644
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
+		bg->bytes_super - bg->zone_unusable);
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



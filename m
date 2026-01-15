Return-Path: <linux-btrfs+bounces-20599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B6D28C97
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D9E303828E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93C31D371;
	Thu, 15 Jan 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJcS5ZWk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54786250
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513321; cv=none; b=HDx90uAkNwwbTDx+miegLi1o6LPCpu1OV91f6ynNPoP4u50tQNkmR5sqWfqx/KNiUvS9mLz4FJez6ghXBIFzNRwWysVFDSFzWEI8jFKZtrmDd2eawCe0nE8rbl3fAYcFOl/m5Eqxizn4gbyhKzh+0IfKqXl+t5Ih7JzxbWzwdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513321; c=relaxed/simple;
	bh=PzUUqVtsdsEPFw5cBPS06x8E//BnlAjhnijFxvXY4Og=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A92MytP5QxJicfvmNCK05SNVnQBYg93puId7AyLsqhu9RMJSRn5zvtJ+k+/LAnWz1c3TiZPHM902ReYfQcg1MM7G5pvQEsQBWASYyQa/VYlN7l+YEcYiItcZsHnfD/2QvMbf5akq7lRs0TCGgRt0OFI51mkapnv2nzB330svrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJcS5ZWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20423C116D0
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513320;
	bh=PzUUqVtsdsEPFw5cBPS06x8E//BnlAjhnijFxvXY4Og=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fJcS5ZWk22OGuStK2orG1qw+bh1uZj6JVS/nVfZ7mciA3Ue6GR+7oVzpX4pIiyOqT
	 CIN1xiGe/swt9AKg7OIfvAJSeLZp6Mci1G70wyYhYtvZ6RXsd1RiO4Hv5piL6fGlgW
	 m1JWdshugHW7Nxk1q6mMF45HuGzH2vrsmFfswfqxMxoFknDyXHSbLwvWIOvcAEKkuv
	 ErPzdHpt3J5Oro9OPi/OFpBII/jj1bHEjkhmzVkH7xuwEhxmKKJouUeFREl6kglf7K
	 UHQPe3FIJsjyyMyUzYdPDYGKre74PTvoq/3DnibaSR0fKUf22cfWopK0YKrEv7OuHE
	 kKGagD9E48plA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add and use helper to compute the free space for a block group
Date: Thu, 15 Jan 2026 21:41:54 +0000
Message-ID: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768513242.git.fdmanana@suse.com>
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



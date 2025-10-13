Return-Path: <linux-btrfs+bounces-17723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C1BD58A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDF504E29C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B723090E6;
	Mon, 13 Oct 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX1n4MO3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC63019C3
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377101; cv=none; b=FnaJMfRp7eum8YiPwmI1EuV4L6foUwE54akmbhgyxqy1aHuC8xsZbqhV7aW1mKTdKo6DJAvUIwh1p37sgviyusYyScd36ti494o8LTMB70ZFihzDwWbGQXgTn/P4M5rpQh7ftWyxoPwMUx0ghaVdpfjj99JbzFpCbhOK79Y7e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377101; c=relaxed/simple;
	bh=JblxonGmn+GmFFrW5IhvJOsU9nNQiugw0oEP6OUgsHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxT1kna7dKqEm4YYQbeONmVuA3mkW/3kHV8dzM5ikHmUTBnfwtRF5fbn+sZIHJVJNK6YGi5jXiwKHAY4l7kCAh4Jasc37g/yi/skDJIGT3HY8Lq5CJJ7L4C2dk8RWPT7cewYINsKiDQqyITHNviDgUHN+am3XS4s1xgHPocOkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX1n4MO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A82C4CEFE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377100;
	bh=JblxonGmn+GmFFrW5IhvJOsU9nNQiugw0oEP6OUgsHE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gX1n4MO3PVL6zoHE759wCA2TvegL2pFpg4QZa4SigX/OZ07yjSz0TjSozLCNG0/nZ
	 U7RVFueO0z9d+jjxqkgFXsLSAypWc7KzzrtVZDscjwL39r7xXTMZHb+TfcfVklqBgN
	 GeFmmjXZEmIXGCWy2kF/LauuED3qxVJ54wcnoMIg+mfh1q1kmfM+p0DXuyqpAGFvyk
	 VgBe6CQeXDtcpfgUzuZszCwqsCxjNo2YOf3+LjtjI1+dt35g2Z12n1n8AweKzEr5qp
	 JO058uvz+7ZLPD4ghywBu0hL3xkreQ3C6GPl379DiMPBRm8Y+CywcBr76+hBWtIKfC
	 r31WJhRyoZ9nA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/16] btrfs: remove fs_info argument from btrfs_can_overcommit()
Date: Mon, 13 Oct 2025 18:38:01 +0100
Message-ID: <3360144ef804f1c583192e6f2bdfdbde2dcfc704.1760376569.git.fdmanana@suse.com>
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
 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/space-info.c  | 9 +++------
 fs/btrfs/space-info.h  | 3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 07fc75f481ff..0a72056fd065 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1403,8 +1403,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, bool force)
 		 * BTRFS_RESERVE_NO_FLUSH to give ourselves the most amount of
 		 * leeway to allow us to mark this block group as read only.
 		 */
-		if (btrfs_can_overcommit(cache->fs_info, sinfo, num_bytes,
-					 BTRFS_RESERVE_NO_FLUSH))
+		if (btrfs_can_overcommit(sinfo, num_bytes, BTRFS_RESERVE_NO_FLUSH))
 			ret = 0;
 	}
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 88d715dcdb0e..c473160d6e36 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -490,8 +490,7 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
 	return avail;
 }
 
-int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 const struct btrfs_space_info *space_info, u64 bytes,
+int btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush)
 {
 	u64 avail;
@@ -525,7 +524,6 @@ static void remove_ticket(struct btrfs_space_info *space_info,
  */
 void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 {
-	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct list_head *head;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
 
@@ -541,8 +539,7 @@ void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 
 		/* Check and see if our ticket can be satisfied now. */
 		if ((used + ticket->bytes <= space_info->total_bytes) ||
-		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
-					 flush)) {
+		    btrfs_can_overcommit(space_info, ticket->bytes, flush)) {
 			btrfs_space_info_update_bytes_may_use(space_info, ticket->bytes);
 			remove_ticket(space_info, ticket);
 			ticket->bytes = 0;
@@ -1775,7 +1772,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	 */
 	if (!pending_tickets &&
 	    ((used + orig_bytes <= space_info->total_bytes) ||
-	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {
+	     btrfs_can_overcommit(space_info, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(space_info, orig_bytes);
 		ret = 0;
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 596a1e923ddf..737e874a8c34 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -284,8 +284,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
 void btrfs_try_granting_tickets(struct btrfs_space_info *space_info);
-int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 const struct btrfs_space_info *space_info, u64 bytes,
+int btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush);
 
 static inline void btrfs_space_info_free_bytes_may_use(
-- 
2.47.2



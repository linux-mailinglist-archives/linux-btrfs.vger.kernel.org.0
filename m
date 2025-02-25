Return-Path: <linux-btrfs+bounces-11761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F032A43C73
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B317219C2C3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8257267734;
	Tue, 25 Feb 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLfyTycd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36D267B81
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481035; cv=none; b=B7MW4PJvDbztxkpso0J1BzHkov3hvGeZxbWQcAvHQF0730fp/MtIhDxXo5l1ywlXgdCkMq5/TssV5A3AzOuiR2uKgqLRt52B0dOmcgK/XeScCY4f3Q4O2ClqmTp70X0b3pFN8k3IaBSB9X+/9ugNJBQXJIK4tft1tKZHio+No20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481035; c=relaxed/simple;
	bh=3e7HJO5pm7tc/hMqRj1pzs9iKBBUDGyVsuHPSbjaiVA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E95kRTYBXwHvmUkT+0mVfVKikaaOV/zMY6H4fEEpx71Q6CLwC6MJ8RPvWFa6/oYKWHWfArk2+vXth24HHd4fjA0NPdzJCYHOkAkpew6YBe3e5fLblEIx8ayJ3/rpXMQiFg1PTn1XckmtC1MFuNmgWkVykunQzjpHxwPqo67YVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLfyTycd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139A5C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740481034;
	bh=3e7HJO5pm7tc/hMqRj1pzs9iKBBUDGyVsuHPSbjaiVA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LLfyTycdlQNVrJUjTmv/DXPCN3pF9h22srGmG2iSjdenKOZM5VgP7ZWKM7UUYt41m
	 LOVx97Ya6LxJq6RkBiF7y8YeOhOfu/et/FinqixkB7FXsVHWCAM/L3O6FbJnh7YKC3
	 bhn9Z2MlVu836NmEM64A+ok/8FT5RAfakon+OtjZxn3zqQnph7FSFWj82IYlWne9wO
	 j3TJz4tWQ65joVY6JHxWshfXrEFi3ezoOBNppD+ULxTj3aqt+fLnwyVTTZWCZBkJ73
	 3DZn0q/6f0NRG4E6ZbsjbCjFDIddKFm1jEmJmjH5zF1WrKxvz3lAprXlM7twSPWl+5
	 mvZ2R+haKRW0Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
Date: Tue, 25 Feb 2025 10:57:07 +0000
Message-Id: <2e713972ad284809bb889a5bd52da87777bb885b.1740427964.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740427964.git.fdmanana@suse.com>
References: <cover.1740427964.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_reclaim_bgs_work(), we are grabbing a block group's zone unusable
bytes while not under the protection of the block group's spinlock, so
this can trigger race reports from KCSAN (or similar tools) since that
field is typically updated while holding the lock, such as at
__btrfs_add_free_space_zoned() for example.

Fix this by grabbing the zone unusable bytes while we are still in the
critical section holding the block group's spinlock, which is right above
where we are currently grabbing it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 18f58674a16c..2e174c14ca0a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1887,6 +1887,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+
+		/*
+		 * Cache the zone_unusable value before turning the block group
+		 * to read only. As soon as the blog group is read only it's
+		 * zone_unusable value gets moved to the block group's read-only
+		 * bytes and isn't available for calculations anymore. We also
+		 * cache it before unlocking the block group, to prevent races
+		 * (reports from KCSAN and such tools) with tasks updating it.
+		 */
+		zone_unusable = bg->zone_unusable;
+
 		spin_unlock(&bg->lock);
 		spin_unlock(&space_info->lock);
 
@@ -1903,13 +1914,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			goto next;
 		}
 
-		/*
-		 * Cache the zone_unusable value before turning the block group
-		 * to read only. As soon as the blog group is read only it's
-		 * zone_unusable value gets moved to the block group's read-only
-		 * bytes and isn't available for calculations anymore.
-		 */
-		zone_unusable = bg->zone_unusable;
 		ret = inc_block_group_ro(bg, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0)
-- 
2.45.2



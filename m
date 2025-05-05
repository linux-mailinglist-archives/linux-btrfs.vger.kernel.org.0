Return-Path: <linux-btrfs+bounces-13709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31734AAB4B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 07:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E127A64C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C7289835;
	Tue,  6 May 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS1Pzm65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FF289826;
	Mon,  5 May 2025 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486853; cv=none; b=smZd+Uo7vSm+Xvh352ifr57Nk/2jIg3Qd1TAK2MjvVSSS9XL0JUlNtJ7A1ifNsOUuhL8NFd34Ro/qFWcx8qbFwrAabq3wd7w0nIL1kPUriGSX7E7qRsX4jIbALYpO7zKCiMy0JpStfgoF5n+82L/hpUbpmEe1ou/GOS2fa9oH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486853; c=relaxed/simple;
	bh=6K1W7Zy3vyBKZTLpth2DPhBesAHtGw1EAG+78Ae1Obo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAI9KpqkOeozh3gYNq7jVi/jLUvEUEayhNDn3Jg+t4TQyKnZhUT9k6lzk+/k2eXOhflU0VZm9nLKRwHd7ODwjlYbUuDfIT8ViFTJ+nMF+VM4jL8BYx/Jjv+BSphO6OHthRLZYLHgTvBC5BzfGw0mraCzxm2HVSiYGClPJHTwxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS1Pzm65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A04C4CEE4;
	Mon,  5 May 2025 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486852;
	bh=6K1W7Zy3vyBKZTLpth2DPhBesAHtGw1EAG+78Ae1Obo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MS1Pzm65pzvEtTS97JrJGAe4XEAwT7go+JxmHA3xNSUeRTalJxRJPGswQQAdR0wfY
	 6k85Fs4tubxiqa3GYd3F6O14sQym2U2A+kRq/BJecjoVvAOFYMxZMGRhFIlogBvPuY
	 6UUuzGNhEDh/8F01Hw/L9j53Awuzlgb4LNkXDIJnvvYdZ4dgBlsAnumW96S7VgJsKD
	 6qH64yVhrPYUQUBdCUFYy4LFEU0NPDXySqA6w1uTpSigJewRK4MjwyqIUkpYYQrB68
	 DlRFkysypTg6Ozi18ahYQ9AST+nAJsKsQK1Z/fUBQlrlQrj3zPlfDK06guxHQ698ZH
	 OUetK0WuisIqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 024/153] btrfs: make btrfs_discard_workfn() block_group ref explicit
Date: Mon,  5 May 2025 19:11:11 -0400
Message-Id: <20250505231320.2695319-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 895c6721d310c036dcfebb5ab845822229fa35eb ]

Currently, the async discard machinery owns a ref to the block_group
when the block_group is queued on a discard list. However, to handle
races with discard cancellation and the discard workfn, we have a
specific logic to detect that the block_group is *currently* running in
the workfn, to protect the workfn's usage amidst cancellation.

As far as I can tell, this doesn't have any overt bugs (though
finish_discard_pass() and remove_from_discard_list() racing can have a
surprising outcome for the caller of remove_from_discard_list() in that
it is again added at the end).

But it is needlessly complicated to rely on locking and the nullity of
discard_ctl->block_group. Simplify this significantly by just taking a
refcount while we are in the workfn and unconditionally drop it in both
the remove and workfn paths, regardless of if they race.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/discard.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index bd9dde374e5d8..3ddd0c24a94ea 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -151,13 +151,7 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	block_group->discard_eligible_time = 0;
 	queued = !list_empty(&block_group->discard_list);
 	list_del_init(&block_group->discard_list);
-	/*
-	 * If the block group is currently running in the discard workfn, we
-	 * don't want to deref it, since it's still being used by the workfn.
-	 * The workfn will notice this case and deref the block group when it is
-	 * finished.
-	 */
-	if (queued && !running)
+	if (queued)
 		btrfs_put_block_group(block_group);
 
 	spin_unlock(&discard_ctl->lock);
@@ -243,9 +237,10 @@ static struct btrfs_block_group *peek_discard_list(
 			block_group->discard_cursor = block_group->start;
 			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
 		}
-		discard_ctl->block_group = block_group;
 	}
 	if (block_group) {
+		btrfs_get_block_group(block_group);
+		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
 	}
@@ -469,9 +464,20 @@ static void btrfs_discard_workfn(struct work_struct *work)
 
 	block_group = peek_discard_list(discard_ctl, &discard_state,
 					&discard_index, now);
-	if (!block_group || !btrfs_run_discard_work(discard_ctl))
+	if (!block_group)
 		return;
+	if (!btrfs_run_discard_work(discard_ctl)) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
 	if (now < block_group->discard_eligible_time) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
 		btrfs_discard_schedule_work(discard_ctl, false);
 		return;
 	}
@@ -523,15 +529,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_lock(&discard_ctl->lock);
 	discard_ctl->prev_discard = trimmed;
 	discard_ctl->prev_discard_time = now;
-	/*
-	 * If the block group was removed from the discard list while it was
-	 * running in this workfn, then we didn't deref it, since this function
-	 * still owned that reference. But we set the discard_ctl->block_group
-	 * back to NULL, so we can use that condition to know that now we need
-	 * to deref the block_group.
-	 */
-	if (discard_ctl->block_group == NULL)
-		btrfs_put_block_group(block_group);
+	btrfs_put_block_group(block_group);
 	discard_ctl->block_group = NULL;
 	__btrfs_discard_schedule_work(discard_ctl, now, false);
 	spin_unlock(&discard_ctl->lock);
-- 
2.39.5



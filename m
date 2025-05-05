Return-Path: <linux-btrfs+bounces-13697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF08AAABE9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1685A1452
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA53B63DB;
	Mon,  5 May 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4FNi8gb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A23984C2;
	Mon,  5 May 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486454; cv=none; b=WWd+x13MdF3GCPyEGY1PhtE4mOOyh7Egl4h8CKtlNnUXmfyhhpRq2cmptqXZ0tcDnErWOk15+pmWe9qXrsFBij36fFa1s00ec6RsA19tYGqamcyDwLCStiPyDTht1PDsVmfbiyKYA1Pa7tgJxcASfOy54uKheaF6LDElKLZosPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486454; c=relaxed/simple;
	bh=udTVttIycoEh733uozUt9/H6zWEntjHLcGGR0v5h8kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRPogo07Pa+k3s0t7Au2YFvCmhMlf1VgnEu0qAAspdlo8RSb5ytb6tJY9TSI5Om+pKDBwGgf/jXcOTjwS17uwaVjdsIKcWVc1G6q3ws5NcpexrIKgonKjjliV/nf3/m0b7NGVJoHXt2r7oZQguLBP5+Ugvd8nNHxteXBHseS/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4FNi8gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94139C4CEEE;
	Mon,  5 May 2025 23:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486453;
	bh=udTVttIycoEh733uozUt9/H6zWEntjHLcGGR0v5h8kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4FNi8gba6bGbi2l6fzJpIAxrWCOpM9z0lMK90ppJg5Q7bb3Yy/10hMt9YbkvEj/F
	 xlTAullxbV5GEzd8qrhgNO5fZwXj4oOm9M3bvpH9QU/liohb73UMhrZ0x20KJsXvR1
	 suHMGBFFKK6yv40iTK8a2pWaQz5EN4zpaI3hkalQHuGj7qTc+ng6I+evZHpSjy05/b
	 HuWx9yqkZ+P3llSNnBP5rZa8MJDNeZB7ZJzuNHi8PLu7yPwZX4J8WSd6WqL5inooEf
	 zC3yIEunbIdzcRmfvtkni6ZmRk4y5lyMIxxSKHXSd04g977KMwF1cdaWgCt0JvNXzg
	 4ptth7VbAjI6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 038/212] btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
Date: Mon,  5 May 2025 19:03:30 -0400
Message-Id: <20250505230624.2692522-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1283b8c125a83bf7a7dbe90c33d3472b6d7bf612 ]

At btrfs_reclaim_bgs_work(), we are grabbing a block group's zone unusable
bytes while not under the protection of the block group's spinlock, so
this can trigger race reports from KCSAN (or similar tools) since that
field is typically updated while holding the lock, such as at
__btrfs_add_free_space_zoned() for example.

Fix this by grabbing the zone unusable bytes while we are still in the
critical section holding the block group's spinlock, which is right above
where we are currently grabbing it.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0dcf7fecaf55b..91440ef79a26f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1678,6 +1678,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+
+		/*
+		 * Cache the zone_unusable value before turning the block group
+		 * to read only. As soon as the block group is read only it's
+		 * zone_unusable value gets moved to the block group's read-only
+		 * bytes and isn't available for calculations anymore. We also
+		 * cache it before unlocking the block group, to prevent races
+		 * (reports from KCSAN and such tools) with tasks updating it.
+		 */
+		zone_unusable = bg->zone_unusable;
+
 		spin_unlock(&bg->lock);
 
 		/*
@@ -1693,13 +1704,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
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
2.39.5



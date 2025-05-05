Return-Path: <linux-btrfs+bounces-13704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014AFAAB2F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 06:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051C13AD86F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79143F3AF;
	Tue,  6 May 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh4z55gS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E736F89A;
	Mon,  5 May 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485886; cv=none; b=o6N1KQ41ctDGpAOEWESM8hxIHzzdMDJlN/WdMJO2pDQn32SJcY8ntErZ0ck5MOWfzcXG33cPOd2d91184h8JVrvO2INIRVRY/wB55DTuFxQw1sc9JfZXUccTeuAEbK86K2BxixStupAS7gmH+6UWJgDUdaV6nm8dgiMbAcDH7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485886; c=relaxed/simple;
	bh=VtAC6sVh/dxvCU/5OQQipVHhltgVIdpnx+vOWNddpGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cC4M/w7d0JRND5DdBQE/3MFkqs1XdZapcw55dqk8yHQ0+7pms1eHf2M2i4uQcna9iDCrFiKr2iK0mdx5yXCCc01Ox3kn0INSwdjBA0N6q8UflZNqYoKarmbY0kjy97lqy9EbhykGh9Qym/Q2by576JUyYxT7Iq6jJuKccQwoehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh4z55gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6919EC4CEED;
	Mon,  5 May 2025 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485886;
	bh=VtAC6sVh/dxvCU/5OQQipVHhltgVIdpnx+vOWNddpGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rh4z55gSGiyd2xVJ0wl16GfnWgJD3Nv59JaBfkPTOGO3chttIa++9nfhT7BaVRv9D
	 ajB37XQGOA0iEitUtA9MqAAbPAnOT4oVk5edOAjOnbmNwuHzsJWz8DmJ3wl/Z2QHMu
	 6ETr/skLdcV2uyAL0YGcOrYBNK92Czis45YQZPbc2FI/tlWWwPrMmfDfY2xCc7XDE9
	 AFNdAHwHZa/g+tbgF+SpOzUCF4nJSuzEtO/SJiyqWI9SC5WtSHQ9vI1jJ16RR72KLI
	 YV2AkGlTrLt0F/ielEhBtTh345IJ6HuY8CZcWZ7OmqHlJlkVYqqqzdu4kGjDQoJzPS
	 lZ7nXMFaZjcNA==
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
Subject: [PATCH AUTOSEL 6.6 048/294] btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
Date: Mon,  5 May 2025 18:52:28 -0400
Message-Id: <20250505225634.2688578-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 434cf3d5f4cf1..226e6434a58a9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1885,6 +1885,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
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
@@ -1900,13 +1911,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
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



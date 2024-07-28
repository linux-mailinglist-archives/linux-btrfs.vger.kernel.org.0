Return-Path: <linux-btrfs+bounces-6803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D093E2B9
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5981F21915
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A11946B3;
	Sun, 28 Jul 2024 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnIXZzyh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D7194156;
	Sun, 28 Jul 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128072; cv=none; b=ipNR8vzXgSn6jj3OCksceVpfYzTEjJbwP+CHjvG2+aRGbIYANFdVE/JluJ7zStJeiyGskDFOHFOrTC+3Qwi0dkQp0bws4ro4EZsHIr8D0scQ0H+kTIjnsdaWkqSWkQufA8eiklhzRkr6tVVKMAtIlqbcKv7qe+kob1YH20nRMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128072; c=relaxed/simple;
	bh=aVcfoLY6sqlTRLx3TmnjXeHUD7E90+3diu7rS8CMphk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvEGRT5xTxCYcJ2Mw+HRhrYYVgqzQd4aAGE1MZs2F/B0r9wpJaKKjyCDr6H9aXGGbIBrU4Cm0BETRbHyGfvWaGxucYpbEmMjaDLj0ogxgRCmmxNy5OV0jNnmlQ+s2EbuQT8R6wni0ryHzO0g5mRnyQrd5b8MDjyaG8L0q0t/gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnIXZzyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A88C4AF0C;
	Sun, 28 Jul 2024 00:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128072;
	bh=aVcfoLY6sqlTRLx3TmnjXeHUD7E90+3diu7rS8CMphk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnIXZzyhJ32yl4WZmnJ1BrO2g+BuON8ZXZXa04PgtwxSnc6p04IvP3bZghSBJ8IDc
	 Zc1m2zrD0EjHKnNg6KTlEqFMnaJZs7Zoghb5LbHSLz+uP+NRO878LcQY6KDuiZP/2F
	 01rdv1lwQjmoig6eokKMGAvrE2j0Yg7eS94IvV5GpWvCsVBhKFvNEpAyCOta66khSO
	 sKdIOtpkoWDECRPImNSeJcznSkhbzJIbZLnvtG+gpeHOnYZwz4hpVyVk5srTMBe7wt
	 fbJl/ZxVZXeHSqBTGFMgn1Y8FTnoEWdG2dQkse5kLNOljclVZjzTPjgx5DxWKWp0zw
	 BenO7GSKCbnBw==
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
Subject: [PATCH AUTOSEL 6.10 25/27] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:53:08 -0400
Message-ID: <20240728005329.1723272-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 320d8dc612660da84c3b70a28658bb38069e5a9a ]

If we failed to link a free space entry because there's already a
conflicting entry for the same offset, we free the free space entry but
we don't free the associated bitmap that we had just allocated before.
Fix that by freeing the bitmap before freeing the entry.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dabc3d0793cf4..5007dabc45d3d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -858,6 +858,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0



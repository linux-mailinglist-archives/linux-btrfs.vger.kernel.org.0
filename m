Return-Path: <linux-btrfs+bounces-6806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862993E31A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36B9B240BA
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52AC1A071B;
	Sun, 28 Jul 2024 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD5xs/7R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16901A072D;
	Sun, 28 Jul 2024 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128147; cv=none; b=tyyMiM8rtL8IPZOINabnMGvPkHEruvK/ZGa0MoFX2V3TJf2juuq/z7KYH2lnyfiTE+Vc8ftThcj9SObYJZYF6VSkzGBF4dnLVnDqq596PRSG7yfo/f43NwhU+nMl631FLtJJtWOgVUUamXrfZR5eaPLGUisbux7lZRIDX8F82cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128147; c=relaxed/simple;
	bh=oBLUhY3x06WnyDihtPpXhpSwyTQvIY4CYZnqrS3Vrsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik/qTCy1JO2veensOI/u+YBk6qhuNXgpqkytBCmf6RaWFmOBBQXgzG98Db843eJqqyK8yf+m+7UcLex49QGnwmk1mlgckh+7hE+Pa3miqzjljucSLWPerHjnjzRyxJIPCRdwMZpSiHsALD1ccFKI8s7aHBnS7Xz7BJvGa5QU78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD5xs/7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490DDC32781;
	Sun, 28 Jul 2024 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128146;
	bh=oBLUhY3x06WnyDihtPpXhpSwyTQvIY4CYZnqrS3Vrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FD5xs/7Ro6AKo/gErGPYv5XGWoE0lN3QCXygP3PXfCMmUMO6u+vGmnYEhOXG99ynt
	 KJyIl+FBYarYGTOOwxZ4qoWjGY+GXXbCxX62NofFnut2Wv7S0eMiuQ0untuHcgThwz
	 rROmW2tf4COlQFN0DXTmxhYDjLHyCrZs98PzDhdiBu2W5fDn0SMRKj1p6vs1H1spIL
	 XzTopURmpMTjXYI+yCBuCnL3746P72j1j8UN1+Fj6ZHHZrBUMr+Gvfqd7CY1m0TPyb
	 6B/r4Ltgvquy980jHXP1NyR2KanKHgyvTenA4fC9jm+lsWX63Lz0ylp967WM5Mu1ZN
	 nmLPGxT2Lbfcg==
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
Subject: [PATCH AUTOSEL 6.1 11/11] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:55:16 -0400
Message-ID: <20240728005522.1731999-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 862a222caab33..c0c413a542395 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -865,6 +865,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0



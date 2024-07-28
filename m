Return-Path: <linux-btrfs+bounces-6810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E593E35F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080751F21FED
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE01AD9E8;
	Sun, 28 Jul 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihPbimPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E41465BE;
	Sun, 28 Jul 2024 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128206; cv=none; b=Qf6Cj7V1BF+AVmk4/4fF0TmdrlsZMH3tp3CDvnGeN4NfWFr+uWYkPGqJultyCbw2JPV0kq2hI1ojATG/TA8P9jsb841i9R2Th/DPVge4oQeoiPugpGzBKhAk2Z11g1VAOkC9S6y+QTA95pIpnzmmITVdt3wh4iQ1T3F7rVub3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128206; c=relaxed/simple;
	bh=gGu4yPaEddLTC3SWSGWC4guQWpZtynRLKaEq2y2mZfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMYsK7boCN+M0mRs+9AsbFDNfwt1wqltUhD1N+JX80cnuwxJv+ZZkY/vL6Na2PjE5idAGgcKSJ6EiiKLxGiBp63ijavDeQqlQdQvgFIysy2ZgLeJqQKr8IVdOPNYhbfmiygBpPoBKJRR0KuPO4JciLZ8+YYzsVugiSB8jagWql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihPbimPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0919C4AF0C;
	Sun, 28 Jul 2024 00:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128206;
	bh=gGu4yPaEddLTC3SWSGWC4guQWpZtynRLKaEq2y2mZfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihPbimPxuUgE/yk6/paOpL659LKgScb7XNF7v4pqVPbFaKbOzCU6B+kr0qSJ+LJy9
	 DtQ92sdY0Km/5aDFMeM3xdfowCt1E4snARMKZMe0sV1M2/zqNmniFO/ciJobIz2bxy
	 gz0yWxKzM7MvyS9SlEmos+7/S72CyRc16CMdmp9TG+J77PSD+cETSZWt78YzQHl8b+
	 +pAQFp8qCu0LQK6JPw9RBa7Mo20oNxd2r+WKtRErfr+WBhaCDPT8ZMgQQn12bqXE/l
	 tru07kb7HocYXLS7XrMbbnrWUrBXdvj+rJ1+KlIHeyjHJk2NGt97qqabRLeCe7/SO+
	 wDrQ0GbxXhyTg==
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
Subject: [PATCH AUTOSEL 4.19 4/4] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:56:38 -0400
Message-ID: <20240728005638.1737527-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005638.1737527-1-sashal@kernel.org>
References: <20240728005638.1737527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index b623e9f3b4c49..88f5775792597 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -787,6 +787,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0



Return-Path: <linux-btrfs+bounces-6805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF493E2EF
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536CB1C20322
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89DC19DF81;
	Sun, 28 Jul 2024 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/22FKaS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874113DDC0;
	Sun, 28 Jul 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128113; cv=none; b=updXh3aHBSF0AlN61dasZCf/fmGhyngHePxgE7C2E/uio8B7mv06WlgyCYn9YYnulTg3nXRgISpl1qB3Cu9vUT96cUAXpyBrVIj/ab+/wmFWNkfKYXs1fZIn3GcOCe6SP5puw/teu8MjCpp03/Opuygg4XaTvFF+dMH7qtKK2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128113; c=relaxed/simple;
	bh=kYBu2/wmDwnczaLW/HXHYW5WOP4HVJ3M//hFHq2mDPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu6OrLLwFYko5lLJGRC3QNF3rga0sIzU589ONC68xQG5eRJz3FwAUP/pHkwK6iXP8jo7XFIcn2UPEAVjVMsfdHV81LR7E3/tYD445FwU3beJ+W8YmaHNpVtM7hlewEfE849aONNHgAuPmNUgwQG/JgbNoedmvb6B/A9a3fPvvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/22FKaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667FBC32781;
	Sun, 28 Jul 2024 00:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128113;
	bh=kYBu2/wmDwnczaLW/HXHYW5WOP4HVJ3M//hFHq2mDPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/22FKaS3DW4WB9Z0HaLCC5qKAVwJT85RLhJlfwuI37uL9oESZVd7GeY+1/HOuJtt
	 +X+uxtB3OA2p8EXp6/efN3TnJXn9hfyBk2EYXR2dvDh9PYfeaVMOTkMTEp0RYagc/O
	 4+i75WZG3LmMKrY2QqYRBSZy0k31etNOzjikXP1QYOdww1LlM72PchjpExCz7Kkfcq
	 Tg9yWoEbPbimMVtQgZLiTwyNVpMvnTRN3Mnd1PeoHD764g/3OyctbiLGBYkVlPOgom
	 Nx0kU7q/d/T41LYlGHNQmXYs7ijzpr/nFw0i2b62VQ5PQNJsNPY6S8hKCvkuba5FBN
	 XDXGSRW0YQigw==
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
Subject: [PATCH AUTOSEL 6.6 14/15] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:54:35 -0400
Message-ID: <20240728005442.1729384-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index dcfc0425115e9..003b865676142 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -855,6 +855,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0



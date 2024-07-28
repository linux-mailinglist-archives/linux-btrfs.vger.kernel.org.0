Return-Path: <linux-btrfs+bounces-6808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC193E340
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1574A1F21648
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC6145B23;
	Sun, 28 Jul 2024 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUP3FPqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0C1A3BBB;
	Sun, 28 Jul 2024 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128179; cv=none; b=U2PDr7LYRyP/ubjzqoCZ/9VGM8G8C/0YLGZ64ywnstCOeUFoWWXoBAEvc9NCK/pwpWjfCUuGh6cp3FhCvH7QtloRuSB2lBpB1laNh8Vwq5QXEA4yXE2JfsfhZSdpvrZkOA4HrFzBuNIouuHU5DtP/q++l7nzDyzJcbPyLGc2ZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128179; c=relaxed/simple;
	bh=zEv/k3NfI7luFSr1j4RX2rLk4wfQK7hdvSWSWeUCZcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMgEhst+Lcg7x5svcHBSf9uv+sHqb6cgGbh32EY5Ti2igQQw/mQzhxjvmpDZeKRad154JrNjs+dC5WTZO4HrTj1IMHsV9AIWKYO3Sd0pi302xCNkVYJsBMXrCRXxOYK5506dq+QyNK/DYKgMzdvZXdVmvPLuDnwgGnX+RzNBHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUP3FPqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D17C4AF09;
	Sun, 28 Jul 2024 00:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128179;
	bh=zEv/k3NfI7luFSr1j4RX2rLk4wfQK7hdvSWSWeUCZcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUP3FPqJwQSSrw2FkImNT4uDg/77ysQIir2SKMGnGdBIHdVWoHqCRJ7dWSfc7Wk8m
	 7dDiK9ff1BW6pY1gOl5ujrYJFK3vjewZks2s14sUGvpiyPU7hRZgVdXyrtp0jAX2Vl
	 yhvaJkPRqJ9yBwiGIHFGCZQx0hr+wrsGgsciJALce0n6XeHqWquqtx2qyMRlo6aI0i
	 Nl3UMtcFU68EJ0pcRTj3EvcsbYeTt6oVwgC+aiK5c1WT/vB6Yqz9DBfSwXjElXtVG1
	 Eibous9e3Qg+/BSUeAlia5rSbkKx7IVFYmrLSasRwiOUlZO9ZQf+O6URFb+JlC+X8I
	 fAdtSls1lrsLA==
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
Subject: [PATCH AUTOSEL 5.10 6/6] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:56:03 -0400
Message-ID: <20240728005606.1735387-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005606.1735387-1-sashal@kernel.org>
References: <20240728005606.1735387-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 4989c60b1df9c..af52c9e005b3c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -798,6 +798,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0



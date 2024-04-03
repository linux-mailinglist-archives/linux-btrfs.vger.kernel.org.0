Return-Path: <linux-btrfs+bounces-3875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCA896EA8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7BB1C23FE6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A7C146595;
	Wed,  3 Apr 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ/yuMfy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549CD146018
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145955; cv=none; b=sAypVKhdFMz5Hk7hF8jhFakbx3CrLaKEBXcd5w+FSRVjoaDf4RLl+TMBbAac/tlmJZuqXi1ztkZlZt+4y1aUd/hrfF+WOOjL8ETjtWPHSdLV5oRSEhL4VaFw9yVKdnonotg0vSqk1niMYt5vNBMtQyfSDODvnpKLSliwO8VOFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145955; c=relaxed/simple;
	bh=b+iwCjPZD8qteOnIXHyv/CW3LKmy8IgiMu7pQh/scgY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSMB9ZRgoRfW/+ZtuezxP/056B9Qx8TMTacjhkVxw5kBkLNB6QqdhYcDxAnSa1IzNEIxWnp3bzRZXRHKjGCj6/LgIXKmBDfRR9bvMweBVADPkAkeMk6EkMukNo3XASObowp0IBCj99dosPSv4DEY8vs5ft/JacR11NWTgeaF8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ/yuMfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B36C43394
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712145955;
	bh=b+iwCjPZD8qteOnIXHyv/CW3LKmy8IgiMu7pQh/scgY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hJ/yuMfyECE8i/dtPReomCmu1g3X/VR4LOzKIVR1V5hEyXJdPMbyUbFcHwlcazLsE
	 ihhH6f7xIZKY8FUmVOlii/77ExryZSErTyGWliJlahy0O33lh9r8on+Aex9TjL+IXF
	 O7gnOLD3jZXm7Y26hqxsG1pd0pgmCMaDiWUmyCNG1ZUkYvuQjXF45jpTatPyuRxaeL
	 /oT1yzE1F569CDbTCRSuUal/TerCfF4D3MYZnRnL4Q1ZkfDPEKEhSjAIxMO8Ts3CYG
	 p+pqGcCCuaxYsOufZk6c9u7iLNkCJp1tuDjUZOR42WKRM14SOcUsPM6OXGiG0wiPdR
	 fhNRyyFr9pVnw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove no longer used btrfs_clone_chunk_map()
Date: Wed,  3 Apr 2024 13:05:48 +0100
Message-Id: <8274f4976218dc1186edabbfe22a6bd3e55b961a.1712145320.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712145320.git.fdmanana@suse.com>
References: <cover.1712145320.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are no more users of btrfs_clone_chunk_map(), the last one (and
only one ever) was removed in commit 1ec17ef59168 ("btrfs: zoned: fix
use-after-free in do_zone_finish()"). So remove btrfs_clone_chunk_map().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 15 ---------------
 fs/btrfs/volumes.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f15591f3e54f..a3dc88e420d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5614,21 +5614,6 @@ struct btrfs_chunk_map *btrfs_alloc_chunk_map(int num_stripes, gfp_t gfp)
 	return map;
 }
 
-struct btrfs_chunk_map *btrfs_clone_chunk_map(struct btrfs_chunk_map *map, gfp_t gfp)
-{
-	const int size = btrfs_chunk_map_size(map->num_stripes);
-	struct btrfs_chunk_map *clone;
-
-	clone = kmemdup(map, size, gfp);
-	if (!clone)
-		return NULL;
-
-	refcount_set(&clone->refs, 1);
-	RB_CLEAR_NODE(&clone->rb_node);
-
-	return clone;
-}
-
 static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 			struct alloc_chunk_ctl *ctl,
 			struct btrfs_device_info *devices_info)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 93854609a4d5..cf555f5b47ce 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -743,7 +743,6 @@ struct btrfs_chunk_map *btrfs_alloc_chunk_map(int num_stripes, gfp_t gfp);
 int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
 #endif
 
-struct btrfs_chunk_map *btrfs_clone_chunk_map(struct btrfs_chunk_map *map, gfp_t gfp);
 struct btrfs_chunk_map *btrfs_find_chunk_map(struct btrfs_fs_info *fs_info,
 					     u64 logical, u64 length);
 struct btrfs_chunk_map *btrfs_find_chunk_map_nolock(struct btrfs_fs_info *fs_info,
-- 
2.43.0



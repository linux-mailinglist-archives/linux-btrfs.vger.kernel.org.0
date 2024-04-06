Return-Path: <linux-btrfs+bounces-4001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C144089A9C8
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E894B224EB
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41175200DB;
	Sat,  6 Apr 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="roIBn4va"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83DEAD5
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712393189; cv=none; b=gGwxSgT0lcEcyWTwMxMBpfvOz61wVrHvAx5I7o21iRVOBdO8SA30ovORUwczFytxwG+NJGErPnMhGf96OJ7Sf1LGhPuyY6bZAXSvBjKkhKcNJJmSEOSObE56pdkBjkNdhvsFZHpT4M+oXX3+yQoyi4yuNONpt8dT9NQJ9ncDrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712393189; c=relaxed/simple;
	bh=oTUVMvZ4ytF1Lzl/HyS1qgfmemPpEGbwIWkrniX1vAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DN1JRbc5L+//lEtBIpoUChhjq+Bp8ACoVkHXzQVKt8fZBp0u8aAcvlUFZ5j6e6xMYcwRLO28dbI4SlKBaFu8OMnGDhOE4bFh63TManOuxgFIupRf8Dn35YHDkar9YScJ90fQPMCupgIFs1mxj2KGxnnZ/jgGJK14xZxebbTr0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=roIBn4va; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 396EE80449;
	Sat,  6 Apr 2024 04:46:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712393181; bh=oTUVMvZ4ytF1Lzl/HyS1qgfmemPpEGbwIWkrniX1vAI=;
	h=From:To:Cc:Subject:Date:From;
	b=roIBn4vaOb1da4wqoQQewKoRe82/WTZMYcD613jxp19u6DRLSi2iKa3IZUVbLckIR
	 CEsqb5VQQkrZwHmaBXSw5yZIkAIbjhF73Q1PubOGhz02YoDfgwdlyfqhemWMUxlp/z
	 ZqQ0CQyxlPejmIttvfinTpj2jXgymcOvh+t43zfog4pKcwsLFrQjFL0pjeVKRepgC2
	 gyuQ88MhU95jw3wEYFkf1V0g/46/XjOY6CPB0dadUN05wMyN8Md4dZy4FPqe4pWKqJ
	 4E1YZMRavfrWtskSfX6BzNGYUhrq3PTkzFH4V68XMtBsuwIWBuvRLaFEgYtz2v6g/k
	 Zpesw6mIUn95w==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	kernel-team@meta.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH] btrfs: fallback if compressed IO fails for ENOSPC
Date: Sat,  6 Apr 2024 04:45:02 -0400
Message-ID: <4607d44ee4cf72a302d3adeba5d0ae99518a5f36.1712391866.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b4ccace878f4 ("btrfs: refactor submit_compressed_extents()"), if
an async extent compressed but failed to find enough space, we changed
from falling back to an uncompressed write to just failing the write
altogether. The principle was that if there's not enough space to write
the compressed version of the data, there can't possibly be enough space
to write the larger, uncompressed version of the data.

However, this isn't necessarily true: due to fragmentation, there could
be enough discontiguous free blocks to write the uncompressed version,
but not enough contiguous free blocks to write the smaller but
unsplittable compressed version.

This has occurred to an internal workload which relied on write()'s
return value indicating there was space. While rare, it has happened a
few times.

Thus, in order to prevent early ENOSPC, re-add a fallback to
uncompressed writing.

Fixes: b4ccace878f4 ("btrfs: refactor submit_compressed_extents()")
Co-developed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/inode.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3442dedff53d..15a13e191ee7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1148,13 +1148,13 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				   0, *alloc_hint, &ins, 1, 1);
 	if (ret) {
 		/*
-		 * Here we used to try again by going back to non-compressed
-		 * path for ENOSPC.  But we can't reserve space even for
-		 * compressed size, how could it work for uncompressed size
-		 * which requires larger size?  So here we directly go error
-		 * path.
+		 * We can't reserve contiguous space for the compressed size.
+		 * Unlikely, but it's possible that we could have enough
+		 * non-contiguous space for the uncompressed size instead.  So
+		 * fall back to uncompressed.
 		 */
-		goto out_free;
+		submit_uncompressed_range(inode, async_extent, locked_page);
+		goto done;
 	}
 
 	/* Here we're doing allocation and writeback of the compressed pages */
@@ -1206,7 +1206,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
-out_free:
 	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
 	extent_clear_unlock_delalloc(inode, start, end,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
-- 
2.44.0



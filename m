Return-Path: <linux-btrfs+bounces-13677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B4AAA0E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B618840E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FCB2973B0;
	Mon,  5 May 2025 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDkFMbdG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42825296FD2;
	Mon,  5 May 2025 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483527; cv=none; b=TSNqOesvRzVUhIJm8UN51lPbELxENW31jCcU1g8ef6piBC+2mu/dbF+sHQ0/D2ccwEwVjjqhLzaSUH8nIC84v0VMk4cKENNfWinZj9Y/rBn4gnUHhJjaVOm53YoBReWcZxTrkz1PWcKAGSuojhE6NausI2gSAaHwwAXM90k1G5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483527; c=relaxed/simple;
	bh=GHDq27BxzT0Hze7a7nzpKDuR9W4ajvuTZDpqk2fNH64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCQvg9Y/cwc2+Oww3NzKnEzH1dV5MGNMMSKbCxxPvPGaEIRn8ukOA/ni8SGBa9c1HdUrCDdInUG+uDnp7kTnlhlE6Bq/vS314yqikd+twR1QS9SczcD9GPi54K2PATiKXUr+9HoVO64O+bxdxolyFboz1+yMIzfuW9puFaryd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDkFMbdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA5FC4CEE4;
	Mon,  5 May 2025 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483526;
	bh=GHDq27BxzT0Hze7a7nzpKDuR9W4ajvuTZDpqk2fNH64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDkFMbdG5SsKo/Fbm82k+CZmsB04Lu5jTWV59KyPn3XEWbamBitEuPzA3/rS+AUFN
	 /DCSq2ZTb2HkqquYuxfVa7AO9I4IQMp4NkmleSaktWymNMpFFFFGzKkmNssJM+p3uG
	 2bU2VZVa/5Gtq5/EsdDTlGSoXwn5P5/N+L5I87J39f7W/YWS7f2eP6SKXPqNVPaLIw
	 KQ3vh3T3ksZnVKM2fFWPHZQMgVRQt5ElnfMarPYDeaU77XVUV53f+EGjn8ro07k2hm
	 zpv0RZ7jXK59qAbObQNSkEpwMYY7AryYkyoUzbthlKR/Jnkot77Uj6Og0B2jtOMuNq
	 2ghGG6mJGsafw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 099/642] btrfs: prevent inline data extents read from touching blocks beyond its range
Date: Mon,  5 May 2025 18:05:15 -0400
Message-Id: <20250505221419.2672473-99-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 1a5b5668d711d3d1ef447446beab920826decec3 ]

Currently reading an inline data extent will zero out the remaining
range in the page.

This is not yet causing problems even for block size < page size
(subpage) cases because:

1) An inline data extent always starts at file offset 0
   Meaning at page read, we always read the inline extent first, before
   any other blocks in the page. Then later blocks are properly read out
   and re-fill the zeroed out ranges.

2) Currently btrfs will read out the whole page if a buffered write is
   not page aligned
   So a page is either fully uptodate at buffered write time (covers the
   whole page), or we will read out the whole page first.
   Meaning there is nothing to lose for such an inline extent read.

But it's still not ideal:

- We're zeroing out the page twice
  Once done by read_inline_extent()/uncompress_inline(), once done by
  btrfs_do_readpage() for ranges beyond i_size.

- We're touching blocks that don't belong to the inline extent
  In the incoming patches, we can have a partial uptodate folio, of
  which some dirty blocks can exist while the page is not fully uptodate:

  The page size is 16K and block size is 4K:

  0         4K        8K        12K        16K
  |         |         |/////////|          |

  And range [8K, 12K) is dirtied by a buffered write, the remaining
  blocks are not uptodate.

  If range [0, 4K) contains an inline data extent, and we try to read
  the whole page, the current behavior will overwrite range [8K, 12K)
  with zero and cause data loss.

So to make the behavior more consistent and in preparation for future
changes, limit the inline data extents read to only zero out the range
inside the first block, not the whole page.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3dcf9a428b2b4..c11d0a8e5b06d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6768,6 +6768,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 {
 	int ret;
 	struct extent_buffer *leaf = path->nodes[0];
+	const u32 blocksize = leaf->fs_info->sectorsize;
 	char *tmp;
 	size_t max_size;
 	unsigned long inline_size;
@@ -6784,7 +6785,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
-	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
+	max_size = min_t(unsigned long, blocksize, max_size);
 	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
 			       max_size);
 
@@ -6796,14 +6797,15 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size < PAGE_SIZE)
-		folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
+	if (max_size < blocksize)
+		folio_zero_range(folio, max_size, blocksize - max_size);
 	kfree(tmp);
 	return ret;
 }
 
 static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 {
+	const u32 blocksize = path->nodes[0]->fs_info->sectorsize;
 	struct btrfs_file_extent_item *fi;
 	void *kaddr;
 	size_t copy_size;
@@ -6818,14 +6820,14 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
 		return uncompress_inline(path, folio, fi);
 
-	copy_size = min_t(u64, PAGE_SIZE,
+	copy_size = min_t(u64, blocksize,
 			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
 	kaddr = kmap_local_folio(folio, 0);
 	read_extent_buffer(path->nodes[0], kaddr,
 			   btrfs_file_extent_inline_start(fi), copy_size);
 	kunmap_local(kaddr);
-	if (copy_size < PAGE_SIZE)
-		folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size);
+	if (copy_size < blocksize)
+		folio_zero_range(folio, copy_size, blocksize - copy_size);
 	return 0;
 }
 
-- 
2.39.5



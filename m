Return-Path: <linux-btrfs+bounces-20330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F8D09D5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F11F530325BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4635A933;
	Fri,  9 Jan 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3zPrWbA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3D359FA0
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961797; cv=none; b=rayZ/aFst060xJZtYCtMSqizJDFT5ocQeMLIGrFMHe3QcAjVuT81dLeSd9jrrvJnc1yxaelNFLoF6LopQBLcshokhmPqaVOOOvPxM1U1CrwhmLppYzE9IUDzRY7932ireHxTPPsQ06PJOaLX01vpnqCkaBronQbN2n9lx8poFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961797; c=relaxed/simple;
	bh=QyQp+Kwh1jLfIjnSJSIepflb8qx/bs8rTQcFLFNVLOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frffh10wAJP6k9/VR+zeHd3kPehbc6KJ51KqY/zh23AD9XreUH6xWc6GDT3AMaMQ8Bu+BB1oSSLNVxerIjJw+Xb2bpbuVvNVjm3nr0MV0COzAnuMVmxWEWSf9mgdDH8AXihnrilfBI8DgSfnm7DZmSWoyIIxi/UNNSj3k6w+ugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3zPrWbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A771BC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767961797;
	bh=QyQp+Kwh1jLfIjnSJSIepflb8qx/bs8rTQcFLFNVLOM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o3zPrWbATH/etF3+vF867KobQsQsyoBcCOyHE9UcZmQHUNCZ2mRjzVT+7jonE3P2p
	 QG3kHBcgcpWgNn6p0VvHWwbZKkOB87fRUen1YKztynN4L9zm5AyogMI3T6sKM6eCn+
	 2wTwABB+P5DNw8sJd5LqQtnL7vX4ogj27A+kFsSwCPoqyhmzJNJ143dlmcffM5Jypd
	 nBBEwJWz0qvFhOnRZJvHZhGH7zK1yvbGYZeyRiOEmu1+czH4K6G/fov5YJAr9d7C6m
	 HaRqDd4nZf28VDbROPzbk4KBvlcchMR2VT/2acjEt5aj1OmnApy1X/aVV516mlogX1
	 9DxgoGFRChhBA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: invalidate pages instead of truncate after reflinking
Date: Fri,  9 Jan 2026 12:29:50 +0000
Message-ID: <91292893f805261c8bd972d039785b74bbb3abee.1767960735.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1767960735.git.fdmanana@suse.com>
References: <cover.1767960735.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Qu reported that generic/164 often fails because the read operations get
zeroes when it expects to either get all bytes with a value of 0x61 or
0x62. The issue stems from truncating the pages from the page cache
instead of invalidating, as truncating can zero page contents. This
zeroing is not just in case the range is not page sized (as it's commented
in truncate_inode_pages_range()) but also in case we are using large
folios, they need to be split and the splitting fails. Stealing Qu's
comment in the thread linked below:

  "We can have the following case:

	0          4K         8K         12K          16K
        |          |          |          |            |
        |<---- Extent A ----->|<----- Extent B ------>|

   The page size is still 4K, but the folio we got is 16K.

   Then if we remap the range for [8K, 16K), then
   truncate_inode_pages_range() will get the large folio 0 sized 16K,
   then call truncate_inode_partial_folio().

   Which later calls folio_zero_range() for the [8K, 16K) range first,
   then tries to split the folio into smaller ones to properly drop them
   from the cache.

   But if splitting failed (e.g. racing with other operations holding the
   filemap lock), the partially zeroed large folio will be kept, resulting
   the range [8K, 16K) being zeroed meanwhile the folio is still a 16K
   sized large one."

So instead of truncating, invalidate the page cache range with a call to
filemap_invalidate_inode(), which besides not doing any zeroing also
ensures that while it's invalidating folios, no new folios are added.

This helps ensure that buffered reads that happen while a reflink
operation is in progress always get either the whole old data (the one
before the reflink) or the whole new data, which is what generic/164
expects.

Link: https://lore.kernel.org/linux-btrfs/7fb9b44f-9680-4c22-a47f-6648cb109ddf@suse.com/
Reported-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e746980567da..ab4ce56d69ee 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	struct inode *src = file_inode(file_src);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	int ret;
-	int wb_ret;
 	u64 len = olen;
 	u64 bs = fs_info->sectorsize;
 	u64 end;
@@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
 	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * We may have copied an inline extent into a page of the destination
-	 * range, so wait for writeback to complete before truncating pages
+	 * range, so wait for writeback to complete before invalidating pages
 	 * from the page cache. This is a rare case.
 	 */
-	wb_ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
-	ret = ret ? ret : wb_ret;
+	ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
+	if (ret < 0)
+		return ret;
+
 	/*
-	 * Truncate page cache pages so that future reads will see the cloned
-	 * data immediately and not the previous data.
+	 * Invalidate page cache so that future reads will see the cloned data
+	 * immediately and not the previous data.
 	 */
-	truncate_inode_pages_range(&inode->i_data,
-				round_down(destoff, PAGE_SIZE),
-				round_up(destoff + len, PAGE_SIZE) - 1);
+	ret = filemap_invalidate_inode(inode, false, destoff, end);
+	if (ret < 0)
+		return ret;
 
 	btrfs_btree_balance_dirty(fs_info);
 
-	return ret;
+	return 0;
 }
 
 static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
-- 
2.47.2



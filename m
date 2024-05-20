Return-Path: <linux-btrfs+bounces-5105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A4D8C9AA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CA11C21AA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69734E1A2;
	Mon, 20 May 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhE57jjt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505C4D9E7
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198419; cv=none; b=lSKyVmZUxFycVcYaknspeC512le+SjHySoBckJg8tKpsKYEQBHjvg77ErIU6FZ1jKwmpaalt/xKFXeRAhaVINZQ9XIUufPOgNUO4pfVoZq1UcExO/spR8Kpd0GI5NZOIx/MUxpG4miDa+fupbLUZxf74Vaca77/X2/SlAe9ryQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198419; c=relaxed/simple;
	bh=+LGz3X+eqO7HNkmzpOfkwpApdXXtLILRqNWctX63o9s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXyF11z8XjK4LYZ6WgK59CmrWB7ZyvahEAMn/bdBX7iXAc5tEIxqmeWbeUy262xMVBUWP9ETS8cOXF4SlRIpS2SyM6HSvl2HWeRMHHYuvmmrhIIEMuE9809ndYVHl3+F1fWdQ1QYMVTFfA0kne8YadGJXizKKeeOnMNAG4K1TBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhE57jjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB2CC4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198418;
	bh=+LGz3X+eqO7HNkmzpOfkwpApdXXtLILRqNWctX63o9s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bhE57jjt9XCas3qObXdFMJLZsRSOEVkX/nZy43lCZBDRj547zwcOyoz9HgfXHmEKa
	 FFVQexLKKtBZDbzgVNPWpzjsSj46ng5SK9C+olOBKu/5vIUJQY5DZkP9lVFkPl+/Jq
	 fnYocM0OjLoqttSi+DAtnewRVVjKUY7Oc4623FZpkmuZk0yqvGOCajDTrxtxHqAPIZ
	 yCp0c7czmTBhWOLFaUAGQdRQ+5XyxlBFXXgVeVPKf05G5Ns4geaqP7ucdrmG4bdOiU
	 YFNpHGCSpBajokWW9T5vDLIaNRQyGPJljonmhgLtm4x3MTg8n4gpR8Xcw/DHdfTS/R
	 yzFs2BeUi9Bvw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 4/6] btrfs: pass a btrfs_inode to btrfs_fdatawrite_range()
Date: Mon, 20 May 2024 10:46:49 +0100
Message-Id: <3b6b8932697de0ecea770e590531fd1cdaa8410a.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
References: <cover.1716053516.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing a (VFS) inode pointer argument, pass a btrfs_inode
instead, as this is generally what we do for internal APIs, making it
more consistent with most of the code base. This will later allow to
help to remove a lot of BTRFS_I() calls in btrfs_sync_file().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c             | 18 +++++++++---------
 fs/btrfs/file.h             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/ordered-data.c     |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 506eabcd809d..23c5510f6271 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1625,7 +1625,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * able to read what was just written.
 	 */
 	endbyte = pos + written_buffered - 1;
-	ret = btrfs_fdatawrite_range(inode, pos, endbyte);
+	ret = btrfs_fdatawrite_range(BTRFS_I(inode), pos, endbyte);
 	if (ret)
 		goto out;
 	ret = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
@@ -1738,7 +1738,7 @@ int btrfs_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end)
+static int start_ordered_ops(struct btrfs_inode *inode, loff_t start, loff_t end)
 {
 	int ret;
 	struct blk_plug plug;
@@ -1825,7 +1825,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * multi-task, and make the performance up.  See
 	 * btrfs_wait_ordered_range for an explanation of the ASYNC check.
 	 */
-	ret = start_ordered_ops(inode, start, end);
+	ret = start_ordered_ops(BTRFS_I(inode), start, end);
 	if (ret)
 		goto out;
 
@@ -1851,7 +1851,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * So trigger writeback for any eventual new dirty pages and then we
 	 * wait for all ordered extents to complete below.
 	 */
-	ret = start_ordered_ops(inode, start, end);
+	ret = start_ordered_ops(BTRFS_I(inode), start, end);
 	if (ret) {
 		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
 		goto out;
@@ -4045,8 +4045,9 @@ const struct file_operations btrfs_file_operations = {
 	.remap_file_range = btrfs_remap_file_range,
 };
 
-int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end)
+int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end)
 {
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	int ret;
 
 	/*
@@ -4063,10 +4064,9 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end)
 	 * know better and pull this out at some point in the future, it is
 	 * right and you are wrong.
 	 */
-	ret = filemap_fdatawrite_range(inode->i_mapping, start, end);
-	if (!ret && test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-			     &BTRFS_I(inode)->runtime_flags))
-		ret = filemap_fdatawrite_range(inode->i_mapping, start, end);
+	ret = filemap_fdatawrite_range(mapping, start, end);
+	if (!ret && test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags))
+		ret = filemap_fdatawrite_range(mapping, start, end);
 
 	return ret;
 }
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 77aaca208c7b..ce93ed7083ab 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -37,7 +37,7 @@ int btrfs_release_file(struct inode *inode, struct file *file);
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached, bool noreserve);
-int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
+int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end);
 int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait);
 void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c8a05d5eb9cb..e6d599efd713 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1483,7 +1483,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	io_ctl->entries = entries;
 	io_ctl->bitmaps = bitmaps;
 
-	ret = btrfs_fdatawrite_range(inode, 0, (u64)-1);
+	ret = btrfs_fdatawrite_range(BTRFS_I(inode), 0, (u64)-1);
 	if (ret)
 		goto out;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 16f9ddd2831c..605d88e09525 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -859,7 +859,7 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 	/* start IO across the range first to instantiate any delalloc
 	 * extents
 	 */
-	ret = btrfs_fdatawrite_range(inode, start, orig_end);
+	ret = btrfs_fdatawrite_range(BTRFS_I(inode), start, orig_end);
 	if (ret)
 		return ret;
 
-- 
2.43.0



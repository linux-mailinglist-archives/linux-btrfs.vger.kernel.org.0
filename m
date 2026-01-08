Return-Path: <linux-btrfs+bounces-20251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C455D054C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 761F43176DD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280832BD5B4;
	Thu,  8 Jan 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLFtV/b1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DF29D291
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892209; cv=none; b=WN1NS2mOxTeJzUofrT7nqMoVC9EzPdbxT+FRo6QAe7lUDSpaLBZI7IK6Ju7tk1vhxZCpT1lMlIWvWUvVKaIjvf/BTksLJz5HwSRLLAfe7rMivfz84iB17+vo7KZzIAfjnqUWuXFT2gMfNwiOMA7O0TWfugzbZyfDntV7QGqZfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892209; c=relaxed/simple;
	bh=GUTvevid4lnqLJD9khEp8ETE2PNpZrAeIP3/jddG5dE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N7bkfEFznhtpp5px7dV9B5tLmAvQEW2xM3a27Bt03OUVFuMdgt8MIwR1VWd+IKfhR4h/scCcbrHKD+xYpH3Nfa02zolHUG1tLS7RyLV52ZAjyuwywwZUZlpH6cKShwT4Oy77n2HKWPV5UKgPGMzA0fhcvRVCxrtN6ElBLrSoLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLFtV/b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB90BC19422
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892208;
	bh=GUTvevid4lnqLJD9khEp8ETE2PNpZrAeIP3/jddG5dE=;
	h=From:To:Subject:Date:From;
	b=FLFtV/b1lTXVNp2Xc2Iah5RmemE5Jc+TepYJWSbXvA6luq1ElZhrbpNuiGQG3az6B
	 zgZ7YPHu+5ZPePoFwUNHy4nFFsY7euRYL3Zzlzh6a6w9siQlebco3gJX8WmHoNQxWz
	 fUbLrmaWRxGIZRj7ZBDNtbsqYBsd8D5B/7ziBlaAqKeVVN/Ui6JDnaaHcWUqr32YKn
	 OcgbQyF8tOUJi7DShmfXZam2MM5b6YU6rJq5FxX6dmkN45T778ifYwXzFXloffoHjz
	 Ok5pmlg1pObglynuj07uKKwvJtIkoymbQy7oj2O7fmvU4Vc0w1SzlIkc4mZX8AxpN4
	 dzcObRcf1M28w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: invalidate pages instead of truncate after reflinking
Date: Thu,  8 Jan 2026 17:10:04 +0000
Message-ID: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
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
instead of invalidating, as truncating can zero page contents.

So instead of truncating, invalidate the page cache range with a call to
filemap_invalidate_inode(), which besides not doing any zeroing also
ensures that while it's invalidating folios, no new folios are added.
This helps ensure that buffered reads that happen while a reflink
operation is in progress always get either the whole old data (the one
before the reflink) or the whole new data, which is what generic/164
expects.

Reported-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e746980567da..f7ddd3765249 100644
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
 	 * range, so wait for writeback to complete before truncating pages
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



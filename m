Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78182A62E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKDLHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 06:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgKDLHl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 06:07:41 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F66B223C7
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604488060;
        bh=pAifiHXZySY+a2w7pF1bPDAWqQ5FGtejg95ftrDRsjo=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=uWDpdaq8rNMiAN4mtpOUFBKiBGIeOyXTJJqFijhSa8hQChrLzqIDLJMpsqGHuWowj
         0EP4uuplL03+u+7kIrFRYjTRyRdqcYUgWC9PahqX5T5FHCEE2N2zSwrcy2fIpfS57f
         5sa1gGEBAV4OKaAKPbQXL/10FdHaShgNPx1oKwQI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: fix race when defragging that leads to unnecessary IO
Date:   Wed,  4 Nov 2020 11:07:33 +0000
Message-Id: <a812a90e50fd792ee8a2e7adff2f588bf8f9b047.1604486892.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
References: <cover.1604486892.git.fdmanana@suse.com>
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
References: <cover.1604486892.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When defragging we skip ranges that have holes or inline extents, so that
we don't do unnecessary IO and waste space. We do this check when calling
should_defrag_range() at btrfs_defrag_file(). However we do it without
holding the inode's lock. The reason we do it like this is to avoid
blocking other tasks for too long, that possibly want to operate on other
file ranges, since after the call to should_defrag_range() and before
locking the inode, we trigger a synchronous page cache readahead. However
before we were able to lock the inode, some other task might have punched
a hole in our range, or we may now have an inline extent there, in which
case we should not set the range for defrag anymore since that would cause
unnecessary IO and make us waste space (i.e. allocating extents to contain
zeros for a hole).

So after we locked the inode and the range in the iotree, check again if
we have holes or an inline extent, and if we do, just skip the range.

I hit this while testing my next patch that fixes races when updating an
inode's number of bytes (subject "btrfs: update the number of bytes used
by an inode atomically"), and it depends on this change in order to work
correctly. Alternatively I could rework that other patch to detect holes
and flag their range with the 'new delalloc' bit, but this itself fixes
an efficiency problem due a race that from a functional point of view is
not harmful (it could be triggered with btrfs/062 from fstests).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69a384145dc6..7c44aa277e93 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1275,6 +1275,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	u64 page_end;
 	u64 page_cnt;
 	u64 start = (u64)start_index << PAGE_SHIFT;
+	u64 search_start;
 	int ret;
 	int i;
 	int i_done;
@@ -1371,6 +1372,40 @@ static int cluster_pages_for_defrag(struct inode *inode,
 
 	lock_extent_bits(&BTRFS_I(inode)->io_tree,
 			 page_start, page_end - 1, &cached_state);
+
+	/*
+	 * When defragging we skip ranges that have holes or inline extents,
+	 * (check should_defrag_range()), to avoid unnecessary IO and wasting
+	 * space. At btrfs_defrag_file(), we check if a range should be defragged
+	 * before locking the inode and then, if it should, we trigger a sync
+	 * page cache readahead - we lock the inode only after that to avoid
+	 * blocking for too long other tasks that possibly want to operate on
+	 * other file ranges. But before we were able to get the inode lock,
+	 * some other task may have punched a hole in the range, or we may have
+	 * now an inline extent, in which case we should not defrag. So check
+	 * for that here, where we have the inode and the range locked, and bail
+	 + out if that happened.
+	 */
+	search_start = page_start;
+	while (search_start < page_end) {
+		struct extent_map *em;
+
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, search_start,
+				      page_end - search_start);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto out_unlock_range;
+		}
+		if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
+			free_extent_map(em);
+			/* Ok, 0 means we did not defrag anything. */
+			ret = 0;
+			goto out_unlock_range;
+		}
+		search_start = extent_map_end(em);
+		free_extent_map(em);
+	}
+
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start,
 			  page_end - 1, EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			  EXTENT_DEFRAG, 0, 0, &cached_state);
@@ -1401,6 +1436,10 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	btrfs_delalloc_release_extents(BTRFS_I(inode), page_cnt << PAGE_SHIFT);
 	extent_changeset_free(data_reserved);
 	return i_done;
+
+out_unlock_range:
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+			     page_start, page_end - 1, &cached_state);
 out:
 	for (i = 0; i < i_done; i++) {
 		unlock_page(pages[i]);
-- 
2.28.0


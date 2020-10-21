Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254C0294851
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440842AbgJUG2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:44598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408802AbgJUG2B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUouxSvb0OqwwI1yfTd5VmIiA/R20YUcjnuNaFs3tHc=;
        b=WNqxVjlQQa74OUIR+9YwNEVS+WlXiNgxdwrWu0QM7iyKMlzPQQmtbUDP7/FaWWU8ey8rZ6
        7rdnhZ6MuQEa7oK9DtxVXoArmvH/h4EdBeuUm/0htnS0dXg90JUQjIPN7hjdRy+oCcNElq
        T8RqfDO6FK+Towgek6lab8Ph3uyznTA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07E82AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 53/68] btrfs: inode: make can_nocow_extent() check only return 1 if the range is no smaller than PAGE_SIZE
Date:   Wed, 21 Oct 2020 14:25:39 +0800
Message-Id: <20201021062554.68132-54-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage, we can still get sector aligned extent mapper, thus it
could lead to the following case:

0	16K	32K	48K	64K
|///////|			|
    |		\- Hole
    \- NODATACOW extent

If we want to dirty page range [0, 64K) for new write, and we need to
check the nocow status, can_nocow_extent() would return 1, with length
16K.

But for current subpage data write support, we can only write a full
page, but the range [16K, 64K) is hole where writes must be COWed.

To solve the problem, just make can_nocow_extent() do extra returned
length check.
If the result is smaller than one page, we return 0.

This behavior change won't affect regular sector size support since in
that case num_bytes should already be page aligned.

Also modify the callers to always pass page aligned offset for subpage
support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c  |  7 +++----
 fs/btrfs/inode.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d3766d2bb8d6..a2009127ef96 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1535,8 +1535,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
+	u32 blocksize = PAGE_SIZE;
 	u64 lockstart, lockend;
 	u64 num_bytes;
 	int ret;
@@ -1547,9 +1547,8 @@ static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	if (!nowait && !btrfs_drew_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
-	lockstart = round_down(pos, fs_info->sectorsize);
-	lockend = round_up(pos + *write_bytes,
-			   fs_info->sectorsize) - 1;
+	lockstart = round_down(pos, blocksize);
+	lockend = round_up(pos + *write_bytes, blocksize) - 1;
 	num_bytes = lockend - lockstart + 1;
 
 	if (nowait) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f22ee5d3c105..8551815c4d65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7006,6 +7006,11 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	int found_type;
 	bool nocow = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW);
 
+	/*
+	 * We should only do full page write even for subpage. Thus the offset
+	 * should always be page aligned.
+	 */
+	ASSERT(IS_ALIGNED(offset, PAGE_SIZE));
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -7121,6 +7126,16 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	disk_bytenr += offset - key.offset;
 	if (csum_exist_in_range(fs_info, disk_bytenr, num_bytes))
 		goto out;
+
+	/*
+	 * If the nocow range is smaller than one page, it doesn't make any
+	 * sense for subpage case, as we can only submit full page write yet.
+	 */
+	if (num_bytes < PAGE_SIZE) {
+		ret = 0;
+		goto out;
+	}
+
 	/*
 	 * all of the above have passed, it is safe to overwrite this extent
 	 * without cow
-- 
2.28.0


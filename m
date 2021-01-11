Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77712F10B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbhAKK7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 05:59:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:34456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbhAKK7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 05:59:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610362694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YoNCE+1BmQlHL5Tv9Xb58anQKfY89tW9FqyGgC63WIU=;
        b=mXC1FXrxDg4mTMZ9nkWQVraszlxqfGXc/otiFgdczTlBpmPuG654Duhw3BOP33QNrDSmxp
        fdSq8mc3+MPV3qkn8Kf0fv/63fozsRKN7wUO6JrnY9IKiHfNqNWsliWWmYbWj7F0VJ7q98
        kgGSQ+l5gM83tvXWq5zhcnTqW5IbpEQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51CB0ACBA;
        Mon, 11 Jan 2021 10:58:14 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Make btrfs_start_delalloc_root's nr argument a long
Date:   Mon, 11 Jan 2021 12:58:11 +0200
Message-Id: <20210111105812.423915-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's currently u64 which gets instantly translated either to LONG_MAX
(if U64_MAX is passed) or casted to an unsigned long (which is in fact,
wrong because iwriteback_control::nr_to_write is a signed, long type).

Just convert the function's argument to be long time which obviates the
need to manually convert u64 value to a long. Adjust all call sites
which pass U64_MAX to pass LONG_MAX. Finally ensure that in
shrink_delalloc the u64 is converted to a long without overflowing,
resulting in a negative number.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
David,

Here are 2 patches which I believe should be folded into
"btrfs: shrink delalloc pages instead of full inodes" so as to avoid needless
casts and a possible overflow, resulting in negative nr_to_write value.

 fs/btrfs/ctree.h       | 2 +-
 fs/btrfs/dev-replace.c | 2 +-
 fs/btrfs/inode.c       | 6 +++---
 fs/btrfs/ioctl.c       | 2 +-
 fs/btrfs/space-info.c  | 3 ++-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 05f009fbbd55..3dc67f241919 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3101,7 +3101,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       u32 min_type);

 int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 			       bool in_reclaim_context);
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 324f646d6e5e..bc73f798ce3a 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -715,7 +715,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	 * flush all outstanding I/O and inode extent mappings before the
 	 * copy operation is declared as being finished
 	 */
-	ret = btrfs_start_delalloc_roots(fs_info, U64_MAX, false);
+	ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
 	if (ret) {
 		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5c173a30a97a..69e24341afc0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9474,11 +9474,11 @@ int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
 	return start_delalloc_inodes(root, &wbc, true, false);
 }

-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 			       bool in_reclaim_context)
 {
 	struct writeback_control wbc = {
-		.nr_to_write = (nr == U64_MAX) ? LONG_MAX : (unsigned long)nr,
+		.nr_to_write = nr,
 		.sync_mode = WB_SYNC_NONE,
 		.range_start = 0,
 		.range_end = LLONG_MAX,
@@ -9500,7 +9500,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
 		 * Reset nr_to_write here so we know that we're doing a full
 		 * flush.
 		 */
-		if (nr == U64_MAX)
+		if (nr == LONG_MAX)
 			wbc.nr_to_write = LONG_MAX;

 		root = list_first_entry(&splice, struct btrfs_root,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index db29c1b54daa..998ea561d934 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4973,7 +4973,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SYNC: {
 		int ret;

-		ret = btrfs_start_delalloc_roots(fs_info, U64_MAX, false);
+		ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
 		if (ret)
 			return ret;
 		ret = btrfs_sync_fs(inode->i_sb, 1);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e8347461c8dd..84fb94e78a8f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -532,7 +532,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,

 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		u64 nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
+		u64 temp = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
+		long nr_pages = min_t(u64, temp, LONG_MAX);

 		btrfs_start_delalloc_roots(fs_info, nr_pages, true);

--
2.25.1


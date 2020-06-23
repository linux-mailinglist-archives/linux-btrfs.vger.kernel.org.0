Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43F206845
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgFWXYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 19:24:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388094AbgFWXYC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 19:24:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13ADEAECE
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 23:24:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 2/3] btrfs: add comments for btrfs_check_can_nocow() and can_nocow_extent()
Date:   Wed, 24 Jun 2020 07:23:51 +0800
Message-Id: <20200623232352.668681-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623232352.668681-1-wqu@suse.com>
References: <20200623232352.668681-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two functions have extra conditions that their callers need to
meet, and some not-that-common parameters used for return value.

So adding some comments may save reviewers some time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c  | 21 +++++++++++++++++++++
 fs/btrfs/inode.c | 21 +++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0115ef7f7943..2bee888cb929 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1533,6 +1533,27 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
+/*
+ * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
+ *
+ * @pos:	 File offset
+ * @write_bytes: The length to write, will be updated to the nocow writeable
+ *		 range
+ * @nowait:	 Whether this function could sleep.
+ *
+ * This function will flush ordered extents in the range to ensure proper
+ * nocow checks for (nowait == false) case.
+ *
+ * Return:
+ * >0 and update @write_bytes if we can do nocow write.
+ * 0 if we can't do nocow write.
+ * -EAGAIN if we can't get the needed lock or there are ordered extents for
+ * (nowait == true) case.
+ * <0 if other error happened.
+ *
+ * NOTE: For wait (nowait==false) calls, callers need to release the drew write
+ * 	 lock of inode->root->snapshot_lock when return value > 0.
+ */
 int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			  size_t *write_bytes, bool nowait)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9d9ec7838f13..339d739b2d29 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6952,8 +6952,25 @@ static struct extent_map *btrfs_new_extent_direct(struct inode *inode,
 }
 
 /*
- * returns 1 when the nocow is safe, < 1 on error, 0 if the
- * block must be cow'd
+ * Check if we can do nocow write into the range [@offset, @offset+ @len)
+ *
+ * @offset:	File offset
+ * @len:	The length to write, will be updated to the nocow writeable
+ *		range
+ * @orig_start:	(Optional) Return the original file offset of the file extent
+ * @orig_len:	(Optional) Return the original on-disk length of the file extent
+ * @ram_bytes:	(Optional) Return the ram_bytes of the file extent
+ *
+ * This function will flush ordered extents in the range to ensure proper
+ * nocow checks for (nowait == false) case.
+ *
+ * Return:
+ * >0 and update @len if we can do nocow write.
+ * 0 if we can't do nocow write.
+ * <0 if error happened.
+ *
+ * NOTE: This only checks the file extents, caller is responsible to wait for
+ *	 any ordered extents.
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-- 
2.27.0


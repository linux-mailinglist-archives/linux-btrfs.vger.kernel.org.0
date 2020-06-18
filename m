Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB01FECD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgFRHt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 03:49:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:35866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRHt6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 03:49:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E2EC7ABF4
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 07:49:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and can_nocow_extent()
Date:   Thu, 18 Jun 2020 15:49:48 +0800
Message-Id: <20200618074950.136553-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618074950.136553-1-wqu@suse.com>
References: <20200618074950.136553-1-wqu@suse.com>
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
 fs/btrfs/file.c  | 19 +++++++++++++++++++
 fs/btrfs/inode.c | 19 +++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fccf5862cd3e..0e4f57fb2737 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1533,6 +1533,25 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
+/*
+ * Check if we can do nocow write into the range [@pos, @pos + @write_bytes)
+ *
+ * This function will flush ordered extents in the range to ensure proper
+ * nocow checks for (nowait == false) case.
+ *
+ * Return >0 and update @write_bytes if we can do nocow write into the range.
+ * Return 0 if we can't do nocow write.
+ * Return -EAGAIN if we can't get the needed lock, or for (nowait == true) case,
+ * there are ordered extents need to be flushed.
+ * Return <0 for if other error happened.
+ *
+ * NOTE: For wait (nowait==false) calls, callers need to release the drew write
+ * 	 lock of inode->root->snapshot_lock if return value > 0.
+ *
+ * @pos:	 File offset of the range
+ * @write_bytes: The length of the range to check, also contains the nocow
+ * 		 writable length if we can do nocow write
+ */
 static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 				    size_t *write_bytes, bool nowait)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 86f7aa377da9..48e16eae7278 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6922,8 +6922,23 @@ static struct extent_map *btrfs_new_extent_direct(struct inode *inode,
 }
 
 /*
- * returns 1 when the nocow is safe, < 1 on error, 0 if the
- * block must be cow'd
+ * Check if we can write into [@offset, @offset + @len) of @inode.
+ *
+ * Return >0 and update @len if we can do nocow write into [@offset, @offset +
+ * @len).
+ * Return 0 if we can't do nocow write.
+ * Return <0 if error happened.
+ *
+ * NOTE: This only checks the file extents, caller is responsible to wait for
+ *	 any ordered extents.
+ *
+ * @offset:	File offset
+ * @len:	The length to write, will be updated to the nocow writable
+ * 		range
+ *
+ * @orig_start:	(Optional) Return the original file offset of the file extent
+ * @orig_len:	(Optional) Return the original on-disk length of the file extent
+ * @ram_bytes:	(Optional) Return the ram_bytes of the file extent
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-- 
2.27.0


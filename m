Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1E3FC9C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhHaObp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237525AbhHaObn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 160CC600AA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420248;
        bh=qTX3sTdeSoggig5qmyMStuT6ZzALgUBoMQqd5lKEDb0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z3jNRfSIc0GKfMTYgfHZLqQDPdbdUjQnlkch0q0zMEbirvdumSd83KkvC4y/1zJ3Q
         EazoscTwBr5h6fteMmcNkwt3y8c3tI9EkWZW1fprIF+lj8xuYpZhEptW55sVJ1cs5u
         Xg1d+g35aqa92jWDESpaaoYUD1glthMWMzAMc5gF0zL8XPCoIV7yZkPdirT/5pxWJH
         IpBu0HCM2EfEAFyiDBwsj90Aw3l4ZumlwIEzITxoURN5AOJLGwkdO+r/d+B42GTl0i
         f5tMOL9w2NBPQIa3BG5+qN0CxSWFgWcBmQ0W4WJ1cqKwdi+ghpvRs1F3K6VuBlJSeT
         1T24+bBoLABUw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: add helper to truncate inode items when logging inode
Date:   Tue, 31 Aug 2021 15:30:36 +0100
Message-Id: <aac5bf126fb17f697b2e4be81b1103556facee5d.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Move the call to btrfs_truncate_inode_items(), and the surrounding retry
loop, into a local helper function. This avoids some repetition and avoids
making the next change a bit awkward due to a bit of too much indentation.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 6/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d4f04b2d74ba..3abd11a0beda 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3920,6 +3920,21 @@ static int drop_inode_items(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int truncate_inode_items(struct btrfs_trans_handle *trans,
+				struct btrfs_root *log_root,
+				struct btrfs_inode *inode,
+				u64 new_size, u32 min_type)
+{
+	int ret;
+
+	do {
+		ret = btrfs_truncate_inode_items(trans, log_root, inode,
+						 new_size, min_type, NULL);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 static void fill_inode_item(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *leaf,
 			    struct btrfs_inode_item *item,
@@ -4508,13 +4523,9 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			 * Avoid logging extent items logged in past fsync calls
 			 * and leading to duplicate keys in the log tree.
 			 */
-			do {
-				ret = btrfs_truncate_inode_items(trans,
-							 root->log_root,
-							 inode, truncate_offset,
-							 BTRFS_EXTENT_DATA_KEY,
-							 NULL);
-			} while (ret == -EAGAIN);
+			ret = truncate_inode_items(trans, root->log_root, inode,
+						   truncate_offset,
+						   BTRFS_EXTENT_DATA_KEY);
 			if (ret)
 				goto out;
 			dropped_extents = true;
@@ -5460,12 +5471,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 					  &inode->runtime_flags);
 				clear_bit(BTRFS_INODE_COPY_EVERYTHING,
 					  &inode->runtime_flags);
-				while(1) {
-					ret = btrfs_truncate_inode_items(trans,
-						log, inode, 0, 0, NULL);
-					if (ret != -EAGAIN)
-						break;
-				}
+				ret = truncate_inode_items(trans, log, inode, 0, 0);
 			}
 		} else if (test_and_clear_bit(BTRFS_INODE_COPY_EVERYTHING,
 					      &inode->runtime_flags) ||
-- 
2.28.0


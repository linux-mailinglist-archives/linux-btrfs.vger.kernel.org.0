Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2B142CDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgATOJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:49052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgATOJX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4F94FB166;
        Mon, 20 Jan 2020 14:09:21 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/11] btrfs: Call btrfs_pin_reserved_extent only during active transaction
Date:   Mon, 20 Jan 2020 16:09:11 +0200
Message-Id: <20200120140918.15647-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Calling btrfs_pin_reserved_extent makes sense only with a valid
transaction since pinned extents are processed from transaction commit
in btrfs_finish_extent_commit. In case of error it's sufficient to
adjust the reserved counter to account for log tree extents allocated in
the last transaction.

This commit moves btrfs_pin_reserved_extent to be called only with
valid transaction handle and otherwise uses the newly introduced
unaccount_log_buffer to adjust "reserved". If this is not done if a
failure occurs before transaction is committed WARN_ON are going to
be triggered on unmount. This was especially pronounced with generic/475
test.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 30e7d96a69fe..4c550579e621 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2743,18 +2743,16 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+					ret = btrfs_pin_reserved_extent(fs_info,
+								bytenr, blocksize);
+					if (ret) {
+						free_extent_buffer(next);
+						return ret;
+					}
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
-				}
-
-				WARN_ON(root_owner !=
-					BTRFS_TREE_LOG_OBJECTID);
-				ret = btrfs_pin_reserved_extent(fs_info,
-							bytenr, blocksize);
-				if (ret) {
-					free_extent_buffer(next);
-					return ret;
+					unaccount_log_buffer(fs_info, bytenr);
 				}
 			}
 			free_extent_buffer(next);
@@ -2822,17 +2820,17 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+					ret = btrfs_pin_reserved_extent(fs_info,
+							path->nodes[*level]->start,
+							path->nodes[*level]->len);
+					if (ret)
+						return ret;
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
+					unaccount_log_buffer(fs_info,
+							     path->nodes[*level]->start);
 				}
-
-				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
-				ret = btrfs_pin_reserved_extent(fs_info,
-						path->nodes[*level]->start,
-						path->nodes[*level]->len);
-				if (ret)
-					return ret;
 			}
 			free_extent_buffer(path->nodes[*level]);
 			path->nodes[*level] = NULL;
@@ -2903,15 +2901,16 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 				btrfs_clean_tree_block(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+				ret = btrfs_pin_reserved_extent(fs_info, next->start,
+								next->len);
+				if (ret)
+					goto out;
 			} else {
 				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 					clear_extent_buffer_dirty(next);
+				unaccount_log_buffer(fs_info,
+						     next->start);
 			}
-
-			ret = btrfs_pin_reserved_extent(fs_info, next->start,
-							next->len);
-			if (ret)
-				goto out;
 		}
 	}
 
-- 
2.17.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2802C3FC9C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhHaObq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237549AbhHaObo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6F1D60FD8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420249;
        bh=DT8kBgsaziRrz+Iny1jEA3YQcE5jOgnFonGAAqiMOMY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aiDp6YsIiVVZCK5VSjSkejGGgSmInyzM5nZ/Kz82MLsRQQuuKRgzG1edE+TV7OEvS
         RK2K5gzyMUOKI1p+2cmW7H/uyidLkchuwwLRwYVM4+FKatD/ldjtdt+d8pKlOYdhTJ
         i/LoUqygFom3zoYxZaZFZMbPDbV12Me1wNjJkXJ0eXsNvOCGCBfp6hSgkIwPnQ4kx9
         VMn4kIjSuS0gRLdRwfFMmVlVp1qsVLx3Whumq10eP5TafWS75nMnHZktwoufhGA/tR
         U3fZ17fWCvCuL+g8LS50MSFWzbTg5+YHJfQzHmepY8xlIZhQW1TvzKHHnGMlv5SoM0
         B6gCQ4JZ01AHw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: avoid expensive search when truncating inode items from the log
Date:   Tue, 31 Aug 2021 15:30:37 +0100
Message-Id: <7050db12201d7f42ad0216563bf0a81c53d85836.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Whenever we are logging a file inode in full sync mode we call
btrfs_truncate_inode_items() to delete items of the inode we may have
previously logged.

That results in doing a btree search for deletion, which is expensive
because it always acquires write locks for extent buffers at levels 2, 1
and 0, and it balances any node that is less than half full. Acquiring
the write locks can block the task if the extent buffers are already
locked by another task or block other tasks attempting to lock them,
which is specially bad in case of log trees since they are small due to
their short life, with a root node at a level typically not greater than
level 2.

If we know that we are logging the inode for the first time in the current
transaction, we can skip the call to btrfs_truncate_inode_items(), avoiding
the deletion search. This change does that.

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

This is patch 7/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3abd11a0beda..e07f0ac1627a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5471,7 +5471,9 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 					  &inode->runtime_flags);
 				clear_bit(BTRFS_INODE_COPY_EVERYTHING,
 					  &inode->runtime_flags);
-				ret = truncate_inode_items(trans, log, inode, 0, 0);
+				if (inode_logged(trans, inode))
+					ret = truncate_inode_items(trans, log,
+								   inode, 0, 0);
 			}
 		} else if (test_and_clear_bit(BTRFS_INODE_COPY_EVERYTHING,
 					      &inode->runtime_flags) ||
-- 
2.28.0


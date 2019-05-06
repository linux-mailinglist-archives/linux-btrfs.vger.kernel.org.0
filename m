Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436D315089
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEFPn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 May 2019 11:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEFPn4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 May 2019 11:43:56 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00206205C9
        for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2019 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557157435;
        bh=dVd0sRHWgq3Co/oqaxfa1rQL3O/zsjAUY990mlz1XsU=;
        h=From:To:Subject:Date:From;
        b=ytj+yhfXZCAQIIxdiL9hquC9s1sfwsT0npkmIimAsk5tItFJc+l+ta6f/I4vl5vDl
         foTIHElCVE8ChjSMEkuqNBx+3JOgaT95p+m6uDh8k+w+8+3aXyPVYcpZg+kXrjRmIY
         JA3o8GFnNTKSR+wuV3otQR0cHtIVMq3Cg2bi80sM=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: avoid fallback to transaction commit during fsync of files with holes
Date:   Mon,  6 May 2019 16:43:51 +0100
Message-Id: <20190506154351.20047-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we are doing a full fsync (bit BTRFS_INODE_NEEDS_FULL_SYNC set) of a
file that has holes and has file extent items spanning two or more leafs,
we can end up falling to back to a full transaction commit due to a logic
bug that leads to failure to insert a duplicate file extent item that is
meant to represent a hole between the last file extent item of a leaf and
the first file extent item in the next leaf. The failure (EEXIST error)
leads to a transaction commit (as most errors when logging an inode do).

For example, we have the two following leafs:

Leaf N:

  -----------------------------------------------
  | ..., ..., ..., (257, FILE_EXTENT_ITEM, 64K) |
  -----------------------------------------------
  The file extent item at the end of leaf N has a length of 4Kb,
  representing the file range from 64K to 68K - 1.

Leaf N + 1:

  -----------------------------------------------
  | (257, FILE_EXTENT_ITEM, 72K), ..., ..., ... |
  -----------------------------------------------
  The file extent item at the first slot of leaf N + 1 has a length of
  4Kb too, representing the file range from 72K to 76K - 1.

During the full fsync path, when we are at tree-log.c:copy_items() with
leaf N as a parameter, after processing the last file extent item, that
represents the extent at offset 64K, we take a look at the first file
extent item at the next leaf (leaf N + 1), and notice there's a 4K hole
between the two extents, and therefore we insert a file extent item
representing that hole, starting at file offset 68K and ending at offset
72K - 1. However we don't update the value of *last_extent, which is used
to represent the end offset (plus 1, non-inclusive end) of the last file
extent item inserted in the log, so it stays with a value of 68K and not
with a value of 72K.

Then, when copy_items() is called for leaf N + 1, because the value of
*last_extent is smaller then the offset of the first extent item in the
leaf (68K < 72K), we look at the last file extent item in the previous
leaf (leaf N) and see it there's a 4K gap between it and our first file
extent item (again, 68K < 72K), so we decide to insert a file extent item
representing the hole, starting at file offset 68K and ending at offset
72K - 1, this insertion will fail with -EEXIST being returned from
btrfs_insert_file_extent() because we already inserted a file extent item
representing a hole for this offset (68K) in the previous call to
copy_items(), when processing leaf N.

The -EEXIST error gets propagated to the fsync callback, btrfs_sync_file(),
which falls back to a full transaction commit.

Fix this by adjusting *last_extent after inserting a hole when we had to
look at the next leaf.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index bb7b27a47537..87e3e4e37606 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4169,6 +4169,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 							       *last_extent, 0,
 							       0, len, 0, len,
 							       0, 0, 0);
+				*last_extent += len;
 			}
 		}
 	}
-- 
2.11.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73622F76
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfETIzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 04:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfETIzq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 04:55:46 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5674120656
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342545;
        bh=pjQOQWGIo+F+kxckHjuNE5EMbwRbmF7To2w8bsV+5Is=;
        h=From:To:Subject:Date:From;
        b=oXrgeWqRR750JEstPmMVaRkGy50PD3Hbf+/+U+55iGGJo8sQNvTdYx3sg8Gyqmguh
         Wsg+I7npUh+U3/4c1gdk4Rp3IDLB+oszObsjrbK5oJ6rUCFkk3c6ivTyIuvr80cnr3
         QrpZ7e94fl4X6h46NupmoiZshlws4fzB6crbyh2E=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: incremental send, fix file corruption when no-holes feature is enabled
Date:   Mon, 20 May 2019 09:55:42 +0100
Message-Id: <20190520085542.29282-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the no-holes feature, if we have a file with prealloc extents
with a start offset beyond the file's eof, doing an incremental send can
cause corruption of the file due to incorrect hole detection. Such case
requires that the prealloc extent(s) exist in both the parent and send
snapshots, and that a hole is punched into the file that covers all its
extents that do not cross the eof boundary.

Example reproducer:

  $ mkfs.btrfs -f -O no-holes /dev/sdb
  $ mount /dev/sdb /mnt/sdb

  $ xfs_io -f -c "pwrite -S 0xab 0 500K" /mnt/sdb/foobar
  $ xfs_io -c "falloc -k 1200K 800K" /mnt/sdb/foobar

  $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base

  $ btrfs send -f /tmp/base.snap /mnt/sdb/base

  $ xfs_io -c "fpunch 0 500K" /mnt/sdb/foobar

  $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr

  $ btrfs send -p /mnt/sdb/base -f /tmp/incr.snap /mnt/sdb/incr

  $ md5sum /mnt/sdb/incr/foobar
  816df6f64deba63b029ca19d880ee10a   /mnt/sdb/incr/foobar

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt/sdc

  $ btrfs receive -f /tmp/base.snap /mnt/sdc
  $ btrfs receive -f /tmp/incr.snap /mnt/sdc

  $ md5sum /mnt/sdc/incr/foobar
  cf2ef71f4a9e90c2f6013ba3b2257ed2   /mnt/sdc/incr/foobar

    --> Different checksum, because the prealloc extent beyond the
        file's eof confused the hole detection code and it assumed
        a hole starting at offset 0 and ending at the offset of the
        prealloc extent (1200Kb) instead of ending at the offset
        500Kb (the file's size).

Fix this by ensuring we never cross the file's size when issuing the
write operations for a hole.

Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
CC: stable@vger.kernel.org # 3.14+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c5184691d7f2..1549d0639b57 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4999,6 +4999,12 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	if (offset >= sctx->cur_inode_size)
 		return 0;
 
+	/*
+	 * Don't go beyond the inode's i_size due to prealloc extents that start
+	 * after the i_size.
+	 */
+	end = min_t(u64, end, sctx->cur_inode_size);
+
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, end - offset);
 
-- 
2.11.0


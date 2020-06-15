Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DAC1F9ED1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgFORtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 13:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFORtB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 13:49:01 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D422080D
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592243341;
        bh=+YX5rwsNF72lJcCRHB2idiC8MmXfRTd1D2weo2gloyk=;
        h=From:To:Subject:Date:From;
        b=VxBjANumFEQ3coONaWv0SwSAiGd6r26htLXkSEV4YW0+Vej4M0NWEh6C16nVxMM+I
         iyrIEDOJT5Ok7cBaW49fcDozjeNVbYQGPGdKMRsQdoO9yDVbVKuPva98vHCGeAyAvw
         rQcIUm1T5fz1kF8GN+E6udo62mFO3ZhH/DfDG89s=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] Btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof
Date:   Mon, 15 Jun 2020 18:48:58 +0100
Message-Id: <20200615174858.14888-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we attempt to write to prealloc extent located after eof using a
RWF_NOWAIT write, we always fail with -EAGAIN.

We do actually check if we have an allocated extent for the write at
the start of btrfs_file_write_iter() through a call to check_can_nocow(),
but later when we go into the actual direct IO write path we simply
return -EAGAIN if the write starts at or beyond EOF.

Trivial to reproduce:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ touch /mnt/foo
  $ chattr +C /mnt/foo

  $ xfs_io -d -c "pwrite -S 0xab 0 64K" /mnt/foo
  wrote 65536/65536 bytes at offset 0
  64 KiB, 16 ops; 0.0004 sec (135.575 MiB/sec and 34707.1584 ops/sec)

  $ xfs_io -c "falloc -k 64K 1M" /mnt/foo

  $ xfs_io -d -c "pwrite -N -V 1 -S 0xfe -b 64K 64K 64K" /mnt/foo
  pwrite: Resource temporarily unavailable

On xfs and ext4 the write succeeds, as expected.

Fix this by removing the wrong check at btrfs_direct_IO().

Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 62b49d2db928..cfa863d2d97c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7889,9 +7889,6 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			dio_data.overwrite = 1;
 			inode_unlock(inode);
 			relock = true;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
-			ret = -EAGAIN;
-			goto out;
 		}
 		ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
 						   offset, count);
-- 
2.26.2


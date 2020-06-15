Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35F1F9EC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgFORqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 13:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731270AbgFORqE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 13:46:04 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DB32078A
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592243164;
        bh=U+ToLZUScU7hhZBhe8QFVGjR/yW7bRP2jaPQ3IEQcyQ=;
        h=From:To:Subject:Date:From;
        b=Iyllm2UFrXofTsZAzMtMqiPSmVEX5KxKDg8zERBmBNZ/A5UMtBBE5jvD8O9mEfAxc
         i+5K7czzdeGQd0nkKC7i4SZkhSp+CpCRmmIFaYagYzDp5S3YvN6Ri0Q6nEsw75+7N5
         k5p95IEYJEnAQGhLZr/OYEesmIHgsY8iF6gZc0B8=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] Btrfs: fix hang on snapshot creation after RWF_NOWAIT write
Date:   Mon, 15 Jun 2020 18:46:01 +0100
Message-Id: <20200615174601.14559-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we do a successful RWF_NOWAIT write we end up locking the snapshot lock
of the inode, through a call to check_can_nocow(), but we never unlock it.

This means the next attempt to create a snapshot on the subvolume will
hang forever.

Trivial reproducer:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ touch /mnt/foobar
  $ chattr +C /mnt/foobar
  $ xfs_io -d -c "pwrite -S 0xab 0 64K" /mnt/foobar
  $ xfs_io -d -c "pwrite -N -V 1 -S 0xfe 0 64K" /mnt/foobar

  $ btrfs subvolume snapshot -r /mnt /mnt/snap
    --> hangs

Fix this by unlocking the snapshot lock if check_can_nocow() returned
success.

Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
CC: stable@vger.kernel.org # 4.13+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2c14312b05e8..04faa04fccd1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1914,6 +1914,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 			inode_unlock(inode);
 			return -EAGAIN;
 		}
+		/* check_can_nocow() locks the snapshot lock on success */
+		btrfs_drew_write_unlock(&root->snapshot_lock);
 	}
 
 	current->backing_dev_info = inode_to_bdi(inode);
-- 
2.26.2


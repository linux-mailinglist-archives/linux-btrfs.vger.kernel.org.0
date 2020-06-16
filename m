Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458D01FA661
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 04:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFPCR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 22:17:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPCR5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 22:17:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7604B1AB;
        Tue, 16 Jun 2020 02:17:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Greed Rong <greedrong@gmail.com>
Subject: [PATCH 4/4] btrfs: free anon_dev earlier to prevent exhausting anonymous block device pool
Date:   Tue, 16 Jun 2020 10:17:37 +0800
Message-Id: <20200616021737.44617-5-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616021737.44617-1-wqu@suse.com>
References: <20200616021737.44617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When a lot of subvolumes are created, there is a user report about
transaction aborted:

  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -24)
  WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
  RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
  Call Trace:
   create_pending_snapshots+0x82/0xa0 [btrfs]
   btrfs_commit_transaction+0x275/0x8c0 [btrfs]
   btrfs_mksubvol+0x4b9/0x500 [btrfs]
   btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
   btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
   btrfs_ioctl+0x11a4/0x2da0 [btrfs]
   do_vfs_ioctl+0xa9/0x640
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x1a/0x20
   do_syscall_64+0x5a/0x110
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ---[ end trace 33f2f83f3d5250e9 ]---
  BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
  BTRFS info (device sda1): forced readonly
  BTRFS warning (device sda1): Skipping commit of aborted transaction.
  BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown

[CAUSE]
The root cause is we don't have unlimited resource for anonymous block
device number.
The anonymous block device pool only contains 1<<20 devices, and is
shared across a several fses, like ceph and overlayfs.

While btrfs has support for 1<<48 subvolumes, so it's just a problem of
time to hit such limit.

[WORKAROUND]
Here we can free btrfs_root::anon_dev as long as the subvolume is no
longer visible to users.

By freeing it earlier we reclaim the anon_dev quicker, hopefully to
reduce the chance of exhausting the pool.

Reported-by: Greed Rong <greedrong@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 195aac71fe32..e9f5a166d056 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4045,6 +4045,8 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		}
 	}
 
+	free_anon_bdev(dest->anon_dev);
+	dest->anon_dev = 0;
 out_end_trans:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
-- 
2.27.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB01FA65E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 04:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgFPCRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 22:17:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPCRr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 22:17:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14FA7AE69;
        Tue, 16 Jun 2020 02:17:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Greed Rong <greedrong@gmail.com>
Subject: [PATCH 1/4] btrfs: disk-io: don't allocate anonymous block device for user invisible roots
Date:   Tue, 16 Jun 2020 10:17:34 +0800
Message-Id: <20200616021737.44617-2-wqu@suse.com>
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
Since it's not possible to completely solve the problem, we can only
workaround it.

Firstly, we can reduce the user of anon_dev. Data reloc tree is not visible
to users, thus it doesn't need anon_dev at all.

This patch will do extra check on root objectid, to rule out roots who
don't need anon_dev.
Although currently it's only data reloc tree and orphan roots.

Reported-by: Greed Rong <greedrong@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c70d47b8090a..cfc0ff288238 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1428,9 +1428,17 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
 	spin_lock_init(&root->ino_cache_lock);
 	init_waitqueue_head(&root->ino_cache_wait);
 
-	ret = get_anon_bdev(&root->anon_dev);
-	if (ret)
-		goto fail;
+	/*
+	 * Anonymous block device pool has limited size (1M), which is way
+	 * smaller than btrfs subvolumes limits (1<<48).
+	 * We shouldn't allocate any if it's not a user visible subvolume.
+	 */
+	if (is_fstree(root->root_key.objectid) &&
+	    btrfs_root_refs(&root->root_item)) {
+		ret = get_anon_bdev(&root->anon_dev);
+		if (ret)
+			goto fail;
+	}
 
 	mutex_lock(&root->objectid_mutex);
 	ret = btrfs_find_highest_objectid(root,
-- 
2.27.0


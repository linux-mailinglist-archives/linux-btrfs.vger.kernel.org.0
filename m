Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A171FA65D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 04:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFPCRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 22:17:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPCRn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 22:17:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2979FAE69
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 02:17:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: workaround exhausted anonymous block device pool
Date:   Tue, 16 Jun 2020 10:17:33 +0800
Message-Id: <20200616021737.44617-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a user report about transaction abort with a rare error number,
-EMFILE:

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

It turns out that, it's caused by exhausted anonymous block device pool.
For that case, we don't have any good way to enlarge that pool to match
btrfs subvolume limits.

But still we can improve the situation not to abort transaction, but
report error gracefully to user.

This patchset will:
- Reduce the user of anonymous block device pool
  Although it can only reduce the user by data reloc tree and orphan
  roots, it should still save save several ids.

- Catch the unintialized btrfs_root::anon_dev for user visible roots
  Just an extra safe net for previous patch

- Preallocate anon_dev for snapshot/subvolume creation
  So user will get a graceful error other than transaction abort
  This patch should be the core of the patchset, as the remaining part
  won't have much user visible effect.

- Free anon_dev earlier to reduce the lifespan of anon_dev

Qu Wenruo (4):
  btrfs: disk-io: don't allocate anonymous block device for user
    invisible roots
  btrfs: detect uninitialized btrfs_root::anon_dev for user visible
    subvolumes
  btrfs: preallocate anon_dev for subvolume and snapshot creation
  btrfs: free anon_dev earlier to prevent exhausting anonymous block
    device pool

 fs/btrfs/disk-io.c     | 59 +++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/disk-io.h     |  2 ++
 fs/btrfs/inode.c       | 11 +++++++-
 fs/btrfs/ioctl.c       | 21 ++++++++++++++-
 fs/btrfs/transaction.c |  3 ++-
 fs/btrfs/transaction.h |  2 ++
 6 files changed, 88 insertions(+), 10 deletions(-)

-- 
2.27.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905A811A3A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 06:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLKFAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 00:00:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:45532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfLKFAQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 00:00:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4F3BAE07;
        Wed, 11 Dec 2019 05:00:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH 3/3] btrfs: relocation: Fix a KASAN report on btrfs_reloc_pre_snapshot() due to extended reloc root lifespan
Date:   Wed, 11 Dec 2019 13:00:04 +0800
Message-Id: <20191211050004.18414-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211050004.18414-1-wqu@suse.com>
References: <20191211050004.18414-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running workload with balance start/cancel, snapshot
creation/deletion and fsstress, we can hit the following KASAN report:
  ==================================================================
  BUG: KASAN: use-after-free in btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
  Read of size 4 at addr ffff888157140100 by task btrfs/1822

  CPU: 2 PID: 1822 Comm: btrfs Tainted: G           O      5.5.0-rc1-custom+ #40
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   dump_stack+0xc2/0x11a
   print_address_description.constprop.0+0x20/0x210
   __kasan_report.cold+0x1b/0x41
   kasan_report+0x12/0x20
   check_memory_region+0x13c/0x1b0
   __asan_loadN+0xf/0x20
   btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
   create_pending_snapshot+0x209/0x15f0 [btrfs]
   create_pending_snapshots+0x111/0x140 [btrfs]
   btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
   btrfs_mksubvol+0x915/0x960 [btrfs]
   btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
   btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
   btrfs_ioctl+0x241b/0x3e60 [btrfs]
   do_vfs_ioctl+0x831/0xb10
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x43/0x50
   do_syscall_64+0x79/0xe0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

[CAUSE]
Again, we try to access root->reloc_root without verify if that reloc
root is already dead (being freed).

[FIX]
Check if the root has dead reloc root before accessing it.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 619ccb183515..2d2cd1596ec9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4721,7 +4721,8 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 	struct btrfs_root *root = pending->root;
 	struct reloc_control *rc = root->fs_info->reloc_ctl;
 
-	if (!root->reloc_root || !rc)
+	if (!root->reloc_root || !rc || test_bit(BTRFS_ROOT_DEAD_RELOC_TREE,
+				&root->state))
 		return;
 
 	if (!rc->merge_reloc_tree)
-- 
2.24.0


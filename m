Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C543B24DDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEUL2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 07:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfEUL2P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 07:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81313AD02;
        Tue, 21 May 2019 11:28:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Juan Erbes <jerbes@gmail.com>
Subject: [PATCH v1.1] btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer dereference
Date:   Tue, 21 May 2019 19:28:08 +0800
Message-Id: <20190521112808.28728-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When mounting a fs with reloc tree and has qgroup enabled, it can cause
NULL pointer dereference at mount time:
  BUG: kernel NULL pointer dereference, address: 00000000000000a8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  RIP: 0010:btrfs_qgroup_add_swapped_blocks+0x186/0x300 [btrfs]
  Call Trace:
   replace_path.isra.23+0x685/0x900 [btrfs]
   merge_reloc_root+0x26e/0x5f0 [btrfs]
   merge_reloc_roots+0x10a/0x1a0 [btrfs]
   btrfs_recover_relocation+0x3cd/0x420 [btrfs]
   open_ctree+0x1bc8/0x1ed0 [btrfs]
   btrfs_mount_root+0x544/0x680 [btrfs]
   legacy_get_tree+0x34/0x60
   vfs_get_tree+0x2d/0xf0
   fc_mount+0x12/0x40
   vfs_kern_mount.part.12+0x61/0xa0
   vfs_kern_mount+0x13/0x20
   btrfs_mount+0x16f/0x860 [btrfs]
   legacy_get_tree+0x34/0x60
   vfs_get_tree+0x2d/0xf0
   do_mount+0x81f/0xac0
   ksys_mount+0xbf/0xe0
   __x64_sys_mount+0x25/0x30
   do_syscall_64+0x65/0x240
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

[CAUSE]
In btrfs_recover_relocation(), we don't have enough info to determine
which block group we're relocating, but only to merge existing reloc
trees.

Thus in btrfs_recover_relocation(), rc->block_group is NULL.
btrfs_qgroup_add_swapped_blocks() hasn't take this into consideration,
and causes NULL pointer dereference.

The bug is introduced by commit 3d0174f78e72 ("btrfs: qgroup: Only trace
data extents in leaves if we're relocating data block group"), and
later qgroup refactor still keeps this optimization.

[FIX]
Thankfully in the context of btrfs_recover_relocation(), there is no
other progress can modify tree blocks, thus those swapped tree blocks
pair will never affect qgroup numbers, no matter whatever we set for
block->trace_leaf.

So we only need to check if @bg is NULL before accessing @bg->flags.

Reported-by: Juan Erbes <jerbes@gmail.com>
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1134806
Fixes: 3d0174f78e72 ("btrfs: qgroup: Only trace data extents in leaves if we're relocating data block group")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Test case using dm-log-writes will follow after another bug fixed.

The test case using dm-log-writes can not only trigger this bug, but
also some other reloc related BUG_ON() even with this patch.

Without the other bug fixed, the test case will fail anyway, so test
case will be delayed.

Changelog:
v1.1
- Fix a grammar and format error in the [BUG] section.
---
 fs/btrfs/qgroup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2f708f2c4e67..3e6ffbbd8b0a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3830,7 +3830,13 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 							    subvol_slot);
 	block->last_snapshot = last_snapshot;
 	block->level = level;
-	if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
+
+	/*
+	 * If we have bg == NULL, we're called from btrfs_recover_relocation(),
+	 * no one else can modify tree blocks thus we qgroup will not change
+	 * no matter the value of trace_leaf.
+	 */
+	if (bg && bg->flags & BTRFS_BLOCK_GROUP_DATA)
 		block->trace_leaf = true;
 	else
 		block->trace_leaf = false;
-- 
2.21.0


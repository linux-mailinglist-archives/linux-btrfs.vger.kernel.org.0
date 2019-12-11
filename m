Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5B11A39E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 06:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfLKFAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 00:00:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:45508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfLKFAN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 00:00:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EA73AE07;
        Wed, 11 Dec 2019 05:00:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH 1/3] btrfs: relocation: Fix a KASAN use-after-free bug due to extended reloc tree lifespan
Date:   Wed, 11 Dec 2019 13:00:02 +0800
Message-Id: <20191211050004.18414-2-wqu@suse.com>
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
When running a workload with balance start/cancel, snapshot creation and
deletion, and fsstress, we can get the following KASAN report:

  ==================================================================
  BUG: KASAN: use-after-free in should_ignore_root+0x54/0xb0 [btrfs]
  Read of size 8 at addr ffff888146e340f0 by task btrfs/1216

  CPU: 6 PID: 1216 Comm: btrfs Tainted: G           O      5.5.0-rc1-custom+ #40
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   dump_stack+0xc2/0x11a
   print_address_description.constprop.0+0x20/0x210
   __kasan_report.cold+0x1b/0x41
   kasan_report+0x12/0x20
   check_memory_region+0x13c/0x1b0
   __asan_loadN+0xf/0x20
   should_ignore_root+0x54/0xb0 [btrfs]
   build_backref_tree+0x11af/0x2280 [btrfs]
   relocate_tree_blocks+0x391/0xb80 [btrfs]
   relocate_block_group+0x3e5/0xa00 [btrfs]
   btrfs_relocate_block_group+0x240/0x4d0 [btrfs]
   btrfs_relocate_chunk+0x53/0xf0 [btrfs]
   btrfs_balance+0xc91/0x1840 [btrfs]
   btrfs_ioctl_balance+0x416/0x4e0 [btrfs]
   btrfs_ioctl+0x8af/0x3e60 [btrfs]
   do_vfs_ioctl+0x831/0xb10
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x43/0x50
   do_syscall_64+0x79/0xe0
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

[CAUSE]
When should_ignore_root() accessing root->reloc_root, the reloc_root can
be being dropped, thus root->reloc_root can be unreliable.

[FIX]
Check DEAD_RELOC_ROOT bit before accessing root->reloc_root.

Furthermore in the context of should_ignore_root(), if the root has
already gone through tree merge, we don't need to trace that root
anymore.
Thus we need to return 1, for root with dead reloc root.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..bb41b981e493 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -525,6 +525,10 @@ static int should_ignore_root(struct btrfs_root *root)
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return 0;
 
+	/* This root has been merged with its reloc tree, so we can ignore it */
+	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
+		return 1;
+
 	reloc_root = root->reloc_root;
 	if (!reloc_root)
 		return 0;
-- 
2.24.0


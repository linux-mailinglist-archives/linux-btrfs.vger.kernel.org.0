Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE365A48
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2019 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGKPXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jul 2019 11:23:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:57508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728124AbfGKPXR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jul 2019 11:23:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB9A6ACD9;
        Thu, 11 Jul 2019 15:23:16 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] btrfs: free checksum hash on in close_ctree
Date:   Thu, 11 Jul 2019 17:23:04 +0200
Message-Id: <20190711152304.11438-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_info::csum_hash gets initialized in btrfs_init_csum_hash() which is
called by open_ctree().

But it only gets freed if open_ctree() fails, not on normal operation.

This leads to a memory leak like the following found by kmemleak:
unreferenced object 0xffff888132cb8720 (size 96):
  comm "mount", pid 450, jiffies 4294912436 (age 17.584s)
  hex dump (first 32 bytes):
    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000c9643d4>] crypto_create_tfm+0x2d/0xd0
    [<00000000ae577f68>] crypto_alloc_tfm+0x4b/0xb0
    [<000000002b5cdf30>] open_ctree+0xb84/0x2060 [btrfs]
    [<0000000043204297>] btrfs_mount_root+0x552/0x640 [btrfs]
    [<00000000c99b10ea>] legacy_get_tree+0x22/0x40
    [<0000000071a6495f>] vfs_get_tree+0x1f/0xc0
    [<00000000f180080e>] fc_mount+0x9/0x30
    [<000000009e36cebd>] vfs_kern_mount.part.11+0x6a/0x80
    [<0000000004594c05>] btrfs_mount+0x174/0x910 [btrfs]
    [<00000000c99b10ea>] legacy_get_tree+0x22/0x40
    [<0000000071a6495f>] vfs_get_tree+0x1f/0xc0
    [<00000000b86e92c5>] do_mount+0x6b0/0x940
    [<0000000097464494>] ksys_mount+0x7b/0xd0
    [<0000000057213c80>] __x64_sys_mount+0x1c/0x20
    [<00000000cb689b5e>] do_syscall_64+0x43/0x130
    [<000000002194e289>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Free fs_info::csum_hash in close_ctree() to avoid the memory leak.

Fixes: 6d97c6e31b55 ("btrfs: add boilerplate code for directly including the crypto framework")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/disk-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41a2bd2e0c56..5f7ee70b3d1a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4106,6 +4106,7 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
 
+	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_free_ref_cache(fs_info);
 }
-- 
2.16.4


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5371F31D59D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBQHHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 02:07:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6399 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhBQHHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 02:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613545664; x=1645081664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0roR2gTdO3yQSWi1HiSp47lPa8ibaBqppFCitPPUjR8=;
  b=e/W5FjMfifpdeuXcfIeNkhf5yWQ0Se9pqxkuz/gsxOveEhY5X501glZF
   ghygz+RI+DjqroyB+maaC541D1phrJDVI/7XNk7s9mVGoVQzufZ5KVDkO
   6KVhH39Pfc0nrZWJODND4Lu9o4p/GfbzYUqbeGkwJVKLKM/WMZXgbKpgr
   oQkLA1Nx6KOVyWgrZhbSiOJbzEgNRz97xb6/5AhcHSlLqyfzkWVT3H0VS
   FZFDn5iUpLM//pfIKRbDfGfliNSTK1dTyJ/XQK4G8p2BsuPd2MIwKM/SD
   SNtZz2cc1boeefBvyK7tpCjNWzmviUrA7KqHCVqtt5VKBrdv7tfGbYNXk
   g==;
IronPort-SDR: i9TLUm7YL/eKnbg3MHPpvXvfiIH9pFaIK5QSwzFW5UDFNt0Pb+QbyjgxLh/Wejtc7TS1H0CCQM
 2vzq2KdbWujyxmyY/q8I18KuJJdjbVes46kEbCeuFRd2Gp6tFxST5NwWXENEGUXFrmpDtI8a/M
 ns29dCiKLV0Tui2vW6Sb4vy7hvvPi4+7KBQQSl6rGBlv0Gneji5YCtqQ4BiksWs2Rhd2UGLqx7
 1ZEU8aXzXE79Tj+IDAPrAt+blSm/iSpXFHCdEy6IuEyiSgyg7xG8FVI/xquvK2P1I+NkxafE3i
 xsc=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="160124248"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 15:06:39 +0800
IronPort-SDR: 3WIXLPoXkFm2rMuBfz0jVeqgpNMAX/1/fAweG4hHFSWhkpNLu+hJCxTtE0Ga2EN9Mxh3WuiAvT
 ePzv5xCDxZA8VG1ezcoLKj7jKUt+34tbtcQtWbuhXCqFoFt24i438dFemfa4CqFP/y86YtKT6y
 OKUXIMdWWtvFzOR/Lx1Q+B20HXJS6djyC2UR6v/TkkKYrXsJWUr/u88/qbkS5p3xKlOGLrjN0e
 Q/eEPPIZdvl5eutmFlIpEC7MM2GwjLzbwtlJmYO8ZlXhbxlQhgxK9dyLK1OOakQHKmHGrkiNaO
 EG07qunD6s+8INFy7dglro+n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 22:50:11 -0800
IronPort-SDR: GP4ZUw9AZs08r/kHoCiRBnL0Ra9kiJe2/l/lFHtDrFyF30abvAzpbuHq1GKAnKfOeZgn8/ifGv
 dXxVO6FgF+ZZI2hNAagFmiN1JHm/RkIKMl9T9KFvkX1G6RIG1QBQKuuvU28cqV6IPkTEJPn8sh
 RLVidWDfGi3i8ZtZKjBd3aIZkX7OzQArM2xRCpW3LNoABnRNVjb445ApEASF0Im+SsxaWCLc5Z
 FAss/9xTONy07sHqv+qnDEVx6sVtxrJU1vrRhBLp87WV1bvr18MyfgFBZSNRM7bj0PRBKpaMBX
 vpc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Feb 2021 23:06:38 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix possible deadlock on log sync
Date:   Wed, 17 Feb 2021 16:06:18 +0900
Message-Id: <ba64e01fa8f13d10daebe1d8e24ad1a20de9b231.1613545566.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lockdep with fstests test-case btrfs/041 detected a unsafe locking
scenario when we allocate the log node on a zoned filesystem.

btrfs/041
 ============================================
 WARNING: possible recursive locking detected
 5.11.0-rc7+ #939 Not tainted
 --------------------------------------------
 xfs_io/698 is trying to acquire lock:
 ffff88810cd673a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x3d1/0xee0 [btrfs]

 but task is already holding lock:
 ffff88810b0fc3a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x313/0xee0 [btrfs]

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&root->log_mutex);
   lock(&root->log_mutex);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 2 locks held by xfs_io/698:
  #0: ffff88810cd66620 (sb_internal){.+.+}-{0:0}, at: btrfs_sync_file+0x2c3/0x570 [btrfs]
  #1: ffff88810b0fc3a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x313/0xee0 [btrfs]

 stack backtrace:
 CPU: 0 PID: 698 Comm: xfs_io Not tainted 5.11.0-rc7+ #939
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
 Call Trace:
  dump_stack+0x77/0x97
  __lock_acquire.cold+0xb9/0x32a
  lock_acquire+0xb5/0x400
  ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
  __mutex_lock+0x7b/0x8d0
  ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
  ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
  ? find_first_extent_bit+0x9f/0x100 [btrfs]
  ? __mutex_unlock_slowpath+0x35/0x270
  btrfs_sync_log+0x3d1/0xee0 [btrfs]
  btrfs_sync_file+0x3a8/0x570 [btrfs]
  __x64_sys_fsync+0x34/0x60
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f1e856b8ecb
 Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 b3 f6 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 11 f7 ff ff 8b 44
 RSP: 002b:00007ffde89011b0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
 RAX: ffffffffffffffda RBX: 0000557ef97886c0 RCX: 00007f1e856b8ecb
 RDX: 0000000000000002 RSI: 0000557ef97886e0 RDI: 0000000000000003
 RBP: 0000557ef97886e0 R08: 0000000000000000 R09: 0000000000000003
 R10: fffffffffffff50e R11: 0000000000000293 R12: 0000000000000001
 R13: 0000557ef97886c0 R14: 0000000000000001 R15: 0000557ef976e2a0

This happens, because we are taking the ->log_mutex albeit it has already
been locked.

Also while at it, fix the bogus unlock of the tree_log_mutex in the error
handling.

Fixes: 3ddebf27fcd3 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
Cc: Filipe Manana <fdmanana@suse.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tree-log.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d90695c1ab6c..2f1acc9aea9e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3174,16 +3174,13 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	root_log_ctx.log_transid = log_root_tree->log_transid;
 
 	if (btrfs_is_zoned(fs_info)) {
-		mutex_lock(&fs_info->tree_root->log_mutex);
 		if (!log_root_tree->node) {
 			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
 			if (ret) {
-				mutex_unlock(&fs_info->tree_log_mutex);
 				mutex_unlock(&log_root_tree->log_mutex);
 				goto out;
 			}
 		}
-		mutex_unlock(&fs_info->tree_root->log_mutex);
 	}
 
 	/*
-- 
2.30.0


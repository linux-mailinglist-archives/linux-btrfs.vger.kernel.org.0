Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A635FACB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfGDPYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 11:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfGDPYN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 11:24:13 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9DE2083B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2019 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562253852;
        bh=ddPC0/yHo1LACTAlx/obLf9OWIhKOv47Ip2uMuPk1R8=;
        h=From:To:Subject:Date:From;
        b=NxeTFB7ILjHgOcHUf2kGgKmao2KP6kVct7S42CXBMr+jKzVq2pKOvlDdziGiCZEg4
         hqVOkgdt/cqTb9LvdM0pmhzqcoAp5K9XASvaIiposqpAwF690ZDHXc/bYO39rQqlON
         d4p7GJHz7Jnk1p6miCN/49K+u74KgucaSCgQuEJY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] Btrfs: fix hang when loading existing inode cache off disk
Date:   Thu,  4 Jul 2019 16:24:09 +0100
Message-Id: <20190704152409.20665-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we are able to load an existing inode cache off disk, we set the state
of the cache to BTRFS_CACHE_FINISHED, but we don't wake up any one waiting
for the cache to be available. This means that anyone waiting for the
cache to be available, waiting on the condition that either its state is
BTRFS_CACHE_FINISHED or its available free space is greather than zero,
can hang forever.

This could be observed running fstests with MOUNT_OPTIONS="-o inode_cache",
in particular test case generic/161 triggered it very frequently for me,
producing a trace like the following:

  [63795.739712] BTRFS info (device sdc): enabling inode map caching
  [63795.739714] BTRFS info (device sdc): disk space caching is enabled
  [63795.739716] BTRFS info (device sdc): has skinny extents
  [64036.653886] INFO: task btrfs-transacti:3917 blocked for more than 120 seconds.
  [64036.654079]       Not tainted 5.2.0-rc4-btrfs-next-50 #1
  [64036.654143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [64036.654232] btrfs-transacti D    0  3917      2 0x80004000
  [64036.654239] Call Trace:
  [64036.654258]  ? __schedule+0x3ae/0x7b0
  [64036.654271]  schedule+0x3a/0xb0
  [64036.654325]  btrfs_commit_transaction+0x978/0xae0 [btrfs]
  [64036.654339]  ? remove_wait_queue+0x60/0x60
  [64036.654395]  transaction_kthread+0x146/0x180 [btrfs]
  [64036.654450]  ? btrfs_cleanup_transaction+0x620/0x620 [btrfs]
  [64036.654456]  kthread+0x103/0x140
  [64036.654464]  ? kthread_create_worker_on_cpu+0x70/0x70
  [64036.654476]  ret_from_fork+0x3a/0x50
  [64036.654504] INFO: task xfs_io:3919 blocked for more than 120 seconds.
  [64036.654568]       Not tainted 5.2.0-rc4-btrfs-next-50 #1
  [64036.654617] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [64036.654685] xfs_io          D    0  3919   3633 0x00000000
  [64036.654691] Call Trace:
  [64036.654703]  ? __schedule+0x3ae/0x7b0
  [64036.654716]  schedule+0x3a/0xb0
  [64036.654756]  btrfs_find_free_ino+0xa9/0x120 [btrfs]
  [64036.654764]  ? remove_wait_queue+0x60/0x60
  [64036.654809]  btrfs_create+0x72/0x1f0 [btrfs]
  [64036.654822]  lookup_open+0x6bc/0x790
  [64036.654849]  path_openat+0x3bc/0xc00
  [64036.654854]  ? __lock_acquire+0x331/0x1cb0
  [64036.654869]  do_filp_open+0x99/0x110
  [64036.654884]  ? __alloc_fd+0xee/0x200
  [64036.654895]  ? do_raw_spin_unlock+0x49/0xc0
  [64036.654909]  ? do_sys_open+0x132/0x220
  [64036.654913]  do_sys_open+0x132/0x220
  [64036.654926]  do_syscall_64+0x60/0x1d0
  [64036.654933]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fix this by adding a wake_up() call right after setting the cache state to
BTRFS_CACHE_FINISHED, at start_caching(), when we are able to load the
cache from disk.

Fixes: 82d5902d9c681b ("Btrfs: Support reading/writing on disk free ino cache")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode-map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index ffca2abf13d0..4a5882665f8a 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -145,6 +145,7 @@ static void start_caching(struct btrfs_root *root)
 		spin_lock(&root->ino_cache_lock);
 		root->ino_cache_state = BTRFS_CACHE_FINISHED;
 		spin_unlock(&root->ino_cache_lock);
+		wake_up(&root->ino_cache_wait);
 		return;
 	}
 
-- 
2.11.0


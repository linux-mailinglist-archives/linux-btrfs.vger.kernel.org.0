Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B845E5E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 04:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbhKZCpv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 21:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358827AbhKZCnu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 21:43:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90DFA6126A;
        Fri, 26 Nov 2021 02:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637894148;
        bh=sgiv5Ump/GT979rCOQ1JsMuo3gcBXiKY1RleDtPnKsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lq07/mNktUhH2dYbwLpgLi0D8nJe/54pjTs3A9HOltO7+DgH+PMe7W564o86TCQSB
         FHC+3BAJb2Ctvs8F3UK/clUO6Y2FyqPqwxu8a3qjVLgoBrR29J+iqIjXqzFBoE0lsf
         OBDxIW02VC9wWQgf0cztoJOompFQpGaB//xSArcP3YWafAQLosRcrIdbuDLh2JfoDr
         ET8vA7w94NIObrVPgR4QJMfPGpfC/jApNb5XU52fP2ZBrvd7WVZ1s5D1sWhPmi58pU
         XL/M0WVb3MlO7nK3ZmQ8DQUWA7GUUmqcOq6bxSsWPvY2uT1o5w1TVEptyusSK/Y8XS
         P82SextuEq7pw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Filipe Manana <fdmanana@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/15] btrfs: check-integrity: fix a warning on write caching disabled disk
Date:   Thu, 25 Nov 2021 21:35:26 -0500
Message-Id: <20211126023533.442895-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126023533.442895-1-sashal@kernel.org>
References: <20211126023533.442895-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Wang Yugui <wangyugui@e16-tech.com>

[ Upstream commit a91cf0ffbc244792e0b3ecf7d0fddb2f344b461f ]

When a disk has write caching disabled, we skip submission of a bio with
flush and sync requests before writing the superblock, since it's not
needed. However when the integrity checker is enabled, this results in
reports that there are metadata blocks referred by a superblock that
were not properly flushed. So don't skip the bio submission only when
the integrity checker is enabled for the sake of simplicity, since this
is a debug tool and not meant for use in non-debug builds.

fstests/btrfs/220 trigger a check-integrity warning like the following
when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.

  btrfs: attempt to write superblock which references block M @5242880 (sdb2/5242880/0) which is not flushed out of disk's write cache (block flush_gen=1, dev->flush_gen=0)!
  ------------[ cut here ]------------
  WARNING: CPU: 28 PID: 843680 at fs/btrfs/check-integrity.c:2196 btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
  CPU: 28 PID: 843680 Comm: umount Not tainted 5.15.0-0.rc5.39.el8.x86_64 #1
  Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
  RIP: 0010:btrfsic_process_written_superblock+0x22a/0x2a0 [btrfs]
  RSP: 0018:ffffb642afb47940 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
  RDX: 00000000ffffffff RSI: ffff8b722fc97d00 RDI: ffff8b722fc97d00
  RBP: ffff8b5601c00000 R08: 0000000000000000 R09: c0000000ffff7fff
  R10: 0000000000000001 R11: ffffb642afb476f8 R12: ffffffffffffffff
  R13: ffffb642afb47974 R14: ffff8b5499254c00 R15: 0000000000000003
  FS:  00007f00a06d4080(0000) GS:ffff8b722fc80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fff5cff5ff0 CR3: 00000001c0c2a006 CR4: 00000000001706e0
  Call Trace:
   btrfsic_process_written_block+0x2f7/0x850 [btrfs]
   __btrfsic_submit_bio.part.19+0x310/0x330 [btrfs]
   ? bio_associate_blkg_from_css+0xa4/0x2c0
   btrfsic_submit_bio+0x18/0x30 [btrfs]
   write_dev_supers+0x81/0x2a0 [btrfs]
   ? find_get_pages_range_tag+0x219/0x280
   ? pagevec_lookup_range_tag+0x24/0x30
   ? __filemap_fdatawait_range+0x6d/0xf0
   ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
   ? find_first_extent_bit+0x9b/0x160 [btrfs]
   ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
   write_all_supers+0x1b3/0xa70 [btrfs]
   ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
   btrfs_commit_transaction+0x59d/0xac0 [btrfs]
   close_ctree+0x11d/0x339 [btrfs]
   generic_shutdown_super+0x71/0x110
   kill_anon_super+0x14/0x30
   btrfs_kill_super+0x12/0x20 [btrfs]
   deactivate_locked_super+0x31/0x70
   cleanup_mnt+0xb8/0x140
   task_work_run+0x6d/0xb0
   exit_to_user_mode_prepare+0x1f0/0x200
   syscall_exit_to_user_mode+0x12/0x30
   do_syscall_64+0x46/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x7f009f711dfb
  RSP: 002b:00007fff5cff7928 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
  RAX: 0000000000000000 RBX: 000055b68c6c9970 RCX: 00007f009f711dfb
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055b68c6c9b50
  RBP: 0000000000000000 R08: 000055b68c6ca900 R09: 00007f009f795580
  R10: 0000000000000000 R11: 0000000000000246 R12: 000055b68c6c9b50
  R13: 00007f00a04bf184 R14: 0000000000000000 R15: 00000000ffffffff
  ---[ end trace 2c4b82abcef9eec4 ]---
  S-65536(sdb2/65536/1)
   -->
  M-1064960(sdb2/1064960/1)

Reviewed-by: Filipe Manana <fdmanana@gmail.com>
Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cb21ffd3bba7c..06e5529fedfdb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3578,11 +3578,23 @@ static void btrfs_end_empty_barrier(struct bio *bio)
  */
 static void write_dev_flush(struct btrfs_device *device)
 {
-	struct request_queue *q = bdev_get_queue(device->bdev);
 	struct bio *bio = device->flush_bio;
 
+#ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	/*
+	 * When a disk has write caching disabled, we skip submission of a bio
+	 * with flush and sync requests before writing the superblock, since
+	 * it's not needed. However when the integrity checker is enabled, this
+	 * results in reports that there are metadata blocks referred by a
+	 * superblock that were not properly flushed. So don't skip the bio
+	 * submission only when the integrity checker is enabled for the sake
+	 * of simplicity, since this is a debug tool and not meant for use in
+	 * non-debug builds.
+	 */
+	struct request_queue *q = bdev_get_queue(device->bdev);
 	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		return;
+#endif
 
 	bio_reset(bio);
 	bio->bi_end_io = btrfs_end_empty_barrier;
-- 
2.33.0


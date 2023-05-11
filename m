Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A66FF7B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbjEKQqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbjEKQqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 12:46:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577349EFA
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 09:46:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso8314595a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1683823561; x=1686415561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJBg7jnM8iqsAShl37/n16AxX5uxHkW2D2EKURXy71A=;
        b=eENkN1CPIVakfWW8DRloTPleG1IsaOovL6csK5TqmeECYhidD79yT7/mgdK13BRh/T
         nHxp951qTkAb8SRKORTdMdrkj/YAtKC9VnrhKBlGHxYjTSXsEToEQV2wHLfEuY8HPE5+
         wCUv/ADzidvfpgtf7dcePNt0D5UQcywvSvpm2mEjsZ+I2nrmvho9bi2hgV6U0uWERszG
         mMD+5UWC1zvzOh+lv+Y24Bv/a9yx90oNB0nTK3jRuz4AaVk2Z2vN6F+/4RNpc04h0y8v
         q7h3Ox65RyMN6hdDNTlpXTRWFkuzYhy7d6PD9V4DWXGYcT4/ZI+W1BF3f9aXXQ2gQX03
         Pc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683823561; x=1686415561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJBg7jnM8iqsAShl37/n16AxX5uxHkW2D2EKURXy71A=;
        b=f082//lKyicWcJgdDSSJ1jD6rDnF9Mc1m/X0M+wPna9eJsjVn0mLQifVxa0ORlJomR
         9ZMmzCLvSVqTyAbizTXGfwTzlCTs5RjsWsjOYebXQjRwMPxfXwqGM/VSiYEBCjUVb3C6
         +pvp+PmNzQeDTdowphGiexQfnJVmP3H3F2napHE21VQfSOAAeFwH7DHTY9buKg4IQZoL
         Q2AzE2tS//H0PvUZUveTklNO1Ix3Oa2VM4+WoHPThPqr4Wqmw3QJOx3UZVJIQk239vtZ
         XTQn3AUdC1FWPdzJnUioRlRX/NZ8C/up3z+OMKs+BD7vdZU5D6HMSOPrxdC2flMF6vDe
         6yCg==
X-Gm-Message-State: AC+VfDwb4OL/1inbyF6hSmjNpDil2rZWcHINHSYbrqt0N9wHAia+8AEQ
        15URkg1vIdT9FFg2jIXR7GzNXMKl1EjMBNG/Eyfy6Bzi
X-Google-Smtp-Source: ACHHUZ5TXSnkojQo3TQ9y815eQ/bul/M9+xwHQI0RfCU0GUzTfrK/mb4d3PzkhIB1mEXEpmPpuIQmg==
X-Received: by 2002:a17:90a:b00a:b0:250:1905:ae7b with SMTP id x10-20020a17090ab00a00b002501905ae7bmr21979771pjq.27.1683823560902;
        Thu, 11 May 2023 09:46:00 -0700 (PDT)
Received: from localhost ([64.141.80.140])
        by smtp.gmail.com with ESMTPSA id gi21-20020a17090b111500b00250d908a771sm3255148pjb.50.2023.05.11.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:46:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: use nofs when cleaning up aborted transactions
Date:   Thu, 11 May 2023 12:45:59 -0400
Message-Id: <d92da03aa76633c6631b367f1e8ad6055d5756de.1683823518.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our CI system caught a lockdep splat

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc7+ #1167 Not tainted
------------------------------------------------------
kswapd0/46 is trying to acquire lock:
ffff8c6543abd650 (sb_internal#2){++++}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x5f/0x120

but task is already holding lock:
ffffffffabe61b40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x4aa/0x7a0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0xa5/0xe0
       kmem_cache_alloc+0x31/0x2c0
       alloc_extent_state+0x1d/0xd0
       __clear_extent_bit+0x2e0/0x4f0
       try_release_extent_mapping+0x216/0x280
       btrfs_release_folio+0x2e/0x90
       invalidate_inode_pages2_range+0x397/0x470
       btrfs_cleanup_dirty_bgs+0x9e/0x210
       btrfs_cleanup_one_transaction+0x22/0x760
       btrfs_commit_transaction+0x3b7/0x13a0
       create_subvol+0x59b/0x970
       btrfs_mksubvol+0x435/0x4f0
       __btrfs_ioctl_snap_create+0x11e/0x1b0
       btrfs_ioctl_snap_create_v2+0xbf/0x140
       btrfs_ioctl+0xa45/0x28f0
       __x64_sys_ioctl+0x88/0xc0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x72/0xdc

-> #0 (sb_internal#2){++++}-{0:0}:
       __lock_acquire+0x1435/0x21a0
       lock_acquire+0xc2/0x2b0
       start_transaction+0x401/0x730
       btrfs_commit_inode_delayed_inode+0x5f/0x120
       btrfs_evict_inode+0x292/0x3d0
       evict+0xcc/0x1d0
       inode_lru_isolate+0x14d/0x1e0
       __list_lru_walk_one+0xbe/0x1c0
       list_lru_walk_one+0x58/0x80
       prune_icache_sb+0x39/0x60
       super_cache_scan+0x161/0x1f0
       do_shrink_slab+0x163/0x340
       shrink_slab+0x1d3/0x290
       shrink_node+0x300/0x720
       balance_pgdat+0x35c/0x7a0
       kswapd+0x205/0x410
       kthread+0xf0/0x120
       ret_from_fork+0x29/0x50

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(sb_internal#2);
                               lock(fs_reclaim);
  lock(sb_internal#2);

 *** DEADLOCK ***

3 locks held by kswapd0/46:
 #0: ffffffffabe61b40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x4aa/0x7a0
 #1: ffffffffabe50270 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x113/0x290
 #2: ffff8c6543abd0e0 (&type->s_umount_key#44){++++}-{3:3}, at: super_cache_scan+0x38/0x1f0

stack backtrace:
CPU: 0 PID: 46 Comm: kswapd0 Not tainted 6.3.0-rc7+ #1167
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x58/0x90
 check_noncircular+0xd6/0x100
 ? save_trace+0x3f/0x310
 ? add_lock_to_list+0x97/0x120
 __lock_acquire+0x1435/0x21a0
 lock_acquire+0xc2/0x2b0
 ? btrfs_commit_inode_delayed_inode+0x5f/0x120
 start_transaction+0x401/0x730
 ? btrfs_commit_inode_delayed_inode+0x5f/0x120
 btrfs_commit_inode_delayed_inode+0x5f/0x120
 btrfs_evict_inode+0x292/0x3d0
 ? lock_release+0x134/0x270
 ? __pfx_wake_bit_function+0x10/0x10
 evict+0xcc/0x1d0
 inode_lru_isolate+0x14d/0x1e0
 __list_lru_walk_one+0xbe/0x1c0
 ? __pfx_inode_lru_isolate+0x10/0x10
 ? __pfx_inode_lru_isolate+0x10/0x10
 list_lru_walk_one+0x58/0x80
 prune_icache_sb+0x39/0x60
 super_cache_scan+0x161/0x1f0
 do_shrink_slab+0x163/0x340
 shrink_slab+0x1d3/0x290
 shrink_node+0x300/0x720
 balance_pgdat+0x35c/0x7a0
 kswapd+0x205/0x410
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_kswapd+0x10/0x10
 kthread+0xf0/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x29/0x50
 </TASK>

This happens because when we abort the transaction in the transaction
commit path we call invalidate_inode_pages2_range on our block group
cache inodes (if we have space cache v1) and any delalloc inodes we may
have.  The plain invalidate_inode_pages2_range() call passes through
GFP_KERNEL, which makes sense in most cases, but not here.  Wrap these
two invalidate calles with memalloc_nofs_save/memalloc_nofs_restore to
make sure we don't end up with the fs reclaim dependency under the
transaction dependency.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7a726644a9ff..b1b7482a02a8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4867,7 +4867,10 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 		 */
 		inode = igrab(&btrfs_inode->vfs_inode);
 		if (inode) {
+			unsigned int nofs_flag = memalloc_nofs_save();
+
 			invalidate_inode_pages2(inode->i_mapping);
+			memalloc_nofs_restore(nofs_flag);
 			iput(inode);
 		}
 		spin_lock(&root->delalloc_lock);
@@ -4973,7 +4976,11 @@ static void btrfs_cleanup_bg_io(struct btrfs_block_group *cache)
 
 	inode = cache->io_ctl.inode;
 	if (inode) {
+		unsigned int nofs_flag = memalloc_nofs_save();
+
 		invalidate_inode_pages2(inode->i_mapping);
+		memalloc_nofs_restore(nofs_flag);
+
 		BTRFS_I(inode)->generation = 0;
 		cache->io_ctl.inode = NULL;
 		iput(inode);
-- 
2.39.2


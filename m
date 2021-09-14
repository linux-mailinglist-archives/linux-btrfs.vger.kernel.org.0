Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4801640A6FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhING7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 02:59:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhING7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 02:59:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 681A42002E;
        Tue, 14 Sep 2021 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631602683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sAX8RMHWW3HL7u94rX9TYHBHFFSIu3mLUl8BpTP6G0o=;
        b=rxRwDBCk+IOdAa45uaIncE1a71FvQX9BF4+abc6vs+fGoP556TPDfDsznFQxB6gdWmScsB
        FxxXpSdcx9Q35JUN0VmRuSCKjEFAL6AMp1amx+JBLcDp63V4Y9uyk6KN4e1cvQs3n2xt8N
        2KNF2tMnyVpkY840zhgolPIqaGHpBz8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61D1A13E4F;
        Tue, 14 Sep 2021 06:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5xPtCPpHQGFMcAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 14 Sep 2021 06:58:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] btrfs: unlock the newly allocated extent buffer in btrfs_alloc_tree_block()
Date:   Tue, 14 Sep 2021 14:57:59 +0800
Message-Id: <20210914065759.38793-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a very detailed bug report that injected ENOMEM error could
leave a tree block locked while we return to user-space:

  BTRFS info (device loop0): enabling ssd optimizations
  FAULT_INJECTION: forcing a failure.
  name failslab, interval 1, probability 0, space 0, times 0
  CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
  rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
  Call Trace:
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
   fail_dump lib/fault-inject.c:52 [inline]
   should_fail+0x13c/0x160 lib/fault-inject.c:146
   should_failslab+0x5/0x10 mm/slab_common.c:1328
   slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
   slab_alloc_node mm/slub.c:3120 [inline]
   slab_alloc mm/slub.c:3214 [inline]
   kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
   btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
   btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
   __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
   btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
   btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
   btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
   btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
   btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
   lookup_open+0x660/0x780 fs/namei.c:3282
   open_last_lookups fs/namei.c:3352 [inline]
   path_openat+0x465/0xe20 fs/namei.c:3557
   do_filp_open+0xe3/0x170 fs/namei.c:3588
   do_sys_openat2+0x357/0x4a0 fs/open.c:1200
   do_sys_open+0x87/0xd0 fs/open.c:1216
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x46ae99
  Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
  89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
  01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
  RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
  RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
  RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
  R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0

  ================================================
  WARNING: lock held when returning to user space!
  5.15.0-rc1 #16 Not tainted
  ------------------------------------------------
  syz-executor/7579 is leaving the kernel with locks still held!
  1 lock held by syz-executor/7579:
   #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
  __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112

[CAUSE]
In btrfs_alloc_tree_block(), after btrfs_init_new_buffer(), the new
extent buffer @buf is locked, but if later operations like adding
delayed tree ref fails, we just free @buf without unlocking it,
resulting above warning.

[FIX]
Unlock @buf in out_free_buf: tag.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CACkBjsZ9O6Zr0KK1yGn=1rQi6Crh1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c88e7727a31a..8aa981ffe7b7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4898,6 +4898,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 out_free_delayed:
 	btrfs_free_delayed_extent_op(extent_op);
 out_free_buf:
+	btrfs_tree_unlock(buf);
 	free_extent_buffer(buf);
 out_free_reserved:
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 0);
-- 
2.33.0


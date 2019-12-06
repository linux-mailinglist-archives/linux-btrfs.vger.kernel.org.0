Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6EE115065
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLFM1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 07:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFM1n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 07:27:43 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300332464E
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2019 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575635262;
        bh=IybqZmQDYIGKIJPK7nTeStic2u2uDA6P8dbRxPYYm7I=;
        h=From:To:Subject:Date:From;
        b=jBX+8DUzFMxZ1U59+pkkKaGHsH77oWpaCsQmqcIlwd6s981e53VW+KqI3e8jjrwz2
         Z74RZTCEnh8WXSp9PZMBqF9CKLIdjDnJOGrhBXrLR8SVLM/TDClW5/b/0XML3oRfYB
         sAPLr9Cmqm+Nmc0+z38aJn+dhcky/9x8AAAhMpxU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix removal logic of the tree mod log that leads to use-after-free issues
Date:   Fri,  6 Dec 2019 12:27:39 +0000
Message-Id: <20191206122739.27195-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When a tree mod log user no longer needs to use the tree it calls
btrfs_put_tree_mod_seq() to remove itself from the list of users and
delete all no longer used elements of the tree's red black tree, which
should be all elements with a sequence number less then our equals to
the caller's sequence number. However the logic is broken because it
can delete and free elements from the red black tree that have a
sequence number greater then the caller's sequence number:

1) At a point in time we have sequence numbers 1, 2, 3 and 4 in the
   tree mod log;

2) The task which got assigned the sequence number 1 calls
   btrfs_put_tree_mod_seq();

3) Sequence number 1 is deleted from the list of sequence numbers;

4) The current minimum sequence number is computed to be the sequence
   number 2;

5) A task using sequence number 2 is at tree_mod_log_rewind() and gets
   a pointer to one of its elements from the red black tree through
   a call to tree_mod_log_search();

6) The task with sequence number 1 iterates the red black tree of tree
   modification elements and deletes (and frees) all elements with a
   sequence number less then or equals to 2 (the computed minimum sequence
   number) - it ends up only leaving elements with sequence numbers of 3
   and 4;

7) The task with sequence number 2 now uses the pointer to its element,
   already freed by the other task, at __tree_mod_log_rewind(), resulting
   in a use-after-free issue. When CONFIG_DEBUG_PAGEALLOC=y it produces
   a trace like the following:

  [16804.546854] general protection fault: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
  [16804.547451] CPU: 0 PID: 28257 Comm: pool Tainted: G        W         5.4.0-rc8-btrfs-next-51 #1
  [16804.548059] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
  [16804.548666] RIP: 0010:rb_next+0x16/0x50
  (...)
  [16804.550581] RSP: 0018:ffffb948418ef9b0 EFLAGS: 00010202
  [16804.551227] RAX: 6b6b6b6b6b6b6b6b RBX: ffff90e0247f6600 RCX: 6b6b6b6b6b6b6b6b
  [16804.551873] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e0247f6600
  [16804.552504] RBP: ffff90dffe0d4688 R08: 0000000000000001 R09: 0000000000000000
  [16804.553136] R10: ffff90dffa4a0040 R11: 0000000000000000 R12: 000000000000002e
  [16804.553768] R13: ffff90e0247f6600 R14: 0000000000001663 R15: ffff90dff77862b8
  [16804.554399] FS:  00007f4b197ae700(0000) GS:ffff90e036a00000(0000) knlGS:0000000000000000
  [16804.555039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [16804.555683] CR2: 00007f4b10022000 CR3: 00000002060e2004 CR4: 00000000003606f0
  [16804.556336] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [16804.556968] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [16804.557583] Call Trace:
  [16804.558207]  __tree_mod_log_rewind+0xbf/0x280 [btrfs]
  [16804.558835]  btrfs_search_old_slot+0x105/0xd00 [btrfs]
  [16804.559468]  resolve_indirect_refs+0x1eb/0xc70 [btrfs]
  [16804.560087]  ? free_extent_buffer.part.19+0x5a/0xc0 [btrfs]
  [16804.560700]  find_parent_nodes+0x388/0x1120 [btrfs]
  [16804.561310]  btrfs_check_shared+0x115/0x1c0 [btrfs]
  [16804.561916]  ? extent_fiemap+0x59d/0x6d0 [btrfs]
  [16804.562518]  extent_fiemap+0x59d/0x6d0 [btrfs]
  [16804.563112]  ? __might_fault+0x11/0x90
  [16804.563706]  do_vfs_ioctl+0x45a/0x700
  [16804.564299]  ksys_ioctl+0x70/0x80
  [16804.564885]  ? trace_hardirqs_off_thunk+0x1a/0x20
  [16804.565461]  __x64_sys_ioctl+0x16/0x20
  [16804.566020]  do_syscall_64+0x5c/0x250
  [16804.566580]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [16804.567153] RIP: 0033:0x7f4b1ba2add7
  (...)
  [16804.568907] RSP: 002b:00007f4b197adc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [16804.569513] RAX: ffffffffffffffda RBX: 00007f4b100210d8 RCX: 00007f4b1ba2add7
  [16804.570133] RDX: 00007f4b100210d8 RSI: 00000000c020660b RDI: 0000000000000003
  [16804.570726] RBP: 000055de05a6cfe0 R08: 0000000000000000 R09: 00007f4b197add44
  [16804.571314] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4b197add48
  [16804.571905] R13: 00007f4b197add40 R14: 00007f4b100210d0 R15: 00007f4b197add50
  (...)
  [16804.575623] ---[ end trace 87317359aad4ba50 ]---

Fix this by making btrfs_put_tree_mod_seq() skip deletion of elements that
have a sequence number equals to the computed minimum sequence number, and
not just elements with a sequence number greater then that minimum.

Fixes: bd989ba359f2ac ("Btrfs: add tree modification log functions")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5b6e86aaf2e1..24658b5a5787 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -379,7 +379,7 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
 	for (node = rb_first(tm_root); node; node = next) {
 		next = rb_next(node);
 		tm = rb_entry(node, struct tree_mod_elem, node);
-		if (tm->seq > min_seq)
+		if (tm->seq >= min_seq)
 			continue;
 		rb_erase(node, tm_root);
 		kfree(tm);
-- 
2.11.0


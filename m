Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 131518A576
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 20:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHLSOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 14:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfHLSOd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 14:14:33 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0352067D
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565633673;
        bh=9xLOwJLs2YjrgolNRaCK81x1BbjGgrNh0aBQAX3iDb8=;
        h=From:To:Subject:Date:From;
        b=Vtvwc1HrGuMV6vovS2KuED7qVOoQC5Gs2jK88cJe0xPkHez6cmlmh9Ja54GBbu4Pf
         LA+cQ+oOl+patXKaS9B8psHzLGOjGrFlMGJ5Cceh2GIwuZ2VpV7eXeHPLikwKc5is8
         gsdR6hp+l/qsbeAseZ9ZEey6vFewFNIQQ2Nezwx4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix use-after-free when using the tree modification log
Date:   Mon, 12 Aug 2019 19:14:29 +0100
Message-Id: <20190812181429.11444-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At ctree.c:get_old_root(), we are accessing a root's header owner field
after we have freed the respective extent buffer. This results in an
use-after-free that can lead to crashes, and when CONFIG_DEBUG_PAGEALLOC
is set, results in a stack trace like the following:

  [ 3876.799331] stack segment: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
  [ 3876.799363] CPU: 0 PID: 15436 Comm: pool Not tainted 5.3.0-rc3-btrfs-next-54 #1
  [ 3876.799385] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
  [ 3876.799433] RIP: 0010:btrfs_search_old_slot+0x652/0xd80 [btrfs]
  (...)
  [ 3876.799502] RSP: 0018:ffff9f08c1a2f9f0 EFLAGS: 00010286
  [ 3876.799518] RAX: ffff8dd300000000 RBX: ffff8dd85a7a9348 RCX: 000000038da26000
  [ 3876.799538] RDX: 0000000000000000 RSI: ffffe522ce368980 RDI: 0000000000000246
  [ 3876.799559] RBP: dae1922adadad000 R08: 0000000008020000 R09: ffffe522c0000000
  [ 3876.799579] R10: ffff8dd57fd788c8 R11: 000000007511b030 R12: ffff8dd781ddc000
  [ 3876.799599] R13: ffff8dd9e6240578 R14: ffff8dd6896f7a88 R15: ffff8dd688cf90b8
  [ 3876.799620] FS:  00007f23ddd97700(0000) GS:ffff8dda20200000(0000) knlGS:0000000000000000
  [ 3876.799643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 3876.799660] CR2: 00007f23d4024000 CR3: 0000000710bb0005 CR4: 00000000003606f0
  [ 3876.799682] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [ 3876.799703] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [ 3876.799723] Call Trace:
  [ 3876.799735]  ? do_raw_spin_unlock+0x49/0xc0
  [ 3876.799749]  ? _raw_spin_unlock+0x24/0x30
  [ 3876.799779]  resolve_indirect_refs+0x1eb/0xc80 [btrfs]
  [ 3876.799810]  find_parent_nodes+0x38d/0x1180 [btrfs]
  [ 3876.799841]  btrfs_check_shared+0x11a/0x1d0 [btrfs]
  [ 3876.799870]  ? extent_fiemap+0x598/0x6e0 [btrfs]
  [ 3876.799895]  extent_fiemap+0x598/0x6e0 [btrfs]
  [ 3876.799913]  do_vfs_ioctl+0x45a/0x700
  [ 3876.799926]  ksys_ioctl+0x70/0x80
  [ 3876.799938]  ? trace_hardirqs_off_thunk+0x1a/0x20
  [ 3876.799953]  __x64_sys_ioctl+0x16/0x20
  [ 3876.799965]  do_syscall_64+0x62/0x220
  [ 3876.799977]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [ 3876.799993] RIP: 0033:0x7f23e0013dd7
  (...)
  [ 3876.800056] RSP: 002b:00007f23ddd96ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [ 3876.800078] RAX: ffffffffffffffda RBX: 00007f23d80210f8 RCX: 00007f23e0013dd7
  [ 3876.800099] RDX: 00007f23d80210f8 RSI: 00000000c020660b RDI: 0000000000000003
  [ 3876.800626] RBP: 000055fa2a2a2440 R08: 0000000000000000 R09: 00007f23ddd96d7c
  [ 3876.801143] R10: 00007f23d8022000 R11: 0000000000000246 R12: 00007f23ddd96d80
  [ 3876.801662] R13: 00007f23ddd96d78 R14: 00007f23d80210f0 R15: 00007f23ddd96d80
  (...)
  [ 3876.805107] ---[ end trace e53161e179ef04f9 ]---

Fix that by saving the root's header owner field into a local variable
before freeing the root's extent buffer, and then use that local variable
when needed.

Fixes: 30b0463a9394d9 ("Btrfs: fix accessing the root pointer in tree mod log functions")
CC: stable@vger.kernel.org # 3.10+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5df76c17775a..0e7ae8da1f95 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1343,6 +1343,7 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 	struct tree_mod_elem *tm;
 	struct extent_buffer *eb = NULL;
 	struct extent_buffer *eb_root;
+	u64 eb_root_owner = 0;
 	struct extent_buffer *old;
 	struct tree_mod_root *old_root = NULL;
 	u64 old_generation = 0;
@@ -1380,6 +1381,7 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 			free_extent_buffer(old);
 		}
 	} else if (old_root) {
+		eb_root_owner = btrfs_header_owner(eb_root);
 		btrfs_tree_read_unlock(eb_root);
 		free_extent_buffer(eb_root);
 		eb = alloc_dummy_extent_buffer(fs_info, logical);
@@ -1396,7 +1398,7 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 	if (old_root) {
 		btrfs_set_header_bytenr(eb, eb->start);
 		btrfs_set_header_backref_rev(eb, BTRFS_MIXED_BACKREF_REV);
-		btrfs_set_header_owner(eb, btrfs_header_owner(eb_root));
+		btrfs_set_header_owner(eb, eb_root_owner);
 		btrfs_set_header_level(eb, old_root->level);
 		btrfs_set_header_generation(eb, old_generation);
 	}
-- 
2.11.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349416F5EFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjECTOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjECTOR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 15:14:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D238A7ABA
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 12:14:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A3CD20684;
        Wed,  3 May 2023 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683141254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TL7S19ID0JYT1UKkruY02NF5DvG15UQ6PVc6lH1m2eo=;
        b=FDEnqnHbsUxGFjiN7novSi+BFVKk+6LjAP5seb2Z73dwSVDAt14Rl7997/w+VJaORAqOfK
        Ao4rbdT5oeG7WJA/Vq9ZVLAy2HpyCPmwiwLvrP3CwVg+lswWMh2Y6ul4EbzDIuwAf9VGIy
        fArkmvhGnGHbAqI486PCw7lzJLdGW0k=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E2232C141;
        Wed,  3 May 2023 19:14:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F35FDA704; Wed,  3 May 2023 21:08:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH RFC] btrfs: print assertion failure report and stack trace from the same line
Date:   Wed,  3 May 2023 21:08:16 +0200
Message-Id: <20230503190816.8800-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Assertions reports are split into two parts, the exact file and location
of the condition and then the stack trace printed from
btrfs_assertfail(). This means all the stack traces report the same line
and this is what's typically reported by various tools, making it harder
to distinguish the reports.

  [403.2467] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
  [403.2479] ------------[ cut here ]------------
  [403.2484] kernel BUG at fs/btrfs/messages.c:259!
  [403.2488] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
  [403.2493] CPU: 2 PID: 23202 Comm: umount Not tainted 6.2.0-rc4-default+ #67
  [403.2499] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
  [403.2509] RIP: 0010:btrfs_assertfail+0x19/0x1b [btrfs]
  ...
  [403.2595] Call Trace:
  [403.2598]  <TASK>
  [403.2601]  btrfs_free_block_groups.cold+0x52/0xae [btrfs]
  [403.2608]  close_ctree+0x6c2/0x761 [btrfs]
  [403.2613]  ? __wait_for_common+0x2b8/0x360
  [403.2618]  ? btrfs_cleanup_one_transaction.cold+0x7a/0x7a [btrfs]
  [403.2626]  ? mark_held_locks+0x6b/0x90
  [403.2630]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
  [403.2636]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
  [403.2642]  ? trace_hardirqs_on+0x2d/0x110
  [403.2646]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
  [403.2652]  generic_shutdown_super+0xb0/0x1c0
  [403.2657]  kill_anon_super+0x1e/0x40
  [403.2662]  btrfs_kill_super+0x25/0x30 [btrfs]
  [403.2668]  deactivate_locked_super+0x4c/0xc0

By making btrfs_assertfail a macro we'll get the same line number for
the BUG output:

  [63.5736] assertion failed: 0, in fs/btrfs/super.c:1572
  [63.5758] ------------[ cut here ]------------
  [63.5782] kernel BUG at fs/btrfs/super.c:1572!
  [63.5807] invalid opcode: 0000 [#2] PREEMPT SMP KASAN
  [63.5831] CPU: 0 PID: 859 Comm: mount Tainted: G      D            6.3.0-rc7-default+ #2062
  [63.5868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
  [63.5905] RIP: 0010:btrfs_mount+0x24/0x30 [btrfs]
  [63.5964] RSP: 0018:ffff88800e69fcd8 EFLAGS: 00010246
  [63.5982] RAX: 000000000000002d RBX: ffff888008fc1400 RCX: 0000000000000000
  [63.6004] RDX: 0000000000000000 RSI: ffffffffb90fd868 RDI: ffffffffbcc3ff20
  [63.6026] RBP: ffffffffc081b200 R08: 0000000000000001 R09: ffff88800e69fa27
  [63.6046] R10: ffffed1001cd3f44 R11: 0000000000000001 R12: ffff888005a3c370
  [63.6062] R13: ffffffffc058e830 R14: 0000000000000000 R15: 00000000ffffffff
  [63.6081] FS:  00007f7b3561f800(0000) GS:ffff88806c600000(0000) knlGS:0000000000000000
  [63.6105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [63.6120] CR2: 00007fff83726e10 CR3: 0000000002a9e000 CR4: 00000000000006b0
  [63.6137] Call Trace:
  [63.6143]  <TASK>
  [63.6148]  legacy_get_tree+0x80/0xd0
  [63.6158]  vfs_get_tree+0x43/0x120
  [63.6166]  do_new_mount+0x1f3/0x3d0
  [63.6176]  ? do_add_mount+0x140/0x140
  [63.6187]  ? cap_capable+0xa4/0xe0
  [63.6197]  path_mount+0x223/0xc10

This comes at a cost of bloating the final btrfs.ko module due all the
inlining, as long as assertions are compiled in. This is a must for
debugging builds but this is often enabled on release builds too.

Release build:

   text    data     bss     dec     hex filename
1251676   20317   16088 1288081  13a791 pre/btrfs.ko
1260612   29473   16088 1306173  13ee3d post/btrfs.ko

DELTA: +8936

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 8 --------
 fs/btrfs/messages.h | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 310a05cf95ef..23fc11af498a 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -252,14 +252,6 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 }
 #endif
 
-#ifdef CONFIG_BTRFS_ASSERT
-void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line)
-{
-	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-	BUG();
-}
-#endif
-
 void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
 {
 	btrfs_err(fs_info,
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index ac2d1982ba3d..0797df12c1ae 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -4,6 +4,8 @@
 #define BTRFS_MESSAGES_H
 
 #include <linux/types.h>
+#include <linux/printk.h>
+#include <linux/bug.h>
 
 struct btrfs_fs_info;
 
@@ -160,7 +162,11 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-void __cold __noreturn btrfs_assertfail(const char *expr, const char *file, int line);
+
+#define btrfs_assertfail(expr, file, line)	({				\
+	pr_err("assertion failed: %s, in %s:%d\n", (expr), (file), (line));	\
+	BUG();								\
+})
 
 #define ASSERT(expr)						\
 	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
-- 
2.40.0


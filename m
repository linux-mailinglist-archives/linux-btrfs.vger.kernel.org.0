Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E9667E6DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 14:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjA0Nhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 08:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjA0Nhv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 08:37:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D180DBC2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:37:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25EEC20194;
        Fri, 27 Jan 2023 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674826668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KyeZZ7qxXXGi5HmXa7A0+h4wV1MkUgPydfDfZU7uFrM=;
        b=jUibTk7ZM7BHPiOLQoctOVscVLRUK4EbgxCdb2v39q0xbdGQcVHY4eJYuDfcGwoFszF4ke
        PvoNOne4f4ArYLzq0mgNIAnWak/7BKXEAbTzMi+dsmHTen1Y2T1PfnBbFjnTF/adKuFaZk
        GXEfMLfbabi5iPvTAVzFkdP+HGhpM8I=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1B9E72C141;
        Fri, 27 Jan 2023 13:37:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E478DA7CF; Fri, 27 Jan 2023 14:32:05 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: restore assertion failure to the code line where it happens
Date:   Fri, 27 Jan 2023 14:32:02 +0100
Message-Id: <20230127133202.16220-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In commit 083bd7e54e8e ("btrfs: move the printk and assert helpers to
messages.c") btrfs_assertfail got un-inlined. This means that assertion
failures would all report as messages.c:259 as below, so make it inline
again.

  [403.246730] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
  [403.247935] ------------[ cut here ]------------
  [403.248405] kernel BUG at fs/btrfs/messages.c:259!
  [403.248879] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
  [403.249363] CPU: 2 PID: 23202 Comm: umount Not tainted 6.2.0-rc4-default+ #67
  [403.249986] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
  [403.250931] RIP: 0010:btrfs_assertfail+0x19/0x1b [btrfs]
  ...
  [403.259517] Call Trace:
  [403.259840]  <TASK>
  [403.260134]  btrfs_free_block_groups.cold+0x52/0xae [btrfs]
  [403.260824]  close_ctree+0x6c2/0x761 [btrfs]
  [403.261395]  ? __wait_for_common+0x2b8/0x360
  [403.261899]  ? btrfs_cleanup_one_transaction.cold+0x7a/0x7a [btrfs]
  [403.262632]  ? mark_held_locks+0x6b/0x90
  [403.263084]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
  [403.263628]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
  [403.264213]  ? trace_hardirqs_on+0x2d/0x110
  [403.264699]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
  [403.265279]  generic_shutdown_super+0xb0/0x1c0
  [403.265794]  kill_anon_super+0x1e/0x40
  [403.266241]  btrfs_kill_super+0x25/0x30 [btrfs]
  [403.266836]  deactivate_locked_super+0x4c/0xc0

Fixes: 083bd7e54e8e ("btrfs: move the printk and assert helpers to messages.c")
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 8 --------
 fs/btrfs/messages.h | 9 ++++++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index fde5aaa6e7c9..23fc11af498a 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -252,14 +252,6 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 }
 #endif
 
-#ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line)
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
index 8c516ee58ff9..9e8e7741ab76 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -4,6 +4,8 @@
 #define BTRFS_MESSAGES_H
 
 #include <linux/types.h>
+#include <linux/printk.h>
+#include <linux/bug.h>
 
 struct btrfs_fs_info;
 
@@ -160,7 +162,12 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line);
+static inline void __cold __noreturn btrfs_assertfail(const char *expr,
+						      const char *file, int line)
+{
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
+}
 
 #define ASSERT(expr)						\
 	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
-- 
2.37.3


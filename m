Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798D76E008
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 08:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjHCGHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 02:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjHCGHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 02:07:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28730CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 23:07:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E355B1F45A;
        Thu,  3 Aug 2023 06:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691042830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKmqw6Z1jkyHPHXSmij0N2tnpEXUa0guYn4Bxeex/R8=;
        b=aWRGjBNW0PZsTorgg0G6G+hzioGM/CP+HWl3HJ3mWFbQ6jIzb4BQD/Ae7PndeH74J0rzTW
        YxkHAJJ0GC9LeZF5kINYIBjfhF2MvRfSYAyELG138ZJZtfDRfYr8Uwb4i9EgJNAo1iV7lt
        CIdFmDLkh/0EKLMlIsdW/mEIEyOgWoI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE92F134B0;
        Thu,  3 Aug 2023 06:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wIEuIQ1Ey2TlDQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 03 Aug 2023 06:07:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: [PATCH v3 1/3] btrfs: avoid race with qgroup tree creation and relocation
Date:   Thu,  3 Aug 2023 14:06:48 +0800
Message-ID: <c4250b5ef6a0b09d6ebca9c0794e6eda297e104e.1691042474.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691042474.git.wqu@suse.com>
References: <cover.1691042474.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Syzbot reported a weird ASSERT() triggered inside prepare_to_merge().

  assertion failed: root->reloc_root == reloc_root, in fs/btrfs/relocation.c:1919
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/relocation.c:1919!
  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
  CPU: 0 PID: 9904 Comm: syz-executor.3 Not tainted
  6.4.0-syzkaller-08881-g533925cb7604 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine,
  BIOS Google 05/27/2023
  RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
  Code: fe e9 f5 (...)
  RSP: 0018:ffffc9000325f760 EFLAGS: 00010246
  RAX: 000000000000004f RBX: ffff888075644030 RCX: 1481ccc522da5800
  RDX: ffffc90005c09000 RSI: 00000000000364ca RDI: 00000000000364cb
  RBP: ffffc9000325f870 R08: ffffffff816f33ac R09: 1ffff9200064bea0
  R10: dffffc0000000000 R11: fffff5200064bea1 R12: ffff888075644000
  R13: ffff88803b166000 R14: ffff88803b166560 R15: ffff88803b166558
  FS:  00007f4e305fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000056080679c000 CR3: 00000000193ad000 CR4: 00000000003506f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   relocate_block_group+0xa5d/0xcd0 fs/btrfs/relocation.c:3749
   btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
   btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
   __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
   btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
   btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7f4e2f88c389

[CAUSE]
With extra debugging, the offending reloc_root is for quota tree
(rootid 8).

Normally we should not use reloc tree for quota root at all, as reloc
trees are only for subvolume trees.

But there is a race between quota enabling and relocation, this happens
after commit 85724171b302 ("btrfs: fix the btrfs_get_global_root return value").

Before that commit, for quota and free space tree, we exit immediately
if we can not grab it from fs_info.

But now we would try to read it from disk, just as if they are fs trees,
this sets ROOT_SHAREABLE flags in such race:

             Thread A             |           Thread B
 ---------------------------------+------------------------------
 btrfs_quota_enable()             |
 |                                | btrfs_get_root_ref()
 |                                | |- btrfs_get_global_root()
 |                                | |  Returned NULL
 |                                | |- btrfs_lookup_fs_root()
 |                                | |  Returned NULL
 |- btrfs_create_tree()           | |
 |  Now quota root item is        | |
 |  inserted                      | |- btrfs_read_tree_root()
 |                                | |  Got the newly inserted quota root
 |                                | |- btrfs_init_fs_root()
 |                                | |  Set ROOT_SHAREABLE flag

[FIX]
Get back to the old behavior by returning PTR_ERR(-ENOENT) if the target
objectid is not a subvolume tree or data reloc tree.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Fixes: 85724171b302 ("btrfs: fix the btrfs_get_global_root return value")
Reported-and-tested-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index da51e5750443..5fd336c597e9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1300,6 +1300,16 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	root = btrfs_get_global_root(fs_info, objectid);
 	if (root)
 		return root;
+
+	/*
+	 * If we're called for non-subvolume trees, and above function didn't
+	 * found one, do not try to read it from disk.
+	 *
+	 * This is mostly for fst and quota trees, which can change at runtime
+	 * and should only be grabbed from fs_info.
+	 */
+	if (!is_fstree(objectid) && objectid != BTRFS_DATA_RELOC_TREE_OBJECTID)
+		return ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
-- 
2.41.0


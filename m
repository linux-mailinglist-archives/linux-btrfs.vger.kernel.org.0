Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA432735C1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjFSQWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjFSQWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 12:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E63E63
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 09:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A375260D37
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0E8C433C8
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687191719;
        bh=FQFnvuoaoV+n+wO9CXcURGW+tbO3m8y6YRtVi0XJ2ks=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GFDDCkoJVj6gJwfKEWaFihiWIU9drf2+W9eKB6uc6BX4PWbbFSk6Tg1/inp6TM1eH
         zASqMec3iyDFxRleZvBaUkA6izlCtZPq3qGT0o68iv9LX8LreGEPWwd1kUBlPR9q2z
         VfLc0eGkysI4Hoz9r/EihNPB8hCMAP4kLRjN3BwrUu0EKLtiU4qkM+uOr9gaeOVVir
         yeIRhlbKx/pJlURfaTRifHOZC7ciywZl9Il38qVmHIRYv3vD386z9sFTHZiYuVe0Xd
         8L70cHKmd/NE1+vzMVd9mJV0kizcb6FeUsQM59X7Lg19ED4dB3Rxj1rIKa07akHY7g
         gRdyDhWkjAccA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: fix race when deleting free space root from the dirty cow roots list
Date:   Mon, 19 Jun 2023 17:21:48 +0100
Message-Id: <ade590c4c831aac50fdb4fa5fbb1eb64dd652ddc.1687185583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687185583.git.fdmanana@suse.com>
References: <cover.1687185583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When deleting the free space tree we are deleting the free space root
from the list fs_info->dirty_cowonly_roots without taking the lock that
protects it, which is struct btrfs_fs_info::trans_lock.
This unsynchronized list manipulation may cause chaos if there's another
concurrent manipulation of this list, such as when adding a root to it
with ctree.c:add_root_to_dirty_list().

This can result in all sorts of weird failures caused by a race, such as
the following crash:

      [337571.278245] general protection fault, probably for non-canonical address 0xdead000000000108: 0000 [#1] PREEMPT SMP PTI
      [337571.278933] CPU: 1 PID: 115447 Comm: btrfs Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
      [337571.279153] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
      [337571.279572] RIP: 0010:commit_cowonly_roots+0x11f/0x250 [btrfs]
      [337571.279928] Code: 85 38 06 00 (...)
      [337571.280363] RSP: 0018:ffff9f63446efba0 EFLAGS: 00010206
      [337571.280582] RAX: ffff942d98ec2638 RBX: ffff9430b82b4c30 RCX: 0000000449e1c000
      [337571.280798] RDX: dead000000000100 RSI: ffff9430021e4900 RDI: 0000000000036070
      [337571.281015] RBP: ffff942d98ec2000 R08: ffff942d98ec2000 R09: 000000000000015b
      [337571.281254] R10: 0000000000000009 R11: 0000000000000001 R12: ffff942fe8fbf600
      [337571.281476] R13: ffff942dabe23040 R14: ffff942dabe20800 R15: ffff942d92cf3b48
      [337571.281723] FS:  00007f478adb7340(0000) GS:ffff94349fa40000(0000) knlGS:0000000000000000
      [337571.281950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
      [337571.282184] CR2: 00007f478ab9a3d5 CR3: 000000001e02c001 CR4: 0000000000370ee0
      [337571.282416] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
      [337571.282647] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
      [337571.282874] Call Trace:
      [337571.283101]  <TASK>
      [337571.283327]  ? __die_body+0x1b/0x60
      [337571.283570]  ? die_addr+0x39/0x60
      [337571.283796]  ? exc_general_protection+0x22e/0x430
      [337571.284022]  ? asm_exc_general_protection+0x22/0x30
      [337571.284251]  ? commit_cowonly_roots+0x11f/0x250 [btrfs]
      [337571.284531]  btrfs_commit_transaction+0x42e/0xf90 [btrfs]
      [337571.284803]  ? _raw_spin_unlock+0x15/0x30
      [337571.285031]  ? release_extent_buffer+0x103/0x130 [btrfs]
      [337571.285305]  reset_balance_state+0x152/0x1b0 [btrfs]
      [337571.285578]  btrfs_balance+0xa50/0x11e0 [btrfs]
      [337571.285864]  ? __kmem_cache_alloc_node+0x14a/0x410
      [337571.286086]  btrfs_ioctl+0x249a/0x3320 [btrfs]
      [337571.286358]  ? mod_objcg_state+0xd2/0x360
      [337571.286577]  ? refill_obj_stock+0xb0/0x160
      [337571.286798]  ? seq_release+0x25/0x30
      [337571.287016]  ? __rseq_handle_notify_resume+0x3ba/0x4b0
      [337571.287235]  ? percpu_counter_add_batch+0x2e/0xa0
      [337571.287455]  ? __x64_sys_ioctl+0x88/0xc0
      [337571.287675]  __x64_sys_ioctl+0x88/0xc0
      [337571.287901]  do_syscall_64+0x38/0x90
      [337571.288126]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
      [337571.288352] RIP: 0033:0x7f478aaffe9b

So fix this by locking struct btrfs_fs_info::trans_lock before deleting
the free space root from that list.

Fixes: a5ed91828518 ("Btrfs: implement the free space B-tree")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index b21da1446f2a..045ddce32eca 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1280,7 +1280,10 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 		goto abort;
 
 	btrfs_global_root_delete(free_space_root);
+
+	spin_lock(&fs_info->trans_lock);
 	list_del(&free_space_root->dirty_list);
+	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_tree_lock(free_space_root->node);
 	btrfs_clear_buffer_dirty(trans, free_space_root->node);
-- 
2.34.1


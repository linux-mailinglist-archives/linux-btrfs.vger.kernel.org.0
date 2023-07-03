Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87209746140
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGCRPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGCRPt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 13:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E2110D1
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 10:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC2B60FF8
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 17:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882A3C433C7
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688404537;
        bh=SEHpTG7ACny8w3CGPbmG+vv4boYWcS5c1mkEJZnH3Ek=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gnkqtOjB1pltl0UxR+av1w9QuDN5w3geL6TPS2DYgDYU0HuG8AagRFmLjayyt27X2
         GRm/MKT0ecbd1E9KGy2S/WkHl2GhssZAJA0ckNBolkMr2UqkMbbz+s5V9azjk4kVEJ
         dtS7ACeoFUFV57HgrCMNtW2+2wK+1Xw2vHuHMrUS82YRIqrRxwQ4RmcIJ6Lz8BfRAd
         NHCUxBuCmDUKntarI9AId7twJJtyEz+qgy4dnl8aseYnmNzosjsX7wOYSUEr+niWZC
         6+DjT0TZveIiHLxak3qQ4d1eGNfCxGUqxt/alnusUTdXAdvJz0vBZ/Yb6Ts5mkDOm7
         sxbveoGoFL1wg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix iput() on error pointer after error during orphan cleanup
Date:   Mon,  3 Jul 2023 18:15:31 +0100
Message-Id: <0acc9d8cea160460e4bf049d761d285697b925bf.1688403622.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688403622.git.fdmanana@suse.com>
References: <cover.1688403622.git.fdmanana@suse.com>
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

At btrfs_orphan_cleanup(), if we can't find an inode (btrfs_iget() returns
an -ENOENT error pointer), we proceed with 'ret' set to -ENOENT and the
inode pointer set to ERR_PTR(-ENOENT). Later when we proceed to the body
of the following if statement:

    if (ret == -ENOENT || inode->i_nlink) {
        (...)
        trans = btrfs_start_transaction(root, 1);
        if (IS_ERR(trans)) {
            ret = PTR_ERR(trans);
            iput(inode);
            goto out;
        }
        (...)
        ret = btrfs_del_orphan_item(trans, root,
                                    found_key.objectid);
        btrfs_end_transaction(trans);
        if (ret) {
            iput(inode);
            goto out;
        }
        continue;
    }

If we get an error from btrfs_start_transaction() or from the call to
btrfs_del_orphan_item() we end calling iput() against an inode pointer
that has a value of ERR_PTR(-ENOENT), resulting in a crash with the
following trace:

    [438876.667234] BUG: kernel NULL pointer dereference, address: 0000000000000096
    [438876.667456] #PF: supervisor read access in kernel mode
    [438876.667683] #PF: error_code(0x0000) - not-present page
    [438876.667868] PGD 0 P4D 0
    [438876.668050] Oops: 0000 [#1] PREEMPT SMP PTI
    [438876.668231] CPU: 0 PID: 2356187 Comm: mount Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
    [438876.668420] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
    [438876.668617] RIP: 0010:iput+0xa/0x20
    [438876.668818] Code: ff ff ff 66 (...)
    [438876.669274] RSP: 0018:ffffafa9c0c9f9d0 EFLAGS: 00010282
    [438876.669512] RAX: ffffffffffffffe4 RBX: 000000000009453b RCX: 0000000000000000
    [438876.669746] RDX: 0000000000000001 RSI: ffffafa9c0c9f930 RDI: fffffffffffffffe
    [438876.669989] RBP: ffff95c612f3b800 R08: 0000000000000001 R09: ffffffffffffffe4
    [438876.670231] R10: 00018f2a71010000 R11: 000000000ead96e3 R12: ffff95cb7d6909a0
    [438876.670476] R13: fffffffffffffffe R14: ffff95c60f477000 R15: 00000000ffffffe4
    [438876.670730] FS:  00007f5fbe30a840(0000) GS:ffff95ccdfa00000(0000) knlGS:0000000000000000
    [438876.670999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [438876.671296] CR2: 0000000000000096 CR3: 000000055e9f6004 CR4: 0000000000370ef0
    [438876.671648] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [438876.671984] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [438876.672264] Call Trace:
    [438876.744284]  <TASK>
    [438876.744589]  ? __die_body+0x1b/0x60
    [438876.744872]  ? page_fault_oops+0x15d/0x450
    [438876.745170]  ? __kmem_cache_alloc_node+0x47/0x410
    [438876.745459]  ? do_user_addr_fault+0x65/0x8a0
    [438876.745740]  ? exc_page_fault+0x74/0x170
    [438876.746021]  ? asm_exc_page_fault+0x22/0x30
    [438876.746305]  ? iput+0xa/0x20
    [438876.746586]  btrfs_orphan_cleanup+0x221/0x330 [btrfs]
    [438876.746917]  btrfs_lookup_dentry+0x58f/0x5f0 [btrfs]
    [438876.747251]  btrfs_lookup+0xe/0x30 [btrfs]
    [438876.747564]  __lookup_slow+0x82/0x130
    [438876.785817]  walk_component+0xe5/0x160
    [438876.786129]  path_lookupat.isra.0+0x6e/0x150
    [438876.786411]  filename_lookup+0xcf/0x1a0
    [438876.786687]  ? mod_objcg_state+0xd2/0x360
    [438876.786954]  ? obj_cgroup_charge+0xf5/0x110
    [438876.787255]  ? should_failslab+0xa/0x20
    [438876.787519]  ? kmem_cache_alloc+0x47/0x450
    [438876.787772]  vfs_path_lookup+0x51/0x90
    [438876.788023]  mount_subtree+0x8d/0x130
    [438876.788306]  btrfs_mount+0x149/0x410 [btrfs]
    [438876.788624]  ? __kmem_cache_alloc_node+0x47/0x410
    [438876.788899]  ? vfs_parse_fs_param+0xc0/0x110
    [438876.789175]  legacy_get_tree+0x24/0x50
    [438876.834144]  vfs_get_tree+0x22/0xd0
    [438876.852406]  path_mount+0x2d8/0x9c0
    [438876.852684]  do_mount+0x79/0x90
    [438876.852914]  __x64_sys_mount+0x8e/0xd0
    [438876.853135]  do_syscall_64+0x38/0x90
    [438876.899182]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
    [438876.958854] RIP: 0033:0x7f5fbe50b76a
    [438876.959113] Code: 48 8b 0d a9 (...)
    [438876.959578] RSP: 002b:00007fff01925798 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
    [438876.959808] RAX: ffffffffffffffda RBX: 00007f5fbe694264 RCX: 00007f5fbe50b76a
    [438876.960026] RDX: 0000561bde6c8720 RSI: 0000561bde6bdec0 RDI: 0000561bde6c31a0
    [438876.960238] RBP: 0000561bde6bdc70 R08: 0000000000000000 R09: 0000000000000001
    [438876.960448] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
    [438876.960657] R13: 0000561bde6c31a0 R14: 0000561bde6c8720 R15: 0000561bde6bdc70
    [438876.960868]  </TASK>

So fix this by setting 'inode' to NULL whenever we get an error from
btrfs_iget(), and to make the code simpler, stop testing for 'ret' being
-ENOENT to check if we have an inode - instead test for 'inode' being NULL
or not. Having a NULL 'inode' prevents any iput() call from crashing, as
iput() ignores NULL inode pointers. Also, stop testing for a NULL return
value from btrfs_iget() with PTR_ERR_OR_ZERO(), because btrfs_iget() never
returns NULL - in case an inode is not found, it returns ERR_PTR(-ENOENT),
and in case of memory allocation failure, it returns ERR_PTR(-ENOMEM).
We also don't need the extra iput() calls on the error branches for the
btrfs_start_transaction() and btrfs_del_orphan_item() calls, as we have
already called iput() before, so remove them.

Fixes: a13bb2c03848 ("btrfs: add missing iputs on orphan cleanup failure")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d919318d2498..c8921589e2f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3659,11 +3659,14 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		found_key.type = BTRFS_INODE_ITEM_KEY;
 		found_key.offset = 0;
 		inode = btrfs_iget(fs_info->sb, last_objectid, root);
-		ret = PTR_ERR_OR_ZERO(inode);
-		if (ret && ret != -ENOENT)
-			goto out;
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
+			inode = NULL;
+			if (ret != -ENOENT)
+				goto out;
+		}
 
-		if (ret == -ENOENT && root == fs_info->tree_root) {
+		if (!inode && root == fs_info->tree_root) {
 			struct btrfs_root *dead_root;
 			int is_dead_root = 0;
 
@@ -3724,8 +3727,8 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		 * deleted but wasn't. The inode number may have been reused,
 		 * but either way, we can delete the orphan item.
 		 */
-		if (ret == -ENOENT || inode->i_nlink) {
-			if (!ret) {
+		if (!inode || inode->i_nlink) {
+			if (inode) {
 				ret = btrfs_drop_verity_items(BTRFS_I(inode));
 				iput(inode);
 				inode = NULL;
@@ -3735,7 +3738,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			trans = btrfs_start_transaction(root, 1);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
-				iput(inode);
 				goto out;
 			}
 			btrfs_debug(fs_info, "auto deleting %Lu",
@@ -3743,10 +3745,8 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			ret = btrfs_del_orphan_item(trans, root,
 						    found_key.objectid);
 			btrfs_end_transaction(trans);
-			if (ret) {
-				iput(inode);
+			if (ret)
 				goto out;
-			}
 			continue;
 		}
 
-- 
2.34.1


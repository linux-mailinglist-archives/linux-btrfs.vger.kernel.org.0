Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360B5326680
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBZRwm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 12:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhBZRwd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 12:52:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B32A64F17;
        Fri, 26 Feb 2021 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614361912;
        bh=y2a2z5oq0Q8sTiF+vsTx2xsuUkUwkE+xjvVbFyw37d0=;
        h=From:To:Cc:Subject:Date:From;
        b=dp35la/+Ebqgm3qlwGxyRUnYuXLSrHD21mS5lFjsclr8hJ46Z+VSZERgjlyNbnfzM
         kv+UWvwnleYxqua3nx7e1wCAOu8krnXxwd52NH+ZlGzj58TISk4FuT6/aMRXkn1b0W
         8lnlfLKBOKfC+zfoWVWWV1aDPND7ydhq8m2GxTLYEuWkF4X+yAoBvN3oBSEWbNqQgp
         pb+8Xnq0x2TsC54RqImlbpbI/ApOXpmxrwO7ryxcxaxXRmf4z95fZGqGlDEWSy9FjK
         K/EO18XPwZZLM9Z8SVK+VDeMI94chf3S6AIJxvjq7mjL5efG+fHDAfk7n5Oass4H2B
         vRIOf4V0HrngQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     casey@schaufler-ca.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix warning when creating a directory with smack enabled
Date:   Fri, 26 Feb 2021 17:51:44 +0000
Message-Id: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we have smack enabled, during the creation of a directory smack may
attempt to add a "smack transmute" xattr on the inode, which results in
the following warning and trace:

[  220.732359] ------------[ cut here ]------------
[  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 start_transaction+0x489/0x4f0
[  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns (...)
[  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack+ #81
[  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
[  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
[  220.732447] Code: e9 be fc ff ff (...)
[  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
[  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 0000000000000003
[  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff888177849000
[  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 0000000000000004
[  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: ffffffffffffffe2
[  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff8881680d8000
[  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) knlGS:0000000000000000
[  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 0000000000370ee0
[  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  220.732475] Call Trace:
[  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
[  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
[  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
[  220.732496]  __vfs_setxattr+0x63/0x80
[  220.732502]  smack_d_instantiate+0x2d3/0x360
[  220.732507]  security_d_instantiate+0x29/0x40
[  220.732511]  d_instantiate_new+0x38/0x90
[  220.732515]  btrfs_mkdir+0x1cf/0x1e0
[  220.732521]  vfs_mkdir+0x14f/0x200
[  220.732525]  do_mkdirat+0x6d/0x110
[  220.732531]  do_syscall_64+0x2d/0x40
[  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  220.732537] RIP: 0033:0x7f673196ae6b
[  220.732540] Code: 8b 05 11 (...)
[  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
[  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f673196ae6b
[  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc3c67a30d
[  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 0000000000000000
[  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 0000000000000000
[  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007ffc3c679ce0
[  220.732563] irq event stamp: 11029
[  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>] console_unlock+0x486/0x670
[  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>] console_unlock+0xa1/0x670
[  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] asm_call_on_stack+0xf/0x20
[  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] asm_call_on_stack+0xf/0x20
[  220.732577] ---[ end trace 8f958916039daced ]---

This happens because at btrfs_mkdir() we call d_instantiate_new() while
holding a transaction handle, which results in the following call chain:

  btrfs_mkdir()
     trans = btrfs_start_transaction(root, 5);

     d_instantiate_new()
        smack_d_instantiate()
            __vfs_setxattr()
                btrfs_setxattr_trans()
                   btrfs_start_transaction()
                      start_transaction()
                         WARN_ON()
                           --> a tansaction start has TRANS_EXTWRITERS
                               set in its type
                         h->orig_rsv = h->block_rsv
                         h->block_rsv = NULL

     btrfs_end_transaction(trans)

Besides the warning triggered at start_transaction.c, we set the handle's
block_rsv to NULL which may cause some surprises later on.

So fix this by making btrfs_setxattr_trans() not start a transaction when
we already have a handle on one, stored in current->journal_info, and use
that handle. We are good to use the handle because at btrfs_mkdir() we did
reserve space for the xattr and the inode item.

Reported-by: Casey Schaufler <casey@schaufler-ca.com>
Link: https://lore.kernel.org/linux-btrfs/434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/xattr.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index af6246f36a9e..03135dbb318a 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -229,11 +229,33 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
+	const bool start_trans = (current->journal_info == NULL);
 	int ret;
 
-	trans = btrfs_start_transaction(root, 2);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	if (start_trans) {
+		/*
+		 * 1 unit for inserting/updating/deleting the xattr
+		 * 1 unit for the inode item update
+		 */
+		trans = btrfs_start_transaction(root, 2);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+	} else {
+		/*
+		 * This can happen when smack is enabled and a directory is being
+		 * created. It happens through d_instantiate_new(), which calls
+		 * smack_d_instantiate(), which in turn calls __vfs_setxattr() to
+		 * set the transmute xattr (XATTR_NAME_SMACKTRANSMUTE) on the
+		 * inode. We have already reserved space for the xattr and inode
+		 * update at btrfs_mkdir(), so just use the transaction handle.
+		 * We don't join or start a transaction, as that will reset the
+		 * block_rsv of the handle and trigger a warning for the start
+		 * case.
+		 */
+		ASSERT(strncmp(name, XATTR_SECURITY_PREFIX,
+			       XATTR_SECURITY_PREFIX_LEN) == 0);
+		trans = current->journal_info;
+	}
 
 	ret = btrfs_setxattr(trans, inode, name, value, size, flags);
 	if (ret)
@@ -244,7 +266,8 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	BUG_ON(ret);
 out:
-	btrfs_end_transaction(trans);
+	if (start_trans)
+		btrfs_end_transaction(trans);
 	return ret;
 }
 
-- 
2.28.0


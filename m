Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0C753B3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjGNMm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNMm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 08:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B62723
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 05:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A5161BD5
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 12:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C6FC433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689338530;
        bh=e8395rsgxwqY+K6yUgq1c6wtOh4RBd05pzwPojE6Vhw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cTWMs5h8aag3GF988dL7qqwuFTQBg/Yl/BN7qEFfUuInwgQO9e9su97WsoxqoNYne
         byWLnAnNL0mNt87S9nCHQd2a9RPEzB9BfgoZtrvYi+91BUxnUYsMrTQ1OTjEzkOQS/
         8OsdEYIvI8QrV0nfbtvTviqhuZpHYQ+mFXf1eNZBsxFn5N7bQzF+ZCxcVcGHmXRheH
         XR/dHfsc6c5ZCo1ID6iPNtWU7phFp70OdLQrdftmVtHetdHOBbYC73j41e7kB96iE4
         qMi1LSeIaTbgWJhDSzamcQTTivFCjc9he3y4GV+7uybCVnMTj7bpZgSdoJR+za3GLO
         cn/e7pXgZmXKw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix warning when putting transaction with qgroups enabled after abort
Date:   Fri, 14 Jul 2023 13:42:06 +0100
Message-Id: <a508af864554f90e8def36dafd2ab3ed9e5e6ee9.1689338421.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b3c8ed953bbac475211b40c2f100e57168a56f45.1689336707.git.fdmanana@suse.com>
References: <b3c8ed953bbac475211b40c2f100e57168a56f45.1689336707.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we have a transaction abort with qgroups enabled we get a warning
triggered when doing the final put on the transaction, like this:

  [161552.678901] ------------[ cut here ]------------
  [161552.681530] WARNING: CPU: 4 PID: 81745 at fs/btrfs/transaction.c:144 btrfs_put_transaction+0x123/0x130 [btrfs]
  [161552.681759] Modules linked in: btrfs blake2b_generic xor (...)
  [161552.681934] CPU: 4 PID: 81745 Comm: btrfs-transacti Tainted: G        W          6.4.0-rc6-btrfs-next-134+ #1
  [161552.681945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
  [161552.681951] RIP: 0010:btrfs_put_transaction+0x123/0x130 [btrfs]
  [161552.682139] Code: bd a0 01 00 (...)
  [161552.682146] RSP: 0018:ffffa168c0527e28 EFLAGS: 00010286
  [161552.682155] RAX: ffff936042caed00 RBX: ffff93604a3eb448 RCX: 0000000000000000
  [161552.682161] RDX: ffff93606421b028 RSI: ffffffff92ff0878 RDI: ffff93606421b010
  [161552.682166] RBP: ffff93606421b000 R08: 0000000000000000 R09: ffffa168c0d07c20
  [161552.682171] R10: 0000000000000000 R11: ffff93608dc52950 R12: ffffa168c0527e70
  [161552.682175] R13: ffff93606421b000 R14: ffff93604a3eb420 R15: ffff93606421b028
  [161552.682181] FS:  0000000000000000(0000) GS:ffff93675fb00000(0000) knlGS:0000000000000000
  [161552.682187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [161552.682193] CR2: 0000558ad262b000 CR3: 000000014feda005 CR4: 0000000000370ee0
  [161552.682211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [161552.682216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [161552.682221] Call Trace:
  [161552.682229]  <TASK>
  [161552.682236]  ? __warn+0x80/0x130
  [161552.682250]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
  [161552.682430]  ? report_bug+0x1f4/0x200
  [161552.682444]  ? handle_bug+0x42/0x70
  [161552.682456]  ? exc_invalid_op+0x14/0x70
  [161552.682467]  ? asm_exc_invalid_op+0x16/0x20
  [161552.682483]  ? btrfs_put_transaction+0x123/0x130 [btrfs]
  [161552.682661]  btrfs_cleanup_transaction+0xe7/0x5e0 [btrfs]
  [161552.682838]  ? _raw_spin_unlock_irqrestore+0x23/0x40
  [161552.682847]  ? try_to_wake_up+0x94/0x5e0
  [161552.682856]  ? __pfx_process_timeout+0x10/0x10
  [161552.682872]  transaction_kthread+0x103/0x1d0 [btrfs]
  [161552.683047]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
  [161552.683217]  kthread+0xee/0x120
  [161552.683227]  ? __pfx_kthread+0x10/0x10
  [161552.683237]  ret_from_fork+0x29/0x50
  [161552.683259]  </TASK>
  [161552.683262] ---[ end trace 0000000000000000 ]---

This corresponds to this line of code:

  void btrfs_put_transaction(struct btrfs_transaction *transaction)
  {
      (...)
          WARN_ON(!RB_EMPTY_ROOT(
                          &transaction->delayed_refs.dirty_extent_root));
      (...)
  }

The warning happens because btrfs_qgroup_destroy_extent_records(), called
in the transaction abort path, we free all entries from the rbtree
"dirty_extent_root" with rbtree_postorder_for_each_entry_safe(), but we
don't actually empty the rbtree - it's still pointing to nodes that were
freed.

So set the rbtree's root node to NULL to avoid this warning (assign
RB_ROOT).

Fixes: 81f7eb00ff5b ("btrfs: destroy qgroup extent records on transaction abort")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use RB_ROOT macro instead of assigning NULL directly to the root's rb_node.

 fs/btrfs/qgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index da1f84a0eb29..2637d6b157ff 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4445,4 +4445,5 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
+	*root = RB_ROOT;
 }
-- 
2.34.1


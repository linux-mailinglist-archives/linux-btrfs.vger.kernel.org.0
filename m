Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD6735C1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjFSQWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSQWA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 12:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874DE5C
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 09:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B18FB60CEC
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5D5C433C9
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687191718;
        bh=b4FRC1CrWDiG+P0AmSwVkk2JbD/fLzpFs+31aQViJ/Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YrFoAnXiPCtFiC3ONdB5c2WAxYxSufaapaz/SC3489AR7SKhM7P717X+rI8GXrwpQ
         1P8njTBmC8IV809qeP0+HL9r/C+F5eOIxOYiXhSCFN0NFsowHe4Gm8Pe6rFofh0rjO
         mbsdJw3Jh2Y7c8pEDRY4e/+h+sYwGPYb11BvRuaLj1WqgiOYqbuJUVm5BeI2kL8aHv
         5xUmKtvOP6Fcdvkr0GJ2CoqUN5m+GtNR8MSHszjS4k4shsb/UNTD7ZGwTA11iH+wTR
         BmByeeqzhxUFregPwchcghiv/bogBh8en2SNFzMZj/3N4sFWpDxsd2c7WOd3Tr0iQU
         EN+kYhVN+utUw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix race when deleting quota root from the dirty cow roots list
Date:   Mon, 19 Jun 2023 17:21:47 +0100
Message-Id: <f7a7da2fc74fb35b27a50d9241252547bada0693.1687185583.git.fdmanana@suse.com>
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

When disabling quotas we are deleting the quota root from the list
fs_info->dirty_cowonly_roots without taking the lock that protects it,
which is struct btrfs_fs_info::trans_lock. This unsynchronized list
manipulation may cause chaos if there's another concurrent manipulation
of this list, such as when adding a root to it with
ctree.c:add_root_to_dirty_list().

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
the quota root from that list.

Fixes: bed92eae26cc ("Btrfs: qgroup implementation and prototypes")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f41da7ac360d..f8735b31da16 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1301,7 +1301,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	spin_lock(&fs_info->trans_lock);
 	list_del(&quota_root->dirty_list);
+	spin_unlock(&fs_info->trans_lock);
 
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clear_buffer_dirty(trans, quota_root->node);
-- 
2.34.1


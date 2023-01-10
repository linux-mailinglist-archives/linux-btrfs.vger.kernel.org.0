Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3876639C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 08:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjAJHOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 02:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjAJHOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 02:14:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADAB44C5B
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Jan 2023 23:14:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF0A14DF96;
        Tue, 10 Jan 2023 07:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673334875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EiaPNyugMQ7I8x3WmTllaOf8vPTtfqj9TQ0qseqRL38=;
        b=FPP+yAc4lDz0E3WyqAK5lucaGD8EqbpVhnWXEhqfJ1IAEA51VTXzo2HRBney8ipMjLZWCV
        IBM+qFmHob+PGP1sZmNZii6sAXQ9m/CUwFyAQNa8+l7HQm4YtYnkZnkigDg5eMZOKciT5X
        dYjOKlpiO2oV0IGDpbftbGv8MVGODF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E457113338;
        Tue, 10 Jan 2023 07:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bJutK1oQvWO7aQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 10 Jan 2023 07:14:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Lukas Straub <lukasstraub2@web.de>,
        HanatoK <summersnow9403@gmail.com>
Subject: [PATCH] btrfs: qgroup: do not warn on record without @old_roots populated
Date:   Tue, 10 Jan 2023 15:14:17 +0800
Message-Id: <de9535cd9d3b5b020190bbfc751c3705fee8d55d.1673334821.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is some reports from the mailing list that since v6.1 kernel, the
WARN_ON() inside btrfs_qgroup_account_extent() get triggered during
rescan:

 ------------[ cut here ]------------
 WARNING: CPU: 3 PID: 6424 at fs/btrfs/qgroup.c:2756 btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
 CPU: 3 PID: 6424 Comm: snapperd Tainted: P           OE      6.1.2-1-default #1 openSUSE Tumbleweed 05c7a1b1b61d5627475528f71f50444637b5aad7
 RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
 Call Trace:
  <TASK>
 btrfs_commit_transaction+0x30c/0xb40 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
  ? start_transaction+0xc3/0x5b0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
 btrfs_qgroup_rescan+0x42/0xc0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
  btrfs_ioctl+0x1ab9/0x25c0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
  ? __rseq_handle_notify_resume+0xa9/0x4a0
  ? mntput_no_expire+0x4a/0x240
  ? __seccomp_filter+0x319/0x4d0
  __x64_sys_ioctl+0x90/0xd0
  do_syscall_64+0x5b/0x80
  ? syscall_exit_to_user_mode+0x17/0x40
  ? do_syscall_64+0x67/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0033:0x7fd9b790d9bf
  </TASK>
 ---[ end trace 0000000000000000 ]---

[CAUSE]
Since commit e15e9f43c7ca ("btrfs: introduce
BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"), if
our qgroup is already in inconsistent status, we will no longer do the
time-consuming backref walk.

This can leave some qgroup records without a valid old_roots ulist.
Normally this is fine, as btrfs_qgroup_account_extents() would also skip
those records if we have NO_ACCOUNTING flag set.

But there is a small window, if we have NO_ACCOUNTING flag set, and
inserted some qgroup_record without a old_roots ulist, but then the user
triggered a qgroup rescan.

During btrfs_qgroup_rescan(), we firstly clear NO_ACCOUNTING flag, then
commit current transaction.

And since we have a qgroup_record with old_roots = NULL, we trigger the
WARN_ON() during btrfs_qgroup_account_extents().

[FIX]
Unfortunately due to the introduce of NO_ACCOUNTING flag, the assumption
that every qgroup_record would has its old_roots populated is no longer
correct.

So to fix the false alerts, just change the WARN_ON() to unlikely().

Reported-by: Lukas Straub <lukasstraub2@web.de>
Reported-by: HanatoK <summersnow9403@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/2403c697-ddaf-58ad-3829-0335fc89df09@gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d275bf24b250..6a1aedf0dc72 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2765,9 +2765,19 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 
 			/*
 			 * Old roots should be searched when inserting qgroup
-			 * extent record
+			 * extent record.
+			 *
+			 * But for INCONSISTENT (NO_ACCOUNTING) -> rescan case,
+			 * we may have some record inserted during
+			 * NO_ACCOUNTING (thus no old_roots populated), but
+			 * later we start rescan, which clears NO_ACCOUNTING,
+			 * leaving some inserted records without old_roots
+			 * populated.
+			 *
+			 * Those cases are rare and should not cause too much
+			 * time spent during commit_transaction().
 			 */
-			if (WARN_ON(!record->old_roots)) {
+			if (unlikely(!record->old_roots)) {
 				/* Search commit root to find old_roots */
 				ret = btrfs_find_all_roots(&ctx, false);
 				if (ret < 0)
-- 
2.39.0


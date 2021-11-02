Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D20442E72
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 13:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKBMvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 08:51:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39280 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBMvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 08:51:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87DE51FD3D;
        Tue,  2 Nov 2021 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635857357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zYVaif4wR7oL8o2BtndkDlh3Ggv9y4LmZUpKJ25luFg=;
        b=JlvA2uId7K9Il75PmVDaSXxtO+ZIV3pHN/OpixAxeWnuJeVm/nvfZSl2LWPPVkwf/MRebN
        aMzS/o/kXO8buVakcGhiimR2qvTy2877YohQ/whk+auUxUoL+/VMi1RZivpKlvxQGX3sbK
        9q3ODznabslyCmfuhzW3vMj3j0+7n/M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D09413BF7;
        Tue,  2 Nov 2021 12:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wm9LEM0zgWFBdAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 02 Nov 2021 12:49:17 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] btrfs: fix memory ordering between normal and ordered work functions
Date:   Tue,  2 Nov 2021 14:49:16 +0200
Message-Id: <20211102124916.433836-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ordered work functions aren't guaranteed to be handled by the same thread
which executed the normal work functions. The only way execution between
normal/ordered functions is synchronized is via the WORK_DONE_BIT,
unfortunately the used bitops don't guarantee any ordering whatsoever.

This manifested as seemingly inexplicable crashes on arm64, where
async_chunk::inode is seens as non-null in async_cow_submit which causes
submit_compressed_extents to be called and crash occurs because
async_chunk::inode suddenly became NULL. The call trace was similar to:

    pc : submit_compressed_extents+0x38/0x3d0
    lr : async_cow_submit+0x50/0xd0
    sp : ffff800015d4bc20

    <registers omitted for brevity>

    Call trace:
     submit_compressed_extents+0x38/0x3d0
     async_cow_submit+0x50/0xd0
     run_ordered_work+0xc8/0x280
     btrfs_work_helper+0x98/0x250
     process_one_work+0x1f0/0x4ac
     worker_thread+0x188/0x504
     kthread+0x110/0x114
     ret_from_fork+0x10/0x18

Fix this by adding respective barrier calls which ensure that all
accesses preceding setting of WORK_DONE_BIT are strictly ordered before
settint the flag. At the same time add a read barrier after reading of
WORK_DONE_BIT in run_ordered_work which ensures all subsequent loads
would be strictly ordered after reading the bit. This in turn ensures
are all accesses before WORK_DONE_BIT are going to be strictly ordered
before any access that can occur in ordered_func.

Fixes: 08a9ff326418 ("btrfs: Added btrfs_workqueue_struct implemented ordered execution based on kernel workqueue")
Reported-by: Chris Murphy <lists@colorremedies.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2011928
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

David,

IMO this is stable material.

 fs/btrfs/async-thread.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 309516e6a968..d39af03b456c 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -234,6 +234,13 @@ static void run_ordered_work(struct __btrfs_workqueue *wq,
 				  ordered_list);
 		if (!test_bit(WORK_DONE_BIT, &work->flags))
 			break;
+		/*
+		 * Orders all subsequent loads after reading WORK_DONE_BIT,
+		 * paired with the smp_mb__before_atomic in btrfs_work_helper
+		 * this guarantees that the ordered function will see all
+		 * updates from ordinary work function.
+		 */
+		smp_rmb();

 		/*
 		 * we are going to call the ordered done function, but
@@ -317,6 +324,13 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	thresh_exec_hook(wq);
 	work->func(work);
 	if (need_order) {
+		/*
+		 * Ensures all memory accesses done in the work function are
+		 * ordered before setting the WORK_DONE_BIT.Ensuring the thread
+		 * which is going to executed the ordered work sees them.
+		 * Pairs with the smp_rmb in run_ordered_work.
+		 */
+		smp_mb__before_atomic();
 		set_bit(WORK_DONE_BIT, &work->flags);
 		run_ordered_work(wq, work);
 	} else {
--
2.25.1


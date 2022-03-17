Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975104DBBA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 01:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbiCQAYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 20:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCQAYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 20:24:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90710F50
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 17:23:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD52F210F9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647476610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=S4rIjdVveBk5W3Ods7oNOD+lgCY1Pf4VqqXRl82flOA=;
        b=A2aY91yv9dz1dVD4ryMLc0kZdzCMumecPMkIsoiT30ylPOWFNXcMVdYvq6oPmxNNoDx04x
        uvTJSC6ssV3J4lKMKkriir+NqKnyP5iQN4IyInjifjGU4lCLaaeRFJYKfWF0TyACmpwotZ
        ybDqtPUjfe3/lWCykPgVvz0mGdOXMk8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DEB813B4D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 00:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hv5YNoF/MmJAZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 00:23:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the uninitialized btrfs_bio::iter
Date:   Thu, 17 Mar 2022 08:23:12 +0800
Message-Id: <f7698bebfcbd1687dbf8742290cd8d88b891590f.1647476483.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are reports about compression crash with error injection, mostly
triggering the following ASSERT()s in dec_and_test_compressed_bio():

	ASSERT(btrfs_bio(bio)->iter.bi_size);

The call trace triggered by generic/475 (needs compress mount option)
looks like this:

  assertion failed: btrfs_bio(bio)->iter.bi_size, in fs/btrfs/compression.c:213
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3551!
  invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
  CPU: 5 PID: 6548 Comm: fsstress Tainted: G           OE     5.17.0-rc7-custom+ #10
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
  Call Trace:
   <TASK>
   dec_and_test_compressed_bio.cold+0x16/0x2c [btrfs]
   end_compressed_bio_read+0x37/0x170 [btrfs]
   btrfs_submit_compressed_read+0x803/0x820 [btrfs]
   submit_one_bio+0xc7/0x100 [btrfs]
   btrfs_readpage+0xec/0x130 [btrfs]
   filemap_read_folio+0x53/0xf0
   filemap_get_pages+0x6f3/0xa10
   filemap_read+0x1d6/0x520
   new_sync_read+0x24e/0x360
   vfs_read+0x1a1/0x2a0
   ksys_read+0xc9/0x160
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x44/0xae

[CAUSE]
Unlike regular IO path, we will initialize btrfs_bio::iter in
btrfs_map_bio(), for error path, we have to manually initialize
btrfs_bio::iter before calling the endio function.

In above case, due to injected errors, we go to finish_cb: tag directly
without submitting with btrfs_map_bio() call.

This leaves btrfs_bio::iter for the compressed bio uninitialized and
caught by the ASSERT().

[FIX]
Fix it by calling btrfs_bio_save_iter() before we call endio for the
compressed bio.

Please fold this fix into commit "btrfs: make
dec_and_test_compressed_bio() to be split bio compatible".

If needed, I can update the series and resend, but if this is the only
problem, it may be better not to flood the list with 17 patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0bf694038c61..2df034f6194c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -582,6 +582,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 finish_cb:
 	if (bio) {
 		bio->bi_status = ret;
+		btrfs_bio_save_iter(btrfs_bio(bio));
 		bio_endio(bio);
 	}
 	/* Last byte of @cb is submitted, endio will free @cb */
@@ -924,6 +925,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 finish_cb:
 	if (comp_bio) {
 		comp_bio->bi_status = ret;
+		btrfs_bio_save_iter(btrfs_bio(comp_bio));
 		bio_endio(comp_bio);
 	}
 	/* All bytes of @cb is submitted, endio will free @cb */
-- 
2.35.1


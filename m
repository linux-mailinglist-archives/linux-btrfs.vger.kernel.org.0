Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E464F7A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 05:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiLQE5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 23:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLQE5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 23:57:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD47CE24
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 20:57:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DADF3375FD
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 04:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671253048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OxX+555SyDKV6sTUZbXu11SK1vJkNIAdzBxFQ7pxAAk=;
        b=Bnxf7VOCVtZC64Wi5RY4YEeH3HxRSpnpeQd/JAeRCk/DGQhGBLFpveSILSCMVdDQsp/52t
        gOvv8P5S3X9hCpo7t9Rh6Q1b0o6eMWpFUkH7Up9C7R56FWrA1/u+hkC6eN5HJF5m9yyr3t
        tfqVN7dxzxSK3/qbaLxYvZ2FQCG5uVA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 378D51326D
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 04:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fx6bAThMnWNzSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Dec 2022 04:57:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't clear EXTENT_BUFFER_DIRTY bit if the tree block is not dirtied in our transaction
Date:   Sat, 17 Dec 2022 12:57:10 +0800
Message-Id: <ed62dbe7094fb5e80cb5b6df8590ff621b218ae5.1671252987.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since patch "btrfs: do not check header generation in
btrfs_clean_tree_block", a lot of scrub tests will report errors like
btrfs/072:

  QA output created by 072
  Silence is golden
  Scrub find errors in "-m single -d single" test

With newer scrub metadata error reports, we can see the bad tree blocks
are having older fsid from previous runs:

 BTRFS warning (device dm-2): tree block 24117248 mirror 1 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
 BTRFS warning (device dm-2): tree block 24117248 mirror 0 has bad fsid, has b77cd862-f150-4c71-90ec-7baf0544d83f want 17df6abf-23cd-445f-b350-5b3e40bfd2fc
 BTRFS error (device dm-2): bdev /dev/mapper/test-scratch2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0

This means, some tree blocks of commit roots are not properly written
back to disks.

[CAUSE]
Patch "btrfs: do not check header generation in btrfs_clean_tree_block"
will unconditionally clear the DIRTY flag, but there is a race that we
can clear the DIRTY flag for extent buffers which is under writeback:

            Transaction A             |   Transaction A + 1
--------------------------------------+----------------------------------
 btrfs_cow_block()                    |
 |- __btrfs_cow_block()               |
    |- btrfs_alloc_tree_block()       |
    |  Tree block X get allocated     |
    |  Generation is A, and marked    |
    |  dirty.                         |
                                      |
 btrfs_commit_transaction()           |
 | Tree block X should be written     |
 | back. As it's dirtied in           |
 | transaction A.                     |
 |                                    |
 |- cur_trans->state =                |
 |  TRANS_STATE_UNBLOCKED             |
 |  Now new transaction can be        |
 |  started.                          |
 |                                    | Transaction A + 1 started
 |                                    |
 |                                    | btrfs_cow_block()
 |                                    | |- __btrfs_cow_block()
 |                                    |    |- update_ref_for_cow()
 |                                    |    |- btrfs_clear_buffer_dirty()
 |                                    |    |  Tree block X get freed, thus
 |                                    |       its DIRTY flag get cleared.
 |                                    |       And its pages are no
 |                                    |       longer dirty.
 |                                    |
 |- btrfs_write_and_wait_transaction()|
    |- btrfs_write_marked_extents()   |
       Here we will only writeback    |
       dirty pages, and tree block X  |
       no longer has its pages dirty, |
       it will no be written back.    |

Thus those tree blocks don't get written back and cause above fsid
mismatch during scrub.

[FIX]
Just bring back the check of the old code, with added commt on why we
should not clear dirty flag unconditionally.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch should just be used for testing.

The proper fix would be an update of the series "extent buffer dirty
cleanups", which should remove the patch "btrfs: do not check header
generation in btrfs_clean_tree_block" completely.

But I really believe we need a new comment on the original check anyway.
---
 fs/btrfs/extent_io.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4f96f9603ec2..3e793d92d386 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -36,6 +36,7 @@
 #include "file.h"
 #include "dev-replace.h"
 #include "super.h"
+#include "transaction.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
@@ -4704,6 +4705,19 @@ void btrfs_clear_buffer_dirty(struct extent_buffer *eb)
 
 	btrfs_assert_tree_write_locked(eb);
 
+	/*
+	 * Do not clear the dirty flag for an extent buffer which is not
+	 * modified in the current running transaction.
+	 *
+	 * The tree block may belong to previous transaction which is still
+	 * waiting for writeback.
+	 * Clearing the dirity bit unconditionally will make the previous
+	 * transaction to miss its tree blocks, screwing up anything relying
+	 * on commit root, from scrub to powerloss protection.
+	 */
+	if (btrfs_header_generation(eb) != fs_info->running_transaction->transid)
+		return;
+
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
-- 
2.39.0


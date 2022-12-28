Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5886587E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 00:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiL1Xct (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 18:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiL1Xcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 18:32:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5754B120A9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 15:32:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0807721A1D;
        Wed, 28 Dec 2022 23:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672270365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SePMLUpuYNb334AOrOSebwdDrYLLMxQkxD8qI4t3YM=;
        b=NjZnO+ZToqIGkUpJtgYnDFMtYWKTbjgkI0IWK3XLX8rQF/GWprCmotsPAMRq4pguqpVOng
        B5eK1K0wMY/lgzFossJM47gBm1/iKA+yT4RFRQx/esVvXH4tsmQMxJN7Pjk5LwBSx7Nv6w
        MSrHI7wglTuDdQwNOP/WqBMfmzJPK5c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 279C0138F9;
        Wed, 28 Dec 2022 23:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJyvOBvSrGP/BAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 28 Dec 2022 23:32:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH 2/2] btrfs: fix the false alert on bad tree level
Date:   Thu, 29 Dec 2022 07:32:24 +0800
Message-Id: <21f5e59776ba70104bea88c1c190e2b9bd17ca14.1672190127.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672190127.git.wqu@suse.com>
References: <cover.1672190127.git.wqu@suse.com>
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
There is a bug report that on a RAID0 nvme btrfs system, under heavy
write load the fs can flip RO randomly.

With extra debug, it shows some tree blocks failed to pass its level
checks, and if that happens at critical path of a transaction, we abort
the transacation:

 BTRFS error (device nvme0n1p3): level verify failed on logical 5446121209856 mirror 1 wanted 0 found 1
 BTRFS error (device nvme0n1p3: state A): Transaction aborted (error -5)
 BTRFS: error (device nvme0n1p3: state A) in btrfs_finish_ordered_io:3343: errno=-5 IO failure
 BTRFS info (device nvme0n1p3: state EA): forced readonly

[CAUSE]
The reporter has already bisected to commit 947a629988f1 ("btrfs: move
tree block parentness check into validate_extent_buffer()").

And with extra debug, it shows we can have btrfs_tree_parent_check
filled with all zero in the following call trace:

  <TASK>
  submit_one_bio+0xd4/0xe0
  submit_extent_page+0x142/0x550
  read_extent_buffer_pages+0x584/0x9c0
  ? __pfx_end_bio_extent_readpage+0x10/0x10
  ? folio_unlock+0x1d/0x50
  btrfs_read_extent_buffer+0x98/0x150
  read_tree_block+0x43/0xa0
  read_block_for_search+0x266/0x370
  btrfs_search_slot+0x351/0xd30
  ? lock_is_held_type+0xe8/0x140
  btrfs_lookup_csum+0x63/0x150
  btrfs_csum_file_blocks+0x197/0x6c0
  ? sched_clock_cpu+0x9f/0xc0
  ? lock_release+0x14b/0x440
  ? _raw_read_unlock+0x29/0x50
  btrfs_finish_ordered_io+0x441/0x860
  btrfs_work_helper+0xfe/0x400
  ? lock_is_held_type+0xe8/0x140
  process_one_work+0x294/0x5b0
  worker_thread+0x4f/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xf5/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2c/0x50
  </TASK>

Currently we only copy the btrfs_tree_parent_check structure into bbio
at read_extent_buffer_pages() after we have assembled the bbio.

But as shown in the above call trace, submit_extent_page() itself can
already submit the bbio, leaving the bbio->parent_check uninitialized,
and cause the false alert.

[FIX]
Instead of copying @check into bbio after bbio is assembled, we pass
@check in btrfs_bio_ctrl::parent_check, and copy the content of
parent_check in submit_one_bio() for metadata read.

By this, we should be able to pass the needed info for metadata endio
verification, and fix the false alert.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Fixes: 947a629988f1 ("btrfs: move tree block parentness check into validate_extent_buffer()")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 83dd3aa59663..b11332482d57 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -103,6 +103,16 @@ struct btrfs_bio_ctrl {
 	u32 len_to_oe_boundary;
 	btrfs_bio_end_io_t end_io_func;
 
+	/*
+	 * This is for metadata read, to provide the extra needed
+	 * verification info.
+	 * This has to be provided for submit_one_bio(), as submit_one_bio()
+	 * can submit a bio if it ends at stripe boundary.
+	 * If no such parent_check provided, the metadata can hit false alert
+	 * at endio time.
+	 */
+	struct btrfs_tree_parent_check *parent_check;
+
 	/*
 	 * Tell writepage not to lock the state bits for this range, it still
 	 * does the unlocking.
@@ -133,13 +143,24 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
-	if (!is_data_inode(&inode->vfs_inode))
+	if (!is_data_inode(&inode->vfs_inode)) {
+		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
+			/*
+			 * For metadata read, we should have the parent_check,
+			 * and copy it to bbio for metadata verification.
+			 */
+			ASSERT(bio_ctrl->parent_check);
+			memcpy(&btrfs_bio(bio)->parent_check,
+			       bio_ctrl->parent_check,
+			       sizeof(struct btrfs_tree_parent_check));
+		}
 		btrfs_submit_metadata_bio(inode, bio, mirror_num);
-	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+	} else if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		btrfs_submit_data_write_bio(inode, bio, mirror_num);
-	else
+	} else {
 		btrfs_submit_data_read_bio(inode, bio, mirror_num,
 					   bio_ctrl->compress_type);
+	}
 
 	/* The bio is owned by the end_io handler now */
 	bio_ctrl->bio = NULL;
@@ -4829,6 +4850,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct extent_state *cached_state = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.mirror_num = mirror_num,
+		.parent_check = check,
 	};
 	int ret = 0;
 
@@ -4878,7 +4900,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		 */
 		atomic_dec(&eb->io_pages);
 	}
-	memcpy(&btrfs_bio(bio_ctrl.bio)->parent_check, check, sizeof(*check));
 	submit_one_bio(&bio_ctrl);
 	if (ret || wait != WAIT_COMPLETE) {
 		free_extent_state(cached_state);
@@ -4905,6 +4926,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	unsigned long num_reads = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.mirror_num = mirror_num,
+		.parent_check = check,
 	};
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
@@ -4996,7 +5018,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		}
 	}
 
-	memcpy(&btrfs_bio(bio_ctrl.bio)->parent_check, check, sizeof(*check));
 	submit_one_bio(&bio_ctrl);
 
 	if (ret || wait != WAIT_COMPLETE)
-- 
2.39.0


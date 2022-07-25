Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9D57F912
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiGYFii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiGYFie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81967101CE
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EC6A1F992
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzoKvqArmDq0IxdcurTeKhMOUl2ijHIpRQqglPs0l24=;
        b=B9R8peLWSeIruBlVcFz9539X8/f1XXbhfTOjgNs2WPO2dNTOKNd9kXan3DePkE62EtrwBB
        sMePU0ck5oyOTs9nDbSbR07bTogR6Z8FW+PEmux00BiPkE7UBIIL5mtLNzPtNOZSkK29ub
        3iMEuORW1SWv/RZ2+JFZ3gQunY7lVac=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5D8513A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMh+HVcs3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/14] btrfs: avoid recording full stripe write into write-intent bitmaps
Date:   Mon, 25 Jul 2022 13:38:01 +0800
Message-Id: <441b7bd4a0966c9f1d7ef17dea7a2e875440a728.1658726692.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
References: <cover.1658726692.git.wqu@suse.com>
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

Full stripe write can happen in the following cases:

- Writing into a completely new stripe
  In this case, even if powerloss happened, we won't have any committed
  metadata referring the new full stripe.

  Thus we don't need to recover.

- Writing into a NODATACOW range
  In this case, although in theory we should recovery after power loss,
  but NODATACOW implies NODATASUM, thus we have no way to determine
  which data is correct.

  Thus we don't need to and can't recover either.

So just avoid recording full stripe write into write-intent bitmaps.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0a0a2a1e96c3..37e5fd5df1f9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -818,8 +818,13 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	if (rbio->generic_bio_cnt)
 		btrfs_bio_counter_sub(rbio->bioc->fs_info, rbio->generic_bio_cnt);
 
-	/* Clear the write-intent bitmap range for write operation. */
-	if (rbio->operation == BTRFS_RBIO_WRITE)
+	/*
+	 * Clear the write-intent bitmap range for write operation.
+	 * For full stripe write we didn't record it into write-intent thus no
+	 * need to clear the bits for full stripe write.
+	 */
+	if (rbio->operation == BTRFS_RBIO_WRITE &&
+	    rbio->bio_list_bytes < rbio->nr_data * BTRFS_STRIPE_LEN)
 		btrfs_write_intent_clear_dirty(rbio->bioc->fs_info,
 				       rbio->bioc->raid_map[0],
 				       rbio->nr_data * BTRFS_STRIPE_LEN);
@@ -1342,13 +1347,19 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	atomic_set(&rbio->stripes_pending, bio_list_size(&bio_list));
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
-	/* Update the write intent bitmap before we start submitting bios. */
-	btrfs_write_intent_mark_dirty(bioc->fs_info, rbio->bioc->raid_map[0],
-				     rbio->nr_data * BTRFS_STRIPE_LEN, &event);
-	ret = btrfs_write_intent_writeback(bioc->fs_info, event);
+	/*
+	 * Update the write intent bitmap if it's a sub-stripe write,
+	 * before we start submitting bios.
+	 */
+	if (rbio->bio_list_bytes < rbio->nr_data * BTRFS_STRIPE_LEN) {
+		btrfs_write_intent_mark_dirty(bioc->fs_info,
+				rbio->bioc->raid_map[0],
+				rbio->nr_data * BTRFS_STRIPE_LEN, &event);
+		ret = btrfs_write_intent_writeback(bioc->fs_info, event);
+		if (ret < 0)
+			goto cleanup;
+	}
 
-	if (ret < 0)
-		goto cleanup;
 	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_end_io = raid_write_end_io;
 
-- 
2.37.0


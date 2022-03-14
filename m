Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27CE4D7E20
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiCNJJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiCNJJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76D91A83F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:07:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E1741F391
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTkbdFo48uDg1qSnPgOWJAfLV9KpubPkJFizQbtiMdM=;
        b=iMPrtjVgrMas2AOEXYgQWsJ2RNAvTGjNkysQ2ojQyEy+a3ywd1Tw0fTK3Av9pwjUFgXo2E
        0BzaOlPYQ3IR6dCABk/ho+B+yaUO2P7LwQgvFvbZIl/lDYRx3Kspeh/eBabtbrlXdtPe/+
        Ft+AAi7pSQoo9W06iZybpPcE2OaYCKM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90E0D13ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SHS0FuYFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 01/18] btrfs: update an stale comment on btrfs_submit_bio_hook()
Date:   Mon, 14 Mar 2022 17:07:14 +0800
Message-Id: <b361293b6a5724d3351fb2e476014fb461eec336.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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

This function is renamed to btrfs_submit_data_bio(), update the comment
and add extra reason why it doesn't completely follow the same rule in
btrfs_submit_data_bio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e7143ff5523..dded46291637 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7893,7 +7893,13 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
-	/* Check btrfs_submit_bio_hook() for rules about async submit. */
+	/*
+	 * Check btrfs_submit_data_bio() for rules about async submit.
+	 *
+	 * The only exception is for RAID56, when there are more than one bios
+	 * to submit, async submit seems to make it harder to collect csums
+	 * for the full stripe.
+	 */
 	if (async_submit)
 		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-- 
2.35.1


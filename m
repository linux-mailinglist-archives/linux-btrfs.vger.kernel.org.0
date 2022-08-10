Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7314558E6E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiHJF7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHJF7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 01:59:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F4A85F97
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 22:59:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F32DC3745D
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660111155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=S3UkVM3gkN9CX4w5Qn0YrZREb4KX0XgznIB+fpRgjcs=;
        b=s71pE17WROCXwaqrlVTEEmWUlci2vhHho0biGXiW8E4bUofA2dz0vCHGajs6T9ZVMZDvUM
        XNWvcameIjGlYdEbmXZUks02o63veEtrtkDcViOz943K76vMGStI99F6ky7nmXuTBMBIZ3
        ncls90/5VSPXeTVKKIN7SywwBqFonIY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AFBD13A7E
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 05:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TW5sOzJJ82JILgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 05:59:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: remove impossible sanity checks
Date:   Wed, 10 Aug 2022 13:58:57 +0800
Message-Id: <85c8bd723773791d0b74028488a821b42d83d48f.1660111131.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
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

There are several sanity checks which are no longer possible to trigger
inside btrfs_scrub_dev().

Since we have mount time check against super block nodesize/sectorsize,
and our fixed macro is hardcoded to handle even the worst combination.

Thus those sanity checks are no longer needed, can be easily removed.

But this patch still uses some ASSERT()s as a safe net just in case we
change some features in the future to trigger those impossible
combinations.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d05025034b0a..c4e030661fac 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4096,32 +4096,16 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (btrfs_fs_closing(fs_info))
 		return -EAGAIN;
 
-	if (fs_info->nodesize > BTRFS_STRIPE_LEN) {
-		/*
-		 * in this case scrub is unable to calculate the checksum
-		 * the way scrub is implemented. Do not handle this
-		 * situation at all because it won't ever happen.
-		 */
-		btrfs_err(fs_info,
-			   "scrub: size assumption nodesize <= BTRFS_STRIPE_LEN (%d <= %d) fails",
-		       fs_info->nodesize,
-		       BTRFS_STRIPE_LEN);
-		return -EINVAL;
-	}
+	/* At mount time we have ensured nodesize is in the range of [4K, 64K]. */
+	ASSERT(fs_info->nodesize <= BTRFS_STRIPE_LEN);
 
-	if (fs_info->nodesize >
-	    SCRUB_MAX_SECTORS_PER_BLOCK << fs_info->sectorsize_bits ||
-	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_SECTORS_PER_BLOCK) {
-		/*
-		 * Would exhaust the array bounds of sectorv member in
-		 * struct scrub_block
-		 */
-		btrfs_err(fs_info,
-"scrub: nodesize and sectorsize <= SCRUB_MAX_SECTORS_PER_BLOCK (%d <= %d && %d <= %d) fails",
-		       fs_info->nodesize, SCRUB_MAX_SECTORS_PER_BLOCK,
-		       fs_info->sectorsize, SCRUB_MAX_SECTORS_PER_BLOCK);
-		return -EINVAL;
-	}
+	/*
+	 * SCRUB_MAX_SECTORS_PER_BLOCK is calculated using the largest possible
+	 * value (max nodesize / min sectorsize), thus nodesize should always
+	 * be fine.
+	 */
+	ASSERT(fs_info->nodesize <=
+	       SCRUB_MAX_SECTORS_PER_BLOCK << fs_info->sectorsize_bits);
 
 	/* Allocate outside of device_list_mutex */
 	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
-- 
2.37.0


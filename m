Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B574EEC54
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbiDAL0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiDALZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48126196D51
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09C0521A91
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUn9SGZJaLzz/uD4hh6nJo42Ye27bXG29O/GHUWNjf0=;
        b=D1AI1EJmsRC7T2jxtWVat6GSvV3DvXVvCTLiWd75Hn6cnO2ngH1QYO+DFcl2xthhbYt+SV
        oM1t4oiE7LXxsA0WTt2WE6gb12I1cCHeWsXAYME/WdiF7yyAkBfHJFkk/e2DoFBngO6rvV
        SQ/KnmRMvwpYR5y68aza8ZIuoDdEWS8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66F2B132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oJSBDdXgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:24:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/16] btrfs: enable subpage support for RAID56
Date:   Fri,  1 Apr 2022 19:23:31 +0800
Message-Id: <8266be491bc2c3cbee94118e17229de359027881.1648807440.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648807440.git.wqu@suse.com>
References: <cover.1648807440.git.wqu@suse.com>
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

Now the btrfs RAID56 infrastructure has migrated to use sector_ptr
interface, it should be safe to enable subpage support for btrfs RAID56.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 8 --------
 fs/btrfs/raid56.c  | 6 ------
 fs/btrfs/volumes.c | 7 -------
 3 files changed, 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d456f426924c..2c66ea3485e8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3678,14 +3678,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
 			   sectorsize, PAGE_SIZE);
-		if (btrfs_super_incompat_flags(fs_info->super_copy) &
-			BTRFS_FEATURE_INCOMPAT_RAID56) {
-			btrfs_err(fs_info,
-		"RAID56 is not yet supported for sector size %u with page size %lu",
-				sectorsize, PAGE_SIZE);
-			err = -EINVAL;
-			goto fail_alloc;
-		}
 		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
 		if (!subpage_info)
 			goto fail_alloc;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 7bfe8e8d8325..3dff0e009404 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1172,9 +1172,6 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
 	ASSERT(sector->page);
 
-	/* TODO: We don't yet support subpage, thus pgoff should always be 0 */
-	ASSERT(sector->pgoff == 0);
-
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
 
@@ -2419,9 +2416,6 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	}
 	ASSERT(i < rbio->real_stripes);
 
-	/* Now we just support the sectorsize equals to page size */
-	ASSERT(fs_info->sectorsize == PAGE_SIZE);
-	ASSERT(rbio->stripe_npages == stripe_nsectors);
 	bitmap_copy(rbio->dbitmap, dbitmap, stripe_nsectors);
 
 	/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd17e87815a..82c7e4e59c29 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4063,13 +4063,6 @@ static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
 	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
 		return true;
 
-	if (fs_info->sectorsize < PAGE_SIZE &&
-		bargs->target & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		btrfs_err(fs_info,
-		"RAID56 is not yet supported for sectorsize %u with page size %lu",
-			  fs_info->sectorsize, PAGE_SIZE);
-		return false;
-	}
 	/* Profile is valid and does not have bits outside of the allowed set */
 	if (alloc_profile_is_valid(bargs->target, 1) &&
 	    (bargs->target & ~allowed) == 0)
-- 
2.35.1


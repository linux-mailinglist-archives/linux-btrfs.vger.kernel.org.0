Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D64FDCB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbiDLKiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354555AbiDLKdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEAA5BD01
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52B0A21608
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhYPDaLCfopoXzqA40OGTpjEy81f8LlQpGN84HusD7E=;
        b=tiQK3WIuEhvQ3OFcbFuhuZs597W+ek1nk9pGse3mLd5a6sV7CdK/r5ywI+51m5XXt6O3k/
        /knC7yysvjxlNmU0drprlTx5lqodSge55bBNQuUrRUVCIJxuZTVgLirfmhd4u+W3f2T85P
        TOQ/WgSPJX4mYX9Fe4KCja9I22UDL6U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F68E13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ODaRGXhHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/17] btrfs: enable subpage support for RAID56
Date:   Tue, 12 Apr 2022 17:33:07 +0800
Message-Id: <48f2ed0b11100c8e01ce88bc712cb9921236408d.1649753690.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
References: <cover.1649753690.git.wqu@suse.com>
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
index 2bc867d35308..e816943ddb7a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3682,14 +3682,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index ef3d3b67098b..97a92576a163 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1158,9 +1158,6 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
 	ASSERT(sector->page);
 
-	/* We don't yet support subpage, thus pgoff should always be 0 */
-	ASSERT(sector->pgoff == 0);
-
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
 
@@ -2385,9 +2382,6 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	}
 	ASSERT(i < rbio->real_stripes);
 
-	/* Now we just support the sectorsize equals to page size */
-	ASSERT(fs_info->sectorsize == PAGE_SIZE);
-	ASSERT(rbio->stripe_npages == stripe_nsectors);
 	bitmap_copy(rbio->dbitmap, dbitmap, stripe_nsectors);
 
 	/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 93072a090fdd..1b75cde5a267 100644
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


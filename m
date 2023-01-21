Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10458676511
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 09:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAUIGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 03:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAUIGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 03:06:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC859E79
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 00:06:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77FC85FEC0
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674288391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Z9PBtZf7qwg1vntKgsP5qtmtp1qdT1VJN12Q8D32Ng=;
        b=GKUoMYkEf3g0pZFWEwbQFQKtX37MMh6Cq3Ksx5XyeUFUh8pJFVYOso1HKAv1qX3wMElpkC
        pm7qZnCC2ADvIkaq1IPZw1P6xLuxCmo1pSFvp93IEgbcXzQXQ3brYJuxvxA59icUsiqmAc
        I5l+4WloQhhvATevkFEj/oadRfBuUxo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E547D1357F
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oER1LQady2OoPgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: raid56: make error_bitmap update atomic
Date:   Sat, 21 Jan 2023 16:06:11 +0800
Message-Id: <5d3ab2fda0edb0b89ca829af1f59a7270ce6e238.1674285037.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674285037.git.wqu@suse.com>
References: <cover.1674285037.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the rework of raid56 code, there is very limited concurrency in the
endio context.

Most of works is done inside the sectors arrays, which different bios
will never touch the same sector.

But there is a concurrency here for error_bitmap. Both read and write
endio functions need to touch them, and we can have multiple write bios
touching the same error bitmap if they all hit some errors.

Here we fix the unprotected bitmap operation by going set_bit() in a
loop.

Since we have a very small ceiling of the sectors (at most 16 sectors),
such set_bit() in a loop should be very acceptable.

Fixes: 2942a50dea74 ("btrfs: raid56: introduce btrfs_raid_bio::error_bitmap")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 65ed4f326fb9..6f91a78d2e8d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1426,12 +1426,20 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 	u32 bio_size = 0;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
+	int i;
 
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		bio_size += bvec->bv_len;
 
-	bitmap_set(rbio->error_bitmap, total_sector_nr,
-		   bio_size >> rbio->bioc->fs_info->sectorsize_bits);
+	/*
+	 * Since we can have multiple bios touching the error_bitmap, we can not
+	 * call bitmap_set() without protection.
+	 *
+	 * Instead use set_bit() for each bit, as set_bit() itself is atomic.
+	 */
+	for (i = total_sector_nr; i < total_sector_nr +
+	     (bio_size >> rbio->bioc->fs_info->sectorsize_bits); i++)
+		set_bit(i, rbio->error_bitmap);
 }
 
 /* Verify the data sectors at read time. */
-- 
2.39.1


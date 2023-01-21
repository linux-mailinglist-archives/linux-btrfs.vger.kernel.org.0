Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9F676513
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 09:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjAUIGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 03:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjAUIGf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 03:06:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3236589AC
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 00:06:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E0CE33B27
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674288392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVHfDFg40jdNXchjN+ai11yEW6/e/iVtA/+QPT61ZKo=;
        b=l5YyZl/ZOJNTNkY6+TZrTNxOLYVLb49BNeVvkHjQJnnYTSiuYQwYvq3mrkmfK2hy73gOdJ
        K0f0E+48jSRzlKGPvFJW8Aklu2Oca56BNODCDYBhkUugI6UKohEImgphGA6YdBNuol3qOT
        zZdCwt06EuTbzutMQ0Y1MVfWCynMXwQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9DDE1357F
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAy4Jgedy2OoPgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: raid56: reduce the overhead to calculate the bio length
Date:   Sat, 21 Jan 2023 16:06:12 +0800
Message-Id: <416ad3d25cbb930a03056bdfb5cdddc6addda12e.1674285037.git.wqu@suse.com>
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

In rbio_update_error_bitmap(), we need to calculate the length of the
rbio.
As since it's called in the endio function, we can not directly grab the
length from bi_iter.

Currently we call bio_for_each_segment_all(), which will always return a
range inside a page.
But that's not necessary as we don't really care anything inside the
page.

So this patch will use bio_for_each_bvec_all(), which can return a bvec
across multiple continuous pages thus reduce the loops.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6f91a78d2e8d..1ed9e07833a7 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1425,10 +1425,9 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
 	u32 bio_size = 0;
 	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
 	int i;
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
+	bio_for_each_bvec_all(bvec, bio, i)
 		bio_size += bvec->bv_len;
 
 	/*
-- 
2.39.1


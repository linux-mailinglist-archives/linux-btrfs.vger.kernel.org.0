Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F177614857
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKALQY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKALQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD717E0C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F29333995
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzyKjK3GrZToqvGhPFTeFASWaOJ1uB/C93fFDNF9N9w=;
        b=q6iKQ0PC6rjjPiIMNm1YvcF/Mht5GfJSrHtZcdA89plfq8m7KoH7ttDWWQwlCDY+p83j3R
        uifL2TNF49xAY0NfTRTu92ONa+zLPXXGHhCveZx+Im/T3AuRi8a/eJe9E+pef6+hBgSVRQ
        OrCa0tEfS/yDv5XCrQsB9yygICaW+YY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0503E1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CHZFMgEAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/12] btrfs: raid56: extract sector recovery code into a helper
Date:   Tue,  1 Nov 2022 19:16:04 +0800
Message-Id: <7ffc2255e4de1cbaea5dbcd6dd5f6dc54d2b0113.1667300355.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667300355.git.wqu@suse.com>
References: <cover.1667300355.git.wqu@suse.com>
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

This includes extra changes:

- The allocation for unmap_array[] and pointers[]
  Now we allocate them in one go, and free them together.

- Remove @err
  Use errno_to_blk_status(ret) instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 59 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e3c172ba3c80..0f6c3358bb10 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2022,36 +2022,24 @@ static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		kunmap_local(unmap_array[stripe_nr]);
 }
 
-/*
- * all parity reconstruction happens here.  We've read in everything
- * we can find from the drives and this does the heavy lifting of
- * sorting the good from the bad.
- */
-static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
+static int recover_sectors(struct btrfs_raid_bio *rbio)
 {
-	int sectornr;
 	void **pointers = NULL;
 	void **unmap_array = NULL;
-	blk_status_t err;
+	int sectornr;
+	int ret = 0;
 
 	/*
-	 * This array stores the pointer for each sector, thus it has the extra
-	 * pgoff value added from each sector
+	 * @pointers array stores the pointer for each sector.
+	 *
+	 * @unmap_array stores copy of pointers that does not get reordered
+	 * during reconstruction so that kunmap_local works.
 	 */
 	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	if (!pointers) {
-		err = BLK_STS_RESOURCE;
-		goto cleanup;
-	}
-
-	/*
-	 * Store copy of pointers that does not get reordered during
-	 * reconstruction so that kunmap_local works.
-	 */
 	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	if (!unmap_array) {
-		err = BLK_STS_RESOURCE;
-		goto cleanup;
+	if (!pointers || !unmap_array) {
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	/* Make sure faila and fail b are in order. */
@@ -2070,11 +2058,22 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
 		recover_vertical(rbio, sectornr, pointers, unmap_array);
 
-	err = BLK_STS_OK;
-
-cleanup:
-	kfree(unmap_array);
+out:
 	kfree(pointers);
+	kfree(unmap_array);
+	return ret;
+}
+
+/*
+ * all parity reconstruction happens here.  We've read in everything
+ * we can find from the drives and this does the heavy lifting of
+ * sorting the good from the bad.
+ */
+static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
+{
+	int ret;
+
+	ret = recover_sectors(rbio);
 
 	/*
 	 * Similar to READ_REBUILD, REBUILD_MISSING at this point also has a
@@ -2098,13 +2097,13 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 		 *   Cache this rbio iff the above read reconstruction is
 		 *   executed without problems.
 		 */
-		if (err == BLK_STS_OK && rbio->failb < 0)
+		if (!ret && rbio->failb < 0)
 			cache_rbio_pages(rbio);
 		else
 			clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-		rbio_orig_end_io(rbio, err);
-	} else if (err == BLK_STS_OK) {
+		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	} else if (!ret) {
 		rbio->faila = -1;
 		rbio->failb = -1;
 
@@ -2115,7 +2114,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 		else
 			BUG();
 	} else {
-		rbio_orig_end_io(rbio, err);
+		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 	}
 }
 
-- 
2.38.1


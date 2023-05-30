Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C27152E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 03:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjE3BSc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 21:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjE3BS3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 21:18:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82927E0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 18:18:27 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4221021A7B
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685409506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M64yCdIpYm9evIREmBfoS+1aw+NVS5MRbE72A/RGzIA=;
        b=feXMLDUuOV9ak1fodA3C6QbFPBEjTZQ7Qu1jziHZKA9zdJOt9/SWDal6VyYMEk+42/CzHA
        Tp/iZv0hxBkiZXHN4VgDeMpdXAkkyK+txZncc41Y6vyLk0d0dpXJj4q5OABadBA0XJEwpd
        /nOYIi6kvAmi89ALxNcZiObdbdhhASI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B04361341B
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8Fh4IOFOdWRIIQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 01:18:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove processed_extent infrastructure
Date:   Tue, 30 May 2023 09:18:05 +0800
Message-Id: <f6b609d5bf25c12a1893b894b517964001c477d1.1685408905.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685408905.git.wqu@suse.com>
References: <cover.1685408905.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The structure processed_extent and the helper
endio_readpage_release_extent() are used to reduce the number of calls of
unlock_extent() during end_bio_extent_readpage()

This is done by merging the range and only call the function either the
status (uptodate or not) changes or the range is no longer continuous.

However the behavior has been changed:

- The range is always continuous
  Since it's the endio function of a btrfs bio, it's ensured the range
  is always continuous inside the same file.

- The uptodate status is now per-bio (aka, will not change)
  Since commit 7609afac6775 ("btrfs: handle checksum validation and
  repair at the storage layer"), the function end_bio_extent_readpage()
  no longer handles the metadata/data verification.

  This means the @uptodate variable will not change during the function
  end_bio_extent_readpage()

Thus there is no longer the need for processed_extent and the helper
endio_readpage_release_extent().

Just call unlock_extent() at the end of end_bio_extent_readpage().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 87 +++++---------------------------------------
 1 file changed, 9 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d228cc8b401..6bf2dcf3ad28 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -581,75 +581,6 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 	bio_put(bio);
 }
 
-/*
- * Record previously processed extent range
- *
- * For endio_readpage_release_extent() to handle a full extent range, reducing
- * the extent io operations.
- */
-struct processed_extent {
-	struct btrfs_inode *inode;
-	/* Start of the range in @inode */
-	u64 start;
-	/* End of the range in @inode */
-	u64 end;
-	bool uptodate;
-};
-
-/*
- * Try to release processed extent range
- *
- * May not release the extent range right now if the current range is
- * contiguous to processed extent.
- *
- * Will release processed extent when any of @inode, @uptodate, the range is
- * no longer contiguous to the processed range.
- *
- * Passing @inode == NULL will force processed extent to be released.
- */
-static void endio_readpage_release_extent(struct processed_extent *processed,
-			      struct btrfs_inode *inode, u64 start, u64 end,
-			      bool uptodate)
-{
-	struct extent_state *cached = NULL;
-	struct extent_io_tree *tree;
-
-	/* The first extent, initialize @processed */
-	if (!processed->inode)
-		goto update;
-
-	/*
-	 * Contiguous to processed extent, just uptodate the end.
-	 *
-	 * Several things to notice:
-	 *
-	 * - bio can be merged as long as on-disk bytenr is contiguous
-	 *   This means we can have page belonging to other inodes, thus need to
-	 *   check if the inode still matches.
-	 * - bvec can contain range beyond current page for multi-page bvec
-	 *   Thus we need to do processed->end + 1 >= start check
-	 */
-	if (processed->inode == inode && processed->uptodate == uptodate &&
-	    processed->end + 1 >= start && end >= processed->end) {
-		processed->end = end;
-		return;
-	}
-
-	tree = &processed->inode->io_tree;
-	/*
-	 * Now we don't have range contiguous to the processed range, release
-	 * the processed range now.
-	 */
-	unlock_extent(tree, processed->start, processed->end, &cached);
-
-update:
-	/* Update processed to current range */
-	processed->inode = inode;
-	processed->start = start;
-	processed->end = end;
-	processed->uptodate = uptodate;
-}
-
 static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 {
 	ASSERT(PageLocked(page));
@@ -674,20 +605,21 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
+	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 	struct bio_vec *bvec;
-	struct processed_extent processed = { 0 };
+	struct bvec_iter_all iter_all;
+	bool uptodate = !bio->bi_status;
+	u64 file_offset = page_offset(bio_first_page_all(bio)) +
+			  bio_first_bvec_all(bio)->bv_offset;
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
 	 * larger than UINT_MAX, u32 here is enough.
 	 */
 	u32 bio_offset = 0;
-	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		bool uptodate = !bio->bi_status;
 		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
 		u64 start;
@@ -742,17 +674,16 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 			}
 		}
 
-		/* Update page status and unlock. */
+		/* Update page status. */
 		end_page_read(page, uptodate, start, len);
-		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, uptodate);
 
 		ASSERT(bio_offset + len > bio_offset);
 		bio_offset += len;
 
 	}
-	/* Release the last extent */
-	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
+	/* Unlock the extent io tree. */
+	unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
+		      file_offset + bio_offset, NULL);
 	bio_put(bio);
 }
 
-- 
2.40.1


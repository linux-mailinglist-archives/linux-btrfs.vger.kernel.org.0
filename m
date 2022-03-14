Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D04D7E28
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiCNJJU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiCNJJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE3024BEF
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:08:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCE29210F5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1E1C1d1jdg2pJY4I0rJ8b6S2Rf7/n8TbO1ERJ4gnVI=;
        b=pOcDsSPmOkve84V1MWQ3X/df74od8znwPUmvIcLNBcgQEZ2F85H/gQrB3d62fARs5ntm37
        4T1MXCN6jtTaWB3Lbtmq4OQkKh2SPx5INjDhoMIQLAwqCjI3Ost8deKlB/4LV5GaA70dTl
        yH/vPnVwBBzJ0sAh9OnjXw4c6XEosP4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B4BB13ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAOGOe8FL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/18] btrfs: make metadata write endio functions to be split bio compatible
Date:   Mon, 14 Mar 2022 17:07:23 +0800
Message-Id: <f61a1a5b177759ee81950c643cb1845e0f3a13e6.1647248613.git.wqu@suse.com>
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

Two modifications are needed:

- Convert to __bio_for_each_segment()
  bio_for_each_segment_all() should not be called on cloned bio, as it
  will iterate range which no longer belongs to the split bio.

- Avoid bio_first_page_all() for end_bio_subpage_eb_writepage()
  bio_first_page_all() will use the original bvec, thus on cloned bio it
  will trigger a WARN_ON().

  Introduce a helper to grab page and fs_info from bios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a758a5acb8fb..e8c298572d3e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4482,6 +4482,21 @@ static struct extent_buffer *find_extent_buffer_nolock(
 	return NULL;
 }
 
+/*
+ * Since the bio can be cloned, we can no longer use bio_first_*_all()
+ * calls to grab a page.
+ * Thus here we introduce such helper to grab page and fs_info correctly.
+ */
+static struct btrfs_fs_info *bio_to_fs_info(struct bio *bio)
+{
+	struct bio_vec bvec;
+
+	bvec = bio_iter_iovec(bio, btrfs_bio(bio)->iter);
+
+	ASSERT(bvec.bv_page->mapping);
+	return btrfs_sb(bvec.bv_page->mapping->host->i_sb);
+}
+
 /*
  * The endio function for subpage extent buffer write.
  *
@@ -4491,20 +4506,20 @@ static struct extent_buffer *find_extent_buffer_nolock(
 static void end_bio_subpage_eb_writepage(struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 
-	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
+	fs_info = bio_to_fs_info(bio);
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		u64 bvec_start = page_offset(page) + bvec->bv_offset;
-		u64 bvec_end = bvec_start + bvec->bv_len - 1;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
+		u64 bvec_start = page_offset(page) + bvec.bv_offset;
+		u64 bvec_end = bvec_start + bvec.bv_len - 1;
 		u64 cur_bytenr = bvec_start;
 
-		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
+		ASSERT(IS_ALIGNED(bvec.bv_len, fs_info->nodesize));
 
 		/* Iterate through all extent buffers in the range */
 		while (cur_bytenr <= bvec_end) {
@@ -4547,14 +4562,14 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
 
 static void end_bio_extent_buffer_writepage(struct bio *bio)
 {
-	struct bio_vec *bvec;
 	struct extent_buffer *eb;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 	int done;
-	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
 
 		eb = (struct extent_buffer *)page->private;
 		BUG_ON(!eb);
-- 
2.35.1


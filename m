Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940225B6762
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIMFbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIMFbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 01:31:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77554C9D
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 22:31:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A99025BD01;
        Tue, 13 Sep 2022 05:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663047095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62ZArIm4lgwH0OBz93+PN1uC6FiosZLiB29NvGlBtl4=;
        b=GllXfqrIG0EiuoteMCIQqPdIZi5ti4UJMg5FrxRr/hQyj1nIeK2q/kSZp1HT+vOf1+RmXL
        Kz7Lo3PKlWpXI6e/HdFpJ/HbOvYFUNt/lo/C5AjIgb/fQ9sZuRfz6wEqQV7BR3JMjyeEUV
        aKK0LTos6P2dAia5mnZPh1o5nmFnrp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B727013A86;
        Tue, 13 Sep 2022 05:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cEkOH7YVIGO5VwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 13 Sep 2022 05:31:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 2/3] btrfs: switch the page and disk_bytenr argument position for submit_extent_page()
Date:   Tue, 13 Sep 2022 13:31:13 +0800
Message-Id: <b7c524dd2df0a9895f80ea737bf0d2f15bd45938.1663046855.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663046855.git.wqu@suse.com>
References: <cover.1663046855.git.wqu@suse.com>
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

Normally we put (page, pg_len, pg_offset) arguments together, just like
what __bio_add_page() does.

But in submit_extent_page(), what we got is, (page, disk_bytenr, pg_len,
pg_offset), which sometimes can be confusing.

Change the order to (disk_bytenr, page, pg_len, pg_offset) to make it
to follow the common schema.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a3e8232c25ed..ddf1600ea32b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3342,8 +3342,8 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
- * @page:	page to add to the bio
  * @disk_bytenr: logical bytenr where the write will be
+ * @page:	page to add to the bio
  * @size:	portion of page that we want to write to
  * @pg_offset:	offset of the new bio or to check whether we are adding
  *              a contiguous page to the previous one
@@ -3358,7 +3358,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 static int submit_extent_page(blk_opf_t opf,
 			      struct writeback_control *wbc,
 			      struct btrfs_bio_ctrl *bio_ctrl,
-			      struct page *page, u64 disk_bytenr,
+			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
 			      btrfs_bio_end_io_t end_io_func,
 			      enum btrfs_compression_type compress_type,
@@ -3676,7 +3676,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 bio_ctrl, page, disk_bytenr, iosize,
+					 bio_ctrl, disk_bytenr, page, iosize,
 					 pg_offset, end_bio_extent_readpage,
 					 this_bio_flag, force_bio_submit);
 		if (ret) {
@@ -3990,8 +3990,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
 		ret = submit_extent_page(op | write_flags, wbc,
-					 &epd->bio_ctrl, page,
-					 disk_bytenr, iosize,
+					 &epd->bio_ctrl, disk_bytenr,
+					 page, iosize,
 					 cur - page_offset(page),
 					 end_bio_extent_writepage,
 					 0, false);
@@ -4487,7 +4487,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(page);
 
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-			&epd->bio_ctrl, page, eb->start, eb->len,
+			&epd->bio_ctrl, eb->start, page, eb->len,
 			eb->start - page_offset(page),
 			end_bio_subpage_eb_writepage, 0, false);
 	if (ret) {
@@ -4527,7 +4527,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 &epd->bio_ctrl, p, disk_bytenr,
+					 &epd->bio_ctrl, disk_bytenr, p,
 					 PAGE_SIZE, 0,
 					 end_bio_extent_buffer_writepage,
 					 0, false);
@@ -6784,7 +6784,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
-				 page, eb->start, eb->len,
+				 eb->start, page, eb->len,
 				 eb->start - page_offset(page),
 				 end_bio_extent_readpage, 0, true);
 	if (ret) {
@@ -6889,7 +6889,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 
 			ClearPageError(page);
 			err = submit_extent_page(REQ_OP_READ, NULL,
-					 &bio_ctrl, page, page_offset(page),
+					 &bio_ctrl, page_offset(page), page,
 					 PAGE_SIZE, 0, end_bio_extent_readpage,
 					 0, false);
 			if (err) {
-- 
2.37.3


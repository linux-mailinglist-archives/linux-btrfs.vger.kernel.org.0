Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE55B5487
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 08:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiILG3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 02:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiILG3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 02:29:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DF29B
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 23:29:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE6A221F52
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662964138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N97EyUmTuTEQo4bt4IOKgqmw6tRhWcGplzJIjnZbo88=;
        b=vQL7luiSkUmjkIeGKTVusnLfn/M4tMXObZV6ME8q1MxdodMRPTjEHRr/41f38r8E90cMzl
        5G0Wtpe7I8bJcxpONEhLoKiT8kvBRvVWWsjp/+gx/nnar7rKdBJimeJ1DCynKsSayDWKFQ
        JlSO9FWsOsX3yC8FlRXbcRVY7Te52h0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02F92139E0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cL/ELqnRHmMAdgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: switch the page and disk_bytenr argument position for submit_extent_page()
Date:   Mon, 12 Sep 2022 14:28:38 +0800
Message-Id: <570918e453541705fb43762852de0f45dbafb568.1662963954.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662963954.git.wqu@suse.com>
References: <cover.1662963954.git.wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cea7d09c2dc1..dd0697555385 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3356,7 +3356,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 static int submit_extent_page(blk_opf_t opf,
 			      struct writeback_control *wbc,
 			      struct btrfs_bio_ctrl *bio_ctrl,
-			      struct page *page, u64 disk_bytenr,
+			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
 			      btrfs_bio_end_io_t end_io_func,
 			      enum btrfs_compression_type compress_type,
@@ -3674,7 +3674,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 bio_ctrl, page, disk_bytenr, iosize,
+					 bio_ctrl, disk_bytenr, page, iosize,
 					 pg_offset, end_bio_extent_readpage,
 					 this_bio_flag, force_bio_submit);
 		if (ret) {
@@ -3988,8 +3988,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
 		ret = submit_extent_page(op | write_flags, wbc,
-					 &epd->bio_ctrl, page,
-					 disk_bytenr, iosize,
+					 &epd->bio_ctrl, disk_bytenr,
+					 page, iosize,
 					 cur - page_offset(page),
 					 end_bio_extent_writepage,
 					 0, false);
@@ -4485,7 +4485,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(page);
 
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-			&epd->bio_ctrl, page, eb->start, eb->len,
+			&epd->bio_ctrl, eb->start, page, eb->len,
 			eb->start - page_offset(page),
 			end_bio_subpage_eb_writepage, 0, false);
 	if (ret) {
@@ -4525,7 +4525,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 &epd->bio_ctrl, p, disk_bytenr,
+					 &epd->bio_ctrl, disk_bytenr, p,
 					 PAGE_SIZE, 0,
 					 end_bio_extent_buffer_writepage,
 					 0, false);
@@ -6782,7 +6782,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
-				 page, eb->start, eb->len,
+				 eb->start, page, eb->len,
 				 eb->start - page_offset(page),
 				 end_bio_extent_readpage, 0, true);
 	if (ret) {
@@ -6887,7 +6887,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 
 			ClearPageError(page);
 			err = submit_extent_page(REQ_OP_READ, NULL,
-					 &bio_ctrl, page, page_offset(page),
+					 &bio_ctrl, page_offset(page), page,
 					 PAGE_SIZE, 0, end_bio_extent_readpage,
 					 0, false);
 			if (err) {
-- 
2.37.3


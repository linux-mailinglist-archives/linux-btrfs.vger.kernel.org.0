Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4047C75F83D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGXN1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGXN1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C87E74
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GlnKXO6nPoeWxB3BS+pZw+G1cJTsCwIsw4aw/brRaRw=; b=Km25EaLmbzkXx0g/NmhT0bJfqw
        nJD0esea0PjcjesuavyOH0iOtqpsp+EV1NtPeP+u7Dynia6g8PgE0j0dyAe9g0U1Vnsa/MKUfUHLM
        GbbTY9qoWssZ8oILJxH/Q+bTyfgsnvpfyiW3pAC3ch7Yi0kixCV8SDrF3SKdikVU+fuGW+toEkVMA
        XfXRoXOKQBsDx8pvMnmtY8EpW3iZ6/EavOy54Twpl9lm4Air6eR/MSZ3eIatrxxE/7lMv/+gFPx+e
        IsxwMvV6yGylWL0a8CjjWr0MDVnR/A97OmUh4PXgQqDuJ8RzJhY0wyQ5tdi7i9Dyr2eWUHXvRUg8N
        Om7LAqNg==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaY-004RLp-1r;
        Mon, 24 Jul 2023 13:27:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: move the cow_fixup earlier in writepages handling
Date:   Mon, 24 Jul 2023 06:26:56 -0700
Message-Id: <20230724132701.816771-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724132701.816771-1-hch@lst.de>
References: <20230724132701.816771-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs has a special fixup for pages that are marked dirty without having
space reserved for them.  But the place where is is run means it can't
work for I/O that isn't kicked off inline from __extent_writepage, most
notable compressed I/O and I/O to zoned file systems.

Move the fixup earlier based on not findining any delalloc range in the
I/O tree to cover this case as well instead of relying on the fairly
obscure fallthrough behavior that calls __extent_write_page_io even when
no delalloc space was found.

Fixes: c8b978188c9a ("Btrfs: Add zlib compression support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1cc46bbbd888cd..cc258bddd88eab 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1153,6 +1153,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
+	bool found_delalloc = false;
 	int ret = 0;
 
 	while (delalloc_start < page_end) {
@@ -1169,6 +1170,22 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			return ret;
 
 		delalloc_start = delalloc_end + 1;
+		found_delalloc = true;
+	}
+
+	/*
+	 * If we did not find any delalloc range in the io_tree, this must be
+	 * the rare case of dirtying pages through get_user_pages without
+	 * calling into ->page_mkwrite.
+	 * While these are in the process of being fixed by switching to
+	 * pin_user_pages, some are still around and need to be worked around
+	 * by creating a delalloc reservation in a fixup worker, and waiting
+	 * us to be called again with that reservation.
+	 */
+	if (!found_delalloc && btrfs_writepage_cow_fixup(page)) {
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 1;
 	}
 
 	/*
@@ -1274,14 +1291,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	int ret = 0;
 	int nr = 0;
 
-	ret = btrfs_writepage_cow_fixup(page);
-	if (ret) {
-		/* Fixup worker will requeue */
-		redirty_page_for_writepage(bio_ctrl->wbc, page);
-		unlock_page(page);
-		return 1;
-	}
-
 	bio_ctrl->end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
 		u32 len = end - cur + 1;
@@ -1421,9 +1430,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 		goto done;
 
 	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &nr);
-	if (ret == 1)
-		return 0;
-
 	bio_ctrl->wbc->nr_to_write--;
 
 done:
@@ -2176,8 +2182,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
 					    i_size, &nr);
-		if (ret == 1)
-			goto next_page;
 
 		/* Make sure the mapping tag for page dirty gets cleared. */
 		if (nr == 0) {
@@ -2193,7 +2197,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
-next_page:
 		put_page(page);
 		cur = cur_end + 1;
 	}
-- 
2.39.2


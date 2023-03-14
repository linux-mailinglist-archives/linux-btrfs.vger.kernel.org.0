Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227D6B8B17
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCNGRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCNGRk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF707B4AB
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n0jNulNBY7fKcGe0Rhb1Vn15MViVq18AjDg6zDFo3QI=; b=gvqZZFQ5LT4ZeVvDadhAiwn56D
        osexbQdS0ZraKFQ9itK/uv1UhxonORP8LhAYcpoSGeklBDnBwhrDMcrGzZgygs9bxtZ3iy1jdcb0E
        dLf31QkpOQqiVaTNCoN4fEdCYWAVhaYN4oEBGU/o+SQONdn3V24Zbe7h5nmO7GarzrZjqE8KSX0bU
        +Av8PXSVlnCVNKn8meDVVHxq05C6OqlGslfOGWQUXnkXfVZJjFlX9jQXC7no8b5Cz79+m9Qsw8Lya
        OfEnkq/muIw1LGic0a+va2IZdbqNLYX/S0JxEnSCw4VAq7nQFlWDa4rMxD4cqQKES7OtlgrXvGqva
        D/y5mVog==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyb-009AnS-Ji; Tue, 14 Mar 2023 06:17:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/21] btrfs: move page locking from lock_extent_buffer_for_io to write_one_eb
Date:   Tue, 14 Mar 2023 07:16:46 +0100
Message-Id: <20230314061655.245340-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Locking the pages in lock_extent_buffer_for_io only for the non-subpage
case is very confusing.  Move it to write_one_eb to mirror the subpage
case and simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d28744793c28d..56a2e6421b7189 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1635,7 +1635,6 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool ret = false;
-	int i;
 
 	btrfs_tree_lock(eb);
 	while (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
@@ -1663,20 +1662,7 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
 	} else {
 		spin_unlock(&eb->refs_lock);
 	}
-
 	btrfs_tree_unlock(eb);
-
-	/*
-	 * Either we don't need to submit any tree block, or we're submitting
-	 * subpage eb.
-	 * Subpage metadata doesn't use page locking at all, so we can skip
-	 * the page locking.
-	 */
-	if (!ret || fs_info->nodesize < PAGE_SIZE)
-		return ret;
-
-	for (i = 0; i < num_extent_pages(eb); i++)
-		lock_page(eb->pages[i]);
 	return ret;
 }
 
@@ -1959,6 +1945,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
+		lock_page(p);
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
-- 
2.39.2


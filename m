Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252BE6CFB94
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC3Gbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3Gbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647C161AA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n0jNulNBY7fKcGe0Rhb1Vn15MViVq18AjDg6zDFo3QI=; b=lZui8DAXL2nP7Q8ShoiVcQlgY3
        eLtKF/PZMN4sXa+GAbK3iI/F1tEXgq9XzkSNS+CEHUE3B4jar1rnjoVI1KBMUw8pR4bbUron2j7yY
        0eBqAk5QziaJtV+v3MTJJgHXiBjjsvFA7imMz3tL39JYOw8PHDhA84CG57e1Ru6wQoriDtfosAjfD
        ydYpqDxI7yji/D3740kn6bFFnWZpWvVG0J1+VvdNylBgxUzlGk2u0J+3Oc0l1rAyZjMb5p6ZigEiz
        nERYHeg6ny1R/sW6SCtVeW1F5i6x/ZpYuueK/2ANz1QZpqQcBNViihB5YhDMZ9KWNkKi8aZzkAQEW
        CbLDAD/g==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phlon-002lfY-05;
        Thu, 30 Mar 2023 06:31:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/21] btrfs: move page locking from lock_extent_buffer_for_io to write_one_eb
Date:   Thu, 30 Mar 2023 15:30:50 +0900
Message-Id: <20230330063059.1574380-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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


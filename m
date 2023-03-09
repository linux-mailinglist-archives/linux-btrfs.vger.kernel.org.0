Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC76B1F5D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCIJHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCIJG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B45D26A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FzUvW8ckcvEJiwNdW+PGTLv7/NwSpA1UjnKqL0EaCUo=; b=fxIDx29dslLCDoxV98q/EemQaL
        4irgfT9f+LG4lcau2yUL6WC3OgIX+/MM4sEOUkjxjIuTPxcJ+99X6YvK5z/HWTCv8vUpmEez+YlXU
        hWav+hjCk67qcbYiPyVNVRnWlLE2KVeFAOc/NUU6Sivi7rMYQkVJpUG5EGjKuKp3DkbaxsEvs2eL+
        p37RwgouObmOuw2far7XV4/trY4Gq1cHbpJEui5fQtnXy76zifRtAfczXP0PzgBREfFQj26KZ1PXE
        c67mE1ifWoD/vDxT088JsYCyZeAGm14M2w5REq3DjQ+9+h4VTp1DzU6Fl4+X/+dOuBRoN+kPA7tFw
        xujUJkNw==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEK-008hpo-N7; Thu, 09 Mar 2023 09:06:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/20] btrfs: move page locking from lock_extent_buffer_for_io to write_one_eb
Date:   Thu,  9 Mar 2023 10:05:17 +0100
Message-Id: <20230309090526.332550-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
---
 fs/btrfs/extent_io.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ffcc700ea52196..1fc50d1402cef8 100644
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
 
@@ -1958,6 +1944,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
+		lock_page(p);
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
-- 
2.39.2


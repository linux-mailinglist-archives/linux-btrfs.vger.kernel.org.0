Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A129E6F5B03
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjECPZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjECPZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08A40CF
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RZnZCjEFSLv1ueRFe+YThvrF5by4NR59A8y43X1LCiU=; b=M13jFJqKYYpNCVJkDfyABTjiO/
        X3kSzjA9mDMoFvVG2JJFzyFkke+MHRdmdeicjx1mkmj9onAmuBjWIwfSCHUBQpYiLtayql3HBiswv
        w9YnTaRF8Ynvk6MJWfzbyLDqQrZXUdrhy7FDi3RA/SS0hlYoauH6BHNuRslp+LErhh1dKRoGb1pwI
        V0jF00lqRIpbDAXR9qLnWPfNP+/9gB+Q6x2ky8Fm0ToURLtLhrxFVSE9kCU0pIU5OPZxHtywvj+Jc
        oYF/jkhAh6JwPCOijN9BhZEDK8bAHfoxLXyHy4vijX/wuH0FaOyJs90Nzn5+PWvkkfHXndXH648FD
        oU9icE5w==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEM0-004xk9-27;
        Wed, 03 May 2023 15:25:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/21] btrfs: move page locking from lock_extent_buffer_for_io to write_one_eb
Date:   Wed,  3 May 2023 17:24:32 +0200
Message-Id: <20230503152441.1141019-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 3e164309ec70e3..76636e7c21b02f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1636,7 +1636,6 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool ret = false;
-	int i;
 
 	btrfs_tree_lock(eb);
 	while (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
@@ -1664,20 +1663,7 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
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
 
@@ -1960,6 +1946,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
+		lock_page(p);
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
-- 
2.39.2


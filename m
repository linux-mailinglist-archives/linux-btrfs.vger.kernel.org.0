Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090D43C6A58
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhGMGSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36768 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhGMGSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:34 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABD1F221D2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/FUkam4jSGe2eIHoYTLU6jRmoPZGdyh/DRFDTVx4HY=;
        b=SkgonWgkQvtfZQeIlKWpoZPPv0UrIotxJKs1GdRSgiqVJpY49ldbqtmXfLuw3uoRI6Hwe/
        lcOlWGjTsn28BH22ohzloCI3wXxjFpQXQNKAJUocImb0V+WmZTsCEG2dayFIX+lgqmOrfg
        TTWUh/+0ROKa9E/mUQsKKQe0XC7943c=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E587F139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OMhsKY8v7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/27] btrfs: make extent_write_locked_range() to be subpage compatible
Date:   Tue, 13 Jul 2021 14:15:09 +0800
Message-Id: <20210713061516.163318-21-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two sites are not subpage compatible yet for
extent_write_locked_range():

- How @nr_pages are calculated
  For subpage we can have the following range with 64K page size:

  0   32K  64K   96K 128K
  |   |////|/////|   |

  In that case, although 96K - 32K == 64K, thus it looks like one page
  is enough, but the range spans across two pages, not one.

  Fix it by doing proper round_up() and round_down() to calculate
  @nr_pages.

  Also add some extra ASSERT()s to ensure the range passed in is already
  aligned.

- How the page end is calculated
  Currently we just use cur + PAGE_SIZE - 1 to calculate the page end.

  Which can't handle above range layout, and will trigger ASSERT() in
  btrfs_writepage_endio_finish_ordered(), as the range is no longer
  covered by the page range.

  Fix it by take page end into consideration.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 583cfc89f2af..f6be630cf9ef 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5058,15 +5058,14 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 	u64 cur = start;
-	unsigned long nr_pages = (end - start + PAGE_SIZE) >>
-		PAGE_SHIFT;
+	unsigned long nr_pages;
+	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
 	struct extent_page_data epd = {
 		.bio_ctrl = { 0 },
 		.extent_locked = 1,
 		.sync_io = 1,
 	};
 	struct writeback_control wbc_writepages = {
-		.nr_to_write	= nr_pages * 2,
 		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
 		.range_end	= end + 1,
@@ -5075,14 +5074,24 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		.no_cgroup_owner = 1,
 	};
 
+	ASSERT(IS_ALIGNED(start, sectorsize) &&
+	       IS_ALIGNED(end + 1, sectorsize));
+	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
+		   PAGE_SHIFT;
+	wbc_writepages.nr_to_write = nr_pages * 2;
+
 	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (cur <= end) {
+		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1,
+				  end);
+
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		/*
 		 * All pages in the range are locked since
 		 * btrfs_run_delalloc_range(), thus there is no way to clear
 		 * the page dirty flag.
 		 */
+		ASSERT(PageLocked(page));
 		ASSERT(PageDirty(page));
 		clear_page_dirty_for_io(page);
 		ret = __extent_writepage(page, &wbc_writepages, &epd);
@@ -5092,7 +5101,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 			first_error = ret;
 		}
 		put_page(page);
-		cur += PAGE_SIZE;
+		cur = cur_end + 1;
 	}
 
 	if (!found_error)
-- 
2.32.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CCF304533
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 18:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbhAZRZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:25:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:55918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390243AbhAZIhh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:37:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKt+/6uO9FYWemt3jyCTKAM9BMQo2WqaulwRcCz8DrU=;
        b=H799YWS4suKG5ZzEAnphJ3usm8pKQAmmO5N7rWLIC8SUeY6SkZ2Cdu1KL0T6h9SLrSXPjV
        soEv4223TLAeEkzh5KsdfdIAnY7WIdTUj+/W4jyobwt3ISFs3jxllMyHhhQncXh1dDaiVP
        6cnlHy1hzDKddFt54RBSwCp01gnE2g0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20BDAB253;
        Tue, 26 Jan 2021 08:35:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 14/18] btrfs: support subpage in endio_readpage_update_page_status()
Date:   Tue, 26 Jan 2021 16:33:58 +0800
Message-Id: <20210126083402.142577-15-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To handle subpage status update, add the following:

- Use btrfs_page_*() subpage-aware helpers to update page status
  Now we can handle both cases well.

- No page unlock for subpage metadata
  Since subpage metadata doesn't utilize page locking at all, skip it.
  For subpage data locking, it's handled in later commits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ac8faf0f8e5..139a8a77ed72 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2839,15 +2839,24 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void endio_readpage_update_page_status(struct page *page, bool uptodate)
+static void endio_readpage_update_page_status(struct page *page, bool uptodate,
+					      u64 start, u32 len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+
+	ASSERT(page_offset(page) <= start &&
+		start + len <= page_offset(page) + PAGE_SIZE);
+
 	if (uptodate) {
-		SetPageUptodate(page);
+		btrfs_page_set_uptodate(fs_info, page, start, len);
 	} else {
-		ClearPageUptodate(page);
-		SetPageError(page);
+		btrfs_page_clear_uptodate(fs_info, page, start, len);
+		btrfs_page_set_error(fs_info, page, start, len);
 	}
-	unlock_page(page);
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		unlock_page(page);
+	/* Subpage locking will be handled in later patches */
 }
 
 /*
@@ -2984,7 +2993,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		bio_offset += len;
 
 		/* Update page status and unlock */
-		endio_readpage_update_page_status(page, uptodate);
+		endio_readpage_update_page_status(page, uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
-- 
2.30.0


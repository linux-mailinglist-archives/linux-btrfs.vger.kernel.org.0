Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2742D5412
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgLJGk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbgLJGkv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+t+YQg/b8gwwxpg9+2sjClOd1VpCSxMmcRxNyhwVyU=;
        b=gvY1iiUGBmlzTgdM8hCGPMJWa0RiNkrbAXEo4rIcaJxtsH4m1W++7cdpQn4KvdPACn/oLu
        w7SfaWEDGK7l/0JZV9awdaBnjldK6JQaDysxQGhp6T8UsgqjyDQmSwGyV5DPhy733ERLBS
        a9v2UKW553b25Twtnfq2B2apz90gTKY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A163AD77
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/18] btrfs: extent_io: make endio_readpage_update_page_status() to handle subpage case
Date:   Thu, 10 Dec 2020 14:39:01 +0800
Message-Id: <20201210063905.75727-15-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To handle subpage status update, add the following new tricks:
- Use btrfs_page_*() helpers to update page status
  Now we can handle both cases well.

- No page unlock for subpage metadata
  Since subpage metadata doesn't utilize page locking at all, skip it.
  For subpage data locking, it's handled in later commits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ec9de2aa910..64a19c1884fc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2841,15 +2841,26 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void endio_readpage_update_page_status(struct page *page, bool uptodate)
+static void endio_readpage_update_page_status(struct page *page, bool uptodate,
+					      u64 start, u64 end)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	u32 len;
+
+	ASSERT(page_offset(page) <= start &&
+		end <= page_offset(page) + PAGE_SIZE - 1);
+	len = end + 1 - start;
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
@@ -2986,7 +2997,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		bio_offset += len;
 
 		/* Update page status and unlock */
-		endio_readpage_update_page_status(page, uptodate);
+		endio_readpage_update_page_status(page, uptodate, start, end);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
-- 
2.29.2


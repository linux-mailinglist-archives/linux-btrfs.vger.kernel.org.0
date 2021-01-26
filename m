Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657B8304458
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 18:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbhAZIhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 03:37:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:54964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbhAZIgM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:36:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UksFGMWY24VbTkCCa4YljZUik56bK0fzLAkNvNM9kaM=;
        b=r+NPxvNM8wcvyt5i3GYMBIgH9toKQHLz0CuiNkgAK6nKBW6syDv43nrBZu5OUCzMdoS/m7
        1G3ZK87v1Fk5y52y3uxWfPgBiX20m72iZIdvz2E+YaSWd4U4wKSZAjkO04Nowh6PsSeg/9
        EMwf0znR2Jef1uq0IE0ZHPVlvU2sNSw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40851AF80;
        Tue, 26 Jan 2021 08:34:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 10/18] btrfs: support subpage in set/clear_extent_buffer_uptodate()
Date:   Tue, 26 Jan 2021 16:33:54 +0800
Message-Id: <20210126083402.142577-11-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage in set_extent_buffer_uptodate and
clear_extent_buffer_uptodate we only need to use the subpage-aware
helpers to update the page bits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7ee28d94bae9..78fd36ba1f47 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5670,30 +5670,33 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
-	int i;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page;
 	int num_pages;
+	int i;
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 		if (page)
-			ClearPageUptodate(page);
+			btrfs_page_clear_uptodate(fs_info, page,
+						  eb->start, eb->len);
 	}
 }
 
 void set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
-	int i;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page;
 	int num_pages;
+	int i;
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-		SetPageUptodate(page);
+		btrfs_page_set_uptodate(fs_info, page, eb->start, eb->len);
 	}
 }
 
-- 
2.30.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694172EB764
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbhAFBDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:45910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbhAFBDq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS8t2gNXacbP+kV9eU2/W3eEACj8uRferamlEo2gmHY=;
        b=TPCjMnNbrtr5eK38zCAePYjFLJ9FUcTdj169a+GgzEcgESZFdZw2EZnBOMJ5tnNfr3ZmmL
        2J9H+/LEE6rwjux4FFF21e8/ipxOY2AByX5T6FNjmd7vjLnpihax1AO9quo2DMjBPtey8/
        vZfiaohPVNHT69dZuKg47n0kMnmpT/Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17481AF59
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 14/22] btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support subpage size
Date:   Wed,  6 Jan 2021 09:01:53 +0800
Message-Id: <20210106010201.37864-15-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For those functions, to support subpage size they just need to call
btrfs_page_set/clear_uptodate() wrappers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3bd4b99897d6..66e70b263343 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5613,30 +5613,33 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 
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
2.29.2


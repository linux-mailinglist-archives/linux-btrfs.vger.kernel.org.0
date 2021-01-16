Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705B52F8C00
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAPHRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:56166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbhAPHRS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsHc5uf3/iu/mZIDjAjKCyHl7cajkBKg5XGXWlUfG/Y=;
        b=o9oWyAOfI8XtnLcCuH072O2FFNr5EIEcIWmtkGx4qk2Rn/rRucl3Ba9QmgKZcoaUu1R4l8
        r09E8CC87ZIdBQxnzqpueh8wc2NdFYbQ1dOcNfWK1nXAd4GaIcYSRkTgiZUuyY63iBxeXw
        DlbO+ui1/+hd6IAyRjTK1ajLoVMw6bI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95100B902
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:16:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 10/18] btrfs: make set/clear_extent_buffer_uptodate() to support subpage size
Date:   Sat, 16 Jan 2021 15:15:25 +0800
Message-Id: <20210116071533.105780-11-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
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
index 7f94f00936d7..c2459cf56950 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5690,30 +5690,33 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 
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


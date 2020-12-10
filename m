Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CED2D53FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgLJGk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387524AbgLJGkq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KR6va1HHwGJ8WZ0JlPuUV+4CAGChKUm2xRppBWriwxg=;
        b=uZJpKb/Ruxsqut/6HCuXLnQFTn1q7q9wp/A0EOmpT59nnBT6WtchZ13JLRzbtPoKa0HJOr
        mzxhoiU7MehxE34m/8EdxBvVCN4Hqd/KbhyLBYvqC/o8B5PHMig46MXn27uSOeQKHKmvLw
        3OM+7t3AF6fAXODnYF/ASz1cOXwOoJg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D50D3AD4D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/18] btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support subpage size
Date:   Thu, 10 Dec 2020 14:38:58 +0800
Message-Id: <20201210063905.75727-12-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
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
index ee81a2a1baa2..141e414b1ab9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5611,30 +5611,33 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 
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


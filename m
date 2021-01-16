Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547212F8C02
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAPHRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbhAPHRU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67oxTlFBGfM+7X1D+mSit2Atd1veT8boa2zvEYJRE4w=;
        b=dnBscI17ABPbN+LbHNieVMxT1NEzqXsXTyk00jXOEowCkjtCNLYySS67g7TohASNF+DWhK
        Kizct4OUCAj3GpK0L1cbdb5rtLIOVdQJRQvfgXfSXuhWt7v44z8RnELWOJOkm2xuZjGH74
        Fpy1VzOWAqd91bRPQMUklcY71xxkU9Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B164B903
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:16:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 11/18] btrfs: make btrfs_clone_extent_buffer() to be subpage compatible
Date:   Sat, 16 Jan 2021 15:15:26 +0800
Message-Id: <20210116071533.105780-12-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs_clone_extent_buffer(), it's mostly the same code of
__alloc_dummy_extent_buffer(), except it has extra page copy.

So to make it subpage compatible, we only need to:
- Call set_extent_buffer_uptodate() instead of SetPageUptodate()
  This will set correct uptodate bit for subpage and regular sector size
  cases.

Since we're calling set_extent_buffer_uptodate() which will also set
EXTENT_BUFFER_UPTODATE bit, we don't need to manually set that bit
either.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c2459cf56950..74a37eec921f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5164,7 +5164,6 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	if (new == NULL)
 		return NULL;
 
-	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	for (i = 0; i < num_pages; i++) {
@@ -5182,11 +5181,10 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 			return NULL;
 		}
 		WARN_ON(PageDirty(p));
-		SetPageUptodate(p);
 		new->pages[i] = p;
 		copy_page(page_address(p), page_address(src->pages[i]));
 	}
-
+	set_extent_buffer_uptodate(new);
 
 	return new;
 }
-- 
2.30.0


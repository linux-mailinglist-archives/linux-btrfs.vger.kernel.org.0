Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FDE1C9C23
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgEGUUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgEGUUq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DEB6AD2C;
        Thu,  7 May 2020 20:20:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0C33DA732; Thu,  7 May 2020 22:19:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 12/19] btrfs: remove unused map_private_extent_buffer
Date:   Thu,  7 May 2020 22:19:55 +0200
Message-Id: <301e4ce1e53eb6044ceb412c44ff439210911491.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All uses of map_private_extent_buffer have been replaced by more
effective way. The set/get helpers have their own bounds checker.
The function name was confusing since the non-private helper was removed
in a65917156e34 ("Btrfs: stop using highmem for extent_buffers") many
years ago.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 42 ------------------------------------------
 fs/btrfs/extent_io.h |  4 ----
 2 files changed, 46 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 22db0b234ffe..67ee46a0a9c8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5685,48 +5685,6 @@ int read_extent_buffer_to_user(const struct extent_buffer *eb,
 	return ret;
 }
 
-/*
- * return 0 if the item is found within a page.
- * return 1 if the item spans two pages.
- * return -EINVAL otherwise.
- */
-int map_private_extent_buffer(const struct extent_buffer *eb,
-			      unsigned long start, unsigned long min_len,
-			      char **map, unsigned long *map_start,
-			      unsigned long *map_len)
-{
-	size_t offset;
-	char *kaddr;
-	struct page *p;
-	size_t start_offset = offset_in_page(eb->start);
-	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
-	unsigned long end_i = (start_offset + start + min_len - 1) >>
-		PAGE_SHIFT;
-
-	if (start + min_len > eb->len) {
-		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
-		       eb->start, eb->len, start, min_len);
-		return -EINVAL;
-	}
-
-	if (i != end_i)
-		return 1;
-
-	if (i == 0) {
-		offset = start_offset;
-		*map_start = 0;
-	} else {
-		offset = 0;
-		*map_start = ((u64)i << PAGE_SHIFT) - start_offset;
-	}
-
-	p = eb->pages[i];
-	kaddr = page_address(p);
-	*map = kaddr + offset;
-	*map_len = PAGE_SIZE - offset;
-	return 0;
-}
-
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a2842b2d9a98..9ed89c01e2da 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -271,10 +271,6 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 int extent_buffer_under_io(struct extent_buffer *eb);
-int map_private_extent_buffer(const struct extent_buffer *eb,
-			      unsigned long offset, unsigned long min_len,
-			      char **map, unsigned long *map_start,
-			      unsigned long *map_len);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
-- 
2.25.0


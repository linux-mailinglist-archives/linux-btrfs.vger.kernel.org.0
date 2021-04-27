Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC436CF2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhD0XFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:37260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XFg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2oWMg30JQYMT/sabl77qGYHRIMqrj7Jlkqgqbxceb0=;
        b=sRGoEAN/YJEFkI5IhN7lpphG13mZEvEKqia/35o/yL2fuNNZZoPUwXHrV7vK3OeJaWNqcC
        r6VNeQaYvVBoqArAKuULr7pLhtxWSxxj6fzXPlFmQZlV5FVrxDBIeS+uxI7iBPqgGmgRwZ
        x/0tX+Bwlj5Dp3G3O8H/uA1Y/BqFMsA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37380B168
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 25/42] btrfs: prevent extent_clear_unlock_delalloc() to unlock page not locked by __process_pages_contig()
Date:   Wed, 28 Apr 2021 07:03:32 +0800
Message-Id: <20210427230349.369603-26-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In cow_file_range(), after we have succeeded creating an inline extent,
we unlock the page with extent_clear_unlock_delalloc() by passing
locked_page == NULL.

For sectorsize == PAGE_SIZE case, this is just making the page lock and
unlock harder to grab.

But for incoming subpage case, it can be a big problem.

For incoming subpage case, page locking have two entrace:
- __process_pages_contig()
  In that case, we know exactly the range we want to lock (which only
  requires sector alignment).
  To handle the subpage requirement, we introduce btrfs_subpage::writers
  to page::private, and will update it in __process_pages_contig().

- Other directly lock/unlock_page() call sites
  Those won't touch btrfs_subpage::writers at all.

This means, page locked by __process_pages_contig() can only be unlocked
by __process_pages_contig().
Thankfully we already have the existing infrastructure in the form of
@locked_page in various call sites.

Unfortunately, extent_clear_unlock_delalloc() in cow_file_range() after
creating an inline extent is the exception.
It intentionally call extent_clear_unlock_delalloc() with locked_page ==
NULL, to also unlock current page (and clear its dirty/writeback bits).

To co-operate with incoming subpage modifications, and make the page
lock/unlock pair easier to understand, this patch will still call
extent_clear_unlock_delalloc() with locked_page, and only unlock the
page in __extent_writepage().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c5125698bc09..a49d1ecfe62c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1072,7 +1072,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(inode, start, end, NULL,
+			extent_clear_unlock_delalloc(inode, start, end,
+				     locked_page,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -1080,6 +1081,19 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			*nr_written = *nr_written +
 			     (end - start + PAGE_SIZE) / PAGE_SIZE;
 			*page_started = 1;
+			/*
+			 * locked_page is locked by the caller of
+			 * writepage_delalloc(), not locked by
+			 * __process_pages_contig().
+			 *
+			 * We can't let __process_pages_contig() to unlock it,
+			 * as it doesn't have any subpage::writers recorded.
+			 *
+			 * Here we manually unlock the page, since the caller
+			 * can't use page_started to determine if it's an
+			 * inline extent or a compressed extent.
+			 */
+			unlock_page(locked_page);
 			goto out;
 		} else if (ret < 0) {
 			goto out_unlock;
-- 
2.31.1


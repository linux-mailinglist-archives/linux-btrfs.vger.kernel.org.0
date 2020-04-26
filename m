Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203031B9454
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgDZVu0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 17:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZVtv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F38C061A41
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so12026886edv.2
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8YZX6HD1KfYztNlIB7+yLvJefwmGiH93TRfGwqC7PeQ=;
        b=XJUCf4/P3uV7oFMdxzQRFCOfUhzfFQc4G4aSbcspZJ2OiUwRdTeqHaiQFn/uzJVy6n
         WgYCFN8XMPbZLNkfr+vzFpVAGFJcgOV0pdRmEDQlWGUiaxVtwbptV51UEtbu8ZXVJWyT
         iaKsrKOnwwMPfg3OnjKyeGklbYVWoJUlGMZ1WAaBDgSvflIxeWcnfuID+FvQGkMKA1JQ
         YZHXUyTj4ZE6tToXQJVaSVe5/3Lw+SZkhPxruuz+5fw8on+HwDGLZKhP1LB62SUcC7ST
         3emBtqDQ/v+fZdnLeYcjEvFBd0u4IVV93UqT8I5UkEok0FOAq0qHFraUswdzR+xuJ3VM
         BFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8YZX6HD1KfYztNlIB7+yLvJefwmGiH93TRfGwqC7PeQ=;
        b=L6hezCkc3sdER9lPC3S0YIvSeecc0FUjI0ckHmZBXigsdC3d0251Lx16rqwWAkD4Fr
         pOqGCHiiwnm9tK2uB890MCLIhFlDjDC3Zl0bcxiCPnWP47Pgmkzs0Mnen1H6oOyCVbMu
         kHFH5qbuFgCnNhWFAkeghWcTQGB90lT5ORbijFZMPQhKUF7NuDiRT99KNgK9/x0Cv+de
         oV/xgw0Iizzg92I2c9DI9WOdxh6Bci5PErZOu0TRBtl0BHP93jnb6ahUoN/ypQs16pys
         tf+FYVFlU8xuLcVdWNNEOsaO3/+6Q/DPAFzfQhaSOaEkdmvcPooofECZrO5tlZ1cVSRo
         SnnA==
X-Gm-Message-State: AGi0PuYtemIshKVmIU9KrjAt2VCpYQb6Nvyb2cYye47ojcuDsR85Y/IL
        +xLVqI7C3zuHNrF1duvUTBqEIw==
X-Google-Smtp-Source: APiQypLl2Ehi4h73KGGNsjckSs7WvC6lIR9KZ34gD4K2jG94Yygdx+ppB+/wUZoUStYLcS5AnUW+Lw==
X-Received: by 2002:a05:6402:31b1:: with SMTP id dj17mr15648996edb.146.1587937789583;
        Sun, 26 Apr 2020 14:49:49 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:48 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 3/9] btrfs: use set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:19 +0200
Message-Id: <20200426214925.10970-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in btrfs.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/btrfs/disk-io.c   |  4 +---
 fs/btrfs/extent_io.c | 21 ++++++---------------
 fs/btrfs/inode.c     | 17 ++++-------------
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6cb5cbbdb9f..1230863e80f9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -980,9 +980,7 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
 			   "page private not zero on page %llu",
 			   (unsigned long long)page_offset(page));
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
+		clear_fs_page_private(page);
 	}
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39e45b8a5031..de8c2d5a99db 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3076,22 +3076,16 @@ static int submit_extent_page(unsigned int opf,
 static void attach_extent_buffer_page(struct extent_buffer *eb,
 				      struct page *page)
 {
-	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
-		get_page(page);
-		set_page_private(page, (unsigned long)eb);
-	} else {
+	if (!PagePrivate(page))
+		set_fs_page_private(page, eb);
+	else
 		WARN_ON(page->private != (unsigned long)eb);
-	}
 }
 
 void set_page_extent_mapped(struct page *page)
 {
-	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
-		get_page(page);
-		set_page_private(page, EXTENT_PAGE_PRIVATE);
-	}
+	if (!PagePrivate(page))
+		set_fs_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
 }
 
 static struct extent_map *
@@ -4929,10 +4923,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 * We need to make sure we haven't be attached
 			 * to a new eb.
 			 */
-			ClearPagePrivate(page);
-			set_page_private(page, 0);
-			/* One for the page private */
-			put_page(page);
+			clear_fs_page_private(page);
 		}
 
 		if (mapped)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..07871c57ba96 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8303,11 +8303,8 @@ btrfs_readpages(struct file *file, struct address_space *mapping,
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	if (ret == 1)
+		clear_fs_page_private(page);
 	return ret;
 }
 
@@ -8331,11 +8328,9 @@ static int btrfs_migratepage(struct address_space *mapping,
 
 	if (page_has_private(page)) {
 		ClearPagePrivate(page);
-		get_page(newpage);
-		set_page_private(newpage, page_private(page));
+		set_fs_page_private(newpage, (void *)page_private(page));
 		set_page_private(page, 0);
 		put_page(page);
-		SetPagePrivate(newpage);
 	}
 
 	if (PagePrivate2(page)) {
@@ -8458,11 +8453,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	ClearPageChecked(page);
-	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	clear_fs_page_private(page);
 }
 
 /*
-- 
2.17.1


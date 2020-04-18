Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D577D1AF5B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 00:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDRWve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Apr 2020 18:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgDRWvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Apr 2020 18:51:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F7C061A0F
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Apr 2020 15:51:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so4088455edv.8
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Apr 2020 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0luk3914pNV5Z2D7FYXeVI+e9BK/K/Gjo+01ZBjbXw=;
        b=O73MuiYGbH+46Zl86nDDirPeDGYbeg/MIxxMvueibpPnSdgLygy21X46HZ+Xf+goJq
         Qiucm8uTgdm1kKgVo4DDDd7YY8SijdSg6Ax/MdtPlPdqE8e2yoMqCt7rMn8ZVpK7mnyQ
         IYNz76+sHMe+LQFguG/J9+Uqmkh2GgQIUjH6anVaqN8C50hJ5CunSmFkVu4BvJ8uDm1y
         erUzcARK+PvWzcnMS8dorPNIJB4WUWCgUGJN6eP+RvCutj5InHUcSXU9Zq8GvsOSSH1R
         w1fsukDzIl11L0Fr6Q/yUJPl4/Vty1soCKCJErN96BQ1VgMrWPtiNNyssaOOomsXQ020
         FGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0luk3914pNV5Z2D7FYXeVI+e9BK/K/Gjo+01ZBjbXw=;
        b=mPKz7QPJ2HDBMbHrcsFlXBNvUc9vWZl3n7YOpvZJhgFZOnUFgTshIlrqVahSDS6tWr
         JcP+PQTdYmJx+JzuvDz0g24wQeSMMRidVxEJK9MZlDe1EhSOfuizYjrWvVniXeUkDB7y
         KqIdhc2XnCWaSHEwE4TbNnitv1ezxCVYgVFhT20713Euaet6BDTt/WVFn6WRniRZ6o3T
         BgYaNUyXer5mMt63e8n+02x+tLY/MkvQ3SbsipHwA5s7OGt4DIwCk0UUsZIVc5mqONBL
         scrR7qaVsiM3U6j7qgwG5tYHgjWZgU/dMmVTfCxF46wNMkq9IxtpgfoWiSM6unE+ilB8
         kYCw==
X-Gm-Message-State: AGi0PuYCCyFqT51BwuLWPsheIKv9+JiB/k0ejh7GjIOz0nOZOaHwofDa
        pq/cZL1exPZ2vVME0vz4F7y0JQ==
X-Google-Smtp-Source: APiQypJjvw0Gub6G6MI63rFhPdm4CjFtb+5QNO1gPvUdj5qsoRBqC0pSuXpDMCdrmXWe3sl4cjp9BA==
X-Received: by 2002:aa7:cd6a:: with SMTP id ca10mr8572866edb.332.1587250289576;
        Sat, 18 Apr 2020 15:51:29 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:6c58:b8bc:cdc6:2e2d])
        by smtp.gmail.com with ESMTPSA id g21sm2616767ejm.79.2020.04.18.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:51:28 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: call __clear_page_buffers to simplify code
Date:   Sun, 19 Apr 2020 00:51:20 +0200
Message-Id: <20200418225123.31850-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some places can be replaced with __clear_page_buffers after the function
is exported.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/btrfs/disk-io.c   |  5 ++---
 fs/btrfs/extent_io.c |  6 ++----
 fs/btrfs/inode.c     | 14 ++++----------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6cb5cbbdb9f..0f1e5690e8a4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -17,6 +17,7 @@
 #include <linux/error-injection.h>
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
+#include <linux/buffer_head.h>
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
 #include "ctree.h"
@@ -980,9 +981,7 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
 			   "page private not zero on page %llu",
 			   (unsigned long long)page_offset(page));
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
+		__clear_page_buffers(page);
 	}
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39e45b8a5031..317a1cdc7d3e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -13,6 +13,7 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/cleancache.h>
+#include <linux/buffer_head.h>
 #include "extent_io.h"
 #include "extent-io-tree.h"
 #include "extent_map.h"
@@ -4929,10 +4930,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 * We need to make sure we haven't be attached
 			 * to a new eb.
 			 */
-			ClearPagePrivate(page);
-			set_page_private(page, 0);
-			/* One for the page private */
-			put_page(page);
+			__clear_page_buffers(page);
 		}
 
 		if (mapped)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..95886202c74f 100644
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
+		__clear_page_buffers(page);
 	return ret;
 }
 
@@ -8458,11 +8455,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	ClearPageChecked(page);
-	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	if (PagePrivate(page))
+		__clear_page_buffers(page);
 }
 
 /*
-- 
2.17.1


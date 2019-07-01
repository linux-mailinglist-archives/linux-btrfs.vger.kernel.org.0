Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D885C174
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfGAQu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 12:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727563AbfGAQu6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 12:50:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BD66ABE7
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2019 16:50:57 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Move free_pages_out label in inline extent handling branch in compress_file_range
Date:   Mon,  1 Jul 2019 19:50:55 +0300
Message-Id: <20190701165055.15483-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701165055.15483-1-nborisov@suse.com>
References: <20190701165055.15483-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This label is only executed if compress_file_range fails to create an
inline extent. So move its code in the semantically related inline
extent handling branch. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b0bf5ea9eb6..072a300f8487 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -600,7 +600,14 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 						     PAGE_SET_WRITEBACK |
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
-			goto free_pages_out;
+
+			for (i = 0; i < nr_pages; i++) {
+				WARN_ON(pages[i]->mapping);
+				put_page(pages[i]);
+			}
+			kfree(pages);
+
+			return 0;
 		}
 	}
 
@@ -678,15 +685,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	compressed_extents += 1;
 
 	return compressed_extents;
-
-free_pages_out:
-	for (i = 0; i < nr_pages; i++) {
-		WARN_ON(pages[i]->mapping);
-		put_page(pages[i]);
-	}
-	kfree(pages);
-
-	return 0;
 }
 
 static void free_async_extent_pages(struct async_extent *async_extent)
-- 
2.17.1


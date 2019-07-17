Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6E6BB9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfGQLlt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 07:41:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbfGQLlt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 07:41:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 004E1ADFC
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 11:41:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Move free_pages_out label in inline extent handling branch in compress_file_range
Date:   Wed, 17 Jul 2019 14:41:45 +0300
Message-Id: <20190717114145.27731-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717114145.27731-1-nborisov@suse.com>
References: <20190717114145.27731-1-nborisov@suse.com>
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
index 53f973161e6d..a84d73b670ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -601,7 +601,14 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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
 
@@ -679,15 +686,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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


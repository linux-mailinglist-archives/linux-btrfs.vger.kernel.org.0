Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E74EC9D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiC3QqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348916AbiC3QqG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:06 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94C71D7639;
        Wed, 30 Mar 2022 09:44:20 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id BB99680505;
        Wed, 30 Mar 2022 12:44:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648658660; bh=2vDZxqOwL/Uguo0MetysoT9MQskq4w66hKhbgUWx4og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rn+gCgUJHYnJ6pCRofwXqyQz3swpxn7noQEe3+0hH1LkMbrG+XvFVzC5D7f07BYvD
         AfgTpZMFnIZ7ScM3MuMXwQtZGa3MoYU5qOVAA6NEQUAFR2Eyagc4aFYuzpg/kRabp6
         N53wUyWHbvjdw1it1W3DLoopUnHCFSl5piMgdwFoLX0BVvTfSaAvy4np5Cm7EfoXZv
         6wLUH0oILhDsd62mIQIkGJbnAa6jU+2JVGCY3NdKJD/5NUMUnNcFt334KHLXawc2xS
         g65TSbNQobORSO8nxioGjhqvj7frTguZIafak1KFOni7/QC+MNmwRUWsrfdWqbxF9e
         ZzjtrSJyWDIKg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs: allocate page arrays using bulk page allocator
Date:   Wed, 30 Mar 2022 12:44:07 -0400
Message-Id: <4a0be376555602a8ee07b3cb58add0efcce3abd5.1648658236.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1648658235.git.sweettea-kernel@dorminy.me>
References: <cover.1648658235.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While calling alloc_page() in a loop is an effective way to populate an
array of pages, the kernel provides a method to allocate pages in bulk.
alloc_pages_bulk_array() populates the NULL slots in a page array, trying to
grab more than one page at a time.

Unfortunately, it doesn't guarantee allocating all slots in the array,
but it's easy to call it in a loop and return an error if no progress
occurs. Similar code can be found in xfs/xfs_buf.c:xfs_buf_alloc_pages().

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
Changes in v2:
 - Moved from ctree.c to extent_io.c
---
 fs/btrfs/extent_io.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5700fcc23271..52abad421ba1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3144,17 +3144,24 @@ static void end_bio_extent_readpage(struct bio *bio)
  */
 int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array)
 {
-	int i;
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page;
-		if (page_array[i])
+	long allocated = 0;
+	for (;;) {
+		long last = allocated;
+
+		allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages,
+						   page_array);
+		if (allocated == nr_pages)
+			return 0;
+
+		if (allocated != last)
 			continue;
-		page = alloc_page(GFP_NOFS);
-		if (!page)
-			return -ENOMEM;
-		page_array[i] = page;
+		/*
+		 * During this iteration, no page could be allocated, even
+		 * though alloc_pages_bulk_array() falls back to alloc_page()
+		 * if  it could not bulk-allocate. So we must be out of memory.
+		 */
+		return -ENOMEM;
 	}
-	return 0;
 }
 
 /*
-- 
2.35.1


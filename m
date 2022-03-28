Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3590B4EA135
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiC1UQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiC1UQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 16:16:19 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527D27170;
        Mon, 28 Mar 2022 13:14:36 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id F291D806B7;
        Mon, 28 Mar 2022 16:14:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648498476; bh=2bUR5RKViaX8SfbfpxT73b8DjBpuhwRa7cVPxAtx/6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsDCL2Tl8mA9FyUPuqPxAWP5cVNeY0rH39m8oVf6XV0DTWycWgBl319eBc75KsY17
         v5UsddxghGXwIVRUYWL+3XfL7Rt+01E5bouWImkd5DIhNoHquffIH5mXThxVOENGPL
         SlptkK2XFMg1mJNaIjaiS2mIc+j3pFcSfvzAcCfZex7jO8Bjh1q97Q50TwydLWjtnW
         s4+gMkXWFvrDfFBc1RZLW6tlJQj4qrcSzPbfYLkVnIPRKEE36WmWa0ER+4RK1qJFQ1
         TJcbkAmwR/3cTa9n+uUyjqq1N479s/NvaaRTGNn3Pqe6OWjZKEanFn18Vi5mCmzcsE
         85C1zMNzs3DWw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 2/2] btrfs: Allocate page arrays using bulk page allocator.
Date:   Mon, 28 Mar 2022 16:14:28 -0400
Message-Id: <9cbd861d3b302e19b990848ea747d2ea91d01aed.1648497027.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1648497027.git.sweettea-kernel@dorminy.me>
References: <cover.1648497027.git.sweettea-kernel@dorminy.me>
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
---
 fs/btrfs/ctree.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4e81e75c8e7c..37711a66e726 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -102,17 +102,24 @@ void btrfs_free_path(struct btrfs_path *p)
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


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6754E656
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377179AbiFPPpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbiFPPpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 11:45:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC439172
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655394354; x=1686930354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KpSj8w6uqqCaVBn0k0Rp5RipretDmasRScMVOgX/ToA=;
  b=EWJCQr+08gIDtAG/zuhSqCxrdSd0dLEGMYSNQDDO8nco/fpBpUGfxsVH
   oR6UV0OJLUBneT/ongJiZuWz5PojYknc5zs7FJITpq6aIJGh7I7n/2Ap7
   v0hj4vsdbkoMDizMifh6C4HdI+MRKjeBSplT5orJAu2FUuz39Nt7wuaR1
   Sp8s+UPMryR3+UUmQYb99OjoA/8SjvXHswYVZ3wNbeqGIAeLQ/SKN7Umb
   aORTlfHbHIToDp/PIb3584YN6OdBKFSynYuvqtDI7M8GlceZGS7o5Gxi2
   tBdeV6wL6klNfMHubs8enjTFj/ydpbepuvbH+48Vt3bQ181jhKL+DtK7u
   w==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650902400"; 
   d="scan'208";a="204103912"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 23:45:52 +0800
IronPort-SDR: nBmkJz6mJ1BS88NAEl2TYZfc8qyvrETWT2mgImy2o06NQUwYkGtIp/t2qzzMFSRxuI7mhivW4b
 aNvJREFFwPZKGw0CsePaZAsJxV3/xPbdwwa0IUdph71VTbJe8N0wA5RN98Tx+tnYCBO2M7Rerf
 I0iqRXF+kTaIfD+CupKjvJ58LkN5FtrDz5mw179VqSIIzNVYy0qf1CA4dVn5QvDRw2gQa0U8IC
 bu9W2ZoiBd94wcAP596R1rbrM+esqGHJYwVG+eEY/OSH/jvZqPSXfyvEQx9E25C4xj2BvUHu9B
 9rGmLZ+Ejbj/9AyL55eVFnPL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 08:04:03 -0700
IronPort-SDR: RWe2B8v/pJyb2pK3tanNY/91cqU/WglOzVbIc9M09hddoXcKYaWCx1Y+VYbN5hzxYpWVky68pw
 h2S6sCv3p6iqITVjIBq2swa/6iBxm2hO3+J+rpNtsUvsGSztcyqEvKiW04PDsMDk0y2oM+oQTt
 CbN4BzQ39LNC2LPUkkStFmlzJXZg4kRl12eM9uYiag0EtQJ9jEzNDCSDSPjzMJPw5o68kJxAdt
 hpJH4QHxn4N+Fz7PF1jgp0unWnaN27IbO7WVtL6dfvCM4whUt0fsI+CTCye6ayxYnyyXaf3X86
 g64=
WDCIronportException: Internal
Received: from jpf010151.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.117])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2022 08:45:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] btrfs: extend btrfs_cleanup_ordered_extens for NULL locked_page
Date:   Fri, 17 Jun 2022 00:45:40 +0900
Message-Id: <6de954aed27f8e5ebccd780bbc40ce37a6ddf4f1.1655391633.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655391633.git.naohiro.aota@wdc.com>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_cleanup_ordered_extents() assumes locked_page to be non-NULL, so it
is not usable for submit_uncompressed_range() which can habe NULL
locked_page.

This commit supports locked_page == NULL case. Also, it rewrites redundant
"page_offset(locked_page)".

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0c3d9998470f..4e1100f84a88 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -195,11 +195,14 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 {
 	unsigned long index = offset >> PAGE_SHIFT;
 	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
-	u64 page_start = page_offset(locked_page);
-	u64 page_end = page_start + PAGE_SIZE - 1;
-
+	u64 page_start, page_end;
 	struct page *page;
 
+	if (locked_page) {
+		page_start = page_offset(locked_page);
+		page_end = page_start + PAGE_SIZE - 1;
+	}
+
 	while (index <= end_index) {
 		/*
 		 * For locked page, we will call end_extent_writepage() on it
@@ -212,7 +215,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		 * btrfs_mark_ordered_io_finished() would skip the accounting
 		 * for the page range, and the ordered extent will never finish.
 		 */
-		if (index == (page_offset(locked_page) >> PAGE_SHIFT)) {
+		if (locked_page && index == (page_start >> PAGE_SHIFT)) {
 			index++;
 			continue;
 		}
@@ -231,17 +234,20 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		put_page(page);
 	}
 
-	/* The locked page covers the full range, nothing needs to be done */
-	if (bytes + offset <= page_offset(locked_page) + PAGE_SIZE)
-		return;
-	/*
-	 * In case this page belongs to the delalloc range being instantiated
-	 * then skip it, since the first page of a range is going to be
-	 * properly cleaned up by the caller of run_delalloc_range
-	 */
-	if (page_start >= offset && page_end <= (offset + bytes - 1)) {
-		bytes = offset + bytes - page_offset(locked_page) - PAGE_SIZE;
-		offset = page_offset(locked_page) + PAGE_SIZE;
+	if (locked_page) {
+		/* The locked page covers the full range, nothing needs to be done */
+		if (bytes + offset <= page_start + PAGE_SIZE)
+			return;
+		/*
+		 * In case this page belongs to the delalloc range being
+		 * instantiated then skip it, since the first page of a range is
+		 * going to be properly cleaned up by the caller of
+		 * run_delalloc_range
+		 */
+		if (page_start >= offset && page_end <= (offset + bytes - 1)) {
+			bytes = offset + bytes - page_offset(locked_page) - PAGE_SIZE;
+			offset = page_offset(locked_page) + PAGE_SIZE;
+		}
 	}
 
 	return __endio_write_update_ordered(inode, offset, bytes, false);
-- 
2.35.1


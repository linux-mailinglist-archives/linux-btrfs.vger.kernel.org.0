Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61309552B3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiFUGoH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbiFUGoG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:44:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335E1B7B1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655793845; x=1687329845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEsr0emZcvqZpNaKlHb50eTZgkPIqmlIf01Dsc7MAsQ=;
  b=F44u9SFWmSRcQNovfSJVaQRtZtp1yBsvJsvPi6RzKqZJgVGrEgCxQ9UO
   FlXPuJzFJ4zhRl81DO0/92p4Kx3PRtWvB+kCrvj7KhUcUCtx9JiIf5Ri3
   OmBaIinabi2S9QRB0yNi+i/eDZVRDM3xG+znJGaghfJisZMY4Scm9Am+a
   B+dwwms2rqSeInvZz2wtC4w21QDTjHwB300rK1iPAMUQpYful1rnt7M4P
   P7harNNUUnrEcEBpzWEhXNORiXvpWxgst/7w52yb0LSAkap5aeBkkgnCH
   OmooUgl8HdLsgPBrPkdYYxoX7rStcb+UIGgphvMnpHZs94XDJnULUvMcZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="208550411"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 14:44:03 +0800
IronPort-SDR: 52nx6uL9Dpnopo3yh/TYDn1oTh0uihv1W9CGE4kY+sR/BiBNWzpei+0d6vRm3m61qWrbc8nsSA
 hb5GLxnsOQALkRl59BoIeYw+VTaK4PHW632gdS1xoh7aE9ijygOw8xDTdz7LKhJ/egZchTU2F5
 mtdCtBWgXtK15sUcf8O53QaTVK+I7MicNMnAaBs7CSXx1lLdaPiOLOEtvkmyzyI0mZJhLLly22
 zP5OkvWS8GmELo59k7ntQWQsySJmiVrOH/iKmFnedtVefHt+nzkNQSIUkX3/LXLVXz1yl/94Gj
 otsaXSMih7saAofFqRqea10O
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 23:02:12 -0700
IronPort-SDR: SWIStqUcT8oi9lqWIWD6RwaP+MhQ7R7q+sAxyd0eVJWC5pd2vhpUSffmAs6FRJvUHiMuszdH55
 7aF0Hv6xLwMJrTE2E/4Uxk0nxAqqru4ctnuoRFlvfwj3+C77nj5wJz0IY7Tpc2/iye1yfYCBG8
 u1+itkEegaEyGjsLO1NoxK4NcZNQ28kgrlUWYCGAzgCCua3DCuOsj3IlUAFRRxXpwe6tYJutNE
 e2iHBwoVnUQVP/LASr9ad3YthGF8gW/Mzy1W4zyz9JyQVH1/QYumpaI3y6PG1EMBJHaUnJcVDN
 KD4=
WDCIronportException: Internal
Received: from dtjcyy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jun 2022 23:44:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/4] btrfs: extend btrfs_cleanup_ordered_extens for NULL locked_page
Date:   Tue, 21 Jun 2022 15:41:00 +0900
Message-Id: <b1c610bf091e86a3520453906c24dc101d929804.1655791781.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655791781.git.naohiro.aota@wdc.com>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
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
index 4f453f6077fe..326150552e57 100644
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


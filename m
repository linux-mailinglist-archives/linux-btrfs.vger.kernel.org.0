Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAE2B1B5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKMMwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:46490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKMMwL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbYUQ7D6IJMgb+MnV6k8L1txw2aF2D2I2hWgEEqAbSM=;
        b=NTr1q+eBRDzJya7uehbU0ttlY5KocLCitQPLMa6V+nAGTBXgvLRm9gddq6IdAbCbG6toOm
        SPdGsuFeS14naCTohMx+cJgmcwA3zMwIanicfuVnxmB+BeJA0RekEHXMAYYU0t/ddhCiVB
        Qg0E074TI9uzXvNMQRmzzMc2y7Ao4MQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFC86ABD6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:52:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/24] btrfs: extent_io: introduce helper to handle page status update in end_bio_extent_readpage()
Date:   Fri, 13 Nov 2020 20:51:29 +0800
Message-Id: <20201113125149.140836-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, endio_readpage_release_extent(), to handle
update status update in end_bio_extent_readpage().

The refactor itself is not really nothing interesting, the point here is
to provide the basis for later subpage support, where the page status
update can be more complex than current code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b5b3700943e0..caafe44542e8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2849,6 +2849,17 @@ endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
+static void endio_readpage_update_page_status(struct page *page, bool uptodate)
+{
+	if (uptodate) {
+		SetPageUptodate(page);
+	} else {
+		ClearPageUptodate(page);
+		SetPageError(page);
+	}
+	unlock_page(page);
+}
+
 /*
  * after a readpage IO is done, we need to:
  * clear the uptodate bits on error
@@ -2971,14 +2982,10 @@ static void end_bio_extent_readpage(struct bio *bio)
 			off = offset_in_page(i_size);
 			if (page->index == end_index && off)
 				zero_user_segment(page, off, PAGE_SIZE);
-			SetPageUptodate(page);
-		} else {
-			ClearPageUptodate(page);
-			SetPageError(page);
 		}
-		unlock_page(page);
 		offset += len;
 
+		endio_readpage_update_page_status(page, uptodate);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
-- 
2.29.2


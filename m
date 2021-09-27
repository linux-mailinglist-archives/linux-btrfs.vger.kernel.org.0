Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A38418FD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhI0HYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56812 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhI0HYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CB7E20090
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TX/fmlKtoAcVRGx6klxNr1bFg2WTHQBsa7MDpT3lZLU=;
        b=ikDoA7HCrgY3/wKZMKTVKFX6EG7Gijnp1y/7SlHqfmgu5+8gcEnS4LiNewYFLAA765Lbrx
        TeufEy8izb37laPDp/wPfAUE9NNU+48D/FpOEd6UqgclBDrmKrxZaEqMFjRF9hm74fQMoP
        bNZpckuFmLFEKyazRtKLmzkaDLvltp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65F3813A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QI/JDDRxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 02/26] btrfs: remove unnecessary parameter @delalloc_start for writepage_delalloc()
Date:   Mon, 27 Sep 2021 15:21:44 +0800
Message-Id: <20210927072208.21634-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function __extent_writepage() we always pass page start to
@delalloc_start for writepage_delalloc().

Thus we don't really need @delalloc_start parameter as we can extract it
from @page.

So this patch will remove @delalloc_start parameter and make
__extent_writepage() to declare @page_start and @page_end as const.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c56973f7daae..ba258b8329c9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3768,10 +3768,11 @@ static void update_nr_written(struct writeback_control *wbc,
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc,
-		u64 delalloc_start, unsigned long *nr_written)
+		unsigned long *nr_written)
 {
-	u64 page_end = delalloc_start + PAGE_SIZE - 1;
+	u64 page_end = page_offset(page) + PAGE_SIZE - 1;
 	bool found;
+	u64 delalloc_start = page_offset(page);
 	u64 delalloc_to_write = 0;
 	u64 delalloc_end = 0;
 	int ret;
@@ -4049,8 +4050,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 			      struct extent_page_data *epd)
 {
 	struct inode *inode = page->mapping->host;
-	u64 start = page_offset(page);
-	u64 page_end = start + PAGE_SIZE - 1;
+	const u64 page_start = page_offset(page);
+	const u64 page_end = page_start + PAGE_SIZE - 1;
 	int ret;
 	int nr = 0;
 	size_t pg_offset;
@@ -4085,7 +4086,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!epd->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
+		ret = writepage_delalloc(BTRFS_I(inode), page, wbc,
 					 &nr_written);
 		if (ret == 1)
 			return 0;
@@ -4136,7 +4137,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 * capable of that.
 	 */
 	if (PageError(page))
-		end_extent_writepage(page, ret, start, page_end);
+		end_extent_writepage(page, ret, page_start, page_end);
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
-- 
2.33.0


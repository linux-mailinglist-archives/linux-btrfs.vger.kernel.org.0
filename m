Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52183FA940
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhH2FZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:25:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhH2FZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:25:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 494BD1FD50
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQLMh096uneLUfHF1OdGzRovA1RudrQafl9kw/nIcrA=;
        b=Wpcl+1jTyyT4Fl4kHK03eiRuPqTzJMwRIyD2upoobPRhwWmIqoF8KpqwB6j/da3lL/g0Do
        S+fNYyhIWQmdAcMrVVA5y8j+cRp9V8qUyE2F78kEl38+3aqme46rjQ2iYocGY3rzvQA+gU
        yiVk08yF4QyFyTo10CLgwCX+M9R/tTA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 865B913964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EFhxEi8aK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/26] btrfs: remove unnecessary parameter @delalloc_start for writepage_delalloc()
Date:   Sun, 29 Aug 2021 13:24:34 +0800
Message-Id: <20210829052458.15454-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
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
index 5ad749e19ff3..2806949c6243 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3777,10 +3777,11 @@ static void update_nr_written(struct writeback_control *wbc,
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
@@ -4058,8 +4059,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
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
@@ -4094,7 +4095,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!epd->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
+		ret = writepage_delalloc(BTRFS_I(inode), page, wbc,
 					 &nr_written);
 		if (ret == 1)
 			return 0;
@@ -4145,7 +4146,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 * capable of that.
 	 */
 	if (PageError(page))
-		end_extent_writepage(page, ret, start, page_end);
+		end_extent_writepage(page, ret, page_start, page_end);
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
-- 
2.32.0


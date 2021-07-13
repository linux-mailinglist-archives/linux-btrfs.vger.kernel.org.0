Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760163C6A46
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhGMGSW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36328 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhGMGSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C647D22138
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkjW+QQ0jOB9PtEkH6nBKQ9MoWBGHMLZkA6eKnr6n1w=;
        b=Arny5q3L4mFCGoDueacdxq4vs/rXdzIFft8BW8G+leeAC8/W5ZmW8DaK5lT/FB+PQ5mmQC
        V13qPJuX3wlbLE80Ymr6qSiqMcOqkW/aJ0jEnnafUMfLJLFg73BFC3XoHfx4dqmPmrgFTB
        7D0umLijjzpS1a25Az8Sb6T19E7bOrY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 10DC7139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cNxFMXkv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/27] btrfs: remove unnecessary parameter @delalloc_start for writepage_delalloc()
Date:   Tue, 13 Jul 2021 14:14:51 +0800
Message-Id: <20210713061516.163318-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
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
index 248f22267665..d11facbd64c0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3774,10 +3774,11 @@ static void update_nr_written(struct writeback_control *wbc,
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
@@ -4093,7 +4094,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!epd->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
+		ret = writepage_delalloc(BTRFS_I(inode), page, wbc,
 					 &nr_written);
 		if (ret == 1)
 			return 0;
@@ -4114,7 +4115,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 	if (PageError(page)) {
 		ret = ret < 0 ? ret : -EIO;
-		end_extent_writepage(page, ret, start, page_end);
+		end_extent_writepage(page, ret, page_start, page_end);
 	}
 	unlock_page(page);
 	ASSERT(ret <= 0);
-- 
2.32.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E082EB754
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAFBDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:45510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbhAFBDA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAOnzGq4fqd4tHgrK/3fU3OEOYJrvhstZ5ZdY6CuKkg=;
        b=Qp75qx9cvChvrRITCWqETgJH0YwwGeSSDFEjX1igRCHZdZNIb0uACEs6hSiL3ah3PySfc3
        NrxyGTtESjSFlKKHfoM39FbEgs0imaOR6GClHDOnGmFuPeGZVenUZxAQCp5nWhU/Ep+6sp
        vhum+AUr+DNhrRE9N9keKFJcKjFcmZ4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EC10ADE6
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/22] btrfs: extent_io: update locked page dirty/writeback/error bits in __process_pages_contig()
Date:   Wed,  6 Jan 2021 09:01:43 +0800
Message-Id: <20210106010201.37864-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When __process_pages_contig() get called for
extent_clear_unlock_delalloc(), if we hit the locked page, only Private2
bit is updated, but dirty/writeback/error bits are all skiped.

There are several call sites call extent_clear_unlock_delalloc() with
@locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBACK

- cow_file_range()
- run_delalloc_nocow()
- cow_file_range_async()
  All for their error handling branches.

For those call sites, since we skip the locked page for
dirty/error/writeback bit update, the locked page will still have its
dirty bit remaining.

Thankfully, since all those call sites can only be hit with various
serious errors, it's pretty hard to hit and shouldn't affect regular
btrfs operations.

But still, we shouldn't leave the locked_page with its
dirty/error/writeback bits untouched.

Fix this by only skipping lock/unlock page operations for locked_page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6f156ce501a1..098c68583ebb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1970,11 +1970,6 @@ static int __process_pages_contig(struct address_space *mapping,
 			if (page_ops & PAGE_SET_PRIVATE2)
 				SetPagePrivate2(pages[i]);
 
-			if (locked_page && pages[i] == locked_page) {
-				put_page(pages[i]);
-				pages_processed++;
-				continue;
-			}
 			if (page_ops & PAGE_CLEAR_DIRTY)
 				clear_page_dirty_for_io(pages[i]);
 			if (page_ops & PAGE_SET_WRITEBACK)
@@ -1983,6 +1978,11 @@ static int __process_pages_contig(struct address_space *mapping,
 				SetPageError(pages[i]);
 			if (page_ops & PAGE_END_WRITEBACK)
 				end_page_writeback(pages[i]);
+			if (locked_page && pages[i] == locked_page) {
+				put_page(pages[i]);
+				pages_processed++;
+				continue;
+			}
 			if (page_ops & PAGE_UNLOCK)
 				unlock_page(pages[i]);
 			if (page_ops & PAGE_LOCK) {
-- 
2.29.2


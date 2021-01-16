Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D605B2F8BF8
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAPHQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:16:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:55940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbhAPHQ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:16:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jT2FlbFb5n2kN9losXqoiv1O32/bpQbWYnwrcDXeOlk=;
        b=HZb3cm5Qajqijp1i85+Frto5Ssurzsl4uYQRDphTWoTdNO0FRay6Jn4RIVUubLD057+GIA
        ehQxj/GWQu0T8xTvjE206zflw+zbP+fGKqjXyp+dzrKyCdwBxqxV2NHLhw5AUtjXFUEN4J
        bpR6r//qOtfllp/G37c21167xtUmanw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 825D6AC63
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:15:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error bits in __process_pages_contig()
Date:   Sat, 16 Jan 2021 15:15:16 +0800
Message-Id: <20210116071533.105780-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When __process_pages_contig() get called for
extent_clear_unlock_delalloc(), if we hit the locked page, only Private2
bit is updated, but dirty/writeback/error bits are all skipped.

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
index 7f689ad7709c..3442f1746683 100644
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
2.30.0


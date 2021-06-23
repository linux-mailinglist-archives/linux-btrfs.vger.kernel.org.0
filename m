Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8E3B1388
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFWF5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:57:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWF5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A757021941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVugdK+zOUMbXo/vgGDQW1NzunSGLisnNvs/l9jtbNc=;
        b=QlRqwyoE1/7BHwXlc3wEl3MRDo5sWS0OLFVNPfqx8yDucAa5/gmWzHLj2kqUCiOp65tbvu
        7BrGaR6wAFpuDFyJ7Og3ifflJQWvCCxaQIzF5gN7xyQTIXVK0NZaQxdYZuuDLbflLcAiP3
        TtvPrOwhWaqu93/VlRuTBNj2OPLW8zA=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id ACE19A3B91
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/8] btrfs: make btrfs_subpage_end_and_test_writer() to handle pages not locked by btrfs_page_start_writer_lock()
Date:   Wed, 23 Jun 2021 13:55:23 +0800
Message-Id: <20210623055529.166678-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Normally if a page is locked by page_lock() other than
btrfs_page_start_writer_lock(), it should be passed as @locked_page for
various extent_clear_unlock_delalloc() call sites.

But there are quite some call sites in compression path, where we
intentionally call extent_clear_unlock_delalloc() with @locked_page ==
NULL.

This will abuse extent_clear_unlock_delalloc() to unlock @locked_page.

This works fine for regular page size, but not really for subpage, as if
a page is locked by btrfs_page_start_writer_lock() it will have proper
@writers value increased.

If a page not locked by btrfs_page_start_writer_lock() we will underflow
the value.

But thankfully, for such pages its @writers value should be zero, and
we can use that to distinguish page locked by
btrfs_page_start_writer_lock() and @locked_page by delalloc.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index a61aa33aeeee..72d5d4712933 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -245,11 +245,33 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	const int nbits = (len >> fs_info->sectorsize_bits);
+	unsigned long flags;
+	bool ret;
 
 	btrfs_subpage_assert(fs_info, page, start, len);
 
+	/* Will do two atomic checks, no longer atomic and need spinlock */
+	spin_lock_irqsave(&subpage->lock, flags);
+
+	/*
+	 * In compression path, we have extent_clear_unlock_delalloc() call
+	 * sites which intentionally pass @locked_page == NULL to unlock
+	 * the locked page.
+	 *
+	 * In that case, @locked_page should has no writer counts, as it's
+	 * not locked by btrfs_page_start_writer_lock().
+	 * For such case, we just return true so that
+	 * btrfs_page_end_writer_lock() will unlock the page.
+	 */
+	if (atomic_read(&subpage->writers) == 0) {
+		ret = true;
+		spin_unlock_irqrestore(&subpage->lock, flags);
+		return ret;
+	}
 	ASSERT(atomic_read(&subpage->writers) >= nbits);
-	return atomic_sub_and_test(nbits, &subpage->writers);
+	ret = atomic_sub_and_test(nbits, &subpage->writers);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	return ret;
 }
 
 /*
-- 
2.32.0


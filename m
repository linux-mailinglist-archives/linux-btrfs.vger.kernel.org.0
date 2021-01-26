Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5F304522
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 18:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbhAZRXx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:23:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:54958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730238AbhAZIgM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:36:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brNgDs+PJeGeVQ5EpQbp/VwTl0xMoWhiRnY/kn2lO8o=;
        b=KGRX6/oukcw/rGdOccxOzDOeCmh4knwRDgD5VPStbOEvQqvuNVCUvKEDfN85tv2NaY+9Kn
        vl9S+hogy1sW4+eP8enfgvaAS5M60g4G1E+k1Wntx7IovlIdMUMzPBppklismDXQoEyA8l
        eFAiVig3tpMX+glzFVEonO/VN/XuDww=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E28AAF4E;
        Tue, 26 Jan 2021 08:34:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 09/18] btrfs: introduce helpers for subpage error status
Date:   Tue, 26 Jan 2021 16:33:53 +0800
Message-Id: <20210126083402.142577-10-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce the following functions to handle subpage error status:

- btrfs_subpage_set_error()
- btrfs_subpage_clear_error()
- btrfs_subpage_test_error()
  These helpers can only be called when the page has subpage attached
  and the range is ensured to be inside the page.

- btrfs_page_set_error()
- btrfs_page_clear_error()
- btrfs_page_test_error()
  These helpers can handle both regular sector size and subpage without
  problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/subpage.c | 29 +++++++++++++++++++++++++++++
 fs/btrfs/subpage.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 50b56e58ca93..2fe55a712557 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -161,6 +161,33 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
+void btrfs_subpage_set_error(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->error_bitmap |= tmp;
+	SetPageError(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+void btrfs_subpage_clear_error(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->error_bitmap &= ~tmp;
+	if (subpage->error_bitmap == 0)
+		ClearPageError(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -180,6 +207,7 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 	return ret;							\
 }
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
@@ -215,3 +243,4 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 			 PageUptodate);
+IMPLEMENT_BTRFS_PAGE_OPS(error, SetPageError, ClearPageError, PageError);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 1dee4eb1c5c1..68cbfc4f6765 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -20,6 +20,7 @@ struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
 	u16 uptodate_bitmap;
+	u16 error_bitmap;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -78,5 +79,6 @@ bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len);
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
+DECLARE_BTRFS_SUBPAGE_OPS(error);
 
 #endif
-- 
2.30.0


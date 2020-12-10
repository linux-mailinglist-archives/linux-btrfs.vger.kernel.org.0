Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6F2D53F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgLJGkE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387496AbgLJGkE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MYT7OdT61w2xAFuZTlre1acT7NXGekPZPGk/vnndeE=;
        b=f4o9k6zEZ7N/ob1jWV+IdMg3BVcCd4Gkmi4uhqjqG/Q3g9TEYhYNyt4e3ZBDJ+30CPfF/h
        no+XdMAVcz8tVtKJw2lrmv6jNcoQ6xkBNP/buLNwBe6qQh7MGNPhGF9NDEoJg+JJY0JAcd
        Vxhw6bgJlqDtriKXqYSXTR1GwYkPtaI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DD0EACE1;
        Thu, 10 Dec 2020 06:39:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 04/18] btrfs: extent_io: introduce a helper to grab an existing extent buffer from a page
Date:   Thu, 10 Dec 2020 14:38:51 +0800
Message-Id: <20201210063905.75727-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will extract the code to grab an extent buffer from a page
into a helper, grab_extent_buffer_from_page().

This reduces one indent level, and provides the work place for later
expansion for subapge support.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 52 +++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 612fe60b367e..6350c2687c7e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5251,6 +5251,32 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
+static struct extent_buffer *grab_extent_buffer_from_page(struct page *page)
+{
+	struct extent_buffer *exists;
+
+	/* Page not yet attached to an extent buffer */
+	if (!PagePrivate(page))
+		return NULL;
+
+	/*
+	 * We could have already allocated an eb for this page
+	 * and attached one so lets see if we can get a ref on
+	 * the existing eb, and if we can we know it's good and
+	 * we can just return that one, else we know we can just
+	 * overwrite page->private.
+	 */
+	exists = (struct extent_buffer *)page->private;
+	if (atomic_inc_not_zero(&exists->refs)) {
+		mark_extent_buffer_accessed(exists, page);
+		return exists;
+	}
+
+	WARN_ON(PageDirty(page));
+	detach_page_private(page);
+	return NULL;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
@@ -5296,26 +5322,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		if (PagePrivate(p)) {
-			/*
-			 * We could have already allocated an eb for this page
-			 * and attached one so lets see if we can get a ref on
-			 * the existing eb, and if we can we know it's good and
-			 * we can just return that one, else we know we can just
-			 * overwrite page->private.
-			 */
-			exists = (struct extent_buffer *)p->private;
-			if (atomic_inc_not_zero(&exists->refs)) {
-				spin_unlock(&mapping->private_lock);
-				unlock_page(p);
-				put_page(p);
-				mark_extent_buffer_accessed(exists, p);
-				goto free_eb;
-			}
-			exists = NULL;
-
-			WARN_ON(PageDirty(p));
-			detach_page_private(p);
+		exists = grab_extent_buffer_from_page(p);
+		if (exists) {
+			spin_unlock(&mapping->private_lock);
+			unlock_page(p);
+			put_page(p);
+			goto free_eb;
 		}
 		attach_extent_buffer_page(eb, p);
 		spin_unlock(&mapping->private_lock);
-- 
2.29.2


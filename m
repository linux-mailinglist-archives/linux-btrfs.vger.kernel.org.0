Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECE82EB75C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAFBDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:45864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbhAFBDj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7EQai5tbuQ+9vQMHjRvC72RHqNGw7lLMYXFsfh+x6s=;
        b=aeup/mxPGlUBTiKGp7psW1lx0bQKBteHfTV3mfsPyoaHSPjiohNd4s1lf3WFdJccVWao2j
        30I0uH06PqHycHTEs6xBMSt9CbRVVzvqTEqp99ecoS96VhGgKrU2U4Gu/fMWeKma93d364
        qJVBE1Uo/rAGSkhVuIic9Qw+DLHs3QQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E10CAF37;
        Wed,  6 Jan 2021 01:02:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 06/22] btrfs: extent_io: introduce a helper to grab an existing extent buffer from a page
Date:   Wed,  6 Jan 2021 09:01:45 +0800
Message-Id: <20210106010201.37864-7-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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
 fs/btrfs/extent_io.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a2a9c2148e91..d60f1837f8fb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5248,6 +5248,30 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
+static struct extent_buffer *grab_extent_buffer(struct page *page)
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
+	if (atomic_inc_not_zero(&exists->refs))
+		return exists;
+
+	WARN_ON(PageDirty(page));
+	detach_page_private(page);
+	return NULL;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
@@ -5293,26 +5317,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
+		exists = grab_extent_buffer(p);
+		if (exists) {
+			spin_unlock(&mapping->private_lock);
+			unlock_page(p);
+			put_page(p);
+			mark_extent_buffer_accessed(exists, p);
+			goto free_eb;
 		}
 		attach_extent_buffer_page(eb, p);
 		spin_unlock(&mapping->private_lock);
-- 
2.29.2


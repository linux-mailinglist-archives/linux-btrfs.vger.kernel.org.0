Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9792B7991
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKRIxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:47572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8tpplqD6qD6QSswY6SdMOGx3ZFJSlFmwmbwwL1xy5s=;
        b=tffQSsURdafsnvTtRagUQGyqRiVEj1iQKFgzLz44LdD1tsTRStMCl93ifAy748ipkDk1wF
        7E7XD8Mh9/blZI3OgaZRpV4mf13xQbGZ0Xqqgf2Z6k4QePcuxbjqFDvnqiHZ10zYMmpOHI
        jNTBtGkNdnIq/CUIhbQ1hDhiBymbQSQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FC61AD2F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/14] btrfs: extent_io: introduce a helper to grab an existing extent buffer from a page
Date:   Wed, 18 Nov 2020 16:53:07 +0800
Message-Id: <20201118085319.56668-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will extract the code to grab an extent buffer from a page
into a helper, grab_extent_buffer_from_page().

This reduces one indent level, and provides the work place for later
expansion for subapge support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 60 ++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 55115f485d09..759d2f2292ed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5249,6 +5249,36 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
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
+	/*
+	 * The page belongs to an eb which is being freed.
+	 * Detach it from previous eb so that we can reuse it.
+	 */
+	detach_page_private(page);
+	return NULL;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
@@ -5293,30 +5323,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
-			WARN_ON(PageDirty(p));
-
-			/*
-			 * Do this so attach doesn't complain and we need to
-			 * drop the ref the old guy had.
-			 */
-			detach_page_private(page);
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


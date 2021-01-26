Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E4304527
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbhAZRYK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:24:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:54950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbhAZIgM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:36:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAlpLzJU7IxvYSBWyZmuKFX7gvKK9uEoAFAvodNgg4Q=;
        b=Bq+OD3eW4uothn+B0IRYWlEDIBw1aZmG49Ggia33QwAeaHxEUE4UUpxDS/t2nu1zFGCyao
        x3AnP5HpBoVYXgQpyEMD+M/O9i6qy8WCGXDl/6c8KEvKWTEIIBkaWLq9kXZrllpWj2Djv2
        /hMA3hoP72f8JR7FNUJTSo1mUDAx5PE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37837ACF4;
        Tue, 26 Jan 2021 08:34:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 05/18] btrfs: make grab_extent_buffer_from_page() handle subpage case
Date:   Tue, 26 Jan 2021 16:33:49 +0800
Message-Id: <20210126083402.142577-6-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, grab_extent_buffer() can't really get an extent buffer
just from btrfs_subpage.

We have radix tree lock protecting us from inserting the same eb into
the tree.  Thus we don't really need to do the extra hassle, just let
alloc_extent_buffer() handle the existing eb in radix tree.

Now if two ebs are being allocated as the same time, one will fail with
-EEIXST when inserting into the radix tree.

So for grab_extent_buffer(), just always return NULL for subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ea105cb69e3a..16a29f63cfd1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5282,10 +5282,19 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
-static struct extent_buffer *grab_extent_buffer(struct page *page)
+static struct extent_buffer *grab_extent_buffer(
+		struct btrfs_fs_info *fs_info, struct page *page)
 {
 	struct extent_buffer *exists;
 
+	/*
+	 * For subpage case, we completely rely on radix tree to ensure we
+	 * don't try to insert two ebs for the same bytenr.  So here we always
+	 * return NULL and just continue.
+	 */
+	if (fs_info->sectorsize < PAGE_SIZE)
+		return NULL;
+
 	/* Page not yet attached to an extent buffer */
 	if (!PagePrivate(page))
 		return NULL;
@@ -5371,7 +5380,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		exists = grab_extent_buffer(p);
+		exists = grab_extent_buffer(fs_info, p);
 		if (exists) {
 			spin_unlock(&mapping->private_lock);
 			unlock_page(p);
-- 
2.30.0


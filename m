Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611E82D540E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgLJGko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387512AbgLJGko (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8Q9e81kElaLMo39JPpupC99/jwWztHF3bGSwjwzKVU=;
        b=EZr1dhBh158hFrau76brJe0ilx8VCFTA2y/WBAhDP5tv0TjmdXKNpRggRHcCrB3tXY5ljp
        cT2X9YOe2NnrSRTKM7xzSlDYq3+p4MDsOi7mSFJpXN31xfZ/+2tJzIcpoGnD6jzF5iKYyf
        lv7fHVDr2JdUNNRAPPswvs5chLK7qI8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0487AD20
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/18] btrfs: extent_io: make grab_extent_buffer_from_page() to handle subpage case
Date:   Thu, 10 Dec 2020 14:38:54 +0800
Message-Id: <20201210063905.75727-8-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, grab_extent_buffer_from_page() can't really get an
extent buffer just from btrfs_subpage.

Although we have btrfs_subpage::tree_block_bitmap, which can be used to
grab the bytenr of an existing extent buffer, and can then go radix tree
search to grab that existing eb.

However we are still doing radix tree insert check in
alloc_extent_buffer(), thus we don't really need to do the extra hassle,
just let alloc_extent_buffer() to handle existing eb in radix tree.

So for grab_extent_buffer_from_page(), just always return NULL for
subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 51dd7ec3c2b3..b99bd0402130 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5278,10 +5278,19 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
-static struct extent_buffer *grab_extent_buffer_from_page(struct page *page)
+static struct extent_buffer *grab_extent_buffer_from_page(
+		struct btrfs_fs_info *fs_info, struct page *page)
 {
 	struct extent_buffer *exists;
 
+	/*
+	 * For subpage case, we completely rely on radix tree to ensure we
+	 * don't try to insert two eb for the same bytenr.
+	 * So here we alwasy return NULL and just continue.
+	 */
+	if (fs_info->sectorsize < PAGE_SIZE)
+		return NULL;
+
 	/* Page not yet attached to an extent buffer */
 	if (!PagePrivate(page))
 		return NULL;
@@ -5361,7 +5370,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		exists = grab_extent_buffer_from_page(p);
+		exists = grab_extent_buffer_from_page(fs_info, p);
 		if (exists) {
 			spin_unlock(&mapping->private_lock);
 			unlock_page(p);
-- 
2.29.2


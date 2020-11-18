Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96AF2B7994
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKRIxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hRBqJWdeoJm3C/t21Lef3o9zCWoAC6evNfOSfYUuHU=;
        b=TKiSXSfUd7q7zyUPx0lINpMkfhmvPXdn4u5lfH3KjnDn+ueDRh93PVy30IStsfK9LdosMW
        EGGdMyEl2HweJLvENhFDIfaCdD18FvXZLXbiYgfxhWAFk7LAytgwuIwul9Ty0ip8PubLKl
        b+28prBS6a9yWd1F1UecFqtQx20wxMo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AD95ABF4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/14] btrfs: extent_io: make grab_extent_buffer_from_page() to handle subpage case
Date:   Wed, 18 Nov 2020 16:53:10 +0800
Message-Id: <20201118085319.56668-6-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
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
index 94101d1e04eb..f424a26a695e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5284,10 +5284,19 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
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
+	if (btrfs_is_subpage(fs_info))
+		return NULL;
+
 	/* Page not yet attached to an extent buffer */
 	if (!PagePrivate(page))
 		return NULL;
@@ -5402,7 +5411,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		exists = grab_extent_buffer_from_page(p);
+		exists = grab_extent_buffer_from_page(fs_info, p);
 		if (exists) {
 			spin_unlock(&mapping->private_lock);
 			unlock_page(p);
-- 
2.29.2


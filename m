Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9692F8BFC
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAPHRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:56144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbhAPHRN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIUiWj736mPErI3yMq7kL8uX6l7OOGl8OPpmeFasdaI=;
        b=qaMchPwruLPMR/mGdESbxSkuxHJ0Od1toL5DdOc7aWcuEPAaaGEi4vWRleZ/aYCxVydDrH
        rIEf5yySnv89FeOr5YkpbLBuJE3rcscaMMAfQRd+akp2XOvdUvotkLKmBYYBXKG12vBREF
        CUBtcPhq8mmU1wYDd7aasYWXYWYuq2M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 498B9B7F6
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:15:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 05/18] btrfs: make grab_extent_buffer_from_page() to handle subpage case
Date:   Sat, 16 Jan 2021 15:15:20 +0800
Message-Id: <20210116071533.105780-6-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, grab_extent_buffer() can't really get an extent buffer
just from btrfs_subpage.

Thankfully we have radix tree lock protecting us from inserting the same
eb into the tree.

Thus we don't really need to do the extra hassle, just let
alloc_extent_buffer() to handle existing eb in radix tree.

Now if two ebs are being allocated as the same time, one will fail with
-EEIXST when inserting its eb into the radix tree.

So for grab_extent_buffer(), just always return NULL for subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 320731487ac0..b2f8ac5e9a9e 100644
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
+	 * don't try to insert two eb for the same bytenr.
+	 * So here we alwasy return NULL and just continue.
+	 */
+	if (fs_info->sectorsize < PAGE_SIZE)
+		return NULL;
+
 	/* Page not yet attached to an extent buffer */
 	if (!PagePrivate(page))
 		return NULL;
@@ -5366,7 +5375,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		exists = grab_extent_buffer(p);
+		exists = grab_extent_buffer(fs_info, p);
 		if (exists) {
 			spin_unlock(&mapping->private_lock);
 			unlock_page(p);
-- 
2.30.0


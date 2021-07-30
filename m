Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC013DB312
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 07:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhG3F7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 01:59:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51864 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhG3F7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 01:59:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E70C22350
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 05:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627624740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TpIXljZnT8YHRrSp1pSaeZxwVdirT8UnI/uNzFJFKxY=;
        b=KpYLgB9RYUzCI8Ar7bVLcPQ5kDfZlaUV9FK3UtMuFDz9ADeMAv/UJLmi8gN3bo1Lr2wP74
        7iDYfd9pb6+z267Ec+rzv5K+GoxUrG5lHIZ/jPzIc/Hctus/ePeis9ydTIJ0jfxrDUB7i5
        /8fDZdxhOVKdCfEKtxdHhs7uG+yFfw4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C2CDB13748
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 05:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5NFbICOVA2GlawAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 05:58:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: setup the page before calling any subpage helper
Date:   Fri, 30 Jul 2021 13:58:57 +0800
Message-Id: <20210730055857.149633-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function set_page_extent_mapped() will setup the data page cache so that
for subpage cases those pages will have page->private to store subpage
specific info.

Normally this happens when we create a new page for the page cache.
But there is a special call site, __extent_writepage(), as we have
special cases where upper layer can mark some page dirty without going
through set_page_dirty() interface.

I haven't yet seen any real world case for this, but if that's possible
then in __extent_writepage() we will call btrfs_page_clear_error()
before setting up the page->private, which can lead to NULL pointer
dereference.

Fix it by moving set_page_extent_mapped() call before
btrfs_page_clear_error().
And make sure in the error path we won't call anything subpage helper.

Fixes: 32443de3382b ("btrfs: introduce btrfs_subpage for data inodes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
I really hope we can have a more explicit comment about in exactly which
cases we can have such page, and maybe some test cases for it.

In fact, I haven't really seen any case like this, and it doesn't really
make sense for me to make some MM layer code to mark a page dirty
without going through set_page_dirty() interface.
---
 fs/btrfs/extent_io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e665779c046d..e82328bcb281 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4065,6 +4065,13 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 
 	WARN_ON(!PageLocked(page));
 
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		SetPageError(page);
+		unlock_page(page);
+		return ret;
+	}
+
 	btrfs_page_clear_error(btrfs_sb(inode->i_sb), page,
 			       page_offset(page), PAGE_SIZE);
 
@@ -4081,12 +4088,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		flush_dcache_page(page);
 	}
 
-	ret = set_page_extent_mapped(page);
-	if (ret < 0) {
-		SetPageError(page);
-		goto done;
-	}
-
 	if (!epd->extent_locked) {
 		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
 					 &nr_written);
-- 
2.32.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09AF38BFD5
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhEUGot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233613AbhEUGoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7uiT8k8UkHpE0BxV8PFyBHvTkexqnU/zm9FYZH1XjE=;
        b=NFGxX0/v7gIYJeHXSQcGECwGZWVOmcEGMgWSAmikB5Ak7Pl4PxwGdTG/E9CwIFfdcH/TiS
        XKZt4Cki1jiycWtXoXa32ZjPRdrj0Z8LV/vzJjFdkfuLI6wL8s6Y3j2Uevfhi+m5PI2Q+r
        3Jr7yk9qUCYPNolRNyp1X8PT/Hx9dr8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C255AE8D
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:41:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 25/31] btrfs: make defrag to be semi subpage compatible
Date:   Fri, 21 May 2021 14:40:44 +0800
Message-Id: <20210521064050.191164-26-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs defrag is mostly just read the page contents and mark them dirty
so later writeback can try to merge them into a larger extent.

Currently only two parts are blocking subpage support in defrag:

- The clear_page_dirty_for_io() and set_page_dirty() calls
  They don't updated the subpage dirty bit, will make subpage writeback
  to skip the page completely, causing ordered extent never to finish.

- The check for whether a page is released
  Needs extra check on page Private flag.

With above calls sites modified, now defrag is semi subpage compatible.

The remaining problem is, we set the full page dirty, which means if we
have a page which only has one sector on-disk, all the other 15 sectors
are just hole, then after defrag the whole 64K page will be re-written
as a new extent.

This is just a place holder to make most btrfs defrag tests happy, a
proper refactor will follow to make btrfs defrag to be completely subpage
compatible later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a7739461533d..0cd6abc88c55 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -47,6 +47,7 @@
 #include "space-info.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "subpage.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
@@ -1160,6 +1161,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 				    unsigned long start_index,
 				    unsigned long num_pages)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long file_end;
 	u64 isize = i_size_read(inode);
 	u64 page_start;
@@ -1225,7 +1227,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 			 * we unlocked the page above, so we need check if
 			 * it was released or not.
 			 */
-			if (page->mapping != inode->i_mapping) {
+			if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
 				unlock_page(page);
 				put_page(page);
 				goto again;
@@ -1243,7 +1245,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 			}
 		}
 
-		if (page->mapping != inode->i_mapping) {
+		if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
 			unlock_page(page);
 			put_page(page);
 			goto again;
@@ -1324,9 +1326,11 @@ static int cluster_pages_for_defrag(struct inode *inode,
 			     page_start, page_end - 1, &cached_state);
 
 	for (i = 0; i < i_done; i++) {
-		clear_page_dirty_for_io(pages[i]);
+		btrfs_page_clear_dirty(fs_info, pages[i], page_offset(pages[i]),
+				       PAGE_SIZE);
 		ClearPageChecked(pages[i]);
-		set_page_dirty(pages[i]);
+		btrfs_page_set_dirty(fs_info, pages[i], page_offset(pages[i]),
+				     PAGE_SIZE);
 		unlock_page(pages[i]);
 		put_page(pages[i]);
 	}
-- 
2.31.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276B13D6E3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 07:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhG0Flh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 01:41:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhG0Flf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 01:41:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3D17200BB
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 05:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627364495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YGw5qGdHmGqIPlNx0Knf/YTTqWz5x5EHHCeVchT0wn8=;
        b=PyIn5IoHyeHIbZsbnHNpbZbV7Tr9nxc5kMqlj+Z+dd56waeHUoP8nHLRqV/SCKgzKNYO/s
        SU/jPw1OboIS7Yr/czykJVjwovjWgIjTLu0RbvZYgdEwj3COzqShdUSi9qmI70xOCAMSV0
        Kp4Y/CRUo8J6l3Aafce22Bf5KxlzZFs=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D3C1013CDF
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 05:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pKQcJI6c/2DCcgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 05:41:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the unused @start and @end parameter for btrfs_run_delalloc_range()
Date:   Tue, 27 Jul 2021 13:41:32 +0800
Message-Id: <20210727054132.164462-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit d75855b4518b ("btrfs: Remove
extent_io_ops::writepage_start_hook") removes the writepage_start_hook()
and added btrfs_writepage_cow_fixup() function, there is no need to
follow the old hook parameters.

This patch just remove the @start and @end hook, since currently the
fixup check is full page check, it doesn't need @start and @end hook.

Signed-off-by: Qu Wenruo <wqu@suse.com>

---
Special discussion related to the cow fixup.

Recently I'm exploring the possibility to change how we submit bio for a
delalloc range.

Currently we call writepage_delalloc(), which may add a new delalloc
range, and set all involved pages with Ordered bit.
But all other pages in the delalloc range is not locked.

Then we iterate through each page in the delalloc range, and submit
them.

This window between "delalloc range added" to "submit bio for the range"
allows a page to be invalidated or changed.

I'm not sure if the behavior (with the extra window with page unlocked)
is correct.
But at least we already have compression going through another path.

For compression, we call cow_file_range(), but keeps all the pages in
the range locked, then submit bio for the range, finally unlock the page
range.

This makes sure between "delalloc range added" to "bio submitted" the
page is still locked and won't change.

Not sure if this can eliminate the need for such fixup.

As for the new method, if we hit a dirty page, we always ran delalloc
range for it.

Thus there is no way a dirty page will not be covered by an ordered extent,
thus eliminate the need for fixup.

---
 fs/btrfs/ctree.h     | 2 +-
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/inode.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 958fe5d085ea..088f33c01a01 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3190,7 +3190,7 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
 		u64 start, u64 end, int *page_started, unsigned long *nr_written,
 		struct writeback_control *wbc, bool unlock_pages);
-int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
+int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, int uptodate);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b26fd39abd39..b0751920f5ee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3942,7 +3942,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
-	ret = btrfs_writepage_cow_fixup(page, start, end);
+	ret = btrfs_writepage_cow_fixup(page);
 	if (ret) {
 		/* Fixup worker will requeue */
 		redirty_page_for_writepage(wbc, page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index baa3c4556a66..684f1ec85351 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2819,7 +2819,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
  * to fix it up.  The async helper will wait for ordered extents, set
  * the delalloc bit and make it safe to write the page.
  */
-int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
+int btrfs_writepage_cow_fixup(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-- 
2.32.0


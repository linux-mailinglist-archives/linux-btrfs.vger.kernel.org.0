Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4733D346C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 08:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhGWF02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 01:26:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45844 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhGWF02 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 01:26:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DD451FF50
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 06:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627020421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x/pzo71+4MbtNYyTydEh3zkJaVEyLzEOnHXdFfuvZ0U=;
        b=h4DqAfYA8Nq34tzuPTMhEbRnPiM2oJNxJ7PpwXeH09ra6zvIvXKUgsJaa4/f89Y35Bz5iO
        HlOYQRyXfImpyl0pHGBqM3XAVlsi9fKJRs3lqy5pPTK+6H1pf+jHhCHL77d63tE9T0OuXl
        ojrEIsyaEY1FoebY/qQcKDhtprekaqE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 63EC7136DD
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 06:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EWeQCYRc+mBYLgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 06:07:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: unify the error pathes in __extent_writepage() for subpage and regular sectorsize
Date:   Fri, 23 Jul 2021 14:06:57 +0800
Message-Id: <20210723060657.198883-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/160 in a loop for subpage with experimental
compression support, it has a high chance to crash (~20%):

 BTRFS critical (device dm-7): panic in __btrfs_add_ordered_extent:238: inconsistency in ordered tree at offset 0 (errno=-17 Object already exists)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ordered-data.c:238!
 Internal error: Oops - BUG: 0 [#1] SMP
 pc : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
 lr : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
 Call trace:
  __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
  btrfs_add_ordered_extent+0x2c/0x50 [btrfs]
  run_delalloc_nocow+0x81c/0x8fc [btrfs]
  btrfs_run_delalloc_range+0xa4/0x390 [btrfs]
  writepage_delalloc+0xc0/0x1ac [btrfs]
  __extent_writepage+0xf4/0x370 [btrfs]
  extent_write_cache_pages+0x288/0x4f4 [btrfs]
  extent_writepages+0x58/0xe0 [btrfs]
  btrfs_writepages+0x1c/0x30 [btrfs]
  do_writepages+0x60/0x110
  __filemap_fdatawrite_range+0x108/0x170
  filemap_fdatawrite_range+0x20/0x30
  btrfs_fdatawrite_range+0x34/0x4dc [btrfs]
  __btrfs_write_out_cache+0x34c/0x480 [btrfs]
  btrfs_write_out_cache+0x144/0x220 [btrfs]
  btrfs_start_dirty_block_groups+0x3ac/0x6b0 [btrfs]
  btrfs_commit_transaction+0xd0/0xbb4 [btrfs]
  btrfs_sync_fs+0x64/0x1cc [btrfs]
  sync_fs_one_sb+0x3c/0x50
  iterate_supers+0xcc/0x1d4
  ksys_sync+0x6c/0xd0
  __arm64_sys_sync+0x1c/0x30
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0x4c/0xd4
  do_el0_svc+0x30/0x9c
  el0_svc+0x2c/0x54
  el0_sync_handler+0x1a8/0x1b0
  el0_sync+0x198/0x1c0
 ---[ end trace 336f67369ae6e0af ]---

[CAUSE]
For subpage case, we can have multiple sectors inside a page, this makes
it possible for __extent_writepage() to have part of its page submitted
before returning.

In btrfs/160, we are using dm-dust to emulate write error, this means
for certain pages, we could have everything running fine, but at the end
of __extent_writepage(), one of the submitted bios fails due to dm-dust.

Then the page is marked Error, and we change @ret from 0 to -EIO.

This makes the caller extent_write_cache_pages() to error out, without
submitting the remaining pages.

Furthermore, since we're erroring out for free space cache, it doesn't
really care about the error and will update the inode and retry the
writeback.

Then we re-run the delalloc range, and will try to insert the same
delalloc range while previous delalloc range is still hanging there,
triggering the above error.

[FIX]
The proper fix is to make btrfs handle errors from __extent_writepage()
properly, by ending the remaining ordered extent.

But that fix needs the following refactors:

- Know at eaxctly which sector the error happened
  Currently __extent_writepage_io() works for the full page, can't
  return at which sector we hit the error.

- Grab the ordered extent covering the failed sector

As a hotfix for subpage case, here we unify the error pathes in
__extent_writepage().

In fact, the "if (PageError(page))" branch never get executed if @ret is
still 0 for non-subpage cases.

As for non-subpage case, we never submit current page in
__extent_writepage(), but only add current page into bio.
The bio can only get submitted in next page.

Thus we never get PageError() set due to IO failure, thus when we hit
the branch, @ret is never 0.

By simplying removing that @ret assignment, we let subpage case to
ignore the IO failure, thus only error out for fatal errors just like
regular sectorsize.

So that IO error won't be treated as fatal error not trigger the hanging
OE problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
For the proper fix, I pupose to change how we run delalloc range.

Currently we call writepage_delalloc() for every page we're going to
write, but it only really get executed for the first page of a contig
range.

I hope to change the workflow to something more like async cow:
- Run delalloc range
  But keeps all the page still locked

- Submit pages for the delalloc range
  Set each sector writeback and unlock the sector after adding it to
  bio.

So that we can know exactly the delalloc range is, and where the error
happens when submitting bio.

The only down side is btrfs_invalidatepage().
Previously btrfs_invalidatepage() can invalidate a page which is covered
by ordered extent, but not yet being added to a bio.

Now we have to wait for the writeback to finish before doing
invalidating.

Changelog:
v2:
- Make error handling in end_extent_writepage() to be subpage compatible
- Update the commit message and add new comment for why it's safe
  to remove the @ret assignment
---
 fs/btrfs/extent_io.c | 51 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 248f22267665..543f87ea372e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2789,8 +2789,14 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate);
 
 	if (!uptodate) {
-		ClearPageUptodate(page);
-		SetPageError(page);
+		const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+		u32 len;
+
+		ASSERT(end + 1 - start <= U32_MAX);
+		len = end + 1 - start;
+
+		btrfs_page_clear_uptodate(fs_info, page, start, len);
+		btrfs_page_set_error(fs_info, page, start, len);
 		ret = err < 0 ? err : -EIO;
 		mapping_set_error(page->mapping, ret);
 	}
@@ -3795,7 +3801,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
 				delalloc_end, &page_started, nr_written, wbc);
 		if (ret) {
-			SetPageError(page);
+			btrfs_page_set_error(inode->root->fs_info, page,
+					     page_offset(page), PAGE_SIZE);
 			/*
 			 * btrfs_run_delalloc_range should return < 0 for error
 			 * but just in case, we use > 0 here meaning the IO is
@@ -4071,7 +4078,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 
 	WARN_ON(!PageLocked(page));
 
-	ClearPageError(page);
+	btrfs_page_clear_error(btrfs_sb(inode->i_sb), page,
+			       page_offset(page), PAGE_SIZE);
 
 	pg_offset = offset_in_page(i_size);
 	if (page->index > end_index ||
@@ -4112,10 +4120,39 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	if (PageError(page)) {
-		ret = ret < 0 ? ret : -EIO;
+	/*
+	 * Here we used to have a check for PageError() and then set @ret and
+	 * call end_extent_writepage().
+	 *
+	 * But in fact setting @ret here will cause different error paths
+	 * between subpage and regualr sectorsize.
+	 *
+	 * For regular page size, we never submit current page, but only add
+	 * current page to current bio.
+	 * The bio submission can only happen in next page.
+	 * Thus if we hit the PageError() branch, @ret is already set to
+	 * non-zero value and will not get updated for regular sectorsize.
+	 *
+	 * But for subpage case, it's possible we submit part of current page,
+	 * thus can get PageError() set by submitted bio of the same page,
+	 * while our @ret is still 0.
+	 *
+	 * So here we unify the behavior and don't set @ret.
+	 * Error can still be properly passed to higher layer as page will
+	 * be set error, here we just don't handle the IO failure.
+	 *
+	 * NOTE: This is just a hotfix for subpage.
+	 * The root fix will be properly ending ordered extent when we hit
+	 * an error during writeback.
+	 *
+	 * But that needs a much bigger refactor, as we not only need to
+	 * grab the submitted OE, but also needs to know exactly at which
+	 * bytenr we hit an error.
+	 * Currently the full page based __extent_writepage_io() is not
+	 * capable for that.
+	 */
+	if (PageError(page))
 		end_extent_writepage(page, ret, start, page_end);
-	}
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
-- 
2.32.0


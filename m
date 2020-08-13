Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D22433D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 08:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgHMGPi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 02:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgHMGPi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 02:15:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 177A3ACA3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Aug 2020 06:15:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the dead copied check in btrfs_copy_from_user()
Date:   Thu, 13 Aug 2020 14:15:33 +0800
Message-Id: <20200813061533.85671-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is btrfs specific check in btrfs_copy_from_user(), after
iov_iter_copy_from_user_atomic() call, we check if the page is uptodate
and if the copied bytes is smaller than what we expect.

However that check will never be triggered due to the following reasons:
- PageUptodate() check conflicts with current behavior
  Currently we ensure all pages that will go through a partial write
  (some bytes are not covered by the write range) will be forced
  uptodate.

  This is the common behavior to ensure we get the correct content.
  This behavior is always true, no matter if my previous patch "btrfs:
  refactor how we prepare pages for btrfs_buffered_write()" is applied.

- iov_iter_copy_from_user_atomic() only returns 0 or @bytes
  It won't return a short write.

So we're completely fine to remove the (PageUptodate() && copied <
count) check, as we either get copied == 0, and break the loop anyway,
or do a proper copy.

This will revert commit 31339acd07b4 ("Btrfs: deal with short returns from
copy_from_user").

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 705ebe709e8d..2f96f083eb8c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -403,18 +403,6 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 		/* Flush processor's dcache for this page */
 		flush_dcache_page(page);
 
-		/*
-		 * if we get a partial write, we can end up with
-		 * partially up to date pages.  These add
-		 * a lot of complexity, so make sure they don't
-		 * happen by forcing this copy to be retried.
-		 *
-		 * The rest of the btrfs_file_write code will fall
-		 * back to page at a time copies after we return 0.
-		 */
-		if (!PageUptodate(page) && copied < count)
-			copied = 0;
-
 		iov_iter_advance(i, copied);
 		write_bytes -= copied;
 		total_copied += copied;
-- 
2.28.0


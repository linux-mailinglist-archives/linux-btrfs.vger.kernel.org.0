Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E187360167
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhDOFGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhDOFGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bIilx/4AABtsNJuG8ixKNCu8W0p68i8H9GAR5B42wU=;
        b=Onny42ifBcSDYGKzm4G++JoJKrCzCrTMo4BQwc/j7BVuAahRtRHlA7rA2TjQccd756SDv3
        IdddLTpupK8MDwfaExJhAswSCu6GAMthLD6TdKvfvejecIz0uA0Ba9UKDik7iKZtohGn5d
        NMgMAENCi7LKl+Fwc+SdQfB7+eiahOQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 660CDAF03;
        Thu, 15 Apr 2021 05:05:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 24/42] btrfs: update locked page dirty/writeback/error bits in __process_pages_contig
Date:   Thu, 15 Apr 2021 13:04:30 +0800
Message-Id: <20210415050448.267306-25-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When __process_pages_contig() gets called for
extent_clear_unlock_delalloc(), if we hit the locked page, only Private2
bit is updated, but dirty/writeback/error bits are all skipped.

There are several call sites that call extent_clear_unlock_delalloc()
with locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBACK

- cow_file_range()
- run_delalloc_nocow()
- cow_file_range_async()
  All for their error handling branches.

For those call sites, since we skip the locked page for
dirty/error/writeback bit update, the locked page will still have its
subpage dirty bit remaining.

Normally it's the call sites which locked the page to handle the locked
page, but it won't hurt if we also do the update.

Especially there are already other call sites doing the same thing by
manually passing NULL as locked_page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cc73fd3c840c..7dc1b367bf35 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1825,10 +1825,6 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 
 	if (page_ops & PAGE_SET_ORDERED)
 		btrfs_page_clamp_set_ordered(fs_info, page, start, len);
-
-	if (page == locked_page)
-		return 1;
-
 	if (page_ops & PAGE_SET_ERROR)
 		btrfs_page_clamp_set_error(fs_info, page, start, len);
 	if (page_ops & PAGE_START_WRITEBACK) {
@@ -1837,6 +1833,10 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 	}
 	if (page_ops & PAGE_END_WRITEBACK)
 		btrfs_page_clamp_clear_writeback(fs_info, page, start, len);
+
+	if (page == locked_page)
+		return 1;
+
 	if (page_ops & PAGE_LOCK) {
 		int ret;
 
-- 
2.31.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2C38BFC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhEUGoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234753AbhEUGny (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDhnZcsLM789/+Fxsdm7GdBOGyq33jlWaivp6KyBbm8=;
        b=HVMxU7f0wsuVZkJ8SSIdTmtFL/xwpuSED7GCB39r3FkazupPzrmLzVSU7OmMYGYi1C3xUt
        +/vK04uIg7O5+I8fIvPXmgDYeV5zajcswxHnNgC9c1n9+b8EwgbjatM8KOF2w4sLicmDrP
        B+yc3XJaXEMwQL97JHRs7qJmXT5PrZk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02FD4AD12;
        Fri, 21 May 2021 06:41:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v3 11/31] btrfs: update locked page dirty/writeback/error bits in __process_pages_contig
Date:   Fri, 21 May 2021 14:40:30 +0800
Message-Id: <20210521064050.191164-12-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
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
index 4ee0bd03c0d1..8c1f66a9a2c4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1828,10 +1828,6 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 
 	if (page_ops & PAGE_SET_ORDERED)
 		btrfs_page_clamp_set_ordered(fs_info, page, start, len);
-
-	if (page == locked_page)
-		return 1;
-
 	if (page_ops & PAGE_SET_ERROR)
 		btrfs_page_clamp_set_error(fs_info, page, start, len);
 	if (page_ops & PAGE_START_WRITEBACK) {
@@ -1840,6 +1836,10 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
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


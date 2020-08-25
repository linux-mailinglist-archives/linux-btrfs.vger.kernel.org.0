Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F02511B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 07:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHYFs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 01:48:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgHYFs0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 01:48:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B42BFACCF
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 05:48:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/4] btrfs: refactor @nrptrs calculation of btrfs_buffered_write()
Date:   Tue, 25 Aug 2020 13:48:05 +0800
Message-Id: <20200825054808.16241-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825054808.16241-1-wqu@suse.com>
References: <20200825054808.16241-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

@nrptrs of btrfs_bufferd_write() determines the up limit of pages we can
process in one batch.

Refactor that calculation into its own function, and fix a small page
alignment bug where the result can be one page less than ideal.

Despite that, no functionality change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5a818ebcb01f..64f744989697 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1620,6 +1620,25 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
+/* Helper to get how many pages we should alloc for the batch */
+static int calc_nr_pages(loff_t pos, struct iov_iter *iov)
+{
+	int nr_pages;
+
+	/*
+	 * Try to cover the full iov range, as btrfs metadata/data reserve
+	 * and release can be pretty slow, thus the more pages we process in
+	 * one batch the better.
+	 */
+	nr_pages = (round_up(pos + iov_iter_count(iov), PAGE_SIZE) -
+		    round_down(pos, PAGE_SIZE)) / PAGE_SIZE;
+
+	nr_pages = min(nr_pages, current->nr_dirtied_pause -
+				 current->nr_dirtied);
+	nr_pages = max(nr_pages, 8);
+	return nr_pages;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1638,10 +1657,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 
-	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
-			PAGE_SIZE / (sizeof(struct page *)));
-	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
-	nrptrs = max(nrptrs, 8);
+	nrptrs = calc_nr_pages(pos, i);
 	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
-- 
2.28.0


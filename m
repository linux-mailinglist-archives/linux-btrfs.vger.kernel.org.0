Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95232511B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHYFsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 01:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgHYFsf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 01:48:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C5C9ACCF
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 05:49:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/4] btrfs: avoid allocating unnecessary page pointers
Date:   Tue, 25 Aug 2020 13:48:08 +0800
Message-Id: <20200825054808.16241-5-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825054808.16241-1-wqu@suse.com>
References: <20200825054808.16241-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 142349f541d0 ("btrfs: lower the dirty balance poll interval")
introduced one limit which is definitely suspicious:

- ensure we always have 8 pages allocated
  The 8 lower limit looks pretty strange, this means even we're just
  writing 4K, we will allocate page pointers for 8 pages no matter what.
  To me, this 8 pages look more like a upper limit.

This 8 pages upper limit looks so incorrect that my eyes alawys correct
it into "min(, 8)" other than "max(, 8)".

This patch will use a fixed size (SZ_64K) other than page numbers to
setup the upper limit.
Also, with comment added to show why we need a upper limit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 67d2368a8fa6..de6d1c313042 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1561,7 +1561,14 @@ static int calc_nr_pages(loff_t pos, struct iov_iter *iov)
 
 	nr_pages = min(nr_pages, current->nr_dirtied_pause -
 				 current->nr_dirtied);
-	nr_pages = max(nr_pages, 8);
+
+	/*
+	 * Limit the batch to 64K, too large batch may lead to higher memory
+	 * pressure and increase the possibility of short-copy.
+	 * With more and more short-copy, the benefit of batch copy would be
+	 * hugely reduced, as we will fall back to page-by-page copy.
+	 */
+	nr_pages = min(nr_pages, SZ_64K / PAGE_SIZE);
 	return nr_pages;
 }
 
-- 
2.28.0


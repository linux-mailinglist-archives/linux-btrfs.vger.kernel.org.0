Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B32D53F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbgLJGkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbgLJGkA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddZsXFITmL0WGJwxBiWhU61AVm8mYTAI4G7SE3nb+7U=;
        b=gjke2TdAhxPAFQ6tl+Bb1s2J5r1KjBfrhMbZbO51ViQ8OK+6kh6Lpfs3uqEnLRtl+GEj1X
        1nBjQoYLvVUOEk1L+a0q2T89uFzAVWhTwi4vmm2Oit+E7BddtKujmBnd1NNfrTTqKbmW4L
        mnPcnNuWKf1t5qn+TNtgRn15mdLnU6k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 264B9AD6D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/18] btrfs: file: update comment for btrfs_dirty_pages()
Date:   Thu, 10 Dec 2020 14:38:50 +0800
Message-Id: <20201210063905.75727-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The original comment is from the initial merge, which has several
problems:
- No holes check any more
- No inline decision is made

Update the out-of-date comment with more correct one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..a29b50208eee 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -453,12 +453,15 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 }
 
 /*
- * after copy_from_user, pages need to be dirtied and we need to make
- * sure holes are created between the current EOF and the start of
- * any next extents (if required).
- *
- * this also makes the decision about creating an inline extent vs
- * doing real data extents, marking pages dirty and delalloc as required.
+ * After btrfs_copy_from_user(), update the following things for delalloc:
+ * - DELALLOC extent io tree bits
+ *   Later btrfs_run_delalloc_range() relies on this bit to determine the
+ *   writeback range.
+ * - Page status
+ *   Including basic status like Dirty and Uptodate, and btrfs specific bit
+ *   like Checked (for cow fixup)
+ * - Inode size update
+ *   If needed
  */
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
-- 
2.29.2


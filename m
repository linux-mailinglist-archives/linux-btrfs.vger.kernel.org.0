Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B72EB753
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAFBC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:02:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:45500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbhAFBC5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1G/Vpz8nDxbTlFu73xw3UyUN6rUsg/0Wzsb9hl5bB4=;
        b=QRbQenLq3bu4fHTvaR+paxvbwr98wv4vN1+WUBSofqinshkSWrdLqJtTzf9TSa2ErIWLmK
        mdaeupGNEaMBaGds6qnS4DZKwKA+hSvbNM0PO7wXJycbx4619uJrBiC6iCTnNNiEMk/1bo
        79CA4jMBj0LMYsMFQg7adN6KQku8ycM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B744DAF2C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 03/22] btrfs: file: update comment for btrfs_dirty_pages()
Date:   Wed,  6 Jan 2021 09:01:42 +0800
Message-Id: <20210106010201.37864-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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
 fs/btrfs/file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e65223e3510d..1602975ddb88 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -453,12 +453,11 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 }
 
 /*
- * after copy_from_user, pages need to be dirtied and we need to make
- * sure holes are created between the current EOF and the start of
- * any next extents (if required).
- *
- * this also makes the decision about creating an inline extent vs
- * doing real data extents, marking pages dirty and delalloc as required.
+ * After btrfs_copy_from_user(), update the following things for delalloc:
+ * - Mark newly dirtied pages as DELALLOC in the io tree.
+ *   Used to advise which range is to be written back.
+ * - Marks modified pages as Uptodate/Dirty and not needing cowfixup
+ * - Update inode size for past EOF write.
  */
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
-- 
2.29.2


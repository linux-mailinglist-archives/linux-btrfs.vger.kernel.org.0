Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8836D27DE02
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgI3B4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3B4H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1lefI4FzGWvrTB6CT1o1gko9ovuGLF7cpjECplRzkw=;
        b=H32ltjCsGuRpmrlOJvjDfyRps+XDxogPHFw7fQCKl8vpx7w8B2fYpYCoXcio5oLjcZJZMI
        rJCDwQEXSeUrsqqjVGR/DsnHX2b3Aj3vpZzQWXUHUv3hly3sie4BYjqmDDzUhPtek7DRCq
        khrrEbLwbzbNMzdrKIfagcJAhi6eFmo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F795AF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/49] btrfs: extent_io: rename pages_locked in process_pages_contig()
Date:   Wed, 30 Sep 2020 09:55:00 +0800
Message-Id: <20200930015539.48867-11-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function process_pages_contig() does not only handle page locking but
also other operations.

So rename the local variable pages_locked to pages_processed to reduce
confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9f46d7f17a9c..07f8117ddbb4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1830,7 +1830,7 @@ static int process_pages_contig(struct address_space *mapping,
 				unsigned long page_ops, pgoff_t *index_ret)
 {
 	unsigned long nr_pages = end_index - start_index + 1;
-	unsigned long pages_locked = 0;
+	unsigned long pages_processed = 0;
 	pgoff_t index = start_index;
 	struct page *pages[16];
 	unsigned ret;
@@ -1865,7 +1865,7 @@ static int process_pages_contig(struct address_space *mapping,
 
 			if (locked_page && pages[i] == locked_page) {
 				put_page(pages[i]);
-				pages_locked++;
+				pages_processed++;
 				continue;
 			}
 			if (page_ops & PAGE_CLEAR_DIRTY)
@@ -1890,7 +1890,7 @@ static int process_pages_contig(struct address_space *mapping,
 				}
 			}
 			put_page(pages[i]);
-			pages_locked++;
+			pages_processed++;
 		}
 		nr_pages -= ret;
 		index += ret;
@@ -1898,7 +1898,7 @@ static int process_pages_contig(struct address_space *mapping,
 	}
 out:
 	if (err && index_ret)
-		*index_ret = start_index + pages_locked - 1;
+		*index_ret = start_index + pages_processed - 1;
 	return err;
 }
 
-- 
2.28.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB031294827
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440731AbgJUG0Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440725AbgJUG0Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfoeGy0ClMq40LYE9sYe+LOw8Am2amNkICcMqUWZmlc=;
        b=DzQ/MA81u50p5msaboFhNKyrTArRizl4irI3PmnVKXnEhM4zs5JcC+ZKErISpmkSZw3e2+
        xN6PhZY44QDIVuMLJ2lUrvREjRMhyyZ46yzODl7HS5Yretd456vTarxxogy6N5JWdJGi9i
        mFpCDjuou3eAups7oQYRaHT8buUx9yE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 545CDAC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 11/68] btrfs: extent_io: rename pages_locked in process_pages_contig()
Date:   Wed, 21 Oct 2020 14:24:57 +0800
Message-Id: <20201021062554.68132-12-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index d5e03977c9c8..f20b8e886724 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1834,7 +1834,7 @@ static int process_pages_contig(struct address_space *mapping,
 				unsigned long page_ops, pgoff_t *index_ret)
 {
 	unsigned long nr_pages = end_index - start_index + 1;
-	unsigned long pages_locked = 0;
+	unsigned long pages_processed = 0;
 	pgoff_t index = start_index;
 	struct page *pages[16];
 	unsigned ret;
@@ -1869,7 +1869,7 @@ static int process_pages_contig(struct address_space *mapping,
 
 			if (locked_page && pages[i] == locked_page) {
 				put_page(pages[i]);
-				pages_locked++;
+				pages_processed++;
 				continue;
 			}
 			if (page_ops & PAGE_CLEAR_DIRTY)
@@ -1894,7 +1894,7 @@ static int process_pages_contig(struct address_space *mapping,
 				}
 			}
 			put_page(pages[i]);
-			pages_locked++;
+			pages_processed++;
 		}
 		nr_pages -= ret;
 		index += ret;
@@ -1902,7 +1902,7 @@ static int process_pages_contig(struct address_space *mapping,
 	}
 out:
 	if (err && index_ret)
-		*index_ret = start_index + pages_locked - 1;
+		*index_ret = start_index + pages_processed - 1;
 	return err;
 }
 
-- 
2.28.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7696B3B138C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWF6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:58:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWF6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:58:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C9A8D1FD36
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2P6vcTzUOxbY8iyNDkkGrMfmcSshRsbM5EjnB8df06o=;
        b=nspkN3JvYwgHZhvT3S2JUJTgAaIrwR8bvaTV1V6FXxf8XA/MbgLzrTEHtbtcAc5lZsRLud
        lR0zpn8Nn7ntk9qHvXlRPew5UWLkIzo0Zq+PwN+Cz+CVJ85Gq2pbULPZTnawgAmBRRLQRA
        eIHE/VGVOHHzUxsaQQsEta7zRXwWICs=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id CC58CA3B8A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 6/8] btrfs: make end_compressed_bio_writeback() to be subpage compatble
Date:   Wed, 23 Jun 2021 13:55:27 +0800
Message-Id: <20210623055529.166678-7-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In end_compressed_writeback() we just clear the full page writeback.
For subpage case, if there are two delalloc range in the same page, the
2nd range will trigger a BUG_ON() as the page writeback is already
cleared by previous range.

Fix it by using btrfs_page_clamp_clear_writeback() helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a49dbf166b15..2eec9850996e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -29,6 +29,7 @@
 #include "extent_io.h"
 #include "extent_map.h"
 #include "zoned.h"
+#include "subpage.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
@@ -330,6 +331,7 @@ static void end_compressed_bio_read(struct bio *bio)
 static noinline void end_compressed_writeback(struct inode *inode,
 					      const struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct page *pages[16];
@@ -352,7 +354,8 @@ static noinline void end_compressed_writeback(struct inode *inode,
 		for (i = 0; i < ret; i++) {
 			if (cb->errors)
 				SetPageError(pages[i]);
-			end_page_writeback(pages[i]);
+			btrfs_page_clamp_clear_writeback(fs_info, pages[i],
+							 cb->start, cb->len);
 			put_page(pages[i]);
 		}
 		nr_pages -= ret;
-- 
2.32.0


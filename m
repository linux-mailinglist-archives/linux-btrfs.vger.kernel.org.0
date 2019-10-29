Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A73E8E15
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfJ2R2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 13:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfJ2R2q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 13:28:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54AD7B247;
        Tue, 29 Oct 2019 17:28:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47867DA734; Tue, 29 Oct 2019 18:28:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: sink write_flags to __extent_writepage_io
Date:   Tue, 29 Oct 2019 18:28:55 +0100
Message-Id: <51963044924d80a39e183a726dfcf67ca7896576.1572369984.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572369984.git.dsterba@suse.com>
References: <cover.1572369984.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__extent_writepage reads write flags from wbc and passes both to
__extent_writepage_io. This makes write_flags redundant and we can
remove it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ed8ad14338de..ba1ddb2a5520 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3413,7 +3413,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 				 struct extent_page_data *epd,
 				 loff_t i_size,
 				 unsigned long nr_written,
-				 unsigned int write_flags, int *nr_ret)
+				 int *nr_ret)
 {
 	struct extent_io_tree *tree = epd->tree;
 	u64 start = page_offset(page);
@@ -3428,6 +3428,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
+	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
 	ret = btrfs_writepage_cow_fixup(page, start, page_end);
@@ -3560,11 +3561,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	size_t pg_offset = 0;
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
-	unsigned int write_flags = 0;
 	unsigned long nr_written = 0;
 
-	write_flags = wbc_to_write_flags(wbc);
-
 	trace___extent_writepage(page, inode, wbc);
 
 	WARN_ON(!PageLocked(page));
@@ -3602,7 +3600,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	ret = __extent_writepage_io(inode, page, wbc, epd,
-				    i_size, nr_written, write_flags, &nr);
+				    i_size, nr_written, &nr);
 	if (ret == 1)
 		goto done_unlocked;
 
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC342F8C06
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbhAPHRe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:56144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbhAPHRe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vs/i6yNyAbx7v+kPD+/+rY6/TnnwFabTg4YyoXv5RU=;
        b=tvtCKtYitoT/ijn1OAA3cXf6cPZhWKhT/gMwHYwrMo5iOx8GPe4FEcoWjgfqaxdHyUrnVC
        o+U3+Lyi6owLVVCtRLRdHSPQNabYIG7J/SsrBDNAU3J7giTK6PZnQ9QAaikJKTw36t/NeG
        O9PywXEFl2DhgvcMFSaS+vp0Tvg7nbE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED5EEB907
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:16:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 15/18] btrfs: disk-io: introduce subpage metadata validation check
Date:   Sat, 16 Jan 2021 15:15:30 +0800
Message-Id: <20210116071533.105780-16-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage metadata validation check, there are some difference:

- Read must finish in one bvec
  Since we're just reading one subpage range in one page, it should
  never be split into two bios nor two bvecs.

- How to grab the existing eb
  Instead of grabbing eb using page->private, we have to go search radix
  tree as we don't have any direct pointer at hand.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5473bed6a7e8..7d2875c18958 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -591,6 +591,59 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 	return ret;
 }
 
+static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
+				   int mirror)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct extent_buffer *eb;
+	int reads_done;
+	int ret = 0;
+
+	/*
+	 * We don't allow bio merge for subpage metadata read, so we should
+	 * only get one eb for each endio hook.
+	 */
+	ASSERT(end == start + fs_info->nodesize - 1);
+	ASSERT(PagePrivate(page));
+
+	eb = find_extent_buffer(fs_info, start);
+	/*
+	 * When we are reading one tree block, eb must have been
+	 * inserted into the radix tree. If not something is wrong.
+	 */
+	ASSERT(eb);
+
+	reads_done = atomic_dec_and_test(&eb->io_pages);
+	/* Subpage read must finish in page read */
+	ASSERT(reads_done);
+
+	eb->read_mirror = mirror;
+	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
+		ret = -EIO;
+		goto err;
+	}
+	ret = validate_extent_buffer(eb);
+	if (ret < 0)
+		goto err;
+
+	if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
+		btree_readahead_hook(eb, ret);
+
+	set_extent_buffer_uptodate(eb);
+
+	free_extent_buffer(eb);
+	return ret;
+err:
+	/*
+	 * end_bio_extent_readpage decrements io_pages in case of error,
+	 * make sure it has something to decrement.
+	 */
+	atomic_inc(&eb->io_pages);
+	clear_extent_buffer_uptodate(eb);
+	free_extent_buffer(eb);
+	return ret;
+}
+
 int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror)
@@ -600,6 +653,10 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 	int reads_done;
 
 	ASSERT(page->private);
+
+	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+		return validate_subpage_buffer(page, start, end, mirror);
+
 	eb = (struct extent_buffer *)page->private;
 
 	/*
-- 
2.30.0


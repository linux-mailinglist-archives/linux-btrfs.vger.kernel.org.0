Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE82B799A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKRIxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:47878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRIxu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maDN01w4egfhxhZj5odDhJWzJ6lGmlXG3Fhyckd9i5A=;
        b=gnWoQwIxlA9a2XGuoMXAt+MSkXLK044if3CzOijLMOjSyRRD2YVPLwGYE75rn9ZCmKHR8c
        pfEVxH4g4vw/zinueIbImmceV4cBbHBJwIRhBOtalTGUeylhQiA3QUOTXCHV3gF4S4xTb4
        w7aC9vW5kDfAZFyxpMmFGzHaqoYx3l4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8C30ABF4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/14] btrfs: disk-io: introduce subpage metadata validation check
Date:   Wed, 18 Nov 2020 16:53:16 +0800
Message-Id: <20201118085319.56668-12-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
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
 fs/btrfs/disk-io.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b395daf62086..699b999c8ba3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -593,6 +593,84 @@ static int validate_extent_buffer(struct extent_buffer *eb)
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
+	if (!IS_ALIGNED(start, fs_info->sectorsize) ||
+	    !IS_ALIGNED(end - start + 1, fs_info->sectorsize) ||
+	    !IS_ALIGNED(end - start + 1, fs_info->nodesize)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info, "invalid tree read bytenr");
+		return -EUCLEAN;
+	}
+
+	/*
+	 * We don't allow bio merge for subpage metadata read, so we should
+	 * only get one eb for each endio hook.
+	 */
+	ASSERT(end == start + fs_info->nodesize - 1);
+	ASSERT(PagePrivate(page));
+
+	rcu_read_lock();
+	eb = radix_tree_lookup(&fs_info->buffer_radix,
+			       start / fs_info->sectorsize);
+	rcu_read_unlock();
+
+	/*
+	 * When we are reading one tree block, eb must have been
+	 * inserted into the radix tree. If not something is wrong.
+	 */
+	if (!eb) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+			"can't find extent buffer for bytenr %llu",
+			start);
+		return -EUCLEAN;
+	}
+	/*
+	 * The pending IO might have been the only thing that kept
+	 * this buffer in memory.  Make sure we have a ref for all
+	 * this other checks
+	 */
+	atomic_inc(&eb->refs);
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
+	 * our io error hook is going to dec the io pages
+	 * again, we have to make sure it has something to
+	 * decrement
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
@@ -602,6 +680,10 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 	int reads_done;
 
 	ASSERT(page->private);
+
+	if (btrfs_is_subpage(btrfs_sb(page->mapping->host->i_sb)))
+		return validate_subpage_buffer(page, start, end, mirror);
+
 	eb = (struct extent_buffer *)page->private;
 
 
-- 
2.29.2


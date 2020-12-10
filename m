Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33C72D5413
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgLJGlE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:41:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387523AbgLJGlD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:41:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJGTzVPLfPoMAxVRuz+nVyvcG/38/B+4XaBbLMHGhKg=;
        b=MJeSzMGUelNqPIFx6HTeAxPxF+1IXNmPnoz4kFOmn2PHHkLDTZyRjud8QktWwtemUj47Lr
        kf65Mfc2jg62dko16X41/TPI2hKEHpNIUyLX/pH1WrtWcj+ZsfnFC+R0dC//DGb9+ebOWi
        nXS7y58n2oxXsFvWtUoeyjbHZgclJ+s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AB8EAD79
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/18] btrfs: disk-io: introduce subpage metadata validation check
Date:   Thu, 10 Dec 2020 14:39:02 +0800
Message-Id: <20201210063905.75727-16-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
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
index b6c03a8b0c72..adda76895058 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -591,6 +591,84 @@ static int validate_extent_buffer(struct extent_buffer *eb)
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
@@ -600,6 +678,10 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
 	int reads_done;
 
 	ASSERT(page->private);
+
+	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+		return validate_subpage_buffer(page, start, end, mirror);
+
 	eb = (struct extent_buffer *)page->private;
 
 
-- 
2.29.2


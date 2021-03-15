Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF933AB2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 06:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCOFjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 01:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:42542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhCOFjX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 01:39:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615786762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ujy+78ijjCSl5DpABhz4ECGFiIk+SEVKo2p78Isn8o=;
        b=sM44jxUE8grNFwUQHDx+dn0jNA2gR1ELeYEPefskCN7Iu0OQbc/vpRRM8qgKb7OmZeNWsz
        yjqBNREmjUIVoMDBKHtRdo2ToeApKAmhOTZyPBBce6oR9O/L08lRYh9FcDKtmSFr98OZwe
        /VVRzq2MaY8ZM8WKDNipIbynycabsGI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9868CAD73
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 05:39:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix wild pointer access during metadata read failure for subpage
Date:   Mon, 15 Mar 2021 13:39:14 +0800
Message-Id: <20210315053915.62420-2-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315053915.62420-1-wqu@suse.com>
References: <20210315053915.62420-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running fstests for btrfs subpage read-write test, it has a very
high chance to crash at generic/475 with the following crash:

 BTRFS warning (device dm-8): direct IO failed ino 510 rw 1,34817 sector 0xcdf0 len 94208 err no 10
 Unable to handle kernel paging request at virtual address ffff80001157e7c0
 CPU: 2 PID: 687125 Comm: kworker/u12:4 Tainted: G        WC        5.12.0-rc2-custom+ #5
 Hardware name: Khadas VIM3 (DT)
 Workqueue: btrfs-endio-meta btrfs_work_helper [btrfs]
 pc : queued_spin_lock_slowpath+0x1a0/0x390
 lr : do_raw_spin_lock+0xc4/0x11c
 Call trace:
  queued_spin_lock_slowpath+0x1a0/0x390
  _raw_spin_lock+0x68/0x84
  btree_readahead_hook+0x38/0xc0 [btrfs]
  end_bio_extent_readpage+0x504/0x5f4 [btrfs]
  bio_endio+0x170/0x1a4
  end_workqueue_fn+0x3c/0x60 [btrfs]
  btrfs_work_helper+0x1b0/0x1b4 [btrfs]
  process_one_work+0x22c/0x430
  worker_thread+0x70/0x3a0
  kthread+0x13c/0x140
  ret_from_fork+0x10/0x30
 Code: 910020e0 8b0200c2 f861d884 aa0203e1 (f8246827)

[CAUSE]
In end_bio_extent_readpage(), if we hit an error during read, we will
handle the error differently for data and metadata.
For data we queue a repair, while for metadata, we record the error and
let the caller to choose what to do.

But the code is still using page->private to grab extent buffer, which
no longer points to extent buffer for subpage metadata pages.

Thus this wild pointer access leads to above crash.

[FIX]
Introduce a helper, find_extent_buffer_readpage(), to grab extent
buffer.

The difference against find_extent_buffer_nospinlock() is:
- Also handles regular sectorsize == PAGE_SIZE case
- No extent buffer refs increase/decrease
  As extent buffer under IO must has non-zero refs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e38041ba9011..a008dc6d0216 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2918,6 +2918,35 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
+/*
+ * Helper to find the extent buffer.
+ *
+ * This helper is for end_bio_extent_readpage(), thus we can't do any
+ * unsafe spinlock in endio context.
+ */
+static struct extent_buffer *find_extent_buffer_readpage(
+		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
+{
+	struct extent_buffer *ret;
+
+	/*
+	 * For regular sectorsize, we can use page->private to grab extent
+	 * buffer.
+	 */
+	if (fs_info->sectorsize == PAGE_SIZE) {
+		ASSERT(PagePrivate(page) && page->private);
+		return (struct extent_buffer *)page->private;
+	}
+
+	/* For subpage case, we need to lookup buffer radix tree. */
+	rcu_read_lock();
+	ret = radix_tree_lookup(&fs_info->buffer_radix,
+			       bytenr >> fs_info->sectorsize_bits);
+	rcu_read_unlock();
+	ASSERT(ret);
+	return ret;
+}
+
 /*
  * after a readpage IO is done, we need to:
  * clear the uptodate bits on error
@@ -3028,7 +3057,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		} else {
 			struct extent_buffer *eb;
 
-			eb = (struct extent_buffer *)page->private;
+			eb = find_extent_buffer_readpage(fs_info, page, start);
 			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 			eb->read_mirror = mirror;
 			atomic_dec(&eb->io_pages);
-- 
2.30.1


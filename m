Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504AC3EEA0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhHQJjg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 05:39:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50250 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhHQJjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 05:39:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA5EF2000E
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629193139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3X1tHkrqhQ+mVTqZNF913GezKE3Lk/m30W2vIOGQWg=;
        b=eetoYGoULBQZ1X52+DeHVv2iH7apMxDAkFYHQwbIELjXREGUOWYqPsBxDB/zTB+o66WSHW
        fPxi5oAi8beqzAULrZhoOdcAhzbbzkbhA5MN8UwAiwCCspiW0i8CIK+OgOxYvcZv2204cA
        DfC8+aiyyNPw3osTy4JeiAyR+EApjGM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 06F64132AB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gG/JLbKDG2FcCwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:38:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: introduce btrfs_subpage_bitmap_info
Date:   Tue, 17 Aug 2021 17:38:51 +0800
Message-Id: <20210817093852.48126-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817093852.48126-1-wqu@suse.com>
References: <20210817093852.48126-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we use fixed size u16 bitmap for subpage bitmap.
This is fine for 4K sectorsize with 64K page size.

But for 4K sectorsize and larger page size, the bitmap is too small,
while for smaller page size like 16K, u16 bitmaps waste too much space.

Here we introduce a new helper structure, btrfs_subpage_bitmap_info, to
record the proper bitmap size, and where each bitmap should start at.

By this, we can later compact all subpage bitmaps into one u32 bitmap.

This patch is the first step towards such compact bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c | 12 +++++++++---
 fs/btrfs/subpage.c | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f07c82fafa04..a5297748d719 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -899,6 +899,7 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *scrub_workers;
 	struct btrfs_workqueue *scrub_wr_completion_workers;
 	struct btrfs_workqueue *scrub_parity_workers;
+	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2f9515dccce0..3355708919d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1644,6 +1644,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
+	kfree(fs_info->subpage_info);
 	kvfree(fs_info);
 }
 
@@ -3392,12 +3393,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	if (sectorsize != PAGE_SIZE) {
+	if (sectorsize < PAGE_SIZE) {
+		struct btrfs_subpage_info *subpage_info;
+
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
 			   sectorsize, PAGE_SIZE);
-	}
-	if (sectorsize != PAGE_SIZE) {
 		if (btrfs_super_incompat_flags(fs_info->super_copy) &
 			BTRFS_FEATURE_INCOMPAT_RAID56) {
 			btrfs_err(fs_info,
@@ -3406,6 +3407,11 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			err = -EINVAL;
 			goto fail_alloc;
 		}
+		subpage_info = kzalloc(sizeof(*subpage_info), GFP_NOFS);
+		if (!subpage_info)
+			goto fail_alloc;
+		btrfs_init_subpage_info(subpage_info, sectorsize);
+		fs_info->subpage_info = subpage_info;
 	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ae6c68370a95..c4fb2ce52207 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -63,6 +63,41 @@
  *   This means a slightly higher tree locking latency.
  */
 
+void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
+			     u32 sectorsize)
+{
+	unsigned int cur = 0;
+	unsigned int nr_bits;
+
+	/*
+	 * Just in case we have super large PAGE_SIZE that unsigned int is not
+	 * enough to contain the number of sectors for the minimal sectorsize.
+	 */
+	BUILD_BUG_ON(UINT_MAX * SZ_4K < PAGE_SIZE);
+
+	ASSERT(IS_ALIGNED(PAGE_SIZE, sectorsize));
+
+	nr_bits = PAGE_SIZE / sectorsize;
+	subpage_info->bitmap_nr_bits = nr_bits;
+
+	subpage_info->uptodate_offset = cur;
+	cur += nr_bits;
+
+	subpage_info->error_offset = cur;
+	cur += nr_bits;
+
+	subpage_info->dirty_offset = cur;
+	cur += nr_bits;
+
+	subpage_info->writeback_offset = cur;
+	cur += nr_bits;
+
+	subpage_info->ordered_offset = cur;
+	cur += nr_bits;
+
+	subpage_info->total_nr_bits = cur;
+}
+
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct page *page, enum btrfs_subpage_type type)
 {
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index fdcadc5193c1..e4e9cc21a712 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -11,6 +11,40 @@
  */
 #define BTRFS_SUBPAGE_BITMAP_SIZE	16
 
+/*
+ * Extra info for subpapge bitmap.
+ *
+ * For subpage we pack all uptodate/error/dirty/writeback/ordered
+ * bitmaps into one larger bitmap.
+ *
+ * This structure records how they are organized in such bitmap:
+ *
+ * /- uptodate_offset	/- error_offset	/- dirty_offset
+ * |			|		|
+ * v			v		v
+ * |u|u|u|u|........|u|u|e|e|.......|e|e| ...	|o|o|
+ * |<- bitmap_nr_bits ->|
+ * |<--------------- total_nr_bits ---------------->|
+ */
+struct btrfs_subpage_info {
+	/* Number of bits for each bitmap*/
+	unsigned int bitmap_nr_bits;
+
+	/* Total number of bits for the whole bitmap */
+	unsigned int total_nr_bits;
+
+	/*
+	 * *_start indicates where the bitmap starts, the length
+	 * is always @bitmap_size, which is calculated from
+	 * PAGE_SIZE / sectorsize.
+	 */
+	unsigned int uptodate_offset;
+	unsigned int error_offset;
+	unsigned int dirty_offset;
+	unsigned int writeback_offset;
+	unsigned int ordered_offset;
+};
+
 /*
  * Structure to trace status of each sector inside a page, attached to
  * page::private for both data and metadata inodes.
@@ -53,6 +87,8 @@ enum btrfs_subpage_type {
 	BTRFS_SUBPAGE_DATA,
 };
 
+void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
+			     u32 sectorsize);
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct page *page, enum btrfs_subpage_type type);
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
-- 
2.32.0


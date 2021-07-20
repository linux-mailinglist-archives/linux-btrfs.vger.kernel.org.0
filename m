Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BB3CF4E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbhGTGQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 02:16:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58120 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242139AbhGTGQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 02:16:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B82A1FDCF
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 06:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626764209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HypKL8KwMobI7wyC4uT8OpWXXwx2pMBwDH6+7qeomPA=;
        b=VS21GBImCNsTJXlZ3v+2CQIUyfwOGGZymN8ianul3CYCCGJ6IkQ9XiBbySThbISiQohhsf
        f5tIVurUm5daSoCv77UT+FE0fubLN/Nl+j95zbeVzc+//sQqHhoPqMVFQ/Y0SpClGOTgsX
        Q1JekdSS1ZgO5giis/mOOzxt/B0R/Jo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4BE651388B
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 06:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qaPYArBz9mCUawAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 06:56:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: handle the added ordered extent when bio submission fails
Date:   Tue, 20 Jul 2021 14:56:45 +0800
Message-Id: <20210720065645.197453-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a strange bug that when running "-o compress" mount option for
subpage case, btrfs/160 has a random chance (~20%) to crash the system:

 BTRFS critical (device dm-7): panic in __btrfs_add_ordered_extent:238: inconsistency in ordered tree at offset 0 (errno=-17 Object already exists)
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ordered-data.c:238!
 Internal error: Oops - BUG: 0 [#1] SMP
 pc : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
 lr : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
 Call trace:
  __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
  btrfs_add_ordered_extent+0x2c/0x50 [btrfs]
  run_delalloc_nocow+0x81c/0x8fc [btrfs]
  btrfs_run_delalloc_range+0xa4/0x390 [btrfs]
  writepage_delalloc+0xc0/0x1ac [btrfs]
  __extent_writepage+0xf4/0x370 [btrfs]
  extent_write_cache_pages+0x288/0x4f4 [btrfs]
  extent_writepages+0x58/0xe0 [btrfs]
  btrfs_writepages+0x1c/0x30 [btrfs]
  do_writepages+0x60/0x110
  __filemap_fdatawrite_range+0x108/0x170
  filemap_fdatawrite_range+0x20/0x30
  btrfs_fdatawrite_range+0x34/0x4dc [btrfs]
  __btrfs_write_out_cache+0x34c/0x480 [btrfs]
  btrfs_write_out_cache+0x144/0x220 [btrfs]
  btrfs_start_dirty_block_groups+0x3ac/0x6b0 [btrfs]
  btrfs_commit_transaction+0xd0/0xbb4 [btrfs]
  btrfs_sync_fs+0x64/0x1cc [btrfs]
  sync_fs_one_sb+0x3c/0x50
  iterate_supers+0xcc/0x1d4
  ksys_sync+0x6c/0xd0
  __arm64_sys_sync+0x1c/0x30
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0x4c/0xd4
  do_el0_svc+0x30/0x9c
  el0_svc+0x2c/0x54
  el0_sync_handler+0x1a8/0x1b0
  el0_sync+0x198/0x1c0
 ---[ end trace 336f67369ae6e0af ]---

However if we disable v1 space cache, the crash just disappera.

[CAUSE]
The offending inode is in fact a v1 space cache inode.

The crash happens in the following sequence:

- Writing back space cache for inode 1/257 (root 1, ino 257).
  The space cache is a little big in this case, 983040 bytes (960K).

- Run delalloc range for the free space cache inode
  Ordered extent [0, 960K) is inserted for inode 1/257.

- Call __extent_writepage_io() for each page
  The first 3 pages submitted without problem.
  But the 4th page get submitted but failed due to the injected error.

- Error out without handling the submitted ordered extent
  Since only 4 pages submitted and finished, the ordered extent
  [0, 960K) is still there.

- Retry the free space cache writeback with some update
  Now inode 1/257 have its contents updated, and need to try writeback
  again.

- Run delalloc range for the free space cache inode.
  Ordered extent [0, 960K) is going to be inserted again.
  But previously added ordered extent [0, 960K) is still there,
  triggering the crash.

This problem only happens for free space cache inode, as other inode
won't try to re-write the same inode after error.

Although the free space cache size 960K seems to be a subpage specific
problem, but the root cause is still there.

[FIX]
Fix the problem by introducing a new helper,
btrfs_cleanup_hanging_ordered_extents(), to cleanup the added ordered
extent after bio submission error.

This function will call btrfs_mark_ordered_io_finished() on each
involved page, and finish the ordered extent and clear the page Private
bit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

Current version works and will no longer crash at btrfs/160.
(Although still need some polish, as the delalloc space for v1 cache
 inode is not yet properly cleaned up)

But I'm not sure why we never hit such problem for v1 space cache write
back, and not sure if this is the correct way to go.

Should we just error out if we failed to write back v1 space cache?

Anyway, send out the RFC version to make sure if the fix is the correct
way to go.
---
 fs/btrfs/ctree.h       |  3 +++
 fs/btrfs/extent_io.c   | 15 +++++++++++++++
 fs/btrfs/inode.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c | 11 +++++++++++
 4 files changed, 70 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e265a7eb0d5c..8c32f2119790 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3194,6 +3194,9 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, int uptodate);
+void btrfs_cleanup_hanging_ordered_extents(struct btrfs_fs_info *fs_info,
+					   struct btrfs_inode *inode,
+					   u64 start);
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
 extern const struct iomap_dio_ops btrfs_dio_ops;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fff1a4d8fe25..cfbed849b598 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4137,6 +4137,21 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		ret = ret < 0 ? ret : -EIO;
 		end_extent_writepage(page, ret, page_start, page_end);
 	}
+
+	/*
+	 * We may have ordered extent already allocated, and since we error out
+	 * the remaining pages will never be submitted thus the ordered extent
+	 * will hang there forever.
+	 *
+	 * Such hanging OE would cause problem for things like free space cache
+	 * where we could retry to write it back.
+	 * So here if we hit error submitting the IO, we need to cleanup the
+	 * hanging ordered extent.
+	 */
+	if (ret < 0)
+		btrfs_cleanup_hanging_ordered_extents(fs_info, BTRFS_I(inode),
+						      page_end + 1);
+
 	if (epd->extent_locked) {
 		/*
 		 * If epd->extent_locked, it's from extent_write_locked_range(),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e8af0021af78..05d392315f3b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3211,6 +3211,47 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+/*
+ * Cleanup any added ordered ordered extent from @start.
+ *
+ * This fucntion should be called when ordered extent is submitted but by some
+ * how the bio submission hits some error and has to error out.
+ */
+void btrfs_cleanup_hanging_ordered_extents(struct btrfs_fs_info *fs_info,
+					   struct btrfs_inode *inode,
+					   u64 start)
+{
+	struct btrfs_ordered_extent *oe;
+	u64 cur;
+	u64 end;
+
+	ASSERT(IS_ALIGNED(start, PAGE_SIZE));
+	/* Grab the ordered extent covers the bytenr to calculate the end. */
+	oe = btrfs_lookup_first_ordered_extent(inode, start);
+	if (!oe)
+		return;
+	end = oe->file_offset + oe->num_bytes;
+	btrfs_put_ordered_extent(oe);
+
+	/* Finish the ordered extent of the remaining pages */
+	for (cur = start; cur < end; cur += PAGE_SIZE) {
+		struct page *page;
+		u32 len;
+
+		page = find_lock_page(inode->vfs_inode.i_mapping,
+				cur >> PAGE_SHIFT);
+		if (!page)
+			continue;
+
+		len = min(page_offset(page) + PAGE_SIZE, end + 1) -
+		      page_offset(page);
+		btrfs_mark_ordered_io_finished(inode, page, cur, len,
+				finish_ordered_fn, false);
+		unlock_page(page);
+		put_page(page);
+	}
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 14b9fdc8aaa9..05d786401374 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -313,6 +313,17 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	if (type == TRANS_ATTACH)
 		return -ENOENT;
 
+	/*
+	 * TRANS_JOIN_NOLOCK is only utilized by free space cache endio.
+	 * Normally it only happens during commit transaction, but it's
+	 * possible that we error out and abort transaction.
+	 *
+	 * In that case, the endio for free space cache may get no running
+	 * trans.
+	 * Stay cool and just return error for the only caller.
+	 */
+	if (type == TRANS_JOIN_NOLOCK)
+		return -ENOENT;
 	/*
 	 * JOIN_NOLOCK only happens during the transaction commit, so
 	 * it is impossible that ->running_transaction is NULL
-- 
2.32.0


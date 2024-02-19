Return-Path: <linux-btrfs+bounces-2483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0534859BDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 07:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523731F21723
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409F2030A;
	Mon, 19 Feb 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kwmMmCGb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FogY2xtr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79481E514
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322928; cv=none; b=bvjzBQpiTMtkel7CgHWitl2yge81TZoCeXFNR9oEoWpGlm5RB38AiE+8nFyeVMS0K/mAOFPxJ3XNEpCj0+48MhXfVB/eMwjBxM6KovXVzOGbPy4HfIkiYUBIQQC1ZainuVOvJ78p8ojw3LHHtGCUvCQUYbJAsDQaGfzwiNir768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322928; c=relaxed/simple;
	bh=WvnxN5CKulFc4zuIeJVvelqv2kPEdQimVZCDaQp4Jp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXkQ20areTw/XcAz88RRXqilSna2omKRxi3P8xHrhwhOhxExMHS8O6BYO34+OBrz4XU/QWCTz81huxHnnQOrwzM04EgmccaTgZTOCe63zJaBpy62x0SRSzTZaFNweBPeHXgDnuvU4LP3coWkS0o768DnFx+mkGsdx8qkJLC1SHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kwmMmCGb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FogY2xtr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE96421E2F
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBU5nfT4R9ePYKPQhAWCqNRbRENFW/a46WUoLdusb2s=;
	b=kwmMmCGbUC4ToR6C1RdvxSJCoO/d3cx4/0hHjQGEmB7RJ76cAPjnsvbaEKYsdEQasKwooe
	jwPNWKu9U5+yBtBFeERjGTA+2BFsXMNAlyRI1F2wHk+Q1IgQDa1gtm19XTFlkz4HfRU3db
	uJnm4EQIotcpMFR3WCEAAkdjZnR2Cgk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBU5nfT4R9ePYKPQhAWCqNRbRENFW/a46WUoLdusb2s=;
	b=FogY2xtrYyR1NNHofU1c0FNLjaVZvzsPpGMeEG3bo00sIIVM1qUpvbqGyxrCD4WdPgPzkl
	n9KE8rjR0fQQOrl3to6GmC/4v6ZtsJRgKtqfGB11S989s+uKo++zkplN62QM+U4YtYJ2UM
	1eACwoOAXAQ+E/m3QcVuAJ5/YKwLf1I=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F17713585
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0FNiM2vw0mXcJQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: lock subpage ranges in one go for writepage_delalloc()
Date: Mon, 19 Feb 2024 16:38:35 +1030
Message-ID: <6d26231f01dcf42f494ab501e8242394164ef140.1708322044.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708322044.git.wqu@suse.com>
References: <cover.1708322044.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

If we have a subpage range like this for a 16K page with 4K sectorsize:

    0     4K     8K     12K     16K
    |/////|      |//////|       |

    |/////| = dirty range

Currently writepage_delalloc() would go through the following steps:

- lock range [0, 4K)
- run delalloc range for [0, 4K)
- lock range [8K, 12K)
- run delalloc range for [8K 12K)

So far it's fine for subpage, as btrfs_run_delalloc_range() would only
go through cow_file_range()/run_delalloc_cow(), or
run_delalloc_compressed() for the whole page.

But there is a special pitfall for zoned subpage, where we will go
through run_delalloc_cow(), which would unlock the whole page.

This patch would not yet address the run_delalloc_cow() problem, but
would prepare for the proper fix by changing the workflow to the
following one:

- lock range [0, 4K)
- lock range [8K, 12K)
- run delalloc range for [0, 4K)
- run delalloc range for [8K, 12K)

So later for subpage cases we can do extra work to ensure
run_delalloc_cow() to only unlock the full page until the last lock
user.

To save the previously locked range, we utilize a structure called
locked_delalloc_list, which would cached the last hit delalloc range,
thus for non-subpage cases, it would use that cached value.

For subpage cases since we can hit multiple delalloc ranges inside a
page, a list would be utilized and we will allocate memory for them.
This introduced a new memory allocation thus extra error paths, but this
method is only tempoarary, we will later use subpage bitmap to avoid
the memory allocation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 140 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 556ec44fdf8e..e79676422c16 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1185,6 +1185,101 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	}
 }
 
+struct locked_delalloc_range {
+	struct list_head list;
+	u64 delalloc_start;
+	u32 delalloc_len;
+};
+
+/*
+ * Save the locked delalloc range.
+ *
+ * This is for subpage only, as for regular sectorsize, there will be at most
+ * one locked delalloc range for a page.
+ */
+struct locked_delalloc_list {
+	u64 last_delalloc_start;
+	u32 last_delalloc_len;
+	struct list_head head;
+};
+
+static void init_locked_delalloc_list(struct locked_delalloc_list *locked_list)
+{
+	INIT_LIST_HEAD(&locked_list->head);
+	locked_list->last_delalloc_start = 0;
+	locked_list->last_delalloc_len = 0;
+}
+
+static void release_locked_delalloc_list(struct locked_delalloc_list *locked_list)
+{
+	while (!list_empty(&locked_list->head)) {
+		struct locked_delalloc_range *entry;
+
+		entry = list_entry(locked_list->head.next,
+				   struct locked_delalloc_range, list);
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+}
+
+static int add_locked_delalloc_range(struct btrfs_fs_info *fs_info,
+				     struct locked_delalloc_list *locked_list,
+				     u64 start, u32 len)
+{
+	struct locked_delalloc_range *entry;
+
+	entry = kmalloc(sizeof(*entry), GFP_NOFS);
+	if (!entry)
+		return -ENOMEM;
+
+	if (locked_list->last_delalloc_len == 0) {
+		locked_list->last_delalloc_start = start;
+		locked_list->last_delalloc_len = len;
+		return 0;
+	}
+	/* The new entry must be beyond the current one. */
+	ASSERT(start >= locked_list->last_delalloc_start +
+			locked_list->last_delalloc_len);
+
+	/* Only subpage case can have more than one delalloc ranges inside a page. */
+	ASSERT(fs_info->sectorsize < PAGE_SIZE);
+
+	entry->delalloc_start = locked_list->last_delalloc_start;
+	entry->delalloc_len = locked_list->last_delalloc_len;
+	locked_list->last_delalloc_start = start;
+	locked_list->last_delalloc_len = len;
+	list_add_tail(&entry->list, &locked_list->head);
+	return 0;
+}
+
+static void __cold unlock_one_locked_delalloc_range(struct btrfs_inode *binode,
+						    struct page *locked_page,
+						    u64 start, u32 len)
+{
+	u64 delalloc_end = start + len - 1;
+
+	unlock_extent(&binode->io_tree, start, delalloc_end, NULL);
+	__unlock_for_delalloc(&binode->vfs_inode, locked_page, start,
+			      delalloc_end);
+}
+
+static void unlock_locked_delalloc_list(struct btrfs_inode *binode,
+					struct page *locked_page,
+					struct locked_delalloc_list *locked_list)
+{
+	struct locked_delalloc_range *entry;
+
+	list_for_each_entry(entry, &locked_list->head, list)
+		unlock_one_locked_delalloc_range(binode, locked_page,
+				entry->delalloc_start, entry->delalloc_len);
+	if (locked_list->last_delalloc_len) {
+		unlock_one_locked_delalloc_range(binode, locked_page,
+				locked_list->last_delalloc_start,
+				locked_list->last_delalloc_len);
+	}
+}
+
 /*
  * helper for __extent_writepage, doing all of the delayed allocation setup.
  *
@@ -1198,13 +1293,17 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc)
 {
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
 	const u64 page_start = page_offset(page);
 	const u64 page_end = page_start + PAGE_SIZE - 1;
+	struct locked_delalloc_list locked_list;
+	struct locked_delalloc_range *entry;
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
 	int ret = 0;
 
+	init_locked_delalloc_list(&locked_list);
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
 		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
@@ -1212,14 +1311,47 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
-
-		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
-					       delalloc_end, wbc);
-		if (ret < 0)
+		ret = add_locked_delalloc_range(fs_info, &locked_list,
+				delalloc_start, delalloc_end + 1 - delalloc_start);
+		if (ret < 0) {
+			unlock_locked_delalloc_list(inode, page, &locked_list);
+			release_locked_delalloc_list(&locked_list);
 			return ret;
+		}
 
 		delalloc_start = delalloc_end + 1;
 	}
+	list_for_each_entry(entry, &locked_list.head, list) {
+		delalloc_end = entry->delalloc_start + entry->delalloc_len - 1;
+
+		/*
+		 * Hit error in the previous run, cleanup the locked
+		 * extents/pages.
+		 */
+		if (ret < 0) {
+			unlock_one_locked_delalloc_range(inode, page,
+					entry->delalloc_start, entry->delalloc_len);
+			continue;
+		}
+		ret = btrfs_run_delalloc_range(inode, page, entry->delalloc_start,
+					       delalloc_end, wbc);
+	}
+	if (locked_list.last_delalloc_len) {
+		delalloc_end = locked_list.last_delalloc_start +
+			       locked_list.last_delalloc_len - 1;
+
+		if (ret < 0)
+			unlock_one_locked_delalloc_range(inode, page,
+					locked_list.last_delalloc_start,
+					locked_list.last_delalloc_len);
+		else
+			ret = btrfs_run_delalloc_range(inode, page,
+					locked_list.last_delalloc_start,
+					delalloc_end, wbc);
+	}
+	release_locked_delalloc_list(&locked_list);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * delalloc_end is already one less than the total length, so
-- 
2.43.2



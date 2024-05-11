Return-Path: <linux-btrfs+bounces-4909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28EC8C2DE4
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 02:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3185CB2285C
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776E710F4;
	Sat, 11 May 2024 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TnCFNA1a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TnCFNA1a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9528FA
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386540; cv=none; b=VabN1QnJ5je6C4XcYkKmY/uG4bAnmkV/6VhUJ4yTcWw0rzgpx0Zuf00oMt2exZa4QObPgf/ibO+QQyez3ESz8afG2hVk/gp+QuDEilmSBBRdIoDfMQd1O6/fQNoBriePl0EwoDK7B4aNnGOG4+/GusJC2we05MdrLa+SZRrhJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386540; c=relaxed/simple;
	bh=nfSsPzqp2kbZIoQeQnyeXzalBOpKVLeIcYbn/Srk/J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHiMX/MwmCUumbaqDVLLDMF7usKL+DQcsAsKDtN/7sso3NV2a00jrB7qMwKoanc04HTxO55Qge3t1IdO4DxhbZI3/kClzMv5mDGhJGcNoN3cdEpEdO5xo2JXD+JayZwWH5xCCeqBygLWJxGfqTfg+tehbQJCnLViuBTA9K4oK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TnCFNA1a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TnCFNA1a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D35E21F9A;
	Sat, 11 May 2024 00:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x5Jg98LD3zbCi0ZwjwOueuWZy0Nt69BfU7uPyTlw9g=;
	b=TnCFNA1aXbM3Swyo6FEQmlwbVnWgbS5bgzV7y9dxceFIb+bxtY8j2/06uJvrtSO//uVT/h
	aNlm3zPc+TkopLuBOoaXH50a64wQ00qWsvR2dM0Zu5J9JgesT0WHfkGV/lHXKkbQTLHkCS
	HPYJKhFwLLLpL4AJfCh4dHxtVwMSajA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x5Jg98LD3zbCi0ZwjwOueuWZy0Nt69BfU7uPyTlw9g=;
	b=TnCFNA1aXbM3Swyo6FEQmlwbVnWgbS5bgzV7y9dxceFIb+bxtY8j2/06uJvrtSO//uVT/h
	aNlm3zPc+TkopLuBOoaXH50a64wQ00qWsvR2dM0Zu5J9JgesT0WHfkGV/lHXKkbQTLHkCS
	HPYJKhFwLLLpL4AJfCh4dHxtVwMSajA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B987E13A3D;
	Sat, 11 May 2024 00:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uLHpGqa4PmYcPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 May 2024 00:15:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH v4 2/6] btrfs: lock subpage ranges in one go for writepage_delalloc()
Date: Sat, 11 May 2024 09:45:18 +0930
Message-ID: <91da2c388f3152f40af0e3e8c7ca7c7f8f6687db.1715386434.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715386434.git.wqu@suse.com>
References: <cover.1715386434.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

If we have a subpage range like this for a 16K page with 4K sectorsize:

    0     4K     8K     12K     16K
    |/////|      |//////|       |

    |/////| = dirty range

Currently writepage_delalloc() would go through the following steps:

- lock range [0, 4K)
- run delalloc range for [0, 4K)
- lock range [8K, 12K)
- run delalloc range for [8K 12K)

So far it's fine for regular subpage, as btrfs_run_delalloc_range() can
only go into one of  run_delalloc_nocow(), cow_file_range() and
run_delalloc_compressed().

But there is a special pitfall for zoned subpage, where we will go
through run_delalloc_cow(), which would create the ordered extent for the
range and immediately submit the range.
This would unlock the whole page range, causing all kinds of different
ASSERT()s related to locked page.

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
index 8a4a7d00795f..6f237c77699a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1213,6 +1213,101 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
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
@@ -1226,13 +1321,17 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
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
@@ -1240,14 +1339,47 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
2.45.0



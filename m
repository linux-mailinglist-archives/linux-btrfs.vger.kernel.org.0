Return-Path: <linux-btrfs+bounces-4910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC528C2DE5
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 02:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE46284EB0
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCEB28FC;
	Sat, 11 May 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q73zLKJB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q73zLKJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F253C8F3
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386542; cv=none; b=dR+PPjVRbw7nN4YxZBaHMLeJw4B2aEAIjJ4yADRTh6JLUpBoz6WTjyf6t/GJgcJhUaMEptRgiFS9oFf2acvPuA0oCBz4LliA+KJs6nWhk6ple9RENidL1nw15EgNuNwkCtLL0YrdIVJ3/GkrVFkb4bov8UaRaj7MM0xLQSd8uB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386542; c=relaxed/simple;
	bh=yd4qLsQqdzgVjW8aKxz62/v0v4YgaWFgfeyBgbOP9JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebwV+CUBtqkWPlzJ7o+MF12rkNEONebfDD6dfg8YPyKsstJwcwtX/Ir54L4YiD0F7QzlEQuZGIgYt9MISLR+5IfReTB94KNm0/aOCvxbf6xHEAyz7NGZ9sNTxX9uMqceNlwBQocuiu5G1P0M71bivcmNnWqmxj+vNYpd5fcgZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q73zLKJB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q73zLKJB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63047200E6;
	Sat, 11 May 2024 00:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMPUfW4AKhP0KzxiNIfnRzLkDdRGTZU7SBKJZai6Qh8=;
	b=q73zLKJBzkLdE+VwQ4go9vTEurAdtwAQOH6ZEvMmiBuZ9VpBqZ3aqAumDMcMKgQP5LYcdU
	iHp0WQ/8ObE9ON3RK553UZ7SAXZuar7h6Muw824DmfzB+lJh8UehvPrjvk5myk9GVb/i5H
	DXFWMkOoUsNLI/gC8wgECOTXigv2Mpg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=q73zLKJB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMPUfW4AKhP0KzxiNIfnRzLkDdRGTZU7SBKJZai6Qh8=;
	b=q73zLKJBzkLdE+VwQ4go9vTEurAdtwAQOH6ZEvMmiBuZ9VpBqZ3aqAumDMcMKgQP5LYcdU
	iHp0WQ/8ObE9ON3RK553UZ7SAXZuar7h6Muw824DmfzB+lJh8UehvPrjvk5myk9GVb/i5H
	DXFWMkOoUsNLI/gC8wgECOTXigv2Mpg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD6F213A3D;
	Sat, 11 May 2024 00:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePDNI6i4PmYcPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 May 2024 00:15:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH v4 3/6] btrfs: subpage: introduce helpers to handle subpage delalloc locking
Date: Sat, 11 May 2024 09:45:19 +0930
Message-ID: <3e6312684916bdd2b3d9d4ad53a00cd4c9219cad.1715386434.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 63047200E6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Two new helpers are introduced for the incoming subpage delalloc locking
change.

- btrfs_folio_set_writer_lock()
  This is to mark specified range with subpage specific writer lock.
  After calling this, the subpage range can be proper unlocked by
  btrfs_folio_end_writer_lock()

- btrfs_subpage_find_writer_locked()
  This is to find the writer locked subpage range in a page.
  With the help of btrfs_folio_set_writer_lock(), it can allow us to
  record and find previously locked subpage range without extra memory
  allocation.

- btrfs_folio_end_all_writers()
  This is for the locked_page of __extent_writepage(), as there may be
  multiple subpage delalloc ranges locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h |   7 +++
 2 files changed, 123 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 183b32f51f51..3c957d03324e 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -775,6 +775,122 @@ void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
 	btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
+/*
+ * This is for folio already locked by plain lock_page()/folio_lock(), which
+ * doesn't have any subpage awareness.
+ *
+ * This would populate the involved subpage ranges so that subpage helpers can
+ * properly unlock them.
+ */
+void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage;
+	unsigned long flags;
+	int start_bit;
+	int nbits;
+	int ret;
+
+	ASSERT(folio_test_locked(folio));
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
+		return;
+
+	subpage = folio_get_private(folio);
+	start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
+	nbits = len >> fs_info->sectorsize_bits;
+	spin_lock_irqsave(&subpage->lock, flags);
+	/* Target range should not yet be locked. */
+	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	bitmap_set(subpage->bitmaps, start_bit, nbits);
+	ret = atomic_add_return(nbits, &subpage->writers);
+	ASSERT(ret <= fs_info->subpage_info->bitmap_nr_bits);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+/*
+ * Find any subpage writer locked range inside @folio, starting at file offset
+ * @search_start.
+ * The caller should ensure the folio is locked.
+ *
+ * Return true and update @found_start_ret and @found_len_ret to the first
+ * writer locked range.
+ * Return false if there is no writer locked range.
+ */
+bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
+				      struct folio *folio, u64 search_start,
+				      u64 *found_start_ret, u32 *found_len_ret)
+{
+	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
+	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const int len = PAGE_SIZE - offset_in_page(search_start);
+	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked,
+						     search_start, len);
+	const int locked_bitmap_start = subpage_info->locked_offset;
+	const int locked_bitmap_end = locked_bitmap_start +
+				      subpage_info->bitmap_nr_bits;
+	unsigned long flags;
+	int first_zero;
+	int first_set;
+	bool found = false;
+
+	ASSERT(folio_test_locked(folio));
+	spin_lock_irqsave(&subpage->lock, flags);
+	first_set = find_next_bit(subpage->bitmaps, locked_bitmap_end,
+				  start_bit);
+	if (first_set >= locked_bitmap_end)
+		goto out;
+
+	found = true;
+	*found_start_ret = folio_pos(folio) +
+		((first_set - locked_bitmap_start) << fs_info->sectorsize_bits);
+
+	first_zero = find_next_zero_bit(subpage->bitmaps,
+					locked_bitmap_end, first_set);
+	*found_len_ret = (first_zero - first_set) << fs_info->sectorsize_bits;
+out:
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	return found;
+}
+
+/*
+ * Unlike btrfs_folio_end_writer_lock() which unlock a specified subpage range,
+ * this would end all writer locked ranges of a page.
+ *
+ * This is for the locked page of __extent_writepage(), as the locked page
+ * can contain several locked subpage ranges.
+ */
+void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio)
+{
+	u64 folio_start = folio_pos(folio);
+	u64 cur = folio_start;
+
+	ASSERT(folio_test_locked(folio));
+	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+		folio_unlock(folio);
+		return;
+	}
+
+	while (cur < folio_start + PAGE_SIZE) {
+		u64 found_start;
+		u32 found_len;
+		bool found;
+		bool last;
+
+		found = btrfs_subpage_find_writer_locked(fs_info, folio, cur,
+							 &found_start, &found_len);
+		if (!found)
+			break;
+		last = btrfs_subpage_end_and_test_writer(fs_info, folio,
+							 found_start, found_len);
+		if (last) {
+			folio_unlock(folio);
+			break;
+		}
+		cur = found_start + found_len;
+	}
+}
+
 #define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
 	bitmap_cut(dst, subpage->bitmaps, 0,				\
 		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 4b363d9453af..9f19850d59f2 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -112,6 +112,13 @@ int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
 void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
+void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, u64 start, u32 len);
+bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
+				      struct folio *folio, u64 search_start,
+				      u64 *found_start_ret, u32 *found_len_ret);
+void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio);
 
 /*
  * Template for subpage related operations.
-- 
2.45.0



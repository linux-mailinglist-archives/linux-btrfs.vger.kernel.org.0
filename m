Return-Path: <linux-btrfs+bounces-11129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61792A21840
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3966164E21
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81519CD1D;
	Wed, 29 Jan 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yp8RMkxy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yp8RMkxy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583119ABAC
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136279; cv=none; b=rMSAfEAfmfH4WDPeCH512mSXFoZcEwqYW/SmGd204E+m7bJ14ekRVfyYpYQnAugBVikwxAOCizkFyAaE/ZS6elHPyK8g+3o2/Qh2aif2lkNTxldGewc/ETvslOeYk7GGPUi34GaJDTULcnxMLBgFECN6wh25hm/SwsPznleIAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136279; c=relaxed/simple;
	bh=WeA6o27LGW2ILOaOBs3PtWFWRnN1L6jNifF0KFLV0u8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH5kK32H7tWdKIe4U4ltkukObzDsmGJLsbfZvB5INpBpvWqTNqsmTCh/K/djW5SriFwpcvK7StxTCIsIx15vzDymm8oZWEPNe/7WetwWdVKskeFKeSFl94giFE61o5RqAweyyS7qGw03RfOm1xNESllxxV6CyFGnCB2SBr7kWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yp8RMkxy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yp8RMkxy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E47E1F387
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vd/oQra9OQAM2a88DG/Uo39pNUGtnkeO4WVZlB9iZk=;
	b=Yp8RMkxyR/fIbwPERE1zTcBiIYjxxSQnmsO4c1GNXCSklAcTVGRx5hEV+OaN9qnId8FMPc
	J8kMEs0LS00p+o4ZyQxiWDBS4o3+rFka8jt/lUSxI/LAq/fWXYlKaLHZZ0IwqJsjZUDbVP
	s7vu5lKW+fV2h+Jy6C8AMur4Lxs6iHE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vd/oQra9OQAM2a88DG/Uo39pNUGtnkeO4WVZlB9iZk=;
	b=Yp8RMkxyR/fIbwPERE1zTcBiIYjxxSQnmsO4c1GNXCSklAcTVGRx5hEV+OaN9qnId8FMPc
	J8kMEs0LS00p+o4ZyQxiWDBS4o3+rFka8jt/lUSxI/LAq/fWXYlKaLHZZ0IwqJsjZUDbVP
	s7vu5lKW+fV2h+Jy6C8AMur4Lxs6iHE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A1DC137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sKMaCtLamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: use metadata specific helpers to simplify extent buffer helpers
Date: Wed, 29 Jan 2025 18:07:19 +1030
Message-ID: <4bba0a93301709f71908486c1d45a8f470c2e983.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738127135.git.wqu@suse.com>
References: <cover.1738127135.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The following functions are doing metadata specific checks:

- set_extent_buffer_uptodate()
- clear_extent_buffer_uptodate()

The reason why we do not use btrfs_folio_*() helpers for those helpers
is, btrfs_is_subpage() can not handle dummy extent buffer if nodesize >=
PAGE_SIZE but block size < PAGE_SIZE.

In that case, we do not need to attach extra bitmaps to the extent
buffer folio. But since dummy extent buffer folios are not attached to
btree inode, btrfs_is_subpage() will return true, causing problems.

And the following are using btrfs_folio_*() helpers for metadata, but
in theory we should use metadata specific checks:

- set_extent_buffer_dirty()

This is not causing problems because a dummy extent buffer should never
be marked dirty, thus we avoided the bullet.

To make code simpler, introduce btrfs_meta_folio_*() helpers, to do
the metadata specific handling, so that we do not to open-code such
checks in above involved functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 24 ++++--------------------
 fs/btrfs/subpage.c   | 25 +++++++++++++++++++++++++
 fs/btrfs/subpage.h   | 15 ++++++++++++++-
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5fb52e2f67bb..8da1da43aa74 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3424,8 +3424,8 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		if (subpage)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_folios; i++)
-			btrfs_folio_set_dirty(eb->fs_info, eb->folios[i],
-					      eb->start, eb->len);
+			btrfs_meta_folio_set_dirty(eb->fs_info, eb->folios[i],
+						   eb->start, eb->len);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
@@ -3450,15 +3450,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 		if (!folio)
 			continue;
 
-		/*
-		 * This is special handling for metadata subpage, as regular
-		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
-		 */
-		if (!btrfs_meta_is_subpage(fs_info))
-			folio_clear_uptodate(folio);
-		else
-			btrfs_subpage_clear_uptodate(fs_info, folio,
-						     eb->start, eb->len);
+		btrfs_meta_folio_clear_uptodate(fs_info, folio, eb->start, eb->len);
 	}
 }
 
@@ -3471,15 +3463,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio = eb->folios[i];
 
-		/*
-		 * This is special handling for metadata subpage, as regular
-		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
-		 */
-		if (!btrfs_meta_is_subpage(fs_info))
-			folio_mark_uptodate(folio);
-		else
-			btrfs_subpage_set_uptodate(fs_info, folio,
-						   eb->start, eb->len);
+		btrfs_meta_folio_set_uptodate(fs_info, folio, eb->start, eb->len);
 	}
 }
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 61163e3ca42f..aab6d8accf44 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -651,6 +651,31 @@ bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 		return folio_test_func(folio);				\
 	btrfs_subpage_clamp_range(folio, &start, &len);			\
 	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
+}									\
+void btrfs_meta_folio_set_##name(const struct btrfs_fs_info *fs_info,   \
+				 struct folio *folio, u64 start, u32 len) \
+{									\
+	if (!btrfs_meta_is_subpage(fs_info)) {				\
+		folio_set_func(folio);					\
+		return;							\
+	}								\
+	btrfs_subpage_set_##name(fs_info, folio, start, len);		\
+}									\
+void btrfs_meta_folio_clear_##name(const struct btrfs_fs_info *fs_info, \
+				   struct folio *folio, u64 start, u32 len) \
+{									\
+	if (!btrfs_meta_is_subpage(fs_info)) {				\
+		folio_clear_func(folio);				\
+		return;							\
+	}								\
+	btrfs_subpage_clear_##name(fs_info, folio, start, len);		\
+}									\
+bool btrfs_meta_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
+				  struct folio *folio, u64 start, u32 len) \
+{									\
+	if (!btrfs_meta_is_subpage(fs_info))				\
+		return folio_test_func(folio);				\
+	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_uptodate,
 			 folio_test_uptodate);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 0046403774f2..0c68c45d3f62 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -128,6 +128,13 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
  * btrfs_folio_clamp_*() are similar to btrfs_folio_*(), except the range doesn't
  * need to be inside the page. Those functions will truncate the range
  * automatically.
+ *
+ * Both btrfs_folio_*() and btrfs_folio_clamp_*() are for data folios.
+ *
+ * For metadata, one should use btrfs_meta_folio_*() helpers instead, and there
+ * is no clamp version for metadata helpers, as we either go subpage
+ * (nodesize < PAGE_SIZE) or go regular folio helpers (nodesize >= PAGE_SIZE,
+ * and our folio is never larger than nodesize).
  */
 #define DECLARE_BTRFS_SUBPAGE_OPS(name)					\
 void btrfs_subpage_set_##name(const struct btrfs_fs_info *fs_info,	\
@@ -147,7 +154,13 @@ void btrfs_folio_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 void btrfs_folio_clamp_clear_##name(const struct btrfs_fs_info *fs_info,	\
 		struct folio *folio, u64 start, u32 len);			\
 bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct folio *folio, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);		\
+void btrfs_meta_folio_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);		\
+void btrfs_meta_folio_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);		\
+bool btrfs_meta_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);		\
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
-- 
2.48.1



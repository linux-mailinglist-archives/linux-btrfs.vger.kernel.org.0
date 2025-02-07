Return-Path: <linux-btrfs+bounces-11338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E54EA2BA38
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 05:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E126165921
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD95233124;
	Fri,  7 Feb 2025 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZiKi0gKQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZiKi0gKQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D37194A67
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902396; cv=none; b=lVWzomZ47VEDoYZsW/3/JrN7qVu+nzmdwwZRwjp23/+2sRPY3hvokQzRgh8ecZTq3IVHo/DgWM+s3h/QEoMZihQgR9jvXoaiDGHAmYFXTEFdgSJWEWge7MvZr9tJMcwe4KpXN/z77OOnYgGLTYDvxnKMv2xR17BAhZA9TCttxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902396; c=relaxed/simple;
	bh=gtnaW60JahstXBhENcSS8wgRIb0R/ngzGPQDxjajV9Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVjFOaMwcvpwVntU3yG8TaQxSsYl+qixtZ5wzpOGQKGJsHY3O0N+rGuWTHtsMlSbOvf3ejcbDjjzxwMSPpXac+4PhuKXduTp+iv4CYJKv056p2YPojd8vP/FJE6WkndtMgL7xw1Yq/Zt+735BaTDhPZb9i6JR1NOgdJL+iXe0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZiKi0gKQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZiKi0gKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 242B721160
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9k3ffLFD2pxkUgHUAxS7fmMdPPBNrmBX6gw4pyFYZwo=;
	b=ZiKi0gKQ7/vQExcvUDZOE1eVYUcB2WBxbNlZCidpj/WzCSNWEpnRmPSj1i3Ef3WlfT2Ccy
	+o+vITbnFIxZDc96XH2HNzs+9+6lGVNcSDTCWqk6JD89Pr0bATqioiIVlTq/2HpuTQMan4
	FNh8ROd+sr+qFXg7UwZxxIOAmgcg3GE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZiKi0gKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9k3ffLFD2pxkUgHUAxS7fmMdPPBNrmBX6gw4pyFYZwo=;
	b=ZiKi0gKQ7/vQExcvUDZOE1eVYUcB2WBxbNlZCidpj/WzCSNWEpnRmPSj1i3Ef3WlfT2Ccy
	+o+vITbnFIxZDc96XH2HNzs+9+6lGVNcSDTCWqk6JD89Pr0bATqioiIVlTq/2HpuTQMan4
	FNh8ROd+sr+qFXg7UwZxxIOAmgcg3GE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D67E13806
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DzrAneLpWezCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2025 04:26:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/8] btrfs: use metadata specific helpers to simplify extent buffer helpers
Date: Fri,  7 Feb 2025 14:56:03 +1030
Message-ID: <de17aaead0540f8d4eaf863189f82729c03994a8.1738902149.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738902149.git.wqu@suse.com>
References: <cover.1738902149.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 242B721160
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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
index 089fb6cecbba..dbf4fb1fc2d1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3442,8 +3442,8 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
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
@@ -3468,15 +3468,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
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
 
@@ -3489,15 +3481,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
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
index 2119bf2e67ac..07c87da400ec 100644
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



Return-Path: <linux-btrfs+bounces-11133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D6A21845
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DA23A34B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFE19DF64;
	Wed, 29 Jan 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jQmmEZBt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jQmmEZBt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D919D89B
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136284; cv=none; b=ijZXt86AFOqdwGE8Z3xAhz7b2pJ4uoowkRHXIl98muhW1nbVZQcwhVVQk1ulCJSfv/eh5bg2HjNR/3RwBTSe0xaENRoQoJu0JZvmSkGVJFcI9Ky9FGM4Kg8wZ/g4DOu1GjUGrsqgR97CUnuKaHnW/vnx70bhN4nweI1d+jlCGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136284; c=relaxed/simple;
	bh=wxGnX0pBbhUC4HEtaOuzFYcFQfAdQ8MtTL3Q/hUHCpk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0jAoSa0Y/pGKyPZhbKn9b+afX1INjra+d5jbFD/SxwDdHeuH/hCkRzPXdSOezpfsh8FWjxDSV9bNQzgCtg9PeogrBpQllmQPUyYhCJAZ1GuKOgjaJ6lOSY1VxMQMiQEV4H1BLWFk/BfGpUuxoxpY1+bFI5yOpcBEL7N+6abH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jQmmEZBt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jQmmEZBt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D805210F4
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huA8GT8xk2UM+TzUn1a8TpkMRP4g9r0FNiMiYrym1Q4=;
	b=jQmmEZBtNgIqrqknc+2QkmeLVId4i0NN5ftiRpPYuPsuzpGsAaVz0jYeRIczlEXEncJhUF
	Ma/4jLXmbJxnsJVP4HML0dgizbGD+k5GgbeCHikFgjMGJpGGJEHN1q5W/0mZ6PTN0VTJy3
	fzkkW+OsyQegT3+0GyMLkE9IMriaNVo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jQmmEZBt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huA8GT8xk2UM+TzUn1a8TpkMRP4g9r0FNiMiYrym1Q4=;
	b=jQmmEZBtNgIqrqknc+2QkmeLVId4i0NN5ftiRpPYuPsuzpGsAaVz0jYeRIczlEXEncJhUF
	Ma/4jLXmbJxnsJVP4HML0dgizbGD+k5GgbeCHikFgjMGJpGGJEHN1q5W/0mZ6PTN0VTJy3
	fzkkW+OsyQegT3+0GyMLkE9IMriaNVo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA0E137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YMmKHtfamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: require strict data/metadata split for subpage check
Date: Wed, 29 Jan 2025 18:07:23 +1030
Message-ID: <3c7f2bdcb4c930258036349db3ff7e3028291f9a.1738127135.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 9D805210F4
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Since we have btrfs_meta_is_subpage(), we should make btrfs_is_subpage()
to be data inode specific.

This change involves:

- Simplify btrfs_is_subpage()
  Now we only need to do a very simple sectorsize check against
  PAGE_SIZE.
  And since the function is pretty simple now, just make it an inline
  function.

- Add an extra ASSERT() to make sure btrfs_is_subpage() is only called
  on data inode mapping

- Migrate btree_csum_one_bio() to use btrfs_meta_folio_*() helpers
- Migrate alloc_extent_buffer() to use btrfs_meta_folio_*() helpers
- Migrate end_bbio_meta_write() to use btrfs_meta_folio_*() helpers
  Or we will trigger the ASSERT() due to calling btrfs_folio_*() on
  metadata folios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  4 ++--
 fs/btrfs/extent_io.c | 11 ++++-------
 fs/btrfs/subpage.c   | 24 ------------------------
 fs/btrfs/subpage.h   | 11 ++++++++++-
 4 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d55e28282809..8c31ba1b061e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -284,8 +284,8 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON(!btrfs_folio_test_uptodate(fs_info, eb->folios[0],
-					       eb->start, eb->len)))
+	if (WARN_ON(!btrfs_meta_folio_test_uptodate(fs_info, eb->folios[0],
+						    eb->start, eb->len)))
 		return BLK_STS_IOERR;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b810508555fd..ac79886d33d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1720,18 +1720,15 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct folio_iter fi;
-	u32 bio_offset = 0;
 
 	if (bbio->bio.bi_status != BLK_STS_OK)
 		set_btree_ioerr(eb);
 
 	bio_for_each_folio_all(fi, &bbio->bio) {
-		u64 start = eb->start + bio_offset;
 		struct folio *folio = fi.folio;
-		u32 len = fi.length;
 
-		btrfs_folio_clear_writeback(fs_info, folio, start, len);
-		bio_offset += len;
+		btrfs_meta_folio_clear_writeback(fs_info, folio,
+						 eb->start, eb->len);
 	}
 
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
@@ -3118,7 +3115,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
-		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
+		WARN_ON(btrfs_meta_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
 		 * Check if the current page is physically contiguous with previous eb
@@ -3129,7 +3126,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		if (i && folio_page(eb->folios[i - 1], 0) + 1 != folio_page(folio, 0))
 			page_contig = false;
 
-		if (!btrfs_folio_test_uptodate(fs_info, folio, eb->start, eb->len))
+		if (!btrfs_meta_folio_test_uptodate(fs_info, folio, eb->start, eb->len))
 			uptodate = 0;
 
 		/*
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index aab6d8accf44..843259a68c34 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -64,30 +64,6 @@
  *   This means a slightly higher tree locking latency.
  */
 
-#if PAGE_SIZE > SZ_4K
-bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space *mapping)
-{
-	if (fs_info->sectorsize >= PAGE_SIZE)
-		return false;
-
-	/*
-	 * Only data pages (either through DIO or compression) can have no
-	 * mapping. And if page->mapping->host is data inode, it's subpage.
-	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
-	 */
-	if (!mapping || !mapping->host || is_data_inode(BTRFS_I(mapping->host)))
-		return true;
-
-	/*
-	 * Now the only remaining case is metadata, which we only go subpage
-	 * routine if nodesize < PAGE_SIZE.
-	 */
-	if (fs_info->nodesize < PAGE_SIZE)
-		return true;
-	return false;
-}
-#endif
-
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type)
 {
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 0c68c45d3f62..623ff5d98fc1 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/sizes.h>
+#include "btrfs_inode.h"
 #include "fs.h"
 
 struct address_space;
@@ -83,7 +84,13 @@ static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 {
 	return fs_info->nodesize < PAGE_SIZE;
 }
-bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space *mapping);
+static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
+				    struct address_space *mapping)
+{
+	if (mapping && mapping->host)
+		ASSERT(is_data_inode(BTRFS_I(mapping->host)));
+	return fs_info->sectorsize < PAGE_SIZE;
+}
 #else
 static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 {
@@ -92,6 +99,8 @@ static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 				    struct address_space *mapping)
 {
+	if (mapping && mapping->host)
+		ASSERT(is_data_inode(BTRFS_I(mapping->host)));
 	return false;
 }
 #endif
-- 
2.48.1



Return-Path: <linux-btrfs+bounces-13759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129FAAAD4C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 07:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0935698072F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8201DE3A7;
	Wed,  7 May 2025 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kgXAiz50";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kgXAiz50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D023CB
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594311; cv=none; b=Oe+1hEWWIXYpCoELqlXTnuFy/jutcImkqP/9F4tGbhm1sXQ3BJ0BBiootrkxDKJroFGOr+ZJYJxDZFI3jjs3zKgQoAeZu/Lo8lv9iarvFsdVcKefjEcxBDhrg6IbhGVzIzltLaMmuDpHaeJGZM2+aOSH+OwwEEsFAKV2fW8AbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594311; c=relaxed/simple;
	bh=dEI7SkZzO+97RvRxm79NU0R0Zh4qRkePL+sldw0Zpyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z8EjPa78bBQeAP2HTGjLwD2tc0jFC2cWUxKhgTxQi4S7w7avXLh4o2on/S9oKV9rkmlNXZjxbksC7T6uyDcVnmy4nRRh1GaXHNH13BCx5tOy1qOS5pbSyhG2H3SqJKq9DLqAJvOKKrz/bWkStq+Jsm0KlFYaoszrL2ETiM3GKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kgXAiz50; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kgXAiz50; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C0B421222
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 05:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746594306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RT1C0/5X5dM8/StGp2gS4dNieYWqj5Y6QrwTNoCr//M=;
	b=kgXAiz500IHHLiYx/FQcpbtPZyDzDk4pk+JHDqjg3B/LHENU3VCs/SSVNlv1oXR6qU5tMR
	Tt1/NS4osRGH9xbmpcqJ+jb05YHJuTYA6t7xM5OQtMqJEwMANXIw/e/j3hWBfgRlT7HTxp
	bzGBkaWRyYlH+OHn+4ov0NY/JeYrA24=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kgXAiz50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746594306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RT1C0/5X5dM8/StGp2gS4dNieYWqj5Y6QrwTNoCr//M=;
	b=kgXAiz500IHHLiYx/FQcpbtPZyDzDk4pk+JHDqjg3B/LHENU3VCs/SSVNlv1oXR6qU5tMR
	Tt1/NS4osRGH9xbmpcqJ+jb05YHJuTYA6t7xM5OQtMqJEwMANXIw/e/j3hWBfgRlT7HTxp
	bzGBkaWRyYlH+OHn+4ov0NY/JeYrA24=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88FCA13882
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 05:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nzG8EgHqGmhCLAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 07 May 2025 05:05:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: reduce memory usage of scrub_sector_verification
Date: Wed,  7 May 2025 14:34:39 +0930
Message-ID: <b4e4f39ce79e08f41410ec45653d028db63e468b.1746594262.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C0B421222
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

That structure records needed info for block verification (either data
checksum pointer, or expected tree block generation).

But there is also a boolean to tell if this block belongs to a metadata
or not, as the data checksum pointer and expected tree block generation
is already a union, we need a dedicated bit to tell if this block is a
metadata or not.

However such layout means we're wasting 63 bits for x86_64, which is a
huge memory waste.

Thanks to the recent bitmap aggregation, we can easily move this
single-bit-per-block member to a new sub-bitmap.
And since we already have six 16 bits long bitmaps, adding another
bitmap won't even increase any memory usage for x86_64, as we need two
64 bits long anyway.

This will reduce the following memory usages:

- sizeof(struct scrub_sector_verification)
  From 16 bytes to 8 bytes on x86_64.

- scrub_stripe::sectors
  From 16 * 16 to 16 * 8 bytes.

- Per-device scrub_ctx memory usage
  From 128 * (16 * 16) to 128 * (16 * 8), which saves 16KiB memory.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4ba0154e086a..c362bd32756e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -66,8 +66,6 @@ struct scrub_ctx;
 
 /* Represent one sector and its needed info to verify the content. */
 struct scrub_sector_verification {
-	bool is_metadata;
-
 	union {
 		/*
 		 * Csum pointer for data csum verification.  Should point to a
@@ -115,6 +113,9 @@ enum {
 	/* Which blocks are covered by extent items. */
 	scrub_bitmap_nr_has_extent = 0,
 
+	/* Which blocks are meteadata. */
+	scrub_bitmap_nr_is_metadata,
+
 	/*
 	 * Which blocks have errors, including IO, csum, and metadata
 	 * errors.
@@ -304,6 +305,7 @@ static inline unsigned int scrub_bitmap_weight_##name(struct scrub_stripe *strip
 	return bitmap_weight(&bitmap, stripe->nr_sectors);		\
 }
 IMPLEMENT_SCRUB_BITMAP_OPS(has_extent);
+IMPLEMENT_SCRUB_BITMAP_OPS(is_metadata);
 IMPLEMENT_SCRUB_BITMAP_OPS(error);
 IMPLEMENT_SCRUB_BITMAP_OPS(io_error);
 IMPLEMENT_SCRUB_BITMAP_OPS(csum_error);
@@ -801,7 +803,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		return;
 
 	/* Metadata, verify the full tree block. */
-	if (sector->is_metadata) {
+	if (scrub_bitmap_test_bit_is_metadata(stripe, sector_nr)) {
 		/*
 		 * Check if the tree block crosses the stripe boundary.  If
 		 * crossed the boundary, we cannot verify it but only give a
@@ -850,7 +852,7 @@ static void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long b
 
 	for_each_set_bit(sector_nr, &bitmap, stripe->nr_sectors) {
 		scrub_verify_one_sector(stripe, sector_nr);
-		if (stripe->sectors[sector_nr].is_metadata)
+		if (scrub_bitmap_test_bit_is_metadata(stripe, sector_nr))
 			sector_nr += sectors_per_tree - 1;
 	}
 }
@@ -1019,7 +1021,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	for_each_set_bit(sector_nr, &extent_bitmap, stripe->nr_sectors) {
 		bool repaired = false;
 
-		if (stripe->sectors[sector_nr].is_metadata) {
+		if (scrub_bitmap_test_bit_is_metadata(stripe, sector_nr)) {
 			nr_meta_sectors++;
 		} else {
 			nr_data_sectors++;
@@ -1616,7 +1618,7 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 
 		scrub_bitmap_set_bit_has_extent(stripe, nr_sector);
 		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-			sector->is_metadata = true;
+			scrub_bitmap_set_bit_is_metadata(stripe, nr_sector);
 			sector->generation = extent_gen;
 		}
 	}
@@ -1760,7 +1762,6 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	stripe->state = 0;
 
 	for (int i = 0; i < stripe->nr_sectors; i++) {
-		stripe->sectors[i].is_metadata = false;
 		stripe->sectors[i].csum = NULL;
 		stripe->sectors[i].generation = 0;
 	}
@@ -1902,7 +1903,7 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 	int i;
 
 	for_each_set_bit(i, &error, stripe->nr_sectors) {
-		if (stripe->sectors[i].is_metadata) {
+		if (scrub_bitmap_test_bit_is_metadata(stripe, i)) {
 			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 
 			btrfs_err(fs_info,
-- 
2.49.0



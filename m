Return-Path: <linux-btrfs+bounces-9498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4A9C4F56
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1257B21A41
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7620B1E1;
	Tue, 12 Nov 2024 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fTB58x6q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fTB58x6q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458A20A5F1
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396246; cv=none; b=bnONTEJOHrmY4adKWs0DBDweM46R4OTCaHJ5ElxjCt+333hUZHu3/fNFa0GIE5Q4eQSBNELemt7PAgVO2PKAWzc3vdiEQmOPwG2ibsbuxyrQtg/nb28Ko3OxzEykIbQk/erBl/OL9ki/vlSc/kR7BEor1+UZINlH/Vki3tUUXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396246; c=relaxed/simple;
	bh=kx+HlmCPKgfbR8cl22geKKbwGM14ZEbp7OJHvG9m+fQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKnKO1JFpqthYY12+EWf9ka0HqvMxIjuuqJidVwxiBDHS9xO+P+6tEVSvg2keqjM6mVKNkR3pomA3Crwmf0gV+ocI7h0qJay1E3RA0x2WBHe6qevk+moGe5uma2k5TeawuW5HUEGMVAdAdji43xy8/WJkiLzLPYF17Ptwo7uXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fTB58x6q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fTB58x6q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B06301F45B
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU4EZs+192d9rfwX42tTq2kHAkY5Q1v0LyAgbtFgp00=;
	b=fTB58x6quHp+3ndpbUKeqeD7fR+OYfbDsURy9Gb6uSOgD2ys8BF7KV7kkEsEicZv1cILpq
	QJgOBiliCkdT2uhk+b2ZTqykhRM41bxv/hsSnUYquIk+e49MoQkG0EzYjLTF/sjczl/M6A
	5BcMQsZ5if0rc6PTuX3kYXfcX2Us7gY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU4EZs+192d9rfwX42tTq2kHAkY5Q1v0LyAgbtFgp00=;
	b=fTB58x6quHp+3ndpbUKeqeD7fR+OYfbDsURy9Gb6uSOgD2ys8BF7KV7kkEsEicZv1cILpq
	QJgOBiliCkdT2uhk+b2ZTqykhRM41bxv/hsSnUYquIk+e49MoQkG0EzYjLTF/sjczl/M6A
	5BcMQsZ5if0rc6PTuX3kYXfcX2Us7gY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7AB613721
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCeMKZECM2esdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: cleanup the variables inside btrfs_buffered_write()
Date: Tue, 12 Nov 2024 17:53:36 +1030
Message-ID: <b75937c251d9b9cef35f3aff2fc379e15e2cd107.1731396107.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731396107.git.wqu@suse.com>
References: <cover.1731396107.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

We have too many variables with similar naming, which makes code much
harder to review/refactor. Some examples are:

- @offset and @sector_offset
  The former is the offset_in_page(), the latter is offset inside the
  sector.

- @dirty_sectors and @num_sectors
  The former is more or less common, the number of sectors for the
  copied range.
  Meanwhile the latter is the number of sectors for reserved bytes.

And we are mixing bytes and sectors:

- @dirty_sectors and @copied
  The former is the number of sectors for the block aligned range,
  meanwhile @copied is the unaligned length returned by
  copy_folio_from_iter_atomic()

Fix all those shenanigans by:

- Remove all number-of-sectors variables
  All calculation will now be based on bytes.
  The number-of-sectors calculation will be only done when necessary,
  and in fact there will be no call site requiring such result.

- Remove offset-in-page/offset-in-sector variables
  The offset-in-page result is only utilized once in calculating
  @write_bytes.
  So it can be open-coded.

  The offset-in-sector is utilized to calculate the number-of-sectors,
  which will be done in a more unified way.

- Calculate sector aligned length in-place using round_down() and
  round_up()
  Now for every sector aligned length, we go something like:

  	reserved_bytes = round_up(pos + write_bytes, sectorsize) -
			 round_down(pos, sectorsize);

  So no need for any offset-in-sector helper variable.

This removes the following variables:

- offset
- sector_offset
  All call sites are open-coded or replaced completely.

- dirty_sectors
  Replace by @dirty_bytes.

- num_sectors
  We use @dirty_bytes and @reserve_bytes to calculate which range needs
  to be release.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a0fa8c36a224..5fba2e44c630 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1104,6 +1104,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
 	bool only_release_metadata = false;
+	const u32 sectorsize = fs_info->sectorsize;
 
 	if (nowait)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1123,13 +1124,10 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	pos = iocb->ki_pos;
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
-		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
-		size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset);
+		size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset_in_page(pos));
 		size_t reserve_bytes;
+		size_t dirty_bytes;
 		size_t copied;
-		size_t dirty_sectors;
-		size_t num_sectors;
 		struct folio *folio = NULL;
 		int extents_locked;
 		bool force_page_uptodate = false;
@@ -1148,7 +1146,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		only_release_metadata = false;
-		sector_offset = pos & (fs_info->sectorsize - 1);
 
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
@@ -1178,8 +1175,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			only_release_metadata = true;
 		}
 
-		reserve_bytes = round_up(write_bytes + sector_offset,
-					 fs_info->sectorsize);
+		reserve_bytes = round_up(pos + write_bytes, sectorsize) -
+				round_down(pos, sectorsize);
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
 						      reserve_bytes,
@@ -1244,35 +1241,29 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			}
 		}
 
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
-
-		if (copied == 0) {
+		if (copied == 0)
 			force_page_uptodate = true;
-			dirty_sectors = 0;
-		} else {
+		else
 			force_page_uptodate = false;
-		}
 
-		if (num_sectors > dirty_sectors) {
+		dirty_bytes = round_up(pos + copied, sectorsize) -
+			      round_down(pos, sectorsize);
+
+		if (reserve_bytes > dirty_bytes) {
 			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
 			if (only_release_metadata) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							release_bytes, true);
+						reserve_bytes - dirty_bytes, true);
 			} else {
 				u64 release_start = round_up(pos + copied,
 							     fs_info->sectorsize);
 				btrfs_delalloc_release_space(BTRFS_I(inode),
 						data_reserved, release_start,
-						release_bytes, true);
+						reserve_bytes - dirty_bytes, true);
 			}
 		}
 
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
+		release_bytes = dirty_bytes;
 
 		ret = btrfs_dirty_folio(BTRFS_I(inode), folio, pos, copied,
 					&cached_state, only_release_metadata);
-- 
2.47.0



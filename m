Return-Path: <linux-btrfs+bounces-9406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9464C9C3736
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 04:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AF4B21086
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 03:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C814AD38;
	Mon, 11 Nov 2024 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CF11K91H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PhZjjTPB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545113BAF1
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297574; cv=none; b=LBdTGmf12Rh1ITLkUpeKZTypARDbF2ZpP9ukZwrEU+gILhQbxQK9/3FnRhKbWDw/0KJxchxGvT08fW7+DKhVGhQhaIsKBe796xSKL2FUVJFwxJcLWWFU+gpdjHlierc3F2nRk0AnlhNSgkGW11y+7qVtnq2XdM1lbhSzkyaQVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297574; c=relaxed/simple;
	bh=kx+HlmCPKgfbR8cl22geKKbwGM14ZEbp7OJHvG9m+fQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS/mDom3hpjergkYgiMjmBOJREK8z/uBw3WDhtRvtekrBMxWZvV5TArpM7x8lEYoIf3huRU6nsSNM570CYFO0IWPeJFV4Hqpa76zzgEH8LuwV86X8xtc8QWdYmVYalECA7W/vfGd9i/8Q2UbvzgXwHUbQK1rpIKUnYNEvUv+vrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CF11K91H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PhZjjTPB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E58681F38E
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU4EZs+192d9rfwX42tTq2kHAkY5Q1v0LyAgbtFgp00=;
	b=CF11K91H8vFt540l/A8G4dxyx1nXuCojstkx7ppwfhwdiHOG0yhWfeEGGOZkQ05QXlASD6
	cToh2x2T4OPqunTZjeqs+rOyDvPEujtBvrLamRzXWrRR7G9iAh2sfIo0yz0rGOMwIoaxIl
	0zcqn3KWiBIO0kMcA0ztqhjvSOccB2I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PhZjjTPB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU4EZs+192d9rfwX42tTq2kHAkY5Q1v0LyAgbtFgp00=;
	b=PhZjjTPBgcEI1kkqyIT7FW5JyGoxNifxuwll6LALS/37x1RGD+2HPZQa5f76fAMkpfHSNc
	yeagEyav/6Hy/O38IZAtuj/qKNTFAv2ojiQ9BGcrwYE5TqjQbL1RwQ/qKEaydviTAJTnGn
	veR08Vqih0kWjH5bxp3JjubSRFOt5is=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A8B513967
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4MdSNyGBMWcbJgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: cleanup the variables inside btrfs_buffered_write()
Date: Mon, 11 Nov 2024 14:29:08 +1030
Message-ID: <6f6d6249147e7bb54ed5bd7cc5e67bb00ae042f5.1731297381.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731297381.git.wqu@suse.com>
References: <cover.1731297381.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E58681F38E
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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



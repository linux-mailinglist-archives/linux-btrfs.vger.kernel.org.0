Return-Path: <linux-btrfs+bounces-12673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF355A7556C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4674A7A66E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3851ADC69;
	Sat, 29 Mar 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KpycTckk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KpycTckk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD281A072A
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240016; cv=none; b=ERePYgRTYVdKIp/j7p44FoUZpWzvKgAzfAB5r7iaWEjrgXUJsj68xbpinUlrXl2wfPfhHILJY0hKnzVItpjohM7rBKy6ebCyxTOo5BMlOSDPkgWLCKELvInuJfHBSFbQKga2mCA0KBr8BP4BMjprbPIom49Xs0EWOCgVYmefkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240016; c=relaxed/simple;
	bh=/cEAUNzUxjVKAC6qfX2qMvjRguO+fIM/erloClxg3G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWSzoG6/y8BYg5ahPuIZz/SGsgA8qWTcapONm2XAotxXA7nhqpnbggxPMF2PIeJmZHjMgVTXwpb6XGthrHsRtICeX5NcjA3jRGtwGpIBk9eFBhCRooc5B58GlSkqR0ryO/pZA0MEcvnJuheRLYnIPAKlB+mGZUgpL2OdQCNQ8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KpycTckk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KpycTckk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98B7F1F452;
	Sat, 29 Mar 2025 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jcp5Q3bGlZ+KXOXXXGOGIvCDhPEDsdSyeMBP5sqRsAo=;
	b=KpycTckkuRBboefjbvze3swgOPjY14NEv6teZHG1PvhP/bWy4PPWXQRk03meMhP1ElTlNG
	jQpcMhJ5QzxN8kLtA4dr9LlvdjDbgWGaLiUM7PrEXqjPdaTAk0n2zQ0M14Us/gzxyBYXtH
	DmESDojzE+biCWweZy2VUtbaP5Tp0g4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jcp5Q3bGlZ+KXOXXXGOGIvCDhPEDsdSyeMBP5sqRsAo=;
	b=KpycTckkuRBboefjbvze3swgOPjY14NEv6teZHG1PvhP/bWy4PPWXQRk03meMhP1ElTlNG
	jQpcMhJ5QzxN8kLtA4dr9LlvdjDbgWGaLiUM7PrEXqjPdaTAk0n2zQ0M14Us/gzxyBYXtH
	DmESDojzE+biCWweZy2VUtbaP5Tp0g4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94EB113A41;
	Sat, 29 Mar 2025 09:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDKnFUe752cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 29 Mar 2025 09:20:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/5] btrfs: prepare btrfs_buffered_write() for large data folios
Date: Sat, 29 Mar 2025 19:49:39 +1030
Message-ID: <0bd85e2645ad3fbc0fa64649bfe0befc9f732071.1743239672.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743239672.git.wqu@suse.com>
References: <cover.1743239672.git.wqu@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This involves the following modifications:

- Set the order flags for __filemap_get_folio() inside
  prepare_one_folio()

  This will allow __filemap_get_folio() to create a large folio if the
  address space supports it.

- Limit the initial @write_bytes inside copy_one_range()
  If the largest folio boundary splits the initial write range, there is
  no way we can write beyond the largest folio boundary.

  This is done by a simple helper function, calc_write_bytes().

- Release exceeding reserved space if the folio is smaller than expected
  Which is doing the same handling when short copy happened.

All these preparations should not change the behavior when the largest
folio order is 0.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e421b64f7038..a7afc55bab2a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -861,7 +861,8 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 {
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
-	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN);
+	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN) |
+			  fgf_set_order(write_bytes);
 	struct folio *folio;
 	int ret = 0;
 
@@ -1168,6 +1169,16 @@ static void shrink_reserved_space(struct btrfs_inode *inode,
 					     reserved_start + new_len, diff, true);
 }
 
+/* Calculate the maximum amount of bytes we can write into one folio. */
+static size_t calc_write_bytes(const struct btrfs_inode *inode,
+			       const struct iov_iter *iter, u64 start)
+{
+	const size_t max_folio_size = mapping_max_folio_size(inode->vfs_inode.i_mapping);
+
+	return min(max_folio_size - (start & (max_folio_size - 1)),
+		   iov_iter_count(iter));
+}
+
 /*
  * Do the heavy-lifting work to copy one range into one folio of the page cache.
  *
@@ -1181,7 +1192,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
-	size_t write_bytes = min(iov_iter_count(iter), PAGE_SIZE - offset_in_page(start));
+	size_t write_bytes = calc_write_bytes(inode, iter, start);
 	size_t copied;
 	const u64 reserved_start = round_down(start, fs_info->sectorsize);
 	u64 reserved_len;
@@ -1226,9 +1237,25 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 			      only_release_metadata);
 		return ret;
 	}
+
+	/*
+	 * The reserved range goes beyond the current folio, shrink the reserved
+	 * space to the folio boundary.
+	 */
+	if (reserved_start + reserved_len > folio_pos(folio) + folio_size(folio)) {
+		const u64 last_block = folio_pos(folio) + folio_size(folio);
+
+		shrink_reserved_space(inode, *data_reserved, reserved_start,
+				      reserved_len, last_block - reserved_start,
+				      only_release_metadata);
+		write_bytes = last_block - start;
+		reserved_len = last_block - reserved_start;
+	}
+
 	extents_locked = lock_and_cleanup_extent_if_need(inode, folio, start,
 							 write_bytes, &lockstart,
-							 &lockend, nowait, &cached_state);
+							 &lockend, nowait,
+							 &cached_state);
 	if (extents_locked < 0) {
 		if (!nowait && extents_locked == -EAGAIN)
 			goto again;
-- 
2.49.0



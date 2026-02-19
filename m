Return-Path: <linux-btrfs+bounces-21794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDjCKGqgl2nc3AIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21794-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 00:44:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE92163A22
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 00:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D3583010691
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189431A813;
	Thu, 19 Feb 2026 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RtlXY+qn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PimUqwnX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237B2E6CAB
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544625; cv=none; b=oRQ2Jk3T/kyApM5wSmfrk1CWm6QnwHbhV6Gbvl52flpr6vGZI4WBr5NeYxrJ63pnQ/dCygL4VFcqnFmygW2Z+XNKRkOYXyYDjwHuovTtZtqHJJFeIUbA+bW3v1gIVu5eMb124b57mTBIYxUIYSe0lq6xm6T83t067UhwAONHOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544625; c=relaxed/simple;
	bh=/Czfk6wnbMKM4WSHCY/tfQaSzs+k6gY/YqjaHdxKQxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m0khiBR3eWo8f7PCinMe+UyfvXgpGnk8pS+ztDrvUJSAP+nHmGz2DuyKiVGPaRjLcme4puYnYXQHu4Qk7sFyQm/MSLs0urtgR9KzKkX+uP3yCZ6nFLnAIoEKlWmDdgCYjTZyctIqdPxUEkqv/RNozWQ61fOmasZdcPkupPdBF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RtlXY+qn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PimUqwnX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C95A75BD14
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771544622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FrHqXiibia5NIhTZBaIOKiUeOjBs0gJ05qMDwoOlf+Y=;
	b=RtlXY+qnj+N4hEfd6bnpafIUFSpMSjt/TfKmhybIwg7yHSagB1HFNTi/EVV7PT2Sc486QL
	bcYe55E1X53b70JhMxyrV9V388b8Fyd7ipHZhOn0PS9uKVseVjZvvmKEoGFCoDBmUbb7XA
	cfVa5qL/bYCSFgu/VmJIto2OUIc6uVE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PimUqwnX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771544621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FrHqXiibia5NIhTZBaIOKiUeOjBs0gJ05qMDwoOlf+Y=;
	b=PimUqwnX+zDDbOLfPZP4uzWRdXMleL5SOFFge4dxoPS1f/1PwOi2/r5RAz+Dpom0C+xqEY
	47ZEqh/fx/aPejL6FmV5lJCmhkl3lXzWtT5rg9/19rBd0VbMRiLC9pcXJFCqCBWYIwz4vg
	IIgTKOeEmy2THXaWSCMFadKzdmtqo0k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03CC23EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 23:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HYusLSygl2nMJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 23:43:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do compressed bio size roundup and zeroing in one go
Date: Fri, 20 Feb 2026 10:13:38 +1030
Message-ID: <5d98d50379077b98164f3b962ada7b0526e1d4bb.1771544612.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21794-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ECE92163A22
X-Rspamd-Action: no action

Currently we zero out all the remaining bytes of the last folio of
the compressed bio, then round the bio size to fs block boundary.

But that is done in two different functions, zero_last_folio() to zero
the remaining bytes of the last folio, and round_up_last_block() to
round up the bio to fs block boundary.

There are some minor problems:

- zero_last_folio() is zeroing ranges we won't submit
  This is mostly affecting block size < page size cases, where we can
  have a large folio (e.g. 64K), but the fs block size is only 4K.

  In that case, we may only want to submit the first 4K of the folio,
  the remaining range won't matter, but we still zero them all.

  This causes unnecessary CPU usage just to zero out some bytes we won't
  utilized.

- compressed_bio_last_folio() is called twice in two different functions
  Which in theory we only need to call it once.

Enhance the situation by:

- Only zero out bytes up to the fs block boundary
  Thus this will reduce some overhead for bs < ps cases.

- Move the folio_zero_range() call into round_up_last_block()
  So that we can reuse the same folio returned by
  compressed_bio_last_folio().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 471fb08ebff2..07d6c39f4a3f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -842,28 +842,20 @@ static struct folio *compressed_bio_last_folio(struct compressed_bio *cb)
 	return page_folio(phys_to_page(paddr));
 }
 
-static void zero_last_folio(struct compressed_bio *cb)
-{
-	struct bio *bio = &cb->bbio.bio;
-	struct folio *last_folio = compressed_bio_last_folio(cb);
-	const u32 bio_size = bio->bi_iter.bi_size;
-	const u32 foffset = offset_in_folio(last_folio, bio_size);
-
-	folio_zero_range(last_folio, foffset, folio_size(last_folio) - foffset);
-}
-
 static void round_up_last_block(struct compressed_bio *cb, u32 blocksize)
 {
 	struct bio *bio = &cb->bbio.bio;
 	struct folio *last_folio = compressed_bio_last_folio(cb);
 	const u32 bio_size = bio->bi_iter.bi_size;
 	const u32 foffset = offset_in_folio(last_folio, bio_size);
+	const u32 padding_len = round_up(foffset, blocksize) - foffset;
 	bool ret;
 
 	if (IS_ALIGNED(bio_size, blocksize))
 		return;
 
-	ret = bio_add_folio(bio, last_folio, round_up(foffset, blocksize) - foffset, foffset);
+	folio_zero_range(last_folio, foffset, padding_len);
+	ret = bio_add_folio(bio, last_folio, padding_len, foffset);
 	/* The remaining part should be merged thus never fail. */
 	ASSERT(ret);
 }
@@ -888,7 +880,6 @@ static void compress_file_range(struct btrfs_work *work)
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct compressed_bio *cb = NULL;
-	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
 	u64 end = async_chunk->end;
@@ -898,7 +889,6 @@ static void compress_file_range(struct btrfs_work *work)
 	int ret = 0;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
-	unsigned int loff;
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
@@ -981,20 +971,13 @@ static void compress_file_range(struct btrfs_work *work)
 	total_compressed = cb->bbio.bio.bi_iter.bi_size;
 	total_in = cur_len;
 
-	/*
-	 * Zero the tail end of the last folio, as we might be sending it down
-	 * to disk.
-	 */
-	loff = (total_compressed & (min_folio_size - 1));
-	if (loff)
-		zero_last_folio(cb);
-
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
 	 * block size boundary so the allocator does sane things.
 	 */
-	total_compressed = ALIGN(total_compressed, blocksize);
 	round_up_last_block(cb, blocksize);
+	total_compressed = cb->bbio.bio.bi_iter.bi_size;
+	ASSERT(IS_ALIGNED(total_compressed, blocksize));
 
 	/*
 	 * One last check to make sure the compression is really a win, compare
-- 
2.52.0



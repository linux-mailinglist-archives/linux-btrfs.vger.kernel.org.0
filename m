Return-Path: <linux-btrfs+bounces-21093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFQuEVIueGl7oQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21093-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:17:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D41248F7CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E2A308BE6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33452FF679;
	Tue, 27 Jan 2026 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OrpSgRmW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OrpSgRmW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38D187FE4
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483469; cv=none; b=IBkNo1oBpB72MracbFa/QgaQEKjXd3pGOr4kwxzem/i44w0pLfv85TJppg/eAdKU04G1qhysHhTUGNfqCy6zjUp//vXT0LZs/nxzrMkOb2dqvWpApe/kEprSYKiLYNcBqpdujrD+q3nM4Q4bmOc2EFIFActplKFp5lLS+bjJ60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483469; c=relaxed/simple;
	bh=7fXKIHvRE6hvNKx1HQhxsI9/AzNgPgfUUWA7pJckH5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8W8370B6jU7pd/TNOReL8CIMkLUO6wbS2SOaz28AQAzBAbbvgYJKE+tA8XIywsMiMalATMrkm4feau5doT+pOp8tqDTJdQwrAklfD4ToTa3asXzT6d433/EBvdFNQBBJKYkPpvQCsSv47TJrst2IIaLdg0G9sBuHIsECcv4isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OrpSgRmW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OrpSgRmW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83B205BCD9
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkYQApzSMbaoHLT05ATb8Yar74OcIgTVVPJnx3ftSwI=;
	b=OrpSgRmW0Cepqzc/Ae/Slv38gnSjxdB3Hjn6b6m1woHxhvRUkKEt5Qz/h59R1KUIPCe1pi
	XA8F3Cy+viP+NItYpOZ25PyS3DdHRIevxO1rhOV44iZnkRS7z80DmwKQ4pkEbTSoqDkwSw
	w29AIyFco59+LnGPgUSov00X7h7k/NA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OrpSgRmW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkYQApzSMbaoHLT05ATb8Yar74OcIgTVVPJnx3ftSwI=;
	b=OrpSgRmW0Cepqzc/Ae/Slv38gnSjxdB3Hjn6b6m1woHxhvRUkKEt5Qz/h59R1KUIPCe1pi
	XA8F3Cy+viP+NItYpOZ25PyS3DdHRIevxO1rhOV44iZnkRS7z80DmwKQ4pkEbTSoqDkwSw
	w29AIyFco59+LnGPgUSov00X7h7k/NA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7757313712
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOJ/CcgseGnFewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/9] btrfs: introduce zstd_compress_bio() helper
Date: Tue, 27 Jan 2026 13:40:35 +1030
Message-ID: <a6ad07d6acc1f83269c49e8f4fa1486c08263023.1769482298.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769482298.git.wqu@suse.com>
References: <cover.1769482298.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21093-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: D41248F7CA
X-Rspamd-Action: no action

The new helper has the following enhancements against the existing
zstd_compress_folios()

- Much smaller parameter list

  No more shared IN/OUT members, no need to pre-allocate a
  compressed_folios[] array.

  Just a workspace and compressed_bio pointer, everything we need can be
  extracted from that @cb pointer.

- Ready-to-be-submitted compressed bio

  Although the caller still needs to do some common works like
  rounding up and zeroing the tailing part of the last fs block.

Overall the workflow is the same as zstd_compress_folios(), but with
some minor changes:

- @start/@len is now constant
  For the current input file offset, use @start + @tot_in instead.

  The original change of @start and @len makes it pretty hard to know
  what value we're really comparing to.

- No more @cur_len
  It's only utilized when switching input buffer.
  Directly use btrfs_calc_input_length() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.h |   1 +
 fs/btrfs/zstd.c        | 185 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 4b63d7e4a9ad..454c8e0461b4 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -172,6 +172,7 @@ void lzo_free_workspace(struct list_head *ws);
 int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
+int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 7fad1e299c7a..ce204a9300b5 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -585,6 +585,191 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	return ret;
 }
 
+int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
+{
+	struct btrfs_inode *inode = cb->bbio.inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	struct bio *bio = &cb->bbio.bio;
+	zstd_cstream *stream;
+	int ret = 0;
+	struct folio *in_folio = NULL;  /* The current folio to read. */
+	struct folio *out_folio = NULL; /* The current folio to write to. */
+	unsigned long tot_in = 0;
+	unsigned long tot_out = 0;
+	const u64 start = cb->start;
+	const u32 len = cb->len;
+	const u64 end = start + len;
+	const u32 blocksize = fs_info->sectorsize;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
+
+	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
+
+	/* Initialize the stream */
+	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
+			workspace->size);
+	if (unlikely(!stream)) {
+		btrfs_err(fs_info,
+	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
+			  workspace->req_level, btrfs_root_id(inode->root),
+			  btrfs_ino(inode), start);
+		ret = -EIO;
+		goto out;
+	}
+
+	/* map in the first page of input data */
+	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
+	if (ret < 0)
+		goto out;
+	workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_folio(in_folio, start));
+	workspace->in_buf.pos = 0;
+	workspace->in_buf.size = btrfs_calc_input_length(in_folio, end, start);
+
+	/* Allocate and map in the output buffer */
+	out_folio = btrfs_alloc_compr_folio(fs_info);
+	if (out_folio == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	workspace->out_buf.dst = folio_address(out_folio);
+	workspace->out_buf.pos = 0;
+	workspace->out_buf.size = min_folio_size;
+
+	while (1) {
+		size_t ret2;
+
+		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
+				&workspace->in_buf);
+		if (unlikely(zstd_is_error(ret2))) {
+			btrfs_warn(fs_info,
+"zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
+				   workspace->req_level, zstd_get_error_code(ret2),
+				   btrfs_root_id(inode->root), btrfs_ino(inode),
+				   start + tot_in);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Check to see if we are making it bigger */
+		if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
+		    tot_in + workspace->in_buf.pos < tot_out + workspace->out_buf.pos) {
+			ret = -E2BIG;
+			goto out;
+		}
+
+		/* Check if we need more output space */
+		if (workspace->out_buf.pos >= workspace->out_buf.size) {
+			tot_out += min_folio_size;
+			if (tot_out >= len) {
+				ret = -E2BIG;
+				goto out;
+			}
+			/* Queue the current foliot into the bio. */
+			if (!bio_add_folio(bio, out_folio, folio_size(out_folio), 0)) {
+				ret = -E2BIG;
+				goto out;
+			}
+
+			out_folio = btrfs_alloc_compr_folio(fs_info);
+			if (out_folio == NULL) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			workspace->out_buf.dst = folio_address(out_folio);
+			workspace->out_buf.pos = 0;
+			workspace->out_buf.size = min_folio_size;
+		}
+
+		/* We've reached the end of the input */
+		if (tot_in + workspace->in_buf.pos >= len) {
+			tot_in += workspace->in_buf.pos;
+			break;
+		}
+
+		/* Check if we need more input */
+		if (workspace->in_buf.pos >= workspace->in_buf.size) {
+			u64 cur;
+
+			tot_in += workspace->in_buf.size;
+			cur = start + tot_in;
+
+			kunmap_local(workspace->in_buf.src);
+			workspace->in_buf.src = NULL;
+			folio_put(in_folio);
+
+			ret = btrfs_compress_filemap_get_folio(mapping, cur, &in_folio);
+			if (ret < 0)
+				goto out;
+			workspace->in_buf.src = kmap_local_folio(in_folio,
+							 offset_in_folio(in_folio, cur));
+			workspace->in_buf.pos = 0;
+			workspace->in_buf.size = btrfs_calc_input_length(in_folio, end, cur);
+		}
+	}
+	while (1) {
+		size_t ret2;
+
+		ret2 = zstd_end_stream(stream, &workspace->out_buf);
+		if (unlikely(zstd_is_error(ret2))) {
+			btrfs_err(fs_info,
+"zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
+				  workspace->req_level, zstd_get_error_code(ret2),
+				  btrfs_root_id(inode->root), btrfs_ino(inode),
+				  start + tot_in);
+			ret = -EIO;
+			goto out;
+		}
+		/* Queue the remaining part of the output folio into bio. */
+		if (ret2 == 0) {
+			tot_out += workspace->out_buf.pos;
+			if (tot_out >= len) {
+				ret = -E2BIG;
+				goto out;
+			}
+			if (!bio_add_folio(bio, out_folio, workspace->out_buf.pos, 0)) {
+				ret = -E2BIG;
+				goto out;
+			}
+			out_folio = NULL;
+			break;
+		}
+		tot_out += min_folio_size;
+		if (tot_out >= len) {
+			ret = -E2BIG;
+			goto out;
+		}
+		if (!bio_add_folio(bio, out_folio, folio_size(out_folio), 0)) {
+			ret = -E2BIG;
+			goto out;
+		}
+		out_folio = btrfs_alloc_compr_folio(fs_info);
+		if (out_folio == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		workspace->out_buf.dst = folio_address(out_folio);
+		workspace->out_buf.pos = 0;
+		workspace->out_buf.size = min_folio_size;
+	}
+
+	if (tot_out >= tot_in) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	ret = 0;
+	ASSERT(tot_out == bio->bi_iter.bi_size);
+out:
+	if (out_folio)
+		btrfs_free_compr_folio(out_folio);
+	if (workspace->in_buf.src) {
+		kunmap_local(workspace->in_buf.src);
+		folio_put(in_folio);
+	}
+	return ret;
+}
+
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
-- 
2.52.0



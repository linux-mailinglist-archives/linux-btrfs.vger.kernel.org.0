Return-Path: <linux-btrfs+bounces-21211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFAUNvXSemlX+wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21211-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF50AB6B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0777302D5AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16B353EF7;
	Thu, 29 Jan 2026 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ss9sJpXp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ss9sJpXp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C33161A3
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657058; cv=none; b=pfIP+/zukbGkOIlj+6ckfAQgKIkORcSGXxvopJtUUgfKN9X9d3a2DdQrGcsUHh/tmupOoPhGhH641kJRXJ5iXcBV+DF2pQsCDN3LPpsF4NRbPVN17FBLl0n/nLv8V/zMacXow7hQaNY2i0MQE1HNBLaA1KPOIBlu653bqoOZ7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657058; c=relaxed/simple;
	bh=jviVu2/yxSlyS0OsmB9PvuYYmjoXH8mzQCmlHpt3Kxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV8pmG/64tbOivKFew7C+oVmRk6GuU0SVmtHJZuLYZqmhod91XnWZ6TV1UNVnTdkzICgjKWhZINv0hxbPJTBd2hNvBExUyq8q8G4rvHq+ea5v9M501iC4TWSrGXf6jbwZJreIjxIy2TvGC85BNRRU5qYM7hGmaXgXKZuJaYqrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ss9sJpXp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ss9sJpXp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 943D133F07;
	Thu, 29 Jan 2026 03:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peBkY9uJtn16BZ2jb7wuOIAwkThLFao0i4cTUWA1BnQ=;
	b=ss9sJpXpAtQVHSUGsavVfbNDWwVTJRGIGnLwQ6KmeRs21v/kDeIwHbfRn59zJxir2P8F9Y
	nVKO9MvM8SmZqNWQXSM1X88ocOs2xn2hpUhdfKPyVrTIxRlcQ7EdgRMcts44G00UJiztb8
	yBd5qyxbLdvYvmDHXtgXD0pzYrCNShw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peBkY9uJtn16BZ2jb7wuOIAwkThLFao0i4cTUWA1BnQ=;
	b=ss9sJpXpAtQVHSUGsavVfbNDWwVTJRGIGnLwQ6KmeRs21v/kDeIwHbfRn59zJxir2P8F9Y
	nVKO9MvM8SmZqNWQXSM1X88ocOs2xn2hpUhdfKPyVrTIxRlcQ7EdgRMcts44G00UJiztb8
	yBd5qyxbLdvYvmDHXtgXD0pzYrCNShw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3569B3EA61;
	Thu, 29 Jan 2026 03:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qC4DNdjSemk+TgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 29 Jan 2026 03:24:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v5 2/9] btrfs: introduce zstd_compress_bio() helper
Date: Thu, 29 Jan 2026 13:53:39 +1030
Message-ID: <4ff071344ab03deac86668ec82eb9fbb77b3b734.1769656714.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769656714.git.wqu@suse.com>
References: <cover.1769656714.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21211-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email]
X-Rspamd-Queue-Id: 9AF50AB6B8
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

Reviewed-by: Boris Burkov <boris@bur.io>
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



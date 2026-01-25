Return-Path: <linux-btrfs+bounces-21004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA55Fa6hdmmOTAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21004-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:05:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E35983162
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06279306519D
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B503101B6;
	Sun, 25 Jan 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uWXJOd7J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uWXJOd7J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E63115B1
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381367; cv=none; b=X/5KbiZlN5F4aXHjOvQGR9zXYXIW5yoUQps5B45eA/aWC7vrOsZJb3tW4DB+OrUQkeZcZdv1Sgc7CrCv1lEBKwBS9vPVPMg/FBixSZU0/UnzpMbxZ/DShpaC1Z44B1JCttgNnqzB5zJDdHecNYl0ziPYez4myYjyDnlfqVjsjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381367; c=relaxed/simple;
	bh=/CXv3SBH0kI3XaatdnCoBtDuPXRMJIqMd6iqnPCEJP0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5YFVBMaCDxSUx/nlM5sZ+4PRvU8BZMC3BhCfsjalHOyMQxeiRmi0bDQArYjoT1T067vFNvBrKXkKEwtJGjQiqoAcKbnT0urPwcFNIYSf+O9YlcLJymhkNMwQlZiP8U/JVh3ZVqkFi2hNzgqJ6fG1ayuM1Y0TdXUmcm28DVDaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uWXJOd7J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uWXJOd7J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E89A33687
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDvcWRf0c64P240ta7KWfGXTIHK7DwLBXcPo0p1LvHM=;
	b=uWXJOd7JA7vAQ4/K0IkVUChVzk9otwetne53/rpuP4XIFluOElOh/zVyfUt3gAQ/tLG/mi
	s497mnnyrAXbNgfAdAS+zFfefVlaxVSWFGaPI/KT+WMNXE7/T5myykA5xKhga88ADIsA+D
	fmyaOSZqXXc/657n1TZIVf1Xfm2c19w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uWXJOd7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDvcWRf0c64P240ta7KWfGXTIHK7DwLBXcPo0p1LvHM=;
	b=uWXJOd7JA7vAQ4/K0IkVUChVzk9otwetne53/rpuP4XIFluOElOh/zVyfUt3gAQ/tLG/mi
	s497mnnyrAXbNgfAdAS+zFfefVlaxVSWFGaPI/KT+WMNXE7/T5myykA5xKhga88ADIsA+D
	fmyaOSZqXXc/657n1TZIVf1Xfm2c19w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57FD0139E9
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MC5oAuiddmnSTAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: introduce zlib_compress_bio() helper
Date: Mon, 26 Jan 2026 09:18:42 +1030
Message-ID: <d19094883db0b440a1085f2dc4c1b9a2c27f6438.1769381237.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769381237.git.wqu@suse.com>
References: <cover.1769381237.git.wqu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21004-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E35983162
X-Rspamd-Action: no action

The new helper has the following enhancements against the existing
zlib_compress_folios()

- Much smaller parameter list

  No more shared IN/OUT members, no need to pre-allocate a
  compressed_folios[] array.

  Just a workspace and compressed_bio pointer, everything we need can be
  extracted from that @cb pointer.

- Ready-to-be-submitted compressed bio

  Although the caller still needs to do some common works like
  rounding up and zeroing the tailing part of the last fs block.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.h |   1 +
 fs/btrfs/zlib.c        | 193 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 454c8e0461b4..eee4190efa02 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -150,6 +150,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
+int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 6871476e6ebf..dff22cd1147b 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -334,6 +334,199 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	return ret;
 }
 
+int zlib_compress_bio(struct list_head *ws, struct compressed_bio *cb)
+{
+	struct btrfs_inode *inode = cb->bbio.inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	struct bio *bio = &cb->bbio.bio;
+	u64 start = cb->start;
+	u32 len = cb->len;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
+	int ret;
+	char *data_in = NULL;
+	char *cfolio_out;
+	struct folio *in_folio = NULL;
+	struct folio *out_folio = NULL;
+	const u32 blocksize = fs_info->sectorsize;
+	const u64 orig_end = start + len;
+
+	ret = zlib_deflateInit(&workspace->strm, workspace->level);
+	if (unlikely(ret != Z_OK)) {
+		btrfs_err(fs_info,
+	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
+			  ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
+		ret = -EIO;
+		goto out;
+	}
+
+	workspace->strm.total_in = 0;
+	workspace->strm.total_out = 0;
+
+	out_folio = btrfs_alloc_compr_folio(fs_info);
+	if (out_folio == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	cfolio_out = folio_address(out_folio);
+
+	workspace->strm.next_in = workspace->buf;
+	workspace->strm.avail_in = 0;
+	workspace->strm.next_out = cfolio_out;
+	workspace->strm.avail_out = min_folio_size;
+
+	while (workspace->strm.total_in < len) {
+		/*
+		 * Get next input pages and copy the contents to
+		 * the workspace buffer if required.
+		 */
+		if (workspace->strm.avail_in == 0) {
+			unsigned long bytes_left = len - workspace->strm.total_in;
+			unsigned int copy_length = min(bytes_left, workspace->buf_size);
+
+			/*
+			 * For s390 hardware accelerated zlib, and our folio is smaller
+			 * than the copy_length, we need to fill the buffer so that
+			 * we can take full advantage of hardware acceleration.
+			 */
+			if (need_special_buffer(fs_info)) {
+				ret = copy_data_into_buffer(mapping, workspace,
+							    start, copy_length);
+				if (ret < 0)
+					goto out;
+				start += copy_length;
+				workspace->strm.next_in = workspace->buf;
+				workspace->strm.avail_in = copy_length;
+			} else {
+				unsigned int cur_len;
+
+				if (data_in) {
+					kunmap_local(data_in);
+					folio_put(in_folio);
+					data_in = NULL;
+				}
+				ret = btrfs_compress_filemap_get_folio(mapping,
+						start, &in_folio);
+				if (ret < 0)
+					goto out;
+				cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
+				data_in = kmap_local_folio(in_folio,
+							   offset_in_folio(in_folio, start));
+				start += cur_len;
+				workspace->strm.next_in = data_in;
+				workspace->strm.avail_in = cur_len;
+			}
+		}
+
+		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
+		if (unlikely(ret != Z_OK)) {
+			btrfs_warn(fs_info,
+		"zlib compression failed, error %d root %llu inode %llu offset %llu",
+				   ret, btrfs_root_id(inode->root), btrfs_ino(inode),
+				   start);
+			zlib_deflateEnd(&workspace->strm);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* we're making it bigger, give up */
+		if (workspace->strm.total_in > blocksize * 2 &&
+		    workspace->strm.total_in <
+		    workspace->strm.total_out) {
+			ret = -E2BIG;
+			goto out;
+		}
+		if (workspace->strm.total_out >= len) {
+			ret = -E2BIG;
+			goto out;
+		}
+		/* Queue the full folio and allocate a new one. */
+		if (workspace->strm.avail_out == 0) {
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
+			cfolio_out = folio_address(out_folio);
+			workspace->strm.avail_out = min_folio_size;
+			workspace->strm.next_out = cfolio_out;
+		}
+		/* we're all done */
+		if (workspace->strm.total_in >= len)
+			break;
+	}
+	workspace->strm.avail_in = 0;
+	/*
+	 * Call deflate with Z_FINISH flush parameter providing more output
+	 * space but no more input data, until it returns with Z_STREAM_END.
+	 */
+	while (ret != Z_STREAM_END) {
+		ret = zlib_deflate(&workspace->strm, Z_FINISH);
+		if (ret == Z_STREAM_END)
+			break;
+		if (unlikely(ret != Z_OK && ret != Z_BUF_ERROR)) {
+			zlib_deflateEnd(&workspace->strm);
+			ret = -EIO;
+			goto out;
+		} else if (workspace->strm.avail_out == 0) {
+			if (workspace->strm.total_out >= len) {
+				ret = -E2BIG;
+				goto out;
+			}
+			if (!bio_add_folio(bio, out_folio, folio_size(out_folio), 0)) {
+				ret = -E2BIG;
+				goto out;
+			}
+			/* Get another folio for the stream end. */
+			out_folio = btrfs_alloc_compr_folio(fs_info);
+			if (out_folio == NULL) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			cfolio_out = folio_address(out_folio);
+			workspace->strm.avail_out = min_folio_size;
+			workspace->strm.next_out = cfolio_out;
+		}
+	}
+	/* Queue the remaining part of the folio. */
+	if (workspace->strm.total_out > bio->bi_iter.bi_size) {
+		u32 cur_len = offset_in_folio(out_folio, workspace->strm.total_out);
+
+		if (!bio_add_folio(bio, out_folio, cur_len, 0)) {
+			ret = -E2BIG;
+			goto out;
+		}
+	} else {
+		/* The last folio didn't get utilized. */
+		btrfs_free_compr_folio(out_folio);
+	}
+	out_folio = NULL;
+	ASSERT(bio->bi_iter.bi_size == workspace->strm.total_out);
+	zlib_deflateEnd(&workspace->strm);
+
+	if (workspace->strm.total_out >= workspace->strm.total_in) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	ret = 0;
+out:
+	if (out_folio)
+		btrfs_free_compr_folio(out_folio);
+	if (data_in) {
+		kunmap_local(data_in);
+		folio_put(in_folio);
+	}
+
+	return ret;
+}
+
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
-- 
2.52.0



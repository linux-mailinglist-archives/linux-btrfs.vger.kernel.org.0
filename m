Return-Path: <linux-btrfs+bounces-21210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFcHF+7SemlX+wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21210-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C613AB6B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 268223029A49
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CDE34FF57;
	Thu, 29 Jan 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KKNxNn11";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KKNxNn11"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2072BE029
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657056; cv=none; b=P+jvJcPzDiwCkX1xFXBEVOxQaXBZncUOCO5SSCKjUvElP6LxTFVRUjVm8hjQx2cRo2n3Gg8ein0guHA2wdth1AqfF5y2MghNmDdbK8r2NXC/WTeKtLePyaKIjevnc+7C8nMeDwkpEs+UO0arQKWhcgOkTCrYSyh9NVa/5jeRcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657056; c=relaxed/simple;
	bh=a9crxbFpXYDiOYNnZw4QabMxnhs08qlx2vQ2/VUUNgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAVJ4kkMwA4HbPIW9pCXzvq4BX6iRkM4oGl9wSuvvxkOl0QI4jEHzJolWToMcyJ+vEawIaEMMxx+Pklj6C/Y7mi3hNpNKdg+hobr/+iV07bT73xxp0Z6fVtAEJvQwpEU8fgdoYvjJnx7QVEvD9f++LTPTc6Q52AfRK0CKh7djDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KKNxNn11; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KKNxNn11; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 915075BCDC;
	Thu, 29 Jan 2026 03:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6OJZNq/ol0lOjnYUKWBN0hzezyWhHJib1ziImUHyTc=;
	b=KKNxNn11YENp89oIQy4a3SzRlKuROPorzBYBK8bCW/qJ8ntXIO7rrCgb6DFvBh0ccon9uT
	z/f7ar/ogYf6vxrODhxRoRAqBWFZ+um5BhMpyHpOuxK7A2HOJprRZNSUSqX+AfKRlNvKxq
	UCJWM9L1C+MIqbEa6OzPHsGn9qwFUkA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KKNxNn11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6OJZNq/ol0lOjnYUKWBN0hzezyWhHJib1ziImUHyTc=;
	b=KKNxNn11YENp89oIQy4a3SzRlKuROPorzBYBK8bCW/qJ8ntXIO7rrCgb6DFvBh0ccon9uT
	z/f7ar/ogYf6vxrODhxRoRAqBWFZ+um5BhMpyHpOuxK7A2HOJprRZNSUSqX+AfKRlNvKxq
	UCJWM9L1C+MIqbEa6OzPHsGn9qwFUkA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 314AC3EA61;
	Thu, 29 Jan 2026 03:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNjsM9rSemk+TgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 29 Jan 2026 03:24:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v5 3/9] btrfs: introduce zlib_compress_bio() helper
Date: Thu, 29 Jan 2026 13:53:40 +1030
Message-ID: <880dd56d55dbf78fbdd60d52e9f5c7d4cfedaf54.1769656714.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-21210-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid,bur.io:email]
X-Rspamd-Queue-Id: 1C613AB6B1
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

Reviewed-by: Boris Burkov <boris@bur.io>
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
index a004aa4ee9e2..6f2a43f06b5c 100644
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



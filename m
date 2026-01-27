Return-Path: <linux-btrfs+bounces-21100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPIuCyYteGl7oQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21100-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:12:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EE8F739
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17AA03016884
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664802FE075;
	Tue, 27 Jan 2026 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cCF6BBSB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cCF6BBSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACE2FD698
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483490; cv=none; b=sBtwz6OLGPoT6M32N0XtE/gwqmiP8HvzEZQviwI3rk3UwhjVlH5fDSZunokTmajtBCoW4yWPwffx++uJXGrfKCld4JfwTga1P1mW9eu6YxnWKUqS38tvMTsf95LaAWIBBBdzrnR9n/2slsuYEOtU/qVytkXE2rVl0i93NpRi6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483490; c=relaxed/simple;
	bh=EXYc+e8UKNeR8mb60u7hFCt4UiDoLux60JdRjTIi3RI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9tV90G2kh5t+EP6mmQdJ5WePZfwAZFMrhdtbZN6OmI1Pzu8LvN/pcl4tKkeE7h8chBO3fke+WaYykgySvPiBpclgLtZR2FBcEv76C+vIhfE1bMmllS08aSB+25qlWeGsAmNHT35sNn9T7N9rwTJOKBTQEnkcYAXzfsBtS39yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cCF6BBSB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cCF6BBSB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC8493376C
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR/LaaGQoLbWyYnDEcskMfIT/skymxb8BjihgIc73hY=;
	b=cCF6BBSBzPRl1lrk+WZVGEEUL5oxrl4tOvE7iURM4I/PGM0TF8kAlr8NuxH0r4faWnlz7l
	Mf+KdglEYCZBDhT14YB4hB7KwD7wNxVG6JUel6jsxpcQ11yuFdohRlJ+MvHFmwPN9oBBts
	SXysSMOm7jn88OG21ri9ZIZ2icEZDyI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cCF6BBSB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR/LaaGQoLbWyYnDEcskMfIT/skymxb8BjihgIc73hY=;
	b=cCF6BBSBzPRl1lrk+WZVGEEUL5oxrl4tOvE7iURM4I/PGM0TF8kAlr8NuxH0r4faWnlz7l
	Mf+KdglEYCZBDhT14YB4hB7KwD7wNxVG6JUel6jsxpcQ11yuFdohRlJ+MvHFmwPN9oBBts
	SXysSMOm7jn88OG21ri9ZIZ2icEZDyI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0CD813712
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2HBpG8sseGnFewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/9] btrfs: introduce btrfs_compress_bio() helper
Date: Tue, 27 Jan 2026 13:40:37 +1030
Message-ID: <2aea63da96f7bc16101682c922ff2309bccbf85f.1769482298.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21100-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: C11EE8F739
X-Rspamd-Action: no action

The helper will allocate a new compressed_bio, do the compression, and
return it to the caller.

This greatly simplifies the compression path, as we no longer need to
allocate a folio array thus no extra error path, furthermore the
compressed bio structure can be utilized for submission with very minor
modifications (like rounding up the bi_size and populate the bi_sector).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/compression.h | 13 ++++++++
 2 files changed, 81 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4c6298cf01b2..942b85bcacbe 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1064,6 +1064,74 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
 	return ret;
 }
 
+/*
+ * Given an address space and start and length, compress the page cache
+ * contents into @cb.
+ *
+ * @type_level is encoded algorithm and level, where level 0 means whatever
+ * default the algorithm chooses and is opaque here;
+ * - compression algo are 0-3
+ * - the level are bits 4-7
+ *
+ * @cb->bbio.bio.bi_iter.bi_size will indicate the compressed data size.
+ * The bi_size may not be sectorsize aligned, thus the caller still need
+ * to do the round up before submission.
+ *
+ * This function will allocate compressed folios with btrfs_alloc_compr_folio(),
+ * thus callers must make sure the endio function and error handling are using
+ * btrfs_free_compr_folio() to release those folios.
+ * This is already done in end_bbio_compressed_write() and cleanup_compressed_bio().
+ */
+struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
+					  u64 start, u32 len, unsigned int type,
+					  int level, blk_opf_t write_flags)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct list_head *workspace;
+	struct compressed_bio *cb;
+	int ret;
+
+	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE | write_flags,
+				  end_bbio_compressed_write);
+	cb->start = start;
+	cb->len = len;
+	cb->writeback = true;
+	cb->compress_type = type;
+
+	level = btrfs_compress_set_level(type, level);
+	workspace = get_workspace(fs_info, type, level);
+	switch (type) {
+	case BTRFS_COMPRESS_ZLIB:
+		ret = zlib_compress_bio(workspace, cb);
+		break;
+	case BTRFS_COMPRESS_LZO:
+		ret = lzo_compress_bio(workspace, cb);
+		break;
+	case BTRFS_COMPRESS_ZSTD:
+		ret = zstd_compress_bio(workspace, cb);
+		break;
+	case BTRFS_COMPRESS_NONE:
+	default:
+		/*
+		 * This can happen when compression races with remount setting
+		 * it to 'no compress', while caller doesn't call
+		 * inode_need_compress() to check if we really need to
+		 * compress.
+		 *
+		 * Not a big deal, just need to inform caller that we
+		 * haven't allocated any pages yet.
+		 */
+		ret = -E2BIG;
+	}
+
+	put_workspace(fs_info, type, workspace);
+	if (ret < 0) {
+		cleanup_compressed_bio(cb);
+		return ERR_PTR(ret);
+	}
+	return cb;
+}
+
 static int btrfs_decompress_bio(struct compressed_bio *cb)
 {
 	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index eee4190efa02..fd0cce5d07cf 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -146,6 +146,19 @@ int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end);
 
 int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 				     struct folio **in_folio_ret);
+struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
+					  u64 start, u32 len, unsigned int type,
+					  int level, blk_opf_t write_flags);
+
+static inline void cleanup_compressed_bio(struct compressed_bio *cb)
+{
+	struct bio *bio = &cb->bbio.bio;
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio)
+		btrfs_free_compr_folio(fi.folio);
+	bio_put(bio);
+}
 
 int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
-- 
2.52.0



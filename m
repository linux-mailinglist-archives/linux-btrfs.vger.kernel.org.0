Return-Path: <linux-btrfs+bounces-21213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOF+H/zSemlX+wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21213-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5DAB6C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2230A3007AC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8D3542CB;
	Thu, 29 Jan 2026 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nW9a7b3p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nW9a7b3p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F73161A3
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657065; cv=none; b=XZmFmGfkC9FRJzD1ekcIpjoNkPLDvdZpsWIfPMZOJ7d1tAe4fC11DJH1MW/HXcO+pH06KIttG26NJA0LwBA2Jvz9WTcQyZiCWiMXIqKDus3hFcvJViG5QVKd70OY06kZcpm+fyFRJPaLFPlqZx3lAVD2ms4Ou5yOjzi93r7PleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657065; c=relaxed/simple;
	bh=dXYOISGaMfNxHqsvEe1p7m4M1Hg6Kv/7wbvVQSm5zk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhtc2sorVUac+pdYkAFczBamL9ZkIzK4MvzDP3eSTDYLWYvI3ph5zNM2UJWt2cPX1H2GQfonIzKq4Fl4m4vMGZYETdIpn3Qe5FdAKvapBS4paXxc4znXgHzBgcdhQFqlNqlqLSUeB0dwBTcFgyRQDO6/MWF/xPQ+BcqaLO39Lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nW9a7b3p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nW9a7b3p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B4FF33F05;
	Thu, 29 Jan 2026 03:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6mjkmAvVfEwMrz4bYzLaowmBzskCrAIdk/VrJJdHls=;
	b=nW9a7b3ptKEwcHFXrWA730F4de6kA1ayc9WmpmHstMy0FFOAUnYvjuy0+SP6yT2kHdG5WU
	b6NF35rsQKJRykQSMYGvo7r7LoN2eNElqy119GKeCSNrm9a7Mxmxx1CVf9dPHxbUtnQK9k
	y6WmXHL784f4NvKPOx9vY+6iL9L0Q8E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6mjkmAvVfEwMrz4bYzLaowmBzskCrAIdk/VrJJdHls=;
	b=nW9a7b3ptKEwcHFXrWA730F4de6kA1ayc9WmpmHstMy0FFOAUnYvjuy0+SP6yT2kHdG5WU
	b6NF35rsQKJRykQSMYGvo7r7LoN2eNElqy119GKeCSNrm9a7Mxmxx1CVf9dPHxbUtnQK9k
	y6WmXHL784f4NvKPOx9vY+6iL9L0Q8E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E28D3EA61;
	Thu, 29 Jan 2026 03:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KLMtM9zSemk+TgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 29 Jan 2026 03:24:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v5 4/9] btrfs: introduce btrfs_compress_bio() helper
Date: Thu, 29 Jan 2026 13:53:41 +1030
Message-ID: <efe3994c824b1b509e9578ab1fa1b6e7e2795d27.1769656714.git.wqu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21213-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,suse.com:email,suse.com:dkim,suse.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0C5DAB6C6
X-Rspamd-Action: no action

The helper will allocate a new compressed_bio, do the compression, and
return it to the caller.

This greatly simplifies the compression path, as we no longer need to
allocate a folio array thus no extra error path, furthermore the
compressed bio structure can be utilized for submission with very minor
modifications (like rounding up the bi_size and populate the bi_sector).

Reviewed-by: Boris Burkov <boris@bur.io>
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



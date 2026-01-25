Return-Path: <linux-btrfs+bounces-21003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C8GFXefdmmOTAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21003-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 23:55:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBEA82F25
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 23:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70E0304AACF
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE043148DC;
	Sun, 25 Jan 2026 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ccWlMnAf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SBJzt3M5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5D2F3622
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381364; cv=none; b=C9wm8yjEvnKVzj2WLPxeFdRwlqTQh6mzi504w7lzkiKAKfaC+RD0pOdwV9Q/jDe2z/Q6ky5/u2qYSS0eA7GTTg7U257F4PxNkiAn7E151VNSCVkad1ZbKa7XXm695cvW7+b9/n4De73xtEHHvTjXy7K5U2T2Kx+gyqywl5zD8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381364; c=relaxed/simple;
	bh=somHLnwSasGKGAbL8meQ0RjbZUBwQUh10Fv5ZwmUxng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6IjhUFT1UFxdlXsfrqraS24qLV3QGFAFTd3w6jNYEKn2LEjuolOwwDKuKNp2+lNVKdqR1V3RliPB05Dx75HZqWFc+OGbksTkLZ3mNC2c7HR5q1lpZ15IrFMZpyKCyKK8jVEFR283Y8o/FlXBWJ6e0r/mVYzarYgw8b+UYiLxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ccWlMnAf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SBJzt3M5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2DAC5BCCC
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKzCgwph7YDgxmTCpUqLiSMRBOjJmcyr7ZgW0UTHD4I=;
	b=ccWlMnAfjCwKaj+f8geclYqh6amwtLAk/LhTGJYXh8+bha4Yr1rzMhUTLg7yds8XrczEDI
	+811hXxGsM27nlxb0Ghb7sZ0yGRkrfn3HI8ofAYJHkmGtBCBCoi4afEgfsTydWDnGDm27p
	YYxIJBY66VFFHD+MMZOmgyBMzFfa+3Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKzCgwph7YDgxmTCpUqLiSMRBOjJmcyr7ZgW0UTHD4I=;
	b=SBJzt3M5hDcN/sg2Fn1Kb6224QnNlN5KISdIGcFfh9orsCDA2E3OdA85AvohjdD2+g90Ma
	VWT2AC7HFRhmLXELC1uxzf/zo+CqGS5zC042VkyXWF+Kb44ZJS6D6nI+TCCC1lHOMGrIv0
	X8b2PqyhOGUD8o1L7UJc+hb2JwLG3vA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBB99139E9
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Mx4JumddmnSTAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: introduce btrfs_compress_bio() helper
Date: Mon, 26 Jan 2026 09:18:43 +1030
Message-ID: <035ad74b09ad5813268d90bc517d76622d0d8570.1769381237.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21003-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: ADBEA82F25
X-Rspamd-Action: no action

The helper will allocate a new compressed_bio, do the compression, and
return it to the caller.

This greatly simplifies the compression path, as we no longer need to
allocate a folio array thus no extra error path, furthermore the
compressed bio structure can be utilized for submission with very minor
modifications (like rounding up the bi_size and populate the bi_sector).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/compression.h | 13 +++++++++
 2 files changed, 76 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4323d4172c7b..56f8a3f31fbd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1064,6 +1064,69 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
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
index eee4190efa02..49cf0f5421e6 100644
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
+		folio_put(fi.folio);
+	bio_put(bio);
+}
 
 int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
-- 
2.52.0



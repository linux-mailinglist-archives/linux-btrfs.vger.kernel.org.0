Return-Path: <linux-btrfs+bounces-22281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFpoBVsArmnF+gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22281-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3C2329A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92C1301F1B4
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 23:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFA34B663;
	Sun,  8 Mar 2026 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LoxuCApv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LoxuCApv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DBE55A
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011010; cv=none; b=lvyg6fiBnSfC+p8z1jOYOxHMzK0Q8Ke2t7cjbuQsV5R18ZtCPS+XsJu9Iw7ZdbSSfpYtU8z5CdnxgV9M6KTmqE9onEVAdjy4w4/wpyCzL0WAaXIH7T/ya8Bet/efUp7biuJDnRB9qYgISMLD1huOuAikCzM1bRO65piURcjQg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011010; c=relaxed/simple;
	bh=ywCZ71VyCaZskbR/65N9L4hb9ftIdt069vSvFLUJavA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvpJt7UPlAzdM28eSDGT8yVzx7/tThN74spI6oPmmEfw9dlU6MSH83QJPvGStGbswCSm6fVRBcBciYuPslblzIgR7ob7lcI/ueh59HvQUhzFV6s1He2UFsYpB65Uu/48h88/vRiKBEHwBtCyss8wc2CGyy32+X8rdTzKLwKwjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LoxuCApv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LoxuCApv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F56D4D1D9
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773011003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9cv1zXjhH4xqiPEVNPB4cfCz4A5GFecboduxoqa3oc=;
	b=LoxuCApvEfwFYWjcwswVfE7+fiXMOcHXWdzX7FppzrRjXQLJgr2KpEEsUVp9o2LAIGNmW4
	/r5j3nZvAUqLi0i3Dh+0zoJweuGF9xZ/pxQUgMpTPk6IdULNC2E2GL/EazIkZxgrTLxVuq
	Jrr5z8wXTXktHiSed9QwQmuV8cMlp8w=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773011003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9cv1zXjhH4xqiPEVNPB4cfCz4A5GFecboduxoqa3oc=;
	b=LoxuCApvEfwFYWjcwswVfE7+fiXMOcHXWdzX7FppzrRjXQLJgr2KpEEsUVp9o2LAIGNmW4
	/r5j3nZvAUqLi0i3Dh+0zoJweuGF9xZ/pxQUgMpTPk6IdULNC2E2GL/EazIkZxgrTLxVuq
	Jrr5z8wXTXktHiSed9QwQmuV8cMlp8w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C9363EBA8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sAPnDzoArmkNbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 23:03:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 4/6] btrfs: introduce compression for delayed bbio
Date: Mon,  9 Mar 2026 09:32:53 +1030
Message-ID: <7dcba74a7d7d5a50f2ca5f246f518f9199d7ce84.1773009120.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773009120.git.wqu@suse.com>
References: <cover.1773009120.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: A8F3C2329A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22281-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

The compressed write path inside a delayed bbio is mostly the same as
regular compression, but with some differences:

- The error handling should not touch folio flags
  It will be handled by the parent delayed bbio.

- A successful compression will lead to a child compressed bio
  That compressed bio will be properly submitted, and if there is no
  more pending ios of the delayed bbio, end the delayed bbio.

- No sequential execution of data extent reservation
  The existing async thread is some quirk related to the ordered
  function execution, which is not suitable for this call site.

  After the compressed bio is submitted, we can no longer touch the
  child compressed bio (it can finished immediately and also finish the
  parent delayed bbio).
  Meanwhile the async ordered function needs different entries to handle
  the workload and free involved structures.

  This will be the major changes compared to the existing compressed
  write.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bee38419fe0f..d9a12d857a93 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7653,6 +7653,111 @@ struct extent_map *btrfs_create_delayed_em(struct btrfs_inode *inode,
 	return em;
 }
 
+static void end_bbio_delayed_compressed(struct btrfs_bio *bbio)
+{
+	struct delayed_bio_private *dbp = bbio->private;
+	struct btrfs_bio *parent = dbp->delayed_bbio;
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, &bbio->bio)
+		btrfs_free_compr_folio(fi.folio);
+	bio_put(&bbio->bio);
+
+	cmpxchg(&parent->status, BLK_STS_OK, bbio->status);
+	if (atomic_dec_and_test(&dbp->pending_ios))
+		btrfs_bio_end_io(parent, parent->status);
+}
+
+static bool try_submit_compressed(struct btrfs_bio *parent)
+{
+	struct delayed_bio_private *dbp = parent->private;
+	struct btrfs_bio *bbio = dbp->delayed_bbio;
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_key ins;
+	struct compressed_bio *cb;
+	struct extent_state *cached = NULL;
+	struct extent_map *em;
+	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent;
+	u64 alloc_hint;
+	const u32 len = bio_get_size(&bbio->bio);
+	const u64 fileoff = bbio->file_offset;
+	const u64 end = fileoff + len - 1;
+	u32 compressed_size;
+	int compress_type = fs_info->compress_type;
+	int compress_level = fs_info->compress_level;
+	int ret;
+
+	if (!btrfs_inode_can_compress(inode) ||
+	    !inode_need_compress(inode, fileoff, len, false))
+		return false;
+
+	if (inode->defrag_compress > 0 &&
+	    inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
+		compress_type = inode->defrag_compress;
+		compress_level = inode->defrag_compress_level;
+	} else if (inode->prop_compress) {
+		compress_type = inode->prop_compress;
+	}
+	cb = btrfs_compress_bio(inode, fileoff, len, compress_type,
+				compress_level, 0);
+	if (IS_ERR(cb))
+		return false;
+
+	round_up_last_block(cb, fs_info->sectorsize);
+	compressed_size = cb->bbio.bio.bi_iter.bi_size;
+
+	alloc_hint = btrfs_get_extent_allocation_hint(inode, fileoff, len);
+	ret = btrfs_reserve_extent(inode->root, len,
+				   compressed_size, compressed_size,
+				   0, alloc_hint, &ins, true, true);
+	if (ret < 0) {
+		cleanup_compressed_bio(cb);
+		return false;
+	}
+	btrfs_lock_extent(&inode->io_tree, fileoff, end, &cached);
+	file_extent.disk_bytenr = ins.objectid;
+	file_extent.disk_num_bytes = ins.offset;
+	file_extent.ram_bytes = len;
+	file_extent.num_bytes = len;
+	file_extent.offset = 0;
+	file_extent.compression = cb->compress_type;
+
+	cb->bbio.bio.bi_iter.bi_sector = ins.objectid >> SECTOR_SHIFT;
+	em = btrfs_create_io_em(inode, fileoff, &file_extent, BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_free_reserve;
+	}
+	btrfs_free_extent_map(em);
+
+	ordered = btrfs_alloc_ordered_extent(inode, fileoff, &file_extent,
+					     1U << BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(ordered)) {
+		btrfs_drop_extent_map_range(inode, fileoff, end, false);
+		ret = PTR_ERR(ordered);
+		goto out_free_reserve;
+	}
+	cb->bbio.ordered = ordered;
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+	btrfs_unlock_extent(&inode->io_tree, fileoff, end, &cached);
+
+	cb->bbio.end_io = end_bbio_delayed_compressed;
+	cb->bbio.private = dbp;
+	atomic_inc(&dbp->pending_ios);
+	btrfs_submit_bbio(&cb->bbio, 0);
+	return true;
+
+out_free_reserve:
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
+	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
+	btrfs_unlock_extent(&inode->io_tree, fileoff, end, &cached);
+	cleanup_compressed_bio(cb);
+	return false;
+}
+
 static void run_delayed_bbio(struct work_struct *work)
 {
 	struct delayed_bio_private *dbp = container_of(work, struct delayed_bio_private, work);
@@ -7663,8 +7768,13 @@ static void run_delayed_bbio(struct work_struct *work)
 	 * until all child ones are submitted.
 	 */
 	atomic_inc(&dbp->pending_ios);
-	/* Compressed and uncompressed fallback is not yet implemented. */
+	if (try_submit_compressed(parent))
+		goto finish;
+
+	/* Uncompressed fallback is not yet implemented. */
 	ASSERT(0);
+
+finish:
 	if (atomic_dec_and_test(&dbp->pending_ios))
 		btrfs_bio_end_io(parent, parent->status);
 }
-- 
2.53.0



Return-Path: <linux-btrfs+bounces-19688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A25CB80B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39701303B197
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543C30C37E;
	Fri, 12 Dec 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FbZHcsXv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FbZHcsXv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C0299A9E
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521745; cv=none; b=B3hdprFgkTuMB5Xu1LzU9DgrD2hX72mB+2+wkNMMR/CmUCNh9lQXucQzv5tUSVxFdZiE9uLfnvGqy+hfxJTqCxzvy87M/6qVcKfV+na4o2oQicwwOK7e+TifNjIrX5Vsd7uOd61RFJ4q42v77Q2/IcV4BJoyFPKQ7gJX5hqQKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521745; c=relaxed/simple;
	bh=Lo19KCc+yu2GoK/dxCzKTXDCTln/HV0WLwtj2AedRGs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UL8hE3C4Mt725+7csQ1fnZnpwO4YnBRjYn6hhZErC+9inSSLvUa9JfptA/lscLFN73dXmU+10bUOFFfS3QoOSeBCsA7r8lbDA/Sue/PtLQoLRNJlxCBPlwe+XptvZGeXpYoBgFTUSiR+FOwYHFQrID07TQpybuJXo6IvcmS4NBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FbZHcsXv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FbZHcsXv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84A083381F
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765521740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N9VI0NOfXKpFtctfMoVg9TusYMr1o+kOnyG/oR8tRMU=;
	b=FbZHcsXvidN0kvDrOXn8vJ7jzZe791uIkG9ExaAVop07uuLvqL6R8SYzlgmXPe8jnGBAZx
	Q7wQCj8lISZXtz1U43IssGAiCgBf++XvkSLGGXsksapW/vxeos/8Tbyy+6xuOh/DCF0oJI
	HQ2aUqeWMj3/dX5A//xuJ/zvrJ4jYLQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FbZHcsXv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765521740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N9VI0NOfXKpFtctfMoVg9TusYMr1o+kOnyG/oR8tRMU=;
	b=FbZHcsXvidN0kvDrOXn8vJ7jzZe791uIkG9ExaAVop07uuLvqL6R8SYzlgmXPe8jnGBAZx
	Q7wQCj8lISZXtz1U43IssGAiCgBf++XvkSLGGXsksapW/vxeos/8Tbyy+6xuOh/DCF0oJI
	HQ2aUqeWMj3/dX5A//xuJ/zvrJ4jYLQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB5A83EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 06:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VKuwHku5O2lBGwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 06:42:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add an ASSERT() to catch ordered extents with incorrect csums
Date: Fri, 12 Dec 2025 17:12:01 +1030
Message-ID: <7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 84A083381F
X-Spam-Flag: NO
X-Spam-Score: -3.01

Inspired by recent bug fix like 18de34daa7c6 ("btrfs: truncate ordered
extent when skipping writeback past i_size"), and the patch "btrfs: fix
beyond-EOF write handling", if we can catch ordered extents with
incorrect checksums, the above bugs will be caught much easier.

Introduce the following extra checks for an ordered extent at
btrfs_finish_one_ordered(), before inserting an file extent item:

- Skip data reloc inodes first
  A data reloc inode represents a block group during relocation, which
  can have ranges that have csum but some without.
  So we can not easily check them.

- NODATACOW OEs, NODATASUM inodes must have no csums
  NODATACOW implies NODATASUM, and it's pretty obvious that NODATASUM
  inode should not have ordered extents with csums.

- Compressed file extents must have csum covering the on-disk range
  Even if a compressed file extents is truncated, the csum is calculated
  using the on-disk extent, thus the csum must still cover the on-disk
  length.

- Truncated regular file extents must have csum for the truncated length

- The remaining regular file extents must have csum for the whole length

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Updated to check all possible combinations
  Previously version can only detect the OEs in patch "btrfs: fix
  beyond-EOF write handling" where the OE has no csum at all, but can
  not detect OEs that has partial csums.
---
 fs/btrfs/inode.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 461725c8ccd7..050f4027fce7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3090,6 +3090,67 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
 
+static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
+{
+	struct btrfs_ordered_sum *sum;
+	u64 ret = 0;
+
+	list_for_each_entry(sum, &oe->list, list)
+		ret += sum->len;
+	return ret;
+}
+
+#define ASSERT_OE(cond, oe)				\
+	ASSERT(cond,					\
+"root=%lld ino=%llu file_pos=%llu num_bytes=%llu ram_bytes=%llu truncated_len=%lld csum_bytes=%llu disk_bytenr=%llu disk_num_bytes=%llu flags=0x%lx", \
+	       btrfs_root_id((oe)->inode->root),	\
+	       btrfs_ino((oe)->inode),			\
+	       (oe)->file_offset, (oe)->num_bytes,	\
+	       (oe)->ram_bytes, (oe)->truncated_len,	\
+	       oe_csum_bytes(oe),			\
+	       (oe)->disk_bytenr, (oe)->disk_num_bytes, \
+	       (oe)->flags);
+
+static void assert_oe_csums(struct btrfs_ordered_extent *oe)
+{
+	struct btrfs_inode *inode = oe->inode;
+
+	/*
+	 * Skip data reloc inodes. They are for relocation and they
+	 * can have ranges with csum and ranges without.
+	 */
+	if (btrfs_is_data_reloc_root(inode->root))
+		return;
+
+	/*
+	 * There should be no csum for NODATACOW (implies NOCSUM),
+	 * NODATASUM inode.
+	 */
+	if (test_bit(BTRFS_ORDERED_NOCOW, &oe->flags) ||
+	    inode->flags & BTRFS_INODE_NODATASUM) {
+		ASSERT_OE(list_empty(&oe->list), oe);
+		return;
+	}
+	/* For compressed OE, csum must cover the on-disk range. */
+	if (test_bit(BTRFS_ORDERED_COMPRESSED, &oe->flags)) {
+		ASSERT_OE(oe->disk_num_bytes == oe_csum_bytes(oe), oe);
+		return;
+	}
+
+	/* For truncated uncompressed OE, the csum must cover the truncated length. */
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
+		ASSERT_OE(oe->truncated_len == oe_csum_bytes(oe), oe);
+		return;
+	}
+
+	/*
+	 * The remaining case is untruncated regular extents.
+	 *
+	 * The csum must cover the whole range.
+	 */
+	ASSERT_OE(oe->num_bytes == oe_csum_bytes(oe), oe);
+}
+
 /*
  * As ordered data IO finishes, this gets called so we can finish
  * an ordered extent if the range of bytes in the file it covers are
@@ -3170,6 +3231,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	trans->block_rsv = &inode->block_rsv;
 
+	assert_oe_csums(ordered_extent);
+
 	ret = btrfs_insert_raid_extent(trans, ordered_extent);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.52.0



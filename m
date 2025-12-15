Return-Path: <linux-btrfs+bounces-19765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D3CC034C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 00:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB73304E14F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108732ABCE;
	Mon, 15 Dec 2025 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L5D5DoFT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L5D5DoFT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42232937C
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842059; cv=none; b=ldnv2EkujfoFZGXK76m6p2c4VAc0TVl8WkW4cSFD4lBXxklqyg7hafEE5m5A+ylrrqZkV+tE5hKlD5oUuq+qAy1G/UdehIbN9vmm5pArHWo1XAYfN+2De/5gc69mFnj35nB1LNJQYlOarrqaW7qjCGyFBicggJ51iMHkFUoduO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842059; c=relaxed/simple;
	bh=U34WLcFVbkwYEP0VwKDKJ2PqK8Q6xQm35wPoeSWeER0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Huy5FeSqGJbADY/hk+JaVU+GSWiwmWX632+jhahe8zBHV9YRcFv9OORGfUyEQzwt2rJmoppo0X+VVnEbbxMtFwDUwth06jyxOlX5nk9L874P2ABEosVVe1OnsPjIyymKnfdNpSGIuEC0oS4WOAO1jT6W8rAVodXlthzf4AGga/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L5D5DoFT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L5D5DoFT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84AC9336AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 23:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765842053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HdwC6g9aSObP2PJFlZesH8UHcG534pIxFAzRLoPJdCk=;
	b=L5D5DoFTWPUTsRjNSlgAS9bYqzrQci3kx08BQ1KVAOMlLkaioz3r6vQc0ClkC9ane3Qhs3
	wLo+TeBBfGmIoY3tiubMz3P6BdO0+5Wxn5J5iaD3L8nckjW8bLCg1or7fNnhdsnVzfvpIr
	dALwK6Qb6INPNbjQlvYUp0uwSt3UwvU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=L5D5DoFT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765842053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HdwC6g9aSObP2PJFlZesH8UHcG534pIxFAzRLoPJdCk=;
	b=L5D5DoFTWPUTsRjNSlgAS9bYqzrQci3kx08BQ1KVAOMlLkaioz3r6vQc0ClkC9ane3Qhs3
	wLo+TeBBfGmIoY3tiubMz3P6BdO0+5Wxn5J5iaD3L8nckjW8bLCg1or7fNnhdsnVzfvpIr
	dALwK6Qb6INPNbjQlvYUp0uwSt3UwvU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D7F3EA63
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 23:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8hsCHYScQGnIDAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 23:40:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4] btrfs: add an ASSERT() to catch ordered extents missing checksums
Date: Tue, 16 Dec 2025 10:10:30 +1030
Message-ID: <169dd70fb9c36f34aa32cc0894b13c981d9edc83.1765842002.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 84AC9336AB
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Inspired by recent bug fix like 18de34daa7c6 ("btrfs: truncate ordered
extent when skipping writeback past i_size"), and the patch "btrfs: fix
beyond-EOF write handling", if we can catch ordered extents missing
checksums, the above bugs will be caught much easier.

Introduce the following extra checks for an ordered extent at
btrfs_finish_one_ordered(), before inserting an file extent item:

- Skip data reloc inodes first
  A data reloc inode represents a block group during relocation, which
  can have ranges that have checksums but some without.
  So we need to skip them to avoid false alerts.

- NODATACOW ordered extents, NODATASUM inodes must have no checksum
  NODATACOW implies NODATASUM, and it's pretty obvious that NODATASUM
  inodes should not have ordered extents with checksums.

- Compressed file extents must have checksums covering the on-disk range
  Even if a compressed file extents is truncated, the checksums are
  calculated using the on-disk compressed extent, thus the checksums must
  cover the whole on-disk compressed extent.

- Truncated regular file extents must have checksum for the truncated
  length

- The remaining regular file extents must have checksums for the whole
  length

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v4:
- Rewords about the checksum problems
  Instead of "incorrect" checksums, use "missing" checksums to reduce
  confusion

- Constify the ordered extent parameters

- Rename involved functions to use "ordered_extent_" prefix

v3:
- Fix a compiler warning when CONFIG_BTRFS_ASSERT is not selected
  By hiding the oe_csum_bytes() and the main part of assert_oe_csums()
  behind that config.

v2:
- Updated to check all possible combinations
  Previously version can only detect the OEs in patch "btrfs: fix
  beyond-EOF write handling" where the OE has no csum at all, but can
  not detect OEs that has partial csums.
---
 fs/btrfs/inode.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 461725c8ccd7..3df8f174d32c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3090,6 +3090,68 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
 
+#ifdef CONFIG_BTRFS_ASSERT
+static u64 ordered_extent_csum_bytes(const struct btrfs_ordered_extent *oe)
+{
+	struct btrfs_ordered_sum *sum;
+	u64 ret = 0;
+
+	list_for_each_entry(sum, &oe->list, list)
+		ret += sum->len;
+	return ret;
+}
+#endif
+
+#define ASSERT_ORDERED_EXTENT(cond, oe)			\
+	ASSERT(cond,					\
+"root=%lld ino=%llu file_pos=%llu num_bytes=%llu ram_bytes=%llu truncated_len=%lld csum_bytes=%llu disk_bytenr=%llu disk_num_bytes=%llu flags=0x%lx", \
+	       btrfs_root_id((oe)->inode->root),	\
+	       btrfs_ino((oe)->inode),			\
+	       (oe)->file_offset, (oe)->num_bytes,	\
+	       (oe)->ram_bytes, (oe)->truncated_len,	\
+	       ordered_extent_csum_bytes(oe),		\
+	       (oe)->disk_bytenr, (oe)->disk_num_bytes, \
+	       (oe)->flags);
+
+static void assert_ordered_extent_csums(const struct btrfs_ordered_extent *oe)
+{
+#ifdef CONFIG_BTRFS_ASSERT
+	struct btrfs_inode *inode = oe->inode;
+	const u64 csum_bytes = ordered_extent_csum_bytes(oe);
+
+	/*
+	 * Skip data reloc inodes. They are for relocation and they
+	 * can have ranges with csum and ranges without.
+	 */
+	if (btrfs_is_data_reloc_root(inode->root))
+		return;
+
+	if (test_bit(BTRFS_ORDERED_NOCOW, &oe->flags) ||
+	    inode->flags & BTRFS_INODE_NODATASUM) {
+		ASSERT_ORDERED_EXTENT(csum_bytes == 0, oe);
+		return;
+	}
+
+	/* For compressed OE, csums must cover the on-disk range. */
+	if (test_bit(BTRFS_ORDERED_COMPRESSED, &oe->flags)) {
+		ASSERT_ORDERED_EXTENT(oe->disk_num_bytes == csum_bytes, oe);
+		return;
+	}
+
+	/* For truncated uncompressed OE, the csums must cover the truncated length. */
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
+		ASSERT_ORDERED_EXTENT(oe->truncated_len == csum_bytes, oe);
+		return;
+	}
+
+	/*
+	 * The remaining case is untruncated regular extents.
+	 * The csums must cover the whole range.
+	 */
+	ASSERT_ORDERED_EXTENT(oe->num_bytes == csum_bytes, oe);
+#endif
+}
+
 /*
  * As ordered data IO finishes, this gets called so we can finish
  * an ordered extent if the range of bytes in the file it covers are
@@ -3170,6 +3232,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	trans->block_rsv = &inode->block_rsv;
 
+	assert_ordered_extent_csums(ordered_extent);
+
 	ret = btrfs_insert_raid_extent(trans, ordered_extent);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.52.0



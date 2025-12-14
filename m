Return-Path: <linux-btrfs+bounces-19722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1BCBBFF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Dec 2025 21:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A4C33005A87
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Dec 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6B4288C30;
	Sun, 14 Dec 2025 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="INLqcTHy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gs8SXW0c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADF1E0083
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765744421; cv=none; b=fF3VVW9+mV7vpyfGZaifC5sy5S/xk+42V8EFrOQuyvFnXoNwaRhdQJUXBmqfJhm7CZd4OKDQvay+2CPKhKR6bznMy31qASPDDW936iqeuHKAZdm3+tHPQ4Bp8z/vkG7ZyNJnnpqiMcmWiUwvWVQGwWH904mLQK30DbuWqGs21Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765744421; c=relaxed/simple;
	bh=d0HgEofboL7N9eHYRsrt1B5mSEdLg3qIwIYUYDizhHA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eEfzkeDGteWiTaJBIKbi4nnZEUYZpieIB04Hp1TYwJZtcqO6CJ4mC4Puyz63xWxOXpfxTUYq41DKQf6Dr6U7LlL/cRmrfkb6TiKxd4PPyQ/2ygbSRiC0jZP3mDBPjoz8+qStEthX7Qzeon1WF2yeagpHb2A4YH4w5V8tagKdb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=INLqcTHy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gs8SXW0c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D289F5BD5E
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765744417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=D7TcDoTfnyat0ddzVWBQcha6SKVeGhOt3sdOL7W/BYM=;
	b=INLqcTHy6/NqDu18UWpbp8S0jn18I2kjtLUzKFuJBBtp9A5HDSiG7u+eKIhePN18iuZ808
	a4K0w4IZK/mhBro1QQt1/GEksY2JJ2su8icjvdShXEvSfQC0SHLferNU6n+V4uJv+igaze
	ihHj+tw7wSlrkFyVEY7No5WF81x1B+A=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gs8SXW0c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765744415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=D7TcDoTfnyat0ddzVWBQcha6SKVeGhOt3sdOL7W/BYM=;
	b=gs8SXW0cKTQkH9MY2y26iWwcvbYld9UlGKLK6RtrDWOTfChB/D/pKz0Y15W3YAEKznL3xn
	8vLtT1fmG+ADoQBIp32PBsUGTwh3pVFpnE01gJqNA+O5H0mCGPv0r3CWdVRncRqUDYsnLe
	S/jRz1lGfnx0pNTy0t6J6lqSBAqRe+U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 175C33EA63
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 20:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9hN3Mh4fP2lSMAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 20:33:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: add an ASSERT() to catch ordered extents with incorrect csums
Date: Mon, 15 Dec 2025 07:03:17 +1030
Message-ID: <b9ce1fd6cf3ef17a4d4b24a71d51792c6979fe68.1765744373.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: D289F5BD5E
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

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
 fs/btrfs/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 461725c8ccd7..28227d43b082 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3090,6 +3090,72 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 					   update_inode_bytes, oe->qgroup_rsv);
 }
 
+#ifdef CONFIG_BTRFS_ASSERT
+static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
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
+#ifdef CONFIG_BTRFS_ASSERT
+	struct btrfs_inode *inode = oe->inode;
+	const u64 csum_bytes = oe_csum_bytes(oe);
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
+		ASSERT_OE(csum_bytes == 0, oe);
+		return;
+	}
+	/* For compressed OE, csum must cover the on-disk range. */
+	if (test_bit(BTRFS_ORDERED_COMPRESSED, &oe->flags)) {
+		ASSERT_OE(oe->disk_num_bytes == csum_bytes, oe);
+		return;
+	}
+
+	/* For truncated uncompressed OE, the csum must cover the truncated length. */
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
+		ASSERT_OE(oe->truncated_len == csum_bytes, oe);
+		return;
+	}
+
+	/*
+	 * The remaining case is untruncated regular extents.
+	 *
+	 * The csum must cover the whole range.
+	 */
+	ASSERT_OE(oe->num_bytes == csum_bytes, oe);
+#endif
+}
+
 /*
  * As ordered data IO finishes, this gets called so we can finish
  * an ordered extent if the range of bytes in the file it covers are
@@ -3170,6 +3236,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	trans->block_rsv = &inode->block_rsv;
 
+	assert_oe_csums(ordered_extent);
+
 	ret = btrfs_insert_raid_extent(trans, ordered_extent);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.52.0



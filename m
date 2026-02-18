Return-Path: <linux-btrfs+bounces-21742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEYAIJSPlWl7SQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21742-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:08:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D74881551BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A18F302E402
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36333C51D;
	Wed, 18 Feb 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QbbPiaHN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QbbPiaHN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2062F3C26
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409188; cv=none; b=uguuCQpaOyA5ZtdEUD8ZQ3oqZ/rTFPD+b+Fs8b7BKvLSNdrD0sns6Jk9vj/vqKKIQKayVcLbv8Hk347O8LDQulDMPljde2SbSL3UJVzv66GKHobu8z6Yueuzy/ZDj9yoZDNaCrdwErD7T7DFC5E2fIJA8DHCyxy+/zCveIryKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409188; c=relaxed/simple;
	bh=KPegXBtp8yLTyG9Ue1zezl0IDvRtjWotKD+5rZ9H63c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwlKn2zvrEuRR+NQR5InI0IoRrMHwCz60OdvwlL+dNuQ4fpwNesfzFl6hik0boYy7GTDOXZ8WrWJbfixB+CN9c2ucSQCp2tvvnNf6/vq++5Dz45lO6YRJ+LecTk79AyPwbcOBQFs+h2BcbPkV7b5ITtjGyjRxMCXJfFjXrte684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QbbPiaHN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QbbPiaHN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91B125BCC8
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771409185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOTbm5YyBNYOdwPNWTY6C4BCpI6MiBFeHtC5b28vjUw=;
	b=QbbPiaHNwbYfCrW5tzHt/lruKiwxRNJMEaCHviLFJUaHxFPYplRQ5ajO0n973VbyPdw/AG
	zE1AaU+bJkZ0W84RFGOWG/7Yrxpbt07yTc4YELNx3BrvqOhyLt+O2C/1YPvjmNOrfvUS7J
	teHBealPRpX9jqADgygXnvLZeZ9K95Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771409185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOTbm5YyBNYOdwPNWTY6C4BCpI6MiBFeHtC5b28vjUw=;
	b=QbbPiaHNwbYfCrW5tzHt/lruKiwxRNJMEaCHviLFJUaHxFPYplRQ5ajO0n973VbyPdw/AG
	zE1AaU+bJkZ0W84RFGOWG/7Yrxpbt07yTc4YELNx3BrvqOhyLt+O2C/1YPvjmNOrfvUS7J
	teHBealPRpX9jqADgygXnvLZeZ9K95Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C76653EA65
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UE9rIiCPlWluDQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: do not touch page cache for encoded writes
Date: Wed, 18 Feb 2026 20:36:02 +1030
Message-ID: <55f2c30ccfcb7fd9b60f54716453c953858992a4.1771409004.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771409004.git.wqu@suse.com>
References: <cover.1771409004.git.wqu@suse.com>
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
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21742-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: D74881551BC
X-Rspamd-Action: no action

[BUG]
When running btrfs/284, the following ASSERT() will be triggered with
64K page size and 4K fs block size:

 assertion failed: folio_test_writeback(folio) :: 0, in subpage.c:476
 ------------[ cut here ]------------
 kernel BUG at subpage.c:476!
 Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
 CPU: 4 UID: 0 PID: 2313 Comm: kworker/u37:2 Tainted: G           OE       6.19.0-rc8-custom+ #185 PREEMPT(voluntary)
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Workqueue: btrfs-endio simple_end_io_work [btrfs]
 pc : btrfs_subpage_clear_writeback+0x148/0x160 [btrfs]
 lr : btrfs_subpage_clear_writeback+0x148/0x160 [btrfs]
 Call trace:
  btrfs_subpage_clear_writeback+0x148/0x160 [btrfs] (P)
  btrfs_folio_clamp_clear_writeback+0xb4/0xd0 [btrfs]
  end_compressed_writeback+0xe0/0x1e0 [btrfs]
  end_bbio_compressed_write+0x1e8/0x218 [btrfs]
  btrfs_bio_end_io+0x108/0x258 [btrfs]
  simple_end_io_work+0x68/0xa8 [btrfs]
  process_one_work+0x168/0x3f0
  worker_thread+0x25c/0x398
  kthread+0x154/0x250
  ret_from_fork+0x10/0x20
 ---[ end trace 0000000000000000 ]---

[CAUSE]
The offending bio is from an encoded write, where the compressed data is
directly written as a data extent, without touching the page cache.

However the encoded write still utilizes the regular buffered write path
for compressed data, by setting the compressed_bio::writeback flag.

When that flag is set, at end_bbio_compressed_write() btrfs will go
clearing the writeback flags of the folio in page cache.

However for bs < ps cases, the subpage helper has one extra check to make
sure the folio has writeback flag set in the first place.

But since it's an encoded write, we never go through page
cache, thus the folio has no writeback flag and triggered the ASSERT().

[FIX]
Do not set compressed_bio::writeback flag for encoded writes, and change
the ASSERT() in btrfs_submit_compressed_write() to make sure that flag
is not set.

Fixes: e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage for encoded writes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 348551ab2c04..64600b6458cb 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -320,7 +320,12 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 
 	ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->sectorsize));
 	ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->sectorsize));
-	ASSERT(cb->writeback);
+	/*
+	 * This flag determines if we should clear writeback flags
+	 * from page cache. But this function is only utilized by
+	 * encoded write, it never go through page cache.
+	 */
+	ASSERT(!cb->writeback);
 
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
@@ -346,8 +351,7 @@ struct compressed_bio *btrfs_alloc_compressed_write(struct btrfs_inode *inode,
 	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE, end_bbio_compressed_write);
 	cb->start = start;
 	cb->len = len;
-	cb->writeback = true;
-
+	cb->writeback = false;
 	return cb;
 }
 
-- 
2.52.0



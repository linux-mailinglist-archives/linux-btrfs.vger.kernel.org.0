Return-Path: <linux-btrfs+bounces-14352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B5ACA80C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 03:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA143B6FE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614919CC39;
	Mon,  2 Jun 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JA/W6hnJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JA/W6hnJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53413B293
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824766; cv=none; b=L/3txl0bP6P/zg0yMhDbVweCZnKRI8uBqOQp3mKvs98kvQu6XWldmr5+l17B01KREEZ54wTT0+ojAuudpmBrYmAerElWZktsDkD8uTduHFVuPKJMwkNHONza1IgjWyQ91uAczHUmiVWmX1SCWkqKwlr8VhbYxCBXDRlgwIUC6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824766; c=relaxed/simple;
	bh=ncMSsKU0Wzemc5d5M9PL1ZBWseZNQtWLoLC1WJo4lO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM11H0cU9jAo25oNs1J/BOKfseiMuZcmlIJllVD44WyQlhxD3YHFXYzE+1JN3YdbBGjS7brdz5caBRRb/v6wfDVjBBjDBtf/20jChPWDMZfcM6nwVC9ZL0Sonl6My9/YXsSshwIrZ6DLnqUdefsCUmKL/38/On8onI1gm2MIr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JA/W6hnJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JA/W6hnJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 264A421A05
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 00:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748824757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEzGQHmzkLDan/H5FqvpBCHZ7fQhWVa9OFca9KE0Qew=;
	b=JA/W6hnJm76qXxm4Eee/Zo2lHdyD8PUH1BbTnSa5q+EzVIMBkaAsED+RIMntiBEBhza3ky
	tTTPkQy2KLXwizJST9lfePq5Ibl4mNlyhDD6UAUscX1j/iRAyNMKLVp2KMHlV8N+1T10NZ
	F4JuSznxk54qq1OROJ4y6VmSntK1eEI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748824757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEzGQHmzkLDan/H5FqvpBCHZ7fQhWVa9OFca9KE0Qew=;
	b=JA/W6hnJm76qXxm4Eee/Zo2lHdyD8PUH1BbTnSa5q+EzVIMBkaAsED+RIMntiBEBhza3ky
	tTTPkQy2KLXwizJST9lfePq5Ibl4mNlyhDD6UAUscX1j/iRAyNMKLVp2KMHlV8N+1T10NZ
	F4JuSznxk54qq1OROJ4y6VmSntK1eEI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6262313A63
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 00:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJSBCbTyPGgOdwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 00:39:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add comments on the extra btrfs specific subpage bitmaps
Date: Mon,  2 Jun 2025 10:08:52 +0930
Message-ID: <498a64865fedcc98571092f8479cc5b0b1494cd5.1748824641.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748824641.git.wqu@suse.com>
References: <cover.1748824641.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Unlike the iomap_folio_state structure, the btrfs_subpage structure has a
lot of extra sub-bitmaps, namingly:

- writeback sub-bitmap
- locked sub-bitmap
  iomap_folio_state uses an atomic for writeback tracking, meanwhile has
  no per-block locked tracking.

  This is because iomap always lock a single folio, and submit dirty
  blocks with that folio locked.

  But btrfs has async delalloc ranges (for compression), which are queued
  with their range locked, until the compression is done, then mark the
  involved range writeback and unlocked.

  This means a range can be unlocked and marked writeback at seemingly
  random timing, thus needs the extra tracking.

  This needs a huge rework on the lifespan of async delalloc range
  before we can remove/simplify those two sub-bitmaps.

- ordered sub-bitmap
- checked sub-bitmap
  These are for COW-fixup, but as I mentioned in the past, the COW-fixup
  is not really needed and those two flags are already marked
  deprecated, and will be removed in the near-future after comprehensive
  tests.

Add related comments to indicate we're actively trying to align the
sub-bitmaps to the iomap ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 3042c5ea840a..52546e0e97ce 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -33,8 +33,22 @@ enum {
 	btrfs_bitmap_nr_uptodate = 0,
 	btrfs_bitmap_nr_dirty,
 	btrfs_bitmap_nr_writeback,
+	/*
+	 * The ordered and checked flags are for COW fixup, already marked
+	 * deprecated, and will be removed eventually.
+	 */
 	btrfs_bitmap_nr_ordered,
 	btrfs_bitmap_nr_checked,
+
+	/*
+	 * The locked bit is for async delalloc range (compression), currently
+	 * async extent is queued with the range locked, until the compression
+	 * is done.
+	 * So an async extent can unlock the range at any random timing.
+	 *
+	 * This will need a rework on the async extent lifespan (mark writeback
+	 * and do compression) before deprecating this flag.
+	 */
 	btrfs_bitmap_nr_locked,
 	btrfs_bitmap_nr_max
 };
-- 
2.49.0



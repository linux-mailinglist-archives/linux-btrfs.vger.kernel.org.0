Return-Path: <linux-btrfs+bounces-3030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459A6872A03
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 23:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A771F280C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FA12D206;
	Tue,  5 Mar 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KzlgqNyQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KzlgqNyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134912CDBD
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676970; cv=none; b=L2zXLyPXApRFDP4Q1SFRHh7gMK2cVcxYeoCVZR1hqSjSbbZxwE4hRzmu7ELaBg1axDF8Ir9efzy5p2ibgSQTxc7ZKS6FBQq6+YXlIe/C7S2lgop/6UC7ZA2fFPH30/Zjw0xCY8ylBbRgDfCK2xUg+kQUY4YYEuaJ5pav7uKyJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676970; c=relaxed/simple;
	bh=dFSivGwPTZumWgPFRX13nIj+tcpXjHz0+c6kla+DecM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR0qANGFHzeQPXFXGviDRPFDXgQ2i+2B6ZVDzuadmLi0EhRCS0nX4ggMfI0NMv8zXzQYjjp5Mw3Nmzs2SBtjgnS0ScA/PvU0WsNzgO+Y8OFiPMOWflsqpK+FN7JIekAlPe3Kvbp3FYaMugIeu9+SIimF/hIeTIXZOxdq6N3UEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KzlgqNyQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KzlgqNyQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 738863474F
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709676966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSppW9f/zTwiypyZlwErx44Qr645BryOoJC5Yb/KeO4=;
	b=KzlgqNyQzZWsBnKBZYazimGFbJRucKn7XfWG8sin/sucTDliRCEy2hKfDP0c+5PWe7xKrH
	rQACJZB1KKOPlas8DEcV7eJRwJ8rUtIDsxdSxOSF1UEf1aVUOEn2qJx0s3TWuhIw87U8L+
	ej6noQRs/GmpC2eaFIT29URK7DB32lI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709676966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSppW9f/zTwiypyZlwErx44Qr645BryOoJC5Yb/KeO4=;
	b=KzlgqNyQzZWsBnKBZYazimGFbJRucKn7XfWG8sin/sucTDliRCEy2hKfDP0c+5PWe7xKrH
	rQACJZB1KKOPlas8DEcV7eJRwJ8rUtIDsxdSxOSF1UEf1aVUOEn2qJx0s3TWuhIw87U8L+
	ej6noQRs/GmpC2eaFIT29URK7DB32lI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 75DAD13A5D
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YC6KCqWZ52XsJgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 22:16:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: do not clear page dirty inside extent_write_locked_range()
Date: Wed,  6 Mar 2024 08:45:36 +1030
Message-ID: <58e956200dc2e8c65c6a3fdf0cf05de8d77969ab.1709676577.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709676577.git.wqu@suse.com>
References: <cover.1709676577.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
For subpage + zoned case, btrfs can easily hang with the following
workload, even with previous subpage delalloc rework:

 # mkfs.btrfs -f $dev
 # mount $dev $mnt
 # xfs_io -f -c "pwrite 32k 128k" $mnt/foobar
 # umount $mnt

The system would hang at unmount due to unfinished ordered extents.

Above $dev is a tcmu-runner emulated zoned HDD, which has a max zone
append size of 64K.

[CAUSE]
There is a bug involved in extent_write_locked_range() (well, I'm
already surprised by how many subpage incompatible code are inside that
function):

- If @pages_dirty is true, we will clear the page dirty flag for the
  whole page

  This means, for above case, since the max zone append size is 64K,
  we got an ordered extent sized 64K, resulting the following writeback
  range:

  0      32K        64K       96K       128K    192K    256K
  |      |//////////|/////////|/////////|///////|       |
          \     Write back    /

  |///| = subpage dirty range

  Since we clear the dirty flag for the page at 64K before entering
  __extent_writepage_io(), result the following page flags:

  0      32K        64K       96K       128K    192K    256K
  |      |          |         |         |///////|       |

  Then for the next delalloc range run, we would create ordered extent
  for the range [96K, 192K) and writeback the range.

  But since the whole 2nd page has no dirty flag set, we only submit
  the range [128K, 192K), meanwhile our ordered extent is still in 64K
  size, it would never be properly finished.
  And this also mean, dirty data is not properly submitted for
  writeback, and would cause data corruption.

This bug only affects subpage and zoned case.
For non-subpage and zoned case, find_next_dirty_byte() just return the
whole page no matter if it has dirty flags or not.

For subpage and non-zoned case, we never go into
extent_write_locked_range().

[FIX]
Just do not clear the page dirty at all.
As __extent_writepage_io() would do a more accurate, subpage compatible
clear for page dirty anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fb63055f42f3..bdd0e29ba848 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2290,10 +2290,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
-		if (pages_dirty && page != locked_page) {
+		if (pages_dirty && page != locked_page)
 			ASSERT(PageDirty(page));
-			clear_page_dirty_for_io(page);
-		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
 					    &bio_ctrl, i_size, &nr);
-- 
2.44.0



Return-Path: <linux-btrfs+bounces-18088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CDBF48C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 05:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFAD18C068A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 03:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80F224245;
	Tue, 21 Oct 2025 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bs9GvEO+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SLzan1wh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C618D515
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018728; cv=none; b=iTg5hhgNI4eGwgaDCSkhd+DgcJwRV7wTKJDVj6rF880DuTE8JjJfdSvbbkE9Xfe2WH52iFpiidYxqtk+b/p6hvF41B+kHrSRFb04ZS34CmhqskexrXI5DhJNelfsech9xvPGQijfdRW+Hzmc0vVhbvFxoFuQHEaocgFJ8NdLeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018728; c=relaxed/simple;
	bh=FlNfRvf8ei4Is2XD5KhoYefq+qdn53ugJQnxRc9cR1o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MTPmh7NjnH+dE1+XLH8eb88Q/5rPtPf8lTtS8tDvCB1ACB9VIq9UqT5r9eydUZYd6UfiZ42AeVZmJIfVVgK2tPhpDKBZQklJmhv3XUitS7Qh+x3WeHK2h0VptU2IEjxQg1HHtm2HR4h4dCjJbdWQNk6I7D8VEUJkWSQYip8JWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bs9GvEO+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SLzan1wh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F3A02119B
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 03:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761018717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbHrL5U9iv6/iVq8LH7zmKCKltz1t26udQ3KGD7TmwA=;
	b=Bs9GvEO+MUw9zY3Tpv+VdMfP+CWge/0eScWD3EWXmRtsymJMtjjOUjA+j+WdT0vw34f9rS
	TT6qpsOM66++9tW8/cwirbvFesl4OFSzZ1Yc2uEJE3952/HWEqUg38g+mvPq/jZV0zxoDA
	HZ+dK06l288/8kBGTH2bMUxsGDMl03A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SLzan1wh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761018713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbHrL5U9iv6/iVq8LH7zmKCKltz1t26udQ3KGD7TmwA=;
	b=SLzan1wh/gdul7qLQrjjQ0qPpFNCAtnJ3By+S0EZ4SE1BUbzSNH2/VlYtjSMIjZxNtU6eH
	TLMOJzymROZ+R8veGDyyYx2olJ2CCFM+lPXBRDsGbGB2pimbgq0aEuFISMGexWS+6jgapE
	JS/nyG+e9PXRRDUSiYQmBqd/XhVKxos=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D4F613800
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 03:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qdAYJVcD92ghDAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 03:51:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: subpage: simplify the PAGECACHE_TAG_TOWRITE handling
Date: Tue, 21 Oct 2025 14:21:48 +1030
Message-ID: <377fc6736bba9df49b7bdeeb80f36b17f610eeb2.1761018694.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F3A02119B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

In function btrfs_subpage_set_writeback() we need to keep the
PAGECACHE_TAG_TOWRITE tag if the folio is still dirty.

This is a needed quirk for support async extents, as a subpage range can
almost suddenly go writeback, without touching other subpage ranges in
the same folio.

However we can simplify the handling by replace the open-coded tag
clearing by passing the @keep_write flag depending on if the folio is
dirty.

Since we're holding the subpage lock already, no one is able to change
the dirty/writeback flag, thus it's safe to check the folio dirty before
calling __folio_start_writeback().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 0a4a1ee81e63..80cd27d3267f 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -440,6 +440,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
 	unsigned long flags;
+	bool keep_write;
 
 	spin_lock_irqsave(&bfs->lock, flags);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
@@ -450,18 +451,9 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	 * assume writeback is complete, and exit too early — violating sync
 	 * ordering guarantees.
 	 */
+	keep_write = folio_test_dirty(folio);
 	if (!folio_test_writeback(folio))
-		__folio_start_writeback(folio, true);
-	if (!folio_test_dirty(folio)) {
-		struct address_space *mapping = folio_mapping(folio);
-		XA_STATE(xas, &mapping->i_pages, folio->index);
-		unsigned long xa_flags;
-
-		xas_lock_irqsave(&xas, xa_flags);
-		xas_load(&xas);
-		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
-		xas_unlock_irqrestore(&xas, xa_flags);
-	}
+		__folio_start_writeback(folio, keep_write);
 	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
-- 
2.51.0



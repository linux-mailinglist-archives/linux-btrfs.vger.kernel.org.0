Return-Path: <linux-btrfs+bounces-10828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150BFA0730E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C877D188B11F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40104218E9B;
	Thu,  9 Jan 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BKUZiORz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ohOZeDG2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D821504D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418277; cv=none; b=l2YvwDIhuQ76GKahc5l+i6Wvp5JOiNF2oziwHZ9Nqt+xztVxn7xnBUZoh18561BzrrQOS05kQ3XwPwt8H+8FI6UrKYMuJO7QmaGnJG5vL9Bibtl5k2jvb1lDiKYqjjFgRS2C32L8p14WX7DX32/li0zNJK6X79ehE58r7MrHRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418277; c=relaxed/simple;
	bh=2/h/LDLSiGQ53OOzD4AZX85XuQJcw/P0TvkON2eSYVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeAaiqCRg6ux7fwCZ1Lc3Oxy263GctgUbLFwlahqHJRIe6wcUJnKhfsTE5mhpHa9eajXrYWjGJYxW4uLWqsKBJnykkB2V/0SmoVZxkblGq4ikg8Qb4jV8uPLmZZhixJ2v70u6sn/4jAxChQ0NCeAMm4pRwsRc9b8ST5AbaVEcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BKUZiORz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ohOZeDG2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBCC01F385;
	Thu,  9 Jan 2025 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IxzciT7OWF2Tq2lc0CGo9kv/msUzd96cVBxdfqz5cs=;
	b=BKUZiORzSfjQuQ/WVS/FASfdQbM8212rnnOMVdf03VUsuzTWY/fZMYw24zdia/LXxgYEzS
	40IeIHi5fY9c7jyhzPOOVGO9gGxpav2CMHi/NZBRWjQlh7GEtwvXJ1Kth0foE/N4BxV3xE
	LgsJeqiD86GghdW/Kf+Q7I5vHpJKsXU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ohOZeDG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IxzciT7OWF2Tq2lc0CGo9kv/msUzd96cVBxdfqz5cs=;
	b=ohOZeDG2hxmV+rlLPERD5zXgRzwdiOwCZeumwyZloj/3M8shF16x6v10zE65QF9rbX71Uy
	a94Zxod162zPUQ+MKEqYC7jNM7N7C8rnKSd5K9Sr5jK9Mi4ouXKKHsFeGInLfqtQMQOKFX
	+Wg2zx+9PGeYGceegubcwwM30yQhPqg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4DB0139AB;
	Thu,  9 Jan 2025 10:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 72kLMOGjf2dNEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/18] btrfs: switch grab_extent_buffer() to folios
Date: Thu,  9 Jan 2025 11:24:29 +0100
Message-ID: <cfc1126823c5690264d55a5186bd60381498bd8b.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBCC01F385
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Use the folio API, remove page_folio/folio_page conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2815972f69ec..ad1e54ab665e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2811,13 +2811,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 }
 #endif
 
-static struct extent_buffer *grab_extent_buffer(
-		struct btrfs_fs_info *fs_info, struct page *page)
+static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct extent_buffer *exists;
 
-	lockdep_assert_held(&page->mapping->i_private_lock);
+	lockdep_assert_held(&folio->mapping->i_private_lock);
 
 	/*
 	 * For subpage case, we completely rely on radix tree to ensure we
@@ -2832,7 +2830,7 @@ static struct extent_buffer *grab_extent_buffer(
 		return NULL;
 
 	/*
-	 * We could have already allocated an eb for this page and attached one
+	 * We could have already allocated an eb for this folio and attached one
 	 * so lets see if we can get a ref on the existing eb, and if we can we
 	 * know it's good and we can just return that one, else we know we can
 	 * just overwrite folio private.
@@ -2841,7 +2839,7 @@ static struct extent_buffer *grab_extent_buffer(
 	if (atomic_inc_not_zero(&exists->refs))
 		return exists;
 
-	WARN_ON(PageDirty(page));
+	WARN_ON(folio_test_dirty(folio));
 	folio_detach_private(folio);
 	return NULL;
 }
@@ -2932,8 +2930,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
 
-		existing_eb = grab_extent_buffer(fs_info,
-						 folio_page(existing_folio, 0));
+		existing_eb = grab_extent_buffer(fs_info, existing_folio);
 		if (existing_eb) {
 			/* The extent buffer still exists, we can use it directly. */
 			*found_eb_ret = existing_eb;
-- 
2.47.1



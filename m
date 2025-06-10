Return-Path: <linux-btrfs+bounces-14586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A1AD35EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60263B3354
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCE2900B6;
	Tue, 10 Jun 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MC2a7VQ7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MC2a7VQ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D228F950
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557887; cv=none; b=u9Lkop2qjuxtYNnLPIj0a9REiqnP9ociwlmej4wXRsYNReuZDJnLA5pDvlcKWlzRZO8VbkZ4eW170aooMjOgnEw032DFktpEn0K+t5EQNIM8v/rCV9YMhYbQ/C1ibHPx0ZyzF+L7NqwaO2XrNTcR2eIJ0qG4kH0qI2CVDaSYKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557887; c=relaxed/simple;
	bh=yIMSyJWLBHL0gZ3KrlKvvobRyNuuo+rZTKyHIHhvHDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb7vRHsaf/qZsGFRpqcHeZlXNQ9DvU07eNNMnEBpGQXwtRj7e4rlf7tgGG8nSXpjlEZqIAJdbhXPA/IeywaLuuv4EdhDbt2Wil3fk/v527vXga7Na9fJ8ihvbtO4RNHwi6uKxsskrRH40Hps8offTPIaik3zZ3wrUIuhYSUOifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MC2a7VQ7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MC2a7VQ7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61AE21F7D2;
	Tue, 10 Jun 2025 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vog3Mk5SSupxvmC1HEV5qEotUvxgPR2WG4p8kjOOkfg=;
	b=MC2a7VQ7WhFuYlzIl33+pzowi9nintRwQoHFUZF/+45Pkq5n7qNDTZsUg1N//2pirlCn2L
	GwFKZnguOIC3kPLk22QTXtCsFzAeFmIpOsaziCNxfuuSIeEVSNLgoN+M0eendnMPxh6eZ9
	GtbEpmYaP33tGJIQ7xXxbpUTqR2TYb0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vog3Mk5SSupxvmC1HEV5qEotUvxgPR2WG4p8kjOOkfg=;
	b=MC2a7VQ7WhFuYlzIl33+pzowi9nintRwQoHFUZF/+45Pkq5n7qNDTZsUg1N//2pirlCn2L
	GwFKZnguOIC3kPLk22QTXtCsFzAeFmIpOsaziCNxfuuSIeEVSNLgoN+M0eendnMPxh6eZ9
	GtbEpmYaP33tGJIQ7xXxbpUTqR2TYb0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA27139E2;
	Tue, 10 Jun 2025 12:17:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R0QfFm8iSGi6cgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 10 Jun 2025 12:17:51 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/4] btrfs: rename variables for locked range in defrag_prepare_one_folio()
Date: Tue, 10 Jun 2025 14:17:51 +0200
Message-ID: <2881f8b5dd962b6c635dbad5e6ed67c6cc1bb770.1749557686.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749557686.git.dsterba@suse.com>
References: <cover.1749557686.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

In preparation to use a helper for folio_pos + folio_size, rename the
variables for the locked range so they don't use the 'folio_' prefix. As
the locking ranges take inclusive end of the range (hence the "-1") this
would be confusing as the folio helpers typically use exclusive end of
the range.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 6dca263b224e..faa563ee3000 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -848,8 +848,8 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 {
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
-	u64 folio_start;
-	u64 folio_end;
+	u64 lock_start;
+	u64 lock_end;
 	struct extent_state *cached_state = NULL;
 	struct folio *folio;
 	int ret;
@@ -885,15 +885,15 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 		return ERR_PTR(ret);
 	}
 
-	folio_start = folio_pos(folio);
-	folio_end = folio_pos(folio) + folio_size(folio) - 1;
+	lock_start = folio_pos(folio);
+	lock_end = folio_pos(folio) + folio_size(folio) - 1;
 	/* Wait for any existing ordered extent in the range */
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		btrfs_lock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, folio_start, folio_size(folio));
-		btrfs_unlock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, lock_start, lock_end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, lock_start, folio_size(folio));
+		btrfs_unlock_extent(&inode->io_tree, lock_start, lock_end, &cached_state);
 		if (!ordered)
 			break;
 
-- 
2.47.1



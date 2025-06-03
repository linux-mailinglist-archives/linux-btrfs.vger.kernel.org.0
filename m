Return-Path: <linux-btrfs+bounces-14404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF3ACC206
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 10:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC56A18910BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08964280CEA;
	Tue,  3 Jun 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EDJasW1Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J5OyrJdn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F72C3244
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938604; cv=none; b=N2GjsQtrqrX26S0YeswMgogY8r0lOwE2xc0N6lZbXxCtHl0PbYxw9X6CAFeUl6zaFV4sMfkPERB/pF33ENNaMNfmxNDCv0VIZAxqLqV8TLA33G6+YIGvOR8xbWd9B2MEYq9hkY4QcEiU928tnDnqpktwD6DqFQfV2xV6KAqvWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938604; c=relaxed/simple;
	bh=65WLRNGXPAOZYWT6NRMopGkgWFroSV55nzvuF9G36Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEqNHe9ZbjQjwe1WVYGuUwc6B4+dpM7rg3iPfHFbe9Q+Bu2zKbDDihMayLxpYdXc+fVdbl5lJ5fY0NAjG1/eRz7bXgpHu4eUwNguWuFg8v4vkdT2qVLdXbnuFshXWsmFKa2e8Ivp8sb4rYMiBx5smZpjmDe/+flN5YlNXnkGt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EDJasW1Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J5OyrJdn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C91DB211EF;
	Tue,  3 Jun 2025 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748938594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h66X4YwzqdLj0qmbGl5/sXLP34eAy5Ht5wTWmYRfEns=;
	b=EDJasW1QkU2W5f24FKqct3t3/BMVVwar5Kef/kF6fQ58ixnmXYykYzE4PfCY/PT3vZmPAq
	+IAtbE/wqlLhjCVsbt/hL097t5btA5ldk38ihfCPuQwtAPgFlnIgvPDIVb0jMJJQuztcrb
	5F2e35rOploUofWAPGFHj4n4smHobOE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748938593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h66X4YwzqdLj0qmbGl5/sXLP34eAy5Ht5wTWmYRfEns=;
	b=J5OyrJdn9gil87F/PXVgxUpQzwSyFlkGPJltBAi6FOhOdnG/spO7YEh26bsK7hPTjXyLXx
	4r0ldCTZ3HzcHsbZJX0asOYzuoZ6lLXQDPx4e6oJPlQuo9O4MQDXzDqcsWZnpUfrh7u0Z7
	fhleP5U9ik28W0juGEOCSfi8dUUSF+g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6EC913A92;
	Tue,  3 Jun 2025 08:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aPymLGGvPmihIgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 03 Jun 2025 08:16:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: add helper folio_end()
Date: Tue,  3 Jun 2025 10:16:17 +0200
Message-ID: <bb27f76180bb5bc365b4917310c7bc283ba91c6b.1748938504.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748938504.git.dsterba@suse.com>
References: <cover.1748938504.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

There are several cases of folio_pos + folio_size, add a convenience
helper for that. Rename local variable in defrag_prepare_one_folio() to
avoid name clash.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 8 ++++----
 fs/btrfs/misc.h   | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 6dca263b224e87..e5739835ad02f0 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -849,7 +849,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
 	u64 folio_start;
-	u64 folio_end;
+	u64 folio_last;
 	struct extent_state *cached_state = NULL;
 	struct folio *folio;
 	int ret;
@@ -886,14 +886,14 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	}
 
 	folio_start = folio_pos(folio);
-	folio_end = folio_pos(folio) + folio_size(folio) - 1;
+	folio_last = folio_pos(folio) + folio_size(folio) - 1;
 	/* Wait for any existing ordered extent in the range */
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		btrfs_lock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, folio_start, folio_last, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, folio_start, folio_size(folio));
-		btrfs_unlock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, folio_start, folio_last, &cached_state);
 		if (!ordered)
 			break;
 
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 9cc292402696cc..ff5eac84d819d8 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -7,6 +7,8 @@
 #include <linux/bitmap.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
@@ -158,4 +160,9 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
 	return (found_set == start + nbits);
 }
 
+static inline u64 folio_end(struct folio *folio)
+{
+	return folio_pos(folio) + folio_size(folio);
+}
+
 #endif
-- 
2.49.0



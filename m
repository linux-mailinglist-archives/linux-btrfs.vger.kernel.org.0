Return-Path: <linux-btrfs+bounces-8704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D64996DDC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061DA1C20A8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2119EED7;
	Wed,  9 Oct 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WBRARv7D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WBRARv7D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE371DA3D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484283; cv=none; b=XsAxGJnhTJKDpzHQMiCrqLGUHg4rfW6XNpSArH5hwDj1Tho7nmQf7L/E9RpbOlbDQTQWy6zSSGYwJkDwjsQIWiPzXKGO8l7RAQTxnTaAQHevjkEKqoVF7iYpI5jcZmFA4UAqZuPJru9h1x37B9fPsIu6viLXAMNDAlr2oXhdQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484283; c=relaxed/simple;
	bh=4F1xCBrnn7QLOQm2tOmEimNa5ghZcd8MsI8poQtvaZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs9xfyyl15oYCP6lSsijY3Sivm1olS9Bty3WUkFqZfPg6n3qjZBl7qOjlbtaekY61mQr7/cL6fUTGDc8f8dUTO7NDhQL+g+avnNKCuC/YBIk9cARgkbKdlYLb2Xhcc96G+DeMFACe7ajQycJllluS9u9pBN9+11la8TjIEs1Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WBRARv7D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WBRARv7D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 892711F80B;
	Wed,  9 Oct 2024 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3C1cf8IdxnGwUXbcCRzNP+x33JLnyUm4gQbA5vBIG0c=;
	b=WBRARv7DgxgeLq4rupYjgj1lrVfRmCcaWD5YFw3EM0rchkHADgdaTYoJGwzCkdItaiQkEX
	XweuSvYVSx9Mg7Ma9jfDxngvZ62h4dbUREx1K5q8PZQp8sPyDT/60QQ9yn3t8YNgUHHBgq
	ebSWkEv6ZSRcSb993N0Cip/Mdq51H10=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3C1cf8IdxnGwUXbcCRzNP+x33JLnyUm4gQbA5vBIG0c=;
	b=WBRARv7DgxgeLq4rupYjgj1lrVfRmCcaWD5YFw3EM0rchkHADgdaTYoJGwzCkdItaiQkEX
	XweuSvYVSx9Mg7Ma9jfDxngvZ62h4dbUREx1K5q8PZQp8sPyDT/60QQ9yn3t8YNgUHHBgq
	ebSWkEv6ZSRcSb993N0Cip/Mdq51H10=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 825D7136BA;
	Wed,  9 Oct 2024 14:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DuDQH7aTBmcYRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/25] btrfs: drop unused parameter map from scrub_simple_mirror()
Date: Wed,  9 Oct 2024 16:31:18 +0200
Message-ID: <23a41b79f9113dc3fa136da5a65a903ced95fcf4.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The parameter map used to be passed to scrub_extent() until
e02ee89baa66c4 ("btrfs: scrub: switch scrub_simple_mirror() to
scrub_stripe infrastructure"), where the scrub implementation was
completely reworked.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f21fc6cf07c0..204c928beaf9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2112,7 +2112,6 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
  */
 static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			       struct btrfs_block_group *bg,
-			       struct btrfs_chunk_map *map,
 			       u64 logical_start, u64 logical_length,
 			       struct btrfs_device *device,
 			       u64 physical, int mirror_num)
@@ -2231,7 +2230,7 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
 		 * this stripe.
 		 */
-		ret = scrub_simple_mirror(sctx, bg, map, cur_logical,
+		ret = scrub_simple_mirror(sctx, bg, cur_logical,
 					  BTRFS_STRIPE_LEN, device, cur_physical,
 					  mirror_num);
 		if (ret)
@@ -2315,7 +2314,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * Only @physical and @mirror_num needs to calculated using
 		 * @stripe_index.
 		 */
-		ret = scrub_simple_mirror(sctx, bg, map, bg->start, bg->length,
+		ret = scrub_simple_mirror(sctx, bg, bg->start, bg->length,
 				scrub_dev, map->stripes[stripe_index].physical,
 				stripe_index + 1);
 		offset = 0;
@@ -2370,7 +2369,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * We can reuse scrub_simple_mirror() here, as the repair part
 		 * is still based on @mirror_num.
 		 */
-		ret = scrub_simple_mirror(sctx, bg, map, logical, BTRFS_STRIPE_LEN,
+		ret = scrub_simple_mirror(sctx, bg, logical, BTRFS_STRIPE_LEN,
 					  scrub_dev, physical, 1);
 		if (ret < 0)
 			goto out;
-- 
2.45.0



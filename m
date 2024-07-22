Return-Path: <linux-btrfs+bounces-6635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8006938896
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 07:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79712281467
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F921C280;
	Mon, 22 Jul 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="egbSe73W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="egbSe73W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07021BDDF
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627776; cv=none; b=Au7NxsfVficRMrFpc7wUE0vzZKAof2RAplxkXSUlZU+ZSZV6m3qVb8YauF0TjO6dQ4SeJXWAvEq6xJUktrCALrHPc4NXvD0gCRh87N/CBA9lXUunmsFCWDQnTAtGzNicNAWDaVqZA8CV+OaTo64IS4uTyXHlOqYWDb+hZ5zTwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627776; c=relaxed/simple;
	bh=TkCffIrC70gulDWYYgKzsApowwMpwO2MdfIpaY4agYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo8LO/EsHSPBA7UjoL9Hx8FVoLDaPEAx4/tVj2vRA/Bkwl7dJP2zDhj3Ye8HXFQOJkmlxZM2xezF2aTnv84lwoK23xFfXGy+Ub8b3DP3aAY0+OUDuPG0m6zcaD+xORQqpRboDlZic0H3aG/5aOz33HyM8uVHHNcElYzUZkgz19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=egbSe73W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=egbSe73W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA9F121A47;
	Mon, 22 Jul 2024 05:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721627771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccw9zS1ipFRDv+C+72fOu6WSkCrShq7bqb5rbgB33vQ=;
	b=egbSe73Wq1/g8+M1H+jSKKCEK58f+NlDDthE6SwZGymekAakooODt+hIVppMf0es8f1z92
	7NAAz3yxSdBvn1QPwHD9D52XAgkpjuBuUMt4Mi8R4EgIjOutz9SqkkB2NW4QTQSvoL0w94
	anPUN2XDwJvXu1FyvdQlHFu6P/4ih1Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721627771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccw9zS1ipFRDv+C+72fOu6WSkCrShq7bqb5rbgB33vQ=;
	b=egbSe73Wq1/g8+M1H+jSKKCEK58f+NlDDthE6SwZGymekAakooODt+hIVppMf0es8f1z92
	7NAAz3yxSdBvn1QPwHD9D52XAgkpjuBuUMt4Mi8R4EgIjOutz9SqkkB2NW4QTQSvoL0w94
	anPUN2XDwJvXu1FyvdQlHFu6P/4ih1Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC55138A7;
	Mon, 22 Jul 2024 05:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDFYHXr0nWa+LQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 22 Jul 2024 05:56:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Michel Palleau <michel.palleau@gmail.com>
Subject: [PATCH v2 2/2] btrfs: scrub: update last_physical after scrubing one stripe
Date: Mon, 22 Jul 2024 15:25:49 +0930
Message-ID: <09c3f2adcdba2e5c27577e3fa17fda83a6985303.1721627526.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721627526.git.wqu@suse.com>
References: <cover.1721627526.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.60
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO

Currently sctx->stat.last_physical only got updated in the following
cases:

- When the last stripe of a non-RAID56 chunk is scrubbed
  This implies a pitfall, if the last stripe is at the chunk boundary,
  and we finished the scrub of the whole chunk, we won't update
  last_physical at all until the next chunk.

- When a P/Q stripe of a RAID56 chunk is scrubbed

This leads the following two problems:

- sctx->stat.last_physical is not updated for a almost full chunk
  This is especially bad, affecting scrub resume, as the resume would
  start from last_physical, causing unnecessary re-scrub.

- "btrfs scrub stat" will not report any progress for a long time

Fix the problem by properly updating @last_physical after each stripe is
scrubbed.

And since we're here, for the sake of consistency, use spin lock to
protect the update of @last_physical, just like all the remaining
call sites touching sctx->stat.

Reported-by: Michel Palleau <michel.palleau@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d42a58386415..0f15f5139896 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1876,6 +1876,10 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 		stripe = &sctx->stripes[i];
 
 		wait_scrub_stripe_io(stripe);
+		spin_lock(&sctx->stat_lock);
+		sctx->stat.last_physical = stripe->physical +
+					   stripe_length(stripe);
+		spin_unlock(&sctx->stat_lock);
 		scrub_reset_stripe(stripe);
 	}
 out:
@@ -2144,7 +2148,9 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 					 cur_physical, &found_logical);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
+			spin_lock(&sctx->stat_lock);
 			sctx->stat.last_physical = physical + logical_length;
+			spin_unlock(&sctx->stat_lock);
 			ret = 0;
 			break;
 		}
@@ -2341,6 +2347,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			stripe_logical += chunk_logical;
 			ret = scrub_raid56_parity_stripe(sctx, scrub_dev, bg,
 							 map, stripe_logical);
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.last_physical = min(physical + BTRFS_STRIPE_LEN,
+						       physical_end);
+			spin_unlock(&sctx->stat_lock);
 			if (ret)
 				goto out;
 			goto next;
-- 
2.45.2



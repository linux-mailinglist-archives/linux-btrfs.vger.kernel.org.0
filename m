Return-Path: <linux-btrfs+bounces-3088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33F875D38
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 05:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA01F21F6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14C2E657;
	Fri,  8 Mar 2024 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W13q44kP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W13q44kP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B618E01
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 04:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872820; cv=none; b=F8nJUxWuni6bioQlpJJ9KS1ClMoOoFQHBGovmUhhEkmhP6uL7pnSkWygV/DrX8RA56Z1UM/CnHt1reKgMefN+o0+FhCgn9MrNEv/9CcQe4j8ZZ3KYNVRrhDbIr3RkEVrjogKQ7wOi5RDbp6Hf6ZSz0CLlFoSVLZGXwgMy28UK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872820; c=relaxed/simple;
	bh=RhDVfkt2qjwg2xOjuQuouQJ4YJHQma0UEriBQwqgwz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJxIGslhtscx0I9kXGyc2fizTyA8zdMUOMAbLODv1hEAQSW0CftG7lLjILxtw1gxtOxLMAncqzK3IBvQCYwfLKJr3AJPu16wZoipM51gMpdqAHA9AcTHBUqHgcL9joOMMEM1oK8wUiNbFJxu8GuXJFNGJ+cHkqHKgUYTqlKSge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W13q44kP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W13q44kP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BEAE5FA9B;
	Fri,  8 Mar 2024 03:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709867454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4yaTnIZQ+BFtGuHVTxOAqHvDDLH7BKW9H+4uEbgUAg=;
	b=W13q44kPXcO0cE22O7xqbp14YO/svry5zXn6Rkp18oeSSRdvSLfQvC8ab4eSg4HfyKK+4B
	C4GUdT0E5Mwjsft2QyM79kguo0gyQdufeX/9EgJCjJZSzrofCMBFbVe1YUz6IOr5Xms6Uf
	MKmw/DFlyAVEfryvZn6SuEMD9iwINoM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709867454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4yaTnIZQ+BFtGuHVTxOAqHvDDLH7BKW9H+4uEbgUAg=;
	b=W13q44kPXcO0cE22O7xqbp14YO/svry5zXn6Rkp18oeSSRdvSLfQvC8ab4eSg4HfyKK+4B
	C4GUdT0E5Mwjsft2QyM79kguo0gyQdufeX/9EgJCjJZSzrofCMBFbVe1YUz6IOr5Xms6Uf
	MKmw/DFlyAVEfryvZn6SuEMD9iwINoM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD5D1391D;
	Fri,  8 Mar 2024 03:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0FnmCL2B6mUkcwAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 08 Mar 2024 03:10:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	michel.palleau@gmail.com
Subject: [PATCH 2/2] btrfs: scrub: update last_physical after scrubing one stripe
Date: Fri,  8 Mar 2024 13:40:31 +1030
Message-ID: <d9154e07333df0c719627364b9035f1fa9cf11de.1709867186.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709867186.git.wqu@suse.com>
References: <cover.1709867186.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.80)[99.14%]
X-Spam-Flag: NO

Currently sctx->stat.last_physical only got updated in the following
cases:

- When the last stripe of a non-RAID56 chunk is scrubbed
  This implies a pitfall, if the last stripe is at the chunk boundary,
  and we finished the scrub of the whole chunk, we won't update
  last_physical at all until the next chunk.

- When a P/Q stripe of a RAID56 chunk is scrubbed

This leads makes sctx->stat.last_physical to be not update for a long
time if we're scrubbing a large data chunk (which can go up to 10GiB).

And if scrub is cancelled halfway, we would restart from last_physical,
but that last_physical is only updated to the last finished chunk end,
we would re-scrub the same chunk again.

This can waste a lot of time especially when the chunk is huge.

Fix the problem by properly updating @last_physical after each stripe is
scrubbed.

And since we're here, for the sake of consistency, use spin lock to
protect the update of @last_physical, just like all the remaining
call sites touching sctx->stat.

Reported-by: Michel Palleau <michel.palleau@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8a21214eca35..3bccd171be61 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1872,6 +1872,8 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 		stripe = &sctx->stripes[i];
 
 		wait_scrub_stripe_io(stripe);
+		sctx->stat.last_physical = stripe->physical +
+					   stripe_length(stripe);
 		scrub_reset_stripe(stripe);
 	}
 out:
@@ -2337,6 +2339,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			stripe_logical += chunk_logical;
 			ret = scrub_raid56_parity_stripe(sctx, scrub_dev, bg,
 							 map, stripe_logical);
+			sctx->stat.last_physical = min(physical + BTRFS_STRIPE_LEN,
+						       physical_end);
 			if (ret)
 				goto out;
 			goto next;
-- 
2.44.0



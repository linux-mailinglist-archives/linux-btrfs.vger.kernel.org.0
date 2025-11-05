Return-Path: <linux-btrfs+bounces-18727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 594BEC34F03
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 10:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED2624FCD22
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D4302CAB;
	Wed,  5 Nov 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CAlMv5TC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CAlMv5TC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580F23D2B4
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335886; cv=none; b=i7EfJWVv7HnQ+0RCxH7v6soz6UYX8DrwkXBpx5p9cOnOiJ4TKE2lSMe1H7S4L28xtNPj486RzGGkL4nd+gOdOsTZPCJ+qhsMsyW82FI3BSPqGYH3R5vnoSN5aYwpeJPh34FFMMz7d8q7w5PGWBZzl43qf8fDvR9F7AidhGILHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335886; c=relaxed/simple;
	bh=UWEtbZK38tzw31It7E9LmYq6IItCAwIGlkHZwU2makI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cQ7Udr0JCKQHmLjFBywM8yLLSxTA0goZRK4fw5HTsfj9CmPkaUqG+VYcpx/CeMh4BpyvNmz4Yq2vZ8lX3P350KcgSs3X+kqwVCAjyamJftvV8ix0zz9yi2HX5wlmM3/7pf1Zg3Xi/0uygJKaRygNhQaQsOznC9DqzValLO7FFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CAlMv5TC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CAlMv5TC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 429831F394
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762335882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qMCqbcrdIpuDvD3ptb4XFmW4x+UW664EYjdWaErcxd4=;
	b=CAlMv5TCaDwH12N2WJNSysTYyc9C4Yf+WY3vzj+DCkal3RFccxHL7U5J4WXcXPMyv2tHMe
	qSst6xPJH8fWBS209MdHoskPMcuuKyQ8X2BgOFHzfJ10gcox+l73MdWaiTxtJUnOuwm96Z
	3OhEKvcVI6eVaU2LDbssA0PrSCiLXKk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762335882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qMCqbcrdIpuDvD3ptb4XFmW4x+UW664EYjdWaErcxd4=;
	b=CAlMv5TCaDwH12N2WJNSysTYyc9C4Yf+WY3vzj+DCkal3RFccxHL7U5J4WXcXPMyv2tHMe
	qSst6xPJH8fWBS209MdHoskPMcuuKyQ8X2BgOFHzfJ10gcox+l73MdWaiTxtJUnOuwm96Z
	3OhEKvcVI6eVaU2LDbssA0PrSCiLXKk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 803F2132DD
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UlbfEIkcC2kHKwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 09:44:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make sure extent and csum paths are always released in scrub_raid56_parity_stripe()
Date: Wed,  5 Nov 2025 20:14:23 +1030
Message-ID: <13a62f820aac90e7ba30d31c0825a2a93129c994.1762335836.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Unlike queue_scrub_stripe() which uses the global sctx->extent_path and
sctx->csum_path which are always released at the end of scrub_stripe(),
scrub_raid56_parity_stripe() uses local extent_path and csum_path, as
that function is going to handle the full stripe, whose bytenr may be
smaller than the bytenr in the global sctx paths.

However the cleanup of local extent/csum paths are only happening after
we have successfully submitted an rbio.

There are several error routes that we didn't release those two paths:

- scrub_find_fill_first_stripe() errored out at csum tree search
  In that case extent_path is still valid, and that function itself will
  not release the extent_path passed in.
  And the function returns directly without releasing both paths.

- The full stripe is empty
- Some blocks failed to be recovered
- btrfs_map_block() failed
- raid56_parity_alloc_scrub_rbio() failed
  The function returns directly without releasing both paths.

Fix it by covering btrfs_release_path() calls inside the out: tag.

This is just a hot fix, in the long run we will go scoped based auto
freeing for both local paths.

Fixes: 1009254bf22a3 ("btrfs: scrub: use scrub_stripe to implement RAID56 P/Q scrub")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 92fcd138cd67..b6278406a103 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2288,9 +2288,9 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	bio_put(bio);
 	btrfs_bio_counter_dec(fs_info);
 
+out:
 	btrfs_release_path(&extent_path);
 	btrfs_release_path(&csum_path);
-out:
 	return ret;
 }
 
-- 
2.51.2



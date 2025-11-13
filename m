Return-Path: <linux-btrfs+bounces-18964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C3C5A287
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 22:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B222E3AD736
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17853246E0;
	Thu, 13 Nov 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u0X7G7rc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Me60ZVum"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEB244670
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070024; cv=none; b=hRcDHhtV1RBwgWn1W1HcSOEo1M5co8MV5ZLSBYrEW3Xay6nq5Ch6bRoED9JoPW8S7+9oY9jdGRKLUxSsXUmhwmqThWfXSKbT9ywET9m0SS81g0Jp+kKuM0FmOw6vJUq5buH7pmWViSKq+Bgj8+h6iJr9onMShWWWSdv6vUL+2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070024; c=relaxed/simple;
	bh=gB+fab4Q7hL9SUVPjMeQ7YoNk6Evam5QFDV2sX2JT0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+QR0MzamGj6mrRpIY54Pn6pnPnxfcyuWLgv4S6cvbWSrk2QGltd2BP72/ifCGT0pBEO/ta4UBlzPj0l/dzw+ui6hOst5P2bqaRc5EG7MWO6vHOBxkYBVQ/tpNpOIzhaFnuwzoCC3r0oIR8bcMzMAU43JUy9oPz7evXBkeoEU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u0X7G7rc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Me60ZVum; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D55101F399;
	Thu, 13 Nov 2025 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763070020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l9n4C6ngEezzNepOm3Nz9beKNePtWpc3f3ZCoxzURR4=;
	b=u0X7G7rcBdx7p07QJXRVSYrTw5XTNtW0b7ixR7fSKffoo0HTozzJJfWK4b4EMAsndVaVZP
	aqD6Q0r0NGM5d8qmEwsRbaqBUePeomuOFq6H1SCyb3/I2+y3tBySFgz5E2oM3OPobhPLMp
	TGMfY4N3V3EzUkeWbN5ytIA1vwoCP0Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Me60ZVum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763070018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l9n4C6ngEezzNepOm3Nz9beKNePtWpc3f3ZCoxzURR4=;
	b=Me60ZVumIV486QPjhvjpwjjifBoFF8a5vZzrD9SHwidI1MjJp4ohi9tNHTdf1y3Z8hFxlP
	dNgk5eD4lJ1fxLXqm5/PC/OLHxk5cUK3Zuqln966fRDHLMJrCnWMEBYTKka/RKHUWxvvM6
	3ORDkR/jTT8YGAzOD1f2vmZ5a8h69d8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C91C83EA62;
	Thu, 13 Nov 2025 21:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5g6aIUFQFmnjQAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 13 Nov 2025 21:40:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] btrfs: raid56: fix a out-of-boundary access for sub-page systems
Date: Fri, 14 Nov 2025 08:09:59 +1030
Message-ID: <bbd1a41c70c0f37da9e3e82aa89784e831b0e889.1763069997.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D55101F399
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[BUG]
There is a bug report from IBM that on Power11 the test case btrfs/023
crashed.

The call trace itself is not useful as this particular case is a wild
memory write, which corrupted the SLUB system.

[CAUSE]
Inside index_stripe_sectors() we will update rbio->stripe_paddrs[] array
to reflect the latest stripe_pages[].

We use the physical address of the corresponding page, add an offset
inside the page to represent the sector.

However in patch "btrfs: raid56: remove sector_ptr structure", the
offset is added to the stripe_pages[] array, not the result of
page_to_phys().

This makes the stripe_paddrs[] to be hugely incorrect for subpage
systems.

[FIX]
Fix the calculation by adding the offset after page_to_phys().

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The fix will be folded into the offending patch.
---
 fs/btrfs/raid56.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ad3d5e789158..7cb756ac19ba 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -331,8 +331,8 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 		if (!rbio->stripe_pages[page_index])
 			continue;
 
-		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index] +
-						      offset_in_page(offset));
+		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index]) +
+						      offset_in_page(offset);
 	}
 }
 
-- 
2.51.2



Return-Path: <linux-btrfs+bounces-17864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AEBE16DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D542511D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 04:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630F2192E4;
	Thu, 16 Oct 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ekx0XSNa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ekx0XSNa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A919644B
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589175; cv=none; b=AXKIAKDdry8AfDDiMzQqcm5m0Eb/sBaFVs2AaIspVSqnxZaBsetD5/ap3ukkTbXpZHyvTCKtvZ0yaf/NH3RGKG235/o44g5K6WKJ6Sj63zAUByjUg76mnD7Z++VeoXvnWEM5zEipaT0qA537ZV9f+NH21QTDAs4XV5g/l83ymFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589175; c=relaxed/simple;
	bh=POHT5luMmDX58r+L7uk+ElQvsTkKQELXlbBZCyxWdJU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrbMBy2ERrUlHIgdyLyNnVbIkBKjxN3e3HzLvG46aMrkcdduv7XA1ttFEH/rFt29k52Kj0hb6ZdQdz6ZDSJSaTfxHxpKPySf5hsSU5LzCXs40CAvZo2JqdyVwNoDjxslbHTG87vxqzwPWnEbQti6qJLgDqcLl29ih0vR+fviPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ekx0XSNa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ekx0XSNa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 931D01F7A7
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfESMTPYXE8+8Awy4gTwtKX31jy2JBbHvGek3wPZhEQ=;
	b=ekx0XSNaUC4AHez9s2FbEOzrHPEF7JGluud4mhf7W8MUffn67Lc9kPZ3qUHKP8D5StP4UW
	l86b+VUxvwYqljmckZGf2g86Gg9h1Vz3cnN84xH1DjP3E6E3Ef7210YhVmx5MwiVyqQKcY
	0+Cxsvl2ijSHeEEl4HPfn/PUhuF0l70=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfESMTPYXE8+8Awy4gTwtKX31jy2JBbHvGek3wPZhEQ=;
	b=ekx0XSNaUC4AHez9s2FbEOzrHPEF7JGluud4mhf7W8MUffn67Lc9kPZ3qUHKP8D5StP4UW
	l86b+VUxvwYqljmckZGf2g86Gg9h1Vz3cnN84xH1DjP3E6E3Ef7210YhVmx5MwiVyqQKcY
	0+Cxsvl2ijSHeEEl4HPfn/PUhuF0l70=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81E11376E
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oN7NIXJ18GiqNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: scrub: add cancel/pause/removed bg checks for raid56 parity stripes
Date: Thu, 16 Oct 2025 15:02:29 +1030
Message-ID: <f8acf0633c2486088f91bde313d8430ff42e3602.1760588662.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760588662.git.wqu@suse.com>
References: <cover.1760588662.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Level: 

For raid56, data and parity stripes are handled differently.

For data stripes they are handled just like regular RAID1/RAID10 stripes,
going through the regular scrub_simple_mirror().

But for parity stripes we have to read out all involved data stripes and
do any needed verification and repair, then scrub the parity stripe.

This process will take a much longer time than a regular stripe, but
unlike scrub_simple_mirror(), we do not check if we should cancel/pause
or the block group is already removed.

Aligned the behavior of scrub_raid56_parity_stripe() to
scrub_simple_mirror(), by adding:

- Cancel check
- Pause check
- Removed block group check

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe266785804e..facbaf3cc231 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2091,6 +2091,24 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	ASSERT(sctx->raid56_data_stripes);
 
+	/* Canceled? */
+	if (atomic_read(&fs_info->scrub_cancel_req) ||
+	    atomic_read(&sctx->cancel_req))
+		return -ECANCELED;
+
+	/* Paused? */
+	if (atomic_read(&fs_info->scrub_pause_req))
+		/* Push queued extents */
+		scrub_blocked_if_needed(fs_info);
+
+	/* Block group removed? */
+	spin_lock(&bg->lock);
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
+		spin_unlock(&bg->lock);
+		return 0;
+	}
+	spin_unlock(&bg->lock);
+
 	/*
 	 * For data stripe search, we cannot reuse the same extent/csum paths,
 	 * as the data stripe bytenr may be smaller than previous extent.  Thus
-- 
2.51.0



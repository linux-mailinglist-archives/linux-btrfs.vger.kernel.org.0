Return-Path: <linux-btrfs+bounces-8703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21A996DD9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD10C1F21EAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C519CC28;
	Wed,  9 Oct 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UPv3aj1x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UPv3aj1x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2461126BF1
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484280; cv=none; b=OOsk/8TPSbWa+KaBD/U365uYuSCj9oRLQiNDs5NzLmNEFTA+jjvwPFmQzuJavYYzrO2MhX+YxrGazdBdA1+poutho3+BBnWRbWbJEGlnZq7w7l6Na+ayRfXCGbSYS/Q+iybKio9Z+GyQ5f0oVBQui0kIgVnU8yxYBjbv+uTe+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484280; c=relaxed/simple;
	bh=Wr6YPu9L9n1+aasp/BIWOE+t7pSHQmvTZxIFUjX0huo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNafCnbhSXx5E62G6gg0xt46x1Uzc7gIcSL+QKdb76P6JAQWP6zfU8/uo2hOVLpUvG9N/WPNpIy1bzJejdk8hVtPCXFr9RLbFRUgtRP8ZBY0A6cAU9u8vebvHUUd1w6IY6k90+21ZZwvx7r7c6gu/1TqUbz24PRcHbz8Lp+ZA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UPv3aj1x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UPv3aj1x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24BDF1F7C8;
	Wed,  9 Oct 2024 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCp36bU6YdYd5i2GLutXcWbqajZboaT6p+jYyhp7cgQ=;
	b=UPv3aj1x5eXxbsd3V7wzC9T2crgXm8lcX1ydc9nI22VJf7qsCEAH0BwuMshIUb85DBeCOg
	//JzHE21f0Xi6FIpIXURJfl1mdwka4HNIVLORfCTII5HqWRl+DxH6g1nIuNH1Rjodyj+eL
	12b+TQ8Pmtjic6y46wQrQqOSGL8CTyo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCp36bU6YdYd5i2GLutXcWbqajZboaT6p+jYyhp7cgQ=;
	b=UPv3aj1x5eXxbsd3V7wzC9T2crgXm8lcX1ydc9nI22VJf7qsCEAH0BwuMshIUb85DBeCOg
	//JzHE21f0Xi6FIpIXURJfl1mdwka4HNIVLORfCTII5HqWRl+DxH6g1nIuNH1Rjodyj+eL
	12b+TQ8Pmtjic6y46wQrQqOSGL8CTyo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12FE1136BA;
	Wed,  9 Oct 2024 14:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DHKgBLSTBmcTRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/25] btrfs: scrub: drop unused parameter sctx from scrub_submit_extent_sector_read()
Date: Wed,  9 Oct 2024 16:31:15 +0200
Message-ID: <a7f21b39b213c8c53aa9d57daa534c59017a59db.1728484021.git.dsterba@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The parameter is unused and we can reach sctx from scrub stripe if
needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 52e09f307462..f21fc6cf07c0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1656,8 +1656,7 @@ static u32 stripe_length(const struct scrub_stripe *stripe)
 		   stripe->bg->start + stripe->bg->length - stripe->logical);
 }
 
-static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
-					    struct scrub_stripe *stripe)
+static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
@@ -1753,7 +1752,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 
 	if (btrfs_need_stripe_tree_update(fs_info, stripe->bg->flags)) {
-		scrub_submit_extent_sector_read(sctx, stripe);
+		scrub_submit_extent_sector_read(stripe);
 		return;
 	}
 
-- 
2.45.0



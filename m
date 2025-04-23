Return-Path: <linux-btrfs+bounces-13323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EDA994DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019171BC5BEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F0242D64;
	Wed, 23 Apr 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sqz57pE7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sqz57pE7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7461F2C45
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423866; cv=none; b=lOS1x50N9oUqy2DvPyIoBZF/9CZKN3UCz/h9KMag0wHX2hRBPO/a4IxPt16bbj/P6Sq7AgQlcJv+uJyEcOMgP4LEZpCfsdBjw8SkmBlfS1373XNjQX7ScKiO8fguzcyA5bom32oa2yjLluavgT9hjL/Qqh9HvdruqV36/kH9k2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423866; c=relaxed/simple;
	bh=jH8dQul4eSC+5VG4c/FaL6js3XZl29MhzG62F4laRb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii0+ge6W6uETyXfDqCD3hGwUy2B0FDb8quQbXceOrblBIQ7HQqArkdEyYaCLTR6wlbGvlnurNhM5QapHWr4DoIa24xslhurHQmufV72NL6iz/BxzjLR7jScsx3HFYsexq4Iry+9QmcdB6P08oBssD7r2XJybb7RkA1prH0ffPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sqz57pE7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sqz57pE7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 885641F393;
	Wed, 23 Apr 2025 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeHtBQoprGl+M4jEqHxrZMA5LgvZmEDMVmZgb+ib3Vs=;
	b=sqz57pE7RI4KhCZDZwW/R2POnXKHjp0g6WBsFObZu8VM4wBVnqzVA/XvygtiZJGnadlARc
	NnKR8tgtb5GxS1bY957nFGwTyB0UQJ40SHOGJ2Y2zoxX1hHeEK9sD5NcjRm//Djj6dzmdc
	M5jWVwyroQDeMosdYedeet9+jzz9BM4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeHtBQoprGl+M4jEqHxrZMA5LgvZmEDMVmZgb+ib3Vs=;
	b=sqz57pE7RI4KhCZDZwW/R2POnXKHjp0g6WBsFObZu8VM4wBVnqzVA/XvygtiZJGnadlARc
	NnKR8tgtb5GxS1bY957nFGwTyB0UQJ40SHOGJ2Y2zoxX1hHeEK9sD5NcjRm//Djj6dzmdc
	M5jWVwyroQDeMosdYedeet9+jzz9BM4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F13813691;
	Wed, 23 Apr 2025 15:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7GsCH/UNCWiKCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:57:41 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/12] btrfs: drop redundant local variable in raid_wait_write_end_io()
Date: Wed, 23 Apr 2025 17:57:13 +0200
Message-ID: <01b9342a3f919ad5048ad249e71563550450cc84.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
References: <cover.1745422901.git.dsterba@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The bio status is read only once, no variable needed for that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 955cf17f443016..5906fd44c15def 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2291,9 +2291,8 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 static void raid_wait_write_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
-	blk_status_t err = bio->bi_status;
 
-	if (err)
+	if (bio->bi_status)
 		rbio_update_error_bitmap(rbio, bio);
 	bio_put(bio);
 	if (atomic_dec_and_test(&rbio->stripes_pending))
-- 
2.49.0



Return-Path: <linux-btrfs+bounces-6634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCCF938895
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 07:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5419EB20A69
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B219BA6;
	Mon, 22 Jul 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BqVtPSBF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZuG962Xd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED81BDCF
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627775; cv=none; b=QP9Hx/4thdca8NhTDDfnmVf/1oI8kRiTlqziaYG99ejMeCuzZ8EoRaTKxFwzwKwHAIMFiqGJHItKKt4VWZ1RtZjCqmRMeXRlVIoOjpP9OqygUaYti50mbvx/heYQr0ZnEfFGB10SlV/8ZcLY3m0BHNGJhkeLaJN4KxO7yiIIMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627775; c=relaxed/simple;
	bh=FbBToTDGhePH0XARMC21fi3QaU8kr3CAZMVREKPBp7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzdpVld9uXznjT0ehrk4Gp04K68+R4MTJzWgOmPIxBl1IJqN9u3k8kAN1SxXK2vpiAgxfKxPWZant2A6xdTFCTuTCL7JkrfdVJCkqzXURks0PhMVKB7yC+1zIspddCnfQYgcQWoS76lb235lVW3SABdBixxPmtToRsrmq6Lmr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BqVtPSBF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZuG962Xd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 389071FB56;
	Mon, 22 Jul 2024 05:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721627771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdSPJWZoK1TNZKt3E4etqDTZ3E4LGrHAeE0AbjsQdic=;
	b=BqVtPSBF/dW3WHLfRgeYSy/CTeBd4Ig3l8d7f5bagQHXQ4Afwio6VDBDfbqFkRfcoM8Gm3
	Ryq5T6ka+4oTQom3W9ubjFrJCzzLkrko99n1fouDde8/ONvb2SCtVxDPn3fs61attzoA+q
	ZSUWoTo27SvFPjnTkz+gRgZitjRZ25Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZuG962Xd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721627770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdSPJWZoK1TNZKt3E4etqDTZ3E4LGrHAeE0AbjsQdic=;
	b=ZuG962XdR0U4lGqW6KGUho9IipRK6uTlNiZfHEdN02H8k9vjA9SZHxNVh15xVOzo8Jexbn
	a/gq4HC4mnF5fXxTE4M4QMn8UtN+ZmnfuVIo1U+PxhIjDiZM1mS2MHxP0+PpePodb6QCRb
	mynSC7u+A4lIw04uGyl5jx/EMFMZi9o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A0A1398E;
	Mon, 22 Jul 2024 05:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBcXMXj0nWa+LQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 22 Jul 2024 05:56:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Reviewed-by : Johannes Thumshirn" <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] btrfs: extract the stripe length calculation into a helper
Date: Mon, 22 Jul 2024 15:25:48 +0930
Message-ID: <ece3adde3a583693c2327204e059efacce655915.1721627526.git.wqu@suse.com>
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
X-Spamd-Result: default: False [0.19 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 389071FB56
X-Spam-Score: 0.19
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /

Currently there are two location which needs to calculate the real
length of a stripe (which can be at the end of a chunk, and the chunk
size may not always be 64K aligned).

Extract them into a helper as we're going to have a third user soon.

Reviewed-by: Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 14a8d7100018..d42a58386415 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1648,14 +1648,21 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	}
 }
 
+static u32 stripe_length(struct scrub_stripe *stripe)
+{
+	ASSERT(stripe->bg);
+
+	return min(BTRFS_STRIPE_LEN,
+		   stripe->bg->start + stripe->bg->length - stripe->logical);
+
+}
+
 static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
-				      stripe->bg->length - stripe->logical) >>
-				  fs_info->sectorsize_bits;
+	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
@@ -1729,9 +1736,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
-	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
-				      stripe->bg->length - stripe->logical) >>
-				  fs_info->sectorsize_bits;
+	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
-- 
2.45.2



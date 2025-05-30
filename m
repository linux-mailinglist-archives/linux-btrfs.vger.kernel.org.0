Return-Path: <linux-btrfs+bounces-14340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0CBAC9365
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675C41C21503
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFAE1C8FBA;
	Fri, 30 May 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MgGCR1dS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MgGCR1dS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB75674E
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621959; cv=none; b=WBarzgHfKK8tC2DC2LBMgjd1okmFn1RQ4w7iFTYAPW0G7tOIG+nXU+m+ATJlD9/gAbjJOhzQR1I8EF0F9gI5sJGc8XlvdxZfFzLA5pyl3bdQpZxzX4Kwaad/aXUuwcwJvpr5N+CNF/x+xGDFaehKG7ksxOpnP/fyLNpnuyhevMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621959; c=relaxed/simple;
	bh=bTVbR4fWdMRItTTTguE2Pz/0ehQ6Yo68Mqvdu/+bsKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J13lmJ8DOJyBH4/1BGKskY+iRGrvX8Re0caXwpgKQQGMr4ehe4ggeESBC7VXRsHRC3/CfzOHRZuZ65WxVJoL2/ihDUfcYwUR9rzDh4WrQM7+22n2I3rq4jnyX3cx7sdSaNSVlZ8KM4Ty5Gczon9c+olwTQH+2U9XqhabSRS/pQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MgGCR1dS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MgGCR1dS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98BDF21AF3;
	Fri, 30 May 2025 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmbPFU+yQufIeOZ73NVTwSszOzxiV5JcIjSFVIkzaXw=;
	b=MgGCR1dSJmkUf8SYVsqGiPKwERWyGbkBY0meqMpAyLTxHf5XkSwE4Jy1dn2NgbUco4jopL
	9kBCwtdjoeU6cISZWiuIEe2xiryYwPZBrbi3zw1s9Gaq0lkADclxoY/TEenZqR1iVkqIks
	dKwmHkO1rd32Hxcah9J80RaGotl+aCg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmbPFU+yQufIeOZ73NVTwSszOzxiV5JcIjSFVIkzaXw=;
	b=MgGCR1dSJmkUf8SYVsqGiPKwERWyGbkBY0meqMpAyLTxHf5XkSwE4Jy1dn2NgbUco4jopL
	9kBCwtdjoeU6cISZWiuIEe2xiryYwPZBrbi3zw1s9Gaq0lkADclxoY/TEenZqR1iVkqIks
	dKwmHkO1rd32Hxcah9J80RaGotl+aCg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BCE13889;
	Fri, 30 May 2025 16:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vETRI37aOWghaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:19:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 22/22] btrfs: rename err to ret in scrub_submit_extent_sector_read()
Date: Fri, 30 May 2025 18:19:06 +0200
Message-ID: <37024fee71d734bf4748fd57e7f287177aa514a7.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7cd5e76a783c..e8fa27754563 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1806,7 +1806,7 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 			struct btrfs_io_context *bioc = NULL;
 			const u64 logical = stripe->logical +
 					    (i << fs_info->sectorsize_bits);
-			int err;
+			int ret;
 
 			io_stripe.rst_search_commit_root = true;
 			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
@@ -1814,11 +1814,11 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 			 * For RST cases, we need to manually split the bbio to
 			 * follow the RST boundary.
 			 */
-			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
+			ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
 					      &stripe_len, &bioc, &io_stripe, &mirror);
 			btrfs_put_bioc(bioc);
-			if (err < 0) {
-				if (err != -ENODATA) {
+			if (ret < 0) {
+				if (ret != -ENODATA) {
 					/*
 					 * Earlier btrfs_get_raid_extent_offset()
 					 * returned -ENODATA, which means there's
-- 
2.47.1



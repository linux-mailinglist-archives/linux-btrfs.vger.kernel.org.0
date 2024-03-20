Return-Path: <linux-btrfs+bounces-3460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26666880A3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DE71F22F33
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605914296;
	Wed, 20 Mar 2024 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Smm6X+QJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Smm6X+QJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51E13AC0
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906912; cv=none; b=sEsLledokj7CpHp9nie9Wlyic/48Dltr10RIjyGhzuompKigyeqhhhAjBecHV5g8QXCk1VcvKfa9hLtyDdyYcaZVEz/WzciAmv73rYMORu261l1FV/p46KnJo/mWT6W0sZ4I6e5MzCSAE/u79ZwY+eDXSJqjCSgvPASnjJs9Zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906912; c=relaxed/simple;
	bh=8dCDV/shdY/iA6vZJEOt5GbYfyN20SX8loubLa2BSuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cA9Op206fIMr1xIkY8q6PHIrzitoXv1ZbYtZuuTJ9qg2gvDqlZ7TuyoYH4WjJNhaxYFVAfrX2B+jXe8bKNxPQYkNfoI9NHSo17UEpob83WYUw17YFHFyDm1l9QkV71/iuLdHMr96XyOT1ApRldaIaQ+hSxrJhtJGmSuINJzl0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Smm6X+QJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Smm6X+QJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB135205F5
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR9r/ZeB1wvotsssF0a4rU0XrcX08VrRcfHF4Fxqmw4=;
	b=Smm6X+QJzXaj2+xTYAqBUDvlJtvX9nLFLPAha/Q4+UYHN3QC0xX803J/Ryqzq3EAupRvCq
	0KWzRsAUAfzVLhDI+RPOf9WTKmhXVNs6MQpYDoZDNs2wA14/W2WI/Vac3xrk2c+mFGK7Ms
	vP+G4XLClfxP9aj1euuk9NZ/LCIXbLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR9r/ZeB1wvotsssF0a4rU0XrcX08VrRcfHF4Fxqmw4=;
	b=Smm6X+QJzXaj2+xTYAqBUDvlJtvX9nLFLPAha/Q4+UYHN3QC0xX803J/Ryqzq3EAupRvCq
	0KWzRsAUAfzVLhDI+RPOf9WTKmhXVNs6MQpYDoZDNs2wA14/W2WI/Vac3xrk2c+mFGK7Ms
	vP+G4XLClfxP9aj1euuk9NZ/LCIXbLU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB052136AE
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHbuJhte+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/7] btrfs: scrub: remove unnecessary dev/physical lookup for  scrub_stripe_report_errors()
Date: Wed, 20 Mar 2024 14:24:54 +1030
Message-ID: <55061b90dd4fe3193ca9992ada5c6c79e8e9c32f.1710906371.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710906371.git.wqu@suse.com>
References: <cover.1710906371.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.44
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.44 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.13)[-0.657];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Smm6X+QJ
X-Rspamd-Queue-Id: AB135205F5

The @stripe passed into scrub_stripe_report_errors() either has
stripe->dev and stripe->physical properly populated (regular data
stripes) or stripe->flags would have SCRUB_STRIPE_FLAG_NO_REPORT
(RAID56 P/Q stripes).

Thus there is no need to go with btrfs_map_block() to get the
dev/physical.

Just add an extra ASSERT() to make sure we get stripe->dev populated
correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 54 +++++++-----------------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a5a9fef2bdb2..ff952dd2b510 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -863,7 +863,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_device *dev = NULL;
+	struct btrfs_device *dev = stripe->dev;
 	u64 stripe_physical = stripe->physical;
 	int nr_data_sectors = 0;
 	int nr_meta_sectors = 0;
@@ -874,35 +874,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
 		return;
 
-	/*
-	 * Init needed infos for error reporting.
-	 *
-	 * Although our scrub_stripe infrastructure is mostly based on btrfs_submit_bio()
-	 * thus no need for dev/physical, error reporting still needs dev and physical.
-	 */
-	if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors)) {
-		u64 mapped_len = fs_info->sectorsize;
-		struct btrfs_io_context *bioc = NULL;
-		int stripe_index = stripe->mirror_num - 1;
-		int ret;
-
-		/* For scrub, our mirror_num should always start at 1. */
-		ASSERT(stripe->mirror_num >= 1);
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				      stripe->logical, &mapped_len, &bioc,
-				      NULL, NULL);
-		/*
-		 * If we failed, dev will be NULL, and later detailed reports
-		 * will just be skipped.
-		 */
-		if (ret < 0)
-			goto skip;
-		stripe_physical = bioc->stripes[stripe_index].physical;
-		dev = bioc->stripes[stripe_index].dev;
-		btrfs_put_bioc(bioc);
-	}
-
-skip:
+	ASSERT(dev);
 	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
 		const u64 logical = stripe->logical +
 				    (sector_nr << fs_info->sectorsize_bits);
@@ -933,41 +905,29 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		 * output the message of repaired message.
 		 */
 		if (repaired) {
-			if (dev) {
-				btrfs_err_rl_in_rcu(fs_info,
+			btrfs_err_rl_in_rcu(fs_info,
 			"fixed up error at logical %llu on dev %s physical %llu",
 					    logical, btrfs_dev_name(dev),
 					    physical);
-			} else {
-				btrfs_err_rl_in_rcu(fs_info,
-			"fixed up error at logical %llu on mirror %u",
-					    logical, stripe->mirror_num);
-			}
 			continue;
 		}
 
 		/* The remaining are all for unrepaired. */
-		if (dev) {
-			btrfs_err_rl_in_rcu(fs_info,
+		btrfs_err_rl_in_rcu(fs_info,
 	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
 					    logical, btrfs_dev_name(dev),
 					    physical);
-		} else {
-			btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on mirror %u",
-					    logical, stripe->mirror_num);
-		}
 
 		if (test_bit(sector_nr, &stripe->io_error_bitmap))
-			if (__ratelimit(&rs) && dev)
+			if (__ratelimit(&rs))
 				scrub_print_common_warning("i/o error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
-			if (__ratelimit(&rs) && dev)
+			if (__ratelimit(&rs))
 				scrub_print_common_warning("checksum error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
-			if (__ratelimit(&rs) && dev)
+			if (__ratelimit(&rs))
 				scrub_print_common_warning("header error", dev,
 						     logical, physical);
 	}
-- 
2.44.0



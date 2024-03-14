Return-Path: <linux-btrfs+bounces-3276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD5087BABA
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC806282B00
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229E6E5E3;
	Thu, 14 Mar 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q3zrJEfQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q3zrJEfQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B076CDDB
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409834; cv=none; b=MeXKzV5F1yv5u24DkFxXZ7U1/0DHeRiQqzQoruEFQPihr5TXzcXfjVO8DZlS2/KPfg4uV+PTptkvshJ1Rz0BGAhaLDCfLZeDBKkF2mENcblpN1Akrx55IAyC8cqJt/2wCnUlJseSYlbaZvFYGZG2aisOhNbd29IhR57QnX4ExK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409834; c=relaxed/simple;
	bh=TmhfV/j45ugz3mkOoxRo/F2X9W+krF5orFRWf/ZM3AU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih89zzVgOGE5hkqIuDIuiYCSUnQv3VySc3iuMlxnsG50KxxCUxYZ6HXXnv48yzpvhr0GNlUaUNMCllwPcZWgsJ5IJtgcCDrBlDPQ4Q1zA888vY8JYi7SShQ/saz8faSnFd/dkQ35CD3FA9DOLjXoIjkbiCy+Jib8kuSBbmzvrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q3zrJEfQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q3zrJEfQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95A991F845
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waiVz8wg5IZHDWrpWYDOpTmaYoOVspdvQAH1YrSaOtA=;
	b=q3zrJEfQaB6mgf1z/y8v5YwKsj7N8S458nr2fSiN3c402Lxmk+6zSEnqCKdC/2WPhxk9Bs
	4D+hG7stQnJTNKOim1xJbxG+bMkTJEJ/iA08ANnA02J64sdK70nSD6T00UYmxN4la6JWui
	8BdC6FGPYRNdEaPbWRhdYYl4pYdf09U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waiVz8wg5IZHDWrpWYDOpTmaYoOVspdvQAH1YrSaOtA=;
	b=q3zrJEfQaB6mgf1z/y8v5YwKsj7N8S458nr2fSiN3c402Lxmk+6zSEnqCKdC/2WPhxk9Bs
	4D+hG7stQnJTNKOim1xJbxG+bMkTJEJ/iA08ANnA02J64sdK70nSD6T00UYmxN4la6JWui
	8BdC6FGPYRNdEaPbWRhdYYl4pYdf09U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11751386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kCyaHGXI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: scrub: remove unnecessary dev/physical lookup for scrub_stripe_report_errors()
Date: Thu, 14 Mar 2024 20:20:17 +1030
Message-ID: <348c07314744f4914f5d613c516e9790f8c725b5.1710409033.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710409033.git.wqu@suse.com>
References: <cover.1710409033.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=q3zrJEfQ
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: 95A991F845
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

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
 fs/btrfs/scrub.c | 59 ++++++------------------------------------------
 1 file changed, 7 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5e371ffdb37b..277583464371 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -860,10 +860,8 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 				       struct scrub_stripe *stripe)
 {
-	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_device *dev = NULL;
+	struct btrfs_device *dev = stripe->dev;
 	u64 stripe_physical = stripe->physical;
 	int nr_data_sectors = 0;
 	int nr_meta_sectors = 0;
@@ -874,35 +872,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
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
 		u64 logical = stripe->logical +
 			      (sector_nr << fs_info->sectorsize_bits);
@@ -933,42 +903,27 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
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
-				scrub_print_common_warning("i/o error", dev,
+			scrub_print_common_warning("i/o error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
-			if (__ratelimit(&rs) && dev)
-				scrub_print_common_warning("checksum error", dev,
+			scrub_print_common_warning("checksum error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
-			if (__ratelimit(&rs) && dev)
-				scrub_print_common_warning("header error", dev,
+			scrub_print_common_warning("header error", dev,
 						     logical, physical);
 	}
 
-- 
2.44.0



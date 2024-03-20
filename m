Return-Path: <linux-btrfs+bounces-3463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88426880A42
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5AA1C21AC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39941799B;
	Wed, 20 Mar 2024 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u1lA8Cq6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u1lA8Cq6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F7171D8
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906917; cv=none; b=dJg3ty8E4So7w1JUsqy6AvuOBogtqs6Ry4+DCMyYhGtujIzsG+zLo9VLGW00XBH1KQiyLCiZq2q/K9uO9rSa+9yBQjnkB7aBzjvoycgjLO84GFxBHC3lHgejXPUnHUwl7mGkwJ8B0OoK8SZzmzslLhaNP8Prpn3AOh5NoffZXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906917; c=relaxed/simple;
	bh=Ooc0AloRH/nCmt9cNyUftBdTEGYxx+WzFMgr2tLZVn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLcArXeL6sfrBTCUib34TWS5coC3R/n1WXcgY5RL2szAuLUl4kC9ZYAzGfxjk4X5jiEZ+LdoApXpco7Tyc6xOd8U921V0B2oEATeUc++T4R4WTyfAF1gouQJ1ScCKxYJxn6m3IBxnFd9Kd70C7LalGSzajzr4uItK2kN9RjP73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u1lA8Cq6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u1lA8Cq6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6ECEB33B84
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f70Je7xySzt5w5UYQfBR0cxFxZa8ooSVRDPmKFrYy1c=;
	b=u1lA8Cq6bJ36AGJi76yLJRv/pON1GYv/Fm+lHC6yP9xZCn4SjeUwbbGt0MY/BBfB03q7z8
	KnkP+3de6zYZSQexSX5mZ8OBOVWjVRzn2itwJpZeDo/McnCZfULxgMbietpmkK5m5Rck3W
	Cxm4akjNhm4lAIS/cLN2XBkmM3FAVHw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f70Je7xySzt5w5UYQfBR0cxFxZa8ooSVRDPmKFrYy1c=;
	b=u1lA8Cq6bJ36AGJi76yLJRv/pON1GYv/Fm+lHC6yP9xZCn4SjeUwbbGt0MY/BBfB03q7z8
	KnkP+3de6zYZSQexSX5mZ8OBOVWjVRzn2itwJpZeDo/McnCZfULxgMbietpmkK5m5Rck3W
	Cxm4akjNhm4lAIS/cLN2XBkmM3FAVHw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71AFA136AE
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FJnDCBe+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/7] btrfs: scrub: use generic ratelimit helpers to output error messages
Date: Wed, 20 Mar 2024 14:24:57 +1030
Message-ID: <15b30ab7f305a81238ec74f84a84564137f45d0a.1710906371.git.wqu@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Currently scrub goes different ways to rate limits its error messages:

- regular btrfs_err_rl_in_rcu() helper for repaired sectors and
  the initial message for unrepaired sectors

- Manually rate limits scrub_print_common_warning()

I'd say the different rate limits could lead to cases where we only got
the "unable to fixup (regular) error" messages but the detailed report
about that corruption is ratelimited.

To make the whole rate limit works more consistently, change the rate
limit by:

- Always using btrfs_*_rl() helpers

- Remove the initial "unable to fixup (regular) error" message
  Since we're ensured to have at least one error message for each
  unrepaired sector (before rate limit), there is no need for
  a duplicated line.

  And if we hit rate limits, we will rate limit all the error messages
  together, not treating different error messages differently.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0d2b042d75c2..f942c9e3f121 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -427,7 +427,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 * hold all of the paths here
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i) {
-		btrfs_warn_in_rcu(fs_info,
+		btrfs_warn_rl_in_rcu(fs_info,
 "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, path: %s",
 				  swarn->errstr, swarn->logical,
 				  btrfs_dev_name(swarn->dev),
@@ -442,7 +442,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	return 0;
 
 err:
-	btrfs_warn_in_rcu(fs_info,
+	btrfs_warn_rl_in_rcu(fs_info,
 			  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
 			  swarn->errstr, swarn->logical,
 			  btrfs_dev_name(swarn->dev),
@@ -500,7 +500,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 				break;
 			if (ret > 0)
 				break;
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn_rl_in_rcu(fs_info,
 "%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
 				errstr, swarn.logical, btrfs_dev_name(dev),
 				swarn.physical, (ref_level ? "node" : "leaf"),
@@ -508,7 +508,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 			swarn.message_printed = true;
 		}
 		if (!swarn.message_printed)
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn_rl_in_rcu(fs_info,
 			"%s at metadata, logical %llu on dev %s physical %llu",
 					  errstr, swarn.logical,
 					  btrfs_dev_name(dev), swarn.physical);
@@ -527,7 +527,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 		iterate_extent_inodes(&ctx, true, scrub_print_warning_inode, &swarn);
 		if (!swarn.message_printed)
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn_rl_in_rcu(fs_info,
 	"%s at data, filename unresolved, logical %llu on dev %s physical %llu",
 					  errstr, swarn.logical,
 					  btrfs_dev_name(dev), swarn.physical);
@@ -846,8 +846,6 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 				       struct scrub_stripe *stripe)
 {
-	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_device *dev = stripe->dev;
 	u64 stripe_physical = stripe->physical;
@@ -899,22 +897,14 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		}
 
 		/* The remaining are all for unrepaired. */
-		btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
-					    logical, btrfs_dev_name(dev),
-					    physical);
-
 		if (test_bit(sector_nr, &stripe->io_error_bitmap))
-			if (__ratelimit(&rs))
-				scrub_print_common_warning("i/o error", dev,
+			scrub_print_common_warning("i/o error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
-			if (__ratelimit(&rs))
-				scrub_print_common_warning("checksum error", dev,
+			scrub_print_common_warning("checksum error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
-			if (__ratelimit(&rs))
-				scrub_print_common_warning("header error", dev,
+			scrub_print_common_warning("header error", dev,
 						     logical, physical);
 	}
 
-- 
2.44.0



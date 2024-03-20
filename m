Return-Path: <linux-btrfs+bounces-3459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F09880A3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC1C1F22F47
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277A14287;
	Wed, 20 Mar 2024 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tErxUQpb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tErxUQpb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C30134C0
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906912; cv=none; b=ETVK1mBcF6m6OPnbTUNO3fGO8mriPE0lVFGDNbUmjrcnMAmz9/LHsD7skK+ZdOt8x7XQ+ZE+tWWy/wVVrVllnDCsDXZJOuDdKIKndPUx8Y8UKb46NPojm2Blswx+4f9RK12IKZ9sFYnW41NTWGRyVim9CLvzfuapYiSfmBxU+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906912; c=relaxed/simple;
	bh=2ewjlbayvlR+kyhPeFxwAwDt5ksgN5GBgasc0Zoov1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUGb9ccV+F+D6buih7VJFcP7wvfDuHdU4QhnwTNRPkscWczPv8yI2EB5thmtXmeihLP9VTL9qCInT3kx1KGCuWY55XocBqdNhnEIyJjn8W59UxYCj9uq5R8pD3NZLvamr79NNhKhhXv/MMIZnK4cK9bz3JMA5RsUc62MlzLwa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tErxUQpb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tErxUQpb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A4BE205F1;
	Wed, 20 Mar 2024 03:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWpv+N8/OT3BCt1ChDItsMAc4WMDyy7oVUy5iztOm6A=;
	b=tErxUQpbIy2tBAnBuMNaCX9sEsrC22KOYdVD42+zaexI8AdLC83LxGZu7yhKCmckZGgbOn
	KT0HWY6I6U9SuFlMEdCnMdy+fn0xGXA4tuwJsQ8WtElQ/F+bMLn6iVz+WKukO2UbZPEbbo
	w805aDflQYmssQIN0i5K7G2FK2xXPrg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWpv+N8/OT3BCt1ChDItsMAc4WMDyy7oVUy5iztOm6A=;
	b=tErxUQpbIy2tBAnBuMNaCX9sEsrC22KOYdVD42+zaexI8AdLC83LxGZu7yhKCmckZGgbOn
	KT0HWY6I6U9SuFlMEdCnMdy+fn0xGXA4tuwJsQ8WtElQ/F+bMLn6iVz+WKukO2UbZPEbbo
	w805aDflQYmssQIN0i5K7G2FK2xXPrg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C8F7136AE;
	Wed, 20 Mar 2024 03:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QDM+Axpe+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 20 Mar 2024 03:55:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/7] btrfs: scrub: remove unused is_super parameter from scrub_print_common_warning()
Date: Wed, 20 Mar 2024 14:24:53 +1030
Message-ID: <30e61128c374874aeb55ce1bfffabc645651fb13.1710906371.git.wqu@suse.com>
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
X-Spam-Score: 0.80
X-Spamd-Result: default: False [0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.10)[-0.477];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Since commit 2a2dc22f7e9d ("btrfs: scrub: use dedicated super block
verification function to scrub one super block"), the super block
scrubbing is handled in a dedicated helper, thus
scrub_print_common_warning() no longer needs to print warning for super
block errors.

Just remove the parameter.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 72aa74310612..a5a9fef2bdb2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -476,7 +476,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 }
 
 static void scrub_print_common_warning(const char *errstr, struct btrfs_device *dev,
-				       bool is_super, u64 logical, u64 physical)
+				       u64 logical, u64 physical)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
 	struct btrfs_path *path;
@@ -488,12 +488,6 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	u32 item_size;
 	int ret;
 
-	/* Super block error, no need to search extent tree. */
-	if (is_super) {
-		btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
-				  errstr, btrfs_dev_name(dev), physical);
-		return;
-	}
 	path = btrfs_alloc_path();
 	if (!path)
 		return;
@@ -966,15 +960,15 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 
 		if (test_bit(sector_nr, &stripe->io_error_bitmap))
 			if (__ratelimit(&rs) && dev)
-				scrub_print_common_warning("i/o error", dev, false,
+				scrub_print_common_warning("i/o error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
 			if (__ratelimit(&rs) && dev)
-				scrub_print_common_warning("checksum error", dev, false,
+				scrub_print_common_warning("checksum error", dev,
 						     logical, physical);
 		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
 			if (__ratelimit(&rs) && dev)
-				scrub_print_common_warning("header error", dev, false,
+				scrub_print_common_warning("header error", dev,
 						     logical, physical);
 	}
 
-- 
2.44.0



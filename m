Return-Path: <linux-btrfs+bounces-3275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25887BAB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531ED1C20ED4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300F6E2B7;
	Thu, 14 Mar 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uDDIc7S+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uDDIc7S+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F86D1CE
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409833; cv=none; b=HRXbXFoxyqmszoOIpfEvlGgVyGPnunjkl7SlVAhQovBv+Fqe0twbBECgk5AyB9Gtu3VOPYIg9LjoJGyGfnMwFnyzL4vS+IcirRiVHK5h3Yr5cwXY9YyOvzUB5dJ+bkq1zaSOip7L2Uu1PG+qSSdbhEy0sXkTJcJIJDtwegcRr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409833; c=relaxed/simple;
	bh=iyUpbDmvh2HW8t0jaMmLivMx02Wi+HFoasSbBqPgDEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMAgEO8/uSFtlWe8rYEf3KtrcZ4QJj81K7CByUSzVOeEIZmychLKWyf6sQW7OzVK5qxcmTkMLWsV3GiZAaVVN9N5HN4xZlPfqefJ4UODOG/Abo+KHh/+XINBHidL4Zn3++/vvYi+dj8yPPTITRzE0+S8BbseXB6Qm6D/nGAt/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uDDIc7S+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uDDIc7S+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 307141F844
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nbSFVBtIZ/e6RMWmZwnvDsEZ3/P2uNkxgHUsWl+80c=;
	b=uDDIc7S+uEnvGnp4GF7yd5gkINgCTgYkJiD1Zj665/p2LA7nnhZ73Ecwr+JhV6ERWx3Cya
	z7OnhpavBIXcHxAo41zX1HfkRTPtWS0XusNlPYmow/oXdJJgQtVr68cdZMjZAfinWuIkiI
	eBiiROVPu4f71TvfN7Yg5GJw9q6DKb8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nbSFVBtIZ/e6RMWmZwnvDsEZ3/P2uNkxgHUsWl+80c=;
	b=uDDIc7S+uEnvGnp4GF7yd5gkINgCTgYkJiD1Zj665/p2LA7nnhZ73Ecwr+JhV6ERWx3Cya
	z7OnhpavBIXcHxAo41zX1HfkRTPtWS0XusNlPYmow/oXdJJgQtVr68cdZMjZAfinWuIkiI
	eBiiROVPu4f71TvfN7Yg5GJw9q6DKb8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D3C41386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sKA/OGPI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: scrub: remove unused is_super parameter from scrub_print_common_warning()
Date: Thu, 14 Mar 2024 20:20:16 +1030
Message-ID: <9c33e49522e2910e2c6735a32592080325ed395d.1710409033.git.wqu@suse.com>
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
	dkim=pass header.d=suse.com header.s=susede1 header.b=uDDIc7S+
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
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
X-Rspamd-Queue-Id: 307141F844
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Since commit 2a2dc22f7e9d ("btrfs: scrub: use dedicated super block
verification function to scrub one super block"), the super block
scrubbing is handled in a dedicated helper, thus
scrub_print_common_warning() no longer needs to print warning for super
block errors.

Just remove the parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 119e98797b21..5e371ffdb37b 100644
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



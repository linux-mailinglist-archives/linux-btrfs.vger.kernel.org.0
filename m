Return-Path: <linux-btrfs+bounces-3458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53091880A3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC611B23062
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF98134C9;
	Wed, 20 Mar 2024 03:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qitHLOI2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qitHLOI2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37511721;
	Wed, 20 Mar 2024 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906909; cv=none; b=UrgoJP6H/VBlSP88FsesGoLp5tl7Z9dsbHL/ltax9XmXaV0U9eG16KhyD8PrcLvUD+vlDBtmewp/IziR4XLTOexBoBDvAU0Tc2eXSX/ikWZ6riydZx1H9T4W/eIx2zoco/6u77uc7Oj/TtI2OH9a62OP3yoMzn4WmuLF716RBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906909; c=relaxed/simple;
	bh=0MkS8Vs1qJYWPfUsCU7D2Mq8IVfHXzGvwv7l/XeFkcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul1ubzFY5xroSCiEoGHAdtSBvncHsE3Xj6iVlcmwrz+EnKQCnu/O7GWRMiRGR7qX7bm+d2TXHbEk2FX+jWfZn4snQzunVX76laYpta3KIq5/7K2k4vpG21ZrOXsxNmYDeitQE/+98oe/2YCCor43banVVa9n5OZzlcj2e/QsVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qitHLOI2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qitHLOI2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBB6633B82;
	Wed, 20 Mar 2024 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmdTrfE3q3JEsO18FddVR9pA5yAPIye6EJlyDX73DU0=;
	b=qitHLOI2IjsCS0gSVHmBKUyxou0fUckLtAu+Ab70tty07cZOQn5hzfWQ8P6HllywztM8RO
	VKxouxP/zTH2RnocJCeo8mMgg3gn+PNyxMTYxuhjwgiBxX78eLm81NW4vTdTFGjOCjs36M
	SaeZa7Pml/pCelrLjNwm2LHVAo00gR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmdTrfE3q3JEsO18FddVR9pA5yAPIye6EJlyDX73DU0=;
	b=qitHLOI2IjsCS0gSVHmBKUyxou0fUckLtAu+Ab70tty07cZOQn5hzfWQ8P6HllywztM8RO
	VKxouxP/zTH2RnocJCeo8mMgg3gn+PNyxMTYxuhjwgiBxX78eLm81NW4vTdTFGjOCjs36M
	SaeZa7Pml/pCelrLjNwm2LHVAo00gR4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6564E136AE;
	Wed, 20 Mar 2024 03:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cCM/Chhe+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 20 Mar 2024 03:55:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/7] btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
Date: Wed, 20 Mar 2024 14:24:52 +1030
Message-ID: <8f3e7a57b40973e62c0d758922971566ca96fb2e.1710906371.git.wqu@suse.com>
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
X-Spam-Score: -1.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.19)[-0.934];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qitHLOI2
X-Rspamd-Queue-Id: CBB6633B82

Currently when we increase the device statistics, it would always lead
to an error message in the kernel log.

However this output is mostly duplicated with the existing ones:

- For scrub operations
  We always have the following messages:
  * "fixed up error at logical %llu"
  * "unable to fixup (regular) error at logical %llu"

  So no matter if the corruption is repaired or not, it scrub would
  output an error message to indicate the problem.

- For non-scrub read operations
  We also have the following messages:
  * "csum failed root %lld inode %llu off %llu" for data csum mismatch
  * "bad (tree block start|fsid|tree block level)" for metadata
  * "read error corrected: ino %llu off %llu" for repaired data/metadata

So the error message from btrfs_dev_stat_inc_and_print() is duplicated.

The real usage for the btrfs device statistics is for some user space
daemon to check if there is any new errors, acting like some checks on
SMART, thus we don't really need/want those messages in dmesg.

This patch would reduce the log level to debug (disabled by default) for
btrfs_dev_stat_inc_and_print().
For users really want to utilize btrfs devices statistics, they should
go check "btrfs device stats" periodically, and we should focus the
kernel error messages to more important things.

CC: stable@vger.kernel.org
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e49935a54da0..126145950ed3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7828,7 +7828,7 @@ void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index)
 
 	if (!dev->dev_stats_valid)
 		return;
-	btrfs_err_rl_in_rcu(dev->fs_info,
+	btrfs_debug_rl_in_rcu(dev->fs_info,
 		"bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen %u",
 			   btrfs_dev_name(dev),
 			   btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRITE_ERRS),
-- 
2.44.0



Return-Path: <linux-btrfs+bounces-3274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB6787BAB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3A2285A8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112F6DD0A;
	Thu, 14 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uw4qfesA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uw4qfesA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F96CDDB;
	Thu, 14 Mar 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409831; cv=none; b=atbzYkxAqm9RCjlZ8Gl3Mxt7WG3ppHlrelqXhOS5Uno+5AzMdQuckgQ1fAIrbbgIQXfCEjF9gYbWN52KRXzH4uzGp3P2wdKfYEgbgqfBqsyVpMRlJvwJO76DlvyJEx3MSVtV2hTzpHshI4HXj6XXlgGkn8Zq5jS1KiQtAyutto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409831; c=relaxed/simple;
	bh=K/CEd3RNqXZXTQ0NLAQim//VRn3tbx1k0NNRY/ttNCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKAi4uUS/pHBTEjrsYMSK4B7njYMp8h396cHAqU/5jldvogey8zyVvxBA6BPEE0QJEbkRqmxLpLj+NfqNPrrqIuzRrS5RDAvDb34gBBMEvTAOtUvXNAIN0LvgjzmxjaY9J/ZQKUkDJmpv99OfbQ7oFUL/CVMBKUfVh5kNFWGCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uw4qfesA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uw4qfesA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0F141F842;
	Thu, 14 Mar 2024 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeF+9f6hvwubs3gTkYMoPPUNvBAqgdX2QvrFGWljTQo=;
	b=uw4qfesAtOkGSx0I66YEbLpxGwaOk9CmxbHSqQIJcalW1L0lSCaInesGKnv9H9eH2p6QTN
	oEIoCRfW+If3xI1oiiPHEYDdAhEKG+Bavc5Sw+MqBnX2rvRcsUzVP37R6jA1m06Q6wHryz
	UPlbyjjeLV/fzgKbRdxL07P0yYikRzs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeF+9f6hvwubs3gTkYMoPPUNvBAqgdX2QvrFGWljTQo=;
	b=uw4qfesAtOkGSx0I66YEbLpxGwaOk9CmxbHSqQIJcalW1L0lSCaInesGKnv9H9eH2p6QTN
	oEIoCRfW+If3xI1oiiPHEYDdAhEKG+Bavc5Sw+MqBnX2rvRcsUzVP37R6jA1m06Q6wHryz
	UPlbyjjeLV/fzgKbRdxL07P0yYikRzs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88BD1138A7;
	Thu, 14 Mar 2024 09:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WN4vEmLI8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 14 Mar 2024 09:50:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/7] btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
Date: Thu, 14 Mar 2024 20:20:15 +1030
Message-ID: <c54030e9a9e202f36e6002fb533810bc5e8a6b9b.1710409033.git.wqu@suse.com>
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
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uw4qfesA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.61%]
X-Spam-Score: 2.49
X-Rspamd-Queue-Id: A0F141F842
X-Spam-Flag: NO

Currently when we increase the device statistics, it would always lead
to an error message in the kernel log.

I would argue this behavior is not ideal:

- It would flood the dmesg and bury real important messages
  One common scenario is scrub.
  If scrub hit some errors, it would cause both scrub and
  btrfs_dev_stat_inc_and_print() to print error messages.

  And in that case, btrfs_dev_stat_inc_and_print() is completely
  useless.

- The results of btrfs_dev_stat_inc_and_print() is mostly for history
  monitoring, doesn't has enough details

  If we trigger the errors during regular read, such messages from
  btrfs_dev_stat_inc_and_print() won't help us to locate the cause
  either.

The real usage for the btrfs device statistics is for some user space
daemon to check if there is any new errors, acting like some checks on
SMART, thus we don't really need/want those messages in dmesg.

This patch would reduce the log level to debug (disabled by default) for
btrfs_dev_stat_inc_and_print().
For users really want to utilize btrfs devices statistics, they should
go check "btrfs device stats" periodically, and we should focus the
kernel error messages to more important things.

CC: stable@vger.kernel.org
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



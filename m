Return-Path: <linux-btrfs+bounces-21577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNcGNhSuimkKNAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21577-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 05:03:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0072D116D34
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 05:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A57C30069B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0539F283C89;
	Tue, 10 Feb 2026 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MfbJ+hHZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MfbJ+hHZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CC2F851
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696207; cv=none; b=JUT+JAjpLJ3A2FTvxj0sBwYBMGNTebIM+nJx8YbcajsuVmO/9eVC8NoCTysDMCyd2syGY6CSUCG4cjXjl9nN5HNQ3sDTmUzBGD0LJZrnI5ogRLTDTjE+H92xYlxg/wYsUwquRLtziU1tlgD52c6RwIKLFB3AZNJrGLYl1MJE5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696207; c=relaxed/simple;
	bh=55UdkllFkeiL/Kx9eaevKsJIJHMbRf65vQq/EQYl2Y8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgu0LPV0XwOV6FyaznLHHv/t8vwYe7gDokNl2bDS+dQd8ZpvUqHdN3g/yaQgcMC0dM4C0Lpmbr5MHmoPrTpTQvr7xA4azTW5pNhXc2jdgcMsRRKM3oS4V8MqtPNitO4+6xwqGznGr8NpkgjFCXhcsG59yYxiOkF5L9GeN8338Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MfbJ+hHZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MfbJ+hHZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C996B3E712
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770696199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qDBpCrYl6uqRLC+WX4F23FzEsH/x5CkxQT0bqJ8dwc=;
	b=MfbJ+hHZxxzACmGyieay9bz51c5gIdJQOvPlLU16JF9jIuslfq8bPZ7eO4HVsZq7LIuQUa
	AjWvk/3dooTRQeUJRu0g6dJZJpPAIaQJvj8MXs8R2sADCKTJysHkgMdzqzjd67NoBku7qJ
	vq+qD7m9VpZ8RrqmZeqdPg8n/ZQ4vnw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770696199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qDBpCrYl6uqRLC+WX4F23FzEsH/x5CkxQT0bqJ8dwc=;
	b=MfbJ+hHZxxzACmGyieay9bz51c5gIdJQOvPlLU16JF9jIuslfq8bPZ7eO4HVsZq7LIuQUa
	AjWvk/3dooTRQeUJRu0g6dJZJpPAIaQJvj8MXs8R2sADCKTJysHkgMdzqzjd67NoBku7qJ
	vq+qD7m9VpZ8RrqmZeqdPg8n/ZQ4vnw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E3F3EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6GLsGAauimm/bwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:03:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: move shutdown and remove_bdev callbacks out of experimental features
Date: Tue, 10 Feb 2026 14:32:57 +1030
Message-ID: <d302fbc2950ea6056a61c82d5eec2adfd0893213.1770695952.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770695952.git.wqu@suse.com>
References: <cover.1770695952.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21577-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0072D116D34
X-Rspamd-Action: no action

These two new callbacks are introduced in v6.19, and it has been two
releases in v7.1.

During that time we have not yet exposed bugs related that two features,
thus it's time to expose them for end users.

It's especially important to expose remove_bdev callback to end users.

That new callback makes btrfs automatically shutdown or go degraded
when a device is missing (depending on if the fs can maintain RW), which
is affecting end users.

We want some feedback from early adopters.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Kconfig | 2 --
 fs/btrfs/super.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index ede184b6eda1..5e75438e0b73 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -112,8 +112,6 @@ config BTRFS_EXPERIMENTAL
 
 	  - large folio and block size (> page size) support
 
-	  - shutdown ioctl and auto-degradation support
-
 	  - asynchronous checksum generation for data writes
 
 	  - remap-tree - logical address remapping tree
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d64d303b6edc..44bc7fb6b24f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2423,7 +2423,6 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	return 0;
 }
 
-#ifdef CONFIG_BTRFS_EXPERIMENTAL
 static int btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -2481,7 +2480,6 @@ static void btrfs_shutdown(struct super_block *sb)
 
 	btrfs_force_shutdown(fs_info);
 }
-#endif
 
 static int btrfs_show_stats(struct seq_file *seq, struct dentry *root)
 {
@@ -2511,10 +2509,8 @@ static const struct super_operations btrfs_super_ops = {
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
 	.show_stats	= btrfs_show_stats,
-#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	.remove_bdev	= btrfs_remove_bdev,
 	.shutdown	= btrfs_shutdown,
-#endif
 };
 
 static const struct file_operations btrfs_ctl_fops = {
-- 
2.52.0



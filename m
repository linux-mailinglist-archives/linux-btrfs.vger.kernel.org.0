Return-Path: <linux-btrfs+bounces-11480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4EFA36CA5
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369B518956DC
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865119884C;
	Sat, 15 Feb 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j+5NYLYR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j+5NYLYR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF218CBEC
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608505; cv=none; b=EzQAH9eSq5lyvzqckwli6MhdOU/PpiD0NgwsUWrnnDGgTeSx1NM9FIuNhE0701aVRAVGIIl3h8Eu6xBl5BGzp8Lw57kUbb3foTmh9C85KmuDDbFtdA8ZbuZfQPcYHTEqPUF5h07F+gW1OJmE3vByZu8Hu8PrWw+W1QTrK+ktrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608505; c=relaxed/simple;
	bh=bb9ug1KoKCCiRAmQB2PMDU4wFOf4YuBewWtZcEvx6Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbnOgm4Qy0DLVJx9JP8MKNKUcyfcnZ1JknNH4B76A2obSwfges/nTfXCESsY68o1SMIEES3K8GmVaz16/n4iStP/jusyhxeHbSYjw0ZsZJ3rb3Cy1zmudG21rN2jHC76Qb+2WiX5R7zLnMseslzc3idNvfZT5UQN6rX9NZMB6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j+5NYLYR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j+5NYLYR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F88B21177
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739608486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh7T41xY70/KZT+LF4z4bY/oAzhBLSSVywBEQL7OVAk=;
	b=j+5NYLYRMKHx1lkmaAuvql+6PF2/A7XBE8GV1iWVE3uMi7NYiEI3fud0hWUsHiA+4Vka2p
	hHWLXIsL22PnZSxUDxTiBWKh/2AsasmDR5UaXyWcBA8BJ1JAlPytQSD2ChSF+bRxAInYUY
	88W7SnqeudyhABTIu/uX25qrjdC509o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=j+5NYLYR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739608486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dh7T41xY70/KZT+LF4z4bY/oAzhBLSSVywBEQL7OVAk=;
	b=j+5NYLYRMKHx1lkmaAuvql+6PF2/A7XBE8GV1iWVE3uMi7NYiEI3fud0hWUsHiA+4Vka2p
	hHWLXIsL22PnZSxUDxTiBWKh/2AsasmDR5UaXyWcBA8BJ1JAlPytQSD2ChSF+bRxAInYUY
	88W7SnqeudyhABTIu/uX25qrjdC509o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 942BA136E6
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDIBFaVRsGfNTQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: remove the subpage related warning message
Date: Sat, 15 Feb 2025 19:04:22 +1030
Message-ID: <4d502549296f910f7af7d06a4442688c3da7d200.1739608189.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739608189.git.wqu@suse.com>
References: <cover.1739608189.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F88B21177
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since the initial enablement of block size < page size support for
btrfs in v5.15, we have hit several milestones for block size < page
size (subpage) support:

- RAID56 subpage support
  In v5.19

- Refactored scrub support to support subpage better
  In v6.4

- Block perfect (previously require page aligned range) compressed write
  In v6.13

- Various error handling fixes involving subpage
  In v6.14

Finally the only missing feature is the pretty simple and harmless
inlined data extent creation, just done in previous patches.

Now btrfs has all of its features ready for both regular and subpage
cases, there is no reason to output a warning about the experimental
subpage support, and we can finally remove it now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c31ba1b061e..1d64b3721e25 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3415,11 +3415,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
 
-	if (sectorsize < PAGE_SIZE)
-		btrfs_warn(fs_info,
-		"read-write for sector size %u with page size %lu is experimental",
-			   sectorsize, PAGE_SIZE);
-
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret)
 		goto fail_sb_buffer;
-- 
2.48.1



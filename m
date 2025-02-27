Return-Path: <linux-btrfs+bounces-11894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C90A4759B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824BD1890324
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87AF218E96;
	Thu, 27 Feb 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SLt76EAA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SLt76EAA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846F1EB5E2
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635743; cv=none; b=Iq8U5zuICQLNOHh1wdO/+90qwLTDG69mqhqQj2WsCgQa9PdthzZDYgBvmZ6PdIPOQCu4qTOQXBcOluuC8bcEXtZBNwn7KSZQZfv4b+ZdMS/wFTKV0rXOsvpNE6riOwLRnJe0+Wo21HcKoupcop2cSL/E1YxapB6PuDuB4+Bwj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635743; c=relaxed/simple;
	bh=Fsw8BM2I8VRdDBCuV2TJiwoYnfv9wIgJf84iTcRD7QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hs6TG0vcE8Fm6eOPlOMuSjsvLUaI0nalh2PF1JhcslGKvZXJKwq15l8f9/20VsJgWpkMg3zeLbskSJpa9pCHKfiYl5ThI3HjMgy5KhACHkrinvZ4XdCFBlMWUHaf9raX94U8xFJ29KnXNR0hONnubcyfuokWUazlq3wWIk3mC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SLt76EAA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SLt76EAA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A416F1F455;
	Thu, 27 Feb 2025 05:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vJn0lBaTk0U9rnHXoReogewqzAgou5H37LSns0XRdU=;
	b=SLt76EAASqDvcVMXEtUb7HrWfN6n19b5VsiKmewbLNzjWZXHUYC4UCI84z1rSuFDpkvk9v
	03YMf3xA/OAcnUOlOEe55HpCutErlVsPNqBwzs6GqjAUBQYiYtefEWJxEP/6E4PRc3nyk7
	Tvoo//hXFpAadJ2PNNZVvobjpWZYTeM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vJn0lBaTk0U9rnHXoReogewqzAgou5H37LSns0XRdU=;
	b=SLt76EAASqDvcVMXEtUb7HrWfN6n19b5VsiKmewbLNzjWZXHUYC4UCI84z1rSuFDpkvk9v
	03YMf3xA/OAcnUOlOEe55HpCutErlVsPNqBwzs6GqjAUBQYiYtefEWJxEP/6E4PRc3nyk7
	Tvoo//hXFpAadJ2PNNZVvobjpWZYTeM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1E471376A;
	Thu, 27 Feb 2025 05:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AADnGEP+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Feb 2025 05:55:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 8/8] btrfs: remove the subpage related warning message
Date: Thu, 27 Feb 2025 16:24:46 +1030
Message-ID: <ecd2c5009c632393c2015f72cc58f83dab1e41af.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
References: <cover.1740635497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Since the initial enablement of block size < page size support for
btrfs in v5.15, we have hit several milestones for block size < page
size (subpage) support:

- RAID56 subpage support
  In v5.19

- Refactored scrub support to support subpage better
  In v6.4

- Block perfect (previously requires page aligned ranges) compressed write
  In v6.13

- Various error handling fixes involving subpage
  In v6.14

Finally the only missing feature is the pretty simple and harmless
inlined data extent creation, just added in previous patches.

Now btrfs has all of its features ready for both regular and subpage
cases, there is no reason to output a warning about the experimental
subpage support, and we can finally remove it now.

Acked-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a799216aa264..c0b40dedceb5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3414,11 +3414,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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



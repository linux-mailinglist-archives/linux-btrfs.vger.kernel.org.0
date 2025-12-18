Return-Path: <linux-btrfs+bounces-19850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D5CCA442
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 05:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BC2B3011F8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 04:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41E280328;
	Thu, 18 Dec 2025 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uTEouf95";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uTEouf95"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D41DFF0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766033153; cv=none; b=COEndaHjmabU4FTnPSpUNJYpt2Y/kBs3LGlxgqH9JN9rCtWNk9JyfZJcdKPPeXd9XuHVC06AKqCujNMmfwpWNTIYwui+RVXm91WnZ44wzinWaMCrkF28DZhyNSXA3EyZCa4hFeTyN74C3QYCgk9s0aIBVXZX24XZH0IbYoyvdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766033153; c=relaxed/simple;
	bh=dlzynnFsr5Ozt/AugtsNnGNoeomiqhbS4EfLnS7u/H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4FghUp3XyS5Pyh+u5IWV7l7SE/+qiQ477HuhuP+jwwfs7wVoDxly63kBxzr/wPrIf0PYJ/Czro+x5dzAFpfB2Hg74AHbWxCDtvzTY9gxq3Qzc1Qz4jLMXxeuVgBm5EGDaf+an1ZcmCFuyo9EtbIcyV5dGXxO+Y+k5/VSHk3pUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uTEouf95; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uTEouf95; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 076145BCEE
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766033149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDebIaI8PpNcIXlp4HMsyv++2FSpWr2TSk19e9UlnRU=;
	b=uTEouf95olTW7QuZOQO3tE+1WrreO0xAjyJ6PzmA4y1fKQsgJqmp5i3IdHsi59YeuwwChw
	g7ZOAQ7Nh3M265zmrYZfrpT18jPUwsuG28xSatqYTgc9WKS4227wjimgtVyqjRJDGyfAvZ
	9ANvw3K1Q+FvakOGa8CBRdE125vSPmk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uTEouf95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766033149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDebIaI8PpNcIXlp4HMsyv++2FSpWr2TSk19e9UlnRU=;
	b=uTEouf95olTW7QuZOQO3tE+1WrreO0xAjyJ6PzmA4y1fKQsgJqmp5i3IdHsi59YeuwwChw
	g7ZOAQ7Nh3M265zmrYZfrpT18jPUwsuG28xSatqYTgc9WKS4227wjimgtVyqjRJDGyfAvZ
	9ANvw3K1Q+FvakOGa8CBRdE125vSPmk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 445703EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFIoAvyGQ2kYBgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 04:45:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: only enforce free space tree if v1 cache is required for bs < ps cases
Date: Thu, 18 Dec 2025 15:15:28 +1030
Message-ID: <4eb0313e1d6f1afd7bf31dfb9408155323158936.1766032843.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766032843.git.wqu@suse.com>
References: <cover.1766032843.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 076145BCEE
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

[BUG]
Since the introduction of btrfs bs < ps support, v1 cache is never on
the plan due to its hard coded PAGE_SIZE usage, and the future plan to
properly deprecate it.

However for bs < ps cases, even if 'nospace_cache,clear_cache' mount
option is specified, it's never respected and free space tree is always
enabled:

 mkfs.btrfs -f -O ^bgt,fst $dev
 mount $dev $mnt -o clear_cache,nospace_cache
 umount $mnt
 btrfs ins dump-super $dev
 ...
 compat_ro_flags		0x3
			( FREE_SPACE_TREE |
			  FREE_SPACE_TREE_VALID )
 ...

This means a different behavior compared to bs >= ps cases.

[CAUSE]
The forcing usage of v2 space cache is done inside
btrfs_set_free_space_cache_settings(), however it never checks if we're
even using space cache but always enabling v2 cache.

[FIX]
Instead unconditionally enable v2 cache, only forcing v2 cache if the
old v1 cache is required.

Now v2 space cache can be properly disabled on bs < ps cases:

 mkfs.btrfs -f -O ^bgt,fst $dev
 mount $dev $mnt -o clear_cache,nospace_cache
 umount $mnt
 btrfs ins dump-super $dev
 ...
 compat_ro_flags		0x0
 ...

Fixes: 9f73f1aef98b ("btrfs: force v2 space cache usage for subpage mount")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a37b71091014..09c38becf20b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -736,14 +736,12 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
  */
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->sectorsize < PAGE_SIZE) {
+	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
+		btrfs_info(fs_info,
+			   "forcing free space tree for sector size %u with page size %lu",
+			   fs_info->sectorsize, PAGE_SIZE);
 		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
-			btrfs_info(fs_info,
-				   "forcing free space tree for sector size %u with page size %lu",
-				   fs_info->sectorsize, PAGE_SIZE);
-			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-		}
+		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
 	}
 
 	/*
-- 
2.52.0



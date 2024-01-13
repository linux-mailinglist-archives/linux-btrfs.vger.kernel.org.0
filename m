Return-Path: <linux-btrfs+bounces-1430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A382CA90
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1FD284D98
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E346B7;
	Sat, 13 Jan 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="thKO830Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="thKO830Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBC7E6
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D2C722301
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIrKLlxboeuTO0Iz3/DMqmd85/kfDqfm7m4Ob4C86sk=;
	b=thKO830YML9GBfQsCOX8wwAn/0UFcYtj2MlhY9H0AWBsNcXHqy2/9c13Wcfztral06BdvO
	bRVtXEIx6ZjkZyxWgRBuDhp1xnPI6v9BAK8n98pWK1D8rEfxDpxrNuqdZLZRte0cjaAXBZ
	IwxF88dA2UjmVKxunryVkdFQaD9QnNI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIrKLlxboeuTO0Iz3/DMqmd85/kfDqfm7m4Ob4C86sk=;
	b=thKO830YML9GBfQsCOX8wwAn/0UFcYtj2MlhY9H0AWBsNcXHqy2/9c13Wcfztral06BdvO
	bRVtXEIx6ZjkZyxWgRBuDhp1xnPI6v9BAK8n98pWK1D8rEfxDpxrNuqdZLZRte0cjaAXBZ
	IwxF88dA2UjmVKxunryVkdFQaD9QnNI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DFA313676
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBX/BMNNomVLeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: new debug environment variable to finetune metadata cache size
Date: Sat, 13 Jan 2024 19:15:30 +1030
Message-ID: <07579fc7e3a960384f9e4e455c11c3407f68cab1.1705135055.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705135055.git.wqu@suse.com>
References: <cover.1705135055.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Since we got a recent bug report about tree-checker triggered for large
fs conversion, we need a properly way to trigger the problem for test
case purpose.

To trigger that bug, we need to meet several conditions:

- We need to read some tree blocks which has half-backed inodes
- We need a large enough enough fs to generate more tree blocks than
  our cache.

  For our existing test cases, firstly the fs is not that large, thus
  we may even go just one transaction to generate all the inodes.

  Secondly we have a global cache for tree blocks, which means a lot of
  written tree blocks are still in the cache, thus won't trigger
  tree-checker.

To make the problem much easier for our existing test case to expose,
this patch would introduce a debug environment variable:
BTRFS_PROGS_DEBUG_METADATA_CACHE_SIZE.

This variable allows us to finetune the cache size, so that we can
reduce the metadata cache size and trigger more read thus more
tree-checker checks to shake out more bugs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index ee19430daa12..ce5e4ffb7a59 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -43,7 +43,10 @@ static void free_extent_buffer_final(struct extent_buffer *eb);
 
 void extent_buffer_init_cache(struct btrfs_fs_info *fs_info)
 {
-	fs_info->max_cache_size = total_memory() / 4;
+	u64 max_cache_size = total_memory() / 4;
+
+	get_env_u64("BTRFS_PROGS_DEBUG_METADATA_CACHE_SIZE", &max_cache_size);
+	fs_info->max_cache_size = max_cache_size;
 	fs_info->cache_size = 0;
 	INIT_LIST_HEAD(&fs_info->lru);
 }
-- 
2.43.0



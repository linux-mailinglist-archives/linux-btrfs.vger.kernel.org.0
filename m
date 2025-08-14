Return-Path: <linux-btrfs+bounces-16074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF379B25ACF
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875E71C231E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8177224AE6;
	Thu, 14 Aug 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AoE9dCw1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AoE9dCw1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D621FF4D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149636; cv=none; b=aVEzduiFfvYzqXTdZXiM0EW+cqum37KB8eQeRKPy2+Y6L4Gy942a/J2gV3z8Ph6dxvigDbJnL407vkcQjXKcenAL2svOkg402vHPTLUWuJlD/sVrMqRNIKrUQcVFQGfzkrXBPL98Ixfh+KWRuAPLyL72U2nE2NsF6AiR9KvsFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149636; c=relaxed/simple;
	bh=CjgudFgcBhys3Xne47KIioDvtwyxKCXmzzGOTQNix24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5ripsbLeKFnl47EIC0jskPH6KxzKYHD5cMv1kUOKwlVryNrCPo1iMFO5Xwm20mozpUBZDyVRp50T3lEHooDjX5Q3TWutwH1bPof67EF9+YUh+1erBfhjExnruYE/I8uVgvlJZB6Ms6IsBZ3CnTrB2ylbhLewUsz/GVuXg3vuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AoE9dCw1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AoE9dCw1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 793AE21B15
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7r+XIOGHUW1XPWL1zIgq7X3kwuWQBOIvSVb+XL2kYTA=;
	b=AoE9dCw1iSnK89116C+5GNwUp/js327NnkiijC/an8+ZdpywUDExr/gbG8rDbnr+zq3IV/
	GbVxOr8nvqob/U9rrZqZPPd2MqwyYlPV9x1zd/aWtKVuRsd8VYA+ZV8i5JPitxluKT0cQ/
	riWLjM+BPMQlvgv6wWcqskznS4t4RvE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AoE9dCw1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7r+XIOGHUW1XPWL1zIgq7X3kwuWQBOIvSVb+XL2kYTA=;
	b=AoE9dCw1iSnK89116C+5GNwUp/js327NnkiijC/an8+ZdpywUDExr/gbG8rDbnr+zq3IV/
	GbVxOr8nvqob/U9rrZqZPPd2MqwyYlPV9x1zd/aWtKVuRsd8VYA+ZV8i5JPitxluKT0cQ/
	riWLjM+BPMQlvgv6wWcqskznS4t4RvE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A22E13479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wCL0FDx1nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: add generic workspace manager initialization
Date: Thu, 14 Aug 2025 15:03:22 +0930
Message-ID: <d388ffd7cff17a0e6e62b7d24d218ec198efa010.1755148754.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755148754.git.wqu@suse.com>
References: <cover.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 793AE21B15
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

This involves:

- Add generic_(alloc|free)_workspace_manager helpers.
  These are the helper to alloc/free workspace_manager structure, which
  will allocate a workspace_manager structure, initialize it, and
  pre-allocate one workspace for it.

- Call generic_alloc_workspace_manager() inside
  btrfs_alloc_compress_wsm()
  For none, zlib and lzo compression algorithms.

- Call generic_alloc_workspace_manager() inside
  btrfs_free_compress_wsm()
  For none, zlib and lzo compression algorithms.

For now the generic per-fs workspace managers won't really have any effect,
and all compression is still going through the global workspace manager.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0ee8a17abc30..8a7b2b802ddd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -773,6 +773,40 @@ static void free_workspace(int type, struct list_head *ws)
 	}
 }
 
+static int generic_alloc_workspace_manager(struct btrfs_fs_info *fs_info,
+					   enum btrfs_compression_type type)
+{
+	struct workspace_manager *gwsm;
+	struct list_head *workspace;
+
+	ASSERT(fs_info->compr_wsm[type] == NULL);
+	gwsm = kzalloc(sizeof(*gwsm), GFP_KERNEL);
+	if (!gwsm)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&gwsm->idle_ws);
+	spin_lock_init(&gwsm->ws_lock);
+	atomic_set(&gwsm->total_ws, 0);
+	init_waitqueue_head(&gwsm->ws_wait);
+	fs_info->compr_wsm[type] = gwsm;
+
+	/*
+	 * Preallocate one workspace for each compression type so we can
+	 * guarantee forward progress in the worst case
+	 */
+	workspace = alloc_workspace(fs_info, type, 0);
+	if (IS_ERR(workspace)) {
+		btrfs_warn(fs_info,
+	"cannot preallocate compression workspace for %s, will try later",
+			   btrfs_compress_type2str(type));
+	} else {
+		atomic_set(&gwsm->total_ws, 1);
+		gwsm->free_ws = 1;
+		list_add(workspace, &gwsm->idle_ws);
+	}
+	return 0;
+}
+
 static void btrfs_init_workspace_manager(struct btrfs_fs_info *fs_info, int type)
 {
 	struct workspace_manager *wsm;
@@ -799,6 +833,26 @@ static void btrfs_init_workspace_manager(struct btrfs_fs_info *fs_info, int type
 	}
 }
 
+static void generic_free_workspace_manager(struct btrfs_fs_info *fs_info,
+					   enum btrfs_compression_type type)
+{
+	struct list_head *ws;
+	struct workspace_manager *gwsm = fs_info->compr_wsm[type];
+
+	/* ZSTD uses its own workspace manager, should enter here. */
+	ASSERT(type != BTRFS_COMPRESS_ZSTD && type < BTRFS_NR_COMPRESS_TYPES);
+	if (!gwsm)
+		return;
+	fs_info->compr_wsm[type] = NULL;
+	while (!list_empty(&gwsm->idle_ws)) {
+		ws = gwsm->idle_ws.next;
+		list_del(ws);
+		free_workspace(type, ws);
+		atomic_dec(&gwsm->total_ws);
+	}
+	kfree(gwsm);
+}
+
 static void btrfs_cleanup_workspace_manager(int type)
 {
 	struct workspace_manager *wsman;
@@ -1101,6 +1155,15 @@ int btrfs_alloc_compress_wsm(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 
+	ret = generic_alloc_workspace_manager(fs_info, BTRFS_COMPRESS_NONE);
+	if (ret < 0)
+		goto error;
+	ret = generic_alloc_workspace_manager(fs_info, BTRFS_COMPRESS_ZLIB);
+	if (ret < 0)
+		goto error;
+	ret = generic_alloc_workspace_manager(fs_info, BTRFS_COMPRESS_LZO);
+	if (ret < 0)
+		goto error;
 	ret = zstd_alloc_workspace_manager(fs_info);
 	if (ret < 0)
 		goto error;
@@ -1112,6 +1175,9 @@ int btrfs_alloc_compress_wsm(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_compress_wsm(struct btrfs_fs_info *fs_info)
 {
+	generic_free_workspace_manager(fs_info, BTRFS_COMPRESS_NONE);
+	generic_free_workspace_manager(fs_info, BTRFS_COMPRESS_ZLIB);
+	generic_free_workspace_manager(fs_info, BTRFS_COMPRESS_LZO);
 	zstd_free_workspace_manager(fs_info);
 }
 
-- 
2.50.1



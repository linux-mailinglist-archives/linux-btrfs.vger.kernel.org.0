Return-Path: <linux-btrfs+bounces-13331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86AA994E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF90F9A3DA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87F284B4B;
	Wed, 23 Apr 2025 15:58:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B8238C16
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423911; cv=none; b=PhKMRnlx3BobXzOFKY4kvf5GIaizgMJtiOVYpgBtRVHS0TCkxWMuyppGHKdpmNE47hfLl4uw4oWk1dc/QYzbQFIELxaTNfUDHy/QCnxVepfB13ONDoMtT7IRlITyz00ktikefD3fD+7e3eotxKykP39Oda+z/2QOAoXU3LRIv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423911; c=relaxed/simple;
	bh=8QZUoFGwAbg7jTlyqEChLA2b5HIqQJfpsRUHekhkaxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC6YgTckLzDKZOkJ+h2md0DjnQUx/hfcOkN+Zcr11b89MvqRtOCnUKSCTvbpvI/95HUh2n0ujd4eDNYfQdrkMYzteXGKz3ScMpwYlot9oVmFf5l2GmkLbpMTtuv+POjYxYIeWsL9NXVvu2TLeoSPQgrVHqDJIi65HXcvAovDsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D4A12118F;
	Wed, 23 Apr 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6528713691;
	Wed, 23 Apr 2025 15:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dHqtGB8OCWjACQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/12] btrfs: rename ret to status in btrfs_submit_compressed_read()
Date: Wed, 23 Apr 2025 17:57:21 +0200
Message-ID: <cd981bf048f0480ab6d6bc5d146f6ef935dc7c63.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
References: <cover.1745422901.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6D4A12118F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

We're using 'status' for the blk_status_t variables, rename 'ret' so we can
use it for generic errors.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 59075dd865c143..a2cf97ca975f81 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -576,7 +576,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	struct extent_map *em;
 	unsigned long pflags;
 	int memstall = 0;
-	blk_status_t ret;
+	blk_status_t status;
 	int ret2;
 
 	/* we need the actual starting offset of this extent in the file */
@@ -584,7 +584,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	em = btrfs_lookup_extent_mapping(em_tree, file_offset, fs_info->sectorsize);
 	read_unlock(&em_tree->lock);
 	if (!em) {
-		ret = BLK_STS_IOERR;
+		status = BLK_STS_IOERR;
 		goto out;
 	}
 
@@ -608,13 +608,13 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
 	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct page *), GFP_NOFS);
 	if (!cb->compressed_folios) {
-		ret = BLK_STS_RESOURCE;
+		status = BLK_STS_RESOURCE;
 		goto out_free_bio;
 	}
 
 	ret2 = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios);
 	if (ret2) {
-		ret = BLK_STS_RESOURCE;
+		status = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
 	}
 
@@ -637,7 +637,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 out_free_bio:
 	bio_put(&cb->bbio.bio);
 out:
-	btrfs_bio_end_io(bbio, ret);
+	btrfs_bio_end_io(bbio, status);
 }
 
 /*
-- 
2.49.0



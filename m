Return-Path: <linux-btrfs+bounces-11860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E78A45AC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6330166840
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08324DFFF;
	Wed, 26 Feb 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E5rH//G3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E5rH//G3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824E24DFF6
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563518; cv=none; b=bERXqdM8qBSZeaI2va/3TnwZaQ04ae3f/Tlys79ovL85+obN/9PMcalEUEo1+jZ0qSw9tsMo4mwy4vjkGWIokCMUTmZmbthYI3kIcY0NFfYHGgpjrMV1QxvaHAuXSKL7Yp3oAhH3CnMLY1crv7D4L0q/C3wv6UyGuIqg4MOrQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563518; c=relaxed/simple;
	bh=zhL4K1qX0nh+O27j0ffNrfdNIQ0iSd5yRlYkNVKiR+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPmvAMFzLdT0j0XK6rZsbHPAQg7qxolTGdueYkVfXx1vv9Zw9+rpb2nVw9Og0iXBlj3cK4xnSxwshgjEK7iUoppdNoLq7Y6txTWle29+zinwGcYcKU5eEpiaFBxah9vCjS3AXyVjf0Mrf7RFLvTL7sQl36CRP49hip7Y3ifMuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E5rH//G3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E5rH//G3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36B7E1F455;
	Wed, 26 Feb 2025 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HGrr7edchDkQjHZqZasQZ7ZoTOEm/SZxq2oB8CCzDM=;
	b=E5rH//G334ipcPIxGSpnqnpcUobWzephMyzrv9eT/5xiCZ5lHPvJy5W6zLoqc/5P1laNf+
	1HA+NwbEvLgi7S8JsyfgUjqbepHQ6zIuyr1gfldaERmJ7Y6mAnI0cyhSGye82J83/Qeei2
	0HTdl3MH5Lshs3sqwXSaog3dQ3eeRRI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HGrr7edchDkQjHZqZasQZ7ZoTOEm/SZxq2oB8CCzDM=;
	b=E5rH//G334ipcPIxGSpnqnpcUobWzephMyzrv9eT/5xiCZ5lHPvJy5W6zLoqc/5P1laNf+
	1HA+NwbEvLgi7S8JsyfgUjqbepHQ6zIuyr1gfldaERmJ7Y6mAnI0cyhSGye82J83/Qeei2
	0HTdl3MH5Lshs3sqwXSaog3dQ3eeRRI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EE7413A53;
	Wed, 26 Feb 2025 09:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hvVwCxTkvmcyYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_init_root_free_objectid()
Date: Wed, 26 Feb 2025 10:51:15 +0100
Message-ID: <b8c7055dff8c3b81bb0bc08b88a2c2f7addce36d.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f0e4dd0245df..7ae9d020f12a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4898,7 +4898,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 
 int btrfs_init_root_free_objectid(struct btrfs_root *root)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 	struct extent_buffer *l;
 	struct btrfs_key search_key;
@@ -4914,14 +4914,13 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 	search_key.offset = (u64)-1;
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
 	if (ret < 0)
-		goto error;
+		return ret;
 	if (ret == 0) {
 		/*
 		 * Key with offset -1 found, there would have to exist a root
 		 * with such id, but this is out of valid range.
 		 */
-		ret = -EUCLEAN;
-		goto error;
+		return -EUCLEAN;
 	}
 	if (path->slots[0] > 0) {
 		slot = path->slots[0] - 1;
@@ -4932,10 +4931,8 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 	} else {
 		root->free_objectid = BTRFS_FIRST_FREE_OBJECTID;
 	}
-	ret = 0;
-error:
-	btrfs_free_path(path);
-	return ret;
+
+	return 0;
 }
 
 int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
-- 
2.47.1



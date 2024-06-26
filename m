Return-Path: <linux-btrfs+bounces-5979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1759175DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 03:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD801C21ACB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B30175BE;
	Wed, 26 Jun 2024 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l/GVSIyb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l/GVSIyb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06502134DE
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366478; cv=none; b=fhbwpRxOCAYFRSfeFYwVKQZ6eJBM7vV8Lf6ykoXbrQO9tP8rZ9KjSmj8d8oU+32o7gGhrMr/+Qbi2bMRqWB5684Tfgt1DMpy7nI2RLItx9pkwnOH83q3bLUSV67P9v0YHA78nivJuvFvMuO3HpJ4KSq6Y/aKGZ3Uatusca6iNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366478; c=relaxed/simple;
	bh=L9JU+MhINMS6B1fERfQYqMI2zlQEm0Ekmf/zwS82nhs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkZwDbrPxjat0U1C0eo9OOqEY7PUB9W6O2BiqwE+mIISqANU66i9a8GuVlgcqQszpfj/OF0bXqJynSbkERldqOTJ4kqOr0g6r/M2TIcn4PJX8iGCTZweEPmTrMAXOi+kAdrzXM8N5DpJvO7HflXs8nvXVJAqzx4UPs4rNd3otCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l/GVSIyb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l/GVSIyb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 443A61F8C5
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AqaazgbAyBWxneeYSEdqAxyRSm8MRDg3VvllD5q1po=;
	b=l/GVSIybe1fWzumIglA4DSWkBVIWzaXI8rdYmuMNZLJBAE5UyOJcYqKSdfFnffJO1KIveD
	OaKnOGFVIi0vNBSwd+DuhEhbz8kzkDLgNBPoHUzBxwv9lvSA2GCXjb1f10bFxswfrwLBsN
	9E5eBAroRQAkmM/aYbCid5xWJJRSA30=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="l/GVSIyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AqaazgbAyBWxneeYSEdqAxyRSm8MRDg3VvllD5q1po=;
	b=l/GVSIybe1fWzumIglA4DSWkBVIWzaXI8rdYmuMNZLJBAE5UyOJcYqKSdfFnffJO1KIveD
	OaKnOGFVIi0vNBSwd+DuhEhbz8kzkDLgNBPoHUzBxwv9lvSA2GCXjb1f10bFxswfrwLBsN
	9E5eBAroRQAkmM/aYbCid5xWJJRSA30=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5546913AD2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OO07A0lze2ZtbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:47:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: cleanup the bytenr usage inside btrfs_extent_item_to_extent_map()
Date: Wed, 26 Jun 2024 11:17:29 +0930
Message-ID: <093587f4c5586bdcb77cdbe9bb329a7ec0113c20.1719366258.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719366258.git.wqu@suse.com>
References: <cover.1719366258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 443A61F8C5
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

[HICCUP]
Before commit 85de2be7129c ("btrfs: remove extent_map::block_start
member"), we utilized @bytenr variable inside
btrfs_extent_item_to_extent_map() to calculate block_start.

But that commit removed block_start completely, we have no need to
advance @bytenr at all.

[ENHANCEMENT]
- Rename @bytenr as @disk_bytenr
- Only declare @disk_bytenr inside the if branch
- Make @disk_bytenr const and remove the modification on it

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 55703c833f3d..2cc61c792ee6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1281,7 +1281,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	const int slot = path->slots[0];
 	struct btrfs_key key;
 	u64 extent_start;
-	u64 bytenr;
 	u8 type = btrfs_file_extent_type(leaf, fi);
 	int compress_type = btrfs_file_extent_compression(leaf, fi);
 
@@ -1291,22 +1290,22 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	em->generation = btrfs_file_extent_generation(leaf, fi);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
+		const u64 disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+
 		em->start = extent_start;
 		em->len = btrfs_file_extent_end(path) - extent_start;
-		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-		if (bytenr == 0) {
+		if (disk_bytenr == 0) {
 			em->disk_bytenr = EXTENT_MAP_HOLE;
 			em->disk_num_bytes = 0;
 			em->offset = 0;
 			return;
 		}
-		em->disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+		em->disk_bytenr = disk_bytenr;
 		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		em->offset = btrfs_file_extent_offset(leaf, fi);
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 		} else {
-			bytenr += btrfs_file_extent_offset(leaf, fi);
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
-- 
2.45.2



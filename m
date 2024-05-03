Return-Path: <linux-btrfs+bounces-4711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDE8BA6D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4E3283818
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5013A411;
	Fri,  3 May 2024 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FfSra7+q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FfSra7+q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90213A41E
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716147; cv=none; b=lK9PFVyOtvp1wYrTI2SOyP8hKRC4ntbnXitfkykJ17duN5rZTHHd+gIoH6KuPSZNN8gIGcHFqzc/JFiXsfadjVveRbY+GnN6OYs9zZep5vKkB/5Ld8J/4sIt6RhFpZf89lxc6FW//LCpBQceQxI6EGvSLBm5rkBDY2+jGxtj6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716147; c=relaxed/simple;
	bh=RYPXfWGvAk3XZkidDReYofdn2hpt/HLabvn6TU1PnpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7YnNCVezWNd5C9nokeWknxzqAd2KZeJU2YSj1c2EW2+aQkeFrJqoOYg8kVTcERQYAQkO7laZbivR/FFdLLZsr5z6n3udNxuMYHW67D/e9eFwQ8CT1iEh+zhqhhacPsXaaplRopqCApWxOLia/RD+VbPX3/PwFZfuEmV7/tS564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FfSra7+q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FfSra7+q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C70A1FDBF
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXg3PCryr8oZoCDnLpwkJx4ZSsM4mdXYKlbYn80vQi0=;
	b=FfSra7+qSlcl6IYNugudxjC6CUsLIBk0JCrt9209ou9oZ1WcKPJu1xR6xMz9PrJSFTzH8W
	cGxdequB4C5psANkADkMP5TfijQubyavfLcnuB1tYAVMgT7oNARAEyHMtK4GL+6oWoVYsi
	YFQjOwzmaZy1E6BcFJPFDkxr9s6zVPA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FfSra7+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXg3PCryr8oZoCDnLpwkJx4ZSsM4mdXYKlbYn80vQi0=;
	b=FfSra7+qSlcl6IYNugudxjC6CUsLIBk0JCrt9209ou9oZ1WcKPJu1xR6xMz9PrJSFTzH8W
	cGxdequB4C5psANkADkMP5TfijQubyavfLcnuB1tYAVMgT7oNARAEyHMtK4GL+6oWoVYsi
	YFQjOwzmaZy1E6BcFJPFDkxr9s6zVPA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B59413991
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LsHCu99NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 06:02:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/11] btrfs: cleanup duplicated parameters related to btrfs_create_dio_extent()
Date: Fri,  3 May 2024 15:31:46 +0930
Message-ID: <8bdb1c42be16e32919b5e3e80aa6576c3a688d0d.1714707707.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4C70A1FDBF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email]

The following 3 parameters can be cleaned up using btrfs_file_extent
structure:

- len
  btrfs_file_extent::num_bytes

- orig_block_len
  btrfs_file_extent::disk_num_bytes

- ram_bytes
  btrfs_file_extent::ram_bytes

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a95dc2333972..09974c86d3d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6969,11 +6969,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
-						  const u64 len,
-						  const u64 orig_block_len,
-						  const u64 ram_bytes,
-						  const int type,
-						  struct btrfs_file_extent *file_extent)
+						  struct btrfs_file_extent *file_extent,
+						  const int type)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
@@ -6991,7 +6988,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (em) {
 			free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
-						    start + len - 1, false);
+					start + file_extent->num_bytes - 1, false);
 		}
 		em = ERR_CAST(ordered);
 	} else {
@@ -7034,10 +7031,9 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.ram_bytes = ins.offset;
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR,
-				     &file_extent);
+	em = btrfs_create_dio_extent(inode, dio_data, start,
+				     &file_extent,
+				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7404,10 +7400,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      file_extent.disk_num_bytes,
-					      file_extent.ram_bytes, type,
-					      &file_extent);
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
+					      &file_extent, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
-- 
2.45.0



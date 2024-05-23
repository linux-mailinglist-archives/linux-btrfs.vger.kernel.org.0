Return-Path: <linux-btrfs+bounces-5237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE808CCB9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4501C21658
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F313B5BB;
	Thu, 23 May 2024 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TXetqVaA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TXetqVaA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5118413B5A6
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440651; cv=none; b=Z3QXmRh6p4nw3KXpN5zkQ63JdcCcCU/A66Q2EMmQoVE4wS08smJyEDBjidU7E3KxSheADye6j/VyC0kvyhYgUai6NBlWH9XXT039QtarBUTzMoNIIKA22RSGvbCxNHuHpXYahxKhv2xAFmIAxUms0CKMRHFkGJqc0QJSuLP6x/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440651; c=relaxed/simple;
	bh=pvPpfQGk9yUdE8HMCQRsUC6rOXIbKOPlO/neIIvwLuU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ1hg3EiExSz5r7aHcThqb9yQNRt8FO6ejmXehnIFAO5Ga0HqGdsjpqU3fo/sF5tNOH1b0fT4whl5pjCwWAj3nS7Zp38tk4fqNMrm854ysZAJ6DWdCZEYOjcW88r740aUQPJw4T9IJRzcvin3TlKez4pqO9wsfRrj6cc63hnk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TXetqVaA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TXetqVaA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE803220E3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm/gKVhsPor6uKEojjfj1gmdWHvp4N6qUkzBoNMM8uc=;
	b=TXetqVaAayM7bkPJK8v7DQfjd9tFLuyWKpIHxZsd/CxTaSZyLSfro+8jmlPCfx0Ab/Uj14
	PVi5jw8SKsL53i99RhXVnh3vwDOFADGYlQ0/pwmic3X6SRTXw+55NphNOBq1l8gkhgT5Ou
	PGh/Hho1EG6Vza5YdiBfxo21GsCGF6E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TXetqVaA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm/gKVhsPor6uKEojjfj1gmdWHvp4N6qUkzBoNMM8uc=;
	b=TXetqVaAayM7bkPJK8v7DQfjd9tFLuyWKpIHxZsd/CxTaSZyLSfro+8jmlPCfx0Ab/Uj14
	PVi5jw8SKsL53i99RhXVnh3vwDOFADGYlQ0/pwmic3X6SRTXw+55NphNOBq1l8gkhgT5Ou
	PGh/Hho1EG6Vza5YdiBfxo21GsCGF6E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C570713A6B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FCpH0fOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/11] btrfs: cleanup duplicated parameters related to btrfs_create_dio_extent()
Date: Thu, 23 May 2024 14:33:30 +0930
Message-ID: <e5bcf2efbd816ce551b5b02bff341ccf7440770a.1716440169.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BE803220E3
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]

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
 fs/btrfs/inode.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ecafaa181201..0ec275b24adc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7004,11 +7004,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
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
@@ -7026,7 +7023,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (em) {
 			free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
-						    start + len - 1, false);
+					start + file_extent->num_bytes - 1, false);
 		}
 		em = ERR_CAST(ordered);
 	} else {
@@ -7069,10 +7066,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.ram_bytes = ins.offset;
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR,
-				     &file_extent);
+	em = btrfs_create_dio_extent(inode, dio_data, start, &file_extent,
+				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7439,10 +7434,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
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
2.45.1



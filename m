Return-Path: <linux-btrfs+bounces-5948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4F915DF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 07:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ADC28414D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2E1448E5;
	Tue, 25 Jun 2024 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oERYA5JN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oERYA5JN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E92143899
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292079; cv=none; b=Rf3OC3i+R7stNN20LehwQWLeMnCyOXiwHw4tfDTaEk9wWDKJ9x7g7TaXUioabQl8woUQJ3s8X9xP0Idcacazv0TS4SCChLhp8wTAoaI8RGia5F/dfxLBajiaz98EZ79sB5Ipi5h3tT+kx7sOLimnn/yyEdalUWdSj64sIjmctoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292079; c=relaxed/simple;
	bh=JUMmICTKSnT55CY314nWWuzM7owJJOTmgmyL2CiGjU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP34lTee8gY0tF+IUDOGMwgzseIjqZpQOLo8KRuX9PdljST1Wkcx/Pn9a6LxCTu02rePFA6euAbFUgk6VlhItY5JJoRsAp0ghDgUqK5op46ClIVJOnq7XWirDUOqUG7ua/fUFlsonNWFb1VPzC5ye6PwGkQiLv5aYRBUoBUoYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oERYA5JN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oERYA5JN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D2CF1F844
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd3cirDEkMvD+UZByMmRvY/lzsscOiHNbzdY/cdYEMo=;
	b=oERYA5JNhRdSKbJXOScVn/qC8g2VL3jZN3Pm+m0RoeC5Lw7Kw/LIURHEhJ5BIE/9nwWGDq
	pVxGWxC+an9GoqiqWJr+f3/qG4A7rEdL3yjP9PLZ7DxnoHDv+5clm/IvMlKdTo4JfnE3Pr
	QN6Eff8eDnHmAtDh6QN956isH5CSCvM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oERYA5JN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719292075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd3cirDEkMvD+UZByMmRvY/lzsscOiHNbzdY/cdYEMo=;
	b=oERYA5JNhRdSKbJXOScVn/qC8g2VL3jZN3Pm+m0RoeC5Lw7Kw/LIURHEhJ5BIE/9nwWGDq
	pVxGWxC+an9GoqiqWJr+f3/qG4A7rEdL3yjP9PLZ7DxnoHDv+5clm/IvMlKdTo4JfnE3Pr
	QN6Eff8eDnHmAtDh6QN956isH5CSCvM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 574971384C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aB0DBKpQembqdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 05:07:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: cleanup the bytenr usage inside btrfs_extent_item_to_extent_map()
Date: Tue, 25 Jun 2024 14:37:27 +0930
Message-ID: <a963c3b347e54bc23b9c0b39e8e864ae309dd148.1719291793.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719291793.git.wqu@suse.com>
References: <cover.1719291793.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D2CF1F844
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[PROBLEMS]
Before commit 85de2be7129c ("btrfs: remove extent_map::block_start
member"), we utilized @bytenr variable inside
btrfs_extent_item_to_extent_map() to calculate block_start.

But that commit removed block_start completely, we have no need to
advance @bytenr at all.

Furthermore with recent enhanced btrfs-progs check for ram_bytes
mimsatch, it turns out that for truncated ordered extents, their
ram_bytes can be smaller than disk_num_bytes.

[ENHANCEMENT]
Thankfully all above problems are not really going to affect end users,
fix them by:

- Declare @bytenr only inside the if branch and make it const
  So we can remove the unnecessary advance of @bytenr.

- Manually override extent_map::ram_bytes using disk_num_bytes
  This is for non-compressed regular/preallocated extents.

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



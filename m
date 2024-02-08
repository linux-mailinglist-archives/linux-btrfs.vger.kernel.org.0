Return-Path: <linux-btrfs+bounces-2225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D866284DC2E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DDD286860
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75F6A8DE;
	Thu,  8 Feb 2024 09:00:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA06A8C0
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382806; cv=none; b=bz2dlMrvzoEyc2GZpPLLKZ6Ltvzq0e218ZVSUqMPTnBJfHkTJzHzwMD9giCAfJnwHe7NhnexvV6Ble0dAnB2EHk538FUots6F98n18kJ9xewqLDThXVHX3Nqw6bbcJP0JsTuoQjJxRemRwRzW+GZUZ9HrUnyQtc+mseUD8poOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382806; c=relaxed/simple;
	bh=6BFobnTFgf00FG+CDK6s6X0AfwAbCXO6VQ3jFLl3yH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/ldW79rRNHhna9HQkyuiK5I7QFue68z1QxYzLB9UCfTRSA97Gb5aAyvp5vYYm9s1urH7oMdWgZt4x1OiGSor2d2l6wo8ZBYvAa2aPUrxyXvG1Ubb89+giOhoZyZ4V+2mx4YRxYdxV/ZE1wgfKWi9D6lxFfR13cnc5qkqkj9Gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DD5721E6F;
	Thu,  8 Feb 2024 09:00:03 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CEFE13984;
	Thu,  8 Feb 2024 09:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aLPeDhOYxGVuDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/14] btrfs: push errors up from add_async_extent()
Date: Thu,  8 Feb 2024 09:59:34 +0100
Message-ID: <1ad1e8edabb32fab03aa4d04c61e3cb4be08bb6e.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4DD5721E6F
X-Spam-Flag: NO

The memory allocation error in add_async_extent() is not handled
properly, return an error and push the BUG_ON to the caller. Handling it
there is not trivial so at least make it visible.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index adf11936a47e..311d252addaf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -738,7 +738,8 @@ static noinline int add_async_extent(struct async_chunk *cow,
 	struct async_extent *async_extent;
 
 	async_extent = kmalloc(sizeof(*async_extent), GFP_NOFS);
-	BUG_ON(!async_extent); /* -ENOMEM */
+	if (!async_extent)
+		return -ENOMEM;
 	async_extent->start = start;
 	async_extent->ram_size = ram_size;
 	async_extent->compressed_size = compressed_size;
@@ -1025,8 +1026,9 @@ static void compress_file_range(struct btrfs_work *work)
 	 * The async work queues will take care of doing actual allocation on
 	 * disk for these compressed pages, and will submit the bios.
 	 */
-	add_async_extent(async_chunk, start, total_in, total_compressed, pages,
-			 nr_pages, compress_type);
+	ret = add_async_extent(async_chunk, start, total_in, total_compressed, pages,
+			       nr_pages, compress_type);
+	BUG_ON(ret);
 	if (start + total_in < end) {
 		start += total_in;
 		cond_resched();
@@ -1038,8 +1040,9 @@ static void compress_file_range(struct btrfs_work *work)
 	if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && !inode->prop_compress)
 		inode->flags |= BTRFS_INODE_NOCOMPRESS;
 cleanup_and_bail_uncompressed:
-	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
-			 BTRFS_COMPRESS_NONE);
+	ret = add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
+			       BTRFS_COMPRESS_NONE);
+	BUG_ON(ret);
 free_pages:
 	if (pages) {
 		for (i = 0; i < nr_pages; i++) {
-- 
2.42.1



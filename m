Return-Path: <linux-btrfs+bounces-3816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A747C894B54
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 08:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D482841C5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 06:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35645225A2;
	Tue,  2 Apr 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cH0NFuHf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5E1B7F4
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039029; cv=none; b=HtfiI8x+3i6VFAltUYn8/eN6zv/5TXYkiMURJ1ryl0ujU46svFwatVfwCt2Dx3X2y6XCpNWKPFqBW2Zk2nAWUTr4tG7eEC/+Pckak/AY8Mc2BRq/TIqKzTRKiHQYs0fa6ZeYGIx7WXFtozy2imauzk1Xrq9ENaWlsTQIsZdlqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039029; c=relaxed/simple;
	bh=yIti+89+vMuzojZnhWzzRSJzAay6+yTq48+dmkwdCSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRqSnj3X28qPrOq3saeruaYKoNP4tXOwRnsD0wAHzavIVaIqCsigpowTSWDCYxwvnhCsTQbGtdmxAJjz85ohzhPGf5+a+kt3kePxI5AG6xxOWs5V6Jq/1qS6rkwfpIoB0sEgFze2EAF5L//6xSi3YiIWo+Xn3U+vBbQJ4wysBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cH0NFuHf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC10220CA6
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712039025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kznuLZ73hKmTB9SfL1fcALUBng+SkeAiK5OEWDLW3Vs=;
	b=cH0NFuHf5RQAA1AGXBQ82WyIAqU1pzMHDFdCuHveK+LZayj7Mwqo0zqIHPOn9AEJLuHl/p
	i0U62z7IMwCwj1duCCwMdMxdpA20WmBBX+T93SIypu1KO226IoMTX//2mxDouaKN77RStd
	xck2nqI5FHWDEaGz8yr+uuBJXWWWfTA=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04A5C13A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 06:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uO3wLHCkC2biOQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 06:23:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: simplify the inline extent map creation
Date: Tue,  2 Apr 2024 16:53:20 +1030
Message-ID: <da18eebca4fdff1e0be286c18aee0359c074d3f8.1712038308.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712038308.git.wqu@suse.com>
References: <cover.1712038308.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[33.17%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.20
X-Spam-Level: *
X-Spam-Flag: NO

With the tree-checker ensuring all inline file extents starts at file
offset 0 and has a length no larger than sectorsize, we can simplify the
calculation to assigned those fixes values directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e58fb5347e65..de3ccee38572 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1265,18 +1265,19 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	struct extent_buffer *leaf = path->nodes[0];
 	const int slot = path->slots[0];
 	struct btrfs_key key;
-	u64 extent_start, extent_end;
+	u64 extent_start;
 	u64 bytenr;
 	u8 type = btrfs_file_extent_type(leaf, fi);
 	int compress_type = btrfs_file_extent_compression(leaf, fi);
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
-	extent_end = btrfs_file_extent_end(path);
 	em->ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	em->generation = btrfs_file_extent_generation(leaf, fi);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
+		u64 extent_end = btrfs_file_extent_end(path);
+
 		em->start = extent_start;
 		em->len = extent_end - extent_start;
 		em->orig_start = extent_start -
@@ -1299,9 +1300,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
+		/* Tree-checker has ensured this. */
+		ASSERT(extent_start == 0);
+
 		em->block_start = EXTENT_MAP_INLINE;
-		em->start = extent_start;
-		em->len = extent_end - extent_start;
+		em->start = 0;
+		em->len = fs_info->sectorsize;
 		/*
 		 * Initialize orig_start and block_len with the same values
 		 * as in inode.c:btrfs_get_extent().
@@ -1336,7 +1340,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path)
 
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
 		end = btrfs_file_extent_ram_bytes(leaf, fi);
-		end = ALIGN(key.offset + end, leaf->fs_info->sectorsize);
+		end = leaf->fs_info->sectorsize;
 	} else {
 		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
 	}
-- 
2.44.0



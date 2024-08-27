Return-Path: <linux-btrfs+bounces-7590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16873961995
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59614B217F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456821D416C;
	Tue, 27 Aug 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hf002uYJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hf002uYJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE01D4163
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795757; cv=none; b=fFHngpCXTL/f7ONizi+gHTFtOzbT3GS7IqlGDnvv4t0nF8ee3ZjUwF17GM8Eo3pmgdxX3dIFBX3tXmFdqpYL3wid/ifMcXmSszXzYeHWIWhAc0c+YE/tKX2EIl+nYGTDLC3kvObgYXmzpmDfqo4lg4sM3e5w/AYyJT9vBVP/m9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795757; c=relaxed/simple;
	bh=eLtglZZvlFlDCcu7Q9ciypISUC/NYEizFlDos1hB4qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiPDnNgo5JmBd5z9htH6uJpa7+XxEiaT2oYnIqpcGQO+bGW2hDCQU3leEzOulG/xoaYH178YgTDrqtu7BacSZ5wvbAilLCOu1IVVIEYh0bE695s84aYZZuDSUD8OWqM7fK6HpI5XDAFxlQvJJuEj4RWTvKY97b3Y/3UKXrCjjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hf002uYJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hf002uYJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DC701FB85;
	Tue, 27 Aug 2024 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3QOTK5BJN0lENZv5fmLptOOmEJDFK15Y8T/4zOF7/U=;
	b=hf002uYJVZMgMNSBL5WPDyAPYhGQgwO5yQwEO8G6u8r5/yVF1CwiRgJWxiE2N53udPMIRZ
	xVZ+H7MZQ8srF1yaQ2DMuAH4DY4UEqQSeyXPquuxNYqomb09bGszTyG0/B4SwwxAsVr/XC
	6LO1j1v4+TKpwRju3/wpWjwkyacmbZc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3QOTK5BJN0lENZv5fmLptOOmEJDFK15Y8T/4zOF7/U=;
	b=hf002uYJVZMgMNSBL5WPDyAPYhGQgwO5yQwEO8G6u8r5/yVF1CwiRgJWxiE2N53udPMIRZ
	xVZ+H7MZQ8srF1yaQ2DMuAH4DY4UEqQSeyXPquuxNYqomb09bGszTyG0/B4SwwxAsVr/XC
	6LO1j1v4+TKpwRju3/wpWjwkyacmbZc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36FDD13A20;
	Tue, 27 Aug 2024 21:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CzNpDWpLzmbEGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/12] btrfs: always pass readahead state to defrag
Date: Tue, 27 Aug 2024 23:55:53 +0200
Message-ID: <30357fe0ebb414b34a44c3590e20300395f926fd.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Defrag ioctl passes readahead from the file, but autodefrag does not
have a file so the readahead state is allocated when needed.

The autodefrag loop in cleaner thread iterates over inodes so we can
simply provide an on-stack readahead state and will not need to allocate
it in btrfs_defrag_file(). The size is 32 bytes which is acceptable.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 7333512cc9dd..c92b4367995d 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -224,7 +224,8 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 #define BTRFS_DEFRAG_BATCH	1024
 
 static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
-				  struct inode_defrag *defrag)
+				  struct inode_defrag *defrag,
+				  struct file_ra_state *ra)
 {
 	struct btrfs_root *inode_root;
 	struct inode *inode;
@@ -263,9 +264,10 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	range.len = (u64)-1;
 	range.start = cur;
 	range.extent_thresh = defrag->extent_thresh;
+	file_ra_state_init(ra, inode->i_mapping);
 
 	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
+	ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
 				       BTRFS_DEFRAG_BATCH);
 	sb_end_write(fs_info->sb);
 	iput(inode);
@@ -292,6 +294,8 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 
 	atomic_inc(&fs_info->defrag_running);
 	while (1) {
+		struct file_ra_state ra = { 0 };
+
 		/* Pause the auto defragger. */
 		if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
 			break;
@@ -314,7 +318,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 		first_ino = defrag->ino + 1;
 		root_objectid = defrag->root;
 
-		btrfs_run_defrag_inode(fs_info, defrag);
+		btrfs_run_defrag_inode(fs_info, defrag, &ra);
 	}
 	atomic_dec(&fs_info->defrag_running);
 
@@ -1307,8 +1311,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		if (entry->start + range_len <= *last_scanned_ret)
 			continue;
 
-		if (ra)
-			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
+		page_cache_sync_readahead(inode->vfs_inode.i_mapping,
 				ra, NULL, entry->start >> PAGE_SHIFT,
 				((entry->start + range_len - 1) >> PAGE_SHIFT) -
 				(entry->start >> PAGE_SHIFT) + 1);
@@ -1340,7 +1343,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
  * Entry point to file defragmentation.
  *
  * @inode:	   inode to be defragged
- * @ra:		   readahead state (can be NUL)
+ * @ra:		   readahead state
  * @range:	   defrag options including range and flags
  * @newer_than:	   minimum transid to defrag
  * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
@@ -1362,12 +1365,13 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	u64 cur;
 	u64 last_byte;
 	bool do_compress = (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
-	bool ra_allocated = false;
 	int compress_type = BTRFS_COMPRESS_ZLIB;
 	int ret = 0;
 	u32 extent_thresh = range->extent_thresh;
 	pgoff_t start_index;
 
+	ASSERT(ra);
+
 	if (isize == 0)
 		return 0;
 
@@ -1396,18 +1400,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	cur = round_down(range->start, fs_info->sectorsize);
 	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
 
-	/*
-	 * If we were not given a ra, allocate a readahead context. As
-	 * readahead is just an optimization, defrag will work without it so
-	 * we don't error out.
-	 */
-	if (!ra) {
-		ra_allocated = true;
-		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
-		if (ra)
-			file_ra_state_init(ra, inode->i_mapping);
-	}
-
 	/*
 	 * Make writeback start from the beginning of the range, so that the
 	 * defrag range can be written sequentially.
@@ -1462,8 +1454,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		cond_resched();
 	}
 
-	if (ra_allocated)
-		kfree(ra);
 	/*
 	 * Update range.start for autodefrag, this will indicate where to start
 	 * in next run.
-- 
2.45.0



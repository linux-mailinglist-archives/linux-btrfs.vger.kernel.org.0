Return-Path: <linux-btrfs+bounces-10823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A6A0730B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881DF165EE2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29382218ABA;
	Thu,  9 Jan 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J5C/am2r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gg/R9FXY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B021661F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418262; cv=none; b=gc2NLuxPAi/4frUQ/CtH4eu/2Z+XhjN8fB7Fjy0RKVrxFpkiwkEPr5fFEOM7ggXPI8uBqKuFQiYa7qc4qSfDwkhRUVvnXX7SsBkMFzAJ6zdxt4YV9jCw+fESUiAXsb6OZ0KYLe2v1g7HXFWs/Mt9RDp7PkRtAGnbff45GmwRNv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418262; c=relaxed/simple;
	bh=2LutsFzyfDrXgUrpRLZtRrnZ4erTRJ55GCm+5BTTeos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj3oR0VH+vqXwFT0fAah9j+9w11a/oQnK8RNG/OXnDoOKH03KRWBOTsbmg/YXA1Heu+Nq6nCLEgvpwC6quaTTM4KwZcRdiDqPYn0AYkur2m411O3U+OG3y22/hgUeLP+if+O7cGtl9yyYT4mDmvW59Du019PC3ygDGw4RufRvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J5C/am2r; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gg/R9FXY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D38061F393;
	Thu,  9 Jan 2025 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDW+wVkJ/SaTlvtgwEsyy0G19ZsGbuDK6uLyrIyWKXQ=;
	b=J5C/am2rUhLjMDsNy+yXJFWq3hE2zyPSBsLVc6NQ7UTaKtXNVf3U3E+YhOhIP6t1kOOtmW
	T+I1gazzkXyeASF85D60yqO8nYvngVIysuM0fu8BQxQ3gdmhX6jhhVgTRMeDmeUyR59bwN
	+ZgHlVFu1bD7LUbvJjOAf4p/WZegblM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDW+wVkJ/SaTlvtgwEsyy0G19ZsGbuDK6uLyrIyWKXQ=;
	b=Gg/R9FXYRmxdSHn10jR+lSnfZWsw9TKUy/xtFJeSmVKpQdflTWVpHo2C4adKzfnhJVrd3p
	g6vmWHuK4it/gC9ep6cgb6+q34PaxkHfzMzx/ZhFOjYmukei7mEXDARqI50vmW4fjAdu1F
	Q7L6Iv+u+HAUH2SShoOFlRE62ZmQbEU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC23D139AB;
	Thu,  9 Jan 2025 10:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i1fUMdGjf2c3EQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/18] btrfs: use btrfs_inode in extent_writepage()
Date: Thu,  9 Jan 2025 11:24:17 +0100
Message-ID: <0efccf0ac1b7252196ded5d591a4bcf910b18d20.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

As extent_writepage() is internal helper we should use our inode type,
so change it from struct inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f503735c302c..eca28c99bbc8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1457,15 +1457,15 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
  */
 static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl)
 {
-	struct inode *inode = folio->mapping->host;
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const u64 page_start = folio_pos(folio);
 	int ret;
 	size_t pg_offset;
-	loff_t i_size = i_size_read(inode);
+	loff_t i_size = i_size_read(&inode->vfs_inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
 
-	trace_extent_writepage(folio, inode, bio_ctrl->wbc);
+	trace_extent_writepage(folio, &inode->vfs_inode, bio_ctrl->wbc);
 
 	WARN_ON(!folio_test_locked(folio));
 
@@ -1489,13 +1489,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret < 0)
 		goto done;
 
-	ret = writepage_delalloc(BTRFS_I(inode), folio, bio_ctrl);
+	ret = writepage_delalloc(inode, folio, bio_ctrl);
 	if (ret == 1)
 		return 0;
 	if (ret)
 		goto done;
 
-	ret = extent_writepage_io(BTRFS_I(inode), folio, folio_pos(folio),
+	ret = extent_writepage_io(inode, folio, folio_pos(folio),
 				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
@@ -1504,7 +1504,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
 done:
 	if (ret) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
+		btrfs_mark_ordered_io_finished(inode, folio,
 					       page_start, PAGE_SIZE, !ret);
 		mapping_set_error(folio->mapping, ret);
 	}
-- 
2.47.1



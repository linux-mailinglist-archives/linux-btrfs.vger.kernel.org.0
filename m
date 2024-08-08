Return-Path: <linux-btrfs+bounces-7043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F361294B67A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 08:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E091F249BC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 06:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5587186295;
	Thu,  8 Aug 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9umld8u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9umld8u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714B158214
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097186; cv=none; b=BbEJmbVIvOvYlHSC8EHUsiLYtlvPneT5wyN5yBQFYOanGSOgES01aoS3hjbr/ejoq6OjCs64kfSdFSmxo7sSadG5sta2W2dhUggGap1GIcnx5A+rC2kNQ2BRpIMYLgV+DweM3+04BqOH7LZOa17tt8Jwnhxhm2xeNyV4+tJjjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097186; c=relaxed/simple;
	bh=6z7tpt02wi4JmL56nhvKnVc9s0vH9XPoZaDOGVXhkwM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih7YHvmNZyAhMBcsTjZecesOcV23CV+iyPztptbrdqMwEv4AZQdoDWDRSbu1+tQqtidFqB8gV9hUoDSyNjWwNlRe7YoZEDjUh0ubtLAoWdxkPym2O3efWzcH53ampL3QHVTEE7Cfc3jkGGv9mz14VExY/PtcRaZsJNvz6Aoy0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9umld8u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9umld8u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D72621B5D
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723097181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmbEfT21vFKXkhj3sKf+XlI/+hoMcz37hSJXk8oBz40=;
	b=S9umld8uFEiFNiUE2ZIpQEd+nOls6Xw070gs3sOkChgUMgaZwFsog7dLQQqgvF5wFpdHtn
	YQEpvpVO635SX9O/rQxwG00dUUkzNo1VzsfPRPdoMS9vJnQUlKuzouitDftRD7g0WOPGiK
	hiTHpZ+rzkjayAz0ljDnN+AYhhri9eY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S9umld8u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723097181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmbEfT21vFKXkhj3sKf+XlI/+hoMcz37hSJXk8oBz40=;
	b=S9umld8uFEiFNiUE2ZIpQEd+nOls6Xw070gs3sOkChgUMgaZwFsog7dLQQqgvF5wFpdHtn
	YQEpvpVO635SX9O/rQxwG00dUUkzNo1VzsfPRPdoMS9vJnQUlKuzouitDftRD7g0WOPGiK
	hiTHpZ+rzkjayAz0ljDnN+AYhhri9eY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 326C713946
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QOogN1tgtGZIZgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 06:06:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: introduce extent_map::em_cached member
Date: Thu,  8 Aug 2024 15:35:59 +0930
Message-ID: <3843c1c37c19f547236a8ec2690d9b258a1c4489.1723096922.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723096922.git.wqu@suse.com>
References: <cover.1723096922.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
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
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Queue-Id: 0D72621B5D

For data read, we always pass an extent_map pointer as @em_cached for
btrfs_readpage().
And that @em_cached pointer has the same lifespan as the @bio_ctrl we
passed in, so it's a perfect match to move @em_cached into @bio_ctrl.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 822e2bf8bc99..d4ad98488c03 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -101,6 +101,8 @@ struct btrfs_bio_ctrl {
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
+	/* For read/write extent map cache. */
+	struct extent_map *em_cached;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -1003,8 +1005,8 @@ static struct extent_map *__get_extent_map(struct inode *inode,
  * XXX JDM: This needs looking at to ensure proper page locking
  * return 0 on success, otherwise return error
  */
-static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
-		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
+static int btrfs_do_readpage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl,
+			     u64 *prev_em_start)
 {
 	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -1052,7 +1054,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			break;
 		}
 		em = __get_extent_map(inode, folio, cur, end - cur + 1,
-				      em_cached);
+				      &bio_ctrl->em_cached);
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end, NULL);
 			end_folio_read(folio, false, cur, end + 1 - cur);
@@ -1160,13 +1162,12 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
-	struct extent_map *em_cached = NULL;
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
-	free_extent_map(em_cached);
+	ret = btrfs_do_readpage(folio, &bio_ctrl, NULL);
+	free_extent_map(bio_ctrl.em_cached);
 
 	/*
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
@@ -2349,16 +2350,14 @@ void btrfs_readahead(struct readahead_control *rac)
 	struct folio *folio;
 	u64 start = readahead_pos(rac);
 	u64 end = start + readahead_length(rac) - 1;
-	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	while ((folio = readahead_folio(rac)) != NULL)
-		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
+		btrfs_do_readpage(folio, &bio_ctrl, &prev_em_start);
 
-	if (em_cached)
-		free_extent_map(em_cached);
+	free_extent_map(bio_ctrl.em_cached);
 	submit_one_bio(&bio_ctrl);
 }
 
-- 
2.45.2



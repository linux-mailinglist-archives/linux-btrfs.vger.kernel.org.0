Return-Path: <linux-btrfs+bounces-2498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDD85A1B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61181F21937
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DDB2C195;
	Mon, 19 Feb 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CLlPVbcF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CLlPVbcF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351C28DC6
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341225; cv=none; b=ExR4S8l/pvKDrrxp2AkMHjgxAOR+JhSlOH7+FzitL6uNsz32/qyMfzLLqUQqNYXDeJ+i9yVbXshk9YgUud+OUPAvXh7aVi3BXwYNLzv2Yfk+IxeJYn6CiUrnRNKWW53TrOP+juVoQd1xcb9GnqgJkRorYCSLvefTYtN1AwpCh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341225; c=relaxed/simple;
	bh=nR09YlccSJtLOXQmhIvmSg2dsTxTraA9SA5bMphXMdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EawbYROwq/lK/lhagAPcYwFcxBVgNN7Kxp01hYjxGNE/wNv+NnQQfJaqk1LjbNRHJyQbt1Wrcuod1GdMDGVjWcBBGNxME7Kxa6Zqnz/jbLjfL8y7/TG4Sihr7jyP0fUoF5pXkPR7lpAXGVnnZbC/kmGPC/6h4q1owgZz8Grh/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CLlPVbcF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CLlPVbcF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B134F22301;
	Mon, 19 Feb 2024 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfUJDSgXPghCPV6sI3/ipUxiDwLtUJf+kd8OZrqSaLo=;
	b=CLlPVbcFSFT5iw6YLao1anK5X7RVxx/Kggs7gFSLcXHlMZzwq1zZISynGspCD0sOCWFMde
	Rp/lTHKqp1HgCAAMi1CSDyiawPZXipypITi3SlCzkJ9954mVmV5mv1WxE3CcP5kYV7MPe3
	tijn0R5RFM6sqlPA63P/tEZ9BbdbFZ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfUJDSgXPghCPV6sI3/ipUxiDwLtUJf+kd8OZrqSaLo=;
	b=CLlPVbcFSFT5iw6YLao1anK5X7RVxx/Kggs7gFSLcXHlMZzwq1zZISynGspCD0sOCWFMde
	Rp/lTHKqp1HgCAAMi1CSDyiawPZXipypITi3SlCzkJ9954mVmV5mv1WxE3CcP5kYV7MPe3
	tijn0R5RFM6sqlPA63P/tEZ9BbdbFZ4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AAF5D139C6;
	Mon, 19 Feb 2024 11:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CbC6KeU302WmZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:41 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/10] btrfs: open code trivial btrfs_lru_cache_size()
Date: Mon, 19 Feb 2024 12:13:06 +0100
Message-ID: <dc3826c9bcd92cf8caafc62f079d6f0df7d2cb3e.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.80%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The helper is really trivial, reading a cache size can be done directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/lru_cache.h | 5 -----
 fs/btrfs/send.c      | 7 +++----
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index 390a12b61fd2..e32906ab6faa 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -52,11 +52,6 @@ struct btrfs_lru_cache {
 #define btrfs_lru_cache_for_each_entry_safe(cache, entry, tmp)		\
 	list_for_each_entry_safe_reverse((entry), (tmp), &(cache)->lru_list, lru_list)
 
-static inline unsigned int btrfs_lru_cache_size(const struct btrfs_lru_cache *cache)
-{
-	return cache->size;
-}
-
 static inline struct btrfs_lru_cache_entry *btrfs_lru_cache_lru_entry(
 					      struct btrfs_lru_cache *cache)
 {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e96d511f9dd9..e6a9e976916c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1418,7 +1418,7 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 	struct btrfs_lru_cache_entry *raw_entry;
 	struct backref_cache_entry *entry;
 
-	if (btrfs_lru_cache_size(&sctx->backref_cache) == 0)
+	if (sctx->backref_cache.size == 0)
 		return false;
 
 	/*
@@ -1516,7 +1516,7 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 	 * transaction handle or holding fs_info->commit_root_sem, so no need
 	 * to take any lock here.
 	 */
-	if (btrfs_lru_cache_size(&sctx->backref_cache) == 1)
+	if (sctx->backref_cache.size == 1)
 		sctx->backref_cache_last_reloc_trans = fs_info->last_reloc_trans;
 }
 
@@ -2821,8 +2821,7 @@ static int cache_dir_utimes(struct send_ctx *sctx, u64 dir, u64 gen)
 
 static int trim_dir_utimes_cache(struct send_ctx *sctx)
 {
-	while (btrfs_lru_cache_size(&sctx->dir_utimes_cache) >
-	       SEND_MAX_DIR_UTIMES_CACHE_SIZE) {
+	while (sctx->dir_utimes_cache.size > SEND_MAX_DIR_UTIMES_CACHE_SIZE) {
 		struct btrfs_lru_cache_entry *lru;
 		int ret;
 
-- 
2.42.1



Return-Path: <linux-btrfs+bounces-11132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B2A21843
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F1164F84
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C4319DF4D;
	Wed, 29 Jan 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uQg/6J2e";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uQg/6J2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4719D071
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136282; cv=none; b=pCL0jEdmcgtQbp8AF300dnFBLm4047z5rA+AO8H1NgzFN5B0SbZ5Ua0DEjLrBtD44y5fwb1m6SpNykJS7W0vuWtrJc9gRkmH2DDB5bn8r//GYZL5uWcGAogSb/mpbnOkvz+uLgvLNfKGnz73GKbiFjo40xqP+GylJ4Be8O4s0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136282; c=relaxed/simple;
	bh=an17GWLU9aU3P/18Wl8TdWqtvncM48HZbiYXSOReyxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZB6EkxIKLfixW16smUGAErMXb3/R6AE6aqxlZP1L6/SDE2nDp62ie8F0WsDvDJXdtUJT4ekbNzy+wcJDS9HbgRr1MNlXgDVJGFh/SvUzwNflQIBTNJSHr6qCK3izu5MIOLSkwcsP0GpQlkiIdZJXw7yGtcyWGK+1VFIi9jBBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uQg/6J2e; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uQg/6J2e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FB85210F3
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwDMXKpeBGsDCwIldR8ByqYEeWOoW2UKJlrMYOIMfZs=;
	b=uQg/6J2eBBzBWDZzIb0jtBdLA2eAay04unsYG2TW0QkVo1HDnwkiEtVtbyEHlOAIeWtpmT
	u1N+7hf2FWDmoPcCpaUm+6WjKm1fQZCNgDb70bTWuXqUxFtMNUW+bglsco67kF/kshpJ4U
	f0JT2NefeGYEGi6u5joMOKGA7Avflh8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwDMXKpeBGsDCwIldR8ByqYEeWOoW2UKJlrMYOIMfZs=;
	b=uQg/6J2eBBzBWDZzIb0jtBdLA2eAay04unsYG2TW0QkVo1HDnwkiEtVtbyEHlOAIeWtpmT
	u1N+7hf2FWDmoPcCpaUm+6WjKm1fQZCNgDb70bTWuXqUxFtMNUW+bglsco67kF/kshpJ4U
	f0JT2NefeGYEGi6u5joMOKGA7Avflh8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BFC7137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMhxCtbamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: simplify read_extent_buffer_pages_nowait()
Date: Wed, 29 Jan 2025 18:07:22 +1030
Message-ID: <63f7d86b8672e4531a737d0522d4a7c56d371bfe.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738127135.git.wqu@suse.com>
References: <cover.1738127135.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

By using a shared bio_add_folio_nofail() with calculated
range_start/range_len, so no more explicit subpage routine needed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e68cf0542f2d..b810508555fd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3467,8 +3467,8 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 				    const struct btrfs_tree_parent_check *check)
 {
+	const int num_folios = num_extent_folios(eb);
 	struct btrfs_bio *bbio;
-	bool ret;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -3508,19 +3508,14 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
-	if (btrfs_meta_is_subpage(eb->fs_info)) {
-		ret = bio_add_folio(&bbio->bio, eb->folios[0], eb->len,
-				    eb->start - folio_pos(eb->folios[0]));
-		ASSERT(ret);
-	} else {
-		int num_folios = num_extent_folios(eb);
+	for (int i = 0; i < num_folios; i++) {
+		struct folio *folio = eb->folios[i];
+		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
+		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+				      eb->start + eb->len) - range_start;
 
-		for (int i = 0; i < num_folios; i++) {
-			struct folio *folio = eb->folios[i];
-
-			ret = bio_add_folio(&bbio->bio, folio, eb->folio_size, 0);
-			ASSERT(ret);
-		}
+		bio_add_folio_nofail(&bbio->bio, folio, range_len,
+				     offset_in_folio(folio, range_start));
 	}
 	btrfs_submit_bbio(bbio, mirror_num);
 	return 0;
-- 
2.48.1



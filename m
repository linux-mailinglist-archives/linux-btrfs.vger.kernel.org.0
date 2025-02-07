Return-Path: <linux-btrfs+bounces-11341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C26A2BA3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 05:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00491166ABE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 04:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5F233D9F;
	Fri,  7 Feb 2025 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QcVvZlMw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QcVvZlMw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA664233151
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902399; cv=none; b=taGYK1hSCZsrVwESxrHnvCscrTlJ3ekN/qtUzXKNtYhOqT9L1rsmc7YOjO1k2XFWU3Bm6YM/a7Z/IWItImOzynFbKXfWF0lsuIHAAJJ2JEqn/lDAjgkVhGvX0WdQyjPjXuODHqOOq5jn8zHVZks/R5Zgk/5As+XzD6fsZX9qK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902399; c=relaxed/simple;
	bh=Ex5pxMO0hh/19rG4yqhAeCaEWT2r+pDzZpOUX44jsds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqVKdbxXaL34UqrImm7ZEgueBRePyAF2IchQHFgCiQLElXhgpFqRyXMO1AonMdb4uyKLRg0BKwIQr++Gd2qOH/bSgpx/3R6EpEQnSWbzahxyc+h/yycgWsnJeV5mo1RpeP8Ar+GbHC5olg/u9g9Minyo66hrkMZypB+orlhhYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QcVvZlMw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QcVvZlMw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E4FD21160
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA3v5so8ml6PIl0vyKEwuJ5WOLC4r02F9l//7+rF8AQ=;
	b=QcVvZlMwRnAjlg5dLn7bPFNMoLe+8vHll8TQf1JrxK2kIiMo+n6Sim5lwNFP5cT2y0HSLN
	u8VoNjlrHNwFXk08edBgr44uqxS6jgil/18nV6VmMcKwCDJj1u1pUIOjGGrtLB19g7adJY
	ZdeMXFyznCVf+k+rMjFYz7SR4NNl6lI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA3v5so8ml6PIl0vyKEwuJ5WOLC4r02F9l//7+rF8AQ=;
	b=QcVvZlMwRnAjlg5dLn7bPFNMoLe+8vHll8TQf1JrxK2kIiMo+n6Sim5lwNFP5cT2y0HSLN
	u8VoNjlrHNwFXk08edBgr44uqxS6jgil/18nV6VmMcKwCDJj1u1pUIOjGGrtLB19g7adJY
	ZdeMXFyznCVf+k+rMjFYz7SR4NNl6lI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5695113806
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGQTBXuLpWezCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2025 04:26:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/8] btrfs: simplify read_extent_buffer_pages_nowait()
Date: Fri,  7 Feb 2025 14:56:06 +1030
Message-ID: <065aa3bb4c172f09f8c1561f1ddc2663518d1f8b.1738902149.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738902149.git.wqu@suse.com>
References: <cover.1738902149.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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
index b23d27cfdf14..1deff394ead3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3494,8 +3494,8 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 				    const struct btrfs_tree_parent_check *check)
 {
+	const int num_folios = num_extent_folios(eb);
 	struct btrfs_bio *bbio;
-	bool ret;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -3535,19 +3535,14 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
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



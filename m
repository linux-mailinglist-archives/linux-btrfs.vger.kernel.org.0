Return-Path: <linux-btrfs+bounces-8320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52234989909
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 03:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529F71C211A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9717736;
	Mon, 30 Sep 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BKTWeDAy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BKTWeDAy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331163D5
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661055; cv=none; b=qUW00ZpvrFrn2E1LmED1BAx7FfLxesYT6hw3fNrfcySVdAshLxd4ptdDr6BOsNKoHpWTAj4NvOI1pJDcZSx+icvb9gCc/0ZQBOg6Ia8b5cZPcAEg3aytsF/dGLbNRLzHZAAdCLP9Aj/opz1My8as6R/N6UT7dke6yUjPXOms3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661055; c=relaxed/simple;
	bh=AYBP7ZJB7/qci5xrVYdD9G7V2Fzp8kOFIvaGTmcv964=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfMe8gSvV7a+xbMNpY8fHG0th2obtJHKMkcT+f4+gEFjbPX6jtUDNCiaFEDsSeFYRg5fF6UZlJYNTPl6UgYbDRiLxLWT5RmaJ2TkRBDeEVca1m7YVm7u7XpZkP1fKMtVE+8lKDoX/hKCsp2BiBtbz9bFNT5q0pkQw+bFqcn9TeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BKTWeDAy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BKTWeDAy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A19521A09
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727661051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQuly3bWEQe396QExQpkceCgQMzhLeHO6dW5QQG5GA4=;
	b=BKTWeDAyzICUoX49W593GNpQeF1Sm0wUWji2uSITB09NTf4FOYxpeks8EI5N2sonrqkErd
	qRbTMPsvRfJUE9ezyS0z5y69WW1uDcXvXYUEvVQ6IN1WQd9YigptQ4bBfhYmwNRaGDFQls
	lqAumBMUT6OPgd6mFjP/4rkvAl6imCo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727661051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQuly3bWEQe396QExQpkceCgQMzhLeHO6dW5QQG5GA4=;
	b=BKTWeDAyzICUoX49W593GNpQeF1Sm0wUWji2uSITB09NTf4FOYxpeks8EI5N2sonrqkErd
	qRbTMPsvRfJUE9ezyS0z5y69WW1uDcXvXYUEvVQ6IN1WQd9YigptQ4bBfhYmwNRaGDFQls
	lqAumBMUT6OPgd6mFjP/4rkvAl6imCo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB3E613318
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yEFMJ/oD+mZvLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: simplify the page uptodate preparation for prepare_pages()
Date: Mon, 30 Sep 2024 11:20:30 +0930
Message-ID: <f7504d38c6e6938e4d50e7cee5108a7010e9e8d8.1727660754.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727660754.git.wqu@suse.com>
References: <cover.1727660754.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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

Currently inside prepare_pages(), we handle the leading and tailing page
differently, and skip the middle pages (if any).

This is to avoid reading pages which is fully covered by the dirty
range.

Refactor the code by moving all checks (alignment check, range check,
force read check) into prepare_uptodate_page().

So that prepare_pages() only need to iterate all the pages
unconditionally.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 68 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9555a3485670..cc8edf8da79d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -858,36 +858,46 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
  */
 static int prepare_uptodate_page(struct inode *inode,
 				 struct page *page, u64 pos,
-				 bool force_uptodate)
+				 u64 len, bool force_uptodate)
 {
 	struct folio *folio = page_folio(page);
+	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
+	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
 	int ret = 0;
 
-	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
-	    !PageUptodate(page)) {
-		ret = btrfs_read_folio(NULL, folio);
-		if (ret)
-			return ret;
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			unlock_page(page);
-			return -EIO;
-		}
+	if (PageUptodate(page))
+		return 0;
 
-		/*
-		 * Since btrfs_read_folio() will unlock the folio before it
-		 * returns, there is a window where btrfs_release_folio() can be
-		 * called to release the page.  Here we check both inode
-		 * mapping and PagePrivate() to make sure the page was not
-		 * released.
-		 *
-		 * The private flag check is essential for subpage as we need
-		 * to store extra bitmap using folio private.
-		 */
-		if (page->mapping != inode->i_mapping || !folio_test_private(folio)) {
-			unlock_page(page);
-			return -EAGAIN;
-		}
+	if (force_uptodate)
+		goto read;
+
+	/* The dirty range fully cover the page, no need to read it out. */
+	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
+	    IS_ALIGNED(clamp_end, PAGE_SIZE))
+		return 0;
+read:
+	ret = btrfs_read_folio(NULL, folio);
+	if (ret)
+		return ret;
+	lock_page(page);
+	if (!PageUptodate(page)) {
+		unlock_page(page);
+		return -EIO;
+	}
+
+	/*
+	 * Since btrfs_read_folio() will unlock the folio before it
+	 * returns, there is a window where btrfs_release_folio() can be
+	 * called to release the page.  Here we check both inode
+	 * mapping and PagePrivate() to make sure the page was not
+	 * released.
+	 *
+	 * The private flag check is essential for subpage as we need
+	 * to store extra bitmap using folio private.
+	 */
+	if (page->mapping != inode->i_mapping || !folio_test_private(folio)) {
+		unlock_page(page);
+		return -EAGAIN;
 	}
 	return 0;
 }
@@ -949,12 +959,8 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 			goto fail;
 		}
 
-		if (i == 0)
-			ret = prepare_uptodate_page(inode, pages[i], pos,
-						    force_uptodate);
-		if (!ret && i == num_pages - 1)
-			ret = prepare_uptodate_page(inode, pages[i],
-						    pos + write_bytes, false);
+		ret = prepare_uptodate_page(inode, pages[i], pos, write_bytes,
+					    force_uptodate);
 		if (ret) {
 			put_page(pages[i]);
 			if (!nowait && ret == -EAGAIN) {
-- 
2.46.1



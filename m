Return-Path: <linux-btrfs+bounces-8352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA398B06E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 00:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6A7283B0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BBB188CC6;
	Mon, 30 Sep 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eehlalbG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eehlalbG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C771836FA
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736455; cv=none; b=BzTpKD2mauKeh3Ocxw9jjd6spDEJcWIkAVgBKWjf4JF+uhro51Cc4WabBygYSZjakzwasPF/B3ENha7UIj1Unqan8012Kas/VouriLKgA/p4+ntBZCCleKcQu3Cqdzoi23z88bjExTfOAr/1PUnPBO4QDCS5dsqqSLCX0rvmDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736455; c=relaxed/simple;
	bh=j5vzTmivkDlnsynnh8FuLMH2lxXw97IksalKopF774w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EesNXJID3c8uWybgTfnXoKhJM48u0sj7IpJZIBTBbuM2+pYQFPAgxFrvcQJ2Dv75oCAneJloEDkVcUrqSSBg0JHgvJyJLQA0Aj33KEFUiFBAJsH5ITVGjj01XXE5sZchhgRVi0OJJpTeShEkhgcDs1m++GVhjILz+jatFvW9KlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eehlalbG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eehlalbG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AC2E219C8
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727736452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNkZxtrOc9h8eiMIPL+O3+HzbKUTZ8QYAku6Sc18GTk=;
	b=eehlalbGoiMzfyC9EL30Kupol77KiWBjoA2OMOq9X6f3uzZlf8PTv4KWT6m02Z9aF6G7tC
	Xvhk2GZ7yW/MGEZX3LElBdPGLNqGs47D0DKKM7an7BneYivo8v6l0Y9CjcHsjbB/heGSDz
	o3YJ/TbHajGlPiaHmZKD95ntjsqIRz4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727736452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNkZxtrOc9h8eiMIPL+O3+HzbKUTZ8QYAku6Sc18GTk=;
	b=eehlalbGoiMzfyC9EL30Kupol77KiWBjoA2OMOq9X6f3uzZlf8PTv4KWT6m02Z9aF6G7tC
	Xvhk2GZ7yW/MGEZX3LElBdPGLNqGs47D0DKKM7an7BneYivo8v6l0Y9CjcHsjbB/heGSDz
	o3YJ/TbHajGlPiaHmZKD95ntjsqIRz4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87E0E13A8B
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAS1EoMq+2YsGgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:47:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: simplify the page uptodate preparation for prepare_pages()
Date: Tue,  1 Oct 2024 08:17:11 +0930
Message-ID: <51064f30d856c1529d47d70dfb4f3cad46a42187.1727736323.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727736323.git.wqu@suse.com>
References: <cover.1727736323.git.wqu@suse.com>
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

Currently inside prepare_pages(), we handle the leading and tailing page
differently, and skip the middle pages (if any).

This is to avoid reading pages which is fully covered by the dirty
range.

Refactor the code by moving all checks (alignment check, range check,
force read check) into prepare_uptodate_page().

So that prepare_pages() only need to iterate all the pages
unconditionally.

And since we're here, also update prepare_uptodate_page() to use
folio API other than the old page API.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 68 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9555a3485670..c5d52fcee0be 100644
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
+	if (folio_test_uptodate(folio))
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
+	folio_lock(folio);
+	if (!folio_test_uptodate(folio)) {
+		folio_unlock(folio);
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
+		folio_unlock(folio);
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
2.46.2



Return-Path: <linux-btrfs+bounces-8408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5998C967
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503CD2846ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 23:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89C11CF5E5;
	Tue,  1 Oct 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XzKeA6b5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dUpiXqJM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9DD158218
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824699; cv=none; b=mRJkf62noan4JuxigIuGJC3t4rXodNT12dBpy6qhksp74jsVBYYKjpFPfVP9o5E+pAJfedk2xwoG6siTliWnQOVg6WgNI2+Vs8M0dAgky3dgUtKobV6P2ZBDeBNsXo1rKY7IJLPWKmZ8Z4RyJeZA+l6yxMXXcC9cEMvKZq/gAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824699; c=relaxed/simple;
	bh=vo5nLL7nZyZfk0gjpWSRFsc5RvDsUJ3aiM+t+zeSZM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWTJ0OqrEkvOTu4/nqMtyTqibUVe35cJ6IlToiInkhUsPO8CaMKftN3I3pz8KQ5lY1dLdjGb75aRwR5l2mo69yhtPY9lmM+w17/XiuxyP6PLZ/YVpX8XZilCQ3NXtsRG4q/o7AHUPkbJD0cx4vbPIuTHlp1ZlZO6LSI++Wukaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XzKeA6b5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dUpiXqJM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0DF61FCFF
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727824695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wpqgNbk08FtmT1HrBIBkL3hPd3RQ5f1ewpb3FNPNic=;
	b=XzKeA6b512RH3ySM1lD6d32mkWRRz1itfttgw4J0f20UcLNRRaRHydTq8ckJrpa7iDGYIe
	mv+nqGNscU8d56EY5+vZJlG0Wr5IAKgujEQka65/3d1jOZQV5G4iyZAls3V52WW1OcekwD
	fC3oKv/VKWdCfH65kSRG9FoqMZwjufA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dUpiXqJM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727824694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wpqgNbk08FtmT1HrBIBkL3hPd3RQ5f1ewpb3FNPNic=;
	b=dUpiXqJMT2w5P5jfz5CcHYHyVXVJQGc+5QJWlticzJ/bvc+hI0H5CHlfeK8rNc6i+1m9j/
	rdnY0+efPyI5JrYuGsQh3ZGOPW+HZEoSGAAmdqGXjefs8/vs7cQ7Tt5Pe9XEqUFKGEP8BP
	UPaMnpNe89vufwXuqbM59n6aXkiqKfA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E21D13A6E
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGACATaD/GbILgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 23:18:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: simplify the page uptodate preparation for prepare_pages()
Date: Wed,  2 Oct 2024 08:47:49 +0930
Message-ID: <82b4440f6fe1f71f85b5ef04fdd34cae7528ad4e.1727824586.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727824586.git.wqu@suse.com>
References: <cover.1727824586.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0DF61FCFF
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
 fs/btrfs/file.c | 65 ++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9555a3485670..fe4c3b31447a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -858,36 +858,43 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
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
+	if (!force_uptodate &&
+	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
+	    IS_ALIGNED(clamp_end, PAGE_SIZE))
+		return 0;
+
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
@@ -949,12 +956,8 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
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



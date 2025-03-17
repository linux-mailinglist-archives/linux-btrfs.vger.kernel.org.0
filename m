Return-Path: <linux-btrfs+bounces-12316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35771A64302
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235873A6849
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C221ABD0;
	Mon, 17 Mar 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VViy8fOk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VViy8fOk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8521ADA7
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195500; cv=none; b=nBb81dxA8rDgBbuQT+xpqpIXtdVnmi8nHXaG4pw2gFz0Ufud4cddpAuQA4nouxtFDXz/I4KI2RwGga7tiR1ENNBsxMafwTfJ59ehpsdtGadiOPzNQ7nvu4wlfZfl++7ittgoZaAXi8Wgho3sJ+Y34hSNxBwdZjg2h96gR1b7M1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195500; c=relaxed/simple;
	bh=9G4aTnWd9OUcqDQWwHSh7Uia1UXX8dK7c1pyRyv5Up4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCff/YEWrIzxNkIflW6GPGBUqwOiE9BUV+8W9n3Y9XSriDpLZ2GlHZ5hhXDS0SQvZg0ID1wHbQVj7WjvgiqSSJ/sdrCfoiGShLBMoip5OtQjRlssih1ouHpM3vIw/DUr3COVLL3j32vtmT9PC0lMswJxyPOZ5Q3alTjWRWl1ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VViy8fOk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VViy8fOk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C58E020191
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8rWJUo7UwU4/E9nJUmtbCCBG7kVAtYC3e7Ajmhe9PU=;
	b=VViy8fOk9yoPOVIj83puaD4tbP10P9vrWOwHPSfIf32UP9p9cNnyo9qveDPOgSsF2547v0
	WcwnIQIpvUgewtCDmToy39sgECle+nVTDd/+QJScboylBEKsVh9vMjhob6vQwRgzz6tIlS
	ZA2o0YYJfLyxmOOb4hPKWyC9Q5BvakE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8rWJUo7UwU4/E9nJUmtbCCBG7kVAtYC3e7Ajmhe9PU=;
	b=VViy8fOk9yoPOVIj83puaD4tbP10P9vrWOwHPSfIf32UP9p9cNnyo9qveDPOgSsF2547v0
	WcwnIQIpvUgewtCDmToy39sgECle+nVTDd/+QJScboylBEKsVh9vMjhob6vQwRgzz6tIlS
	ZA2o0YYJfLyxmOOb4hPKWyC9Q5BvakE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E446139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCVwMCHL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 8/9] btrfs: prepare btrfs_end_repair_bio() for larger data folios
Date: Mon, 17 Mar 2025 17:40:53 +1030
Message-ID: <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742195085.git.wqu@suse.com>
References: <cover.1742195085.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The function btrfs_end_repair_bio() has an ASSERT() making sure the
folio is page sized.

The reason is mostly related to the fact that later we pass a folio and
its offset into btrfs_repair_io_failure().
If we have larger folios passed in, later calculation of the folio and
its offset can go wrong, as we have extra offset to the bv_page.

Change the behavior by:

- Doing a proper folio grab
  Instead of just page_folio(bv_page), we should get the real page (as the
  bv_offset can be larger than page size), then call page_folio().

- Do extra folio offset calculation
  We can have the following cases of a bio_vec (this bv is moved
  forward by btrfs read verification):

  bv_page             bv_offset
  |                   |
  | | | | | | | | | | | | | | | | |
  |<-  folio_a  ->|<-  folio_b  ->|

  | | = a page.

In above case, the real folio should be folio_b, and offset inside that
folio should be:

  bv_offset - ((&folio_b->page - &folio_a->page) << PAGE_SHIFT).

With these changes, now btrfs_end_repair_bio() is able to handle larger
folios properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8c2eee1f1878..292c79e0855f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -156,6 +156,25 @@ static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 	}
 }
 
+static struct folio *bio_vec_get_folio(const struct bio_vec *bv)
+{
+	return page_folio(bv->bv_page + (bv->bv_offset >> PAGE_SHIFT));
+}
+
+static unsigned long bio_vec_get_folio_offset(const struct bio_vec *bv)
+{
+	struct folio *folio = bio_vec_get_folio(bv);
+
+	/*
+	 * There can be multiple physically contiguous folios queued
+	 * into the bio_vec.
+	 * Thus the first page of our folio should be at or beyond
+	 * the first page of the bio_vec.
+	 */
+	ASSERT(&folio->page >= bv->bv_page);
+	return bv->bv_offset - ((&folio->page - bv->bv_page) << PAGE_SHIFT);
+}
+
 static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 				 struct btrfs_device *dev)
 {
@@ -165,12 +184,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
 	int mirror = repair_bbio->mirror_num;
 
-	/*
-	 * We can only trigger this for data bio, which doesn't support larger
-	 * folios yet.
-	 */
-	ASSERT(folio_order(page_folio(bv->bv_page)) == 0);
-
 	if (repair_bbio->bio.bi_status ||
 	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
@@ -192,7 +205,8 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
 				  repair_bbio->file_offset, fs_info->sectorsize,
 				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				  page_folio(bv->bv_page), bv->bv_offset, mirror);
+				  bio_vec_get_folio(bv), bio_vec_get_folio_offset(bv),
+				  mirror);
 	} while (mirror != fbio->bbio->mirror_num);
 
 done:
-- 
2.48.1



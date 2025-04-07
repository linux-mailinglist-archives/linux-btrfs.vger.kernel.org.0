Return-Path: <linux-btrfs+bounces-12832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE962A7D3D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 08:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D0188A550
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 06:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9E224AF3;
	Mon,  7 Apr 2025 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VLp/jqwv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VLp/jqwv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F398224AF0
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006191; cv=none; b=dbWg/IyBzfg/RuBySZ/SGMO/722ElKq4CPAb41hj53zEZoziY5b2XjFKSC/nP0Y941i55uMDnxCvc+KpbJ7KtQ74YXAZXLSEalBDCoIg86ErELFZoOUY1+pumAodQojhqo1pDGWbbMlymrCp//5ltx16HT544aLOjrEgr3uORIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006191; c=relaxed/simple;
	bh=wwHKswYyPTGQjbh3cc/cDd9emLaJ/Rj7jsPb83t3GCE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABPQz7gIVQ2ZCV5tlvbUNY8RuRu3ZE5rEcNE39D52GSNZwOvIctgVN/yIJtUqfW0pF2Ey+WOtRuoQ8zS0Q1F/vcrzakLRkvuKf5yj5SKMZ96F6GTpWXVspby6JHGSfcg+JDqLL2+b7eK0jY00EMPlmqnPVLXFHqBiStqkWYeY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VLp/jqwv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VLp/jqwv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80A6F1F38D
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744006181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+Q033RyPSi9e/L2KMbk8QyRYG4qEvfzJFOmfQHjF88=;
	b=VLp/jqwvFtbiJz+unXWj1fWnIdM6QqxfN9+RHTHLj38uONMDL8itYwg/4KYlknqmvtMbYC
	1V8nNxYFlecrkVQM/gjfXm58qgCBYozI6o/HFsPhOabyYg+fv5zenKwRTATryMCSyTPOFE
	HDEA/Bns9/Cd68bIxUH4a14TP6Uzt6U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744006181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+Q033RyPSi9e/L2KMbk8QyRYG4qEvfzJFOmfQHjF88=;
	b=VLp/jqwvFtbiJz+unXWj1fWnIdM6QqxfN9+RHTHLj38uONMDL8itYwg/4KYlknqmvtMbYC
	1V8nNxYFlecrkVQM/gjfXm58qgCBYozI6o/HFsPhOabyYg+fv5zenKwRTATryMCSyTPOFE
	HDEA/Bns9/Cd68bIxUH4a14TP6Uzt6U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAE7913691
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EH7zHiRs82eIfwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Apr 2025 06:09:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: prepare btrfs_end_repair_bio() for larger data folios
Date: Mon,  7 Apr 2025 15:39:20 +0930
Message-ID: <f679cbeedbb0132cc657b4db7a1d3d70ff2261f0.1744005845.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744005845.git.wqu@suse.com>
References: <cover.1744005845.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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

                     real_page
   bv_page           |   bv_offset (10K)
   |                 |   |
   v                 v   v
   |        |        |       |
   |<- F1 ->|<--- Folio 2 -->|
            | result off |

   '|' is page boundary.

   The folio is the one containing that real_page.
   We want the real offset inside that folio.

   The result offset we want is of two parts:
   - the offset of the real page to the folio page
   - the offset inside that real page

   We can not use offset_in_folio() which will give an incorrect result.
   (2K instead of 6K, as folio 1 has a different order)

With these changes, now btrfs_end_repair_bio() is able to handle not
only large folios, but also multi-page bio vectors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 61 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 8c2eee1f1878..3140aa19aadc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -156,6 +156,58 @@ static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
 	}
 }
 
+/*
+ * Since a single bio_vec can merge multiple physically contiguous pages
+ * into one bio_vec entry, we can have the following case:
+ *
+ * bv_page             bv_offset
+ * v                   v
+ * |    |    |   |   |   |   |
+ *
+ * In that case we need to grab the real page where bv_offset is at.
+ */
+static struct page *bio_vec_get_real_page(const struct bio_vec *bv)
+{
+	return bv->bv_page + (bv->bv_offset >> PAGE_SHIFT);
+}
+static struct folio *bio_vec_get_folio(const struct bio_vec *bv)
+{
+	return page_folio(bio_vec_get_real_page(bv));
+}
+
+static unsigned long bio_vec_get_folio_offset(const struct bio_vec *bv)
+{
+	const struct page *real_page = bio_vec_get_real_page(bv);
+	const struct folio *folio = page_folio(real_page);
+
+	/*
+	 * The following ASCII chart is to show how the calculation is done.
+	 *
+	 *                   real_page
+	 * bv_page           |   bv_offset (10K)
+	 * |                 |   |
+	 * v                 v   v
+	 * |        |        |       |
+	 * |<- F1 ->|<--- Folio 2 -->|
+	 *          | result off |
+	 *
+	 * '|' is page boundary.
+	 *
+	 * The folio is the one containing that real_page.
+	 * We want the real offset inside that folio.
+	 *
+	 * The result offset we want is of two parts:
+	 * - the offset of the real page to the folio page
+	 * - the offset inside that real page
+	 *
+	 * We can not use offset_in_folio() which will give an incorrect result.
+	 * (2K instead of 6K, as folio 1 has a different order)
+	 */
+	ASSERT(&folio->page <= real_page);
+	return (folio_page_idx(folio, real_page) << PAGE_SHIFT) +
+		offset_in_page(bv->bv_offset);
+}
+
 static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 				 struct btrfs_device *dev)
 {
@@ -165,12 +217,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
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
@@ -192,7 +238,8 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
 				  repair_bbio->file_offset, fs_info->sectorsize,
 				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				  page_folio(bv->bv_page), bv->bv_offset, mirror);
+				  bio_vec_get_folio(bv), bio_vec_get_folio_offset(bv),
+				  mirror);
 	} while (mirror != fbio->bbio->mirror_num);
 
 done:
-- 
2.49.0



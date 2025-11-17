Return-Path: <linux-btrfs+bounces-19056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4FBC62BC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D004EBE73
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25831960C;
	Mon, 17 Nov 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OagMBGdL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OagMBGdL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4A3191AC
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364698; cv=none; b=fmeRIMSKD01yP4Nr8Gm+omYWe7dTclm/yE/P24fnpwVFi1MCNg/k6O4cDetrYVHcTLgFvuhZvp/Gq24Ae9jitS1XLFKoL62owJ8w4ZUxxUQNUtj9zkECgzMjLWr/4Pw+41dGtLo+7tn/znaiyHaUIZae0Tv10K3sL1nYazcZnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364698; c=relaxed/simple;
	bh=exUzc85urT2wtHDJqzTasedS8VA76Ghn5n6MArEFoe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9bZ7jZCSmjNa6GB0Q0CaNveRUBcMahWSEEhjJlM0tan3LVt2a2/QdaOzhZy+VFIWs8o1022lYDGHIb7oG+LV33eORqb1pWzAW6wWpVR7ylPMl2w/RVRaxqnrW1qMcMsfxVF0FonNV/0ICl7miCK4p+NuQ+MBiJX7sHMZCWf4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OagMBGdL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OagMBGdL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 800121F794
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEPPyxGOObr0NMKW2xcXnaUfpldfWkSeXA+yv9P9+NA=;
	b=OagMBGdLA2lXOppa7Ue/83TFtDz1wCFjDyid6hJSfbmOVUsOIAWxuvllNk14GX4Mj2PXTb
	odTJr3NFfBAKk8zqhofjZVSfyM4l+5BsbWe4JtXQ1Bb5leyFHb3X4JAgfngn3b+VcANGTM
	joZoyhUZRVWoB7hK1R0hA5rObtfyIfM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OagMBGdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEPPyxGOObr0NMKW2xcXnaUfpldfWkSeXA+yv9P9+NA=;
	b=OagMBGdLA2lXOppa7Ue/83TFtDz1wCFjDyid6hJSfbmOVUsOIAWxuvllNk14GX4Mj2PXTb
	odTJr3NFfBAKk8zqhofjZVSfyM4l+5BsbWe4JtXQ1Bb5leyFHb3X4JAgfngn3b+VcANGTM
	joZoyhUZRVWoB7hK1R0hA5rObtfyIfM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA7FA3EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gB/dHkPPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: prepare recover_vertical() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:44 +1030
Message-ID: <afa8cf141e301e847af33a9f6aafcc42b0bcd919.1763361991.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763361991.git.wqu@suse.com>
References: <cover.1763361991.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 800121F794
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Currently recover_vertical() assumes that every fs block can be mapped
by one page, this is blocking bs > ps support for raid56.

Prepare recover_vertical() to support bs > ps cases by:

- Introduce recover_vertical_step() helper
  Which will recover a full step (min(PAGE_SIZE, sectorsize)).

  Now recover_vertical() will do the error check for the specified
  sector, do the recover step by step, then do the sector verification.

- Fix a spelling error of get_rbio_vertical_errors()
  The old name has a typo: "veritical".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 141 ++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 95cf037cbf0f..fafd200a2eff 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1007,21 +1007,13 @@ static phys_addr_t sector_paddr_in_rbio(struct btrfs_raid_bio *rbio,
  * Similar to sector_paddr_in_rbio(), but with extra consideration for
  * bs > ps cases, where we can have multiple steps for a fs block.
  */
-static phys_addr_t step_paddr_in_rbio(struct btrfs_raid_bio *rbio,
-				      int stripe_nr, int sector_nr, int step_nr,
-				      bool bio_list_only)
+static phys_addr_t sector_step_paddr_in_rbio(struct btrfs_raid_bio *rbio,
+					     int stripe_nr, int sector_nr, int step_nr,
+					     bool bio_list_only)
 {
 	phys_addr_t ret = INVALID_PADDR;
-	int index;
+	const int index = rbio_paddr_index(rbio, stripe_nr, sector_nr, step_nr);
 
-	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->real_stripes,
-			   rbio, stripe_nr);
-	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
-			   rbio, sector_nr);
-	ASSERT_RBIO_SECTOR(step_nr >= 0 && step_nr < rbio->sector_nsteps,
-			   rbio, sector_nr);
-
-	index = (stripe_nr * rbio->stripe_nsectors + sector_nr) * rbio->sector_nsteps + step_nr;
 	ASSERT(index >= 0 && index < rbio->nr_sectors * rbio->sector_nsteps);
 
 	scoped_guard(spinlock, &rbio->bio_list_lock) {
@@ -1147,8 +1139,8 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
  * @faila and @failb will also be updated to the first and second stripe
  * number of the errors.
  */
-static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
-				     int *faila, int *failb)
+static int get_rbio_vertical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
+				    int *faila, int *failb)
 {
 	int stripe_nr;
 	int found_errors = 0;
@@ -1219,8 +1211,8 @@ static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio, struct bio_list *bio_l
 			rbio->error_bitmap);
 
 		/* Check if we have reached tolerance early. */
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
-							 NULL, NULL);
+		found_errors = get_rbio_vertical_errors(rbio, sector_nr,
+							NULL, NULL);
 		if (unlikely(found_errors > rbio->bioc->max_errors))
 			return -EIO;
 		return 0;
@@ -1367,7 +1359,7 @@ static void generate_pq_vertical_step(struct btrfs_raid_bio *rbio, unsigned int
 	/* First collect one sector from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++)
 		pointers[stripe] = kmap_local_paddr(
-				step_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
+				sector_step_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
 
 	/* Then add the parity stripe */
 	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_step_paddr(rbio, sector_nr, step_nr));
@@ -1868,41 +1860,18 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	return ret;
 }
 
-/*
- * Recover a vertical stripe specified by @sector_nr.
- * @*pointers are the pre-allocated pointers by the caller, so we don't
- * need to allocate/free the pointers again and again.
- */
-static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
-			    void **pointers, void **unmap_array)
+static void recover_vertical_step(struct btrfs_raid_bio *rbio,
+				  unsigned int sector_nr,
+				  unsigned int step_nr,
+				  int faila, int failb,
+				  void **pointers, void **unmap_array)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
-	int found_errors;
-	int faila;
-	int failb;
+	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
 	int stripe_nr;
-	int ret = 0;
 
-	/*
-	 * Now we just use bitmap to mark the horizontal stripes in
-	 * which we have data when doing parity scrub.
-	 */
-	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
-	    !test_bit(sector_nr, &rbio->dbitmap))
-		return 0;
-
-	found_errors = get_rbio_veritical_errors(rbio, sector_nr, &faila,
-						 &failb);
-	/*
-	 * No errors in the vertical stripe, skip it.  Can happen for recovery
-	 * which only part of a stripe failed csum check.
-	 */
-	if (!found_errors)
-		return 0;
-
-	if (unlikely(found_errors > rbio->bioc->max_errors))
-		return -EIO;
+	ASSERT(step_nr < rbio->sector_nsteps);
+	ASSERT(sector_nr < rbio->stripe_nsectors);
 
 	/*
 	 * Setup our array of pointers with sectors from each stripe
@@ -1918,9 +1887,9 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		 * bio list if possible.
 		 */
 		if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-			paddr = sector_paddr_in_rbio(rbio, stripe_nr, sector_nr, 0);
+			paddr = sector_step_paddr_in_rbio(rbio, stripe_nr, sector_nr, step_nr, 0);
 		} else {
-			paddr = rbio_stripe_paddr(rbio, stripe_nr, sector_nr);
+			paddr = rbio_stripe_step_paddr(rbio, stripe_nr, sector_nr, step_nr);
 		}
 		pointers[stripe_nr] = kmap_local_paddr(paddr);
 		unmap_array[stripe_nr] = pointers[stripe_nr];
@@ -1968,10 +1937,10 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		}
 
 		if (failb == rbio->real_stripes - 2) {
-			raid6_datap_recov(rbio->real_stripes, sectorsize,
+			raid6_datap_recov(rbio->real_stripes, step,
 					  faila, pointers);
 		} else {
-			raid6_2data_recov(rbio->real_stripes, sectorsize,
+			raid6_2data_recov(rbio->real_stripes, step,
 					  faila, failb, pointers);
 		}
 	} else {
@@ -1981,7 +1950,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		ASSERT(failb == -1);
 pstripe:
 		/* Copy parity block into failed block to start with */
-		memcpy(pointers[faila], pointers[rbio->nr_data], sectorsize);
+		memcpy(pointers[faila], pointers[rbio->nr_data], step);
 
 		/* Rearrange the pointer array */
 		p = pointers[faila];
@@ -1991,24 +1960,54 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		pointers[rbio->nr_data - 1] = p;
 
 		/* Xor in the rest */
-		run_xor(pointers, rbio->nr_data - 1, sectorsize);
-
+		run_xor(pointers, rbio->nr_data - 1, step);
 	}
 
+cleanup:
+	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
+		kunmap_local(unmap_array[stripe_nr]);
+}
+
+/*
+ * Recover a vertical stripe specified by @sector_nr.
+ * @*pointers are the pre-allocated pointers by the caller, so we don't
+ * need to allocate/free the pointers again and again.
+ */
+static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
+			    void **pointers, void **unmap_array)
+{
+	int found_errors;
+	int faila;
+	int failb;
+	int ret = 0;
+
 	/*
-	 * No matter if this is a RMW or recovery, we should have all
-	 * failed sectors repaired in the vertical stripe, thus they are now
-	 * uptodate.
-	 * Especially if we determine to cache the rbio, we need to
-	 * have at least all data sectors uptodate.
-	 *
-	 * If possible, also check if the repaired sector matches its data
-	 * checksum.
+	 * Now we just use bitmap to mark the horizontal stripes in
+	 * which we have data when doing parity scrub.
 	 */
+	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
+	    !test_bit(sector_nr, &rbio->dbitmap))
+		return 0;
+
+	found_errors = get_rbio_vertical_errors(rbio, sector_nr, &faila,
+						&failb);
+	/*
+	 * No errors in the vertical stripe, skip it.  Can happen for recovery
+	 * which only part of a stripe failed csum check.
+	 */
+	if (!found_errors)
+		return 0;
+
+	if (unlikely(found_errors > rbio->bioc->max_errors))
+		return -EIO;
+
+	for (int i = 0; i < rbio->sector_nsteps; i++)
+		recover_vertical_step(rbio, sector_nr, i, faila, failb,
+					    pointers, unmap_array);
 	if (faila >= 0) {
 		ret = verify_one_sector(rbio, faila, sector_nr);
 		if (ret < 0)
-			goto cleanup;
+			return ret;
 
 		set_bit(rbio_sector_index(rbio, faila, sector_nr),
 			rbio->stripe_uptodate_bitmap);
@@ -2016,15 +2015,11 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	if (failb >= 0) {
 		ret = verify_one_sector(rbio, failb, sector_nr);
 		if (ret < 0)
-			goto cleanup;
+			return ret;
 
 		set_bit(rbio_sector_index(rbio, failb, sector_nr),
 			rbio->stripe_uptodate_bitmap);
 	}
-
-cleanup:
-	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
-		kunmap_local(unmap_array[stripe_nr]);
 	return ret;
 }
 
@@ -2162,7 +2157,7 @@ static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_n
 		int faila;
 		int failb;
 
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+		found_errors = get_rbio_vertical_errors(rbio, sector_nr,
 							 &faila, &failb);
 		/* This vertical stripe doesn't have errors. */
 		if (!found_errors)
@@ -2455,7 +2450,7 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
 		int found_errors;
 
-		found_errors = get_rbio_veritical_errors(rbio, sectornr, NULL, NULL);
+		found_errors = get_rbio_vertical_errors(rbio, sectornr, NULL, NULL);
 		if (unlikely(found_errors > rbio->bioc->max_errors)) {
 			ret = -EIO;
 			break;
@@ -2735,7 +2730,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 		int failb;
 		int found_errors;
 
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+		found_errors = get_rbio_vertical_errors(rbio, sector_nr,
 							 &faila, &failb);
 		if (unlikely(found_errors > rbio->bioc->max_errors)) {
 			ret = -EIO;
@@ -2869,7 +2864,7 @@ static void scrub_rbio(struct btrfs_raid_bio *rbio)
 	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
 		int found_errors;
 
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr, NULL, NULL);
+		found_errors = get_rbio_vertical_errors(rbio, sector_nr, NULL, NULL);
 		if (unlikely(found_errors > rbio->bioc->max_errors)) {
 			ret = -EIO;
 			break;
-- 
2.51.2



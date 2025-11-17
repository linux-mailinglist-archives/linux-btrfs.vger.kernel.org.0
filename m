Return-Path: <linux-btrfs+bounces-19057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F44C62BA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826053B1F83
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B33195E4;
	Mon, 17 Nov 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gySCBMkF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gySCBMkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2B318141
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364701; cv=none; b=s0AXoixw9efvrX/mSLuJB7ERfce4xuohTIVDtcwDGeXWZpo2EoZFfryiBlTvu1lPum706RTAuefm2CZTl3BFB1TYuww/YWKLACgzgPtbOWqUEgtxTWhoBb94HC05Dp6Z+WeNljhjZ0S+L1yHx1gGDnK9zy/l9eeN3L/IpZ84lac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364701; c=relaxed/simple;
	bh=PXYZBQz3f36KdgtTJ9XnNvyhhiM1/rLgvI7yQuZ20dY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXNIFXPuaOeznCWsDUilMod8VlzibOAOWBOe3vaScWvfhIyuCYVJgxrMVuEdmxg2l0bZbaue2LnWWVWpzd0W5qaSeJluhw+ESc7hCaMN25s4XOJibm3ftJT0eQ6Wq5NNMQmnFnZrkzb+bYEnNsh/7Z/mR41dYrwANQvdTqSlRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gySCBMkF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gySCBMkF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C42B8211FF
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S06oS6lbi46IklCmE9LdfLdZIVw8gbDJik9bgd616k=;
	b=gySCBMkFjAZA11sYbtCXxQLWW6CnaAGpdL858oo1nZ8eYnu7juPEfBFQmD9U/nGAgzLINY
	nyoaL0WQBV5F1hzcrZBsUk+yqkTFqekROjPbjuMJsatLAhyfoe+hBDdB2yiuqnCPXd5MTV
	J69NtQN3qlsimvBwgFW/IoZu582Qt/Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gySCBMkF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S06oS6lbi46IklCmE9LdfLdZIVw8gbDJik9bgd616k=;
	b=gySCBMkFjAZA11sYbtCXxQLWW6CnaAGpdL858oo1nZ8eYnu7juPEfBFQmD9U/nGAgzLINY
	nyoaL0WQBV5F1hzcrZBsUk+yqkTFqekROjPbjuMJsatLAhyfoe+hBDdB2yiuqnCPXd5MTV
	J69NtQN3qlsimvBwgFW/IoZu582Qt/Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F35053EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YFt4K0nPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: prepare rbio_bio_add_io_paddr() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:49 +1030
Message-ID: <4f668c684ec8b393edcbc990990848549a25397e.1763361991.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C42B8211FF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

The function rbio_bio_add_io_paddr() assume each fs block can be mapped by
one page, blocking bs > ps support for raid56.

Prepare it for bs > ps cases by:

- Introduce a helper bio_add_paddrs()
  Previously we only need to add a single page to a bio for a fs block,
  but now we need to add multiple pages, this means we can fail halfway.

  In that case we need to properly revert the bio (only for its size
  though) for halfway failed cases.

- Rename rbio_add_io_paddr() to rbio_add_io_paddrs()
  And change the @paddr parameter to @paddrs[].

- Change all callers to use the updated rbio_add_io_paddrs()
  For the @paddrs pointer used for the new function, it can be grabbed
  using sector_paddrs_in_rbio() and rbio_stripe_paddrs() helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 106 ++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 7cb3b3eccda6..44eede8d9544 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1245,17 +1245,41 @@ static int get_rbio_vertical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
 	return found_errors;
 }
 
+static int bio_add_paddrs(struct bio *bio, phys_addr_t *paddrs, unsigned int nr_steps,
+			  unsigned int step)
+{
+	int added = 0;
+	int ret;
+
+	for (int i = 0; i < nr_steps; i++) {
+		ret = bio_add_page(bio, phys_to_page(paddrs[i]), step,
+				   offset_in_page(paddrs[i]));
+		if (ret != step)
+			goto revert;
+		added += ret;
+	}
+	return added;
+revert:
+	/*
+	 * We don't need to revert the bvec, as the bio will be submitted immediately,
+	 * as long as the size is reduced the extra bvec will not be accessed.
+	 */
+	bio->bi_iter.bi_size -= added;
+	return 0;
+}
+
 /*
  * Add a single sector @sector into our list of bios for IO.
  *
  * Return 0 if everything went well.
- * Return <0 for error.
+ * Return <0 for error, and no byte will be added to @rbio.
  */
-static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio, struct bio_list *bio_list,
-			     phys_addr_t paddr, unsigned int stripe_nr,
-			     unsigned int sector_nr, enum req_op op)
+static int rbio_add_io_paddrs(struct btrfs_raid_bio *rbio, struct bio_list *bio_list,
+			      phys_addr_t *paddrs, unsigned int stripe_nr,
+			      unsigned int sector_nr, enum req_op op)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 step = min(sectorsize, PAGE_SIZE);
 	struct bio *last = bio_list->tail;
 	int ret;
 	struct bio *bio;
@@ -1271,7 +1295,7 @@ static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio, struct bio_list *bio_l
 			   rbio, stripe_nr);
 	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
 			   rbio, sector_nr);
-	ASSERT(paddr != INVALID_PADDR);
+	ASSERT(paddrs != NULL);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
@@ -1302,8 +1326,7 @@ static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio, struct bio_list *bio_l
 		 */
 		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_bdev == stripe->dev->bdev) {
-			ret = bio_add_page(last, phys_to_page(paddr), sectorsize,
-					   offset_in_page(paddr));
+			ret = bio_add_paddrs(last, paddrs, rbio->sector_nsteps, step);
 			if (ret == sectorsize)
 				return 0;
 		}
@@ -1316,7 +1339,8 @@ static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio, struct bio_list *bio_l
 	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 	bio->bi_private = rbio;
 
-	__bio_add_page(bio, phys_to_page(paddr), sectorsize, offset_in_page(paddr));
+	ret = bio_add_paddrs(bio, paddrs, rbio->sector_nsteps, step);
+	ASSERT(ret == sectorsize);
 	bio_list_add(bio_list, bio);
 	return 0;
 }
@@ -1497,7 +1521,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	 */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
 		stripe = total_sector_nr / rbio->stripe_nsectors;
 		sectornr = total_sector_nr % rbio->stripe_nsectors;
@@ -1507,15 +1531,15 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 			continue;
 
 		if (stripe < rbio->nr_data) {
-			paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
-			if (paddr == INVALID_PADDR)
+			paddrs = sector_paddrs_in_rbio(rbio, stripe, sectornr, 1);
+			if (paddrs == NULL)
 				continue;
 		} else {
-			paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
+			paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
 		}
 
-		ret = rbio_add_io_paddr(rbio, bio_list, paddr, stripe,
-					sectornr, REQ_OP_WRITE);
+		ret = rbio_add_io_paddrs(rbio, bio_list, paddrs, stripe,
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto error;
 	}
@@ -1532,7 +1556,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
 		stripe = total_sector_nr / rbio->stripe_nsectors;
 		sectornr = total_sector_nr % rbio->stripe_nsectors;
@@ -1557,14 +1581,14 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 			continue;
 
 		if (stripe < rbio->nr_data) {
-			paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
-			if (paddr == INVALID_PADDR)
+			paddrs = sector_paddrs_in_rbio(rbio, stripe, sectornr, 1);
+			if (paddrs == NULL)
 				continue;
 		} else {
-			paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
+			paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
 		}
 
-		ret = rbio_add_io_paddr(rbio, bio_list, paddr,
+		ret = rbio_add_io_paddrs(rbio, bio_list, paddrs,
 					 rbio->real_stripes,
 					 sectornr, REQ_OP_WRITE);
 		if (ret)
@@ -2184,7 +2208,7 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 	     total_sector_nr++) {
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
 		/*
 		 * Skip the range which has error.  It can be a range which is
@@ -2201,9 +2225,9 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 
-		paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
-		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, stripe,
-					sectornr, REQ_OP_READ);
+		paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
+		ret = rbio_add_io_paddrs(rbio, &bio_list, paddrs, stripe,
+					 sectornr, REQ_OP_READ);
 		if (ret < 0) {
 			bio_list_put(&bio_list);
 			goto out;
@@ -2393,11 +2417,11 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	     total_sector_nr++) {
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
-		paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
-		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, stripe,
-					sectornr, REQ_OP_READ);
+		paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
+		ret = rbio_add_io_paddrs(rbio, &bio_list, paddrs, stripe,
+					 sectornr, REQ_OP_READ);
 		if (ret) {
 			bio_list_put(&bio_list);
 			return ret;
@@ -2751,11 +2775,11 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * everything else.
 	 */
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
-		paddr = rbio_stripe_paddr(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, rbio->scrubp,
-					sectornr, REQ_OP_WRITE);
+		paddrs = rbio_stripe_paddrs(rbio, rbio->scrubp, sectornr);
+		ret = rbio_add_io_paddrs(rbio, &bio_list, paddrs, rbio->scrubp,
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2769,11 +2793,11 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 */
 	ASSERT_RBIO(rbio->bioc->replace_stripe_src >= 0, rbio);
 	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
-		paddr = rbio_stripe_paddr(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, rbio->real_stripes,
-					sectornr, REQ_OP_WRITE);
+		paddrs = rbio_stripe_paddrs(rbio, rbio->scrubp, sectornr);
+		ret = rbio_add_io_paddrs(rbio, &bio_list, paddrs, rbio->real_stripes,
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2889,7 +2913,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 	     total_sector_nr++) {
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		phys_addr_t paddr;
+		phys_addr_t *paddrs;
 
 		/* No data in the vertical stripe, no need to read. */
 		if (!test_bit(sectornr, &rbio->dbitmap))
@@ -2900,11 +2924,11 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 		 * read them from the disk. If sector_paddr_in_rbio() finds a sector
 		 * in the bio list we don't need to read it off the stripe.
 		 */
-		paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
-		if (paddr == INVALID_PADDR)
+		paddrs = sector_paddrs_in_rbio(rbio, stripe, sectornr, 1);
+		if (paddrs == NULL)
 			continue;
 
-		paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
+		paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
 		/*
 		 * The bio cache may have handed us an uptodate sector.  If so,
 		 * use it.
@@ -2913,8 +2937,8 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 			     rbio->stripe_uptodate_bitmap))
 			continue;
 
-		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, stripe,
-					sectornr, REQ_OP_READ);
+		ret = rbio_add_io_paddrs(rbio, &bio_list, paddrs, stripe,
+					 sectornr, REQ_OP_READ);
 		if (ret) {
 			bio_list_put(&bio_list);
 			return ret;
-- 
2.51.2



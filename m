Return-Path: <linux-btrfs+bounces-19054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A4C62BB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D073F4E9267
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B8319609;
	Mon, 17 Nov 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lm6jMHUL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lm6jMHUL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B63191AC
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364691; cv=none; b=N4l41cGVKEa9JqmKqvbiVZRfGGjn0trqfFm4xRnJHc9xg2MGvQkvQO+vVQcZBTwz7XxipXKvBeRLrvzhdKv3Pjjc1d4TtD7P56YElOV3by+Tz6pi8VltjXYrES8cL/RX7PyRzMbnLJWREwHlYB6RJnzwZqcG+Q7KNlAoJUIO6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364691; c=relaxed/simple;
	bh=JUUXY1yncNaHIpCGVrTTIWknMiwYYPb28DZWMp9kzCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUo3srs0hzb9rWQ1b5EKaywtuVhmXOVvZ8a9nR54UYZj3UInrZq6JQQWP0yzb9utpuJzihgvlv73VbTVVMgJdti65TrOG5uYvoRaUIZM63t6/CdLxiX/B6CZ+8AthRpYWnvfB2IT7dtwbQZSk75dIVGEUHUJejHr8Hc/gZrTUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lm6jMHUL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lm6jMHUL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 460021F78F
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh7Ser1S9MOR5EHaGqUVsWxNokHjYeibV744g2hPNAo=;
	b=lm6jMHULGmnvA7rDzul1njZEH8hFeeQESkqLAEpAY9WXLhSYeGQBXQSH4zcizSVpan+Zdi
	f4AgESMu4OOwjwsFrvQIUJBzfep4j7m5uN4WrqzxGG6p867uRrkXQvIiCjPjJsMC3jeo56
	S+auiN2NsGoQYTWGd2wsB3hqua0qnR0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh7Ser1S9MOR5EHaGqUVsWxNokHjYeibV744g2hPNAo=;
	b=lm6jMHULGmnvA7rDzul1njZEH8hFeeQESkqLAEpAY9WXLhSYeGQBXQSH4zcizSVpan+Zdi
	f4AgESMu4OOwjwsFrvQIUJBzfep4j7m5uN4WrqzxGG6p867uRrkXQvIiCjPjJsMC3jeo56
	S+auiN2NsGoQYTWGd2wsB3hqua0qnR0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 809633EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YAerEELPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/12] btrfs: prepare generate_pq_vertical() for bs > ps cases
Date: Mon, 17 Nov 2025 18:00:43 +1030
Message-ID: <e825ff22cc21760d72e005b93390e0dae2521fbf.1763361991.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

Unlike btrfs_calculate_block_csum_pages(), we can not handle multiple
pages at the same time for pq generation.

So here we introduce a new @step_nr, and various helpers to grab the
sub-block page from the rbio, and generate the P/Q stripe page by page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 92 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 7f01178be7d8..95cf037cbf0f 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -711,20 +711,25 @@ static phys_addr_t rbio_stripe_paddr(const struct btrfs_raid_bio *rbio,
 	return rbio->stripe_paddrs[rbio_paddr_index(rbio, stripe_nr, sector_nr, 0)];
 }
 
-/* Grab a paddr inside P stripe */
-static phys_addr_t rbio_pstripe_paddr(const struct btrfs_raid_bio *rbio,
-				      unsigned int sector_nr)
+static phys_addr_t rbio_stripe_step_paddr(const struct btrfs_raid_bio *rbio,
+					  unsigned int stripe_nr, unsigned int sector_nr,
+					  unsigned int step_nr)
 {
-	return rbio_stripe_paddr(rbio, rbio->nr_data, sector_nr);
+	return rbio->stripe_paddrs[rbio_paddr_index(rbio, stripe_nr, sector_nr, step_nr)];
 }
 
-/* Grab a paddr inside Q stripe, return INVALID_PADDR if not RAID6 */
-static phys_addr_t rbio_qstripe_paddr(const struct btrfs_raid_bio *rbio,
-				      unsigned int sector_nr)
+static phys_addr_t rbio_pstripe_step_paddr(const struct btrfs_raid_bio *rbio,
+					   unsigned int sector_nr, unsigned int step_nr)
+{
+	return rbio_stripe_step_paddr(rbio, rbio->nr_data, sector_nr, step_nr);
+}
+
+static phys_addr_t rbio_qstripe_step_paddr(const struct btrfs_raid_bio *rbio,
+					   unsigned int sector_nr, unsigned int step_nr)
 {
 	if (rbio->nr_data + 1 == rbio->real_stripes)
 		return INVALID_PADDR;
-	return rbio_stripe_paddr(rbio, rbio->nr_data + 1, sector_nr);
+	return rbio_stripe_step_paddr(rbio, rbio->nr_data + 1, sector_nr, step_nr);
 }
 
 /*
@@ -998,6 +1003,38 @@ static phys_addr_t sector_paddr_in_rbio(struct btrfs_raid_bio *rbio,
 	return rbio->stripe_paddrs[index];
 }
 
+/*
+ * Similar to sector_paddr_in_rbio(), but with extra consideration for
+ * bs > ps cases, where we can have multiple steps for a fs block.
+ */
+static phys_addr_t step_paddr_in_rbio(struct btrfs_raid_bio *rbio,
+				      int stripe_nr, int sector_nr, int step_nr,
+				      bool bio_list_only)
+{
+	phys_addr_t ret = INVALID_PADDR;
+	int index;
+
+	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->real_stripes,
+			   rbio, stripe_nr);
+	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
+			   rbio, sector_nr);
+	ASSERT_RBIO_SECTOR(step_nr >= 0 && step_nr < rbio->sector_nsteps,
+			   rbio, sector_nr);
+
+	index = (stripe_nr * rbio->stripe_nsectors + sector_nr) * rbio->sector_nsteps + step_nr;
+	ASSERT(index >= 0 && index < rbio->nr_sectors * rbio->sector_nsteps);
+
+	scoped_guard(spinlock, &rbio->bio_list_lock) {
+		if (rbio->bio_paddrs[index] != INVALID_PADDR || bio_list_only) {
+			/* Don't return sector without a valid page pointer */
+			if (rbio->bio_paddrs[index] != INVALID_PADDR)
+				ret = rbio->bio_paddrs[index];
+			return ret;
+		}
+	}
+	return rbio->stripe_paddrs[index];
+}
+
 /*
  * allocation and initial setup for the btrfs_raid_bio.  Not
  * this does not allocate any pages for rbio->pages.
@@ -1319,45 +1356,56 @@ static inline void *kmap_local_paddr(phys_addr_t paddr)
 	return kmap_local_page(phys_to_page(paddr)) + offset_in_page(paddr);
 }
 
-/* Generate PQ for one vertical stripe. */
-static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
+static void generate_pq_vertical_step(struct btrfs_raid_bio *rbio, unsigned int sector_nr,
+				      unsigned int step_nr)
 {
 	void **pointers = rbio->finish_pointers;
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 step = min(rbio->bioc->fs_info->sectorsize, PAGE_SIZE);
 	int stripe;
 	const bool has_qstripe = rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6;
 
 	/* First collect one sector from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++)
 		pointers[stripe] = kmap_local_paddr(
-				sector_paddr_in_rbio(rbio, stripe, sectornr, 0));
+				step_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
 
 	/* Then add the parity stripe */
-	set_bit(rbio_sector_index(rbio, rbio->nr_data, sectornr),
-		rbio->stripe_uptodate_bitmap);
-	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_paddr(rbio, sectornr));
+	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_step_paddr(rbio, sector_nr, step_nr));
 
 	if (has_qstripe) {
 		/*
 		 * RAID6, add the qstripe and call the library function
 		 * to fill in our p/q
 		 */
-		set_bit(rbio_sector_index(rbio, rbio->nr_data + 1, sectornr),
-			rbio->stripe_uptodate_bitmap);
-		pointers[stripe++] = kmap_local_paddr(rbio_qstripe_paddr(rbio, sectornr));
+		pointers[stripe++] = kmap_local_paddr(
+				rbio_qstripe_step_paddr(rbio, sector_nr, step_nr));
 
 		assert_rbio(rbio);
-		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
-					pointers);
+		raid6_call.gen_syndrome(rbio->real_stripes, step, pointers);
 	} else {
 		/* raid5 */
-		memcpy(pointers[rbio->nr_data], pointers[0], sectorsize);
-		run_xor(pointers + 1, rbio->nr_data - 1, sectorsize);
+		memcpy(pointers[rbio->nr_data], pointers[0], step);
+		run_xor(pointers + 1, rbio->nr_data - 1, step);
 	}
 	for (stripe = stripe - 1; stripe >= 0; stripe--)
 		kunmap_local(pointers[stripe]);
 }
 
+/* Generate PQ for one vertical stripe. */
+static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
+{
+	const bool has_qstripe = rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6;
+
+	for (int i = 0; i < rbio->sector_nsteps; i++)
+		generate_pq_vertical_step(rbio, sectornr, i);
+
+	set_bit(rbio_sector_index(rbio, rbio->nr_data, sectornr),
+		rbio->stripe_uptodate_bitmap);
+	if (has_qstripe)
+		set_bit(rbio_sector_index(rbio, rbio->nr_data + 1, sectornr),
+			rbio->stripe_uptodate_bitmap);
+}
+
 static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 				   struct bio_list *bio_list)
 {
-- 
2.51.2



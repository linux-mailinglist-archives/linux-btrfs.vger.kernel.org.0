Return-Path: <linux-btrfs+bounces-19062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB6FC62BB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F9BD354D56
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374A319871;
	Mon, 17 Nov 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AljEeIQy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AljEeIQy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CC319864
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364717; cv=none; b=fYwfcd9nidA1W2zZ1fxmSqxaIV2b4lScHp9IULWdsZZkyeniEs7iKvHuwT881ONIoX38SThs0FidyKHIJyN3apE5fZmnezz58IybmiuZPjVT17ULImykHJ9fPdUinIEIC8IU+70QQnqLKwU4vSGOa+KDSCVSCGaAvN56WYJ7Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364717; c=relaxed/simple;
	bh=v9etlv3qf6cNmPAcRgLUKI2ksww7HkTLvjEJAkfD0TQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvshJpQ4hg5xfFLzPaqZ7ICRG9D7NCenB9XxZgY0KmfWDKQJ0bwy2zt/QYeR4vKEBZnQ9NhGDEk8PlC0SUXOHr/9+u1pGBPwfDI87pX1FGrnaj/oInnYFoDBIgUaYb274vZDM7pHQYVtskxzylwkuFdzbnEfUI5K4I/F6QIhjOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AljEeIQy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AljEeIQy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 765731F78E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiouILAgIM4tXowev8B1xcZGwbgs285sA5keKG2kfyA=;
	b=AljEeIQyjMMU3jMLSF156jt5AQFblLnu8CbJuBuwByRt/xvmZUrta5PwHGUOuJvXUNZyZS
	zRS14Ci7p8l5NbC/LIBMU1dqNVMPvkvqiXho77n5drS6Mpmh/mDFopghq3wAubAcWKNS/C
	N0xY4o88hZ/YhgkLmNkrfHesRc286qY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AljEeIQy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiouILAgIM4tXowev8B1xcZGwbgs285sA5keKG2kfyA=;
	b=AljEeIQyjMMU3jMLSF156jt5AQFblLnu8CbJuBuwByRt/xvmZUrta5PwHGUOuJvXUNZyZS
	zRS14Ci7p8l5NbC/LIBMU1dqNVMPvkvqiXho77n5drS6Mpmh/mDFopghq3wAubAcWKNS/C
	N0xY4o88hZ/YhgkLmNkrfHesRc286qY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFC783EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENs0HE3PGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/12] btrfs: remove the "_step" infix
Date: Mon, 17 Nov 2025 18:00:52 +1030
Message-ID: <d8eb038cd68cd315ccfdea7e87b15cc600a16349.1763361991.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 765731F78E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

The following functions are introduced as a middle step for bs > ps
support:

- rbio_streip_step_paddr()
- rbio_pstripe_step_paddr()
- rbio_qstripe_step_paddr()
- sector_step_paddr_in_rbio()

As there is already an existing function without the infix, and has a
different parameter list.

But now those existing functions are cleaned up, there is no need to
keep the "_step" infix, just remove the infix completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ec6427565f25..26c1e0e8a1a8 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -735,25 +735,25 @@ static unsigned int rbio_paddr_index(const struct btrfs_raid_bio *rbio,
 	return ret;
 }
 
-static phys_addr_t rbio_stripe_step_paddr(const struct btrfs_raid_bio *rbio,
+static phys_addr_t rbio_stripe_paddr(const struct btrfs_raid_bio *rbio,
 					  unsigned int stripe_nr, unsigned int sector_nr,
 					  unsigned int step_nr)
 {
 	return rbio->stripe_paddrs[rbio_paddr_index(rbio, stripe_nr, sector_nr, step_nr)];
 }
 
-static phys_addr_t rbio_pstripe_step_paddr(const struct btrfs_raid_bio *rbio,
+static phys_addr_t rbio_pstripe_paddr(const struct btrfs_raid_bio *rbio,
 					   unsigned int sector_nr, unsigned int step_nr)
 {
-	return rbio_stripe_step_paddr(rbio, rbio->nr_data, sector_nr, step_nr);
+	return rbio_stripe_paddr(rbio, rbio->nr_data, sector_nr, step_nr);
 }
 
-static phys_addr_t rbio_qstripe_step_paddr(const struct btrfs_raid_bio *rbio,
+static phys_addr_t rbio_qstripe_paddr(const struct btrfs_raid_bio *rbio,
 					   unsigned int sector_nr, unsigned int step_nr)
 {
 	if (rbio->nr_data + 1 == rbio->real_stripes)
 		return INVALID_PADDR;
-	return rbio_stripe_step_paddr(rbio, rbio->nr_data + 1, sector_nr, step_nr);
+	return rbio_stripe_paddr(rbio, rbio->nr_data + 1, sector_nr, step_nr);
 }
 
 /* Return a paddr pointer into the rbio::stripe_paddrs[] for the specified sector. */
@@ -1033,9 +1033,9 @@ static phys_addr_t *sector_paddrs_in_rbio(struct btrfs_raid_bio *rbio,
  * Similar to sector_paddr_in_rbio(), but with extra consideration for
  * bs > ps cases, where we can have multiple steps for a fs block.
  */
-static phys_addr_t sector_step_paddr_in_rbio(struct btrfs_raid_bio *rbio,
-					     int stripe_nr, int sector_nr, int step_nr,
-					     bool bio_list_only)
+static phys_addr_t sector_paddr_in_rbio(struct btrfs_raid_bio *rbio,
+					int stripe_nr, int sector_nr, int step_nr,
+					bool bio_list_only)
 {
 	phys_addr_t ret = INVALID_PADDR;
 	const int index = rbio_paddr_index(rbio, stripe_nr, sector_nr, step_nr);
@@ -1413,10 +1413,10 @@ static void generate_pq_vertical_step(struct btrfs_raid_bio *rbio, unsigned int
 	/* First collect one sector from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++)
 		pointers[stripe] = kmap_local_paddr(
-				sector_step_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
+				sector_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
 
 	/* Then add the parity stripe */
-	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_step_paddr(rbio, sector_nr, step_nr));
+	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_paddr(rbio, sector_nr, step_nr));
 
 	if (has_qstripe) {
 		/*
@@ -1424,7 +1424,7 @@ static void generate_pq_vertical_step(struct btrfs_raid_bio *rbio, unsigned int
 		 * to fill in our p/q
 		 */
 		pointers[stripe++] = kmap_local_paddr(
-				rbio_qstripe_step_paddr(rbio, sector_nr, step_nr));
+				rbio_qstripe_paddr(rbio, sector_nr, step_nr));
 
 		assert_rbio(rbio);
 		raid6_call.gen_syndrome(rbio->real_stripes, step, pointers);
@@ -1958,9 +1958,9 @@ static void recover_vertical_step(struct btrfs_raid_bio *rbio,
 		 * bio list if possible.
 		 */
 		if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-			paddr = sector_step_paddr_in_rbio(rbio, stripe_nr, sector_nr, step_nr, 0);
+			paddr = sector_paddr_in_rbio(rbio, stripe_nr, sector_nr, step_nr, 0);
 		} else {
-			paddr = rbio_stripe_step_paddr(rbio, stripe_nr, sector_nr, step_nr);
+			paddr = rbio_stripe_paddr(rbio, stripe_nr, sector_nr, step_nr);
 		}
 		pointers[stripe_nr] = kmap_local_paddr(paddr);
 		unmap_array[stripe_nr] = pointers[stripe_nr];
@@ -2651,7 +2651,7 @@ static bool verify_one_parity_step(struct btrfs_raid_bio *rbio,
 	/* first collect one page from each data stripe */
 	for (int stripe = 0; stripe < nr_data; stripe++)
 		pointers[stripe] = kmap_local_paddr(
-				sector_step_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
+				sector_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
 
 	if (has_qstripe) {
 		assert_rbio(rbio);
@@ -2664,7 +2664,7 @@ static bool verify_one_parity_step(struct btrfs_raid_bio *rbio,
 	}
 
 	/* Check scrubbing parity and repair it */
-	parity = kmap_local_paddr(rbio_stripe_step_paddr(rbio, rbio->scrubp, sector_nr, step_nr));
+	parity = kmap_local_paddr(rbio_stripe_paddr(rbio, rbio->scrubp, sector_nr, step_nr));
 	if (memcmp(parity, pointers[rbio->scrubp], step) != 0)
 		memcpy(parity, pointers[rbio->scrubp], step);
 	else
-- 
2.51.2



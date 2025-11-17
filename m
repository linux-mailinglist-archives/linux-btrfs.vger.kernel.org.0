Return-Path: <linux-btrfs+bounces-19058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAFC62BAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8EF135AF85
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69601319609;
	Mon, 17 Nov 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rjQRDMC7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rjQRDMC7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587B30BF75
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364704; cv=none; b=gdxdA6yp4q1EJQWJ2ixIy2nV8uwHV8H5iZA4Rclp4sL43j0qQvTYJnX8NcEfJ8tRJtDSntfgdzP4xz8teaQSefDXDkhL9G8UlWLOPoCZGRmLT6A0aaZjLharZvdgvmSVkiJqfEwoqkcdNuHgpjFSIUsYrec6KrtEmEOPs/1YydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364704; c=relaxed/simple;
	bh=/eEqEsmc0Gjd1w5QsQN/UeunhlrV9dJRNDnxDRomfTA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz9mtpIIj3JruHf2wv8RKWqj2W9QOF3MFx++iqgv7iHMC3cOpEB21uKeX4Bw1uKVadNLxKHndeAxE7Lb3v3oX7zBsQQsTqT4TICehmP515gZWC+jxyW+I1Uh5kztJej2ts+lKHQ4J1xJOB4s5J4aU+SLOoIn/sWOJQs5KmhrfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rjQRDMC7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rjQRDMC7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01B541F796
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OnsJLVEdDCo4pofwdehDorcWTrHHDkhZjSHJmivasQ=;
	b=rjQRDMC7HEgMmjXapdcVr/s059dY1j5XNYqMlCuuOs2aSjjA2ZXvdUPTjByeSs/bCSWpQb
	kMsW67mfph6Q2+hAy4unoGJiydr2QuCKl39NTUKm6aOoEseco5QO0HNYY2NcNkGXRTC787
	xvcZX6JOvPC6WNaRzFLWtJAZgv10UWI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rjQRDMC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OnsJLVEdDCo4pofwdehDorcWTrHHDkhZjSHJmivasQ=;
	b=rjQRDMC7HEgMmjXapdcVr/s059dY1j5XNYqMlCuuOs2aSjjA2ZXvdUPTjByeSs/bCSWpQb
	kMsW67mfph6Q2+hAy4unoGJiydr2QuCKl39NTUKm6aOoEseco5QO0HNYY2NcNkGXRTC787
	xvcZX6JOvPC6WNaRzFLWtJAZgv10UWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B3E43EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLBUO0XPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: prepare verify_bio_data_sectors() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:46 +1030
Message-ID: <91cef07b9d4127b97b23b567bde0674e63ef210f.1763361991.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 01B541F796
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim];
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

The function verify_bio_data_sectors() assume each fs block can be mapped by
one page, blocking bs > ps support for raid56.

Prepare it for bs > ps cases by:

- Make get_bio_sector_nr() to consider bs > ps cases
  The function is utilized to calculate the sector number of a device
  bio submitted by btrfs raid56 layer.

- Assemble a local paddrs[] for checksum calculation

- Open code btrfs_check_block_csum()
  btrfs_check_block_csum() only supports fs blocks backed by large
  folios.

  But for raid56 we can have fs blocks backed by multiple incontiguous
  pages, e.g. direct IO, encoded read/write/send.

  So instead of using btrfs_check_block_csum(), open code it to use
  btrfs_calculate_block_csum_pages().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 07d452439e37..6d9d9d494721 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1620,9 +1620,9 @@ static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 	int i;
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
-		if (rbio->stripe_paddrs[i] == bvec_paddr)
+		if (rbio->stripe_paddrs[i * rbio->sector_nsteps] == bvec_paddr)
 			break;
-		if (rbio->bio_paddrs[i] == bvec_paddr)
+		if (rbio->bio_paddrs[i * rbio->sector_nsteps] == bvec_paddr)
 			break;
 	}
 	ASSERT(i < rbio->nr_sectors);
@@ -1655,7 +1655,11 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 				    struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
+	const u32 nr_steps = rbio->sector_nsteps;
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
+	u32 offset = 0;
+	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
 	phys_addr_t paddr;
 
 	/* No data csum for the whole stripe, no need to verify. */
@@ -1666,18 +1670,24 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 	if (total_sector_nr >= rbio->nr_data * rbio->stripe_nsectors)
 		return;
 
-	btrfs_bio_for_each_block_all(paddr, bio, fs_info->sectorsize) {
+	btrfs_bio_for_each_block_all(paddr, bio, step) {
 		u8 csum_buf[BTRFS_CSUM_SIZE];
-		u8 *expected_csum = rbio->csum_buf + total_sector_nr * fs_info->csum_size;
-		int ret;
+		u8 *expected_csum;
+
+		paddrs[(offset / step) % nr_steps] = paddr;
+		offset += step;
+
+		/* Not yet covering the full fs block, continue to the next step. */
+		if (!IS_ALIGNED(offset, fs_info->sectorsize))
+			continue;
 
 		/* No csum for this sector, skip to the next sector. */
 		if (!test_bit(total_sector_nr, rbio->csum_bitmap))
 			continue;
 
-		ret = btrfs_check_block_csum(fs_info, paddr,
-					     csum_buf, expected_csum);
-		if (ret < 0)
+		expected_csum = rbio->csum_buf + total_sector_nr * fs_info->csum_size;
+		btrfs_calculate_block_csum_pages(fs_info, paddrs, csum_buf);
+		if (unlikely(memcmp(csum_buf, expected_csum, fs_info->csum_size) != 0))
 			set_bit(total_sector_nr, rbio->error_bitmap);
 		total_sector_nr++;
 	}
-- 
2.51.2



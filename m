Return-Path: <linux-btrfs+bounces-19053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B4C62BA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C8FE35B55E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B77318143;
	Mon, 17 Nov 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="THX8u33a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="THX8u33a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7435CBB7
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364688; cv=none; b=fJ4Z0wgPwJFto7Ct0kppbyRZCcIe0fjopVM71yJRfQk8r0pntVT0lGC4UwIKZxYYx4gWE+NL5aJkEe0yODojFF4OSOqp9/lrzbKpNb+tZmN3X09b8s2MPgVM5J70V37QBIhnDFu7mbSqZhXqXn4JKSnIHtPRAUebyLeQHL1dwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364688; c=relaxed/simple;
	bh=BgwHqu9eQuTbBYjqqujLTHfhY0uFzft34etD7GvWjEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBMT/+0fPe1zVotsNR5gECT/1EPgCvOhScVWqSeJX4yb9Jt+lBefmg2H02zlDzjLsxL6wLo1wzddCFZm7PEwwxLennoubNIzWJfpBP5662E+BylCdaA0WEhToWQLmJSrvwcIDlQehVzhmD3MxZELSZ13vFEoX8v0hSnjZocOr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=THX8u33a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=THX8u33a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4A17211FC
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rK0p+fEmdFHLdv+bkEOQGrHjHdl0mcQeTMBZjngScwg=;
	b=THX8u33ae+4rCymr0kJ/4Q+ZB59FaOB5057yU8E65iXFNIyWgK+DUmWHlNwMpdA84ZxFm8
	fIZp/gdZqK0TQ5eCZ8QInGDXHDMDZD5qk66Ncwt01D29TvHxeCX1gza/vobtvntS/syvnP
	NtCCUCxpOQ/ugRWPKwxd5Cd13tUUlLE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=THX8u33a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rK0p+fEmdFHLdv+bkEOQGrHjHdl0mcQeTMBZjngScwg=;
	b=THX8u33ae+4rCymr0kJ/4Q+ZB59FaOB5057yU8E65iXFNIyWgK+DUmWHlNwMpdA84ZxFm8
	fIZp/gdZqK0TQ5eCZ8QInGDXHDMDZD5qk66Ncwt01D29TvHxeCX1gza/vobtvntS/syvnP
	NtCCUCxpOQ/ugRWPKwxd5Cd13tUUlLE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 006433EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EAPyLETPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/12] btrfs: prepare verify_one_sector() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:45 +1030
Message-ID: <a583eec569334060f9eb8fdb8b90011c1327c136.1763361991.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: C4A17211FC
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

The function verify_one_sector() assume each fs block can be mapped by
one page, blocking bs > ps support for raid56.

Prepare it for bs > ps cases by:

- Introduce helpers to get a paddrs pointer
  Thankfully all the higher layer bio should still be aligned to fs
  block size, thus a fs block should still be fully covered by the bio.

  Introduce sector_paddrs_in_rbio() and rbio_stripe_paddrs(), which will
  return a paddrs pointer inside btrfs_raid_bio::bio_paddrs[] or
  stripe_paddrs[].

  The pointer can be directly passed to
  btrfs_calculate_block_csum_pages() to verify the checksum.

- Open code btrfs_check_block_csum()
  btrfs_check_block_csum() only supports fs blocks backed by large
  folios.

  But for raid56 we can have fs blocks backed by multiple incontiguous
  pages, e.g. direct IO, encoded read/write/send.

  So instead of using btrfs_check_block_csum(), open code it to use
  btrfs_calculate_block_csum_pages().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 55 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index fafd200a2eff..07d452439e37 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -732,6 +732,13 @@ static phys_addr_t rbio_qstripe_step_paddr(const struct btrfs_raid_bio *rbio,
 	return rbio_stripe_step_paddr(rbio, rbio->nr_data + 1, sector_nr, step_nr);
 }
 
+/* Return a paddr pointer into the rbio::stripe_paddrs[] for the specified sector. */
+static phys_addr_t *rbio_stripe_paddrs(const struct btrfs_raid_bio *rbio,
+				       unsigned int stripe_nr, unsigned int sector_nr)
+{
+	return &rbio->stripe_paddrs[rbio_paddr_index(rbio, stripe_nr, sector_nr, 0)];
+}
+
 /*
  * The first stripe in the table for a logical address
  * has the lock.  rbios are added in one of three ways:
@@ -1003,6 +1010,41 @@ static phys_addr_t sector_paddr_in_rbio(struct btrfs_raid_bio *rbio,
 	return rbio->stripe_paddrs[index];
 }
 
+/*
+ * Get paddr pointer for the sector specified by its @stripe_nr and @sector_nr.
+ *
+ * @rbio:               The raid bio
+ * @stripe_nr:          Stripe number, valid range [0, real_stripe)
+ * @sector_nr:		Sector number inside the stripe,
+ *			valid range [0, stripe_nsectors)
+ * @bio_list_only:      Whether to use sectors inside the bio list only.
+ *
+ * The read/modify/write code wants to reuse the original bio page as much
+ * as possible, and only use stripe_sectors as fallback.
+ *
+ * Return NULL if bio_list_only is set but the specified sector has no
+ * coresponding bio.
+ */
+static phys_addr_t *sector_paddrs_in_rbio(struct btrfs_raid_bio *rbio,
+					  int stripe_nr, int sector_nr,
+					  bool bio_list_only)
+{
+	phys_addr_t *ret = NULL;
+	const int index = rbio_paddr_index(rbio, stripe_nr, sector_nr, 0);
+
+	ASSERT(index >= 0 && index < rbio->nr_sectors * rbio->sector_nsteps);
+
+	scoped_guard(spinlock, &rbio->bio_list_lock) {
+		if (rbio->bio_paddrs[index] != INVALID_PADDR || bio_list_only) {
+			/* Don't return sector without a valid page pointer */
+			if (rbio->bio_paddrs[index] != INVALID_PADDR)
+				ret = &rbio->bio_paddrs[index];
+			return ret;
+		}
+	}
+	return &rbio->stripe_paddrs[index];
+}
+
 /*
  * Similar to sector_paddr_in_rbio(), but with extra consideration for
  * bs > ps cases, where we can have multiple steps for a fs block.
@@ -1832,10 +1874,9 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 			     int stripe_nr, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	phys_addr_t paddr;
+	phys_addr_t *paddrs;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
-	int ret;
 
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
 		return 0;
@@ -1848,16 +1889,18 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	 * bio list if possible.
 	 */
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-		paddr = sector_paddr_in_rbio(rbio, stripe_nr, sector_nr, 0);
+		paddrs = sector_paddrs_in_rbio(rbio, stripe_nr, sector_nr, 0);
 	} else {
-		paddr = rbio_stripe_paddr(rbio, stripe_nr, sector_nr);
+		paddrs = rbio_stripe_paddrs(rbio, stripe_nr, sector_nr);
 	}
 
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	ret = btrfs_check_block_csum(fs_info, paddr, csum_buf, csum_expected);
-	return ret;
+	btrfs_calculate_block_csum_pages(fs_info, paddrs, csum_buf);
+	if (unlikely(memcmp(csum_buf, csum_expected, fs_info->csum_size) != 0))
+		return -EIO;
+	return 0;
 }
 
 static void recover_vertical_step(struct btrfs_raid_bio *rbio,
-- 
2.51.2



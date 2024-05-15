Return-Path: <linux-btrfs+bounces-5003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8348C5F78
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 05:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2378C1C21A1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 03:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E01381B9;
	Wed, 15 May 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IMU7ZhZL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IMU7ZhZL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963F37142
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744665; cv=none; b=lWHV51elVIFZzXTAutpmxp2HoT8nFgycTglT0jNe+ww86ZphCEkMMF6345Ai/yUC6E5jMsckYlKtJRw3k5sQzIVLtbNnho3aN79Vhx6Qu3ulyA00CxOsBvYGUMP+fCPKG145K21DJutzQ/3VpPQTxRvuYQ7n8Wl9IWOhDmnrW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744665; c=relaxed/simple;
	bh=WrdgArUFR2WnBtqdu9C2HxTVu+rL9iXNcCak4ccyytw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lpDkudAwC1eiz5QvlIPQHuy/k8BlmCW+02ecULVv97Kt4BAjlRZkpeeXujHi64fZaIVJ4IxwVDhYPlyq0Dzqr7IC2LAdDEkoBQK72VHSRIfozTACaFOMA/h00iIJZQ7ct9XhIqOn22u5FAugAclXhsmRJRFjeIQCpP8S6P3rGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IMU7ZhZL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IMU7ZhZL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F28633792
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 03:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715744660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dwVIdh8IFf2P5e/3A2/rMKaLq9qx3DklddGOLQvBgTM=;
	b=IMU7ZhZLfLOVfBn3aeEP1BnBH7WsciRUly3pNsTPsLsTh0hDtWaPtH2a/ykGpKC6y0kgVI
	kVJUKRMJO3ABdnF0Nz/g9GmYXG5wIpkcW6JtGSAP5JUAYUqdc0O2moqzDf+bFTimBRsysO
	k3P6IACLmkwIP8//AlvdlQugvAlbT1w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IMU7ZhZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715744660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dwVIdh8IFf2P5e/3A2/rMKaLq9qx3DklddGOLQvBgTM=;
	b=IMU7ZhZLfLOVfBn3aeEP1BnBH7WsciRUly3pNsTPsLsTh0hDtWaPtH2a/ykGpKC6y0kgVI
	kVJUKRMJO3ABdnF0Nz/g9GmYXG5wIpkcW6JtGSAP5JUAYUqdc0O2moqzDf+bFTimBRsysO
	k3P6IACLmkwIP8//AlvdlQugvAlbT1w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF5413A56
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 03:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qXGbG5MvRGYrDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 03:44:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: raid56: do extra dumping for CONFIG_BTRFS_ASSERT
Date: Wed, 15 May 2024 13:14:01 +0930
Message-ID: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9F28633792
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

There are several hard-to-hit ASSERT()s hit inside raid56.
Unfortunately the ASSERT() expression is a little complex, and except
the ASSERT(), there is nothing to provide any clue.

Considering if race is involved, it's pretty hard to reproduce.
Meanwhile sometimes the dump of the rbio structure can provide some
pretty good clues, it's worthy to do the extra multi-line dump for
btrfs raid56 related code.

The dump looks like this:

 BTRFS critical (device dm-3): bioc logical=4598530048 full_stripe=4598530048 size=0 map_type=0x81 mirror=0 replace_nr_stripes=0 replace_stripe_src=-1 num_stripes=5
 BTRFS critical (device dm-3):     nr=0 devid=1 physical=1166147584
 BTRFS critical (device dm-3):     nr=1 devid=2 physical=1145176064
 BTRFS critical (device dm-3):     nr=2 devid=4 physical=1145176064
 BTRFS critical (device dm-3):     nr=3 devid=5 physical=1145176064
 BTRFS critical (device dm-3):     nr=4 devid=3 physical=1145176064
 BTRFS critical (device dm-3): rbio flags=0x0 nr_sectors=80 nr_data=4 real_stripes=5 stripe_nsectors=16 scrubp=0 dbitmap=0x0
 BTRFS critical (device dm-3): logical=4598530048
 assertion failed: orig_logical >= full_stripe_start && orig_logical + orig_len <= full_stripe_start + rbio->nr_data * BTRFS_STRIPE_LEN, in fs/btrfs/raid56.c:1702
 ------------[ cut here ]------------

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 113 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 13 deletions(-)
---
Changelog:
v2:
- Move btrfs_dump_bioc() to raid56.c and remove the "btrfs_" prefix.
- Use parentheses to protect macro parameters
- Add back the accidentally removed assert on @sector_nr inside
  rbio_add_io_sector()
- Use btrfs_crit() to output the error messages
  For the rare case where rbio->bioc is not yet set, use NULL for
  fs_info which is supported for a long time.

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6f4a9cfeea44..7444faa4b165 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -40,6 +40,88 @@
 
 #define BTRFS_STRIPE_HASH_TABLE_BITS				11
 
+static void dump_bioc(struct btrfs_fs_info *fs_info,
+		      const struct btrfs_io_context *bioc)
+{
+	if (unlikely(!bioc)) {
+		btrfs_crit(fs_info, "bioc=NULL");
+		return;
+	}
+	btrfs_crit(fs_info,
+		"bioc logical=%llu full_stripe=%llu size=%llu map_type=0x%llx mirror=%u replace_nr_stripes=%u replace_stripe_src=%d num_stripes=%u",
+		bioc->logical, bioc->full_stripe_logical, bioc->size,
+		bioc->map_type, bioc->mirror_num, bioc->replace_nr_stripes,
+		bioc->replace_stripe_src, bioc->num_stripes);
+	for (int i = 0; i < bioc->num_stripes; i++) {
+		btrfs_crit(fs_info,
+			"    nr=%d devid=%llu physical=%llu",
+			i, bioc->stripes[i].dev->devid,
+			bioc->stripes[i].physical);
+	}
+}
+
+static void btrfs_dump_rbio(struct btrfs_fs_info *fs_info,
+			    const struct btrfs_raid_bio *rbio)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
+		return;
+
+	dump_bioc(fs_info, rbio->bioc);
+	btrfs_crit(fs_info,
+"rbio flags=0x%lx nr_sectors=%u nr_data=%u real_stripes=%u stripe_nsectors=%u scrubp=%u dbitmap=0x%lx",
+		rbio->flags, rbio->nr_sectors, rbio->nr_data,
+		rbio->real_stripes, rbio->stripe_nsectors,
+		rbio->scrubp, rbio->dbitmap);
+}
+
+#define ASSERT_RBIO(expr, rbio)						\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		struct btrfs_fs_info *fs_info = (rbio)->bioc ?		\
+					(rbio)->bioc->fs_info : NULL;	\
+									\
+		btrfs_dump_rbio(fs_info, (rbio));			\
+	}								\
+	ASSERT((expr));							\
+})
+
+#define ASSERT_RBIO_STRIPE(expr, rbio, stripe_nr)			\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		struct btrfs_fs_info *fs_info = (rbio)->bioc ?		\
+					(rbio)->bioc->fs_info : NULL;	\
+									\
+		btrfs_dump_rbio(fs_info, (rbio));			\
+		btrfs_crit(fs_info, "stripe_nr=%d", (stripe_nr));	\
+	}								\
+	ASSERT((expr));							\
+})
+
+#define ASSERT_RBIO_SECTOR(expr, rbio, sector_nr)			\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		struct btrfs_fs_info *fs_info = (rbio)->bioc ?		\
+					(rbio)->bioc->fs_info : NULL;	\
+									\
+		btrfs_dump_rbio(fs_info, (rbio));			\
+		btrfs_crit(fs_info, "sector_nr=%d", (sector_nr));	\
+	}								\
+	ASSERT((expr));							\
+})
+
+#define ASSERT_RBIO_LOGICAL(expr, rbio, logical)			\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		struct btrfs_fs_info *fs_info = (rbio)->bioc ?		\
+					(rbio)->bioc->fs_info : NULL;	\
+									\
+		btrfs_dump_rbio(fs_info, (rbio));			\
+		btrfs_crit(fs_info, "logical=%llu", (logical));		\
+	}								\
+	ASSERT((expr));							\
+})
+
+
 /* Used by the raid56 code to lock stripes for read/modify/write */
 struct btrfs_stripe_hash {
 	struct list_head hash_list;
@@ -593,8 +675,8 @@ static unsigned int rbio_stripe_sector_index(const struct btrfs_raid_bio *rbio,
 					     unsigned int stripe_nr,
 					     unsigned int sector_nr)
 {
-	ASSERT(stripe_nr < rbio->real_stripes);
-	ASSERT(sector_nr < rbio->stripe_nsectors);
+	ASSERT_RBIO_STRIPE(stripe_nr < rbio->real_stripes, rbio, stripe_nr);
+	ASSERT_RBIO_SECTOR(sector_nr < rbio->stripe_nsectors, rbio, sector_nr);
 
 	return stripe_nr * rbio->stripe_nsectors + sector_nr;
 }
@@ -874,8 +956,10 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 	struct sector_ptr *sector;
 	int index;
 
-	ASSERT(stripe_nr >= 0 && stripe_nr < rbio->real_stripes);
-	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
+	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->real_stripes,
+			   rbio, stripe_nr);
+	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
+			   rbio, sector_nr);
 
 	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
 	ASSERT(index >= 0 && index < rbio->nr_sectors);
@@ -1058,8 +1142,10 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	 * thus it can be larger than rbio->real_stripe.
 	 * So here we check against bioc->num_stripes, not rbio->real_stripes.
 	 */
-	ASSERT(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes);
-	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
+	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes,
+			   rbio, stripe_nr);
+	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
+			   rbio, sector_nr);
 	ASSERT(sector->page);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
@@ -1198,14 +1284,14 @@ static void assert_rbio(struct btrfs_raid_bio *rbio)
 	 * At least two stripes (2 disks RAID5), and since real_stripes is U8,
 	 * we won't go beyond 256 disks anyway.
 	 */
-	ASSERT(rbio->real_stripes >= 2);
-	ASSERT(rbio->nr_data > 0);
+	ASSERT_RBIO(rbio->real_stripes >= 2, rbio);
+	ASSERT_RBIO(rbio->nr_data > 0, rbio);
 
 	/*
 	 * This is another check to make sure nr data stripes is smaller
 	 * than total stripes.
 	 */
-	ASSERT(rbio->nr_data < rbio->real_stripes);
+	ASSERT_RBIO(rbio->nr_data < rbio->real_stripes, rbio);
 }
 
 /* Generate PQ for one vertical stripe. */
@@ -1642,9 +1728,10 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 	const u32 sectorsize = fs_info->sectorsize;
 	u64 cur_logical;
 
-	ASSERT(orig_logical >= full_stripe_start &&
+	ASSERT_RBIO_LOGICAL(orig_logical >= full_stripe_start &&
 	       orig_logical + orig_len <= full_stripe_start +
-	       rbio->nr_data * BTRFS_STRIPE_LEN);
+	       rbio->nr_data * BTRFS_STRIPE_LEN,
+	       rbio, orig_logical);
 
 	bio_list_add(&rbio->bio_list, orig_bio);
 	rbio->bio_list_bytes += orig_bio->bi_iter.bi_size;
@@ -2390,7 +2477,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 			break;
 		}
 	}
-	ASSERT(i < rbio->real_stripes);
+	ASSERT_RBIO_STRIPE(i < rbio->real_stripes, rbio, i);
 
 	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
 	return rbio;
@@ -2556,7 +2643,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * Replace is running and our parity stripe needs to be duplicated to
 	 * the target device.  Check we have a valid source stripe number.
 	 */
-	ASSERT(rbio->bioc->replace_stripe_src >= 0);
+	ASSERT_RBIO(rbio->bioc->replace_stripe_src >= 0, rbio);
 	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 
-- 
2.45.0



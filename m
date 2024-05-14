Return-Path: <linux-btrfs+bounces-4961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBF8C4EAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461E31C20B8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03654BD8;
	Tue, 14 May 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KhhP49RB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KhhP49RB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D32537FF
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678570; cv=none; b=VxXNDhp9ShsZXOG62j4Ya3xneD0ZZvAzrav7DOKoOV2bG/pA+DmQ4blMOykNENUu3VPqPhAiok6zbFxGLv6SLOzH8RM1XNMaQJJwm5pEIzTUOk4OAAyTU9INh/PFJ7ObNHW+zq8BK0LBbI5SHkCSxanPleAs9lDAwewTEBcrawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678570; c=relaxed/simple;
	bh=XtsMOGtCI7XVd+8zvRa4/SIrNEYyipTU8A8AccFmofo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h3cvWsMaReFH12Z2gVcpE7+43pviYekYk3Zs66aGJJjvPpnBUCdFSmP0zSAFcxM3vP7kWbBflv8X/GfOu34/iCP0ToICAcBMnEsZbE92ZQpzieJSWXMuDUECZdRW4A+XCFHyxJ5eVk8WxvYDcWsMM+J0ivfrFBR+afJuuuibs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KhhP49RB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KhhP49RB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 833F13EC73
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715678558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GJUd9c4WMhdgrbx+WeL92urPc3R+0nbt3sRoB8Sjo5c=;
	b=KhhP49RBouPWB5nXKf+sQnNqJexJirTl1TE+qPp5C6VnIkaV1w+Xi94Dp1L7RWhUxpuEBW
	gDuOEAP8pmQis96uN73Xz368EUi2UgSeLSQR8rJjrAvVLpWU8H+XXM09tz44i5Tv9XbZeO
	Ya2uKFrQrB+kh4BTxRZ+22PEUTcmdhM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715678558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GJUd9c4WMhdgrbx+WeL92urPc3R+0nbt3sRoB8Sjo5c=;
	b=KhhP49RBouPWB5nXKf+sQnNqJexJirTl1TE+qPp5C6VnIkaV1w+Xi94Dp1L7RWhUxpuEBW
	gDuOEAP8pmQis96uN73Xz368EUi2UgSeLSQR8rJjrAvVLpWU8H+XXM09tz44i5Tv9XbZeO
	Ya2uKFrQrB+kh4BTxRZ+22PEUTcmdhM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B5E2137C3
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 09:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GyjxEF0tQ2ZXYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 09:22:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: raid56: do extra dumping for CONFIG_BTRFS_ASSERT
Date: Tue, 14 May 2024 18:52:19 +0930
Message-ID: <096e0e552749093231fae4f2f6eb450eb9e0d465.1715678510.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

There are several hard-to-hit ASSERT()s hit inside raid56.
Unfortunately the ASSERT() expression is a little complex, and except
the ASSERT(), there is nothing to provide any clue.

Considering if race is involved, it's pretty hard to reproduce.
Meanwhile sometimes the dump of the rbio structure can provide some
pretty good clues, it's worthy to do the extra multi-line dump for
btrfs raid56 related code.

The dump looks like this:

 bioc logical=298917888 full_stripe=298844160 size=0 map_type=0x101 mirror=4 replace_nr_stripes=0 replace_stripe_src=-1 num_stripes=4
     nr=0 devid=1 physical=22020096
     nr=1 devid=2 physical=1048576
     nr=2 devid=3 physical=277872640
     nr=3 devid=4 physical=277872640
 rbio flags=0x0 nr_sectors=64 nr_data=2 real_stripes=4 stripe_nsectors=16 scrubp=0 dbitmap=0x0
 logical=298917888
 assertion failed: orig_logical >= full_stripe_start && orig_logical + orig_len <= full_stripe_start + rbio->nr_data * BTRFS_STRIPE_LEN, in fs/btrfs/raid56.c:1702
 ------------[ cut here ]------------

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  | 77 ++++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.h | 20 ++++++++++++
 2 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6f4a9cfeea44..b8fffac7cd24 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -40,6 +40,54 @@
 
 #define BTRFS_STRIPE_HASH_TABLE_BITS				11
 
+static void btrfs_dump_rbio(const struct btrfs_raid_bio *rbio)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
+		return;
+
+	btrfs_dump_bioc(rbio->bioc);
+	pr_info(
+"rbio flags=0x%lx nr_sectors=%u nr_data=%u real_stripes=%u stripe_nsectors=%u scrubp=%u dbitmap=0x%lx",
+		rbio->flags, rbio->nr_sectors, rbio->nr_data,
+		rbio->real_stripes, rbio->stripe_nsectors,
+		rbio->scrubp, rbio->dbitmap);
+}
+
+#define ASSERT_RBIO(expr, rbio)						\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr)))	\
+		btrfs_dump_rbio(rbio);					\
+	ASSERT(expr);							\
+})
+
+#define ASSERT_RBIO_STRIPE(expr, rbio, stripe_nr)			\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		btrfs_dump_rbio(rbio);					\
+		pr_info("stripe_nr=%d", stripe_nr);			\
+	}								\
+	ASSERT(expr);							\
+})
+
+#define ASSERT_RBIO_SECTOR(expr, rbio, sector_nr)			\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		btrfs_dump_rbio(rbio);					\
+		pr_info("sector_nr=%d", sector_nr);			\
+	}								\
+	ASSERT(expr);							\
+})
+
+#define ASSERT_RBIO_LOGICAL(expr, rbio, logical)			\
+({									\
+	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
+		btrfs_dump_rbio(rbio);					\
+		pr_info("logical=%llu", logical);			\
+	}								\
+	ASSERT(expr);							\
+})
+
+
 /* Used by the raid56 code to lock stripes for read/modify/write */
 struct btrfs_stripe_hash {
 	struct list_head hash_list;
@@ -593,8 +641,8 @@ static unsigned int rbio_stripe_sector_index(const struct btrfs_raid_bio *rbio,
 					     unsigned int stripe_nr,
 					     unsigned int sector_nr)
 {
-	ASSERT(stripe_nr < rbio->real_stripes);
-	ASSERT(sector_nr < rbio->stripe_nsectors);
+	ASSERT_RBIO_STRIPE(stripe_nr < rbio->real_stripes, rbio, stripe_nr);
+	ASSERT_RBIO_SECTOR(sector_nr < rbio->stripe_nsectors, rbio, sector_nr);
 
 	return stripe_nr * rbio->stripe_nsectors + sector_nr;
 }
@@ -874,8 +922,10 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
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
@@ -1058,8 +1108,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	 * thus it can be larger than rbio->real_stripe.
 	 * So here we check against bioc->num_stripes, not rbio->real_stripes.
 	 */
-	ASSERT(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes);
-	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
+	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes,
+			   rbio, stripe_nr);
 	ASSERT(sector->page);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
@@ -1198,14 +1248,14 @@ static void assert_rbio(struct btrfs_raid_bio *rbio)
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
@@ -1642,9 +1692,10 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
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
@@ -2390,7 +2441,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 			break;
 		}
 	}
-	ASSERT(i < rbio->real_stripes);
+	ASSERT_RBIO_STRIPE(i < rbio->real_stripes, rbio, i);
 
 	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
 	return rbio;
@@ -2556,7 +2607,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * Replace is running and our parity stripe needs to be duplicated to
 	 * the target device.  Check we have a valid source stripe number.
 	 */
-	ASSERT(rbio->bioc->replace_stripe_src >= 0);
+	ASSERT_RBIO(rbio->bioc->replace_stripe_src >= 0, rbio);
 	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 66e6fc481ecd..1373721f8e53 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -554,6 +554,26 @@ struct btrfs_io_context {
 	struct btrfs_io_stripe stripes[];
 };
 
+static inline void btrfs_dump_bioc(const struct btrfs_io_context *bioc)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
+		return;
+
+	if (unlikely(!bioc)) {
+		pr_err("bioc=NULL\n");
+		return;
+	}
+	pr_info("bioc logical=%llu full_stripe=%llu size=%llu map_type=0x%llx mirror=%u replace_nr_stripes=%u replace_stripe_src=%d num_stripes=%u\n",
+		bioc->logical, bioc->full_stripe_logical, bioc->size,
+		bioc->map_type, bioc->mirror_num, bioc->replace_nr_stripes,
+		bioc->replace_stripe_src, bioc->num_stripes);
+	for (int i = 0; i < bioc->num_stripes; i++) {
+		pr_info("    nr=%d devid=%llu physical=%llu\n",
+			i, bioc->stripes[i].dev->devid,
+			bioc->stripes[i].physical);
+	}
+}
+
 struct btrfs_device_info {
 	struct btrfs_device *dev;
 	u64 dev_offset;
-- 
2.45.0



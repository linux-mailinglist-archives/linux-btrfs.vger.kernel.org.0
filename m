Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3C61E294
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKFOfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFOfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 09:35:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05026DEA8
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 06:35:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h14so8368856pjv.4
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYHjdh8KyL96t3ipD8sv/iJw5fAsnQ8u2vB4KgU7dxM=;
        b=CDtTyAIqsgzkizDtBpqeJj6Jcrv3ZGgH6WxFEbVFlIuwSSniP8FVjbtRgcj8qlVSUj
         yKdH/OJoO45yeaSLRxIit8rQ8qd17l/FFp1Awzkk6qL8WGIXvuaOFQG4KQceoasaOAFA
         TVPeZSpg4WOvSA5GxOikIRCI7cabptHCW8PUoZkbISNQzNNQiE/SzJGLGB1BZnKicoWD
         7upywhmnI+MwHEUFtUJYRe37vkH4zDII4VUTHpnScPekuJckzqKOb+ioT5Ba3nN5c2ZP
         4tzF8AGVMSuNzrXk32rxWKmQTZRxhlawchnIlsoGas6VCyLXNGmQZQpTvlbBQ8AH+MAW
         fGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYHjdh8KyL96t3ipD8sv/iJw5fAsnQ8u2vB4KgU7dxM=;
        b=FG6uT8HINbaWBGVdWSdvAidQUKjOVPe3ETQpg0rcDGsZJ1y2MNzCgchwvdE57etDKi
         d4xgoJy8RChryrqdcVMhddgPoKkkX2+0XiJJGO+N1FToLA7MlS83ak8EEcPM/wuI89Uo
         mNstdDffAZdWOC57a+880HXVegsfkevz9Bx3NuPTB8hkpChwhUEvq8dtuM7AI9SfKjyu
         sB/bTwrmOmjbxSCRSe+gGnrwe4QBEdrV4up1qnixIo1HKKAwRLxn1yjeX6HqPdV1hSST
         0gBBFwIvi+HEB0cBXjZ5WlHETfvWlnY5ZR+QAC/5V6sNrt2vkH2RJUN2LIxsKcbKVlLN
         xviw==
X-Gm-Message-State: ACrzQf3mRjhw2BrH5CXCP6RuwjkO/8cd47xBcqYn//gGPzfmEkd/TDaH
        Qy2wOUy49wfMrwDSAZW9+doQeKftHR678oOu
X-Google-Smtp-Source: AMsMyM6eczD5GNO/u8VW1hwWQXms8LJHzvJXo8ePQ1G9DUbzMIgU94Kw4u0W08HqYRkKSNmCvu7lNg==
X-Received: by 2002:a17:902:e843:b0:186:b180:3c3a with SMTP id t3-20020a170902e84300b00186b1803c3amr46428610plg.66.1667745317065;
        Sun, 06 Nov 2022 06:35:17 -0800 (PST)
Received: from zlke.localdomain ([113.65.205.154])
        by smtp.gmail.com with ESMTPSA id k193-20020a6284ca000000b0056e8eb09d58sm2774739pfd.170.2022.11.06.06.35.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Nov 2022 06:35:16 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] btrfs: scrub: fix failed to detect checksum error
Date:   Sun,  6 Nov 2022 22:35:04 +0800
Message-Id: <1667745304-11470-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[bug]
Scrub fails to detect checksum errors
To reproduce the problem:

$ truncate -s 250M loop_dev1
$ truncate -s 250M loop_dev2
$ losetup /dev/loop1 loop_dev1
$ losetup /dev/loop2 loop_dev2
$ mkfs.btrfs -mraid1 -draid1 /dev/loop1 /dev/loop2 -f
$ mount /dev/loop1 /mnt/
$ cp ~/btrfs/btrfs-progs/mkfs/main.c /mnt/

$ vim -b loop_dev1

....
         free(label);
         free(source_dir);
         exit(1);
success:
         exit(0);
}zhangli

....

$ sudo btrfs scrub start /mnt/
fsid:b66aa912-ae76-4b4b-881b-6a6840f06870 sock_path:/var/lib/btrfs/scrub.progress.b66aa912-ae76-4b4b-881b-6a6840f06870.
scrub started on /mnt/, fsid b66aa912-ae76-4b4b-881b-6a6840f06870 (pid=9894)

$ sudo btrfs scrub status /mnt/
UUID:             b66aa912-ae76-4b4b-881b-6a6840f06870
Scrub started:    Sun Nov  6 21:51:50 2022
Status:           finished
Duration:         0:00:00
Total to scrub:   392.00KiB
Rate:             0.00B/s
Error summary:    no errors found

[reason]
Because scrub only checks the first sector (scrub_sector) of
the sblock (scrub_block), it does not check other sectors.

[implementation]
1. Move the set sector (scrub_sector) csum from scrub_extent
to scrub_sectors, since each sector has an independent checksum.
2. In the scrub_checksum_data function, check all
sectors in the sblock.
3. In the scrub_setup_recheck_block function,
use sector_index to set the sector csum.

[test]
The test method is the same as the problem reproduction.
Can detect checksum errors and fix checksum errors
Below is the scrub output.

$ sudo btrfs scrub start /mnt/
fsid:b66aa912-ae76-4b4b-881b-6a6840f06870 sock_path:/var/lib/btrfs/scrub.progress.b66aa912-ae76-4b4b-881b-6a6840f06870.
scrub started on /mnt/, fsid b66aa912-ae76-4b4b-881b-6a6840f06870 (pid=11089)
$ sudo btrfs scrub status /mnt/WARNING: errors detected during scrubbing, corrected

UUID:             b66aa912-ae76-4b4b-881b-6a6840f06870
Scrub started:    Sun Nov  6 22:15:02 2022
Status:           finished
Duration:         0:00:00
Total to scrub:   392.00KiB
Rate:             0.00B/s
Error summary:    csum=1
  Corrected:      1
  Uncorrectable:  0
  Unverified:     0

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
Issue: 537

 fs/btrfs/scrub.c | 58 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f260c53..56ee600 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -404,7 +404,7 @@ static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
 static void scrub_parity_put(struct scrub_parity *sparity);
 static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 			 u64 physical, struct btrfs_device *dev, u64 flags,
-			 u64 gen, int mirror_num, u8 *csum,
+			 u64 gen, int mirror_num,
 			 u64 physical_for_dev_replace);
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct work_struct *work);
@@ -420,6 +420,8 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 static void scrub_wr_bio_end_io(struct bio *bio);
 static void scrub_wr_bio_end_io_worker(struct work_struct *work);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
+static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
+
 
 static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
 {
@@ -1516,7 +1518,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sector->have_csum = have_csum;
 			if (have_csum)
 				memcpy(sector->csum,
-				       original_sblock->sectors[0]->csum,
+				       original_sblock->sectors[sector_index]->csum,
 				       sctx->fs_info->csum_size);
 
 			scrub_stripe_index_and_offset(logical,
@@ -1984,21 +1986,22 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	u8 csum[BTRFS_CSUM_SIZE];
 	struct scrub_sector *sector;
 	char *kaddr;
+	int i;
 
 	BUG_ON(sblock->sector_count < 1);
-	sector = sblock->sectors[0];
-	if (!sector->have_csum)
-		return 0;
-
-	kaddr = scrub_sector_get_kaddr(sector);
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
+	for (i = 0; i < sblock->sector_count; i++) {
+		sector = sblock->sectors[i];
+		if (!sector->have_csum)
+			continue;
 
-	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
-
-	if (memcmp(csum, sector->csum, fs_info->csum_size))
-		sblock->checksum_error = 1;
+		kaddr = scrub_sector_get_kaddr(sector);
+		crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
+		if (memcmp(csum, sector->csum, fs_info->csum_size))
+			sblock->checksum_error = 1;
+	}
 	return sblock->checksum_error;
 }
 
@@ -2400,12 +2403,14 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 
 static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
-		       u64 gen, int mirror_num, u8 *csum,
+		       u64 gen, int mirror_num,
 		       u64 physical_for_dev_replace)
 {
 	struct scrub_block *sblock;
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
+	u8 csum[BTRFS_CSUM_SIZE];
+	int have_csum;
 
 	sblock = alloc_scrub_block(sctx, dev, logical, physical,
 				   physical_for_dev_replace, mirror_num);
@@ -2424,7 +2429,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 * more memory for PAGE_SIZE > sectorsize case.
 		 */
 		u32 l = min(sectorsize, len);
-
 		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
@@ -2435,11 +2439,16 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		}
 		sector->flags = flags;
 		sector->generation = gen;
-		if (csum) {
-			sector->have_csum = 1;
-			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
-		} else {
-			sector->have_csum = 0;
+		if (flags & BTRFS_EXTENT_FLAG_DATA) {
+			/* push csums to sbio */
+			have_csum = scrub_find_csum(sctx, logical, csum);
+			if (have_csum == 0) {
+				++sctx->stat.no_csum;
+				sector->have_csum = 0;
+			} else {
+				sector->have_csum = 1;
+				memcpy(sector->csum, csum, sctx->fs_info->csum_size);
+			}
 		}
 		len -= l;
 		logical += l;
@@ -2669,7 +2678,6 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	u64 src_physical = physical;
 	int src_mirror = mirror_num;
 	int ret;
-	u8 csum[BTRFS_CSUM_SIZE];
 	u32 blocksize;
 
 	/*
@@ -2715,17 +2723,9 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 				     &src_dev, &src_mirror);
 	while (len) {
 		u32 l = min(len, blocksize);
-		int have_csum = 0;
-
-		if (flags & BTRFS_EXTENT_FLAG_DATA) {
-			/* push csums to sbio */
-			have_csum = scrub_find_csum(sctx, logical, csum);
-			if (have_csum == 0)
-				++sctx->stat.no_csum;
-		}
 		ret = scrub_sectors(sctx, logical, l, src_physical, src_dev,
 				    flags, gen, src_mirror,
-				    have_csum ? csum : NULL, physical);
+				    physical);
 		if (ret)
 			return ret;
 		len -= l;
@@ -4155,7 +4155,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 
 		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-				    NULL, bytenr);
+				    bytenr);
 		if (ret)
 			return ret;
 	}
-- 
1.8.3.1


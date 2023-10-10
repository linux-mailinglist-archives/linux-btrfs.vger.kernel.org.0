Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91E97C41B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJJUmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbjJJUlr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6878DB8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:45 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7b92cd0ccso18914787b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970504; x=1697575304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6Ati+EqeLVccyZuz2RaSUk3+ioP3QFcOhWT02y0KiE=;
        b=zIcGb1SSsOLAMex5+HxLe4k9icFzdAyGnuHW5ZSjvz0At9zK5DferQL1LzHdr2zKDr
         SaVv9oivUky0t92kQT2PVNWTBfrvxclq3lGtGSjG3ZIKaRLbv17pmeN+zeT19ExYaiuq
         KKG9F+5Pi2kHKS3gD0COHkKSW7f6cumgo8qlPJeIKfRgwiMTYzXcfklUOKpTLIygpboN
         sRPX2PufDRYRtqcTJVllXlB0W/+aBzwDknWRD6ZoByKz4vsUQL4db1EbhoZAUjDRytQs
         Rp5On1ocgdEp8tuJ/P3Yb4EmfOa+V9ua7g+ThaEguH/94gTeh3LCapzNaqJq1lyW4c9j
         kNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970504; x=1697575304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6Ati+EqeLVccyZuz2RaSUk3+ioP3QFcOhWT02y0KiE=;
        b=jnGcZRAoqpoYh7W2J7kjJC2ctLEGmHe9hm3055bViC9HedY/APvTcAKMwe5Digh29g
         wFFag6l1Lq8Ero5X8l3ZGkpUHAFR5CKj5/AeO+JNaUeT8HKExPqVS4lbkXwVfUaNddCY
         UUZGZ69Wep90SrGCiR+JGvd00W6/7Wcv0vbCJexY1GJqQsGGhSmJA8pMH+68bqWwb4Zb
         /OJHXHWfPDKrWqI0FUVDNWoq67Ug8Eo6QxlfFs7kfV/DOhyeUos2ROKlL7Sj9DETEx0V
         GBlXhtR6cabnKIcj4plltgEEXbNcdD/248g9nnARQy5erngP2ML8FwOkZ/CRQqmoFzx2
         sB9w==
X-Gm-Message-State: AOJu0YzJaULsc1GeIhZelG3cnGpodCCXxSjCg1I0kNNc8oPFOyCIdJPb
        t7F5asaGqfgg/zDRwzyJc6rDTQ==
X-Google-Smtp-Source: AGHT+IFqKF/wsw+UCtf7hIO1uKFD9kz0EZod4dWmk76nppECHfp13oAGNwIV4c4UnsQ1Wr8Amy/sBg==
X-Received: by 2002:a05:690c:3509:b0:5a7:dc7b:22 with SMTP id fq9-20020a05690c350900b005a7dc7b0022mr300048ywb.7.1696970504608;
        Tue, 10 Oct 2023 13:41:44 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c65-20020a0df344000000b0059adc0c4392sm4607450ywf.140.2023.10.10.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 35/36] btrfs: add orig_logical to btrfs_bio
Date:   Tue, 10 Oct 2023 16:40:50 -0400
Message-ID: <972da3fc6287abc2b766fa12acf9aca61c00213a.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When checksumming the encrypted bio on writes we need to know which
logical address this checksum is for.  At the point where we get the
encrypted bio the bi_sector is the physical location on the target disk,
so we need to save the original logical offset in the btrfs_bio.  Then
we can use this when csum'ing the bio instead of the
bio->iter.bi_sector.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 9 +++++++++
 fs/btrfs/bio.h       | 3 +++
 fs/btrfs/file-item.c | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 90e4d4709fa3..7d6931e53beb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -96,6 +96,7 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	if (bbio_has_ordered_extent(bbio)) {
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
+		orig_bbio->orig_logical += map_length;
 	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
@@ -674,6 +675,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		goto fail;
 	}
 
+	/*
+	 * For fscrypt writes we will get the encrypted bio after we've remapped
+	 * our bio to the physical disk location, so we need to save the
+	 * original bytenr so we know what we're checksumming.
+	 */
+	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
+		bbio->orig_logical = logical;
+
 	map_length = min(map_length, length);
 	if (use_append)
 		map_length = min(map_length, fs_info->max_zone_append_size);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index ca79decee060..5d3f53dcd6d5 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -54,11 +54,14 @@ struct btrfs_bio {
 		 * - pointer to the checksums for this bio
 		 * - original physical address from the allocator
 		 *   (for zone append only)
+		 * - original logical address, used for checksumming fscrypt
+		 *   bios.
 		 */
 		struct {
 			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
 			u64 orig_physical;
+			u64 orig_logical;
 		};
 
 		/* For metadata reads: parentness verification. */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d925d6d98bf4..26e3bc602655 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -756,7 +756,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	sums->logical = bbio->orig_logical;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
-- 
2.41.0


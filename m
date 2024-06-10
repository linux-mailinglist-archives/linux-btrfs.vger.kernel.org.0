Return-Path: <linux-btrfs+bounces-5611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B5690245D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA50B26BA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3490F132117;
	Mon, 10 Jun 2024 14:42:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5223B0
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030566; cv=none; b=Wv8m+ZGe86UIe7OZm3LMfA1zLWT/ELqPvb3P2rsE43lsCCnzHh8BrL0DfF+yfC+yXEGfwzCxzl+88hlcFGDEZHhvm8ON6DMsdFcV0CkRHbjkuG/Ru2TRy85NH89PUt8GytvrB6yw2dd4wBoaDIGw2uBLr7jo20EQDRcrOtftZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030566; c=relaxed/simple;
	bh=9qrf3xygiMNOBNWHR3SCyqSOru6Oc0mQCM+CmGU31rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9WqV7famZvZ1K6vQFL9M6MZPY58uMTZBxrkBAEeOd36/FT3YwNafmrrjw7KRJ3Ti6JflzMgJISQINJfWd4vlDKacd0ejMBp5Jx5XT2MZ8BgL6Yyt5LOMGDKubEFVPCMTvUo1lvI+MViG1Tz1aLSRjYoNXybE1mlx8Pw38fERX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef46d25efso333491166b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 07:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718030563; x=1718635363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKbIEFzy9XfRP7NxUolQBIpZZNsGaATJrKxWLokaeSY=;
        b=cGrFQg/xE8vYyrppHF8Z3RAb4ij/FJKDmfQq4AilFuqeqkmit8oKLLgE8RI4TZ4Rkd
         q6JGklefX/wQbdGmsSfoV7zjOc8li6WzlfwtOEf3iv4BNjdtbfEZbcve9mAqIwRuBZGU
         zZbhnmc85ceXKgEj1XXl5c8kF2HA/kClZiYVROAiVu2eY6MLuoLdPU03JRzB2nAsLxEo
         MFKk0Y6pQBTP0YV4M5ZNlIsObKGJxqN0j0BbHmyDY544CMTp356GhHM68Tx+BfgcMkkU
         hOjDx3ODuyblBFBb6+GXbHz2npVlNVtH4FR299j660iVQ6TIhJT+9ghOx9QBsnOwTb1x
         RsgA==
X-Gm-Message-State: AOJu0Yz1ywtIyYsSFn5a6DoM81nNJ/HH7us3HHIdA9BRSHZGM0EuxFVj
	MUwCdw4rQLDj4lLhsvX3R0xuRPliDfopI2jIYLLKoaGx2K9YW0puzO8td0ra
X-Google-Smtp-Source: AGHT+IHa9j2nnLK+KFjJ/4k4s5ewzbQzMtS5GtXWV6HwN0OFTjXuISiSL/h1pY9RxYyuvMTiGmrX1g==
X-Received: by 2002:a17:906:f198:b0:a6f:e36:aba8 with SMTP id a640c23a62f3a-a6f0e36acd5mr358679166b.33.1718030562958;
        Mon, 10 Jun 2024 07:42:42 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0c9f88sm7629415a12.21.2024.06.10.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:42:42 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on failed bios
Date: Mon, 10 Jun 2024 16:42:29 +0200
Message-ID: <20240610144229.26373-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running fstests' test-case btrfs/060 with MKFS_OPTIONS="-O rst"
to force the creation of a RAID stripe tree even on regular devices I
hit the follwoing ASSERT() in calc_sector_number():

    ASSERT(i < stripe->nr_sectors);

This ASSERT() is triggered, because we cannot find the page in the
passed in bio_vec in the scrub_stripe's pages[] array.

When having a closer look at the stripe using drgn on the vmcore dump
and comparing the stripe's pages to the bio_vec's pages it is evident
that we cannot find it as first_bvec's bv_page is NULL:

    >>> stripe = t.stack_trace()[13]['stripe']
    >>> print(stripe.pages)
    (struct page *[16]){ 0xffffea000418b280, 0xffffea00043051c0,
    0xffffea000430ed00, 0xffffea00040fcc00, 0xffffea000441fc80,
    0xffffea00040fc980, 0xffffea00040fc9c0, 0xffffea00040fc940,
    0xffffea0004223040, 0xffffea00043a1940, 0xffffea00040fea80,
    0xffffea00040a5740, 0xffffea0004490f40, 0xffffea00040f7dc0,
    0xffffea00044985c0, 0xffffea00040f7d80 }
    >>> bio = t.stack_trace()[12]['bbio'].bio
    >>> print(bio.bi_io_vec)
    *(struct bio_vec *)0xffff88810632bc00 = {
            .bv_page = (struct page *)0x0,
            .bv_len = (unsigned int)0,
            .bv_offset = (unsigned int)0,
    }

Upon closer inspection of the bio itself we see that bio->bi_status is
10, which corresponds to BLK_STS_IOERR:

    >>> print(bio)
    (struct bio){
            .bi_next = (struct bio *)0x0,
            .bi_bdev = (struct block_device *)0x0,
            .bi_opf = (blk_opf_t)0,
            .bi_flags = (unsigned short)0,
            .bi_ioprio = (unsigned short)0,
            .bi_write_hint = (enum rw_hint)WRITE_LIFE_NOT_SET,
            .bi_status = (blk_status_t)10,
            .__bi_remaining = (atomic_t){
                    .counter = (int)1,
            },
            .bi_iter = (struct bvec_iter){
            	 .bi_sector = (sector_t)2173056,
                    .bi_size = (unsigned int)0,
                    .bi_idx = (unsigned int)0,
                    .bi_bvec_done = (unsigned int)0,
            },
            .bi_cookie = (blk_qc_t)4294967295,
            .__bi_nr_segments = (unsigned int)4294967295,
            .bi_end_io = (bio_end_io_t *)0x0,
            .bi_private = (void *)0x0,
            .bi_integrity = (struct bio_integrity_payload *)0x0,
            .bi_vcnt = (unsigned short)0,
            .bi_max_vecs = (unsigned short)16,
            .__bi_cnt = (atomic_t){
                    .counter = (int)1,
            },
            .bi_io_vec = (struct bio_vec *)0xffff88810632bc00,
            .bi_pool = (struct bio_set *)btrfs_bioset+0x0 = 0xffffffff82c85620,
            .bi_inline_vecs = (struct bio_vec []){},
    }

So only call calc_sector_number when we know the bio completed without error.

Cc: Qu Wenru <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 188a9c42c9eb..91590dc509de 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1099,12 +1099,17 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
 	struct bio_vec *bvec;
-	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int sector_nr = 0;
 	int num_sectors;
 	u32 bio_size = 0;
 	int i;
 
-	ASSERT(sector_nr < stripe->nr_sectors);
+	if (bbio->bio.bi_status == BLK_STS_OK) {
+		sector_nr = calc_sector_number(stripe,
+					       bio_first_bvec_all(&bbio->bio));
+		ASSERT(sector_nr < stripe->nr_sectors);
+	}
+
 	bio_for_each_bvec_all(bvec, &bbio->bio, i)
 		bio_size += bvec->bv_len;
 	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
-- 
2.43.0



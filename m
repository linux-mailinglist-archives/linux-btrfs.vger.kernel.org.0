Return-Path: <linux-btrfs+bounces-518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6980160F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C4E1C20C0A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153866703;
	Fri,  1 Dec 2023 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kxYEW1Q9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F7610D0
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:43 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d05ff42db0so29833237b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468763; x=1702073563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBfJ5LP4cPRaU4wHupG+Ey+k+InOBSbHn6NRjNRvG6k=;
        b=kxYEW1Q9EMIICWnG/QkP9Jt/iGyJdm8Dq3iO+I5fa7wgJnmBYuGN/zqu7DHxQTQ9gi
         Vwv7E0YBoVzeEgDEyF8ysdP+QPT4KfLqt4UuHlRLr1ExJznjNFy3m4WDZCxuMZOhupkL
         0DGmhucMYXlM+viFUhBmKUoO2Whyphrou73kvTQynE+AGDvJAbvLckTeM9mTzfsOWYcL
         JVdYYl3iyTafE0QuHBgvuvpkwU8vQ9QSbAIaiIAmSI/VrMowvf1kEFJ4gokmNACgLc/R
         gcMS/l1EIiqGUsgI55JBPjen5k/IaMmyThO79ulXF5wDYg5PlM7DAaXXFp6t6PQFAO/5
         iWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468763; x=1702073563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBfJ5LP4cPRaU4wHupG+Ey+k+InOBSbHn6NRjNRvG6k=;
        b=sVD8WAWbd186TulnZrtduF9hUGeIOoums/70A+IYG2qRvflkqHd1vUv03V0Y2CCloV
         KxWu7g16iWtRzWPwR3Ls038HgFoVgG/WmdhD1ZSuVaO/298WXydrtov6urma4UIoreO2
         VC9xxwP3EvSyRbhFoW7lMPf2Gh10V7wB8n6R4d3ks8Os6i7pEjA1KrqSzc5XsQMcJ9Vw
         5fwlHrUrg5ZTrDzS0ha+IoGgi/Wg1NSfBrjOK5AzIIKcMFpRouby5P8RAOr5cu1Zfni7
         CJHodAr+iwYJcCJOzzKxCad4M/ZueaMeXAuWc5jnpHBdvLDTgylTlYFm3EXVwrLHOqPl
         zeuA==
X-Gm-Message-State: AOJu0Yw/FVggjCrTOYaB46Zs1mcG2N31Rm3rEelyi6LAG1hhEOwVk/sU
	Q4DJzn0lv784LWkc8jnzPltFBuZdgy3tYlJlRajfRI9L
X-Google-Smtp-Source: AGHT+IGi+2G+GsDsi7vKKAg8Gt5OHvNPUGxhK0AXWDsRkrstC8LCZFqZHvQtkSYYZeOORiW5/ur+Ng==
X-Received: by 2002:a81:57d8:0:b0:5d3:adfd:ff7d with SMTP id l207-20020a8157d8000000b005d3adfdff7dmr272703ywb.12.1701468762767;
        Fri, 01 Dec 2023 14:12:42 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p67-20020a819846000000b005d379110c89sm1235459ywg.8.2023.12.01.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 36/46] btrfs: add orig_logical to btrfs_bio
Date: Fri,  1 Dec 2023 17:11:33 -0500
Message-ID: <26716dcde48fe6abde781dbe2a1f4c0d99f6c4b0.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checksumming the encrypted bio on writes we need to know which
logical address this checksum is for.  At the point where we get the
encrypted bio the bi_sector is the physical location on the target disk,
so we need to save the original logical offset in the btrfs_bio.  Then
we can use this when csum'ing the bio instead of the
bio->iter.bi_sector.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 10 ++++++++++
 fs/btrfs/bio.h       |  3 +++
 fs/btrfs/file-item.c |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 90e4d4709fa3..52f027877aaa 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -96,6 +96,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	if (bbio_has_ordered_extent(bbio)) {
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
+		bbio->orig_logical = orig_bbio->orig_logical;
+		orig_bbio->orig_logical += map_length;
 	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
@@ -674,6 +676,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
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



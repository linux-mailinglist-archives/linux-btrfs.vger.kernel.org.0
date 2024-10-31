Return-Path: <linux-btrfs+bounces-9263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2F9B7D39
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 15:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965BE1C216EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332961A254E;
	Thu, 31 Oct 2024 14:45:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A51494AB;
	Thu, 31 Oct 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385914; cv=none; b=toF4KO6YInPI7PgocjliTnhFw8AdIP6Qf2KmMrm70QeNL1xTMe+gR9vewazX9fECYCrfVuufePvfSOshy6NztHW8cY5/WgyZ5SBDARVvBP7URuAUG1d3ylB0x/1AguA1RqqlOX0hS+hM72EGUhx+CDPt2Ugz19QTSFA7f1KpQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385914; c=relaxed/simple;
	bh=8pMDvHQAob58llAamwS7N/iZRX9fW8xGRAqSaiYFYEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pd5J3oZ+rbRA757pKKR/+WmMjiH0ibtneqhjF/MnfEDheuv+tPhodqc9FK6eyxwHGTC7wlIXfv/DqEU9fvmePttQpDUOkJKJO/tEucfaDF/6ORgUg1TIw2TJMXIb8fB2Nox8KqzeibmG+zNBTy+Id8SrQekHh0e6T7fimRVscO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb587d0436so11573851fa.2;
        Thu, 31 Oct 2024 07:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385911; x=1730990711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrXWCVeDKqKbudttL82vkicTuerPbo3lkRQbqLFBsV8=;
        b=RkK4NW1jPLEQ+/CH36VAn/WsqqdHQ4X0TsVZ3Uq0h6L1n7zcu8nh1LDVhcv2x1vaav
         aAVesYqF2rXKmLENIvP79ZjhUhI4g//L78eS8miso/Y9jITTZQCGb2T5IgFV3rAWyEq+
         utT7e8hzdfmvnwXMFM1Ah0UVHvQf3SSNybtT9JteaLcPjvYRB7i05E+c1ch5ahdXKFyH
         bK/b4Okx1t+XFGwvLYQJz9T7/33gT07eCm3RUiYoIOLZ7mrld6tYza4IB9ClwQUYf1fL
         MUsE7JlFkHpInR+zEptUcF41j52vGN1Fb0+uS+CX+CObKHJUhIFYAdI75vkfnriMQSkd
         nzvg==
X-Forwarded-Encrypted: i=1; AJvYcCW3GA0agC9Z/UvJ9m8KvjtT5ARzhLjgtY+ONeworQUfwSpj1zaN01PjCJ+G34PgldNsdiIDELj0PqnwpA==@vger.kernel.org, AJvYcCXezTJPiSGNlcorQxkDwUK3kWsPfHhoFuuVHdXflrJ4mKqArkCvql0JoX8ruJzQ+BIzJ+DHbUpA2rRt+lWt@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVUkee4yxxaJyD73oNFaI3GSshyiIMedgxcF3HSqHmZ5szWLU
	NjaXsaygk2tDc79m8J2BoVz/RLiVn7KsSpgfUgTMIhcl6GY92v2T
X-Google-Smtp-Source: AGHT+IG+YC4v1kqIrDdLWucSevyPreQkgj+9r+AjqJsmVrOIOvdtK5TfywiFoVIydO6nuyMoGu6xiQ==
X-Received: by 2002:a2e:a545:0:b0:2fb:8df3:2291 with SMTP id 38308e7fff4ca-2fedb7a2e8fmr612321fa.16.1730385910299;
        Thu, 31 Oct 2024 07:45:10 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceaef1e71csm522293a12.38.2024.10.31.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:45:08 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-block@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: handle bio_split() error
Date: Thu, 31 Oct 2024 15:44:57 +0100
Message-ID: <20241031144458.11497-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that bio_split() can return errors, add error handling for it in
btrfs_split_bio() and ultimately btrfs_submit_chunk().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

This is based on top of John Garry's series "bio_split() error handling
rework" explicitly on the patch titled "block: Rework bio_split() return
value", which are as of now (Tue Oct 29 10:02:16 2024) not yet merged into
any tree.

Changes to v1:
- convert ERR_PTR to blk_status_t
- correctly fail already split bbios
---
 fs/btrfs/bio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..d2cfef5e4d4a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
 			&btrfs_clone_bioset);
+	if (IS_ERR(bio))
+		return ERR_CAST(bio);
+
 	bbio = btrfs_bio(bio);
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
@@ -687,6 +690,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 	if (map_length < length) {
 		bbio = btrfs_split_bio(fs_info, bbio, map_length);
+		if (IS_ERR(bbio)) {
+			ret = errno_to_blk_status(PTR_ERR(bbio));
+			goto fail;
+		}
 		bio = &bbio->bio;
 	}
 
@@ -698,7 +705,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		if (ret)
-			goto fail;
+			goto fail_split;
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
@@ -732,13 +739,13 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
-				goto fail;
+				goto fail_split;
 		} else if (use_append ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
 			if (ret)
-				goto fail;
+				goto fail_split;
 		}
 	}
 
@@ -746,7 +753,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 done:
 	return map_length == length;
 
-fail:
+fail_split:
 	btrfs_bio_counter_dec(fs_info);
 	/*
 	 * We have split the original bbio, now we have to end both the current
@@ -760,6 +767,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 		btrfs_bio_end_io(remaining, ret);
 	}
+fail:
 	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
-- 
2.43.0



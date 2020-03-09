Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8617EB39
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCIVc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:32:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41659 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgCIVc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:32:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so4526881plr.8
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZmUeitYEXdJfEIJvvQFQzayStsz1CC03NPPcdyYXT4=;
        b=h3l8JCHayM7rNYWpv044Lmdcw3HGiF7gfao0ibdjohT0AnJeeKVzw86mDcVN33TYof
         ovqB9KuhZKNrsDBwaDWUeL1L3Onn5F4shBPi2mrDe1hNR2UTxcl0N0lQcEXcLlWnGydT
         DZNO+7YkuYM/+6xnoulHK+8bE2BwwIbsAtakWgWrdqj1bFRjeBQ2zPf/Vt8s5Xo86wLR
         NXiqpUhCWcP+zGH7oTlB6Pz0y4G1aPzL9qymBanlMq2V711Mhzr9a4uTAH+EM35pgQp+
         CYl0yUyBYgCPDTrlOTFiUrAOnMzL5b4SzXrYQ7uJVyy/SOCehr0pYMqygklUZdxKNxuA
         tfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZmUeitYEXdJfEIJvvQFQzayStsz1CC03NPPcdyYXT4=;
        b=G/h/67BO54lqVpHUcwA1/pxDGedmRCWQ540pxSB4fIJIRJwK9ygm2dsCQjT2vN3xlE
         Xpuaw/d3q/6a/ZS+xeR3vIncfmGFmJpnRydCr/V6QLZ//QPJZK3OEYZJMP0eL5j53lUj
         JWYwgcmO+Te925jyeHYuwXyJAgvW1VTt+63iaQcC8yXYt2gGQjwXowItUdmENqn2VgMk
         p75ikNflmajUHsO9cPNX+x5QR3/Gu9MVZWVnX8PWYFF3MKFLFYuoe9b5PsgRAlna4Z7g
         tJJEHjwEV+tCCFcGDXQiQMLdDpCd6nm2NRKavf95UkZ1Fx51RnFbycSRU4CaM2fnSkW9
         Ag3A==
X-Gm-Message-State: ANhLgQ0GvfRFFGQ7wCyJYb31FwauH4vKoKoEIaZnP/64mDH8/8ZAqa4F
        zg6IlfFk+scb+mC8sxnRu8lhiGKPxqs=
X-Google-Smtp-Source: ADFU+vtvuPpXsp000CUUjOx4NYbglKvJR9aVFTWW9DHEyjRmtQB4ACmJ56YwL0JoiQ502857pT7ing==
X-Received: by 2002:a17:90a:bf83:: with SMTP id d3mr1382792pjs.77.1583789575760;
        Mon, 09 Mar 2020 14:32:55 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:32:55 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/15] btrfs: fix error handling when submitting direct I/O bio
Date:   Mon,  9 Mar 2020 14:32:27 -0700
Message-Id: <4481393496a9dfe99c9432193407ebdaa27d0753.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If we submit orig_bio in btrfs_submit_direct_hook(), we never increment
pending_bios. Then, if btrfs_submit_dio_bio() fails, we decrement
pending_bios to -1, and we never complete orig_bio. Fix it by
initializing pending_bios to 1 instead of incrementing later.

Fixing this exposes another bug: we put orig_bio prematurely and then
put it again from end_io. Fix it by not putting orig_bio.

After this change, pending_bios is really more of a reference count, but
I'll leave that cleanup separate to keep the fix small.

Fixes: e65e15355429 ("btrfs: fix panic caused by direct IO")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8a3bc19d83ff..d48a2010f24a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7948,7 +7948,6 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 
 	/* bio split */
 	ASSERT(geom.len <= INT_MAX);
-	atomic_inc(&dip->pending_bios);
 	do {
 		clone_len = min_t(int, submit_len, geom.len);
 
@@ -7998,7 +7997,8 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	if (!status)
 		return 0;
 
-	bio_put(bio);
+	if (bio != orig_bio)
+		bio_put(bio);
 out_err:
 	dip->errors = 1;
 	/*
@@ -8039,7 +8039,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	bio->bi_private = dip;
 	dip->orig_bio = bio;
 	dip->dio_bio = dio_bio;
-	atomic_set(&dip->pending_bios, 0);
+	atomic_set(&dip->pending_bios, 1);
 	io_bio = btrfs_io_bio(bio);
 	io_bio->logical = file_offset;
 
-- 
2.25.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B487C3D0EF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhGUMDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 08:03:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44572 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhGUMDC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 08:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626871419; x=1658407419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcvflyF6Sr3l32JUsiG2KYWllwPGJ3YVp9x5kYVKYbk=;
  b=jVmNQR08znru3B3CjRW4r6OvZOnszVPLCElvGYQe5JeVoI/xeUE0hWta
   U+3oU3bl8RA7N16oChF5llLzq+jEiXykokUqXtfXWwwpo3nYywL9x0ENb
   wRqwp8zM58aQJ9JvSlU9tUoEMZHAp/ecHHhcQw2du+X/qvoU634ROLuHb
   uJMBsHe66o1ZyS7/q9J/4sqjeSlkzVbVR0oqh+kxh3HdAuwhQB1fFt4/S
   37L+SXDg04IIDK2p8/PPeAAUlO4ll+E3b64LxBo2r2+ZXcipPIenDyeBi
   6+gh+6B9iTwvAERFQq+SmEOUGHDtVyGJCuT36KVr4GYrJCcBHtC+LzxGS
   w==;
X-IronPort-AV: E=Sophos;i="5.84,258,1620662400"; 
   d="scan'208";a="174366711"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 20:43:39 +0800
IronPort-SDR: O2GytIaPopqHKJJRN2h2j6qqONLxiUxcY49PJVvtd/rbZtIzuTVK53A0FjoFGYJ7tFGoGNctob
 cWpjZJrjgRjLSZi7yNhO1qpnuSUzFmSqwI2wtRC/TZPTqtmlPh4yVbeKcl9qKfK6MSpVfLI7Rj
 GGeNyTnvd0ExvvZIEnQCKSE79g59Qiu+JKGqa/f2KZtQiJSKZzXcCV/lBER+SY3uZIiaIFGkyC
 lHU6d9V0KUjVYf7e+Cr6vTnmHvc27k+2ZSLxqX9BFcYT47+ddFp39Becb3x61mBh6gqxKt2HyE
 6OvfkPEDZkBb00bvPaEmqhFx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:19:53 -0700
IronPort-SDR: /fR06Vu9mOQOpevVvXu955grwVUOudBwYkLPeLWlHV7uuawSDC9drZXvbE3IaJ+pDzDUM6ErAz
 569hO8mhCewsyCpSR+03azKgo8lbKL0zTwMjWz069P+0BY8DSASGHnnvnmA9Z+T1mkSAsuFgYL
 cqtWEG0HYaC7v6rUavSvFEDHcO3x9aR5KnxXT/Lya85iloDYEo0DPA6guQChNtYU94A9l9TWRT
 wvIBYrRcwxeZG44ypE1Ue3FUQPmB/zJ2Yly5eXu7JFT5vziBm/RFEIWif/FG0t837wvxWifLQ8
 JWo=
WDCIronportException: Internal
Received: from my8nr8qf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jul 2021 05:43:38 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/3] btrfs: fix argument type of btrfs_bio_clone_partial()
Date:   Wed, 21 Jul 2021 21:43:33 +0900
Message-Id: <54a957c10f01437a4e28ca9381388745244fb427.1626871138.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626871138.git.naohiro.aota@wdc.com>
References: <cover.1626871138.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

The offset and can never be negative use unsigned int instead of int type
for them.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 4 +++-
 fs/btrfs/extent_io.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f947e24091a..97c275b5631e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3153,11 +3153,13 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 {
 	struct bio *bio;
 	struct btrfs_io_bio *btrfs_bio;
 
+	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
+
 	/* this will never fail when it's backed by a bioset */
 	bio = bio_clone_fast(orig, GFP_NOFS, &btrfs_bioset);
 	ASSERT(bio);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..53abdc280451 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -280,7 +280,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
-- 
2.32.0


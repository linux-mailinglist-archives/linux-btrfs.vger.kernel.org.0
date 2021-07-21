Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12EF3D08E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhGUFqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 01:46:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34917 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhGUFqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 01:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626848832; x=1658384832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obmUbAlWbL9nndI5TgkOch831uwFiyDsYEvXx5RWrwo=;
  b=XZVp/mGbTtWODrrQl8Zqm0xkyzXU10iYKvI2cf557m9ub+Nbd/UBEPr+
   yTXrMh2oxQeMaXGXvo75R8eR+r/sbq1WOsPkAfZ5aB6CrIwDf3m2gzMAq
   2W2yar9cd6O+ygmJ5Y4KMqDBSb+ZNlhb5ZaYrJE1Ef6aQFHw//6RwiOBk
   MFIGZxOa/d3Hv+wcfMgQCLf4ySTIpoV5EYbU7eYzTk5abeLE72UbLibts
   IL87Bj6Y95zh0C8XmE1GofhZV/QyT0KNJ5nGt7/UyDOXAhFIGkIdICsvh
   7r0AUn3n7Ue33EJy7lRgskDlaRO+NVh36m4RzPhyRiGqOhGvM92Owrdx1
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,257,1620662400"; 
   d="scan'208";a="179924896"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 14:27:11 +0800
IronPort-SDR: ShfAYJ3a6bhTxrf6TYFZA1JQXfnsEEjo87rlt9up7xZcYvwvhfRZ8d7/z37z4I8eAoQl/n6nEo
 +Z/972Yz4xO9yeU6Rm2TJEcnyqC7NSaVhdgmjW8XL3dAHC6fImPM8WRfw1bIBsfOKZi17FSNR8
 KJ4OmwWa1XRrpFQiqIuzrLyeQG2oeG0syJRfy7Cs/hcJZyqSEb9cz0gEBL+sKXijtOZQzUo1Er
 VSUUO6X3ZsWdizWS5y4GKv57eO8E8BQlx7KinpjRuc8VZCDaE7I0H2RncwQn/VixmL6RCOVO22
 G5I7Vi5DQFs3GTAlULZr1uSu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:03:27 -0700
IronPort-SDR: DjI/fC4xzWDbttXeu4K/6UCGUCd4OXaEk5gnC/mKHF1sFrQXy6esqx+HsBXiypT8YNAyh0UXeR
 60RLVHig1UY9Xqgxk4rFJgPKUu8LHFY/OU/YzNKGz9PCkzTSq+LMR5YtV7lquhK7iMcB2cNTW5
 cXzno+l0N4LRPQqJYHLosT1ZMBb5yI9NezwNl73B/8UguX9lYTyIXN4GiPN77UMOOsvzW2VKnZ
 YOwjaV1Fv492XgFNxB6pfOsohj6TBMBAHMsnt2BukV8H7ScPfwkjXdFOY7s55UHn8bbP+rtbZH
 1o0=
WDCIronportException: Internal
Received: from d1zj3x2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.44])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2021 23:27:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/3] btrfs: fix argument type of btrfs_bio_clone_partial()
Date:   Wed, 21 Jul 2021 15:26:59 +0900
Message-Id: <c69cf6f0b81a28dd04b62537e3b8b4f46bd36e1e.1626848677.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626848677.git.naohiro.aota@wdc.com>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c | 6 ++++--
 fs/btrfs/extent_io.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f947e24091a..0040577c2f4e 100644
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
@@ -3165,7 +3167,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 	btrfs_bio = btrfs_io_bio(bio);
 	btrfs_io_bio_init(btrfs_bio);
 
-	bio_trim(bio, offset >> 9, size >> 9);
+	bio_trim(bio, (sector_t)offset >> 9, (sector_t)size >> 9);
 	btrfs_bio->iter = bio->bi_iter;
 	return bio;
 }
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


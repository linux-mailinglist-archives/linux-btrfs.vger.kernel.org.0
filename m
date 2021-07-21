Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDF3D0EF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhGUMDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 08:03:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44572 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhGUMDB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 08:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626871417; x=1658407417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UqacTvKA8zu7lo0h2FE8f+bJnLjSwx4GkHwcOY7214E=;
  b=rnSKZua/cGXLcTYnWBse+HPNvmRRH271qAU/d6D8UY3PNDzgWd/mgPE1
   wqATv7xzYAzrzO766rcLc3g1tqCFeus6phAQtGIwbTddqRcLT9tmSx5+m
   VULGGz3NY+i5anciCz9LPL/WuFhA5C01eWmD7yG/+PHvSUMDlDLHZwm7P
   Xxpoz9x5qlIfx1+ADgzqsdZxdyT2ngbSgzEQYrRbiXSPSIz8PW5+tDSoe
   qqfnUPyImvllw1ZOXBdv3kCfujIVzY78xrKt/hp5ljc9jpwFbe4qiJ6np
   1jr2xNHBxw1+10P3C4tbyOlXbxvC/d6Em5e+EE8iIPRXFmSXYbymDL6IR
   w==;
X-IronPort-AV: E=Sophos;i="5.84,258,1620662400"; 
   d="scan'208";a="174366709"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 20:43:37 +0800
IronPort-SDR: 0vaq1Pyybk/wDi3XiR9U6z8Z1LeQZ9XIh0jgPyYmdwcTzoc2HQo3HFFIMp/oIulSxqq3Q+o5lb
 9AuH4xv0pXFTNmjYQlKdiZHOuKprebbx6uOuwXUSGAeqtSvFHa3yio77ksO96PN+4y6G61jyZp
 XCaNtTQoQHnmxKg9jTE2O6b/FvBr84Cb+43N11gw+Mdz0pXbT8FcwMc5tY0moQxaUFMyLM0DtS
 ekL/mHI92SiW1T/Nn4S/p1DED7w0kl0WNIBr0SO//ZNM5BsVMmSCPh7TiFvJbwxvrKyQuZEIk4
 qxK4Pj0V+RI7iavKmnE9Luy9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:19:52 -0700
IronPort-SDR: cX+x9bySbCEoKj8hVZEd4i2s42N9fp2/g+Jd8g4iwD0EBAAf42hyigBDucKBaEMCHSUV3SncJ+
 hWtykR2JPcPfXz0GW5iJ+2NEkQ2x7Z5X46ktizFPcry3AyV8uokGsoRRA3M06Vk6WzNraH8Dr3
 Kl6rk2WAXBncly7IoMh5uY432Ws8YOQPy/c8OFM4rP0GszNfFyeDf9WluwkQWmHU4rI7kSB5+3
 gniOKasMTI77NK7C67ZR85Q27JrR/uLxnGiQtXQoC0ijhGwxoWcUcTdLBsHTzzha8F/0tbg4rT
 RH8=
WDCIronportException: Internal
Received: from my8nr8qf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jul 2021 05:43:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/3] block: fix arg type of bio_trim()
Date:   Wed, 21 Jul 2021 21:43:32 +0900
Message-Id: <4fc8537f6dbe0c27489a3431b3a3240013268031.1626871138.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626871138.git.naohiro.aota@wdc.com>
References: <cover.1626871138.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

The function bio_trim has offset and size arguments that are declared
as int.

The callers of this function uses sector_t type when passing the offset
and size e,g. drivers/md/raid1.c:narrow_write_error() and
drivers/md/raid1.c:narrow_write_error().

Change offset and size arguments to sector_t type for bio_trim(). Also, add
WARN_ON_ONCE() to catch their overflow.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 block/bio.c               | 12 +++++++-----
 include/linux/bio.h       |  2 +-
 include/linux/blk_types.h |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..0bf2b865feaf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1464,12 +1464,15 @@ EXPORT_SYMBOL(bio_split);
  * @bio:	bio to trim
  * @offset:	number of sectors to trim from the front of @bio
  * @size:	size we want to trim @bio to, in sectors
+ *
+ * This function is typically used for bios that are cloned and submitted
+ * to the underlying device in parts.
  */
-void bio_trim(struct bio *bio, int offset, int size)
+void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
-	/* 'bio' is a cloned bio which we need to trim to match
-	 * the given offset and size.
-	 */
+	if (WARN_ON_ONCE(offset > BIO_MAX_SECTORS || size > BIO_MAX_SECTORS ||
+			 offset + size > bio->bi_iter.bi_size))
+		return;
 
 	size <<= 9;
 	if (offset == 0 && size == bio->bi_iter.bi_size)
@@ -1480,7 +1483,6 @@ void bio_trim(struct bio *bio, int offset, int size)
 
 	if (bio_integrity(bio))
 		bio_integrity_trim(bio);
-
 }
 EXPORT_SYMBOL_GPL(bio_trim);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..fb663152521e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -379,7 +379,7 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-extern void bio_trim(struct bio *bio, int offset, int size);
+void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..24dfb980fb3f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -285,6 +285,7 @@ struct bio {
 };
 
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
+#define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
 
 /*
  * bio flags
-- 
2.32.0


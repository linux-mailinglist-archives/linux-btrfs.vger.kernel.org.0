Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52A13D08DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhGUFqh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 01:46:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34917 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbhGUFqd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 01:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626848830; x=1658384830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BdpVKhW5llu876IYs9lOPTAZLYKqKV1WZQpNucWVQ0=;
  b=rLShFKeYiabkDMKansZxoervhYtjFwZ9fYYT0KTZf68g59V5V5TpsCeX
   KHTcMevPb+Y8sj1BDA8qPA4zvwDMdftlC01xAJ5yILOQiAGfXG0yTpRoq
   JqSOykWSJx8TiLJj6XzYsj+74odietC8Q7/P7PutTlfKIOlP/vNakHH/W
   xXlFMYWiscmayNFORqA1l93YlIbyhZUgDgvKMcupgaByHJd+QD0f+KNQ2
   R7eaSh+JiO+6f1o2Da0my69T8FhCQ//Ap/HxvhSfupoIrh2OcIIkv3n23
   0EwdD8Q+5OvzcQZInYOGvKHAmoxGbOR6mUuwRSugS5QOJZEPQswVPZxHO
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,257,1620662400"; 
   d="scan'208";a="179924892"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 14:27:10 +0800
IronPort-SDR: ORF9zoC9RTIiMK65GDjIWoJjS3aCnW2nWrmEDrfXKNDaWvyAhV+z4UzYQsbpudFFkvtjZRD4vY
 k8PYMjut2PNWuI0T3wwd7Q0/qVd8pF0/Og9GEvQZ2Dk8gWHOVvsCoGyx8XckcsFYJV0A8gLQVk
 w805dKK9Rhgze4geDq3AvcCJkFmqmrsTJaQSxlzJ9/RTmvEnCNWIeVbyyKGQPIqZke4zo4Rx0X
 kcIXkNRs70lMykqCL8GsZLsPGBtqKh6khrLGAWSCeR0QGogcADddqxx+0mnltZNpZsca+qD+iT
 fye7A89Rp0XiLzc0cfbvbTOh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:03:25 -0700
IronPort-SDR: uXOoQQH9qZ3YKkXYcO7gFrMjiZFs3Pe6qtaq33pgCP/+Ib8l/77e4hvtdNyVHw9Yz/UvbYsxIs
 MGFjQy6tkRT5ozYDvrJLfKjQ3zxE5EJk0jnzKTMyPbR/3pdOMLbrw4qe5PaUKOcdkL1oxusrm9
 i+2Fobt22SdNofrEUnp/2cX6UIiq5IRBDHIeD5GUtlw7boX4DGqvr219rmhgx3BenPu8RqQHfC
 qJSYrwIvTQFfIFMH+QUx53j/Ln5CYqob8wJm1N3WCp8GOI5Wmw6kZpACWvxinfyZDPa4syDxhM
 weI=
WDCIronportException: Internal
Received: from d1zj3x2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.44])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2021 23:27:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/3] block: fix arg type of bio_trim()
Date:   Wed, 21 Jul 2021 15:26:58 +0900
Message-Id: <6bd02746905e41dfee04f2500d6d15f9b9b73fc9.1626848677.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626848677.git.naohiro.aota@wdc.com>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
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
WARN_ON() to catch their overflow.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 block/bio.c         | 14 +++++++++++---
 include/linux/bio.h |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..69a9751b18e7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1465,12 +1465,20 @@ EXPORT_SYMBOL(bio_split);
  * @offset:	number of sectors to trim from the front of @bio
  * @size:	size we want to trim @bio to, in sectors
  */
-void bio_trim(struct bio *bio, int offset, int size)
+void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
-	/* 'bio' is a cloned bio which we need to trim to match
-	 * the given offset and size.
+	const sector_t uint_max_sectors = UINT_MAX >> SECTOR_SHIFT;
+
+	/*
+	 * 'bio' is a cloned bio which we need to trim to match the given
+	 * offset and size.
 	 */
 
+	/* sanity check */
+	if (WARN_ON(offset > uint_max_sectors || size > uint_max_sectors ||
+		    offset + size > bio->bi_iter.bi_size))
+		return;
+
 	size <<= 9;
 	if (offset == 0 && size == bio->bi_iter.bi_size)
 		return;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..c91bc70add06 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -379,7 +379,7 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-extern void bio_trim(struct bio *bio, int offset, int size);
+extern void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
 
-- 
2.32.0


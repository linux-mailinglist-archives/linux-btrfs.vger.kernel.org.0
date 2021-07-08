Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B513C1401
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGHNPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 09:15:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42292 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhGHNPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 09:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625749957; x=1657285957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsm350jfoKt4/3nGe5MPD3rxlEZZX9Ax374HVNofoOY=;
  b=itCvWtVTuGfS8mXZV4tz4BztNGDnylsSfvc70s7zfrl9qgodWeMaRHvV
   q/CAOU2FoGPxW/UXvjQOGjtc1xNFIab+wULsFpg5sPpjNRGKiUt0Hnjhj
   Ig3o4RrTFp3rbrcZG09ZzBtYt/WajsfO3lOuHF3LPkVjVgtNKUywVX4VU
   9CnbR3R0j0UeubmsKYKYDjbpdQKi+QvyU5Rv4jMiGDACm9qkFWVx+7bbS
   cp68BwadvxpsBQPQcPOyeoqTfrimBIkjk9QSZMn5Om6Xga6qcpfPF1l4L
   rWEoQPqfYkkHG9klO+nZGCmzFmQepqDbjDJac19naubZ35DLSeWypemd3
   Q==;
IronPort-SDR: j9snqBTd2hqo4pjTBszdhgwAJcvm6IzvWKdnm4ycJw0UA9uw5xm3YRxS2j+33Uw7Oj93gh3xqz
 zmgXRezCkhyO4J+qXCEn9AW9Tm2nvaH9qgUT73hfTACSIXSU1Qo3JaZPhyDt7U3M7BnDFSF0k0
 3D1ZvEu6Jb5Vh+Beskn7ZhO+BeZgu44njhw3ofaXi14SVbhnPdUuVqVpxbFqcBCAfV/HYHy2lr
 c6dVkFHOOzI5ikBJqzql0yugpvQkzHF0gpVGTo6cQvL3wuAenMU8uX2lqxTc1NNeAfb//7NVZP
 euo=
X-IronPort-AV: E=Sophos;i="5.84,222,1620662400"; 
   d="scan'208";a="285562706"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2021 21:12:34 +0800
IronPort-SDR: c1JqsLl0BLKTUzeqVp0A6IIOUMZlr8yFUnzb5HLFsEpOAfzrZJJamA+XM3Lr4RU+gg4p+X0RAJ
 2Iav6rGK5s/GaFNMYNGcuY8z5Z5JuMbGWHNZOyG59qQwL1Mld0KQAmsipl0k77UmLwa52MoRt9
 ZDgG2MduT7nmwQMJazLnVgz8IQur92vjpgaBbkGZeUTLH1EusDIHAiwN4DDIIhNm1p6BrWzDcn
 VH2m00Wruc7VkDuz82E+7jAihr98yEhXrzAdA+jOSWyMT5zHh3ykAbhHzSo5ioNsHnZsocDAQo
 lixFA47iGMHV8EyZYG+eioV1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 05:49:33 -0700
IronPort-SDR: Xr2M3rkLhKlGAlJ/5fUE4ginOUUnlb7K5udbqCfJdFotFfeBEr84FuTFWm9fPgxn+4p2/6f9WI
 JezPAKafztXFE4YMS1tNVgSaoHbr78NCPxubeurpqyEeYxSjnuwqDj2s7puWYOkfCP+rmTau18
 H20+4I2u/EWSP+ffC6LuNYeGS20lGMO0E3srtXd03CFRQ+yQLdnXFlXcllpb1LFqrc3CF4yII1
 ELGemzdgkWhOF8Lkiu2KBOSYHnPkI2Nj3LcMBPmiGf4YSz19TxbBzhwquIVHlgVGFoHH3S1mhQ
 6qc=
WDCIronportException: Internal
Received: from b1j4fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jul 2021 06:12:34 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] block: fix arg type of bio_trim()
Date:   Thu,  8 Jul 2021 22:10:55 +0900
Message-Id: <20210708131057.259327-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708131057.259327-1-naohiro.aota@wdc.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
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

Change offset & size arguments to sector_t type for bio_trim().

Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c         | 2 +-
 include/linux/bio.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..d342ce84f6cf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1465,7 +1465,7 @@ EXPORT_SYMBOL(bio_split);
  * @offset:	number of sectors to trim from the front of @bio
  * @size:	size we want to trim @bio to, in sectors
  */
-void bio_trim(struct bio *bio, int offset, int size)
+void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
 	/* 'bio' is a cloned bio which we need to trim to match
 	 * the given offset and size.
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
 
-- 
2.32.0


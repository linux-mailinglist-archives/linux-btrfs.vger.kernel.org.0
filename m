Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEBD3C1402
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhGHNPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 09:15:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42289 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhGHNPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 09:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625749959; x=1657285959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dp126TBiOhmZPbSAIauIoF+LNRPkb3kiTzMH0s3VNhk=;
  b=H1W0/0D+Hb1Nhr7joSIBkKx1dx0WpB1n+WNf8ABcmc7xZTzFMeHUhRFJ
   T36yuJQH1bmt9UAqWIw/xVp7UcHwUCkLxKsOezD7JizaG0NKbRmObVMbq
   9SRK4rrkc609rip7rMejUDflNJXMJ4M7iObdx2yGwRjqHFNQcxA8MS36e
   6PFK6aMYdq25G7JXyAljZsX0RQ/GNRiQERGzlSxAmqPfAFyIXkHyZhFxI
   Z2ZQfPUideMD9JMC24X6KDdYomJpALU9tBWLS2lP6kK+lE5XPGTvmKcsH
   +9dB0PLenxslLayAj5af6nktfeZVKY1SH1fu13QJS5gUbmMpm/qwrmvFy
   A==;
IronPort-SDR: fTYL/BIOsz6x//2UXgmF37crP4nyigfYWu+FGi/oySFp5SDhN8cajFs5byxP88mhlZ2WJIh24I
 le1mkUzDG8OPA6WCQ9lt73Awbo+ibyPboAhV6yOK2PyIF0VVm4kXDkA4gr7xc8u6dA3ECAqxtr
 M0gKcfvNwgu2uBtWQEqnA1kSRNig73pplPustGjP4PmpYcmal/luKLN97jWX8ck0VGky0swxX9
 6y7FrrH4Zh+HXGF6+YODFUMflmwM6ehZBoyTY8+QgGBMtI89re53ueNgfXOfJ97fdkYhHaRW6W
 jFA=
X-IronPort-AV: E=Sophos;i="5.84,222,1620662400"; 
   d="scan'208";a="285562709"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2021 21:12:37 +0800
IronPort-SDR: KotAkmL+m9XjY5lGXnLsfeKHb+LiAoR9Le0U4UwFgwXdfKKXTX+BJFZhxY/xqeaRYwmqy1XhT8
 9nF1zXu81jy3oi2T3wYH350z5m9nK8qdm6AsfDbiwjRsH5IEL36YPXF1ZCn7Q5SJGS9vyF5L2j
 ZEO33HpUI7iBLqeIXGxQotft2zKLD0mU6udaPO2AmqnbNphRm9WiV8tWZx70qEiRjUk0sVUdqt
 y9pdi2nS1BjQ7gVYlfSpCY31pDgJ6om2CFWta0pjxusKfAJkhsP57buKvMI2d6XEaIS3NpKiRW
 9IqGoSBMyW5dP17UTFvvAnUN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 05:49:36 -0700
IronPort-SDR: i3qKuhsRNdg7MnBiwGtUyySHlKHEY4TTPpz/xjScYAQPMiUf8lXbuO6pRgZ8sczFxBj8ejQ8ve
 1juLiXililMLz8AgjeJ8nYO+U9wnrqvT7YPWOWl2do16111oN/9v+uVFZkjttQc2HHjKVZOrYA
 AOOfxXT3KVyFcg/57+VbEEHQbmJnXq5MJ/gXpJK5XkblLEsG9G0PJi16NCdadj/tge3eXi3zjX
 vgKh+xE2tguPNS6K5fPpblqoYdu6yJd94mclsH7tvDng5HzR2AL6ZYhAhj8ia/MSKiT2F5Q94G
 kAQ=
WDCIronportException: Internal
Received: from b1j4fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jul 2021 06:12:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs: drop unnecessary ASSERT from btrfs_submit_direct()
Date:   Thu,  8 Jul 2021 22:10:57 +0900
Message-Id: <20210708131057.259327-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708131057.259327-1-naohiro.aota@wdc.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When on SINGLE block group, btrfs_get_io_geometry() will return "the
size of the block group - the offset of the logical address within the
block group" as geom.len. Since we allow up to 8 GB zone size on zoned
btrfs, we can have up to 8 GB block group, so can have up to 8 GB
geom.len. With this setup, we easily hit the "ASSERT(geom.len <=
INT_MAX);".

The ASSERT looks like to guard btrfs_bio_clone_partial() and bio_trim()
which both take "int" (now "unsigned int" with the previous patch). So to
be precise the ASSERT should check if clone_len <= UINT_MAX. But
actually, clone_len is already capped by bio.bi_iter.bi_size which is
unsigned int. So the ASSERT is not necessary.

Drop the ASSERT and properly compare submit_len and geom.len in u64. Then,
let the implicit casting to convert it to unsigned int.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c5..b6cc26dd7919 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8206,8 +8206,8 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	u64 start_sector;
 	int async_submit = 0;
 	u64 submit_len;
-	int clone_offset = 0;
-	int clone_len;
+	unsigned int clone_offset = 0;
+	unsigned int clone_len;
 	u64 logical;
 	int ret;
 	blk_status_t status;
@@ -8255,9 +8255,13 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 			status = errno_to_blk_status(ret);
 			goto out_err_em;
 		}
-		ASSERT(geom.len <= INT_MAX);
 
-		clone_len = min_t(int, submit_len, geom.len);
+		/*
+		 * min()'s result is always capped by bio.bi_iter.bi_size
+		 * which is unsigned int. So the implicit casting it to
+		 * unsigned int is safe.
+		 */
+		clone_len = min(submit_len, geom.len);
 
 		/*
 		 * This will never fail as it's passing GPF_NOFS and
-- 
2.32.0


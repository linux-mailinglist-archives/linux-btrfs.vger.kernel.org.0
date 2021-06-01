Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02A3973BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhFANEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 09:04:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFANEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 09:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622552539; x=1654088539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbB7BFb7NtQBeFytSNxdRRro5KT/vbl/BUVZpKE9qv4=;
  b=VudPcVm4H90f4Fp3wP9FOWbrFNnySgIzUU/AstbHjrmGZ9ttYgGNmV5V
   cCEa+aduZ3Y8uSPsiE5BP+OMn+Pvme2NFotEzeJ2NlAjZm56IBoSPSokm
   5xhjYBzSDcvN3pvs5V2P3+W2eIby9RFIW/YTX9bPCWrDitw732MkP6xFu
   2ZmE5YxMvWl8rNIW41BsJU/gWD1vo1KRoZi0o9xV+DkXgYFMy0mXcd2Vm
   GlhSiJjFL2nobJdsQ4JphhO1XQMsSwShXWP0y1fzktL224GrB3Okc7vvJ
   5K8zBWQ8YhNcGQjAhT8w5ZMX0z5x5WUWrk4mMCPdZfzBCyS8jkh9yD4HF
   w==;
IronPort-SDR: EfmHEVWqY323pTtAbQP2L2ComB0HattBQDYt1CtvCacUUQUmq+MdqYYhvBMchrmRDXl5tjWNkp
 mgBl+6ONegb9cFQ9EFhIS+tXZ/a2rfy3vh/7a/21hpXgNyZNp1A+A+x2wcnBgiJ9FSpudZmysZ
 hXmNKjhV/eZ3eMazmJPrFmHHaqSbqHYZ5MyJkGwAbA8faZ7IumWP7bzUe3ysQaMWfR/M0ZQHTF
 J2qbaVjihEogkXGkE+K2Zi9FamgP4ll23gBEflEDoAwo83E8TpJPO3A88X33O1t6jT7cl+/Hl2
 yfE=
X-IronPort-AV: E=Sophos;i="5.83,239,1616428800"; 
   d="scan'208";a="174991979"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 21:02:19 +0800
IronPort-SDR: QjeJTRQwdGyNhAhB0VB9qCQlnddDJBAZuDxIl+RvuXXPPtces19YJ9J6lSTc5ARx8poC7NtXnk
 dVPEOKLpQBK/SBTHM8s8Q8Ckx6XEFwH2QtJoypVG386W0kgi9VyyiyV+d/I3tEWL7ZGEcPaAe7
 7bbUsaJaA5ylcE8HyPZLWFwzYbcN8eWeKKGzs5AvLqLQvltaTTKfIK6/4PYnZDJsPepx27CUu5
 01vHF6i0Rj8h5DYcp0FVngveF7S/HrCk0NFH9UxfeXAIZCuXWttti9Pgsv/hdqzKdGabTFhJla
 HOrOpOl+ZogmQ3gT+vwKUeZg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 05:40:12 -0700
IronPort-SDR: pUAyKM25UTrkQw0Ex3oXFUVrtPxGanpOJdtT1TjTML971arU6qxO5rVO6kDM0UtET/s7XehxtV
 Tx9AzEncnYKRc26sDZIRqGecwiwptgxTTekh/MsT/LaurFImRSo0OMlTFXToCi5zx77C3t5bcW
 0+X0HeMLOpdJ6D0B8X+7YhsueFNfcnIxy/mEo/1QV8xJ97bbwGZSbgjppRu0zR/tHlg5HcVHh9
 K8KKRU1RND2YPe7QyETvGJFRGC3j7HSt44K/26ELNhZS4kM774qd/z/DiyAsWU2skSo+mnIYlV
 Yh4=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2021 06:02:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: zoned: limit ordered extent to zoned append size
Date:   Tue,  1 Jun 2021 22:02:10 +0900
Message-Id: <da3a097233a87541120dbb2a9624841c7a9e3962.1622552385.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622552385.git.johannes.thumshirn@wdc.com>
References: <cover.1622552385.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Damien reported a test failure with btrfs/209. The test itself ran fine,
but the fsck run afterwards reported a corrupted filesystem.

The filesystem corruption happens because we're splitting an extent and
then writing the extent twice. We have to split the extent though, because
we're creating too large extents for a REQ_OP_ZONE_APPEND operation.

When dumping the extent tree, we can see two EXTENT_ITEMs at the same
start address but different lengths.

$ btrfs inspect dump-tree /dev/nullb1 -t extent
...
   item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53
           refs 1 gen 7 flags DATA
           extent data backref root FS_TREE objectid 257 offset 786432 count 1
   item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53
           refs 1 gen 7 flags DATA
           extent data backref root FS_TREE objectid 257 offset 786432 count 1

On a zoned filesystem, limit the size of an ordered extent to the maximum
size that can be issued as a single REQ_OP_ZONE_APPEND operation.

Note: This patch breaks fstests btrfs/079, as it increases the number of
on-disk extents from 80 to 83 per 10M write.

Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5d0398528a7a..6fbafaaebda0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1373,7 +1373,10 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 
 static inline u64 btrfs_get_max_extent_size(struct btrfs_fs_info *fs_info)
 {
-	return BTRFS_MAX_EXTENT_SIZE;
+	if (!fs_info || !fs_info->max_zone_append_size)
+		return BTRFS_MAX_EXTENT_SIZE;
+	return min_t(u64, BTRFS_MAX_EXTENT_SIZE,
+		     ALIGN_DOWN(fs_info->max_zone_append_size, PAGE_SIZE));
 }
 
 /*
-- 
2.31.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48416B852
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgBYD5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34241 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgBYD5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603040; x=1614139040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rn2jZXEY45B3cB+vxe8yFrI8seLsouh27GclU6Cx07Q=;
  b=nxPjCebZ10cpn/mrSEBBfv1MJDiA8krgFnyAdeEECWwpxHcC3bk916d6
   ghgC8eUYw8KOStgKhr4Nlv9B4kRR6T7Ut8cF/6Q3TQ40B7NTtSB1vHmod
   Jn2YBq39m2PyBPXx0u+dbKoFrDV292iwGGvPuAJJ/A5P4dM5ak5eL/Cmv
   PltWk5dtnnGMNZ4bhLt7Hiz/UTr/8SX+LoKF22z5cw7yiF2yTtUSHl7WD
   9T8Pp96MKpTFf6t6P3IyyRRR1ry+wdecl/VO3XBO1fJPl9GZyWHvv1lW8
   MCNtXucvzLpohJs9tXxJTL6PnYMSkmmhjF9xUzOSEQptlab3RHYHbbij0
   A==;
IronPort-SDR: FY0b5ssDC80qV3iPE56bJ6HKvWMlhfWsWMRLFGX9h19DGmeLXnyBt4z/gNOJbCtmG4G41zgKWN
 OX+HEeMzwERibCVirqfHT7cjUuRWWagrOSCo+z4gp3RAHrMlep6QW1CKyFPW0ezpG8DSGGInuY
 pXajYCgMOWreDu79R+MuI6wUt3ZeHNV0LhYrxNa4GALw17Je44rsdFuEXHoGpYV6ZI6OQP86F5
 zruT6sS8iQGZbplgu1RE2GD9Vdw6WO9FmBifVUFGx09uy/KAhEmfcwFYl7//P95BOl/Tkk9Hw1
 uE8=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168311"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:20 +0800
IronPort-SDR: djicKxs1OKwOxinZ+SdyHav7sSO6DtfOLA9QMsKm5rC2oDNOKhwD/5cUDKz2h4KyscvlrKkd0H
 PGHD2XeNiOKeP1rRzrC7um9RfCapllSXlGFD3BfyDKQ2nRB6zCEnfGYIKs+101ocPD9hMsyrmV
 HFMJg8HXLze3uHVLIn54rDAElITpqLkPpX+88BCVbNRhd3w4mfeTvjYPtFylMdZZjo6z5vBX2R
 9B/rIoeQOYWEBXHi3feaW6Esefyv3h20UY+vkN56MAmObs4hTma48RgEHocbXvWJsuONPRAl7B
 07ujbKANYYuiy4Sl9swSYdrI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:48 -0800
IronPort-SDR: 6j30vn6JJx+CmgQLAmHHANdkENu6Pty5nzfBBcxUztr5vQrTYuYpp2wvpYu/sORgFodIf7u0v7
 BQbacFdV5VuPo8z71DiUk5fiZCEjf6nsqNL8OVo0PXTui4Eq2+ElaQM10etBKrD13w9z22jGeB
 g2UH8nh29W7PyyqUWh7x+zEB6EwqN+NT03OCgQyxK4Oup9gZ0mGT5vrGxHx8irB6ofjEGoJtrT
 S5K9nKr37V5gB8pbdRJJi1hipsR0fPle+C0Pnbo5Dom3YYul6A+5nHkmvWGMFj/G7WnASj8C8z
 HyE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 19/21] btrfs: factor out chunk_allocation_failed()
Date:   Tue, 25 Feb 2020 12:56:24 +0900
Message-Id: <20200225035626.1049501-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out chunk_allocation_failed() from find_free_extent_update_loop().
This function is called when it failed to allocate a chunk. The function
can modify "ffe_ctl->loop" and return 0 to continue with the next stage.
Or, it can return -ENOSPC to give up here.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 05edd69f5fe1..cb82eaf28033 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3748,6 +3748,21 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	}
 }
 
+static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		/*
+		 * If we can't allocate a new chunk we've already looped through
+		 * at least once, move on to the NO_EMPTY_SIZE case.
+		 */
+		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
+		return 0;
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3819,16 +3834,10 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE);
 
-			/*
-			 * If we can't allocate a new chunk we've already looped
-			 * through at least once, move on to the NO_EMPTY_SIZE
-			 * case.
-			 */
-			if (ret == -ENOSPC)
-				ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
-
 			/* Do not bail out on ENOSPC since we can do more. */
-			if (ret < 0 && ret != -ENOSPC)
+			if (ret == -ENOSPC)
+				ret = chunk_allocation_failed(ffe_ctl);
+			else if (ret < 0)
 				btrfs_abort_transaction(trans, ret);
 			else
 				ret = 0;
-- 
2.25.1


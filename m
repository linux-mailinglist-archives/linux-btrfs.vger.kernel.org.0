Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84072663909
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 07:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjAJGF0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 01:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjAJGFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 01:05:03 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D112AA7
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Jan 2023 22:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673330675; x=1704866675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K+WkvtaTOnxzzfetmmMwL6RLLkpx6ikCQbHf2y+wT8Y=;
  b=IjC+P1u1pNA3zLI0747k8WZ+PWyv5tU8Sm2qtwbsmKZHAL2RdDxi1kcl
   eIDXL0weTkIpa6Rjw5k076HxS/O34WEpTNFzSeSn2Yh1Kd5ItwHLPlUBV
   kVD1iA63A83CQxQk06luWz25iR7Slz57FQuq3IObu+GsxubH2ZUcPZ4eT
   lgJbslcqZYypb+BzbmjDnXATLMHacux4L68yYZEyY7igdiUAUlBukjc5m
   RczP5pg7SDkjH1N8AeFVopP2C9V9PrNkftMAf4w0rha0PSLHQrciediZb
   xT52acg4m+S7p/+bxMrpnyQrxcyWx3Wi6emM7MQhd9DPWqTZvuLUYjxP3
   w==;
X-IronPort-AV: E=Sophos;i="5.96,314,1665417600"; 
   d="scan'208";a="324712835"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 14:04:34 +0800
IronPort-SDR: K7ZQK9pddVb+9QPev33j2ruqojdE8ZeIeJfl0tsxHpYAnyLp0WvW/yc1yF6XJzGwfQNIHtZtFd
 8myY1VJS+EgasSlJ8Pb3MFTsxyrzikXYZTfvp3R4cLWCMlnwE//nxjAOB+yA50e1ZEZeZot20t
 rniqUXlQlXTBc1bL2W/uB1WeNUhxcTkMwUrQlzzrpvWDuzSa3yNy7XWVxYMJpVCfypWwfn/BFr
 NbetlLYLNtoslvY4CRughIDnl6bIsQh1yZOdCIoI/6DLIVQzohRjfFfHzvA+cHqyeuti5YImKR
 +/c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 21:22:25 -0800
IronPort-SDR: Lrzl4uCN2TUCyBuK25hiP91XQA+YQKOuFkzYxMnNH4SbRz8fuOn+gFTKzmOPlEQQNeHjPEvbSm
 BkfSeAmMrWf/7dTtxDoDcKKXLCcT2ZJUfGzJsNVdB2fNobUMcITb8/7+I86Q5czGMqauwaB1QG
 N04BknXLXw3I6qMN3lkOPy2PAqCI6x/IDwr95iWjbwPQmHzTnAFSQmH+9QZmHeYojkZFN7oqBJ
 8KbxmzAaVMK4+hOpHWKvAS7+huqv+/D8QQLYNWA8VmV3SkKGwlu+5DlTWBbnHY3FgvV15fxz4M
 41Q=
WDCIronportException: Internal
Received: from f3b4fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jan 2023 22:04:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: enable metadata over-commit for non-ZNS setup
Date:   Tue, 10 Jan 2023 15:04:32 +0900
Message-Id: <e0290c4d7af96991ddee4442a1c602cfb3a79ba3.1673330455.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit 79417d040f4f ("btrfs: zoned: disable metadata overcommit for
zoned") disabled the metadata over-commit to track active zones properly.

However, it also introduced a heavy overhead by allocating new metadata
block groups and/or flushing dirty buffers to release the space
reservations. Specifically, a workload (write only without any sync
operations) worsen its performance from 343.77 MB/sec (v5.19) to 182.89
MB/sec (v6.0).

The performance is still bad on current misc-next which is 187.95 MB/sec.
And, with this patch applied, it improves back to 326.70 MB/sec (+73.82%).

This patch introduces a new fs_info->flag BTRFS_FS_NO_OVERCOMMIT to
indicate it needs to disable the metadata over-commit. The flag is enabled
when a device with max active zones limit is loaded into a file-system.

Fixes: 79417d040f4f ("btrfs: zoned: disable metadata overcommit for zoned")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/fs.h         | 6 ++++++
 fs/btrfs/space-info.c | 3 ++-
 fs/btrfs/zoned.c      | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index a749367e5ae2..37b86acfcbcf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -119,6 +119,12 @@ enum {
 	/* Indicate that we want to commit the transaction. */
 	BTRFS_FS_NEED_TRANS_COMMIT,
 
+	/*
+	 * Indicate metadata over-commit is disabled. This is set when active
+	 * zone tracking is needed.
+	 */
+	BTRFS_FS_NO_OVERCOMMIT,
+
 #if BITS_PER_LONG == 32
 	/* Indicate if we have error/warn message printed on 32bit systems */
 	BTRFS_FS_32BIT_ERROR,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d28ee4e36f3d..69c09508afb5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -407,7 +407,8 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	if (btrfs_is_zoned(fs_info) && (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
+	if (test_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags) &&
+	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
 		avail = 0;
 	else
 		avail = calc_available_free_space(fs_info, space_info, flush);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bca9feb34c0c..f93215b377b3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -542,6 +542,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		}
 		atomic_set(&zone_info->active_zones_left,
 			   max_active_zones - nactive);
+		set_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags);
 	}
 
 	/* Validate superblock log */
-- 
2.39.0


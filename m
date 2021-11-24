Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DA45B784
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhKXJeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32207 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbhKXJe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746279; x=1669282279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiJDXTNh43giXrUH3Bs6opM0CpoRIaFrym75lBC+1Ms=;
  b=MxmTakAO+fUy1xICgTWivWDQMNkeA4xHrqrwRdrkAsvNjHr1iXOspMpV
   ZWvt0+x5ENTdgUZbImzo8xd9QyxP+QjAf0Dvr+K2XziJJ3fXYdqgaLVwY
   xclNufJbXyGr4HGrMblXUI/p/yCOMnK7LVgfPSD+r9JvPXgxxedq6N2/P
   BKhKLHeR7wPByEIcnweB/qIizVxh2PnNX/mQTwsipWvwBTlfpGo6QOAFo
   hD5mufIQLGz4XBkHoUTO3lfcunceiMAyDcBhv1ENL8ZX3eYTd3LCoKkdL
   zEeT2TgUd+YgLSRCIE+/L2zsCiCyIdTEEZFF5kfmVopdO3GVsIVWNyd4e
   w==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499405"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:17 +0800
IronPort-SDR: daaK36ItSa1oqcCtr+MfKdqGqb2vJNznnBN9J6Rx14w4MfczUOJxmrPvSCoKAW3nWd1GUZRJ7E
 AOPgld57e0ScorGxnjBstTNjMcmSvnEeanp0XePpPKFzYQZgWm0Mn0eJYdZ3+g8M3lw7tCC/sS
 +7cUiBqfS2nHuf8WhgCERqNEmc+ahsOolZ/lud1n+KdRwIiIeGXr+lHqZR9nF7BPOsxZN8q5d3
 K61n52ekeOfiYlcvX7EMZS/NwYOEM991wAvANWsIDMBT06xiSY57Ew8drNrOZtStv+hpgzjia4
 36b55OlxWecqRvFyagZLLnww
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:10 -0800
IronPort-SDR: K3tqY3BIQAq7r/o+f77BdBitSSTgKsiPOZUf3uqU2/GR2uHUUIKchmGZLzBCSFSmcOzJTy7ftW
 Q5e04ma+yUiBNFv+MNbfu/whmCihReY0aLNVwL4532xLpLmSW28oafBrk4/fGZDVTquXug1MR+
 LCLGYfa/tchS1i5iq1BA/7lsPkqJ/yAUNhjn7FTfW2BdRwZnY8HQivJop/9deWx5klu8z9FNax
 VvYyOyDkf9KH2A+a8XxzLysvbGXmqhTHqk/mzcEFLt7Y5TWuHv2PTHq7SQmdEjA0fHIMV074+V
 NV8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:17 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 18/21] btrfs: move btrfs_scrub_continue() definition to scrub.h
Date:   Wed, 24 Nov 2021 01:30:44 -0800
Message-Id: <a8840b30ecef1c01f6e5faaf7ac09d8e4b61373c.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a scrub.h move btrfs_scrub_continue()'s definition there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h | 1 -
 fs/btrfs/scrub.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5ab09bb0279fe..064281a700ff1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3801,7 +3801,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
-void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index f06e4a10a08b9..69da2e49732df 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -54,4 +54,5 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
 		    int readonly, int is_dev_replace);
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
+void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 #endif /* BTRFS_SCRUB_H */
-- 
2.31.1


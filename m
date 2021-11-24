Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F001D45B782
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhKXJef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32213 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbhKXJe3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746279; x=1669282279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7n2C2BBZx6WRnYleJyTQgNMYaSaBfZ3Aiqc7zmh4xf4=;
  b=B8K6Mbi3Y65vLc4mYJshy8egPTYPdfGnXGp6ri6s0NERhjjnQTC/plCn
   kIMBJS/mpdI6yhdzYd0o3pPNbd86DnKumbgxnAFgRHiB5Q8s9RziG131x
   1MVLnFwGXqVU6Mkn3cds/ZuPZvnF+rTVcdBoj3Pt9c2BJWDf0IGQWMTgR
   zz0gSyz3x1NaQKa/7RRoKuu2GAegIXqa8w0p5YNSNNhowW8dMxn0gAlha
   OtzZFTbVwFU+eTMQPDslSP7clOVK0NdZYAyF9CIkNvC6mZvDA6aKivpxY
   /M5y7fz5U+sILRZrN95yrKFvjaR5k2nL7z90QVlbalaAOg22MYfdwo5Oy
   g==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499408"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:19 +0800
IronPort-SDR: l3QIGd1kfpiLEkPq7lczggoJ5x1pdckmaF/V+BqK3CT8ots0f30aWnFNXnDkQ/JTMjmJrc9Yhn
 kOLFeos2FnQ+ZHQUch2GugHfImBpwvYITpwkWSkznxJmnW+5uGMfTQb7QG+Oqt/rmB3FXzNpC5
 boijQTbexZWbinMviYaAw8SeDJM/CIl13C7pjKcXZg1i91NSODcb++waOMRWKJ5YUYeOzGaCCT
 YBcC66gHukKsddj7ENRhkyzc+8NRcjmZNT/TnLbh34/5wXmYZmoYnSyUjqA11qeGwklkP7RV5n
 ttmN4vcy/mMDTtD/FpZz4YKH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:12 -0800
IronPort-SDR: sf8VdV726vAdXpadHsEwF61kHZU4aX5jjlMxhlDrtOOcOdpSnj4LpLcCHX7XNPwHActnnI/VjX
 J5ZwRuvohNtCXSYJ1UzeDcs9Fz+55I9Z1gRLbyU5E6ZFN1aE+SyMTQWl5WOFlEOtjVH2HvNA0o
 gQzPGAgkgc/wqprNTtyaUwNMAYPMIOQcL/UNu3NCRteyg7yL0U4PvfDlPWYu3R1l5L84o6MwFq
 Quyli5Fa++mLLTaWspjvSfbez86FDBhcqnD9lnCZZq6NPybSxkbQFzx4mleI+73lZA+oc4Hh2w
 vDo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:19 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 20/21] btrfs: move btrfs_scrub_cancel_dev() definition to scrub.h
Date:   Wed, 24 Nov 2021 01:30:46 -0800
Message-Id: <4c2f33c6dd3accaa5740ce9cd3efbc3f247f3c48.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a scrub.h move btrfs_scrub_cancel_dev()'s definition there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h | 1 -
 fs/btrfs/scrub.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7ab88e67e3510..aef03199e367a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3801,7 +3801,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
-int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 static inline void btrfs_init_full_stripe_locks_tree(
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index c511c310d55ea..e6eaf22b04e14 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -56,4 +56,5 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
+int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 #endif /* BTRFS_SCRUB_H */
-- 
2.31.1


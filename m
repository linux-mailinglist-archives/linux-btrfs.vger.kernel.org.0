Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796186B7041
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 08:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCMHr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCMHrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 03:47:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66247515EA
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678693643; x=1710229643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cs5KB1fd8+rXtU1HrOpz5wIpswNGD0A1Uv2bV1YdBos=;
  b=Ku7yJrnoa5zqqMEC0OZ+p00Us7slobuRUvwL4+k40ekPXut7TvNOXKN+
   z9scE61UZoLRKJJR/x5WUd3okcV1Z3FDnMtve8/zZzxtJe19OWn0ZgNFQ
   Jp3VuhcmwckEZqAJtG/sbyNECdUusJez/LB2W3ciyofYTRtRE5pux45Ae
   mPf24uwCuiUGDwWwjLbzW7II1YF26MVMjaZtHSNyZtsXbCVGkWw2VVLHD
   njEyA8mfvqXi5n40KeokIocsb4P2N1i/aw+GVJ2ISUWJg9FyuI0WiqbAN
   GTlZbfDZJmD2mlBamd0e/BbQP/ECnxhFO6zNzUcnINZE+Li1DQ4AS3k+M
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673884800"; 
   d="scan'208";a="337493363"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 15:47:22 +0800
IronPort-SDR: ZZwBiKLoaKC9L0LPpgWPE0DZOCXRDhUXCQGZt2lO6l7jWzSwcWdS0G055wD1anGpmGtyDtzaGV
 jfnLg/jTcqyx6J5RxCiXLD40Pw+R6Doa2m3rPr86tDbzY0RheSIVBtx0sBJmSTuRpRBPXSR3x+
 4ULesOoqzDYk3FI2mOrgqP1k2bKXaKDGyod+qS3dajHbmCM2jq8RlD+cWB8i5RJxnpqCbkSU3G
 LEmog0WTAqj/l+BiAwI72HZNeF6G1nykoSdBHWdjltfoglV6mC9rm5cR4SVYpU1424/hSmaZfN
 KHY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 23:58:10 -0700
IronPort-SDR: 9fR/RoPF4aLLUceUYR1fwY+hh81KVD5pn47fEGzze4oYKPjs+1ljxRJi9cpXqm6jxvrlTjL7GK
 ukc4iThZS/60MAmu4ThZ2gc3MIZnPvfffDWr0QP7zNkYythsYrSDtrRsGu9LjKUytxFAA+0fMI
 TpqcRB8VDgxQK3tOWDzDu+FQZVDuwVQaUm/tuSuXMclMBnDWpTHHE08Ii3GD/WJHAG0xC+hur5
 mup7bE8y7t6lpwNx0q9W7JXdMVTCUkicrDKG4Pq+HMzaMztBJFtV7OBnxSj1JL8fLFlQvq2Dvo
 iRY=
WDCIronportException: Internal
Received: from 5cg2075dxm.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.82])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Mar 2023 00:47:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: relax bg_reclaim_threshold for debug purpose
Date:   Mon, 13 Mar 2023 16:46:54 +0900
Message-Id: <d04a158f989de1f564cd007f05fd51b6b154c006.1678693572.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.2
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

Currently, /sys/fs/btrfs/<UUID>/bg_reclaim_threshold is limited to 0
(disable) or [50 .. 100]%, so we need to fill 50% of a device to start the
auto reclaim process. It is cumbersome to do so when we want to shake out
possible race issues of normal write vs reclaim.

Relax the threshold check under the BTRFS_DEBUG option.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 37fc58a7f27e..25294e624851 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1262,8 +1262,13 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_BTRFS_DEBUG
+	if (thresh != 0 && (thresh > 100))
+		return -EINVAL;
+#else
 	if (thresh != 0 && (thresh <= 50 || thresh > 100))
 		return -EINVAL;
+#endif
 
 	WRITE_ONCE(fs_info->bg_reclaim_threshold, thresh);
 
-- 
2.39.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DBA4AB3ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiBGFut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350001AbiBGDLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:04 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3BC043181;
        Sun,  6 Feb 2022 19:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203463; x=1675739463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUe9FJuEf7BWKrxSIxqPYK0eG0nCVdO3BScCuHtRrAI=;
  b=leIMmFvB1fNOU4iQFEHvX7KHpF9wO7gQ9e0z5xOs48vhn92d0U1RWXUi
   JMVEQGYTHJ2I2R+pnIGcKxuR85L2/sa3KJcMQQ2w7jf8aQVNbAJDjR4Mx
   CEERBX7S86t/1LBE66624X/88jZmfcSGKDmyv25TnfPEJi7c2iSEKO8RJ
   rKXH+QcKwGF9fsC5khI3Hfiv8oS7i+ai29oyiRNJAKW2qMOb42R7RF25N
   nkjRp21EpTIKZ3UVKk92PZjQYFcM/+gF3DjGJTD7rXv2Y8j28FhiZdi3X
   p6pRieV1zck0NgYfe3kabeeyoOdtdRdA92b4rQD9r0iUgjbNOwsM/tRI2
   A==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304195990"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:10:00 +0800
IronPort-SDR: FoKXDcymv3it7luYCwS9KhkSSSYmQnkBqJxoIxyZszo92L9yW747ZxZkkW3MKRf4nzbRN6AFnZ
 HfXK7bZ6nssBub7vxommYVbJ8bpBbsRGshMoc34te5MYDu4ZvaCkz6qgnaG3GKoFaMiB6RfP2d
 MNBpXdddSRm6tgq/ROVlkc7gnPPxlIfn5ttWVodoUqYnwBLZbdz9fjxQ7Bv/GwF5W8xIVIZ7EE
 ++OU8OTdDGQBH04DMX0ozaya6jbmPWweUatzlCFrp0PkhCFHOGwobbFl3//5MoFTcKuFEvV454
 /mo0pU03RR8JQ7t7zoqpnyrc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:51 -0800
IronPort-SDR: LpPZkThfz21jAcl+k6Nr9RI2EQ711559IvHwRHwYXeEiOiMkV0C+tL6mOk9d6ISpjZgpWWdBqd
 v3T1Zdx90vqRJ/5Kl01XcAr+mUl26N1a9GEMzERvWIL2waQxcHyBHYX/8ue/0OW9kgpj+bULdF
 o1EQfkogcAChzZGdmis4B0iqSH6tb9n6ENFD9FwtIecSbMcgwlDksh8pnKnmCJoaoH0KsZhVVV
 bupuxtyQWrvIFli0xRPDDjqU/ejN3LmCikyT+CE8e8KWnUxoT120bVRfWMKdOg3+WAHRTYbAO7
 txQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:09:59 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/7] common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
Date:   Mon,  7 Feb 2022 12:09:52 +0900
Message-Id: <20220207030958.230618-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
References: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper function _scratch_mkfs_sized needs a couple of improvements
for btrfs. At first, the function adds --mixed option to mkfs.btrfs when
the filesystem size is smaller then 256MiB, but this threshold is no
longer correct and it should be 109MiB. Secondly, the --mixed option
shall not be specified to mkfs.btrfs for zoned devices, since zoned
devices does not allow mixing metadata blocks and data blocks.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index b3289de9..eb2493d1 100644
--- a/common/rc
+++ b/common/rc
@@ -1075,10 +1075,10 @@ _scratch_mkfs_sized()
 		;;
 	btrfs)
 		local mixed_opt=
-		# minimum size that's needed without the mixed option.
-		# Ref: btrfs-prog: btrfs_min_dev_size()
-		# Non mixed mode is also the default option.
-		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
+		# Mixed option is required when the filesystem size is small and
+		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
+		(( fssize < $((109 * 1024 * 1024)) )) &&
+			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
 		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 		;;
 	jfs)
-- 
2.34.1


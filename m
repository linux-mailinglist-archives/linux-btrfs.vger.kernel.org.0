Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70494EA9E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiC2I6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiC2I6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:58:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD2190B50
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648544178; x=1680080178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A948YAVd7f9yGG+Cfki6krVaeHX22/PKpDBYe2Jrg7A=;
  b=aNifqISOyRU9njyiIiv859nEDlWRv+ah4a+7Q1gPnB880zg55lvcJYOu
   Qe0ppRaKiXu0SGFl8Ow9+6Jbh4jfpbSsUQWLMgK8EkvPuss6KXK+fekiE
   YCa+U99wa6DpUKTt8t9jSk0zjdOBb3gUlpDKds9b18oq2A/R/2XEZMfGk
   AMI4r5wgQh/vqnU8Lv+FGsfgICfIErNCt6G1nPA0hoWww7X0f0nECRK6z
   cMoYORBPnnMB559LwZYGt7Z6TFAucSERbYrLuk+Ray6s/wD2hhZST8L3Q
   noHpwfkT5JV8XZnVsIx7nySjJqPxkvuNbwMxnJefggVAYsez0lNu+AMg+
   w==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="308481655"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:56:18 +0800
IronPort-SDR: CEiMAawZhjZcUYtEwHmK5bUl9GIKODKOOiAycCn0fwh/z8sN7UZTVCdHUrN8yNd536DRSliisy
 a/1n4/GKra6nflV9AybrZqfLGPt/o/J0zjeElqeYSmExezZyWQN4omLneVWvdgTcgyxcZDHcNW
 93zdwlQREsuRZJ2N7ln8FUNEQOlZjPX/LjUAx7YjbzM1OcKxvASU3NEqJ75ohy4X6xDPti38HN
 1sKPyndYISIP9rZ2s303XEqX0QuuBxkz4wF3fz4muRqT7rsdO2SUNb8luPGtXE9K0kNj2ivZHd
 rHmKd1HzCtfkHFTYPy2iCAjV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:28:03 -0700
IronPort-SDR: G6s2xXhObs5KRlYJT6kxDXcY4pV0CMw/z6VNTNZV7biIzkGYiJrmv2iFB9HRJzC8tSmXr5eV9y
 koOvC9iLeeXchJg3XTDZrp7ygTeq6jbjxBmwD9mpUSjB7Ie4GeIeo3xsGPQzELj4r9pifvIQea
 sVuJGL83NIzlz+epvNUBeSiFq9MJxE2iRddsJgan/R/tgVn4sKhS8YiNxOIrduxbscbEJsdsAc
 n0kZ27YTUTEM/9V7Wo5aiahhQV7JXV6Ej+AE7FFjIz3wlnoVuuFchRSa/xFUxmImPDXDAYtACU
 z8A=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2022 01:56:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/4] btrfs: change the bg_reclaim_threshold valid region from 0 to 100
Date:   Tue, 29 Mar 2022 01:56:08 -0700
Message-Id: <aa24975c08590da46606fdce7473d05dad67e9fc.1648543951.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648543951.git.johannes.thumshirn@wdc.com>
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
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

From: Josef Bacik <josef@toxicpanda.com>

For the !zoned case we may want to set the threshold for reclaim to
something below 50%.  Change the acceptable threshold from 50-100 to
0-100.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 90da1ea0cae0..fdf9bf789528 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -746,7 +746,7 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (thresh != 0 && (thresh <= 50 || thresh > 100))
+	if (thresh < 0 || thresh > 100)
 		return -EINVAL;
 
 	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
-- 
2.35.1


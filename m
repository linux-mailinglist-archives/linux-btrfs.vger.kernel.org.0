Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825E7AA4FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 00:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjIUW1W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 18:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjIUW1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 18:27:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BFA75E9;
        Thu, 21 Sep 2023 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695319274; x=1726855274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eQQiV0hLP2bIUI2HNvk9Nzw46PQ60At884Epzu9W55k=;
  b=EuQMwKPKvtq0Rvjx3K0cVwlG7aqTXF8uUG9zIl6qyldK8WO1UviR+9T/
   Gg6u7dXJpK4hyfhniwIpuumNWXRY7SF9YO1YzM3T2s9FTsib470F802Ia
   VoZ8ustHM+3D3IWUieKzx4q53CzBLF7NGig+/sXWR+Z8ptmI+BAliP8aG
   zR4XhG+FfiS9kSTmIsGPHO7amgB9O+RkcXTkaOloMLkHmbBUHJ1bd/DC3
   7zvyxXNQwWGr2v3cvKSDnHP0X7Dr5MAe128CcWbwRcsUmoE8Ne6q9k8rN
   dohnFNo/nRUapOqoCZyT2YqlZ+sPV2xvQeZjGzybPEh2zSgl0aMOWovDk
   w==;
X-CSE-ConnectionGUID: aNR3e2T4RyiA4eNyNitEcg==
X-CSE-MsgGUID: b1o2Ub00R1W+DbkKqtfAWg==
X-IronPort-AV: E=Sophos;i="6.03,164,1694707200"; 
   d="scan'208";a="349818414"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 15:44:22 +0800
IronPort-SDR: rmX3pv5JVJeLO7OsSBKNSs8X0hzBohYiURcsv1i2zhopnvbQOP2WchVhoOG1YQhEwW4G5m8nXf
 2RX5c5aTApGJHREiKMjSYhc8Qw/Z22o6HcMAaE00DpOkGPIAcjFR6lKyQUELcFfF8knz9qqbOo
 C+vttE+ICkP//kuq1xw+77636dNfw4Phwt702jrQvVhCo6CzXRF64+1gepCt/AGYWmSweekKGl
 YS0MiCNut2bM4b4m4ZDXKf2EHj55MZ5YqttJtGohSqXXRSjwdOFjpzRAyPvbs86OYV8Wg2eJlN
 wHc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 23:56:56 -0700
IronPort-SDR: 7pyUaF3dziQcm4uxXflZtkNnfhw/oVlpBYCRq56ScH1Nf8uPocsQ5xgauM7+7X2PA/QRtGQLMP
 FyZwhVhH2AEWFPTeBtfx6YlbIQH/tW0/wYSIpvMr1/lgFZ0cOrwupx1Ft06ziluiHFJBdAzWD/
 HaYQjRDL0lp3T8qQe5HE+TsbSc0+p0IwBro33+OBdfz7eH/bWaaiNIGTnEkSefQpn7y+t6YFBL
 VKHSD7Rb/sTFt/h6VusIKU0y1zCZSwTbtJflT7Mi5ZsFdDGuc3FhFauQAQc4eErIoAJN0APVN7
 NE4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.94])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2023 00:44:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/2] btrfs/076: fix failure on device with small zone_append_max_bytes
Date:   Thu, 21 Sep 2023 16:44:06 +0900
Message-ID: <cover.1695282094.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running btrfs/072 on a zoned null_blk device fails with a mismatch of the
number of extents. That mismatch happens because the max size of extent is
limited by not only BTRFS_MAX_UNCOMPRESSED, but also zone_append_max_bytes
on the zoned mode.

Fix the issue by calculating the expected number of extents instead of
hard-coding it in the output file.

Also, use _fixed_by_kernel_commit to rewrite the fixing commit indication
in the comment.

- v3: Use 1024s instead of "<< 10"s to represents KB or MB
- v2: Only fixed the subject lines

Naohiro Aota (2):
  btrfs/076: support smaller extent size limit
  btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel
    commit

 tests/btrfs/076     | 29 ++++++++++++++++++++++++-----
 tests/btrfs/076.out |  3 +--
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.42.0


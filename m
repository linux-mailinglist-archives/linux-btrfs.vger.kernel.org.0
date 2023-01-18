Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1276715EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 09:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjARIPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjARIOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 03:14:43 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E447080
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674027913; x=1705563913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=15QL9/Gel/VI7FDi6mb7VrkSmCYPdDSlaxlFUQAWZFs=;
  b=cvP9n/kMb2ZF80cWobyz7m+UMxcWnRA2LntE+PKyjJNACnM55knLtr5Y
   sG9VHvbKLw7GwQXin/ttPzQY7K8HVmDD3bFMLXFmq8Dks+k8m/26+qQn2
   W5u7g1sHPX4qAK8xdr0btOpn2aRL5Kw2rrqGb9hzPi1+5bRKIk2Uc3fEm
   pfMl1PSY4kd8aZ9iQYH67mFm7M5LMI9UVeH54zkZJ1Q+BDslfmbO0acoK
   tqc1xTKzCEdjFhyrom1mejMtQAcvrx/ruNQByXB1tMf14AHjLh4/P7xrR
   6mtct+vypu1TECWAC3Z/dbvmDl3gh78CjHBfHmwdLiAP7TrgBtaeW4n/W
   w==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="333108002"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 15:45:12 +0800
IronPort-SDR: ETUL1wvj6bRPiIv1vroKBvlAJgt+nwC+sLrzEi8wUfdh1f7TOHe1zJ9AGarBDmLdQ2fBzwU+ol
 ZSPPgPWJUBaaoTceHNpErXUW89+ifv47D+aAsSGfIgejqBc7ubKzySwfnXJ96+Taqn0MTvE270
 pP7XuTLM8RhZWpa+CDkAUP41nCY7seJfOGLSudTbFng1UyJOIG69zNBqqkYi0yA+CyTAKNBXQD
 m+Wkc6sAEBdevqpTC/xlXxK2Mjyb5upyLVzpvrQ+IuRwCnjngY1tTT581iw71hevThLl5ikLuh
 WTA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 23:02:53 -0800
IronPort-SDR: 3gATM39wH6BJuk8Mhnq/rKAJbmUC5T/LnCPud82ApwSAFhDj+LWN9TU0ZuWRupCi9Am0hpyrR6
 8QYWNoNnCYpx4gpWD8f2YMdwvmOsaQRy8yQkGIylztI4WRg0iS7ISyz5wgxItrultaRABKgzmB
 xM1w3PC2z+wFXk/+VpnOEsft3/M6e/e0uklF4DNZ7dkPIAW97SIu5uzwt9kgA2oweq+0mdGIIi
 fL3jzgp0akeeXbqgIwxqkm+TDMI/Xs9siXrkMs6yAEQwRq91d4gkdEhWXKvxs8zTvZr5snflR3
 y7E=
WDCIronportException: Internal
Received: from f9rd9y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.16])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2023 23:45:12 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] btrfs-progs: docs: add entries to sysfs documentation
Date:   Wed, 18 Jan 2023 16:44:55 +0900
Message-Id: <20230118074458.2985005-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.1
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

This series adds a description for per-space_info bg_reclaim_threshold
and chunk_size. It also fixes a subtle typo.

Naohiro Aota (3):
  btrfs-progs: docs: add per-space_info bg_reclaim_threshold entry
  btrfs-progs: docs: fix nodesize typo
  btrfs-progs: docs: add chunk_size description

 Documentation/ch-sysfs.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.39.1


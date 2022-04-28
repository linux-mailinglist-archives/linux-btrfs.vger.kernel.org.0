Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D985137A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiD1PFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiD1PFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:05:39 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8BFB3C73
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651158144; x=1682694144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NhQODV6r/KSXKvNRFNGBtha6vpog8FEZb9Jk38IGCfI=;
  b=nCUy4vXr4Sgnd0Lt6uBx+P6GxUZLbeEZwUhRjLA0ck06OPphK7cqCmbV
   if92AEcfSDc8Q+RA5SShHnjrdFyq6C26MUV9pLrwvo5FcmKVJLqJxsxFK
   FAjQT7FK9dUx7W6HghUxlAFswvlvXcZeC68HSm7YIafLBJxM9D/Bsrd9r
   cdmObIdHC11jlYq147SPr5INETD4FVY4XMXHR6aJ8mIxgZ/ygHqvWltFj
   2b9Pv8YfTgRMs5bXFY4VJVGE0xwsEOs8VMzDfYfDRaUUtrhpXzVn1NbMG
   DrH90kFkuJoHP5ZoTPtM0h35RoQmZCvoCo7eHg943/TfcVINkykylhJ51
   A==;
X-IronPort-AV: E=Sophos;i="5.91,295,1647273600"; 
   d="scan'208";a="303279890"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 23:02:23 +0800
IronPort-SDR: 7Vgt3Guszd+FMd1E363fEAwuZAf72zMIekoROiu+JpWW7e85TnxR4pQbT5av/wr91VXM8KIcyl
 MGiQrcSWct3NgzheTqZy+w18lcmPK7LM92Rk0F0O/W4AGy7KHgp/pb/vIsxoPSr2vC54Jrxa55
 A04Jxn0ENsAlvdUL9rNvztBv+qriE5T54GZ6s+DGnooEQ+86QeZDxPI0wCZnXi8uxjFLqOpNjX
 A+GM6BOchvGnGuhIMbUkwWxw8RF+i2R/YGlzoMDM3PEDYwkSzmzry4VbvQ79k8iQUV372sCv5S
 qyIzNz4kL7WKq5pqEIW/s3l9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 07:32:31 -0700
IronPort-SDR: aOwfA1otNiZrmGfC2xucwsC2C1JoO70mOjts0Vpacr9oB8fL8anH882cJKeDqUxTKSn9Jljxq7
 xrwgtzXQHEJgx5lW3Bl1WfrwUT07VgYrvdmk2pFgw2gAKjxBw79Q4qNqALxOzH+D1WBcmyw1KY
 lZYs1nD1KzQ5r6FgMHSZ4WhpcpRM/c1Apd752D7Rs6Dz7Jn2/uYlKKtKICn9V/nfxoqOrv+g0l
 PP0CCqzAXL1eO0pgBsAwLitM1g8RgoCcGmkZ46OxezB5OMjtQDtEgt7/EuNscA239Z++Lh/1JF
 iB0=
WDCIronportException: Internal
Received: from fd6v5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Apr 2022 08:02:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/4] btrfs: zoned: fixes for zone finishing
Date:   Fri, 29 Apr 2022 00:02:14 +0900
Message-Id: <cover.1651157034.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
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

Commit be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
introduced zone finishing a block group when the IO reaches at the end of
the block group. However, since the zone capacity may not aligned to 16KB
(node size), we can leave an un-allocatable space at the end of a block
group. Also, it turned out that metadata zone finishing never works
actually.

This series addresses these issues by rewriting metadata zone finishing
code to use a workqueue to process the finishing work.

Patch 1 is a clean-up patch to consolidate zone finishing function for
better maintainability.

Patch 2 changes the left region calculation so that it finishes a block
group when there is no more space left for allocation.

Patch 3 fixes metadata block group finishing which is not actually working.

Patch 4 implements zone finishing of an unused block group and fixes active
block group accounting. This patch is a bit unrelated to other ones. But,
the patch is tested with the previous patches applied, so let me go with
the same series.

Naohiro Aota (4):
  btrfs: zoned: consolidate zone finish function
  btrfs: zoned: finish BG when there are no more allocatable bytes left
  btrfs: zoned: properly finish block group on metadata write
  btrfs: zoned: zone finish unused block group

 fs/btrfs/block-group.c |   8 ++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/extent_io.c   |   6 +-
 fs/btrfs/extent_io.h   |   1 -
 fs/btrfs/zoned.c       | 163 +++++++++++++++++++++++------------------
 fs/btrfs/zoned.h       |   5 ++
 6 files changed, 109 insertions(+), 76 deletions(-)

-- 
2.35.1


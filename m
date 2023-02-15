Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D9697E5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBOObW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOObV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:31:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42738EA7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471472; x=1708007472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sAWmo8XzQ8jy9MWZf4Wt1fs1PscM4SDTZKeKheT/9cw=;
  b=Y3RnpR0dPK/XOeXOYwNsb+/ypiV1xusolkeUmZ3CzlYaQyj8TLzA0kt5
   FPnc82KiQ0kakJ0bLbgMgLuUinHexiNrwFPBFhIgbNWFPjwpxp7NVpQUA
   aMPGnXZ729TBtF47syGXHwi0yMLhhCF3L4RA1vqaOlxG02ScdtLysVkt1
   tp9o/cT6KvIqwjOpv7TpTRzqXCvkNPV9b14FWcFwPcIk5mrQUon2ncaRh
   kXL7iyrf00rhjRwSrkkRUX1gip1dIpMui9V/r/Wguw9ID3eTHr3Zp4dmz
   /Xw7asP80b45TuF5GkSMo5X/PpAcQt5MMtpMbzx3bMwc+LrKk2MHvH203
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223393907"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:31:12 +0800
IronPort-SDR: 5mT4slHNiJwSeun6CRMsHwgxy3HIn2tPlFf7O7zXLRpzItwVs5o9fgtXoBuCRUAQQ+fDjYNkq0
 olMeAAWZheVsZNUuEk5d+EpH/rXzXDbrvhloy+wS4MoB7Ff1TWQcHRU8GR4rqs/2oRmTN5KN8J
 bfJFmPgtfaz64/56Q1/ooLVdB74JT8HIl318Y8Vd2AVfMUXw5I93sJ3EajMFR28qYx5hxpOgYD
 jCvRMi/yV+H3olKpbxwpwLgRC5+j1DeTuHCBYTWJrxcnv0HonRZZWxqwLAL9HTz0UYTNXbs9Q1
 aCI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:48:18 -0800
IronPort-SDR: PVwCl4K0DrjOW63rTG7sMAkJDE5qreDSoDPXXLqqfLPWI3fdFziALkllFDyEEbDMPvZHC3gFEt
 +IiU2bUQFmVBDVBRe8PX+HXTkOQvkucWItSyFrThOvNWruhW+MhWLXtghhvstxYF/anrkOOJCB
 uw5aURWacGYdZ7CJmeTHTw8WLwTNcu353BKmWZib/jGQ8wLgKgnAefMQkz5Fib4aX31oUR2ok0
 /i6u3iSZYaF2WxRlR7D2s7euhfQ/cnJXwR3R7ItHo2k6joPgq8qoeY+ChfUzeGTLozzX286H50
 ywQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:31:12 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/6] btrfs-progs: add support for RAID stripe tree
Date:   Wed, 15 Feb 2023 06:31:03 -0800
Message-Id: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
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

This series adds support for the RAID stripe tree to btrfs-progs.

RST is hidden behind the --enable-experimental config option.

This series survived 'make test' with and without experimental enabled.

The kernel side (v6) of the patches can be found here:

https://lore.kernel.org/linux-btrfs/cover.1676470614.git.johannes.thumshirn@wdc.com

Johannes Thumshirn (6):
  btrfs-progs: add raid-stripe-tree definitions
  btrfs-progs: read fs with stripe tree from disk
  btrfs-progs: add dump tree support for the raid stripe tree
  btrfs-progs: read stripe tree when mapping blocks
  btrfs-progs: load zone info for all zoned devices
  btrfs-progs: allow zoned RAID

 cmds/inspect-dump-tree.c   |   5 ++
 common/fsfeatures.c        |   8 +++
 kernel-shared/ctree.h      |  51 +++++++++++++++-
 kernel-shared/disk-io.c    |  32 +++++++++-
 kernel-shared/print-tree.c |  24 ++++++++
 kernel-shared/volumes.c    | 116 ++++++++++++++++++++++++++++++++++++-
 kernel-shared/zoned.c      |  35 ++++++++++-
 kernel-shared/zoned.h      |   4 +-
 mkfs/main.c                |  86 +++++++++++++++++++++++++--
 9 files changed, 347 insertions(+), 14 deletions(-)

-- 
2.39.0


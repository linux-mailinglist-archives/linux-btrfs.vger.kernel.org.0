Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7BA4E3B7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiCVJNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiCVJNI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 05:13:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3E7E58A
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647940301; x=1679476301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XeVsplFDWv8mxZHbsdDabkwor9KSg7eI3ewOnag3FZ8=;
  b=dAf6bhsDApp+oVinmo5IdjoD3EP/OpYYGokSBK7p4zi5132s9B56Ic5b
   RwWTWpf4yuUPLArfCRkGTAnvta0GaOmO8oRDtu69uiB32DankJkIYu1n0
   pX+DJPVo/R8l2kTM17N/mSOfwLiceZe55cpwIjtWU7k0ErcWJh6qENV7I
   o1hLkxI9e7noFqvFSAtkOvrS7bPnCsXhDCbWVqzcxVoloM/v7gR5qK2am
   OctgBqin3KeqCrIagnhcv9HB96TK0lUbqHta4z2X2cE3vxOsvvfUoIpHW
   qdKYyuKecmFHf68QSW6qmq25sUKxBKWZS7HEW2ZQaIZ3e6l08oLqieJ0o
   w==;
X-IronPort-AV: E=Sophos;i="5.90,201,1643644800"; 
   d="scan'208";a="300094307"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 17:11:40 +0800
IronPort-SDR: bSc30HTChTbsKujQ20gsvq2wPAKrsAMQbU647ej2de0kXnVXi3QGFlr+glCYt1433DhRw9+nd/
 0bWPlrXsdCp8K0U0rw51aBbJkDD/44/hboQM1SgDhinjcNhmaKAIlerRXiXDNKnx+G9T/A662m
 YjfQWSe5COtKXrn7wjjXkGakn3jBHvtjIerKt4gwm+phX2w1RFR78wVmORi3P7vMfZ7krrB8Zc
 vWUz1wufKHl7yTv+xOVILOBrn9u7VNpXsuieEV1nDcSKpgvvR0QO5LSzAvqq0VnWYeKShFCrR0
 vdxtcBgxCRlUNW3QvXG5BcFd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:43:35 -0700
IronPort-SDR: KQ+AEQiqxSA+7q+t1nFU299svpSQlMEI01deHfj2HGztWzCUCGQwc6NutKA9DzofnGjm/paneX
 TDo9T35t1C048LHNAZYhkPotNC9xrbdD2TfS0v0lnIaHlUsaU+21k4EBnNH+C8xbnRT+5a4ENA
 wC1o5eRCnusamGV7ukehHhTN8QDoOvPExvS2E88Sz7SUxuRPc3faMei4ShbQD8QEiTfVS8xbfl
 QcrNNkgiTE2s6Q+kyd/AZkn5rgJDW6U4eHazCwfT76htsmTFAy1XkPx3bHWR/FmJ1pUio//Hmz
 BjU=
WDCIronportException: Internal
Received: from cqpt8y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.186])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Mar 2022 02:11:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: activate new BG only from extent allocation context
Date:   Tue, 22 Mar 2022 18:11:32 +0900
Message-Id: <cover.1647936783.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
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

In btrfs_make_block_group(), we activate the allocated block group,
expecting that the block group is soon used for the extent allocation.

With a lot of IOs, btrfs_async_reclaim_data_space() tries to prepare
for them by pre-allocating data block groups. That preallocation can
consume all the active zone counting. It is OK if they are soon
written and filled. However, that's not the case. As a result, an
allocation of non-data block groups fails due to the lack of an active
zone resource.

This series fixes the issue by activating a new block group only when
it's called from find_free_extent(). This series introduces
CHUNK_ALLOC_FORCE_FOR_EXTENT in btrfs_chunk_alloc_enum to distinguish
the context.

--
Changes
- v2
  - Fix a flipped condition

Naohiro Aota (2):
  btrfs: return allocated block group from do_chunk_alloc()
  btrfs: zoned: activate block group only for extent allocation

 fs/btrfs/block-group.c | 36 +++++++++++++++++++++++++++---------
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.35.1


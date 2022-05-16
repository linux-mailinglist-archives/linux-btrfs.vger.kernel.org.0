Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766952871B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiEPObu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiEPObs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5431D30A
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711507; x=1684247507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p/C7S6PXeFY4ea+MYyGR78Tw/dMEewPXRz6m5ogMQWA=;
  b=cRmbvHrr+A2aE4uMUfk/x/ZlyW8scqMoZ4KrwUlDY9hCsXK08czLHVdL
   gHSYQGhJUSIQWZ5ERVuJeIK1880QclDOviw5HpOxwrrILzf0fgZOqLeVy
   /zzjAW8d9MwPsYI/VoBNMfTrUJ9d3b05mtNhAkfhWinPufd23WbKGah9V
   /0sSMZo0u6hi8KAB3SUcxJVqqhLanQ7XyVcD+3RjzIqgqpQZ1kS/9hB8f
   cHZ6d3+RDZZT6mc146vf7B3anKX2fHtnHDcdTNUw7myExUGwYvD9RTjZX
   cnyoMcuq7QelPmzq7J8GWpKlslbXFrQMNgN9g3sLIeHnjp4HswwPI47do
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309207"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:46 +0800
IronPort-SDR: yCDbVrIceeTy6hkw7lyNKN8EIhQQbgECAa8RYD+ocwIcpNv1gwhoFBgniYnSQpDbqPenuJjcis
 dUlonRr9c2ygj+AmqondfnJAKnAgymCOCmUfusr4AT0ZGSW5S/8xLj8kx3t2w+99V0OeRRU8Xv
 /KuC2bOh28GeU2wQQFJxcYJAb6gMD76n3iLPJO8FZFbzzSMjQDh3Gs5b4dr9rjmj2Fokzv8VNm
 /fqe3qXRR3wcUtVE1NY91Gbl+5dQThtiN4k1Kkf5nCnvL8teebcJI3qJk23o5P4o8tY845B0pc
 tLt5+w1DFBQNElxNqJO6VAKL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:28 -0700
IronPort-SDR: tH7rWhsOgsx3l/QToF9snN+nBT2KbSGLALOYCpsr/1k5oHuEXWQABb7dVlg32JSKqHtPfSSzD9
 BV47TeHoAv3ZGD4Xuipibr1k4bAeQmSQFpPerV0q0SPIuIxjOQzzfO45odN23EKkKq0QEanqNf
 9mpq1u1sVs3KjPlugRjwqqBH5k1O1jumwH4U9dGWucOiO3TugWV107agn409BhgVyiiU4PtRDd
 41CEhRWHMyFFFEHpg7wI6D1tLfcBN+DAz4Tinz+tPyZIQNuWsMUyLYh9AeSHeWbja0DdC0V8DJ
 FlM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:46 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Date:   Mon, 16 May 2022 07:31:35 -0700
Message-Id: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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

Introduce a raid-stripe-tree to record writes in a RAID environment.

In essence this adds another address translation layer between the logical
and the physical addresses in btrfs and is designed to close two gaps. The
first is the ominous RAID-write-hole we suffer from with RAID5/6 and the
second one is the inability of doing RAID with zoned block devices due to the
constraints we have with REQ_OP_ZONE_APPEND writes.

Thsi is an RFC/PoC only which just shows how the code will look like for a
zoned RAID1. Its sole purpose is to facilitate design reviews and is not
intended to be merged yet. Or if merged to be used on an actual file-system.

Johannes Thumshirn (8):
  btrfs: add raid stripe tree definitions
  btrfs: move btrfs_io_context to volumes.h
  btrfs: read raid-stripe-tree from disk
  btrfs: add boilerplate code to insert raid extent
  btrfs: add code to delete raid extent
  btrfs: add code to read raid extent
  btrfs: zoned: allow zoned RAID1
  btrfs: add raid stripe tree pretty printer

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/ctree.c                |   1 +
 fs/btrfs/ctree.h                |  29 ++++
 fs/btrfs/disk-io.c              |  12 ++
 fs/btrfs/extent-tree.c          |   9 ++
 fs/btrfs/file.c                 |   1 -
 fs/btrfs/print-tree.c           |  21 +++
 fs/btrfs/raid-stripe-tree.c     | 251 ++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h     |  39 +++++
 fs/btrfs/volumes.c              |  44 +++++-
 fs/btrfs/volumes.h              |  93 ++++++------
 fs/btrfs/zoned.c                |  39 +++++
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  17 +++
 14 files changed, 509 insertions(+), 50 deletions(-)
 create mode 100644 fs/btrfs/raid-stripe-tree.c
 create mode 100644 fs/btrfs/raid-stripe-tree.h

-- 
2.35.1


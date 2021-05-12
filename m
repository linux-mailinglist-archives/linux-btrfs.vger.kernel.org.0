Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E365537BF25
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhELODI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 10:03:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27791 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhELODC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620828113; x=1652364113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k/kLcCUB5ZDf0p5Q453D9L6cLmuv5WPBkRCPza/suyk=;
  b=gESHGX20btOy1zKHeSnZE0p2loQrrw/cUPMWqWyx7JM+gB4m9jgBDnc1
   zaGbJJLKTuP+wpyayjP45SwI5ecWUtsOcSA4ZQznzbAzYUqTTZfVpHZG5
   KQd/vdrNunKNBTeCNapySeD+0TgC9dFppYfld6+jVF5ZEWKwT7VRBDqq8
   IbeHqEWET7//xTpCpLxHwnAig3dnkZuwPfp3BxSKyi3Mh3fEpS5wNL6sR
   BgUBBxFSjH9+BZev+PqpKKfjE8gPOFeWI3Z51hzohTAflkP+GRIoJfyDl
   1LhiX0F5K+IETkmu1r/Oz+gxwMBxL06qvJrkxKI7MkIZffNs9QTgxZZHn
   Q==;
IronPort-SDR: 8wUkQp249MD673SZpL62yzmjcJmycvZF7re4Nr3y6MxM45hMGKBJR0BJL7mKQbDi3QXJ5ACCtf
 dO9ok8OBesMrwmLM3kgb+koIxgI01XQZpU9aEDrV6gj6UJhiuEvHqOasbCZMCBh1amskezSNZC
 U0n7/sXOXWcfnPvtk8QkgBPzlurJGoukU6MxOysla+3jdR96NTghYwdUgHAXhVbOAQaK9tpKkh
 gzjDh9AQx2O6cWfU2Zz8JkjZVbjjsuOlVSM74eYTXnHhtEb2O69fyIyhpKAhzHAnb2+UCF5l8A
 DbU=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="167902771"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 22:01:50 +0800
IronPort-SDR: DrsHohqqzJhTc/hmwfbGn3IVg7gxwFfBE0JJsR26r3youMd+eBiBX59mpUxdqHiIPenMCt2Z+N
 N0dlT7JV9jM2njL10DKur2SGe92tCQDffMkiAXBgLusCg0WvOakMNEga5xjLICpu2kWfkdaW6m
 p6UcouqMQy930jwRH25PrKTYuJbb7zUt7Xv6J8m8bF+yJPLMeCbzyk+nW+GD4xKu4U+UT3PNW0
 U5MjOeN/qoXXZxX44Ajf+0GQWVyi4fWPyYkuLZKN/S1e/cQzGjcGs7vuyY1AyY9Ih0zn5vQMdo
 hurJ+Petjw90SCFZQk+lu18N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:40:25 -0700
IronPort-SDR: XWg/V5WEeETV0fnGuP+F1PYo7p3RVwaA6zwMJ1Cz5aAlGiwqJn26p4Tbwv58fRroCdGaReNN8t
 zFHTko+SstHlL+LYAHTrWCqJb2b8gjU/VjiMaTcTNYKPwJJ43P+4a2+etft/2+VDES/G6fo4Ql
 yA8CbPuhk6kpAiVGVydFyh15hmBZ4EtKqtxWhSeapVqxeNAl+XO48M/V3UukAAYGsLyc8+L9G5
 iNPZMjQ8EfgW4V79PTpIvGlDmwnebAuDML3lHpphSOBWzuQJlYQuyKdUU8T4fttfySs9kk5DIP
 nLM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 May 2021 07:01:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: zoned: fix writes on a compressed zoned filesystem
Date:   Wed, 12 May 2021 23:01:38 +0900
Message-Id: <cover.1620824721.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David reported that I/O errors get thrown on a zoned filesystem with
compression enabled.

This happens because we're using regular writes instead of zoned append, but
with regular writes and increased parallelism, we cannot guarantee the data
placement requirements can be met.

This series switches the compressed I/O submission path to zone append writing
on a zoned filesystem.

Johannes Thumshirn (2):
  btrfs: zoned: pass start block to btrfs_use_zone_append
  btrfs: zoned: fix compressed writes

 fs/btrfs/compression.c | 44 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/zoned.c       |  4 ++--
 fs/btrfs/zoned.h       |  5 ++---
 5 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.31.1


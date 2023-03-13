Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54906B6FD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 08:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCMHGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 03:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMHGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 03:06:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C314DE15
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678691183; x=1710227183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UAi/NV/xW5zT8KwPjX2iJWZ+2OuSi+O0cg7t7vQ4CPs=;
  b=cKqD7mQ3pEDZhpmUUjQl1JLwZI8EAWOZPs8OqO2y4cnXwnaEE2QOMEKz
   zWO0x1brQzZjlNpBJe7QAVc75a7cjM5LG2RLAXSxcdmhSXX9vZI9IqWLx
   OUW4FDx0A4Ju7ENzTJJACoNPj9pEzZsAyve15mY2CBXR6yJwS9IZSJxfa
   9UJNf8UiAL7/vyUMEDszkMXIy2gzFtAG6HW425NExtTkZ0GsEpoVtJYmi
   slKIhJsbD2ADABoRTh+IXs+XM2/PGEqPlAmqnO1lMcA1mOHn6SZVRS8mA
   R5Hp//O6/z+iAggsvQnsxhiemmXFN/ZlycQIHlxMPpTZ9L5O4Fr45wcWi
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673884800"; 
   d="scan'208";a="230433377"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 15:06:22 +0800
IronPort-SDR: 3ph0qrggs+5GeUPmpspUJZhT2a9IjsMFBDJm0spBz3ET9e1fUuskgiEwSoru5qjAfFh7PvIZYy
 gCUDor3S5K95fOqz1sjsPGdT7WaX9wi+Y5Bwms41NVRIjaE7R9zBgonmjlaYodkqQi3PLZHIS8
 E5Hxkt+lZ/YGgNF3Jc97ThG5HBN7C2KGWocCeeaRHtHOanNKxXhB+FN2u3XwVtASlZy8WRcs2F
 lfSkOahalZ73NqVOxAFtlpAS28t9uuhoOkryMEx4Onmr07mETvbw+680BV1phUGYtNpitLJ1sM
 F5Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 23:22:51 -0700
IronPort-SDR: FWAxaxuGLPMn5a0ha4UUyLjGLZyV6mYzxGl+AXeUmG/RM7C1DpeZfMlniujh8TyJsb8JaiXMtq
 PQJ5hyKA42q0eGiW9iF1vPtM4wXf2l1Vhbej5OhM2ZuLGQJxMfR0+qQus51A4G8Q0rkN/JcJxo
 DmQAdjuft2LDkpZ2slODo2GYXkvWSrHZqumKhiC29HOWOGYsOM7ltjkr9vnsQjoQnjpoUqSTl9
 pKQbG0zkKYMvi3GClWYO8LR9k/uJBD/9aF1bygwIhnnFNhFFc4p5x/68ZWqI9mIY95lEO+axMi
 ZJY=
WDCIronportException: Internal
Received: from 5cg2075dxm.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.82])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Mar 2023 00:06:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: replace active_total_bytes counter
Date:   Mon, 13 Mar 2023 16:06:12 +0900
Message-Id: <cover.1678689012.git.naohiro.aota@wdc.com>
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

This series depends on clean up part (patches 1 and 2) of Josef's series.

https://lore.kernel.org/linux-btrfs/cover.1677705092.git.josef@toxicpanda.com/

The naming of space_info->active_total_bytes is misleading. It counts not
only active block groups but also full ones which are previously active but
now inactive. That confusion results in a bug not counting the full BGs
into active_total_bytes on mount time.

Instead, we can count the whole region of a newly allocated block group as
zone_unusable. Then, once that block group is activated, release [0
.. zone_capcity] from the zone_unusable counters. With this, we can
eliminate the confusing ->active_total_bytes and the code will be common
among regular and the zoned mode.

Naohiro Aota (2):
  btrfs: zoned: count fresh BG region as zone unusable
  btrfs: zoned: drop space_info->active_total_bytes

 fs/btrfs/block-group.c      |  6 ------
 fs/btrfs/free-space-cache.c |  8 +++++++-
 fs/btrfs/space-info.c       | 40 +++++++++----------------------------
 fs/btrfs/space-info.h       |  2 --
 fs/btrfs/zoned.c            | 27 +++++++++++++++++--------
 5 files changed, 35 insertions(+), 48 deletions(-)

-- 
2.39.2


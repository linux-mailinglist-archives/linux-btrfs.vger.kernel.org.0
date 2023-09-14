Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC27A0A3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbjINQFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbjINQFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13E1BE1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707543; x=1726243543;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sy6gTCHP4zEbMhOZeNjPkO1NKR1Mb3pqodW67kZsR3Y=;
  b=ZZqeFJBmgazPIrh1blR7ykE+/WsxUr06OENOg5oRayXnlboU5yk6Qq1s
   hGqpTUCnpLh1wKD7EB5SSayC84eSHviFqkekfA0utkLe0/bOcHHS0KYaj
   7ERCwz9VTMj64UWuvYPjrHqrZ/PFyUa6O2+crslRWVlRWIUA1SyFhSpAb
   icnEt6488c7raNOii0oe4DONN0/0u5zXOwbzexUcV5h+7ucqUz0+WCWiy
   t9jpKD0CooL3z/H4G070ekx3aPJZvwHJhM8y1kg/nm4u1C0ctmKJ5Z76j
   YUhKXcT66AxFodqLeZab1eXFTvu9l2/VGxaAOWT61B6HC5NArdVFtmUrg
   Q==;
X-CSE-ConnectionGUID: WqBZK0qxQaSHblZ7u8bwpg==
X-CSE-MsgGUID: y83NVcJJSGOGHITX17bEeQ==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196078"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:42 +0800
IronPort-SDR: 5DF974X8qm4NSHLuFE5ACadnrLwg/g0OP5y0raZP4AFOc7iwcdXTUBv+p1OImw2QULlDpMS8Uh
 x5mLEM+2DHwckTCf6yfndlpdBTIlNmMiJ0gCcal69kI4vBAVet6ewZgE7PIER2aLyZ2fERh8LJ
 6O4rCO9D0yXD8bCk8LGXg2sq20k9DmuNirxydKD/jaPjZdzFcpxHkwbd2keYIuyUKv5u0WxK9c
 IkQ5h1YhXDJCLLACJToJeRyD4BGAocWCE3/x8tSjL7lKppm8vU2ew/Zx3HX6w8D7521nXIn1QY
 XSU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:24 -0700
IronPort-SDR: +mN3OTguBjLVC4cscjAZD3x7OadM7uW7kpQnuDDCdyFBjFHJtDfG1poVsAKnJCLCuggONFIugm
 5T4B/1iEGhJpxxHvKZyO0zJQD1IjiJtdKUabR/QWba1+5qet1fl+7HMM3JKu+/3E6emkPjjC+I
 KuE2GNamSWyl0Th43VwFzts9IfnSy9xI24eEGaga8KzPgBDoSptriL8hmd2F1sOPPBl/Ul1dGI
 AYnlY6nh5yFumL5lnnSDEKT0tFsjZZO5brYX30m4W67srRNukDfV5Xqi/lNDJsM1oK85s//g4D
 LOM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/6] btrfs-progs: add support for RAID stripe tree
Date:   Thu, 14 Sep 2023 09:05:31 -0700
Message-Id: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsvA2UC/2WNyw6CMBAAf4X07JqWlqKe/A/DoY9FNlEgW4Iaw
 r9b8OhxJpnMIhIyYRKXYhGMMyUa+gzmUIjQuf6OQDGzKGWppVUa2FGENDGNCBMjgvXWuGgrFaQ
 TOfMuIXh2fei2MOKMj82PjC2999WtydxRmgb+7OdZb/Y3OSv1P5kVSAgnreu2Nsb46vqK4RiGp
 2jWdf0CvR6fG8YAAAA=
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=1590;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=sy6gTCHP4zEbMhOZeNjPkO1NKR1Mb3pqodW67kZsR3Y=;
 b=eqPvSTucsqQX31VssJDNOak4GXPSkqrKETElda6A/YOOz0II2uoVfk5TJGrwYlW0mYbD4zdzH
 w9h6SeBEamFCBXNMYKORT6cnRdxLu+PrYej+kNFsXVhALGorl+5bcG9
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds support for the RAID stripe tree to btrfs-progs.

RST is hidden behind the --enable-experimental config option.

This series survived 'make test' with and without experimental enabled.

---
Changes in v4:
- Adopt to on-disk format changes
- Link to v3: https://lore.kernel.org/r/20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com

---
Johannes Thumshirn (6):
      btrfs-progs: add raid-stripe-tree definitions
      btrfs-progs: read fs with stripe tree from disk
      btrfs-progs: add dump tree support for the raid stripe tree
      btrfs-progs: allow zoned RAID
      btrfs-progs: load zone info for all zoned devices
      btrfs-progs: read stripe tree when mapping blocks

 cmds/inspect-dump-tree.c        |   5 ++
 common/fsfeatures.c             |   8 +++
 kernel-shared/accessors.h       |  37 +++++++++++++
 kernel-shared/ctree.h           |   9 +++-
 kernel-shared/disk-io.c         |  28 +++++++++-
 kernel-shared/print-tree.c      |  53 ++++++++++++++++++
 kernel-shared/uapi/btrfs.h      |   1 +
 kernel-shared/uapi/btrfs_tree.h |  29 ++++++++++
 kernel-shared/volumes.c         | 116 ++++++++++++++++++++++++++++++++++++++--
 kernel-shared/zoned.c           |  34 ++++++++++--
 kernel-shared/zoned.h           |   4 +-
 mkfs/main.c                     |  83 ++++++++++++++++++++++++++--
 12 files changed, 393 insertions(+), 14 deletions(-)
---
base-commit: aa49b7cfbbe55f9f7fd7f240bdaf960f722f0148
change-id: 20230613-raid-stripe-tree-6b64ad651c0a

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


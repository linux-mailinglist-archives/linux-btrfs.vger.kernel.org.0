Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCEF772A36
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjHGQMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjHGQMr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E036107
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424766; x=1722960766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rY5U1YMQPCkZwvbe5eNzbtvIeM2NhLVP/zfhCVuZQhI=;
  b=GyVJcfTrNtBpHoiMnHtvha5ms7ml6rQJtKm1GU9jCTbPLJqahhxk+WWb
   UR9TylilpOa/LiNvmZxpH7jNXjX75wKVV7K46jNbxGQA8apEEkoFfXG1d
   TCB4cxOR6lJDdBQlomC+fYSMJg7BqlHqDt0oegYY9KNhFsnfqAlcyBHXx
   QchEskCui0QLt28p25C/npSGHrun8ixK/P+hbizwvX8TLBoefSfusTNyE
   Xj7hq3Ko4zIeGZ0o7mCxaf0zvFt3IOg/v09rxKTKHaeKcVLdkpFmq6tHY
   EF+hdVyzEyGEsUoES61jPA/5Rn6JQ5VlqgLor83bV9Lm/WLnhtw4tKRnv
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710981"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:45 +0800
IronPort-SDR: 8A15u4A7TcYFCH7BNojb6Z76dOhe7UbGzIB/Orm0/iqigkHgc7PWDTEi4yWa7quXLUOdYxmKrU
 Zodu8hhq+0TdHdP2TMEBxcI5HQyVDTmtlYOH0n4BKDK4FooW6XGX+NcgjGZ9UKI0Zjv4F8FmUQ
 994R+3hDGGM1ZuvZE/b7De0MAZ7Jn7tK8AgmCRYZNAhpRkzpjursn7mEJSUCFlAumeSMAtQ/ed
 6uPLKfW9/gDPKEaoQvwXzlsUX0GEwHstlkdwS/bzRnSnWY21oO6Gu1udUOjiv9sgN45MAYLCrs
 awQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:13 -0700
IronPort-SDR: FjruVsC26Hxcdzh9gu53gWcGumGowpisdAInJ8y1dZfF5msOA+H9tpvLaki7Mlx2Zio6z0nW87
 MpNEuYRei9kY3Tg0P2VrGUe/Dgtan8Pw7fXr2HkB+CIHcsUs/rp4d5tPRM7Pyk1eV1fLzHsSx2
 VeBTqNvOxuhrZ1M7fo0j4quiGcKUS7oH03KuU9OtgH2yB0PEsKzN6oK3An47wBDMYKC6M6LOTN
 +fQEbrFpt/nMQIGypFZ2ekEcbhDhc14vE+j0UbeDOzSiEkGAZOxsvQpig8C3SL0KZWi1fDLJA+
 m2A=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:45 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata block group
Date:   Tue,  8 Aug 2023 01:12:30 +0900
Message-ID: <cover.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the current implementation, block groups are activated at
reservation time to ensure that all reserved bytes can be written to
an active metadata block group. However, this approach has proven to
be less efficient, as it activates block groups more frequently than
necessary, putting pressure on the active zone resource and leading to
potential issues such as early ENOSPC or hung_task.

Another drawback of the current method is that it hampers metadata
over-commit, and necessitates additional flush operations and block
group allocations, resulting in decreased overall performance.

Actually, we don't need so many active metadata block groups because
there is only one sequential metadata write stream.

So, this series introduces a write-time activation of metadata and
system block group. This involves reserving at least one active block
group specifically for a metadata and system block group. When the
write goes into a new block group, it should have allocated all the
regions in the current active block group. So, we can wait for IOs to
fill the space, and then switch to a new block group.

Switching to the write-time activation solves the above issue and will
lead to better performance.

* Performance

There is a significant difference with a workload (buffered write without
sync) because we re-enable metadata over-commit.

before the patch:  741.00 MB/sec
after the patch:  1430.27 MB/sec (+ 93%)

* Organization

Patches 1-5 are preparation patches involves meta_write_pointer check.

Patches 6 and 7 are the main part of this series, implementing the
write-time activation.

Patches 8-10 addresses code for reserve time activation: counting fresh
block group as zone_unusable, activating a block group on allocation,
and disabling metadata over-commit.

* Changes

- v3
  - Rework the reservation patch to fix the over-reservation problem
    https://lore.kernel.org/all/xpb5wdmxx5wops26ihulo73oluc64dt4zpxqc7cirp2wvxl3qy@hv7lsvma5hxf/
  - Rename btrfs_eb_write_context's block_group to zoned_bg.
    
- v2
  - Introduce a struct to consolidate extent buffer write context
    (btrfs_eb_write_context)
  - Change return type of btrfs_check_meta_write_pointer to int
  - Calculate the reservation count only when it sees DUP BG
  - Drop unnecessary BG lock

Naohiro Aota (10):
  btrfs: introduce struct to consolidate extent buffer write context
  btrfs: zoned: introduce block group context to btrfs_eb_write_context
  btrfs: zoned: return int from btrfs_check_meta_write_pointer
  btrfs: zoned: defer advancing meta_write_pointer
  btrfs: zoned: update meta_write_pointer on zone finish
  btrfs: zoned: reserve zones for an active metadata/system block group
  btrfs: zoned: activate metadata block group on write time
  btrfs: zoned: no longer count fresh BG region as zone unusable
  btrfs: zoned: don't activate non-DATA BG on allocation
  btrfs: zoned: re-enable metadata over-commit for zoned mode

 fs/btrfs/block-group.c      |  13 +-
 fs/btrfs/disk-io.c          |   2 +
 fs/btrfs/extent-tree.c      |   8 +-
 fs/btrfs/extent_io.c        |  44 +++---
 fs/btrfs/extent_io.h        |   7 +
 fs/btrfs/free-space-cache.c |   8 +-
 fs/btrfs/fs.h               |   3 +
 fs/btrfs/space-info.c       |  34 +----
 fs/btrfs/zoned.c            | 259 ++++++++++++++++++++++++++++--------
 fs/btrfs/zoned.h            |  29 ++--
 10 files changed, 273 insertions(+), 134 deletions(-)

-- 
2.41.0


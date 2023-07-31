Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A39769F40
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjGaRTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjGaRT1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:19:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087335AB
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823894; x=1722359894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dv/fTzjEn7+LuzxW4VlxIXNnYv3j43/LlIR7XFnzaj8=;
  b=ZFPSGTLT42WNxw+y7xGtkob/ihkN0pVp1rwYiV0SXhiHHoDQ3SvOHsS7
   N/aYXhrJkwdWvfQm2dAyCHGSD+vNvYhyj/0MmkxZmo4sWH3XtRHJVf1Bo
   YNG8/kCpc5XDXuvZQwlnFiiO6snyypGL+oE8J8tezNpo7fYOipK7ucR6+
   4ux4VmOpBokFYRq5sNC77VbsL8TwVGGCzImfdQWZRrWbX4B3tJu3dVlDu
   U4zMcSp6LESSo+qrVD+TH71kv/eyYejlsBP87a7tTpoEmZTdJnPBGCuCJ
   qZb1CaaYP2UkZqaWaYT9lFA/xRFtvLq/o1ITgfUYYYvW2gejthRry6yMC
   A==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269544"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:30 +0800
IronPort-SDR: D5qfV4Ir0aL1em87qLeRigAMkcZK3ujKbq5CTAXiNa42YF4vkfVCWDvAeAnIXfz8m/Hutf3LZL
 d/YXXwxNffGATuADaZyw9Q8KWuK2gMuVpOnLfrWApsb9ab3QZykjqYGUHxnm4arUG1v2/5mMiX
 TIjbSWqSdRw68ZHJ/JJVrPSLqGnsJp9QOL+rMMfduPVuQJAutukw/uhuZ0CgFK/DyDvoFOTR/r
 6jzLR8641g/S4QI6S2Nk4f39IXf2VDJXJPHMMpdsYz4KAXVBvrYdRdCiBwIctLEk1sDiJ9UJVW
 6co=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:07 -0700
IronPort-SDR: anJgGaFHfKAXcj3oCAhUYlIW+SHBYuMV7Dxqw3ohq+uqHQ6brB2lZp08ZvtggnVPh/g3Mpu+Ex
 UqESGU8+5vg1JcaPBo7mAcaPKmjZsYoT4L8KDhaN0ff7+R6eO9dyNPE0ifOXp3dpv/2rUtqMTk
 zEMl00/Hm+qkiHRYCR86LyjpK2TdbjD4YHQzBHxzzpUKXKi63xg23+YnwBCEFzUui/F69gPmFG
 NxEjCiRY8DeT8z9LurHl2HmzePcJg6hwQP5i7bcLnr4g7VYvtnKGN52ww5S6oRqgRp2h2XAOvG
 +Z4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 00/10] btrfs: zoned: write-time activation of metadata block group
Date:   Tue,  1 Aug 2023 02:17:09 +0900
Message-ID: <cover.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

- v2
  - Introduce a struct to consolidate extent buffer write context
    (btrfs_eb_write_context)
  - Change return type of btrfs_check_meta_write_pointer to int
  - Calculate the reservation count only when it sees DUP BG
  - Drop unnecessary BG lock

Naohiro Aota (10):
  btrfs: introduce struct to consolidate extent buffer write context
  btrfs: zoned: introduce block_group context to btrfs_eb_write_context
  btrfs: zoned: return int from btrfs_check_meta_write_pointer
  btrfs: zoned: defer advancing meta_write_pointer
  btrfs: zoned: update meta_write_pointer on zone finish
  btrfs: zoned: reserve zones for an active metadata/system block group
  btrfs: zoned: activate metadata block group on write time
  btrfs: zoned: no longer count fresh BG region as zone unusable
  btrfs: zoned: don't activate non-DATA BG on allocation
  btrfs: zoned: re-enable metadata over-commit for zoned mode

 fs/btrfs/block-group.c      |  13 ++-
 fs/btrfs/extent-tree.c      |   8 +-
 fs/btrfs/extent_io.c        |  48 +++++----
 fs/btrfs/extent_io.h        |   6 ++
 fs/btrfs/free-space-cache.c |   8 +-
 fs/btrfs/fs.h               |   9 ++
 fs/btrfs/space-info.c       |  34 +-----
 fs/btrfs/zoned.c            | 201 +++++++++++++++++++++++++++---------
 fs/btrfs/zoned.h            |  20 +---
 9 files changed, 216 insertions(+), 131 deletions(-)

-- 
2.41.0


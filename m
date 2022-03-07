Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC614D0AAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiCGWOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiCGWOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:19 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC7755480
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:23 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 11so14568583qtt.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXnqxy8etcUOEobcUWPGoYl1ogFFtI4pC94gxctopFM=;
        b=7QdQebBKsv295BOoSNeHZHUEL9XVog/L7+ud9p5nVwVJu6V8dsevKsS0XZ3BY1tLJ6
         fUHSgI1NkHjJ9pcI+ovn0iiU62ZMEyg/6rSETE8oIrTsHEFbhI7O2p5iOR8Nkar2Yl7S
         zhUQglvh+QJ/Rjuc61B9BSjS2CHhpIkNQopTy0tHgmX6ONGn2gcP9mKVuTQCgjMl6Ax7
         QvT2/EYRMWaqvU0O/nId50AMn+EaghLN1w2Am9BTRIC9KhquqarnYr/Ad3X0mZTLHXej
         nIjP5I+Su7+QZjytaP5GAm+7kuPDZqzN3q/vvlmNAQiJ0j3l7PGDWbMHjOTwh0/T6W5s
         wvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXnqxy8etcUOEobcUWPGoYl1ogFFtI4pC94gxctopFM=;
        b=nsW7p5K0MYJkFgH+njjDQ10V9GM0zEPXXMuKzpEW8nt58Iu43/Wes6t6g37qv0KPOb
         /IEl2zWrRpUEkHcavru2NetxdUDlrBT11eNh7xrl3BLDZQE44iKrWFUCS4Go3wG/66+3
         RtB4RFO/IM1xadODdRN8wo6q5yr3vz8tAtaE/NrnFubgjUefk9pzg47uSdd8m0eTfVFE
         kZtGtmsyByb/04ais/uBgunlMzsx0ynvfyv2Vms0Jv7QA0KQe0B5+FBagqTZY688gBER
         6a3eJH/8LjSkMARNfSnNC7uN9MT9MScjcmDEpkpFrbrFwSbtCKSXG/yJ6nsyQ+7i150V
         XSFQ==
X-Gm-Message-State: AOAM530f+JR0T3wzP/C2Cr/7yF7bZxvga91mGOJIazYGE2syLpO2/Z1J
        5MdeIo5KQXuOblUkDk+Wk303dLCJpEp5BX+e
X-Google-Smtp-Source: ABdhPJysPlLbK2qnkDyh06yhx5gk1ZXDzTP43Z1a7HeKM+MeRS9lxeP3QSxyQexexKB8/mjnCE9JhA==
X-Received: by 2002:ac8:5d49:0:b0:2df:f50f:f4eb with SMTP id g9-20020ac85d49000000b002dff50ff4ebmr11483656qtx.202.1646691202223;
        Mon, 07 Mar 2022 14:13:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b002e06856b04fsm2617533qtb.51.2022.03.07.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/15] btrfs-progs: extent tree v2 gc tree and metadata ref changes
Date:   Mon,  7 Mar 2022 17:13:05 -0500
Message-Id: <cover.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- rebased onto devel, depends on "[PATCH v5 00/19] btrfs-progs: extent tree v2
  support, global roots"

--- Original email ---

Hello,

Here's the next set of btrfs-progs patches for the next set of extent tree v2
features, no more metadata reference tracking and support for a garbge
collection tree.

1. No more metadata reference tracking.  For cowonly trees (global roots) we
   never have more than one reference for a block, so the reference counting
   adds a fair bit of overhead for these trees.  This is especially noticeable
   with the extent tree, we have to update the extent tree to include references
   for every block, including blocks in the extent tree, which generates more
   modifications to the extent tree.  In practice there's a stable state so we
   do not recursively use all the disk space describing the extent tree, however
   it generates a certain amount of churn.

   For FS tree's that can be shared we still want a way to know when we can free
   blocks.  That will be accomplished by drop trees in a future patchset and
   described more thoroughly there.

2. Garbage collection tree.  Free'ing objects in btrfs is a more complicated
   operation than in other file systems.  For truncate we can mete out the
   removal of the inode items, but the cleaning up of checksums has to be done
   in the transaction that the extent is freed.  For large files this can be
   quite expensive and cause latencies because we have to hold the transaction
   open for these operations.  Deferring this work to a GC tree will allow us to
   better throttle these long running operations without causing latencies for
   the rest of the system.

   As alluded above, free'ing shared metadata extents via the drop trees will
   be one of these longer running operations, having a GC tree in place will
   allow us to do these heavier operations without requiring they be done in a
   single transaction.

These patches have been tested with the corresponding kernel patches and pass
the xfstests that are able to be run.  Thanks,

Josef

Josef Bacik (15):
  btrfs-progs: extract out free extent accounting handling
  btrfs-progs: check: skip owner ref check for extent tree v2
  btrfs-progs: check: skip extent backref for metadata in extent tree v2
  btrfs-progs: check: calculate normal flags for extent tree v2 metadata
  btrfs-progs: check: make metadata ref counting extent tree v2 aware
  btrfs-progs: check: update block group used properly for extent tree
    v2
  btrfs-progs: do not insert extent items for metadata for extent tree
    v2
  btrfs-progs: do not remove metadata backrefs for extent tree v2
  btrfs-progs: repair: traverse tree blocks for extent tree v2
  btrfs-progs: cache the block group with the free space tree if
    possible
  btrfs-progs: make btrfs_lookup_extent_info extent tree v2 aware
  btrfs-progs: mkfs: don't populate extent tree with extent tree v2
  btrfs-progs: add on-disk items and read support for the gc tree
  btrfs-progs: mkfs: create the gc tree at mkfs time
  btrfs-progs: deal with GC items in check

 check/main.c                     |  98 ++++++++++++++-
 check/mode-original.h            |   1 +
 common/repair.c                  |   6 +
 kernel-shared/ctree.h            |   6 +
 kernel-shared/disk-io.c          |  10 ++
 kernel-shared/extent-tree.c      |  82 +++++++++----
 kernel-shared/free-space-cache.c |   3 +
 kernel-shared/print-tree.c       |   4 +
 mkfs/common.c                    | 201 +++++++++++++++++--------------
 mkfs/main.c                      |  13 +-
 10 files changed, 305 insertions(+), 119 deletions(-)

-- 
2.26.3


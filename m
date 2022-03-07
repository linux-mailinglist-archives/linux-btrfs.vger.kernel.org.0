Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C014D0A7D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245453AbiCGWF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbiCGWFZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:05:25 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363AD4133C
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:04:30 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d194so3608196qkg.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OF+WLTuqCfnL826zNrfKieakV95GXP8cV0borUjuwj8=;
        b=n2bOmIiyXGyqcrioTo9zkysWXtw8WDNVx//eFJQrWeJNcCOphoSj3gTNG5/AJ+rhry
         me3N69oxexXL7h77l/LpuYsmH6tcu4YxPMxNPMinyVrFlSmrWEK4CoL8B9/4sA5nIwae
         FeNaeNVA0LQL3jLkNsgOih82DLRPts0f82qKXNT8adldC6ZTuDYGGgTM4kz6WCDvtbqj
         sGUufvU8s1F8z33XVR/BHI+wLrPWfbvNgH47fZH5aEbN/zB4uiMAGg3GpzsTtKufJ+Z/
         b1o19FV7vi0mAMVze/Znrxxtin7E7IKRYhzDdj2/TyvOwMzn0kvp0TCf2YfanN500ND2
         NPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OF+WLTuqCfnL826zNrfKieakV95GXP8cV0borUjuwj8=;
        b=P404MfgfoESVxlBSPjN2HyXa8ta0ScXB3q5Iy529thLV3PHds9kmt5wZ5uAUQ2+nG3
         OoucZhwnblhkVGLvM7EOvslBnel5hwy8ksq/tFS92oPrLoNP7Mw7EVX5hkXTiQhRoUcG
         LcjUWoNvG5ilIkolkv7Ye+gkxAgVQ7gH/BwxlU0edJBsB84BZ13ql5yt3klIj6B1vQHV
         1AdQ3dSO9wzMGGbsDkqtieiBh9V5IexLGgvnkp5LAVGCykM/slstGvned8BRdSiUgG9F
         ApziHAytKhnRxmnxticByTCAhikHmaYbDSeFan5idsc55l/XJTZzH8phIbDWEM77JmMw
         ieZg==
X-Gm-Message-State: AOAM533V71+7e+e49po1BTO3AavZar9mny4r59aDYB/7gdmFgrcXzyau
        n8e+CIhcrY2ePSwWXJURvGaL37Fx4UPGTcTl
X-Google-Smtp-Source: ABdhPJyxusLBPD+qej4JayjLeG2GDmg0rUxPJJja42gVr37Oyc/AZ7eHVF9mj7i9p2wH7PuHtbskGg==
X-Received: by 2002:ae9:e891:0:b0:47b:a53f:5f00 with SMTP id a139-20020ae9e891000000b0047ba53f5f00mr8014302qkg.693.1646690668632;
        Mon, 07 Mar 2022 14:04:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a14b700b00648eb7f4ce5sm6490817qkj.35.2022.03.07.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:04:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/6] btrfs: extent-tree-v2, gc and no meta ref counting
Date:   Mon,  7 Mar 2022 17:04:21 -0500
Message-Id: <cover.1646690555.git.josef@toxicpanda.com>
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
- I decided to add the nr of expected global roots to the super block to make
  checking more straightforward, so added a patch for reading that value.
- I sent the prep patches/fixes in a different series and those were merged, so
  dropped them from this series

--- Original email ---

Hello,

This is the kernel side of the support for the GC trees and no longer tracking
metadata reference counts.

For the GC tree we're only implementing offloading the truncate to the GC tree
for now.  As new support is added we'll add code for the garbage collection for
each of the new operations.  Truncate was picked because it's simple enough to
do, gets us a nice latency win on normal workloads, and is a quick way to
validate that the GC tree is doing what it's supposed to.

This also disables the reference counting of metadata blocks.  Snapshotting and
everything reference counting related to metadata has been disabled, and will be
turned back on as the code needed to support those operations is added back.

This survives xfstests without blowing up.  Thanks,

Josef

Josef Bacik (6):
  btrfs: read the nr_global_roots from the super block
  btrfs: don't do backref modification for metadata for extent tree v2
  btrfs: add definitions and read support for the garbage collection
    tree
  btrfs: add a btrfs_first_item helper
  btrfs: turn evict_refill_and_join into a real helper
  btrfs: add garbage collection tree support

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/ctree.c                |  23 ++++
 fs/btrfs/ctree.h                |  19 ++-
 fs/btrfs/disk-io.c              |  37 ++++--
 fs/btrfs/extent-tree.c          |  13 +-
 fs/btrfs/gc-tree.c              | 223 ++++++++++++++++++++++++++++++++
 fs/btrfs/gc-tree.h              |  15 +++
 fs/btrfs/inode.c                |  65 +++-------
 fs/btrfs/print-tree.c           |   4 +
 fs/btrfs/space-info.c           |   4 +-
 fs/btrfs/transaction.c          |  52 ++++++++
 fs/btrfs/transaction.h          |   2 +
 include/uapi/linux/btrfs_tree.h |   6 +
 13 files changed, 394 insertions(+), 71 deletions(-)
 create mode 100644 fs/btrfs/gc-tree.c
 create mode 100644 fs/btrfs/gc-tree.h

-- 
2.26.3


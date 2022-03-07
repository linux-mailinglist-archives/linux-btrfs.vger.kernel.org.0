Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CF4D0B31
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbiCGWiK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbiCGWh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:37:58 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0E52E0B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:03 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id gm1so13279754qvb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xt6kYwSpq/Jy4ZmE2fFl/7wslKkhO6MnoFXo8RrGMbI=;
        b=l+c25eGEuaZpX5M+xa5rTj1sHI0uqYf0XLae/dBtj7s6pYDAiiswmpVlhSPdjVsQiL
         9t9b217taLp18cCrOXa5H/Xaw9eFjhEDBNl/ny3UPkPWPSi8NB2SLuch0RgK1nz6ypwS
         Pl/a2uZZ1p8dZjDzqdLD2xLzjzAK4weBoCXr0+1pYisW3SeLA1A1Vh82l3LUXJEOi6Qz
         fbILHng7WvifkPpu/R+Z4GA2JlcP3Wu6u4OqDZK+0tUyIouRuPS1gSYow6B2TSaumy59
         Eeuqrvfc9ij4oIn6rmw/NGNGz59jYR3Ii35dRXq0gImGVlLMA/xKSOdwFafJ8E25288s
         Yw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xt6kYwSpq/Jy4ZmE2fFl/7wslKkhO6MnoFXo8RrGMbI=;
        b=Ri3aW+3/qdYLQx12VYC7nBQK9iGwB7NXvXNwYckaLOGF8qzsV61MB937ti2A9fBsNI
         yDieSVnTOCe0r0KYE5CNMWqll+ZxUYIa6NDiR1dccFr2TBk/oB5x8Det8aJrUBA+3Nur
         R87oRrJpcSpm7M0aklBohFbhF8oaJwaMtyBKi4pmT5OKnwtM4iKF78SLMwcftW2VdPjy
         2HUKSnsVvnvfMfZcSYlvyyVgsjJS0keHfHy1PJEtltn85VfypqUAz7ibWCCUfHz+jij8
         pdHzAO0Msx7oUuJXUiT2yj/MitwH6DV2jqj14FY88ZZOmzr/aiEMC6hgmTlMGCJxEo0k
         Y/lA==
X-Gm-Message-State: AOAM531lbhcTejlkBRAcrcLb31LHWIH+ttJkAL1+kZidpIOtJCNkX9nx
        U5usljshUeW073aTQIxucpxZwBHIj2QyYD+Y
X-Google-Smtp-Source: ABdhPJxi0Nov3avErBdgIM5PWMVqAtDwHzWEyljPoPyqyZhZHrYKXA6aPYxOGeWd5jnta9uGo8lPOg==
X-Received: by 2002:a05:6214:d6d:b0:435:22f0:ee7c with SMTP id 13-20020a0562140d6d00b0043522f0ee7cmr10138449qvs.38.1646692622627;
        Mon, 07 Mar 2022 14:37:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 141-20020a370a93000000b0067b009288bdsm3380377qkk.87.2022.03.07.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/11] btrfs: add snapshot_id to btrfs_header and root_item
Date:   Mon,  7 Mar 2022 17:36:50 -0500
Message-Id: <cover.1646692474.git.josef@toxicpanda.com>
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

Hello,

This is the next series of changes for extent tree v2.  This adds support for
the snapshot_id to the btrfs_header and btrfs_root_item.  This will allow us to
track shared blocks more simply without requiring a lot of reference updates.

There are also a few extra patches tacked onto the end to add some more testing.
Since we're changing the size of the btrfs_header I wanted to get as much
coverage as possible on the different ways we modify leaves and nodes so I added
another selftest and added support for running the selftests with extent tree v2
set.

Thanks,

Josef

Josef Bacik (11):
  btrfs: take into account BTRFS_HEADER_FLAG_V2 in the item/node helpers
  btrfs: add global_tree_id to btrfs_root_item
  btrfs: add snapshot_id to the btrfs_root_item
  btrfs: handle the new snapshot_id field properly
  btrfs: add a sanity checker for the header flags
  btrfs: zero dummy extent buffers
  btrfs: zero out temporary superblock buffer header
  btrfs: add a debug range check for header_v2
  btrfs: selftests: add a test for delete_one_dir_name
  btrfs: don't do the global_id thing if we are a DUMMY_FS_INFO
  btrfs: selftests: run with EXTENT_TREE_V2 set as well

 fs/btrfs/ctree.c                       |  13 +-
 fs/btrfs/ctree.h                       |  14 +-
 fs/btrfs/disk-io.c                     |   4 +
 fs/btrfs/extent-tree.c                 |   7 +
 fs/btrfs/extent_io.c                   |  22 +++
 fs/btrfs/tests/btrfs-tests.c           |  77 +++++++----
 fs/btrfs/tests/btrfs-tests.h           |  18 ++-
 fs/btrfs/tests/extent-buffer-tests.c   | 181 ++++++++++++++++++++++++-
 fs/btrfs/tests/extent-io-tests.c       |   9 +-
 fs/btrfs/tests/extent-map-tests.c      |   2 +-
 fs/btrfs/tests/free-space-tests.c      |   6 +-
 fs/btrfs/tests/free-space-tree-tests.c |  21 +--
 fs/btrfs/tests/inode-tests.c           |  25 ++--
 fs/btrfs/tests/qgroup-tests.c          |   5 +-
 fs/btrfs/tree-checker.c                |  27 ++++
 fs/btrfs/volumes.c                     |   2 +
 include/uapi/linux/btrfs_tree.h        |  12 +-
 17 files changed, 376 insertions(+), 69 deletions(-)

-- 
2.26.3


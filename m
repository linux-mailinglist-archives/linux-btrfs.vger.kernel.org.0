Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167E3F51DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhHWUPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhHWUPk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2531C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:14:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so20622135qke.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwLUP9vrGKw8YyQ1DhcU0JCM9Cq8gja//jEtDs3Cb2M=;
        b=wTyuQsRSv9ziLUzWghEFZhuGjUKOIcfEs8ByiEdsvOvX+mXLEgrKB6beLt+2n+TTMB
         EfOftukhv4tHX/a0i4sCeS7b1Tpottv+jQIrOS6nHh//a16e1KSCIl+59hkoyEG9UN2F
         zmNrvyiKMReGwoWVjxa84/bKklnNUhN4aA62+wCuESfqhQ4qxcEyWxR8QnT41XsTDLy8
         QMIXr2NeOk1NRHdZxTfE+FtCupNVlcFF0vCEyz0FPzISv1FKkfhQO7/IHAlKXTMJRxXC
         zOy8Rtx5W9Ca1pkWgh3qdKoCaa2tke9dwZ+GkkPum9qzQDJIaV6RZSDTvp1CQbtyBQzn
         2+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwLUP9vrGKw8YyQ1DhcU0JCM9Cq8gja//jEtDs3Cb2M=;
        b=i5rYJlJ3aCBR/z5rymZvhDOacdB0mM6n8mDiBcEqm/i5tSoY6DAUu/CPhXtAdMGJNi
         tvfgl4xumk7MMXG1P4p9Nir5Fbs1+bmfTsI2c/r1Jr/dXrM+9FA7YA4k0K7xddUvhtqF
         c0io69fmGtQMvNvLBUvD33SsjT54IgbuAcEZbCCs5HkXIjr64REp+cfJphdZBn4cPNZ1
         7dVTCozTsaMw1u8FgnEs2jSldW+ANV78ZGuxELyY49fPbYJHNM5SsiH+SNhjs7g0hIKA
         y0BaEuUivm6itlpMgF4+trleuZ28EviBdBa69+dzL3Ai7xgkSzMBQhvl4rqOtKtDhQlu
         LNXw==
X-Gm-Message-State: AOAM533JDcw9bXPi9Zqu/VPiJ9mjPfbKPcf+hAhHOyMNbu4dIUMfaQBa
        5pi/2Agmqp41FbnwXPcCX3eofEPwqTP/6A==
X-Google-Smtp-Source: ABdhPJw2LdBP6B4FtI4CPoQCXR30PwYPY5VJ3hJI6FiTRLoY1//V8SJuNSw9BNROVKZcqrmA+sF5+Q==
X-Received: by 2002:a37:8407:: with SMTP id g7mr23060523qkd.123.1629749696672;
        Mon, 23 Aug 2021 13:14:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j127sm9205492qkf.20.2021.08.23.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:14:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/10] btrfs-progs: mkfs fixes and prep work for extent tree v2
Date:   Mon, 23 Aug 2021 16:14:45 -0400
Message-Id: <cover.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebase onto devel+block group used patches.
- Dropped MKFS_SUPER_BLOCK as suggested by Qu.
- Make sure to recow the free space root now that we're generating it at
  make_btrfs() time.
- Rewored the titles to include the target area.
- Dropped "btrfs-progs: allocate blocks from the start of the temp system chunk"
  as it is no longer needed with the MKFS_SUPER_BLOCK dropping.
- Add a patch to make sure ->ref_cows and ->track_dirty is set properly on roots
  if we read roots directly.

--- Original email ---
Hello,

In order to reduce the amount of pain the reviewers have to endure I'm going to
be sending any prepatory patches separately from the actual feature work.

To that end this is the first batch of preparatory patches.  These are to make
working with mkfs a lot easier for the changes I'm making.  These are all fixes
or enhancements that can apply currently.  The only thing that is extent tree v2
specific is the last patch, which adds the incompat flag.

I've added the patch for the incompat flag because I will have other preparatory
patches that add helpers that essentially do

if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
	/* Do the old thing. */

and then have patches after that add the extent tree v2 magic.  I think this
will make it easier to break up the work, but if we're not comfortable reserving
the bit then I'm fine with dropping that last patch.  It will just mean future
prep work will have to come along with the feature enablement patches.

I've tested this with make test to validate I didn't break anything.  Thanks,

Josef

Josef Bacik (10):
  btrfs-progs: mkfs: use an associative array for init blocks
  btrfs-progs: mkfs: get rid of MKFS_SUPER_BLOCK
  btrfs-progs: mkfs: use blocks_nr to determine the super used bytes
  btrfs-progs: mkfs: set nritems based on root items written
  btrfs-progs: mkfs: add helper for writing empty tree nodes
  btrfs-progs: make sure track_dirty and ref_cows is set properly
  btrfs-progs: mkfs: add the block group item in make_btrfs()
  btrfs-progs: add add_block_group_free_space helper
  btrfs-progs: mkfs: generate free space tree at make_btrfs() time
  btrfs-progs: add the incompat flag for extent tree v2

 kernel-shared/ctree.h           |   1 +
 kernel-shared/disk-io.c         |   5 +-
 kernel-shared/extent-tree.c     |   2 +
 kernel-shared/free-space-tree.c |  26 ++++
 kernel-shared/free-space-tree.h |   2 +
 mkfs/common.c                   | 212 ++++++++++++++++++++++++--------
 mkfs/common.h                   |  19 ++-
 mkfs/main.c                     |  24 ++--
 8 files changed, 224 insertions(+), 67 deletions(-)

-- 
2.26.3


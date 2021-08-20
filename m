Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F133F3455
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhHTTMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhHTTMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:38 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B27C061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id dt3so6059363qvb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRAtnyF6vhxf/AuftBjGY88Icdv7WjRmvYpYFJll3RY=;
        b=vIm5QIWHyiyMRVlekDaCoJsFzsbcDkJzBJKe0jNc6EPYUBHJIHG66+a9KDklW4HHPt
         /l74mhxCaxomDQk5QvAcwm6qF/ypo8/mVMcqPibYluZ6BMT2AVEpVRGXKl+IXBsj0xWa
         nb2yUm9clXgN4uZQaWWG+Wgif+wFzEaDzf2zSNGjseJ00uGTu1WqrAfu6zyM9LyRVXpS
         lztgFIlUUFJDTYxone6Bmiwk1ZFEaoqZ5dwUYzJ3knIbwQiI2sY7ziLK6FUhJ5yHK9Ki
         pxuw5lYHWoeS6aTiXtGLFLA9+C7AlNWeWTlJp/fx9E8f/0tVZJ0t2qlMtR3L3JZmJ4RX
         7c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRAtnyF6vhxf/AuftBjGY88Icdv7WjRmvYpYFJll3RY=;
        b=MB5ynNjSWPE0RdFtxe1Ej9tKppyFyrPlYq88jYXcRwEfAioQuFHZIA4hqJ4bxeTqgu
         HuzmOGcIWmFQbpXVtbll89HENK6B3xhkddn3xY3B7zVh9b45Xt3DpS/LKynMc9+V2+7y
         xKHWwWpRI0d1DWi0CwptuBN12AN+Ss3meBBy/QaFidJ4R4jc+d93ExCST8Dz1ThmIwNn
         xl+sH7IjnOTHiRfryFedAnXqQdLAZm5lqUqKlPLDdLGdwK36w+zYWKLWte0dn92T9T0B
         4PvJgaaZlom6VTb0qNvLGHJjJ/PrzHSvw7Tlyh6kaXr/aZvpDeeRI/+bPbbTI5NXsB++
         AVEQ==
X-Gm-Message-State: AOAM533matmQpg9MNyyMyxAaB8It8Ug6ar3qhpMZU05710ns9e1EED6k
        BRLKDfBRf4RdqbvqH4H8frC+jUTKZWlmdA==
X-Google-Smtp-Source: ABdhPJwY+4q3p/YZh/eDFd0EEIE7QzVbMGAaMM2oug/akV6QfvMTRDyK56IjyyLiAxnvmnCaTcUNdw==
X-Received: by 2002:a05:6214:80a:: with SMTP id df10mr21758975qvb.58.1629486719077;
        Fri, 20 Aug 2021 12:11:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o20sm2887663qtk.41.2021.08.20.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:11:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9] btrfs-progs: mkfs fixes and enhancements for extent tree v2
Date:   Fri, 20 Aug 2021 15:11:48 -0400
Message-Id: <cover.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (9):
  btrfs-progs: use an associative array for init mkfs blocks
  btrfs-progs: use blocks_nr to determine the super used bytes
  btrfs-progs: allocate blocks from the start of the temp system chunk
  btrfs-progs: set nritems based on root items written
  btrfs-progs: add helper for writing empty tree nodes
  btrfs-progs: add the block group item in make_btrfs()
  btrfs-progs: add add_block_group_free_space helper
  btrfs-progs: generate free space tree at make_btrfs() time
  btrfs-progs: add the incompat flag for extent tree v2

 kernel-shared/ctree.h           |   1 +
 kernel-shared/extent-tree.c     |   2 +
 kernel-shared/free-space-tree.c |  26 ++++
 kernel-shared/free-space-tree.h |   2 +
 mkfs/common.c                   | 209 +++++++++++++++++++++++++-------
 mkfs/common.h                   |  19 +++
 mkfs/main.c                     |  18 +--
 7 files changed, 218 insertions(+), 59 deletions(-)

-- 
2.26.3


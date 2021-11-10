Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52344CA1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhKJUK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhKJUKz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:10:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F5C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:07 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id bl12so3626183qkb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiCWdx3qh0AEX6s+xjBYtu1RC1jMCToPPRr6J0rOmKs=;
        b=7kFk+ovRsvfuy2tor3r+I7cVgETjGQkOr276WZ1h5pMZVC3/iJ1jP3x0dv9Q/r2h4Y
         1EyaSPepCh/5yupS7cbdZTtqTqU9Ld9viTk5ElIbD1Dzxz+ECo0DowJ2G+Q4wjbXj1+V
         55JG2h5ViD8WsQyZEHk2gid3RuSqRv6uJqickh1nsIC5wwnGWdUAwT+YV7gRlwS8f/q4
         V3WiHjR4eoXI6aricszKH3FuGBBXCBb4V7Ty8hEybXxmEhCSrqesxxeD+Nx7dWKtLyYL
         aPjtnLtJjocE99uEkHaibCdKuWQfQ4lPucbZICj09Y5EwkgWU9VkD5SbkFulJueuXS0f
         f7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiCWdx3qh0AEX6s+xjBYtu1RC1jMCToPPRr6J0rOmKs=;
        b=35Sy4jrO8joSUZ/ppUCYjYyq4dd6XFmCkvmxA0kaoGlhuBcyPpYnYOSmKtdX4Hf7Hx
         kmadgmqNfJkMLpweQa8y3fHXHgertlrQMthUig4tNxRW59U34AtZD7gL2iP0XCoKd3e1
         vZkrEFvJzd8cyXyHqV9VbxG4bGo4bi0novjvoo4l5V7G4eVQMAr8NwNo47e4bR/A2Svo
         VAHLJS6aIDk8qUGaIMUVxH+mdoNJkZG+0E8/99aXj/Ozqthu/5qLWxQeR6ne30/4FwJ/
         s6Mku+zsuKvi91EotzsFRQWigYnvMycblqieiWKegQwpclb5tPv1zHdOevGEXb5ZxOgf
         b5PQ==
X-Gm-Message-State: AOAM5321YEwthSfGVulJrHHqoGhZt9nawmMajYvjlFaGJ14F8i/5vGAR
        tX1M9vmRJ+fMSZKprgtICn/OmiYugHfO0Q==
X-Google-Smtp-Source: ABdhPJy8WZakcGxKdsKSio7pQIwebO8cjlgM/wbupfKa9XssZ357z3O1bkGxC2E4qWv51iEZSFJfAg==
X-Received: by 2002:a37:647:: with SMTP id 68mr1682239qkg.343.1636574885881;
        Wed, 10 Nov 2021 12:08:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j20sm490511qtj.72.2021.11.10.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/13] btrfs-progs: extent tree v2 global root support prep work
Date:   Wed, 10 Nov 2021 15:07:51 -0500
Message-Id: <cover.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Added a "btrfs-progs: check: fix set_extent_dirty range" which I discovered
  when adding the next part of the changes.
- Dropped all of the global root stuff, pushing it into the extent tree v2
  specific changes.
- Reworked the super block root helper to take a level as suggested by Qu.

--- Original email ---

Hello,

This is a series of patches to do all the prep work needed to support extent
tree v2.  These patches are independent of the actual extent tree v2 support,
some of them are fixes, some of them are purely to pave the way for the global
root support.  These patches are mostly around stopping direct access of
->extent_root/->csum_root/->free_space_root, putting these roots into a rb_tree,
and changing the code to look up the roots in the rb_tree instead of accessing
them directly.  There are a variety of fixes to help make this easier, mostly
removing access to these roots that are strictly necessary.  Thanks,

Josef

Josef Bacik (13):
  btrfs-progs: check: fix set_extent_dirty range
  btrfs-progs: simplify btrfs_make_block_group
  btrfs-progs: check: don't walk down non fs-trees for qgroup check
  btrfs-progs: filesystem-show: close ctree once we're done
  btrfs-progs: add a helper for setting up a root node
  btrfs-progs: btrfs-shared: stop passing root to csum related functions
  btrfs-progs: check: stop passing csum root around
  btrfs-progs: stop accessing ->csum_root directly
  btrfs-progs: image: keep track of seen blocks when walking trees
  btrfs-progs: common: move btrfs_fix_block_accounting to repair.c
  btrfs-progs: check: abstract out the used marking helpers
  btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
  btrfs-progs: mark reloc roots as used

 btrfs-corrupt-block.c       |   2 +-
 check/main.c                |  37 ++++----
 check/mode-common.c         | 124 ++-----------------------
 check/qgroup-verify.c       |   4 +
 cmds/filesystem.c           |  19 ++--
 cmds/rescue-chunk-recover.c |  17 ++--
 common/repair.c             | 176 ++++++++++++++++++++++++++++++++++++
 common/repair.h             |   3 +
 convert/main.c              |   2 +-
 image/main.c                |  12 +++
 kernel-shared/ctree.h       |   8 +-
 kernel-shared/disk-io.c     | 101 +++++++++++++--------
 kernel-shared/disk-io.h     |   2 +-
 kernel-shared/extent-tree.c | 117 ++++--------------------
 kernel-shared/file-item.c   |   6 +-
 mkfs/main.c                 |   3 +-
 mkfs/rootdir.c              |   2 +-
 17 files changed, 326 insertions(+), 309 deletions(-)

-- 
2.26.3


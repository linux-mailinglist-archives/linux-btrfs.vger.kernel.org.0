Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C394E449C66
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhKHT3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhKHT3f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:35 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2DBC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:51 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b11so12608869qvm.7
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgIdhMHTAvT7uHMIzJjbQzY4cYeJ2fVbi9lMwOdBtUI=;
        b=ceyVf2M8+KQx1ST/AXV2KiLhtH9UeVY37kRRhixxbvQdfQUya1sFMNP9gAU7J1qYC7
         ARl43cvgPWyBDVbuci9tC2UD0bw6Or8Psw3mruFzzqurfeln4Nm3eZ4BmNOtFt5EkHKW
         5BDXrjHb54u9tFDYL76zJjuOLXll1v2Fqgs17jPru1Ztu3UJ54NYZcHMT7hvI1uv2zUn
         hM3/w4cI7CwkYIjRjvLetvJCi1XgTn4o4odUQ4lWICtWsN9xLBYzPSGL/AwVzfv36N4x
         ekU+hY49FmHGgKoez0IJWfTY9/rcglUNUMjmvpfI1RlySXp3eANZxSptNgL1YkGqonM9
         VKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgIdhMHTAvT7uHMIzJjbQzY4cYeJ2fVbi9lMwOdBtUI=;
        b=CwIsOaLDaN+jfdrCsHl16rdCXUA1HN2EJi3+QTjhaFzMy5nNzca5yRzhgcC4nSqUkS
         V/rcG8F4r85qUTaqMaI4BOH1gwtmZ0uOd8EPVYFNsHcblMvmpe7jhdSbFf10VK0B6dvS
         eIMM9VZbA35Y2Fa8GBPgUfC3F2z9skQ2Xnqg7DaUgNmsKUtGFiJhYZyANN0Z2e3KGF4L
         fWJT5sgS2a5GkUu+fARYchw67o5hHTt9ykPLJ2JZ0+Sz090ml/f7KEP3sBL053d/UELQ
         je79BOMbEEnRIUEPRV/CpTGRdTNh5y4fB/p1xs2dYodUH3HqdfCHN0+htq/IBKKT6tr3
         XP6Q==
X-Gm-Message-State: AOAM532AzZFkrzkewVqSwgEd/6GNMjxGbW53e/Ok9OBJSS/HZKCDXeHy
        xxdLYQMGOKoTz5k7BIa9wkRvGJDAwdcS1w==
X-Google-Smtp-Source: ABdhPJw4XTY9W4B0onX1H0UHxhscI6ZGC1fMDNJ53Km+TIcUj6EUF9jvnQzJKKh0aknrjBsPt6Yguw==
X-Received: by 2002:a05:6214:b01:: with SMTP id u1mr21202479qvj.37.1636399610118;
        Mon, 08 Nov 2021 11:26:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm2899403qkm.5.2021.11.08.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/20] btrfs-progs: extent tree v2 global root support prep work
Date:   Mon,  8 Nov 2021 14:26:28 -0500
Message-Id: <cover.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- reworked the root node helper thing to check the level as well as per Qu's
  suggestion.
- Fixed a place where we weren't inluding common/repair.h to get a helper that I
  moved (not entirely sure how this still built but whatever.)
- Fixed a place where I could get fs_info from an eb instead of passing it
  around.

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

Josef Bacik (20):
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
  btrfs-progs: stop accessing ->extent_root directly
  btrfs-progs: stop accessing ->free_space_root directly
  btrfs-progs: track csum, extent, and free space trees in a rb tree
  btrfs-progs: check: make reinit work per found root item
  btrfs-progs: check: check the global roots for uptodate root nodes
  btrfs-progs: check: check all of the csum roots
  btrfs-progs: check: fill csum root from all extent roots
  btrfs-progs: common: search all extent roots for marking used space

 btrfs-corrupt-block.c           |  15 +-
 btrfs-map-logical.c             |   9 +-
 btrfstune.c                     |   2 +-
 check/main.c                    | 223 +++++++++++++------
 check/mode-common.c             | 132 +----------
 check/mode-lowmem.c             |  72 +++---
 check/qgroup-verify.c           |   6 +-
 cmds/filesystem.c               |  19 +-
 cmds/rescue-chunk-recover.c     |  35 ++-
 common/repair.c                 | 227 +++++++++++++++++++
 common/repair.h                 |   5 +
 convert/main.c                  |   6 +-
 image/main.c                    |  14 +-
 kernel-shared/backref.c         |  10 +-
 kernel-shared/ctree.h           |  10 +-
 kernel-shared/disk-io.c         | 373 ++++++++++++++++++++++++--------
 kernel-shared/disk-io.h         |   8 +-
 kernel-shared/extent-tree.c     | 159 ++++----------
 kernel-shared/file-item.c       |   6 +-
 kernel-shared/free-space-tree.c |  54 +++--
 kernel-shared/volumes.c         |   3 +-
 kernel-shared/zoned.c           |   2 +-
 mkfs/main.c                     |  29 ++-
 mkfs/rootdir.c                  |   2 +-
 24 files changed, 907 insertions(+), 514 deletions(-)

-- 
2.26.3


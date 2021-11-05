Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0961A4469A9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhKEUb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhKEUb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:29 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E663EC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id az8so9855262qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayrjA4RuH6Gg4nfnyV4lDEGrORI7PdoP07ZjnZv08PE=;
        b=3jbFS0A5JyxlqrBOOIpehswg1D/+qs40jCJDuLYVByBXcORJDYJdeAklQmNSXLIeH0
         3nd0QnnHJL1vvHsPhPiDWtw08ji/RQNVotEMMvnmbILzFcglpp8QBCbO4aVbJQeNEJVA
         NKD+O7EoruOg17hiz3J5ct1yJ3ejGV5Pv4J8s4WP4jdEplgTlvxk7cIkhP+g29tNaaV5
         naLJsOhBLuSVUUBy8OJWfS0K/MsHZcBtP95NmmCHiSyKhjLZ0LXRIDH/R57QiJAE1plD
         Ih4gZvpqU27ncy11KkF8SCFQIRSy/4MMraOP8bz0/OcRvw1N8udtSYNoF1G1skRocVQd
         beAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayrjA4RuH6Gg4nfnyV4lDEGrORI7PdoP07ZjnZv08PE=;
        b=P3IjarreZz0LV5zbN1u0IdTnOWp6mlVg2BK5KGTJKIh0z1reQPyKEJZJQmdm/U/4QH
         cnnYS8eqI+PUf2UTlxrjYrvGbhHKQx904XchRvSw3Y7JvFEMLVP93IPGRshlfhy8hBzy
         MxdHjWpboJA6b7keNtp65ypow1SIHysi+JKDAHNMf2wxDXsuFQ4JnODEuRncHZjin02c
         SruaNP5n/ibD02ZmT7sCJEn13sjGJxKr3lGRyp6F1adXd9nm49+xFdBeeHOr6VHW+dEW
         Q58CPXgQP54Ad6qvVdsS7zj1JqpSettn2mmcCiU7Crvi0rZYIvZQfjoA/LZYaZ0Zjt/A
         HAcQ==
X-Gm-Message-State: AOAM530of3yhFkK2ELyvXSV3qcSBujOdTc9ryXla7Zcaw8+xVpx/+EEz
        nHXdvBOYhO30h/SI0tH82U4OhgXGws6qeQ==
X-Google-Smtp-Source: ABdhPJyQzh1XUylK1wSrHzC+2Z0rbfLIXIXalqtfcxgI8MkWEMcw8aJQQdU1Hc3r9Irva14vLC8drQ==
X-Received: by 2002:a05:620a:bc1:: with SMTP id s1mr50557891qki.49.1636144127497;
        Fri, 05 Nov 2021 13:28:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x16sm6778133qkp.56.2021.11.05.13.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/20] btrfs-progs: extent tree v2 global root support prep work
Date:   Fri,  5 Nov 2021 16:28:25 -0400
Message-Id: <cover.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
 check/main.c                    | 223 ++++++++++++++------
 check/mode-common.c             | 132 +-----------
 check/mode-lowmem.c             |  72 ++++---
 check/qgroup-verify.c           |   6 +-
 cmds/filesystem.c               |  19 +-
 cmds/rescue-chunk-recover.c     |  35 ++--
 common/repair.c                 | 230 +++++++++++++++++++++
 common/repair.h                 |   5 +
 convert/main.c                  |   5 +-
 image/main.c                    |  14 +-
 kernel-shared/backref.c         |  10 +-
 kernel-shared/ctree.h           |  10 +-
 kernel-shared/disk-io.c         | 356 +++++++++++++++++++++++---------
 kernel-shared/disk-io.h         |   8 +-
 kernel-shared/extent-tree.c     | 159 ++++----------
 kernel-shared/file-item.c       |   6 +-
 kernel-shared/free-space-tree.c |  54 +++--
 kernel-shared/volumes.c         |   3 +-
 kernel-shared/zoned.c           |   2 +-
 mkfs/main.c                     |  29 ++-
 mkfs/rootdir.c                  |   2 +-
 24 files changed, 892 insertions(+), 514 deletions(-)

-- 
2.26.3


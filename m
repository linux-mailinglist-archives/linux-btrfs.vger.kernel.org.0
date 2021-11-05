Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA674469CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhKEUnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhKEUnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09292C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bk22so9860664qkb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1dvDJsUGpC8JwnanWlHgduBPE++toOyUu1hWFCndGw=;
        b=i+SskB+nRay8mMA3JZgi6BQzJ9iCShMMD6odWagzeKIe025/OP8GJy9rN2JHGRgVKe
         YA55dSLC7h0pin5ZzK3FbCdjTdzyOC4yPoA27L/SKMNAVJK5+BH13UK81BKDyX8UkTUs
         oYBtSjp/QSS62DR+H+Dptm5548x8Ol1YaOEUhw9PCFNbo1eWdnPfqM5uCpwsatxGBsDt
         Oji3EdySs+sagHd6th8eTwU2U9YXk11GOzH9kg3f4s19Tk+sjBN5NCLq2PvyL2aU6ivm
         K1+/pdTdYgLZ9SPhylV4PB10qUuyUMe2VbrOzcHRgzzgvF3GTxEWe73er49ftzMSFO5w
         Sgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1dvDJsUGpC8JwnanWlHgduBPE++toOyUu1hWFCndGw=;
        b=W0yA8pLgQFCLp1TLXS72mqBbMbFkyp4x0xoMI8uNvA7alqsORw6RdE4VArjeXlH19z
         eyP1raOZwWVA7gCjts1JXUAB3v0ghPsog6SpL+Btcb+W+0D+1gtJcr8ZP6HbrX6wkIiJ
         Cl4w6g5+HVvYG0Bye1LWGARNvi50nqwyYpEa5VZIiojqrdEg1s1tbDVVnhU7pRzTLytq
         wtGf9KbHc3V4lkAOadJ6QbqEyUQylGX9KVtI7LHEB96mbQl9hrQ5zNYGKwnt04Bv1pxf
         XVM82aJhGS1/AcGuyTqVfaFaMxIFsHnfNAo3PoN31bgbP/KVMJF//9p7/qhJ/SzBzEV4
         YIkg==
X-Gm-Message-State: AOAM530xRHnO+RjG+7PSCNjAEZR8FNFzpWtrQMhIkoRESVrHYT8YD5EV
        CcSYXRZl87CYV5IIdHAI0X3o472Ymu6Wrg==
X-Google-Smtp-Source: ABdhPJwqHvfl4AsWPLBDAR+xokT4DPcqgsOPuUSZhHnXOfvYD+dVqOnA9JIWX8/yeEocn0+noIVtKw==
X-Received: by 2002:a05:620a:248f:: with SMTP id i15mr22133467qkn.23.1636144849537;
        Fri, 05 Nov 2021 13:40:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z186sm5869178qke.59.2021.11.05.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/22] btrfs-progs: extent tree v2 support, global roots
Date:   Fri,  5 Nov 2021 16:40:26 -0400
Message-Id: <cover.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

These patches are the first chunk of the extent tree v2 format changes.  This
includes the separate block group root which will hold all of the block group
items.  This also includes the global root support, which is the work to allow
us to have multiple extent, csum, and free space trees in the same file system.

The goal of these two changes are straightforward.  For the block group root, on
very large file systems the block group items are very widely separated, which
means it takes a very long time to mount the file system on large, slow disks.
Putting the block group items in their own root will allow us to densely
populate the tree and dramatically increase mount times in these cases.

The global roots change is motivated by lock contention on the root nodes of
these global roots.  I've had to make many changes to how we run delayed refs to
speed up things like the transaction commit because of all the delayed refs
going into one tree and contending on the root node of the extent tree.  In the
same token you can have heavy lock contention on the csum roots when writing to
many files.  Allowing for multiple roots will let us spread the lock contention
load around.

I have disabled a few key features, namely balance and qgroups.  There will be
more to come as I make more and more invasive changes, and then they will slowly
be re-enabled as the work is added.  These are disabled to avoid a bunch of work
that would be thrown away by future changes.

These patches have passed xfstests without panicing, but clearly failing a lot
of tests because of the disabled features.  I've also run it through fsperf to
validate that there are no major performance regressions.

WARNING: there are many more format changes planned, this is just the first
batch.  If you want to test then please feel free, but know that the format is
still in flux.  Thanks,

Josef

Josef Bacik (22):
  btrfs-progs: common: allow users to select extent-tree-v2 option
  btrfs-progs: add definitions for the block group tree
  btrfs-progs: add on disk pointers to global tree ids
  btrfs-progs: add support for loading the block group root
  btrfs-progs: add print support for the block group tree
  btrfs-progs: mkfs: use the btrfs_block_group_root helper
  btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
  btrfs-progs: handle no bg item in extent tree for free space tree
  btrfs-progs: mkfs: add support for the block group tree
  btrfs-progs: check: add block group tree support
  btrfs-progs: qgroup-verify: scan extents based on block groups
  btrfs-progs: check: make free space tree validation extent tree v2
    aware
  btrfs-progs: check: add helper to reinit the root based on a key
  btrfs-progs: check: handle the block group tree properly
  btrfs-progs: load the number of global roots into the fs_info
  btrfs-progs: handle the per-block group global root id
  btrfs-progs: add a btrfs_delete_and_free_root helper
  btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
  btrfs-progs: make btrfs_create_tree take a key for the root key
  btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
  btrfs-progs: mkfs: create the global root's
  btrfs-progs: check: don't do the root item check for extent tree v2

 check/main.c                    | 233 ++++++++++++++------------
 check/mode-lowmem.c             |  12 +-
 check/qgroup-verify.c           |  32 +++-
 cmds/inspect-dump-tree.c        |  37 ++++-
 common/fsfeatures.c             |  11 ++
 common/repair.c                 |   3 +
 kernel-shared/ctree.h           |  66 +++++++-
 kernel-shared/disk-io.c         | 282 ++++++++++++++++++++++++++------
 kernel-shared/disk-io.h         |  15 +-
 kernel-shared/extent-tree.c     |  25 ++-
 kernel-shared/free-space-tree.c |  72 ++++----
 kernel-shared/print-tree.c      |  26 ++-
 kernel-shared/transaction.c     |   2 +
 libbtrfsutil/btrfs_tree.h       |   3 +
 mkfs/common.c                   |  93 ++++++++---
 mkfs/common.h                   |  12 ++
 mkfs/main.c                     |  94 ++++++++++-
 17 files changed, 779 insertions(+), 239 deletions(-)

-- 
2.26.3


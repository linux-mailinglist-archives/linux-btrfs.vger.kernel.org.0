Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49D4762E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhLOUO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLOUO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:14:57 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E6C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:14:56 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t83so21233206qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82tnboemcLsNJYTPD6CCXDZ7CGAhH2ltjydPbmyfnyY=;
        b=Vrc6gUYBA4ustgQzKk1HiLSlee8bumhAxyuEULlIQ9n5KOb0k1ymoV2HRgN/I9hVEE
         sNJWVjJoVmtaLn8gccsAGeDYnaulU7myDzhoEMIHBhXrg9chWovARQXnWc8QBCJlM9yM
         cQBEHDQjrh29jQqNfsUja/F7QFWAENlOg74XVCRkK0hvW8r6YrZ78mBQi3lHgjCLc38u
         pztzb/+SoimH6mzVw7SEWQ9ACbl7Qaa+ZksaRx4Tk80HWca6nDqaEGX1s7xyvbM0k9sX
         7XLrtTQf88D09ZCWeVJgA35/0SW2H0Y0Io60e9FbbIoonBzzyR0HtfUi1u4U+U6n84Ie
         LX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82tnboemcLsNJYTPD6CCXDZ7CGAhH2ltjydPbmyfnyY=;
        b=wL5VDHMO6UzydhDBLR1jCZDGqun1PJPBb48IkDggguINtGIdXcESQt8bQtQNrzI98F
         NEwhngCJGfrohmd4aB6EZqxJFkiO2EX4r0hWeMOf5zl3lJKi0UQdMsPlgtjLMgczjA8C
         I+pvMTjlIVuVQEIa0P9TUF0epePjRS8qQqzoKiig77lh2RO5r1mn3h13No7h72pIwr5i
         QiJ2AWSIYw9nNnK2rBCmqbkedFBwXwFEl3lAzyU5qHfJW9+RRUa08ikkhDfyPS7M7T8x
         ESBuv95Ngec/eVIPKZsM7PToe/o/Ayf/4G9eKQNva1H3O9HsoEw2bUBwxk5afESxmpsB
         yo3g==
X-Gm-Message-State: AOAM532wHimSdn8MR0XH8SREzrho2gdFcqbCxI7LIoKBMdCJDDaNdl3M
        QAhJJs5PT5CuTvasAEmFjYrBP22ZOpiL2A==
X-Google-Smtp-Source: ABdhPJxS2Im1pG1k6qdeSy6ADpGMDYSQRRTCEsQh/lW0fr9DpiV7fs2UcECXtQ8jBDe0ILd6/+sJJg==
X-Received: by 2002:a05:620a:4495:: with SMTP id x21mr9747580qkp.633.1639599295407;
        Wed, 15 Dec 2021 12:14:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c22sm2192280qtd.76.2021.12.15.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:14:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/15] btrfs-progs: extent tree v2 gc tree and metadata ref changes
Date:   Wed, 15 Dec 2021 15:14:38 -0500
Message-Id: <cover.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
 kernel-shared/disk-io.c          |   5 +
 kernel-shared/extent-tree.c      |  82 ++++++++----
 kernel-shared/free-space-cache.c |   3 +
 kernel-shared/print-tree.c       |   4 +
 mkfs/common.c                    | 207 +++++++++++++++++--------------
 mkfs/main.c                      |  13 +-
 10 files changed, 303 insertions(+), 122 deletions(-)

-- 
2.26.3


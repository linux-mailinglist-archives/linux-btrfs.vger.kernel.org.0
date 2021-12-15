Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C36476396
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhLOUns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:48 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DAC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:47 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j17so23221003qtx.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFNLhS42wSpwjzQIftxR5gK9h0uIETQYy8+6LWkpHIs=;
        b=et7cxlpQeIKG/fCpRtdegBpou66VaT6H91p7kQfGUHNT7jaI00pDURkl6Isr2eznK9
         WyrROVazTtfaiE3m9KwxM4qMteUkERzHgb8rqXZoH+L400g6rfjA1zQfWYBKRvfqEaXT
         5HUqu0uRIeNRwJDxpYG5anmqssqnJUTbmaXURCSILUVlS9BKKJsgXCyRfYDx/LBNGGiR
         D0nzklSXNWziFFjwE/V7iqaKhO6BzlPtSD8FL/qf1Fl9na8xV8N3hLvZEI9ovNplrKUg
         SoHPxqwDKWAHdaFpNDlxwxpLMhk3gb9Bisf+5o8U03Pr0OA7ZKdXlN08d/v8cxPM3nOc
         flxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFNLhS42wSpwjzQIftxR5gK9h0uIETQYy8+6LWkpHIs=;
        b=1G1IO6QyQDd26PQ+WYAo6s6W8r/JV091uqpE2Vh00HPPYwia9zkVqRh2iWgnCxbzmK
         Bj+hp6hPbE5jvfEYK0X5uUBJbwmTNGZfehj0qgx2FyrPXtASpEkozV3B26HOf1/eoo6a
         SRkg5fqYWFJgScOAMbfItcrB133iuRdXwInXL8s+seI46i0hXzRta9TZc+DdlH2tJEQo
         VUWStE3UBP5ZV2abPiRSXCGO4UQ5wY+8/o0qZA2V4/6JIPBnFhKp+tZ4wLrJgw7E1OJz
         hu/wiw+7hsWX1+ALeroBSxsMuk6FbqD8du+UJ/jQJAsutS18RqnULlvgXagmBFAzFTpQ
         2uyg==
X-Gm-Message-State: AOAM533CQScFEwNdR1t/GEOBO7LbhEATbjUdQPEkQq4G4ONR/G3BahY3
        ya4SKJVUClYGS3GxkhXqxfAglo5G4aBdQg==
X-Google-Smtp-Source: ABdhPJw/2ij/Vuh2DlT5YKtwbhZcfViUfgUTT79WKuyUyiQY9Ya/kaWjROdIwKxgyvLPDZ1YtBgPLA==
X-Received: by 2002:ac8:58c9:: with SMTP id u9mr14052932qta.583.1639601026863;
        Wed, 15 Dec 2021 12:43:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q15sm1648421qkj.108.2021.12.15.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9] btrfs: extent-tree-v2, gc and no meta ref counting
Date:   Wed, 15 Dec 2021 15:43:36 -0500
Message-Id: <cover.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (9):
  btrfs: remove BUG_ON(ret) in alloc_reserved_tree_block
  btrfs: add a alloc_reserved_extent helper
  btrfs: remove `last_ref` from the extent freeing code
  btrfs: add a do_free_extent_accounting helper
  btrfs: don't do backref modification for metadata for extent tree v2
  btrfs: add definitions and read support for the garbage collection
    tree
  btrfs: add a btrfs_first_item helper
  btrfs: turn evict_refill_and_join into a real helper
  btrfs: add garbage collection tree support

 fs/btrfs/Makefile               |   2 +-
 fs/btrfs/ctree.c                |  23 ++++
 fs/btrfs/ctree.h                |  11 +-
 fs/btrfs/disk-io.c              |  14 +-
 fs/btrfs/extent-tree.c          | 154 +++++++++++-----------
 fs/btrfs/gc-tree.c              | 223 ++++++++++++++++++++++++++++++++
 fs/btrfs/gc-tree.h              |  15 +++
 fs/btrfs/inode.c                |  65 +++-------
 fs/btrfs/print-tree.c           |   4 +
 fs/btrfs/space-info.c           |   4 +-
 fs/btrfs/transaction.c          |  52 ++++++++
 fs/btrfs/transaction.h          |   2 +
 include/uapi/linux/btrfs_tree.h |   6 +
 13 files changed, 441 insertions(+), 134 deletions(-)
 create mode 100644 fs/btrfs/gc-tree.c
 create mode 100644 fs/btrfs/gc-tree.h

-- 
2.26.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3E47637C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhLOUkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:11 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE7C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:10 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 193so21286851qkh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8gGACu86RU05+krUnGlN2dNOS4UeNfE+bQrYwHFyNU=;
        b=Rhz78XSWq+HF9oKQ/rZ+yUZv/AfnrqLyAq+x9tyIrurT2j4UFb7mRLIuTFSF9cz7Es
         QhYfTyASuMhAVoDqcswmloHDt+NGJMphSa/JjRcG7nNBIlI1/wFFWYQmjOA64Lb+sDuR
         4bSIXMAFuM33oUOQgEMeCwh0bgFFyx/DByvzFlTdqy9nvyrpebJ637GNAkgwXHBU2eSa
         8T6DIhB2aRKKgHF8iGSwmeD1tlH9ff/duJ74rsd07cSmEwSz5yLlOH63nJle0XCxOs/m
         cnbzdPrzywhsq/SowB48p5zg3/WzSwx0t7iKomhttuie8CKQGGiRyALwS1nrQVHATJwU
         y2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8gGACu86RU05+krUnGlN2dNOS4UeNfE+bQrYwHFyNU=;
        b=Xp89SwA7PdxwbxLwiDgwdIk45LxJSnhskW/AkzWK4+IZVcuFwXk2cZs8TLQwAd5Sh7
         IY9W5Yq/yiWC/UUxl1cuHIzBB2xT3TJCHgFAqLijTYjAj6mzS5SMtnPtgTxKql0F8UH8
         nz00Skx4RIa2/vKEGIPEChXbswlgarxahxP/MhgIMNXGYNm2ZIqof/XUna5xR46CzE0R
         i739lVQivXr2mGNzfFUZdJrz52j47nYx+wq94Lz2c7EWr60kPIPUOjtGCY5d0qV/msgI
         cZbGeEfpENNFFz6NTxSlybhxnHCKpx3tp4+oT0Ry/QelMelpJXLhyunYW9Evq8HfURph
         oboQ==
X-Gm-Message-State: AOAM532trbxVHBdIlNouNahwvoQXRmQoRtdtSZxfdCVsd4FQ2IvKFo45
        skZDl6cjN7Ccz0XW5/kX14lzN3NB/ANlVw==
X-Google-Smtp-Source: ABdhPJxO1Wwa/L9o1m7pH6qFv1Aey6OwkGX5dQ23s1Mn5HTBWFdF5PQJ3yNp5UX3WLb/mB1YypYTDA==
X-Received: by 2002:a05:620a:407:: with SMTP id 7mr10269432qkp.506.1639600809575;
        Wed, 15 Dec 2021 12:40:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm1710351qkn.62.2021.12.15.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/11] btrfs: extent tree v2, support for global roots
Date:   Wed, 15 Dec 2021 15:39:57 -0500
Message-Id: <cover.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Disabled some more operations for extent tree v2 that I found were problematic
  in testing.
- Rebased onto a recent misc-next

--- Original email ---
Hello,

This is the kernel side of the global roots and block group root support.  The
motivation for this change is described in the progs patches.  The important
part here is I've disabled qgroups and balance for now, this support will be
added back later.  I've also changed global block rsv size calculation, but it's
exactly the same result for !EXTENT_TREE_V2.  And finally there's the support
for loading the roots.  This doesn't panic and doesn't introduce any performance
regressions.  I've also hidden the support behind CONFIG_BTRFS_DEBUG so it
doesn't get used accidentally.  Thanks,

Josef

Josef Bacik (11):
  btrfs: add definition for EXTENT_TREE_V2
  btrfs: disable balance for extent tree v2 for now
  btrfs: disable device manipulation ioctl's EXTENT_TREE_V2
  btrfs: disable qgroups in extent tree v2
  btrfs: disable scrub for extent-tree-v2
  btrfs: disable snapshot creation/deletion for extent tree v2
  btrfs: disable space cache related mount options for extent tree v2
  btrfs: tree-checker: don't fail on empty extent roots for extent tree
    v2
  btrfs: abstract out loading the tree root
  btrfs: add code to support the block group root
  btrfs: add support for multiple global roots

 fs/btrfs/block-group.c          |  25 ++++-
 fs/btrfs/block-group.h          |   1 +
 fs/btrfs/ctree.h                |  46 ++++++++-
 fs/btrfs/disk-io.c              | 178 +++++++++++++++++++++++---------
 fs/btrfs/disk-io.h              |   2 +
 fs/btrfs/free-space-tree.c      |   2 +
 fs/btrfs/inode.c                |  11 +-
 fs/btrfs/ioctl.c                |  29 ++++++
 fs/btrfs/print-tree.c           |   1 +
 fs/btrfs/qgroup.c               |   6 ++
 fs/btrfs/super.c                |  20 ++++
 fs/btrfs/sysfs.c                |   5 +-
 fs/btrfs/transaction.c          |  15 +++
 fs/btrfs/tree-checker.c         |  35 ++++++-
 fs/btrfs/volumes.c              |  11 ++
 include/trace/events/btrfs.h    |   1 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |   3 +
 18 files changed, 333 insertions(+), 59 deletions(-)

-- 
2.26.3


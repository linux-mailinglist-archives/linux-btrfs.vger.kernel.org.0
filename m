Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC69E476266
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhLOT7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 14:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhLOT7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 14:59:52 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002EC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:51 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v22so23047516qtx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGp96S5BFHtSp4e1A2BVijBAde79wrUqft67KS6qF8w=;
        b=z4KR1kiLOsTtqoOY86zcCDrbQDoUk0/0EQyxP4gUBcwF3injzGkkOwa+TnsXEJvDDi
         sCbxI3uuX59pTSMoONH3zGdYHT3btG3gk2/Q7uol72i6qC0SkwHWqO8c9tgwF5MsX/b4
         nMdncAA0B2qnhk6VDPDTC5LCsg0hAfkGNrj6bsnF7S4bk5y2TopBOsvxWG1Cc2aN7r04
         pER2LAo9ndy4yJ1Eq08BFA0UuykGH7Ep1/zyfxSOxJh+5fWGHlFcGXqU1d80I9i53WWo
         uCjpDWB5QFTWcAfmWxqUmmuaN7lhXt14369Nil/yFgm6XNq9v57J7eA23cA42MPndGvS
         8tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGp96S5BFHtSp4e1A2BVijBAde79wrUqft67KS6qF8w=;
        b=mltatGc1B25pkw4I0y5po/fFAO2oywWWxsuNkLz8Gro+TxgDBEUsoulyCoC9byRxDJ
         4kfntf+fsEqDbFwYWGTvbpnZ6i96SV4OFd8ttFJ3eZXzF9QBGuiyNK3CrsRR6d8jx53l
         d5XfFzmbXRWHyWhnOpg3Nsj+JnbtUuH91diEHsQ6GHUHwiZhfNHT3Y+4AcJMedgS2/XH
         /RLczuKMKna8BQDDhz+ZqnjXjshv1+OL90aMms/kKo0WhIDlOTfHzmD/nalyVpFyMH2D
         Qrl5uzykbGXE94N/FYRaTutPXN6WJ2710j8kMNpg+49bkpwemRcdEjASuYN4gLx/7oiD
         +Ujw==
X-Gm-Message-State: AOAM530sTaOV6i18lR9UMGsozoEEE3UjBuhCVsB6tfDpxrLpTbW0Vjfz
        Wli+CY6AD+0nSRgrQRfh3exDJp0OXKGSIw==
X-Google-Smtp-Source: ABdhPJxBSBZue1EQSd34xR88CBHAKCFU0B0q696gF754Snk0LdNq5wqWOo/w+H28a65efTfFnphpoQ==
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr13914545qtw.52.1639598390549;
        Wed, 15 Dec 2021 11:59:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8sm2300850qtz.28.2021.12.15.11.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:59:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 00/22] btrfs-progs: extent tree v2 support, global roots
Date:   Wed, 15 Dec 2021 14:59:26 -0500
Message-Id: <cover.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- Rebase onto devel, depends on the v3 prep patches that were sent on December
  1st which has the rest of the "don't access ->*_root" patches.
- I think I screwed up the versioning of this, but I lost the other submission,
  so call this v3.

v1->v2:
- These depend on the v3 of the prep patches (it's marked as v2 because I'm
  stupid, but the second v2 posting I sent.)
- I've moved the global root rb tree patches into this series to differentiate
  them from the actual fixes in the prep series.

--- Original email ---
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
 cmds/inspect-dump-tree.c        |  37 +++-
 common/fsfeatures.c             |  11 ++
 common/repair.c                 |   3 +
 kernel-shared/ctree.h           |  66 +++++++-
 kernel-shared/disk-io.c         | 287 ++++++++++++++++++++++++++------
 kernel-shared/disk-io.h         |  15 +-
 kernel-shared/extent-tree.c     |  32 +++-
 kernel-shared/free-space-tree.c |  72 ++++----
 kernel-shared/print-tree.c      |  26 ++-
 kernel-shared/transaction.c     |   2 +
 libbtrfsutil/btrfs_tree.h       |   3 +
 mkfs/common.c                   |  93 ++++++++---
 mkfs/common.h                   |  12 ++
 mkfs/main.c                     |  96 ++++++++++-
 17 files changed, 791 insertions(+), 241 deletions(-)

-- 
2.26.3


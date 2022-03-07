Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBA4D0A91
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiCGWMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiCGWMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:01 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A07563F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:06 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id s16so5019144qks.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGL1vLMTl/sGYozB8JXuMfdSb2CC5G9nhKyEazoK+nk=;
        b=MgF3jOi6vU3oIK/YokbC2R9Mc4yL2VCs7uBPUPEvP0u/CSQYsrvSzysuaG8LSXL8/0
         UDft6qTp/+lQBcgmTUlPApNt7MP7b58yi8gDa0D7j7UmS8wlEh62U2QXtp7DVtzyuNGW
         ityVDBKN/zwZ3cDcJ+w3lQ0mNWaqZJi9rryXKAVCpxnHTssSTaL3qmomQjCMPFCjjAnD
         AoHFB+9QTW2GbsrH2xJLtSF8yV0+cMEQojjS07jWm2cBimWvaCsWWl6AsfOeP/4CTtOy
         KBteHkDXpDppRwYT8Uq/2t2xAxq+oFbX7Gt8Q4XG6ZLnImM+MzDPGblhG1z/zkVJ2uop
         kSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGL1vLMTl/sGYozB8JXuMfdSb2CC5G9nhKyEazoK+nk=;
        b=EQ+m9fTYvh0CUMrxGz8mkBUcHQQzrxnajbx4fa9lR+VE6OUzUlZ2wVdHrsI3o0U5pT
         AtMT7CNeBk7vPsNLZ+oTEhNWRMOAY5aooiJzRFrzmjzS2djEaOqSGqSgJkLoMq/ajRf1
         Tm3AGJh8k/gbC3WQeqDicfDCgzHf7exvYraUQrVoiTO2GYVyPP2jog/CDgQ7ob+dTQaM
         b0Lq51gmQCjRnlI73yEAXI0qeN1Vlpi+aPR62gvysTEkPzev7rJPFobPIEN4AXJD+1SP
         0e8ALhhSRMfgSjBo/qtArZ7sJ7i3ZJey8T2uTQhzcDLA5GbFGLxnix2DiaRmQVHeyJNm
         abcQ==
X-Gm-Message-State: AOAM530JeDDbb8ZE3c3XboUSp9JPHRK43GQXLywGl/aEoJqC770Kf6oR
        t0IzImAPz60dotpKUdtKqpa5qvHnqtoFRSV7
X-Google-Smtp-Source: ABdhPJzCczpIspGPde9+Z97jTkv6f3cYdmBoQrlRloy7WQAZI16MDZ5oiZE6V+MzGn5QlR6Iy9s5WA==
X-Received: by 2002:a05:620a:15e4:b0:613:5610:c311 with SMTP id p4-20020a05620a15e400b006135610c311mr8431976qkm.332.1646691065558;
        Mon, 07 Mar 2022 14:11:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a142400b0067b03a73e70sm3307831qkj.85.2022.03.07.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 00/19] btrfs-progs: extent tree v2 support, global roots
Date:   Mon,  7 Mar 2022 17:10:45 -0500
Message-Id: <cover.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4->v3:
- Rebase onto devel, depends on "btrfs-progs: cleanup btrfs_item* accessors".
- Dropped the various patches that have already been merged into -progs.

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

Josef Bacik (19):
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
  btrfs-progs: set the number of global roots in the super block
  btrfs-progs: handle the per-block group global root id
  btrfs-progs: add a btrfs_delete_and_free_root helper
  btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
  btrfs-progs: make btrfs_create_tree take a key for the root key
  btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
  btrfs-progs: mkfs: create the global root's
  btrfs-progs: check: don't do the root item check for extent tree v2

 check/main.c                    | 233 +++++++++++++++++--------------
 check/mode-lowmem.c             |  12 +-
 check/qgroup-verify.c           |  32 +++--
 cmds/inspect-dump-tree.c        |  30 +++-
 common/repair.c                 |   3 +
 kernel-shared/ctree.h           |   9 +-
 kernel-shared/disk-io.c         | 235 ++++++++++++++++++++++++--------
 kernel-shared/disk-io.h         |  15 +-
 kernel-shared/extent-tree.c     |  32 ++++-
 kernel-shared/free-space-tree.c |  72 +++++-----
 kernel-shared/print-tree.c      |  23 +++-
 kernel-shared/transaction.c     |   2 +
 mkfs/common.c                   |  94 ++++++++++---
 mkfs/common.h                   |  12 ++
 mkfs/main.c                     |  93 ++++++++++++-
 15 files changed, 658 insertions(+), 239 deletions(-)

-- 
2.26.3


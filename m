Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E884F117615
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLITqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so7633805pgk.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B4QuVnQATGIJVYj9B3n4AVxj/PJLxoppbYakulMCTzg=;
        b=uOzQVxho6CQDpee+p1daA9cBln8PKAEAJWLNn/Qnw0khH6LxlzCzpQPl6/8sZG+Eyr
         91kH9sAn5sF5ZDQ6507t3aBAfT9er5Leq/6wqWVKLgWhJl/m23EL+1V1B7U578FQlmFS
         CXJcsLi7QAeMUyjBaaKvg2W4EEgNlFr706EpHL+teRuhxrtJG197ehVK9Lx/xX1vps0d
         2EBE4DSQ6d9RL59KJTjxK9pvPjDm0ngPwnFH+GxzJ/7e+68wZlAML4aqg2vxC6z7YW0c
         1CEhhm24cPCjuKbY94KbhbYWL1zC7JDZfyG/toVMNUAm2ecItPbzUbP6owYmZgCMpEcV
         a3jw==
X-Gm-Message-State: APjAAAWOc7pHPZlIbXfXVB4NuDPdQIgJPscXEKa+6evtZD9NtkZTY9QB
        ix9XjlQR9zXO9zRMZqeyl8E=
X-Google-Smtp-Source: APXvYqy91FW42qldOmyaNQ7DJ7HVkBiaQ5MRHNO+kkSPV2mnhIzA8h/mnC8nrEN90e3Apb3g80AjXw==
X-Received: by 2002:a63:7705:: with SMTP id s5mr20109642pgc.379.1575920770769;
        Mon, 09 Dec 2019 11:46:10 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:10 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v5 00/22] btrfs: async discard support
Date:   Mon,  9 Dec 2019 11:45:45 -0800
Message-Id: <cover.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Dave reported that with async discard enabled, relocation fails [1].
This could be caused by two things. First, if we unpin extents, that
means we haven't fully discarded the block group and need to let async
discard revisit it. Second, relocation removes block_groups outside of
the normal. I fixed both issues and now it successfully passes xfstests
btrfs/003.

Changes in v5:
 - Changed the rules so free space is always added as the right type
   based on discard settings (see btrfs_add_free_space()), this removes
   the need to pass around trim_state in unpin_extent_range().
 - Handled relocation block group deletion (xfstests btrfs/003)
 - When adding to the discard lists, make sure the work queue is active.
   (made all additions go through either btrfs_discard_queue_work() or
   btrfs_discard_check_filter()).
 - Added 10 sec reuse timeout for fully empty block groups.

v4 is available here: [2].

This series is on top of btrfs-devel#misc-next fbc0468e42d2 + [3].

[1] https://lore.kernel.org/linux-btrfs/20191126215204.GP2734@twin.jikos.cz/
[2] https://lore.kernel.org/linux-btrfs/cover.1574709825.git.dennis@kernel.org/
[3] https://lore.kernel.org/linux-btrfs/20191209193846.18162-1-dennis@kernel.org/

Dennis Zhou (22):
  bitmap: genericize percpu bitmap region iterators
  btrfs: rename DISCARD opt to DISCARD_SYNC
  btrfs: keep track of which extents have been discarded
  btrfs: keep track of cleanliness of the bitmap
  btrfs: add the beginning of async discard, discard workqueue
  btrfs: handle empty block_group removal
  btrfs: discard one region at a time in async discard
  btrfs: add removal calls for sysfs debug/
  btrfs: make UUID/debug have its own kobject
  btrfs: add discard sysfs directory
  btrfs: track discardable extents for async discard
  btrfs: keep track of discardable_bytes
  btrfs: calculate discard delay based on number of extents
  btrfs: add bps discard rate limit
  btrfs: limit max discard size for async discard
  btrfs: make max async discard size tunable
  btrfs: have multiple discard lists
  btrfs: only keep track of data extents for async discard
  btrfs: keep track of discard reuse stats
  btrfs: add async discard header
  btrfs: increase the metadata allowance for the free_space_cache
  btrfs: make smaller extents more likely to go into bitmaps

 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/block-group.c      |  88 ++++-
 fs/btrfs/block-group.h      |  30 ++
 fs/btrfs/ctree.h            |  52 ++-
 fs/btrfs/discard.c          | 684 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  42 +++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |   8 +-
 fs/btrfs/free-space-cache.c | 611 +++++++++++++++++++++++++++-----
 fs/btrfs/free-space-cache.h |  41 ++-
 fs/btrfs/inode-map.c        |  13 +-
 fs/btrfs/inode.c            |   2 +-
 fs/btrfs/scrub.c            |   7 +-
 fs/btrfs/super.c            |  39 +-
 fs/btrfs/sysfs.c            | 205 ++++++++++-
 fs/btrfs/volumes.c          |   7 +
 include/linux/bitmap.h      |  35 ++
 mm/percpu.c                 |  61 +---
 18 files changed, 1789 insertions(+), 153 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h

-- 
2.17.1


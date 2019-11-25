Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6710945E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKYTrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:08 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38769 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYTrI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:08 -0500
Received: by mail-qv1-f66.google.com with SMTP id q19so6271207qvs.5
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I3VP/0OOCj23zTlmmD6DVNnT3pNYiMne8JUu9Pu+mYs=;
        b=PHilecmmwcHEZD2yHsw2UxBfyfpVyUa0cHwUzfJHPec7xgXKkYGiADYeTumgFbO85e
         7viHeEj9XTPBM9BOzMXWJD6xvrYOHziR+jQFcVcvye6LH+4krSSCfZJzu4zUKZ4OI5pC
         OhcivAOawGpSqIhXwXUOU7ts9x0Tsjg9XSSL+IvmiTibKAJL2D8gJDuZH+4OsquapBdm
         H4U8MQikGtjeEiZiATU+AIlPH3/M5OmUmTh6Tn30XYpE5zStrM/qfZWf2U9ZgNWAXD4H
         8Qfy5emZ/ajMV+XW8Jpj/RgBsTjY0niG691RrMet/qOS2SPoydUz/iaUNMldEsdVBBvf
         jKTw==
X-Gm-Message-State: APjAAAVyv3FabEENRoIBqdtssqGCOHP0jv8WE/0PHE12eKZO5Pwwm6ST
        XiMpHVRCsclvVJu+Tdltynw=
X-Google-Smtp-Source: APXvYqwjjzSzk3XTBES/dgu0Uiucw7ayRq4SknbJSIAizHtVztRQpKbLop6ImYqdlvoOO5H5CVxzvQ==
X-Received: by 2002:ad4:462d:: with SMTP id x13mr29354314qvv.105.1574711226994;
        Mon, 25 Nov 2019 11:47:06 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:06 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v4 00/22] btrfs: async discard support
Date:   Mon, 25 Nov 2019 14:46:40 -0500
Message-Id: <cover.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

v3 [1] had 2 minor issues which are fixed:
 - I was generically dividing u64 which made 32 bit arches unhappy. [2]
 - Uninitialized use of trim_state local variable [3]

I've gone through and fixed the apparent u64 divisions which passes the
make.cross build provided on the end of the series.

This is based on btrfs-devel#misc-next e88411ecf657.

[1] https://lore.kernel.org/linux-btrfs/cover.1574282259.git.dennis@kernel.org/
[2] https://lore.kernel.org/linux-btrfs/201911230623.j5g9qeNZ%25lkp@intel.com/
[3] https://lore.kernel.org/linux-btrfs/CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com/

diffstats below:

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
 fs/btrfs/block-group.c      |  56 ++-
 fs/btrfs/block-group.h      |  30 ++
 fs/btrfs/ctree.h            |  52 ++-
 fs/btrfs/discard.c          | 680 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/discard.h          |  46 +++
 fs/btrfs/disk-io.c          |  15 +-
 fs/btrfs/extent-tree.c      |  23 +-
 fs/btrfs/free-space-cache.c | 587 ++++++++++++++++++++++++++-----
 fs/btrfs/free-space-cache.h |  39 ++-
 fs/btrfs/inode-map.c        |  13 +-
 fs/btrfs/scrub.c            |   7 +-
 fs/btrfs/super.c            |  39 ++-
 fs/btrfs/sysfs.c            | 205 ++++++++++-
 include/linux/bitmap.h      |  35 ++
 mm/percpu.c                 |  61 +---
 16 files changed, 1737 insertions(+), 153 deletions(-)
 create mode 100644 fs/btrfs/discard.c
 create mode 100644 fs/btrfs/discard.h

Thanks,
Dennis

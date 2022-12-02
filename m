Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27069640A92
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 17:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiLBQZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 11:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiLBQZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 11:25:13 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7BD824C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 08:23:34 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so5830436qts.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKPCqH4mGcU7aSClrx1/KGvoEIA7rauIPsXoy9l/B+Q=;
        b=B8MH4LTdx7hIR+ny0BpMsyPbEt0uAJxd7kuY+nRz+47FHA9Nouya65QZTHPntQFaRs
         68uItvm2jMOiPGWDVggF/ccPWW7pBlFj9vmOU8jf5cOHvoWLOexmpKN9luQSJAD2ypei
         2pG0kpPG+N81GwpzmIWokCO5t7USi+9HS960W63cUhz3J7R92YLbGhjx7+N0K0RfGioy
         r4Rr0ZA1uTKAUuR8IU714ff0fkbeqdyuwgaibxLEZuue7JgllhtxsrTdewPYj5swotUY
         H+7Un3aDKvZOdFX/OpjboQeYq99Nn9fhdur5rsgYIF5fMvJSiVeIRZfQKn++2tq+x16f
         DSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKPCqH4mGcU7aSClrx1/KGvoEIA7rauIPsXoy9l/B+Q=;
        b=VUQIeCzBzIXsrzP0IkTsyrie0XkEG7jnAJhOShFH2qQRzgHYaCD87qhKmvsWCgIpBi
         UkOsFOhy7BLAblMjRFdgdC8n4gqIJL5LJsj5JwlcGcHosDXi5xf08SNL2lbqKLHZDAQv
         Ba+4dPMokaCSGNB098R71k0eUpN1X6xxzscMAva5t2InpEgV1q8Km4AroDz2ozfb08zy
         u6PCHr+Q+fAOTtQTzK5wTjccgyuN1XfiI5Gsfxv85Bi55lK1tikaKPSYPVarVceOHEpX
         bM4pEYTQtzR0J7FvOtzGlHVJEZ3tsVAMsFtOObzeniDh/NCsQn43kvL9ivm2dAghZKzw
         CJsQ==
X-Gm-Message-State: ANoB5pl8w4TXIxWH/AsKPM6sTHvJUmziorxrDKt119xY8FaMXwtsT4Dl
        O8MD3nPS6sfNDfi3gdtraKPt/h6gS8UorRPq
X-Google-Smtp-Source: AA0mqf7Noc22HtwQxhPh73uP7QjRWjrgnoFLwp7tWXYJVOUImSVjhPlIYEa8ceVcYjsa/FXgS8gyxg==
X-Received: by 2002:ac8:4514:0:b0:3a6:95ff:4946 with SMTP id q20-20020ac84514000000b003a695ff4946mr5301723qtn.136.1669998213433;
        Fri, 02 Dec 2022 08:23:33 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id az15-20020a05620a170f00b006ce1bfbd603sm5626249qkb.124.2022.12.02.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:23:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 00/10] prep and initial sync of kernel code
Date:   Fri,  2 Dec 2022 11:23:22 -0500
Message-Id: <cover.1669998153.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
 - Rebased onto devel and dropped all the prep patches that have been merged.
 - Sync'ed some of the ioctl.h changes into btrfs.h in the kernel, and then
   synced the result into btrfs-progs.

v2->v3:
 - A bunch of new prep patches to enable extent-io-tree.c to be sync'ed.
 - make clean wasn't actually cleaning convert properly, which resulted in some
   compile errors that I also fixed.
 - Made a copy of ioctl.h in libbtrfs for snapper, made sure that code used that
   version of ioctl.h instead of btrfs.h.
 - Sync'ed file-item.h, async-thread.[ch] and extent-io-tree.[ch] as well.

v1->v2:
 - Updated a couple other qgroup helpers that I missed.
 - Added a macro for KERN_WARNING that I missed.
 - A couple of cleanups to enable accessors.[ch] to be sync'ed easier.
 - Sync'ing accessors.[ch] as well.

--- Original email ----
Hello,

In order to make my extent tree v2 work easier I need to sync the kernel code
into btrfs-progs.  We haven't done this in a while, and really I want to move
towards doing this every release.  Unfortunately because we haven't done this in
a while it's going to be a little messy.  This is the first patch of patches,
which is mostly prep work, and then syncing the easiest parts of the kernel that
I could manage.

I've almost got accessors.[ch] done, however it requires doing some cleanups and
moving around in the kernel to make it smooth and easy, and I wasn't able to get
those done fast enough this week.

I've taken the approach of marking functions that I have to change things with

/*
 * MODIFIED:
 *  - List of things I changed.
 */

Some of these I did because btrfs-progs simply does things differently.  Some of
these were done because they have dependencies from other things in the kernel
sources, and it was simpler to just change it for now, get everything sync'ed,
and then go back and clean things up after the fact.

I've tried to make this as painless as possible, but it's just a painful
operation.  That being said if I've done something in a way that is confusing
or just too complicated please point it out to me and I can try alternative
strategies.  Thanks,

Josef

Josef Bacik (10):
  btrfs-progs: sync uapi/btrfs.h into btrfs-progs
  btrfs-progs: make the find extent buffer helpers take fs_info
  btrfs-progs: move extent cache code directly into btrfs_fs_info
  btrfs-progs: sync ondisk definitions from the kernel
  btrfs-progs: sync compression.h from the kernel
  btrfs-progs: sync messages.* from the kernel
  btrfs-progs: sync accessors.[ch] from the kernel
  btrfs-progs: sync file-item.h into progs
  btrfs-progs: sync async-thread.[ch] from the kernel
  btrfs-progs: sync extent-io-tree.[ch] and misc.h from the kernel

 Makefile                              |    4 +
 btrfs-corrupt-block.c                 |    4 +-
 btrfs-fragments.c                     |    2 +-
 btrfstune.c                           |    4 +-
 check/clear-cache.c                   |   16 +-
 check/common.h                        |    2 +-
 check/main.c                          |   35 +-
 check/mode-common.c                   |   20 +-
 check/mode-lowmem.c                   |   12 +-
 check/repair.c                        |   16 +-
 cmds/balance.c                        |    2 +-
 cmds/device.c                         |    2 +-
 cmds/filesystem-du.c                  |    1 +
 cmds/filesystem-usage.c               |    1 +
 cmds/filesystem-usage.h               |    2 +-
 cmds/filesystem.c                     |    2 +-
 cmds/inspect-tree-stats.c             |    1 +
 cmds/inspect.c                        |    2 +-
 cmds/property.c                       |    2 +-
 cmds/qgroup.c                         |    3 +-
 cmds/qgroup.h                         |    2 +-
 cmds/quota.c                          |    2 +-
 cmds/receive.c                        |    2 +-
 cmds/replace.c                        |    3 +-
 cmds/rescue-chunk-recover.c           |    5 +-
 cmds/rescue.c                         |    1 +
 cmds/restore.c                        |    3 +-
 cmds/scrub.c                          |    2 +-
 cmds/send.c                           |    2 +-
 cmds/subvolume-list.c                 |    3 +-
 cmds/subvolume.c                      |    2 +-
 common/device-scan.c                  |    2 +-
 common/device-scan.h                  |    2 +-
 common/fsfeatures.c                   |    2 +-
 common/internal.h                     |    4 +
 common/send-stream.c                  |    2 +-
 common/send-utils.c                   |    2 +-
 common/units.c                        |    1 +
 common/utils.c                        |    2 +-
 common/utils.h                        |    2 +-
 convert/common.c                      |    3 +-
 convert/main.c                        |    2 +
 convert/source-ext2.c                 |    2 +
 image/main.c                          |   13 +-
 kerncompat.h                          |  285 +++-
 kernel-lib/bitops.h                   |   12 +
 kernel-lib/trace.h                    |   55 +
 kernel-shared/accessors.c             |  117 ++
 kernel-shared/accessors.h             | 1087 ++++++++++++++
 kernel-shared/async-thread.c          |  339 +++++
 kernel-shared/async-thread.h          |   46 +
 kernel-shared/backref.c               |    1 +
 kernel-shared/ctree.h                 | 1885 +------------------------
 kernel-shared/delayed-ref.c           |    1 +
 kernel-shared/dir-item.c              |    8 +-
 kernel-shared/disk-io.c               |   16 +-
 kernel-shared/extent-io-tree.c        | 1733 +++++++++++++++++++++++
 kernel-shared/extent-io-tree.h        |  239 ++++
 kernel-shared/extent-tree.c           |   52 +-
 kernel-shared/extent_io.c             |  474 +------
 kernel-shared/extent_io.h             |   39 +-
 kernel-shared/file-item.c             |   13 +-
 kernel-shared/file-item.h             |   89 ++
 kernel-shared/file.c                  |    1 +
 kernel-shared/free-space-tree.c       |    1 +
 kernel-shared/inode.c                 |    2 +-
 kernel-shared/messages.c              |  372 +++++
 kernel-shared/messages.h              |  253 ++++
 kernel-shared/misc.h                  |  143 ++
 kernel-shared/print-tree.c            |   17 +-
 kernel-shared/transaction.c           |   10 +-
 kernel-shared/transaction.h           |    1 -
 ioctl.h => kernel-shared/uapi/btrfs.h |  564 +++++---
 kernel-shared/uapi/btrfs_tree.h       | 1259 +++++++++++++++++
 kernel-shared/ulist.c                 |    1 +
 kernel-shared/zoned.h                 |    1 +
 libbtrfs/ctree.h                      |   15 +
 mkfs/common.c                         |    3 +-
 mkfs/main.c                           |    1 +
 mkfs/rootdir.c                        |    1 +
 tests/ioctl-test.c                    |    2 +-
 tests/library-test.c                  |    2 +-
 82 files changed, 6577 insertions(+), 2762 deletions(-)
 create mode 100644 kernel-lib/trace.h
 create mode 100644 kernel-shared/accessors.c
 create mode 100644 kernel-shared/accessors.h
 create mode 100644 kernel-shared/async-thread.c
 create mode 100644 kernel-shared/async-thread.h
 create mode 100644 kernel-shared/extent-io-tree.c
 create mode 100644 kernel-shared/extent-io-tree.h
 create mode 100644 kernel-shared/file-item.h
 create mode 100644 kernel-shared/messages.c
 create mode 100644 kernel-shared/messages.h
 create mode 100644 kernel-shared/misc.h
 rename ioctl.h => kernel-shared/uapi/btrfs.h (71%)
 create mode 100644 kernel-shared/uapi/btrfs_tree.h

-- 
2.26.3


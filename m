Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E132C636D48
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiKWWiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiKWWhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:48 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420C18359
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:40 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s4so133710qtx.6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=89ZsGjqHSZSGNLj/XEwMyCZXWr1mT31UTWSHRjW5BfU=;
        b=M7LyzLfP6OXN++sFGSmGIKklNafoSLHKKsAcl0ZxTJeq7BWabnDcfoejpZNewyokMF
         BGQdVt70Fje3tWmAes75bDKJT3qxc51KPf0GTvYRT13FshVYzz2L/epujtZDxD78GngI
         dRSBHe0FgkydCq2t8iIeRgfnzzfNE+JX8H/6pzSXtybax4KzJRe5xR1k1H5xnw3ySzoO
         N6hu5RAZW+K0SZysWtsp08y9xhO0OkjCREdYIl5ASXFm2GnlHl7Z2KA1DVwQnBeOgXlb
         +W0NJQqWMyygNk7L0f2mSXX6c9rZTvfBjcJ/L6FmX9I0pRyFf//tqYiKlCO6UznEtmCP
         QLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89ZsGjqHSZSGNLj/XEwMyCZXWr1mT31UTWSHRjW5BfU=;
        b=3me7KrrJjXL3DUrQgik+02t3vLvikO2Xt5/ZE7HJ/txinfOA4yKccQDwp39uxxodVH
         7d2TnGJNaTqLLPo7zpSubqFntXvGbdRPDX0mFPkvPP7wa0cvOUwV+VgQEeR1ZzvA/Hfu
         KPxXLNNPDILRvyeTj+OQZIZU8SnKbdx1r9bXhcjc1JlLpwu2mqJw3I/4tVhjHc+QQc0P
         DbMr9UQu9zJO8eWPkresZRvdBYwx4MVj5nVDgi8iLkt5n91JRO5w1pQbmx0kw/Z4EIMG
         yDrQ4Vv530/Uyv3ynvAMGtn/DFg/cIlk3//7maV1q7QngD5EB5CFMlPjZ3z7v2OHA8vn
         SjcQ==
X-Gm-Message-State: ANoB5pmYMegcNkecLnEQU/P91s8RVon8Gb9c5P/ZwaWsoCopeeo5YyyI
        ch/Yyj0MxiMc5rfuRFaMqlaNAMxF0q7uGg==
X-Google-Smtp-Source: AA0mqf7NAViLIFRxSNkssYZL4JFPlBq/l+YkcUVhrI28zK1Pcv5hlFYnTha5Cjger/WJPl1zy5SkbA==
X-Received: by 2002:a05:622a:18aa:b0:3a5:1acc:3760 with SMTP id v42-20020a05622a18aa00b003a51acc3760mr11058313qtc.260.1669243058802;
        Wed, 23 Nov 2022 14:37:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id v9-20020ac873c9000000b003a54a19c550sm10272809qtp.57.2022.11.23.14.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 00/29] prep and initial sync of kernel code
Date:   Wed, 23 Nov 2022 17:37:08 -0500
Message-Id: <cover.1669242804.git.josef@toxicpanda.com>
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

Josef Bacik (29):
  btrfs-progs: turn on more compiler warnings and use -Wall
  btrfs-progs: fix make clean to clean convert properly
  btrfs-progs: properly test for send_stream_version
  btrfs-progs: use -std=gnu11
  btrfs-progs: move btrfs_err_str into common/utils.h
  btrfs-progs: rename qgroup items to match the kernel naming scheme
  btrfs-progs: make btrfs_qgroup_level helper match the kernel
  btrfs-progs: move NO_RESULT definition into replace.c
  btrfs-progs: rename BLOCK_* to IMAGE_BLOCK_* for metadump
  btrfs-progs: rename btrfs_item_end to btrfs_item_data_end
  btrfs-progs: copy ioctl.h into libbtrfs
  btrfs-progs: sync uapi/btrfs.h into btrfs-progs
  btrfs-progs: stop using btrfs_root_item_v0
  btrfs-progs: make the find extent buffer helpers take fs_info
  btrfs-progs: move dirty eb tracking to it's own io_tree
  btrfs-progs: do not pass io_tree into verify_parent_transid
  btrfs-progs: move extent cache code directly into btrfs_fs_info
  btrfs-progs: delete state_private code
  btrfs-progs: rename extent buffer flags to EXTENT_BUFFER_*
  btrfs-progs: sync ondisk definitions from the kernel
  btrfs-progs: sync compression.h from the kernel
  btrfs-progs: sync messages.* from the kernel
  btrfs-progs: replace btrfs_leaf_data with btrfs_item_nr_offset
  btrfs-progs: don't use btrfs_header_csum helper
  btrfs-progs: make write_extent_buffer take a const eb
  btrfs-progs: sync accessors.[ch] from the kernel
  btrfs-progs: sync file-item.h into progs
  btrfs-progs: sync async-thread.[ch] from the kernel
  btrfs-progs: sync extent-io-tree.[ch] and misc.h from the kernel

 Makefile                                      |   13 +-
 btrfs-corrupt-block.c                         |    8 +-
 btrfs-fragments.c                             |    2 +-
 btrfstune.c                                   |    4 +-
 check/clear-cache.c                           |   16 +-
 check/common.h                                |    2 +-
 check/main.c                                  |   53 +-
 check/mode-common.c                           |   21 +-
 check/mode-lowmem.c                           |   15 +-
 check/qgroup-verify.c                         |   66 +-
 check/repair.c                                |   16 +-
 cmds/balance.c                                |    2 +-
 cmds/device.c                                 |    2 +-
 cmds/filesystem-du.c                          |    1 +
 cmds/filesystem-usage.c                       |    1 +
 cmds/filesystem-usage.h                       |    2 +-
 cmds/filesystem.c                             |    3 +-
 cmds/inspect-tree-stats.c                     |    1 +
 cmds/inspect.c                                |    2 +-
 cmds/property.c                               |    2 +-
 cmds/qgroup.c                                 |   76 +-
 cmds/qgroup.h                                 |   10 +-
 cmds/quota.c                                  |    2 +-
 cmds/receive.c                                |    2 +-
 cmds/replace.c                                |    5 +-
 cmds/rescue-chunk-recover.c                   |    8 +-
 cmds/rescue.c                                 |    1 +
 cmds/restore.c                                |    6 +-
 cmds/scrub.c                                  |    2 +-
 cmds/send.c                                   |    2 +-
 cmds/subvolume-list.c                         |    7 +-
 cmds/subvolume.c                              |   14 +-
 common/device-scan.c                          |    2 +-
 common/device-scan.h                          |    2 +-
 common/fsfeatures.c                           |    2 +-
 common/internal.h                             |    4 +
 common/parse-utils.c                          |    1 +
 common/send-stream.c                          |    2 +-
 common/send-utils.c                           |    2 +-
 common/units.c                                |    1 +
 common/utils.c                                |    2 +-
 common/utils.h                                |   34 +-
 convert/common.c                              |    3 +-
 convert/main.c                                |    2 +
 convert/source-ext2.c                         |    2 +
 image/main.c                                  |   63 +-
 image/metadump.h                              |    6 +-
 kerncompat.h                                  |  300 ++-
 kernel-lib/bitops.h                           |   12 +
 kernel-lib/trace.h                            |   55 +
 kernel-shared/accessors.c                     |  117 +
 kernel-shared/accessors.h                     | 1087 ++++++++++
 kernel-shared/async-thread.c                  |  339 +++
 kernel-shared/async-thread.h                  |   46 +
 kernel-shared/backref.c                       |    1 +
 kernel-shared/compression.h                   |  184 ++
 kernel-shared/ctree.c                         |   64 +-
 kernel-shared/ctree.h                         | 1902 +----------------
 kernel-shared/delayed-ref.c                   |    1 +
 kernel-shared/dir-item.c                      |    8 +-
 kernel-shared/disk-io.c                       |   34 +-
 kernel-shared/extent-io-tree.c                | 1733 +++++++++++++++
 kernel-shared/extent-io-tree.h                |  239 +++
 kernel-shared/extent-tree.c                   |   52 +-
 kernel-shared/extent_io.c                     |  570 +----
 kernel-shared/extent_io.h                     |   62 +-
 kernel-shared/file-item.c                     |   13 +-
 kernel-shared/file-item.h                     |   89 +
 kernel-shared/file.c                          |    2 +
 kernel-shared/free-space-tree.c               |    1 +
 kernel-shared/inode.c                         |    2 +-
 kernel-shared/messages.c                      |  372 ++++
 kernel-shared/messages.h                      |  253 +++
 kernel-shared/misc.h                          |  143 ++
 kernel-shared/print-tree.c                    |   40 +-
 kernel-shared/transaction.c                   |   16 +-
 kernel-shared/transaction.h                   |    1 -
 kernel-shared/uapi/btrfs.h                    | 1148 ++++++++++
 kernel-shared/uapi/btrfs_tree.h               | 1259 +++++++++++
 kernel-shared/ulist.c                         |    1 +
 kernel-shared/zoned.h                         |    1 +
 libbtrfs/ctree.h                              |   19 +-
 ioctl.h => libbtrfs/ioctl.h                   |   41 +-
 libbtrfs/send-utils.c                         |    2 +-
 libbtrfsutil/btrfs_tree.h                     |    2 +-
 mkfs/common.c                                 |    3 +-
 mkfs/main.c                                   |    1 +
 mkfs/rootdir.c                                |    1 +
 tests/ioctl-test.c                            |    2 +-
 tests/library-test.c                          |    2 +-
 .../053-receive-write-encoded/test.sh         |    2 +-
 91 files changed, 7884 insertions(+), 2833 deletions(-)
 create mode 100644 kernel-lib/trace.h
 create mode 100644 kernel-shared/accessors.c
 create mode 100644 kernel-shared/accessors.h
 create mode 100644 kernel-shared/async-thread.c
 create mode 100644 kernel-shared/async-thread.h
 create mode 100644 kernel-shared/compression.h
 create mode 100644 kernel-shared/extent-io-tree.c
 create mode 100644 kernel-shared/extent-io-tree.h
 create mode 100644 kernel-shared/file-item.h
 create mode 100644 kernel-shared/messages.c
 create mode 100644 kernel-shared/messages.h
 create mode 100644 kernel-shared/misc.h
 create mode 100644 kernel-shared/uapi/btrfs.h
 create mode 100644 kernel-shared/uapi/btrfs_tree.h
 rename ioctl.h => libbtrfs/ioctl.h (96%)

-- 
2.26.3


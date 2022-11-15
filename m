Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B565629D84
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiKOPcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKOPbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:36 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7192E6A1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:30 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id fz10so8909405qtb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkJye/8FFSLOHFRE8CsyY5LEBsxuiAzg1qguIzjRLpA=;
        b=emvFwQgFbdHlcqy/ufq3/v1IVLagwTCZDT6Z3Jt376B4iXSs7mdggcBJF0Jl8OcAJ0
         +BENrvV0w6W62F+SsI0RsW8W4pFqUdyIi0HDkZPF8UQLzaNSnptB3w434G0GQ4l6deyx
         6nJm0a7I34A5vlIbGVaSJKLJBvGCAKaj/70Ht09E24T/XJFMuV15ywuKYsrQDC7EKne/
         QMZz4evogNlNY0xD6EN0BGbUdEnTq4ZX2Jy4aEGq6LJ/kWRxNPqv5dFk0k7zBgnh39yj
         kWRWkQOz07iehu9RC45k0rMO9FUSsuBvWQ81kO3b9hd7rtkr9yj6XQxKkGPh2pqmhbp0
         3IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkJye/8FFSLOHFRE8CsyY5LEBsxuiAzg1qguIzjRLpA=;
        b=6Rft/5JgqYJcTaJJkdFnc8/HYuAqw/YTTBP7lPSSV52yf6fQaDp/H9On09exwGp7oV
         ZOOdHmOtV7IuC4U/NGp7TreSixDO1NZFvdkBjBPY0j2TBNpGtFt2A2bcvK4OMUabLaK9
         NyNkGdJJzF4ZpxIsxjLJD3RCypLzXDcae+8VhJne1s3YTYuwRgcYJpxcuH5njmOfBrFR
         o78vnJicMBnc1nxPd6QRU6aJ3h4thzfrtZkua2iZVIk7x90FF2h+mJgc3V1z6mtOqyPq
         oIWxhjrJnNli+L8yapxoEMgxO5W8NWxmkBNd84v6P4xAVzQlK6UK3P7iMmIpA0cbrRjD
         CwgA==
X-Gm-Message-State: ANoB5pl1RuYsipYbj9aIk0ipvthJqi+l+ctc36eghO/qlXXIJQDh5Miu
        h5DGkObDN2GZso04GeaFimefigKUSoQ3nA==
X-Google-Smtp-Source: AA0mqf5EH6ZM7E3hujJZ3fvu0Zqr/oScwI0jUs5fX4vgIXoUOzRcgobgMIU0iySc63uZrSHrmP05fg==
X-Received: by 2002:ac8:1001:0:b0:3a5:26e0:f60a with SMTP id z1-20020ac81001000000b003a526e0f60amr16693842qti.372.1668526288717;
        Tue, 15 Nov 2022 07:31:28 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s207-20020a37a9d8000000b006ce2c3c48ebsm8280889qke.77.2022.11.15.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/18] btrfs-progs: prep and initial sync of kernel code
Date:   Tue, 15 Nov 2022 10:31:09 -0500
Message-Id: <cover.1668526161.git.josef@toxicpanda.com>
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

Josef Bacik (18):
  btrfs-progs: turn on more compiler warnings and use -Wall
  btrfs-progs: properly test for send_stream_version
  btrfs-progs: use -std=gnu11
  btrfs-progs: move btrfs_err_str into common/utils.h
  btrfs-progs: rename qgroup items to match the kernel naming scheme
  btrfs-progs: make btrfs_qgroup_level helper match the kernel
  btrfs-progs: move NO_RESULT definition into replace.c
  btrfs-progs: rename BLOCK_* to IMAGE_BLOCK_* for metadump
  btrfs-progs: rename btrfs_item_end to btrfs_item_data_end
  btrfs-progs: sync uapi/btrfs.h into btrfs-progs
  btrfs: stop using btrfs_root_item_v0
  btrfs-progs: sync ondisk definitions from the kernel
  btrfs-progs: sync compression.h from the kernel
  btrfs-progs: sync messages.* from the kernel
  btrfs-progs: replace btrfs_leaf_data with btrfs_item_nr_offset
  btrfs-progs: don't use btrfs_header_csum helper
  btrfs-progs: make write_extent_buffer take a const eb
  btrfs-progs: sync accessors.[ch] from the kernel

 Makefile                                      |    7 +-
 btrfs-corrupt-block.c                         |    5 +-
 btrfs-fragments.c                             |    2 +-
 btrfstune.c                                   |    3 +-
 check/clear-cache.c                           |    1 +
 check/main.c                                  |   23 +-
 check/mode-common.c                           |    6 +-
 check/mode-lowmem.c                           |    8 +-
 check/qgroup-verify.c                         |   66 +-
 cmds/balance.c                                |    2 +-
 cmds/device.c                                 |    2 +-
 cmds/filesystem-du.c                          |    1 +
 cmds/filesystem-usage.c                       |    1 +
 cmds/filesystem-usage.h                       |    2 +-
 cmds/filesystem.c                             |    3 +-
 cmds/inspect.c                                |    2 +-
 cmds/property.c                               |    2 +-
 cmds/qgroup.c                                 |   76 +-
 cmds/qgroup.h                                 |   10 +-
 cmds/quota.c                                  |    2 +-
 cmds/receive.c                                |    2 +-
 cmds/replace.c                                |    5 +-
 cmds/rescue-chunk-recover.c                   |    6 +-
 cmds/rescue.c                                 |    1 +
 cmds/restore.c                                |    5 +-
 cmds/scrub.c                                  |    2 +-
 cmds/send.c                                   |    2 +-
 cmds/subvolume-list.c                         |    7 +-
 cmds/subvolume.c                              |   14 +-
 common/device-scan.c                          |    2 +-
 common/device-scan.h                          |    2 +-
 common/fsfeatures.c                           |    2 +-
 common/parse-utils.c                          |    1 +
 common/send-stream.c                          |    2 +-
 common/send-utils.c                           |    2 +-
 common/units.c                                |    1 +
 common/utils.c                                |    2 +-
 common/utils.h                                |   34 +-
 convert/common.c                              |    3 +-
 convert/source-ext2.c                         |    1 +
 image/main.c                                  |   53 +-
 image/metadump.h                              |    6 +-
 kerncompat.h                                  |   69 +-
 kernel-shared/accessors.c                     |  117 ++
 kernel-shared/accessors.h                     | 1087 ++++++++++
 kernel-shared/backref.c                       |    1 +
 kernel-shared/compression.h                   |  184 ++
 kernel-shared/ctree.c                         |   62 +-
 kernel-shared/ctree.h                         | 1849 +----------------
 kernel-shared/delayed-ref.c                   |    1 +
 kernel-shared/dir-item.c                      |    8 +-
 kernel-shared/extent_io.c                     |    5 +-
 kernel-shared/extent_io.h                     |    2 +-
 kernel-shared/file.c                          |    1 +
 kernel-shared/free-space-tree.c               |    1 +
 kernel-shared/inode.c                         |    2 +-
 kernel-shared/messages.c                      |  372 ++++
 kernel-shared/messages.h                      |  253 +++
 kernel-shared/print-tree.c                    |   39 +-
 kernel-shared/transaction.c                   |    5 -
 kernel-shared/transaction.h                   |    1 -
 ioctl.h => kernel-shared/uapi/btrfs.h         |  644 +++---
 kernel-shared/uapi/btrfs_tree.h               | 1259 +++++++++++
 kernel-shared/ulist.c                         |    1 +
 kernel-shared/zoned.h                         |    1 +
 libbtrfs/ctree.h                              |   19 +-
 libbtrfs/send-utils.c                         |    2 +-
 libbtrfsutil/btrfs_tree.h                     |    2 +-
 mkfs/common.c                                 |    3 +-
 mkfs/main.c                                   |    1 +
 tests/ioctl-test.c                            |    2 +-
 tests/library-test.c                          |    2 +-
 .../053-receive-write-encoded/test.sh         |    2 +-
 73 files changed, 3984 insertions(+), 2392 deletions(-)
 create mode 100644 kernel-shared/accessors.c
 create mode 100644 kernel-shared/accessors.h
 create mode 100644 kernel-shared/compression.h
 create mode 100644 kernel-shared/messages.c
 create mode 100644 kernel-shared/messages.h
 rename ioctl.h => kernel-shared/uapi/btrfs.h (70%)
 create mode 100644 kernel-shared/uapi/btrfs_tree.h

-- 
2.26.3


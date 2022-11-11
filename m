Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2562639D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKKVaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKKVaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:19 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DFE00E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d8so540887qki.13
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xKO2TIslJdomN9te0ttyw8iuJaJMEwRF4WZLzfLfl8=;
        b=VyLekSQkfBrc0c0W8WQ2Oo04Njy7fTPzS0eK5GLv7Ctam3Mg7A6tka5dT4yeoPypUQ
         1rNmKSxf3BiiL/zy9jGE0y80nZQV8WMTB93kYdR79ynlOZOnsOBw4IvK416aNMI0PE/D
         R9Jc6cKqIlKnHR2jNzNSJIyIw4BgFWENaKgmpOyQPo0t04iJinx9C4lrWkgVVEOB2zb4
         59PIYLTV+RixKNkHGq/EgZdQdsnOnpJSZELDlRYOe+eH7aO0GkX1C6SGPTeLV1CodUBa
         ma9blH1kHw5QOuQjoqhm9eKFcw2mzx2VAsGYYTrXXdAr/0fWu5q3Fxtd+b1Pdk2GcxPe
         qFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xKO2TIslJdomN9te0ttyw8iuJaJMEwRF4WZLzfLfl8=;
        b=l9MUQxcphGv8J8wLEayicWAt/+YrzekZ/VDSKZThRYAB7F5mMaVhTt92OBEg+ZJBKu
         heKlErmKiZHcQAiegwOtabZTeatCicd7E1PkWwRP7KokF2i/NZMF7WtDdQN0MMRPECmk
         iOlaWde7vb+rKVY7R3ZtxlwOz54UmMB3jgvY/eQmnDxNbG2OM4KwLUN4CNLVEWdk2wf5
         ZIk4MKjH9WeIZH5j9SACObRRlMXwW+cSOWHu0rFvWmbOPcR4o1/8TU36WWslycoDd1iu
         EYwVHcLMc076q+t4u8Hj/EUg+O1jUp9Q9L25NCESOXjxBeXHP0j+PHiwO2XhxyO9d6p6
         g8uw==
X-Gm-Message-State: ANoB5pkn9ttSFSFKmSdlDcAvhEYRnXf2mt6+5VpCqEwE5qI0iPsXJiRK
        Qvz05iDbFq6EGazuExdINoR45CoW1K6Mgg==
X-Google-Smtp-Source: AA0mqf6wM3Z+QU1mQrF4cWCBG4BeNJltuD5T0O1XFUqppbo5G/UnyL4V0ngmrwBf/0dnVGfemP4RGQ==
X-Received: by 2002:a05:620a:3710:b0:6fa:db14:4827 with SMTP id de16-20020a05620a371000b006fadb144827mr2823986qkb.8.1668202217168;
        Fri, 11 Nov 2022 13:30:17 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a24ca00b006cbc6e1478csm2097992qkn.57.2022.11.11.13.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/14] btrfs-progs: prep and initial sync of kernel code
Date:   Fri, 11 Nov 2022 16:30:01 -0500
Message-Id: <cover.1668201935.git.josef@toxicpanda.com>
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

Josef Bacik (14):
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

 Makefile                                      |    6 +-
 btrfs-corrupt-block.c                         |    1 +
 btrfs-fragments.c                             |    2 +-
 btrfstune.c                                   |    3 +-
 check/clear-cache.c                           |    1 +
 check/main.c                                  |   15 +-
 check/mode-common.c                           |    2 +
 check/mode-lowmem.c                           |    2 +
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
 cmds/rescue-chunk-recover.c                   |    3 +-
 cmds/rescue.c                                 |    1 +
 cmds/restore.c                                |    3 +-
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
 image/main.c                                  |   45 +-
 image/metadump.h                              |    6 +-
 kerncompat.h                                  |   64 +-
 kernel-shared/backref.c                       |    1 +
 kernel-shared/compression.h                   |  184 +++
 kernel-shared/ctree.c                         |   12 +-
 kernel-shared/ctree.h                         | 1020 +------------
 kernel-shared/delayed-ref.c                   |    1 +
 kernel-shared/extent_io.c                     |    1 +
 kernel-shared/file.c                          |    1 +
 kernel-shared/free-space-tree.c               |    1 +
 kernel-shared/messages.c                      |  372 +++++
 kernel-shared/messages.h                      |  253 ++++
 kernel-shared/print-tree.c                    |   15 +-
 kernel-shared/transaction.c                   |    5 -
 kernel-shared/transaction.h                   |    1 -
 ioctl.h => kernel-shared/uapi/btrfs.h         |  644 +++++----
 kernel-shared/uapi/btrfs_tree.h               | 1259 +++++++++++++++++
 kernel-shared/ulist.c                         |    1 +
 kernel-shared/zoned.h                         |    1 +
 libbtrfs/ctree.h                              |    5 +-
 libbtrfs/send-utils.c                         |    2 +-
 libbtrfsutil/btrfs_tree.h                     |    2 +-
 mkfs/common.c                                 |    2 +-
 mkfs/main.c                                   |    1 +
 tests/ioctl-test.c                            |    2 +-
 tests/library-test.c                          |    2 +-
 .../053-receive-write-encoded/test.sh         |    2 +-
 68 files changed, 2715 insertions(+), 1482 deletions(-)
 create mode 100644 kernel-shared/compression.h
 create mode 100644 kernel-shared/messages.c
 create mode 100644 kernel-shared/messages.h
 rename ioctl.h => kernel-shared/uapi/btrfs.h (70%)
 create mode 100644 kernel-shared/uapi/btrfs_tree.h

-- 
2.26.3


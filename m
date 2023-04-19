Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE56E833F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDSVR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDSVRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5188A44BE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a23so616617qtj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939043; x=1684531043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilZ4mJFKYkjLpZAtQrnGdND7Z/IV5NOJYzap5/4LEcw=;
        b=yH4diatyyWMSsMklRrL/hDWbN5i+8fioPRic8x+/B2nGN6cU8Da4edm9B0M571VILX
         y75oy3qzZm+AM03GGksoP0t+FLov0FuHrQpDxlmRCrp8syBJ2wlwxqBWnizp1fYoWVbT
         ge6B1Zf/rFg9dMW7zT5OHwy+FJqBL5pzrqk6H7OUGlAiUjtOGPT/VDWCaxaU/EVW4JCI
         xKqyZm7AERoEXUXFQvbUQmeYeH5xXvX79MjkYZ1mfNdN8FhMXb+wNOlFE8nXHSrQfbT3
         OC55FRRgFHLpnUEYPnPsLdR5VYLE5hb/LUKCu9GguJWedWB9uX2UMOIeq4QXqrCxwbdh
         n2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939043; x=1684531043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilZ4mJFKYkjLpZAtQrnGdND7Z/IV5NOJYzap5/4LEcw=;
        b=BvlyQtZz5+IJxV0h5DNVu2mTr/T7TLr7RIG/R3bSt9cx60ypvnWT2aVFVClDeS5q9C
         n+6GovzvoWDQlr9XPjYbQWIgHXleLyw/IX46tYvZw3d3DXzMdxxOeRFWrXpfjhvCjfhy
         yZngcblotC/wIioF1Ze9RMQIjP+moHZLBhxF+EDx5klZVPv1zGVyEou/hTqpSBUYMhO3
         bBN477apl/pQyzX9AlOsC3oNmdvn7uxfMKnESvsJ+IeI0tWSXBj55A+VrcdbygTG886c
         9i6sRqpnBCu2XVz4r4xPhv+/MKpGqziCa6R6HPXQ2loVB+i52f4UgRm73Kkqp/TCAWde
         YELQ==
X-Gm-Message-State: AAQBX9doOSm3pSH7+B0/clu3RR9+n17YB8Ghc3+7Y9+cZ7xwj65pE8bq
        HJJgA5ucXfCQ2apwsCWui48dMGqPKPyhdZwL+cT19Q==
X-Google-Smtp-Source: AKy350bZ5H2QEw78A6H/xOwGldgjNmDdpT/hSfjb/zPncKy13F5/qgg6H6H/zkn9ghF2eFNGgHsx1w==
X-Received: by 2002:a05:622a:44c:b0:3ef:3c3e:ab5b with SMTP id o12-20020a05622a044c00b003ef3c3eab5bmr7957272qtx.19.1681939043077;
        Wed, 19 Apr 2023 14:17:23 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i3-20020ac85c03000000b003ee08d3e073sm36628qti.42.2023.04.19.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] btrfs-progs: sync basic code from the kernel
Date:   Wed, 19 Apr 2023 17:17:11 -0400
Message-Id: <cover.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
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

Hello,

This series copies the easier to sync files from the kernel into btrfs-progs and
updates all the users to include the appropriate headers.  There's an extra
change in here to deal with va_format, which we'll need for future syncs.  I put
it in here because it's related to the messages sync, so it seemed appropriate.

This depends on the series

 btrfs-progs: prep work for syncing files into kernel-shared

Thanks,

Josef

Josef Bacik (8):
  btrfs-progs: sync uapi/btrfs.h into btrfs-progs
  btrfs-progs: sync ondisk definitions from the kernel
  btrfs-progs: sync messages.* from the kernel
  btrfs-progs: add struct va_format support to our btrfs_no_printk
    helper
  btrfs-progs: sync accessors.[ch] from the kernel
  btrfs-progs: sync file-item.h into progs
  btrfs-progs: sync async-thread.[ch] from the kernel
  btrfs-progs: sync extent-io-tree.[ch] and misc.h from the kernel

 Makefile                                      |    4 +
 btrfs-corrupt-block.c                         |    3 +-
 btrfs-fragments.c                             |    2 +-
 check/clear-cache.c                           |   15 +-
 check/common.h                                |    2 +-
 check/main.c                                  |   34 +-
 check/mode-common.c                           |   19 +-
 check/mode-lowmem.c                           |   11 +-
 check/repair.c                                |   16 +-
 cmds/balance.c                                |    2 +-
 cmds/device.c                                 |    2 +-
 cmds/filesystem-usage.h                       |    2 +-
 cmds/filesystem.c                             |    2 +-
 cmds/inspect-tree-stats.c                     |    1 +
 cmds/inspect.c                                |    2 +-
 cmds/property.c                               |    2 +-
 cmds/qgroup.c                                 |    2 +-
 cmds/qgroup.h                                 |    2 +-
 cmds/quota.c                                  |    2 +-
 cmds/receive.c                                |    2 +-
 cmds/replace.c                                |    2 +-
 cmds/rescue-chunk-recover.c                   |    4 +-
 cmds/restore.c                                |    3 +-
 cmds/scrub.c                                  |    2 +-
 cmds/send.c                                   |    2 +-
 cmds/subvolume-list.c                         |    2 +-
 cmds/subvolume.c                              |    2 +-
 common/device-scan.c                          |    2 +-
 common/device-scan.h                          |    2 +-
 common/fsfeatures.c                           |    2 +-
 common/internal.h                             |    4 +
 common/messages.c                             |   42 +
 common/messages.h                             |   18 +
 common/send-stream.c                          |    2 +-
 common/send-utils.c                           |    2 +-
 common/utils.c                                |    2 +-
 common/utils.h                                |    2 +-
 convert/common.c                              |    2 +-
 convert/main.c                                |    1 +
 convert/source-ext2.c                         |    1 +
 image/main.c                                  |   12 +-
 include/kerncompat.h                          |  285 ++-
 kernel-lib/bitops.h                           |   12 +
 kernel-lib/trace.h                            |   55 +
 kernel-shared/accessors.c                     |  117 +
 kernel-shared/accessors.h                     | 1087 ++++++++++
 kernel-shared/async-thread.c                  |  339 +++
 kernel-shared/async-thread.h                  |   46 +
 kernel-shared/backref.c                       |    1 +
 kernel-shared/ctree.h                         | 1890 +----------------
 kernel-shared/delayed-ref.c                   |    1 +
 kernel-shared/dir-item.c                      |    8 +-
 kernel-shared/disk-io.c                       |   16 +-
 kernel-shared/extent-io-tree.c                | 1733 +++++++++++++++
 kernel-shared/extent-io-tree.h                |  239 +++
 kernel-shared/extent-tree.c                   |   52 +-
 kernel-shared/extent_io.c                     |  474 +----
 kernel-shared/extent_io.h                     |   39 +-
 kernel-shared/file-item.c                     |   13 +-
 kernel-shared/file-item.h                     |   89 +
 kernel-shared/file.c                          |    1 +
 kernel-shared/free-space-tree.c               |    1 +
 kernel-shared/inode.c                         |    2 +-
 kernel-shared/messages.c                      |  336 +++
 kernel-shared/messages.h                      |  216 ++
 kernel-shared/misc.h                          |  143 ++
 kernel-shared/print-tree.c                    |   17 +-
 kernel-shared/transaction.c                   |    5 +-
 include/ioctl.h => kernel-shared/uapi/btrfs.h |  566 +++--
 kernel-shared/uapi/btrfs_tree.h               | 1259 +++++++++++
 kernel-shared/ulist.c                         |    1 +
 kernel-shared/zoned.h                         |    1 +
 libbtrfs/kerncompat.h                         |   20 -
 mkfs/common.c                                 |    3 +-
 mkfs/rootdir.c                                |    1 +
 tests/ioctl-test.c                            |    2 +-
 tune/change-metadata-uuid.c                   |    2 +-
 tune/change-uuid.c                            |    2 +-
 78 files changed, 6530 insertions(+), 2782 deletions(-)
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
 rename include/ioctl.h => kernel-shared/uapi/btrfs.h (72%)
 create mode 100644 kernel-shared/uapi/btrfs_tree.h

-- 
2.40.0


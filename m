Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7129A4DCC58
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiCQR1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiCQR1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418C114FC7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w8so4996802pll.10
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7DHGubPYd3ZDKu8pJXjL5r5SlAt1Oem/2PJOqwf3L8=;
        b=Zi2nIJpzbiO6DtEv8ZGgZxIxWMI5fXBJ/wsvp72Y83QkCqzuINHSSDKxaF58IvVfDf
         ROwtrAY1xyogimvskQV299F86fHrkZed9JJiGcWplfKs8Isowi6+3gNpzzGOlkzklP4y
         T4NVp/5sx/bQZWePbsstIpHWBJA6Mu/vYza+gALZrzqK1YFohXjC/8IU6yCTWxXKy9OF
         Pk+RITt6BNHJsCmrgnbfplW/S5TXeJkY9Z4w1kxiKv3A6MAciSqHojhZcXjt4jdMJxra
         vTP8KHD7XXrvJpeXmY2ROjQgdYuVXZFkWNs5ucvJFXNpMXwx66eH7gx0a7Sk8VxL6uOU
         LLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7DHGubPYd3ZDKu8pJXjL5r5SlAt1Oem/2PJOqwf3L8=;
        b=p5YquJEpleoZf4SsIuXmFPu8J60BTkxoTTTsQiM0klFsB0L07dDPOpMxHf+le/zyv5
         evm7DpeWmwkg0NQHB11KYpCLqwZoBglFXbJ6N7eon0zX2Ri1rON4HmlpBp1aHGH4HH8R
         +AHtRxnq5OBF+cWqs/5GVCU/k0TQInXgciuuHj6WHDMIiVd2BgS8yvAZqt6zYkZ0Dydq
         hYPtaR3FIHqGpTtOocP31hbT4yVtbkCU4BA9/DoFDSzrjXS/OjgHOTjeGf2Qh53P8hlN
         q4MC2qgLzB6pfFOTaDosRE/a43whLirC+i4QR+3t2pNXzyMyUvMwKsj428IozUts0neM
         jD5Q==
X-Gm-Message-State: AOAM5336pEFr/ofKhvqoOwKkJzZevnu1sUJuKzXzdRdqAGlWzA/I0paN
        0Il3g4MZa+TvlYF2sILqtpyinWx4mWOKcg==
X-Google-Smtp-Source: ABdhPJwBQJj2dRzswN3S8qxso5tXxui5u26j+vWWdYUzFdmNxYOC8nxmG5bRiK7NEDop4pjsjw39yg==
X-Received: by 2002:a17:903:24c:b0:153:853c:25c with SMTP id j12-20020a170903024c00b00153853c025cmr6282995plh.84.1647537965987;
        Thu, 17 Mar 2022 10:26:05 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:05 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 0/7] btrfs: add send/receive support for reading/writing compressed data
Date:   Thu, 17 Mar 2022 10:25:36 -0700
Message-Id: <cover.1647537027.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
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

From: Omar Sandoval <osandov@fb.com>

This series adds support for sending compressed data via Btrfs send and
btrfs-progs support for sending/receiving compressed data and writing it
with BTRFS_IOC_ENCODED_WRITE, which was previously merged into
misc-next. See the previous posting for more details and benchmarks [1].

Patches 1 and 2 are cleanups for Btrfs send. Patches 3-5 prepare some
protocol changes for send stream v2. Patch 6 implements compressed send.
Patch 7 enables send stream v2 and compressed send in the send ioctl
when requested.

Changes since v13 [2]:

- Rebased on latest misc-next branch.
- Dropped ioctl patches which are already in misc-next.

1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
2: https://lore.kernel.org/linux-btrfs/cover.1644519257.git.osandov@fb.com/

Omar Sandoval (7):
  btrfs: send: remove unused send_ctx::{total,cmd}_send_size
  btrfs: send: explicitly number commands and attributes
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/ctree.h           |   6 +
 fs/btrfs/inode.c           |  13 +-
 fs/btrfs/send.c            | 324 +++++++++++++++++++++++++++++++++----
 fs/btrfs/send.h            | 142 +++++++++-------
 include/uapi/linux/btrfs.h |  10 +-
 5 files changed, 395 insertions(+), 100 deletions(-)

The btrfs-progs patches were written by Boris Burkov with some updates
from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
Patch 6 implements the fallback to decompressing. Patches 7 and 8
implement the other commands. Patch 9 adds the new `btrfs send` options.
Patch 10 adds a test case.

Changes since v13:

- Rebased on latest devel branch.
- Updated the btrfs_ioctl_encoded_io_args definition to the version that
  was merged into misc-next.

Boris Burkov (8):
  btrfs-progs: receive: support v2 send stream larger tlv_len
  btrfs-progs: receive: dynamically allocate sctx->read_buf
  btrfs-progs: receive: support v2 send stream DATA tlv format
  btrfs-progs: receive: process encoded_write commands
  btrfs-progs: receive: encoded_write fallback to explicit decode and
    write
  btrfs-progs: receive: process fallocate commands
  btrfs-progs: receive: process setflags ioctl commands
  btrfs-progs: receive: add tests for basic encoded_write send/receive

Omar Sandoval (2):
  btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
  btrfs-progs: send: stream v2 ioctl flags

 Documentation/btrfs-receive.rst               |   5 +
 Documentation/btrfs-send.rst                  |  22 ++
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 347 +++++++++++++++++-
 cmds/send.c                                   | 100 ++++-
 common/send-stream.c                          | 165 +++++++--
 common/send-stream.h                          |   7 +
 ioctl.h                                       | 151 +++++++-
 kernel-shared/send.h                          | 146 +++++---
 libbtrfs/send-stream.c                        |   2 +-
 .../052-receive-write-encoded/test.sh         | 114 ++++++
 11 files changed, 993 insertions(+), 97 deletions(-)
 create mode 100755 tests/misc-tests/052-receive-write-encoded/test.sh

-- 
2.35.1


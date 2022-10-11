Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668415FB7BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJKPvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJKPvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 11:51:32 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D92A2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 08:47:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o65so11164844iof.4
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eg7NZ/gvF36cOS9+OajFvVi8wwVoxnQgu+EK7dzNVOc=;
        b=f87qOrGhU0qVZayOTG0AVB6wo4cH38tdD0T1DPAOyhQh+XGygouQEgyFye8nL71C3Z
         GeaJL0qCHje7gLmnX9aRGQKwKx8SVJTywHK1PytEVyskDm6ya8I0r7i299Fa+noDw99N
         FYUUsylKPt3DZ3Ub8JLxKAhTD4ur8vLaClhhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg7NZ/gvF36cOS9+OajFvVi8wwVoxnQgu+EK7dzNVOc=;
        b=Gh9bzDhN1T1Zwwyo3n/M6IpouC2sX2GA7HiV0CJ0W28ro8lj2Ctv+yfrnthvHPkegK
         JqOssbOvribXEc6G8OjyXGB5KMmkFLkNAdItne7BrdXlS4763hGNPhhBAKOcH6brq8jE
         mYy4wPN2KY4Rr+VmjNfdtbyfkFokVnZt5S4xSLqS8dpfu4hcv4Eodz7Ze23T6/wco9Y5
         oYH0pLRT873/UdjMylbA9Gp09umeVGgkDPYI0rOZ3Ad3bLt8hZIY1+29P6sXD78PPjxs
         ClGMgaIgVn0Np75qH2JvYiU9nI83IWseFjYx4nD3ApneH+BWMO9bBcvPqvY2RC2GX7i5
         l8nQ==
X-Gm-Message-State: ACrzQf0Sjxe9dFeWuBuG6gctliBTXERCFaM0sfWpW0Nib0D2iL8/TWqE
        5AAu/NrSv8De7/XL3QmpqU6lcw==
X-Google-Smtp-Source: AMsMyM6KAFSMVdq1HEUo+Ua9Le3UYuS8JkiiBH3iaOwbivmWIIzpArnmNC4BY8CcMzJ3R6z2aua/Bg==
X-Received: by 2002:a05:6638:3492:b0:363:b821:3831 with SMTP id t18-20020a056638349200b00363b8213831mr6038497jal.157.1665503266342;
        Tue, 11 Oct 2022 08:47:46 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-67-190-102-125.hsd1.co.comcast.net. [67.190.102.125])
        by smtp.gmail.com with ESMTPSA id r12-20020a922a0c000000b002f9b55e7e92sm4988680ile.0.2022.10.11.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:47:45 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Simon Glass <sjg@chromium.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jerry Van Baren <vanbaren@cideas.com>,
        John Keeping <john@metanate.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Pavel Herrmann <morpheus.ibis@gmail.com>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Qu Wenruo <wqu@suse.com>, Ramon Fried <rfried.dev@gmail.com>,
        Stefan Roese <sr@denx.de>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/14] vbe: Support device tree fixups for OS requests
Date:   Tue, 11 Oct 2022 09:47:06 -0600
Message-Id: <20221011154720.550320-1-sjg@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

VBE provides the ability for an OS to request that information be passed
to it when it is booted. This is added into the /chosen node, in addition
to things like the bootargs for Linux, for example.

VBE's OS requests are intended to replace the need for the EFI 'boot-time
services'. This works via a 'stub' which runs before Linux, collects the
information from U-Boot, writes it to the device tree (mostly) and then
jumps to Linux with the updated device tree.

Rather than just jumping into Linux and waiting for it to request things
from U-Boot, we can look at the requests in the FIT and process them
before jumping to Linux. This is simpler and easier to test. It is also
more deterministic, since we can tell whether we might lack something
needed by Linux, before jumping to it.

This series adds initial support for OS requests, with just a few simple
ones provided. Further work will expand these out.

Changes in v2:
- Add new patch to update docs about oftree_from_fdt()

Simon Glass (14):
  bootm: Change incorrect 'unsupported' error
  bootm: Avoid returning error codes from command
  bootm: Drop #ifdef from do_bootm()
  boot: Correct handling of addresses in boot_relocate_fdt()
  fs: Quieten down the filesystems more
  fdt: Show a message when the working FDT changes
  bootstd: Move VBE setup into a shared function
  sandbox: Support FDT fixups
  boot: Pass the correct FDT to the EVT_FT_FIXUP event
  boot: Tidy up logging and naming in vbe_simple
  test: Move common FIT code into a separate fit_util file
  vbe: Add fixups for a basic set of OS requests
  dm: core: Update docs about oftree_from_fdt()
  vbe: Add a test for VBE device tree fixups

 arch/sandbox/lib/bootm.c              |  17 ++
 boot/Makefile                         |   2 +-
 boot/bootm.c                          |   2 +-
 boot/image-fdt.c                      |  37 ++--
 boot/vbe_fixup.c                      | 233 ++++++++++++++++++++++++++
 boot/vbe_simple.c                     |  16 +-
 cmd/bootm.c                           |  25 +--
 cmd/fdt.c                             |   1 +
 configs/sandbox_flattree_defconfig    |   2 +-
 disk/part_efi.c                       |  15 +-
 doc/develop/driver-model/livetree.rst |   2 +-
 doc/develop/vbe.rst                   |   3 +-
 doc/usage/cmd/fdt.rst                 |   1 +
 fs/btrfs/disk-io.c                    |   7 +-
 fs/ext4/ext4_common.c                 |   2 +-
 fs/fs_internal.c                      |   3 +-
 include/dm/ofnode.h                   |   3 +
 test/boot/Makefile                    |   1 +
 test/boot/bootflow.c                  |   2 +
 test/boot/bootstd_common.c            |  49 ++++++
 test/boot/bootstd_common.h            |  16 ++
 test/boot/vbe_fixup.c                 |  59 +++++++
 test/boot/vbe_simple.c                |  34 +---
 test/cmd/fdt.c                        |  11 +-
 test/py/tests/fit_util.py             |  93 ++++++++++
 test/py/tests/test_event_dump.py      |   1 +
 test/py/tests/test_fit.py             |  79 +--------
 test/py/tests/test_vbe.py             | 123 ++++++++++++++
 28 files changed, 684 insertions(+), 155 deletions(-)
 create mode 100644 boot/vbe_fixup.c
 create mode 100644 test/boot/vbe_fixup.c
 create mode 100644 test/py/tests/fit_util.py
 create mode 100644 test/py/tests/test_vbe.py

-- 
2.38.0.rc1.362.ged0d419d3c-goog


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA55B3BB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiIIPSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiIIPSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 11:18:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AE514670E
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 08:18:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v2-20020a056830090200b006397457afecso1239765ott.13
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SvbuETYizgrp97mN8zW8XG4+mDRShhn5cPiNG4GV/Ag=;
        b=gey5QGF9gvRkXwrEDg4f4JRhnVhYm03D8Y8W9/w6bzv/7/Rp6drrqhq5K7Fk0nReW3
         3nnPFsee657qso8OxrrIqcHDiwyqrR674dq0+r/CkgBD5bai/DCdfsGTz2apnydonXHq
         CGEKLic3043M+GPk/fV558FJnM1V7IEq7ZB9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SvbuETYizgrp97mN8zW8XG4+mDRShhn5cPiNG4GV/Ag=;
        b=GJnGYLw+geXC86X3B7NsgprRQ/49Bd0W1RqDcqnrQt3gwqLnoeI002zModhyxPSdnO
         ca9XZumtqZp3DlY+/4TCtL6X3jWYWEYy+zfm6RmQppwUICpDBtO9t04iF4hJMDtQ51JO
         OrxW5oDncYOWpQjsGrTjEc/mxmbypBNEt1LvfH9UV7vcHGj6tTUfuN4L2t7zn/Y/QnA4
         tx2VETYqGYoOMZir8gh+5uIiXugxMihLPjfZNPSsDxvjCAADKhud/+6Ek3Psd/H4lnfj
         Tys7Bgu8zmMmXzEA4Mvve6OBu/h/4EkBge7z6bjVRBGJEpQ1PR1K6mjBHdANLVPUqKjb
         iGcA==
X-Gm-Message-State: ACgBeo2t7VZYdJExjgVUwtiZxAQhZL+uAOqArHcGHHo9XFoQmrwfCgOY
        G3++lbHbVbcHU+MYHckThvXvwA==
X-Google-Smtp-Source: AA6agR6+Jp76uIx1bopD2FxgEcYG3lSb4DhYLr5LMnx/HsAYAdVZmikPHOoMig9K4nArHl2Y3SS4jA==
X-Received: by 2002:a9d:6656:0:b0:63c:7809:7166 with SMTP id q22-20020a9d6656000000b0063c78097166mr5611658otm.180.1662736699886;
        Fri, 09 Sep 2022 08:18:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-67-190-102-125.hsd1.co.comcast.net. [67.190.102.125])
        by smtp.gmail.com with ESMTPSA id eq22-20020a056870a91600b0012779ba00fesm591977oab.2.2022.09.09.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:18:18 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Simon Glass <sjg@chromium.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
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
        Sean Anderson <sean.anderson@seco.com>,
        Stefan Roese <sr@denx.de>, linux-btrfs@vger.kernel.org
Subject: [PATCH 00/14] vbe: Support device tree fixups for OS requests
Date:   Fri,  9 Sep 2022 09:17:47 -0600
Message-Id: <20220909151801.336551-1-sjg@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


Simon Glass (14):
  dm: core: Avoid registering an invalid tree in oftree_ensure()
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
  vbe: Add a test for VBE device tree fixups

 arch/sandbox/lib/bootm.c           |  17 +++
 boot/Makefile                      |   2 +-
 boot/bootm.c                       |   2 +-
 boot/image-fdt.c                   |  37 ++---
 boot/vbe_fixup.c                   | 233 +++++++++++++++++++++++++++++
 boot/vbe_simple.c                  |  16 +-
 cmd/bootm.c                        |  25 ++--
 cmd/fdt.c                          |   1 +
 configs/sandbox_flattree_defconfig |   2 +-
 disk/part_efi.c                    |  15 +-
 doc/develop/vbe.rst                |   3 +-
 doc/usage/cmd/fdt.rst              |   1 +
 drivers/core/ofnode.c              |   2 +-
 fs/btrfs/disk-io.c                 |   7 +-
 fs/ext4/ext4_common.c              |   2 +-
 fs/fs_internal.c                   |   3 +-
 test/boot/Makefile                 |   1 +
 test/boot/bootflow.c               |   2 +
 test/boot/bootstd_common.c         |  49 ++++++
 test/boot/bootstd_common.h         |  16 ++
 test/boot/vbe_fixup.c              |  59 ++++++++
 test/boot/vbe_simple.c             |  34 +----
 test/cmd/fdt.c                     |  11 +-
 test/py/tests/fit_util.py          |  93 ++++++++++++
 test/py/tests/test_event_dump.py   |   1 +
 test/py/tests/test_fit.py          |  79 ++--------
 test/py/tests/test_vbe.py          | 123 +++++++++++++++
 27 files changed, 681 insertions(+), 155 deletions(-)
 create mode 100644 boot/vbe_fixup.c
 create mode 100644 test/boot/vbe_fixup.c
 create mode 100644 test/py/tests/fit_util.py
 create mode 100644 test/py/tests/test_vbe.py

-- 
2.37.2.789.g6183377224-goog


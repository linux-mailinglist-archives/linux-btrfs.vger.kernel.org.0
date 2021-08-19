Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DABD3F1201
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 05:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHSDlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 23:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhHSDlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 23:41:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09CC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 20:40:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id r38-20020a05683044a600b0051a2c6dd421so7001687otv.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg6bG5vz4/bH0CDlTMyYG7ykSKbhdsAMHpFmNV8Ogd0=;
        b=PUmiJENf6KU4y06qfcavyeTMv1KQtu4FkgxaAix6jzbm5E6X6D1kYXF8JVOWzbrpWQ
         J2Ukq4iWJc4lGbMDScsieyhHFNAXaTUV0uh+6NPxBfYl3k8VWU413EanAhO449MBCDOf
         GK4FD6ZORKoO1WWHrpuNOA3Nj0US8IovGCYsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg6bG5vz4/bH0CDlTMyYG7ykSKbhdsAMHpFmNV8Ogd0=;
        b=kZwIP06L4M/GARQThMzjMsGVZWQ41Xk3RMfq58q2iGPcES1LMWgmr87FeiJm4tpcgb
         fIoHcKm8GrX1k8plJoX9utlFVLtXUgmtzRQvPKAgJNlkgVYB+EC+BP6pZ4SB3i+UW6bM
         AKhIOk4R1mJhFhjD4u4IvYa/Y4OWllIa1ioaEKFb6oBftTS6TROjvDOAeubUF7RKMlq1
         huL7zvUGQWoNZxkX+FKM/Gqf1WtFQhQKVvhYjI28oukfGWMGQOA4l+deAVd8gKsa2Q9+
         5FroJfX7d/8EoZ/Qd/Ma983Ai/Yd8oFqTkFvRlNJ7JiI/9XRWXaNiW3nRyvKG3DuJkpH
         PQnw==
X-Gm-Message-State: AOAM530z8N0pioLhLGuPv/GJiN0cqYr39f4Aw0fUDWpB1leTht5olm2t
        lvXBnd1uGJHMlnH5bGH7itQlfQ==
X-Google-Smtp-Source: ABdhPJzpNDttK7kKjv3wBdRLOsR7qty7NTH0PEWTM6vRy+l/H0CL1ZMGZns8rd+kFxWckGZk64/jWA==
X-Received: by 2002:a9d:17c2:: with SMTP id j60mr10339713otj.128.1629344439992;
        Wed, 18 Aug 2021 20:40:39 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id q27sm415877oof.12.2021.08.18.20.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 20:40:39 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Dario Binacchi <dariobin@libero.it>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Heiko Schocher <hs@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Marek Behun <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Pavel Herrmann <morpheus.ibis@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Qu Wenruo <wqu@suse.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Sean Anderson <seanga2@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
        Walter Lozano <walter.lozano@collabora.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] sandbox: Minor fixes and improvements
Date:   Wed, 18 Aug 2021 21:40:22 -0600
Message-Id: <20210819034033.1617201-1-sjg@chromium.org>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series collects a few patches that correct and improve sandbox and
sandbox_spl:

- Fix a bug in --rm-memory works
- Support an MMC backing file for MMC emulator, to allow filesystems to be
  used without needing the 'host' filesystem
- Allow skipping console output when checking verbose commands
- Suppress unwanted filesystem warnings when probing partitions
- Tidy up a few comments


Simon Glass (11):
  dtoc: Further improve documentation about warnings
  sandbox: Correct handling of --rm_memory
  sandbox: Add license headers to the dts files
  btrfs: Suppress the message about missing filesystem
  sqfs: Suppress the message about missing filesystem
  test: Tidy a comment in the bloblist test
  dm: core: Fix a few incorrect comments on first/next functions
  sandbox: Add a way to find the size of a file
  sandbox: Add a way to map a file into memory
  sandbox: mmc: Support a backing file
  test: Add a way to skip console checking until a string matches

 arch/sandbox/cpu/os.c                        | 52 +++++++++--
 arch/sandbox/dts/overlay0.dts                |  5 ++
 arch/sandbox/dts/overlay1.dts                |  5 ++
 arch/sandbox/dts/sandbox.dts                 |  5 ++
 arch/sandbox/dts/sandbox.dtsi                |  1 +
 arch/sandbox/dts/sandbox64.dts               |  4 +
 arch/sandbox/dts/test.dts                    |  9 ++
 doc/develop/driver-model/of-plat.rst         | 92 +++++++++++++++++++-
 doc/device-tree-bindings/mmc/sandbox,mmc.txt | 18 ++++
 drivers/mmc/sandbox_mmc.c                    | 46 ++++++++--
 fs/btrfs/disk-io.c                           |  8 +-
 fs/squashfs/sqfs.c                           |  2 +-
 include/dm/device.h                          |  4 +-
 include/dm/uclass.h                          |  2 +-
 include/os.h                                 | 21 +++++
 include/test/ut.h                            | 24 +++++
 test/bloblist.c                              |  2 +-
 test/ut.c                                    | 26 ++++++
 18 files changed, 299 insertions(+), 27 deletions(-)
 create mode 100644 doc/device-tree-bindings/mmc/sandbox,mmc.txt

-- 
2.33.0.rc1.237.g0d66db33f3-goog


Return-Path: <linux-btrfs+bounces-79-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9ED7E8DA0
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 01:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D648280E09
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4891EA2;
	Sun, 12 Nov 2023 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mvi8p/b2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E267E
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 00:09:31 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F189F
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 16:09:29 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a66aa8ebb7so125780939f.3
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699747769; x=1700352569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOZGm1DB+FSqqEEZWw12TzyzShs1slwAa9PWYXUZ83w=;
        b=Mvi8p/b2vlIBy48qOS8OU71rQm4Gz0XoLavmJAS8DKS4dlF0XcuVkCrtK4KDfi5y63
         BIAhZylXkJq/F2fNU20ePnW+CKu/XJU/p5m7oPiaO4GJe/2a0HneHyJOQI2mGRxj8Lij
         QcL+6AwIdWVeIFTH42YiuBo7roHIE65r+5Qq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699747769; x=1700352569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOZGm1DB+FSqqEEZWw12TzyzShs1slwAa9PWYXUZ83w=;
        b=PM2zvMhml1chq9XlLGUHSAD4vMp1H/Gu4BNEZx61w6THoRb0ZpnS/TBLvjO05DqF4Y
         SoMuWo3gizgAVGoy62sNh0kijhwS2rcz6P6zBh1Ped7V3OleFrhG0X2nhPWkNTej+P1L
         3Xo6INkpCQxTKKiz98Djcp2MzNaUt7nYynq6POPtCN9eF7qzw5ptbxKD5ZH4IjRCvrfY
         gXt1cVoPG/MgJ/+ew0R7Olw9I8p1N7IJQWsvSv6MSXWapjHITJF4GxC+U9bJjz270QOF
         hACPEoJORhgQ7aKDb+0Fx1IFaaE8DFYEI1QigJNV1W4gHZV7A2o2hs7XVVV8ONzN+PUe
         6JeQ==
X-Gm-Message-State: AOJu0Yy1OA1JkacBsX82tPdXgUx/kWiby70Fl7uiyDi4+jUJ31ajTDB2
	gF+Rbqt8BNvJDC9rgWN4jzQc1Q==
X-Google-Smtp-Source: AGHT+IHgpvB2JmMn/QlhhT6LQxMxP7GoiTrv+rjW8vRtwpnHlZ+dZFSa6yvDa9pBoa2hiRPqJFzuKg==
X-Received: by 2002:a05:6e02:1a22:b0:359:9efa:3afc with SMTP id g2-20020a056e021a2200b003599efa3afcmr4566531ile.7.1699747769140;
        Sat, 11 Nov 2023 16:09:29 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 16:09:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>,
	Albert Aribaud <albert.u.boot@aribaud.net>,
	Baruch Siach <baruch@tkos.co.il>,
	Bin Meng <bmeng.cn@gmail.com>,
	Eddie James <eajames@linux.ibm.com>,
	Evgeny Bachinin <EABachinin@sberdevices.ru>,
	Fabio Estevam <festevam@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jerry Van Baren <vanbaren@cideas.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marek Vasut <marex@denx.de>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Michal Simek <michal.simek@amd.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Qu Wenruo <wqu@suse.com>,
	Safae Ouajih <souajih@baylibre.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Stefano Babic <sbabic@denx.de>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 00/29] bootm: Refactoring to reduce reliance on CMDLINE (part A)
Date: Sat, 11 Nov 2023 17:08:45 -0700
Message-ID: <20231112000923.73568-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would be useful to be able to boot an OS when CONFIG_CMDLINE is
disabled. This could allow reduced code size.

Standard boot provides a way to handle programmatic boot, without
scripts, so such a feature is possible. The main impediment is the
inability to use the booting features of U-Boot without a command line.
So the solution is to avoid passing command arguments and the like to
code in boot/

A similar process has taken place with filesystems, for example, where
we have (somewhat) separate Kconfig options for the filesystem commands
and the filesystems themselves.

This series starts the process of refactoring the bootm logic so that
it can be called from standard boot without using the command line.
Mostly it removes the use of argc, argv and cmdtbl from the internal
logic.

Some limited tidy-up is included, but this is kept to smaller patches,
rather than trying to remove all #ifdefs etc. Some function comments
are added, however.

A simple programmatic boot is provided as a starting point.

This work will likely take many series, so this is just the start.

Size growth with this series for firefly-rk3288 (Thumb2) is:

       arm: (for 1/1 boards) all +23.0 rodata -49.0 text +72.0

This should be removed by:

   https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/11

but it is not included in this series as it is already large enough.

No functional change is intended in this series.


Simon Glass (29):
  arm: x86: Drop discarding of command linker-lists
  mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
  treewide: Tidy up semicolon after command macros
  bootstd: Add missing header file from bootdev.h
  bootstd: Introduce programmable boot
  bootm: Drop arguments from bootm_start()
  bootm: Simplify arguments for bootm_pre_load()
  bootm: Move boot_get_kernel() higher in the file
  image: Tidy up genimg_get_kernel_addr_fit()
  bootm: Reduce arguments to boot_get_kernel()
  image: Document error codes from fit_image_load()
  bootm: Adjust boot_get_kernel() to return an error
  bootm: Use the error return from boot_get_kernel()
  bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
  bootm: Move error printing out of boot_get_kernel()
  bootm: Reduce arguments to boot_find_os()
  bootm: Reduce arguments to boot_get_ramdisk()
  fdt: Allow use of fdt_support inside if() statements
  bootm: Drop #ifdef in bootm_find_images()
  bootm: Pass image buffer to boot_get_fdt()
  bootm: Reduce arguments to boot_get_fdt()
  bootm: Reduce arguments to boot_get_fpga()
  bootm: Reduce arguments to boot_get_loadables()
  bootm: Simplify Android ramdisk addr in bootm_find_images()
  bootm: efi: Drop special call to bootm_find_other()
  bootm: optee: Drop special call to bootm_find_other()
  bootm: Adjust the parameters of bootm_find_images()
  bootm: Add a function to check overlap
  bootm: Reduce arguments to bootm_find_other()

 arch/arm/cpu/u-boot.lds      |   3 -
 arch/x86/cpu/u-boot-64.lds   |   4 -
 arch/x86/cpu/u-boot-spl.lds  |   4 -
 arch/x86/cpu/u-boot.lds      |   4 -
 board/freescale/common/vid.c |   2 +-
 board/xilinx/common/fru.c    |   2 +-
 board/xilinx/versal/cmds.c   |   2 +-
 board/xilinx/zynqmp/cmds.c   |   2 +-
 boot/Kconfig                 |  11 +
 boot/Makefile                |   2 +
 boot/bootm.c                 | 576 +++++++++++++++++++----------------
 boot/bootm_os.c              |  16 -
 boot/image-board.c           |  67 +---
 boot/image-fdt.c             |  39 +--
 boot/prog_boot.c             |  51 ++++
 cmd/booti.c                  |   4 +-
 cmd/bootz.c                  |   4 +-
 cmd/btrfs.c                  |   2 +-
 cmd/eeprom.c                 |   2 +-
 cmd/ext2.c                   |   4 +-
 cmd/fs.c                     |   8 +-
 cmd/pinmux.c                 |   2 +-
 cmd/qfw.c                    |   2 +-
 common/main.c                |   9 +
 env/mmc.c                    |   2 +-
 include/bootdev.h            |   1 +
 include/bootm.h              |  26 +-
 include/bootstage.h          |   1 -
 include/bootstd.h            |   9 +
 include/command.h            |   2 +-
 include/fdt_support.h        |   5 +-
 include/image.h              | 127 ++++++--
 32 files changed, 550 insertions(+), 445 deletions(-)
 create mode 100644 boot/prog_boot.c

-- 
2.42.0.869.gea05f2083d-goog



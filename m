Return-Path: <linux-btrfs+bounces-145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090347EDA9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 05:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6267E280E89
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BDC2CC;
	Thu, 16 Nov 2023 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lBMm8ada"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248ED194
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 20:11:18 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7affff20d38so13254839f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700107877; x=1700712677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asXP4V5YoZAPdMymETvSzKr3a+LSYs95xd4SQKfHIKs=;
        b=lBMm8adaISU40P+X6o8+FU4nVPGg7Zu4Lxbk3gNp1aBcMm0sQZ1/OW56VxU2cD02+P
         RxT54W3g2lZehafV3ujYh0dpCvELeESikwaEjZIRA4efQbEz5BD7rVH/XJlUOsUvWtWk
         2tz6CPfHcYpt32SvSKXxBZXPqBjFoQ1SFZ9EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700107877; x=1700712677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asXP4V5YoZAPdMymETvSzKr3a+LSYs95xd4SQKfHIKs=;
        b=jWaUqSHuKyJMoCPFpaFI+b/N2z9MFrCV0aLYuMhIBpJNyjq4e3ZX/k9ZF8qSBbpzwl
         +2EIxDGCDitq4lPOGIQ4l2AefFOS3UuAVrmKNE8ToHKG1rOqZVztubyMAM3BvqWF2RT6
         7OsUzGdyesaXBKgjtKvvQpwXRwLVkCOqQ3LCdPynl+W1VuPkxvxBrHX4zFgCTcETO9vr
         R7c91A/92/Zs3MZW5Ty0em6jIPXEx54CMkCLTl+B4d5/cPQJJKbfLAoAt+ZmV473g/HB
         3rB1RsefOWIY5QUbU4vxS1M5HM8HZMGfXFRrmmnEb0NS9iagapl9hBFG2UTaCVe6opfQ
         BmCw==
X-Gm-Message-State: AOJu0YyoGvaX2zlk1Xbsy8EZn5gHgkr3GtAR8yfYE3EpIu20nSialIrF
	LzEVTL/03JFm7ZwrHegZIAmL7Q==
X-Google-Smtp-Source: AGHT+IGJTuE4H/HvKTph7N+MKnM1YPUdSmrUCx6suqiyN0o4IkQqZE1p5BYOFIuCHlSFgwfxwV71Lg==
X-Received: by 2002:a05:6602:164a:b0:7a6:a3b1:b45c with SMTP id y10-20020a056602164a00b007a6a3b1b45cmr21658253iow.14.1700107877472;
        Wed, 15 Nov 2023 20:11:17 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:11:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	Albert Aribaud <albert.u.boot@aribaud.net>,
	Alexander Gendin <agendin@matrox.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Bin Meng <bmeng.cn@gmail.com>,
	Eddie James <eajames@linux.ibm.com>,
	Evgeny Bachinin <EABachinin@sberdevices.ru>,
	Fabio Estevam <festevam@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jerry Van Baren <vanbaren@cideas.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Linus Walleij <linus.walleij@linaro.org>,
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
	Sean Anderson <seanga2@gmail.com>,
	Stefano Babic <sbabic@denx.de>,
	Stephen Carlson <stcarlso@linux.microsoft.com>,
	This contributor prefers not to receive mails <noreply@example.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/32] bootm: Refactoring to reduce reliance on CMDLINE (part A)
Date: Wed, 15 Nov 2023 21:10:00 -0700
Message-ID: <20231116041043.362055-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

Changes in v2:
- Add new patch to adjust position of unmap_sysmem() in boot_get_kernel()
- Add new patch to obtain command arguments
- Fix 'boot_find_os' typo
- Pass in the command name
- Use the command table to provide the command name, instead of "bootm"

Simon Glass (32):
  arm: x86: Drop discarding of command linker-lists
  README: Correct docs for CONFIG_SPL_BUILD
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
  bootm: Adjust position of unmap_sysmem() in boot_get_kernel()
  bootm: Use the error return from boot_get_kernel()
  bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
  bootm: Move error printing out of boot_get_kernel()
  bootm: Reduce arguments to bootm_find_os()
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
  RFC: command: Introduce functions to obtain command arguments

 README                       |  26 +-
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
 boot/bootm.c                 | 577 +++++++++++++++++++----------------
 boot/bootm_os.c              |  16 -
 boot/image-board.c           |  67 +---
 boot/image-fdt.c             |  39 +--
 boot/prog_boot.c             |  51 ++++
 cmd/booti.c                  |   4 +-
 cmd/bootz.c                  |   4 +-
 cmd/btrfs.c                  |   2 +-
 cmd/disk.c                   |   4 +-
 cmd/eeprom.c                 |   2 +-
 cmd/ext2.c                   |   4 +-
 cmd/fs.c                     |   8 +-
 cmd/fuse.c                   |   2 +-
 cmd/mmc.c                    |   2 +-
 cmd/pinmux.c                 |   2 +-
 cmd/qfw.c                    |   2 +-
 common/main.c                |   9 +
 drivers/misc/gsc.c           |   6 +-
 env/mmc.c                    |   2 +-
 fs/fs.c                      |   4 +-
 include/bootdev.h            |   1 +
 include/bootm.h              |  26 +-
 include/bootstage.h          |   1 -
 include/bootstd.h            |   9 +
 include/command.h            |  35 ++-
 include/fdt_support.h        |   5 +-
 include/image.h              | 127 ++++++--
 test/cmd_ut.c                |   2 +-
 39 files changed, 612 insertions(+), 463 deletions(-)
 create mode 100644 boot/prog_boot.c

-- 
2.43.0.rc0.421.g78406f8d94-goog



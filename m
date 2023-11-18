Return-Path: <linux-btrfs+bounces-183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521087F02F6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C04CB20A93
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6D1DFC9;
	Sat, 18 Nov 2023 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYOk+fi4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5811D
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 13:05:53 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a956887c20so125080339f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 13:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700341553; x=1700946353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnUlKHEMUW8hNVFr2uUIldtuqY3ev6XDCaZO0iwKWuE=;
        b=gYOk+fi4yyDMPxJIHlcPAClokkrPk8DBmZVfZq1O7HCSkHxLLCs0GXK3DWVhJgMzdj
         WFyxHzmlnw8RT7E0aIN57UzOq5bORZC8lTasGP0x5ZqRbAobeDRVV8N66BXd1wcZ5YMl
         jSfV8GJQPqV1cvVKtLPQNrBS7dtDCzr6+IOyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700341553; x=1700946353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnUlKHEMUW8hNVFr2uUIldtuqY3ev6XDCaZO0iwKWuE=;
        b=lnIrNzAps7YPG7MDgeWa+nG74h/3L797sfwCQkUB8Ks1ihtoAsdWXPwGW/z7ig+6/G
         FnaRArPRYbnYZGN6jInblLZSRzPF+PVOfB1ssl1lUyHompZzU0Ge1Wn/b+qjmtv4V9z7
         qf2+/gNqBPaLNK6CbZVgCrXjB/jSo9/MRuU0A90YBS9LfyN0OSqOgqJNoczJcnd+csRv
         FswOZIeUTaPtkGLvCeUldzQEDnqIszAYjmgPmQEbElF0xHOAqciqhJxWicO72U4WqWRm
         sHpJUompKyKufZ+YBrKh4ZSHHjQVqI2zZdtuJNLydONX0LQRWEbp1Pq5tRiEuO1HZNWR
         4uXg==
X-Gm-Message-State: AOJu0YzT8A7NqM8Z0pRtOh5yHaM3yEX+MrcgQwdAWcEkDNm6jxSoen2C
	UkRWx4GiLy3Fl/U0v8UcFvpmrA==
X-Google-Smtp-Source: AGHT+IGEZ5OsDcml53MiAEJ6J2NEcVqZW/BxWDM3z/rMBsrgk12N1FX8EonfO3GSWfVqiPFKg1lTCA==
X-Received: by 2002:a5d:9389:0:b0:7ab:ec1f:f4a2 with SMTP id c9-20020a5d9389000000b007abec1ff4a2mr3621118iol.8.1700341552976;
        Sat, 18 Nov 2023 13:05:52 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 13:05:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
Subject: [PATCH v3 00/32] bootm: Refactoring to reduce reliance on CMDLINE (part A)
Date: Sat, 18 Nov 2023 14:04:48 -0700
Message-ID: <20231118210547.577026-1-sjg@chromium.org>
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

Changes in v3:
- Add a panic if programmatic boot fails
- Drop RFC tag

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
  bootstd: Introduce programmatic boot
  command: Introduce functions to obtain command arguments

 README                       |  26 +-
 arch/arm/cpu/u-boot.lds      |   3 -
 arch/x86/cpu/u-boot-64.lds   |   4 -
 arch/x86/cpu/u-boot-spl.lds  |   4 -
 arch/x86/cpu/u-boot.lds      |   4 -
 board/freescale/common/vid.c |   2 +-
 board/xilinx/common/fru.c    |   2 +-
 board/xilinx/versal/cmds.c   |   2 +-
 board/xilinx/zynqmp/cmds.c   |   2 +-
 boot/Kconfig                 |  12 +
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
 common/main.c                |  11 +
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
 39 files changed, 615 insertions(+), 463 deletions(-)
 create mode 100644 boot/prog_boot.c

-- 
2.43.0.rc0.421.g78406f8d94-goog



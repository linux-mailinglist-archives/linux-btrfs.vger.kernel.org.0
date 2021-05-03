Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBA372372
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 01:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhECXMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhECXMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 19:12:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E396C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 16:11:45 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z14so5495794ioc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 03 May 2021 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57E5fXvSX79yXno6LcHZpx07c/TI3SkIjJ97k9sAmQ4=;
        b=n/CA784Vve4ANOE/QeDm76kCWu2LH49qr0HQH7Wy8tEvFEXmowcKA+fsWEu0moF4hZ
         R9M3Vfg2sBLhuylZ0wFCG4jq0wmJWsrLP7z/1V8ZQ78Jbi46lGXvWhnhDTOsfOiQvomh
         /mgPQ4e4vZ2yxgJWJkfFQRZyjtYqOVPTa0XS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57E5fXvSX79yXno6LcHZpx07c/TI3SkIjJ97k9sAmQ4=;
        b=e5YMXnKhUcdte6+blEhgd1QNH1jJLNWu7AHSQe5LjeA7pKQ28vVN48vFqbPImtcubs
         h3Iv6BV5rhdANn+MWU+cSQv9sg21qmg7R41FdHVXisjkff1sIG93IKyUOIt/YyaFi7xE
         d/0wVkJqVjPVB0iB6O6o1bzM8m2yzJ9q5CPbUqTcZpbrkRHiRCdvALcburdBm28UDAvx
         LbVRsDdz1WAvfEfw3kiABVSxZy2XEKbUicigmfT3xqWavSj96pvFtEde7Cbl0c8LhDch
         KIbaxxRmZsfiaWMdiQDKtGXS/j5r6N1YkaBtJ2JFAIee8ao+GG7stgbCZFqcXduDgQCS
         dFxw==
X-Gm-Message-State: AOAM5326Tm2OuysUq5utsLObwkfGe7CwWox2y7q4/+rqDn2zUh2SGxuB
        wKZXoOYMQGGjnHhZLndIJjleJg==
X-Google-Smtp-Source: ABdhPJxs0jL7LFqXXMGS23L9J23oiwgvly6TQEr4yt+eaTxWelDSl6gKLhJqEyst2pbwyzMEUUc6Og==
X-Received: by 2002:a05:6638:13cc:: with SMTP id i12mr4360274jaj.20.1620083504489;
        Mon, 03 May 2021 16:11:44 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id o6sm422727ioa.21.2021.05.03.16.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 16:11:43 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Tom Rini <trini@konsulko.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adam Ford <aford173@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Asherah Connor <ashe@kivikakk.ee>,
        Bastian Krause <bst@pengutronix.de>,
        "Chan, Donald" <hoiho@lab126.com>,
        Chee Hong Ang <chee.hong.ang@intel.com>,
        Chin-Liang See <chin.liang.see@intel.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Fabien Parent <fparent@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>,
        George McCollister <george.mccollister@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Hongwei Zhang <hongweiz@ami.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Joel Stanley <joel@jms.id.au>, Jonathan Gray <jsg@jsg.id.au>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Kever Yang <kever.yang@rock-chips.com>,
        Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lukasz Majewski <lukma@denx.de>,
        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
        Marek Behun <marek.behun@nic.cz>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Patrick Oppenlander <patrick.oppenlander@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Qu Wenruo <wqu@suse.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Reuben Dowle <reubendowle0@gmail.com>,
        Rick Chen <rick@andestech.com>,
        Samuel Holland <samuel@sholland.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Sean Anderson <seanga2@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Siew Chin Lim <elly.siew.chin.lim@intel.com>,
        Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        T Karthik Reddy <t.karthik.reddy@xilinx.com>,
        Tero Kristo <t-kristo@ti.com>,
        Thirupathaiah Annapureddy <thiruan@linux.microsoft.com>,
        Trevor Woerner <twoerner@gmail.com>,
        Wasim Khan <wasim.khan@nxp.com>, chenshuo <chenshuo@eswin.com>,
        linux-btrfs@vger.kernel.org, uboot-snps-arc@synopsys.com
Subject: [PATCH 00/49] image: Reduce #ifdefs and ad-hoc defines in image code
Date:   Mon,  3 May 2021 17:10:47 -0600
Message-Id: <20210503231136.744283-1-sjg@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Much of the image-handling code predates the introduction of Kconfig and
has quite a few #ifdefs in it. It also uses its own IMAGE_... defines to
help reduce the #ifdefs, which is unnecessary now that we can use
IS_ENABLED() et al.

The image code is also where quite a bit of code is shared with the host
tools. At present this uses a lot of checks of USE_HOSTCC.

This series introduces 'host' Kconfig options and a way to use
CONFIG_IS_ENABLED() to check them. This works in a similar way to SPL, so

   CONFIG_IS_ENABLED(FIT)

will evaluate to true on the host build (USE_HOSTCC) if CONFIG_HOST_FIT is
enabled. This allows quite a bit of clean-up of the image.h header file
and many of the image C files.

The 'host' Kconfig options should help to solve a more general problem in
that we mostly want the host tools to build with all features enabled, no
matter which features the 'target' build actually uses. This is a pain to
arrange at present, but with 'host' Kconfigs, we can just define them all
to y.

There are cases where the host tools do not have features which are
present on the target, for example environment and physical addressing.
To help with this, some of the core image code is split out into
image-board.c and image-host.c files.

Even with these changes, some #ifdefs remain (101 down to 42 in
common/image*). But the code is somewhat easier to follow and there are
fewer build paths.

In service of the above, this series includes a patch to add an API function
for zstd, so the code can be dropped from bootm.c

It also introduces a function to handle manual relocation.

Changes in v2:
- Add new abuf_init_set() function

Simon Glass (49):
  Add support for an owned buffer
  compiler: Add a comment to host_build()
  zstd: Create a function for use from U-Boot
  btrfs: Use U-Boot API for decompression
  image: Avoid switch default in image_decomp()
  image: Update zstd to avoid reporting error twice
  gzip: Avoid use of u64
  image: Update image_decomp() to avoid ifdefs
  image: Split board code out into its own file
  image: Fix up checkpatch warnings in image-board.c
  image: Split host code out into its own file
  image: Create a function to do manual relocation
  image: Avoid #ifdefs for manual relocation
  image: Remove ifdefs around image_setup_linux() el at
  image: Add Kconfig options for FIT in the host build
  kconfig: Add host support to CONFIG_IS_ENABLED()
  image: Shorten FIT_ENABLE_SHAxxx_SUPPORT
  image: Rename SPL_SHAxxx_SUPPORT to SPL_FIT_SHAxxx
  hash: Use Kconfig to enable hashing in host tools
  hash: Drop some #ifdefs in hash.c
  image: Drop IMAGE_ENABLE_FIT
  image: Drop IMAGE_ENABLE_OF_LIBFDT
  image: Use Kconfig to enable CONFIG_FIT_VERBOSE on host
  image: Rename CONFIG_FIT_ENABLE_RSASSA_PSS_SUPPORT
  image: Use Kconfig to enable FIT_RSASSA_PSS on host
  Kconfig: Rename SPL_CRC32_SUPPORT to SPL_CRC32
  image: Drop IMAGE_ENABLE_CRC32
  Kconfig: Rename SPL_MD5_SUPPORT to SPL_MD5
  image: Drop IMAGE_ENABLE_MD5
  image: Drop IMAGE_ENABLE_SHA1
  image: Drop IMAGE_ENABLE_SHAxxx
  image: Drop IMAGE_BOOT_GET_CMDLINE
  image: Drop IMAGE_OF_BOARD_SETUP
  image: Drop IMAGE_OF_SYSTEM_SETUP
  image: Drop IMAGE_ENABLE_IGNORE
  image: Drop IMAGE_ENABLE_SIGN/VERIFY defines
  image: Drop IMAGE_ENABLE_BEST_MATCH
  image: Drop IMAGE_ENABLE_EN/DECRYPT defines
  image: Tidy up fit_unsupported_reset()
  image: Drop unnecessary #ifdefs from image.h
  image: Drop #ifdefs for fit_print_contents()
  image: Drop most #ifdefs in image-board.c
  image: Reduce variable scope in boot_get_ramdisk()
  image: Split up boot_get_ramdisk()
  image: Remove #ifdefs from select_ramdisk()
  image: Remove some #ifdefs from image-fit and image-fit-sig
  image: Reduce variable scope in boot_get_fdt()
  image: Split up boot_get_fdt()
  image: Remove #ifdefs from select_fdt()

 arch/arc/lib/bootm.c                      |    2 +-
 arch/arm/lib/bootm.c                      |    4 +-
 arch/arm/mach-imx/hab.c                   |    2 +-
 arch/microblaze/lib/bootm.c               |    2 +-
 arch/nds32/lib/bootm.c                    |    4 +-
 arch/riscv/lib/bootm.c                    |    4 +-
 board/synopsys/hsdk/hsdk.c                |    2 +-
 common/Kconfig.boot                       |   18 +-
 common/Makefile                           |    2 +-
 common/bootm.c                            |   30 +-
 common/bootm_os.c                         |    8 +
 common/hash.c                             |   96 +-
 common/image-board.c                      |  958 +++++++++++++++++
 common/image-cipher.c                     |    6 +-
 common/image-fdt.c                        |  275 ++---
 common/image-fit-sig.c                    |    7 +-
 common/image-fit.c                        |   42 +-
 common/image-host.c                       |   27 +
 common/image-sig.c                        |   57 +-
 common/image.c                            | 1179 ++-------------------
 common/spl/Kconfig                        |   27 +-
 configs/axm_defconfig                     |    2 +-
 configs/bcm963158_ram_defconfig           |    2 +-
 configs/chromebit_mickey_defconfig        |    2 +-
 configs/chromebook_jerry_defconfig        |    2 +-
 configs/chromebook_minnie_defconfig       |    2 +-
 configs/chromebook_speedy_defconfig       |    2 +-
 configs/evb-px30_defconfig                |    2 +-
 configs/firefly-px30_defconfig            |    2 +-
 configs/imxrt1020-evk_defconfig           |    2 +-
 configs/imxrt1050-evk_defconfig           |    2 +-
 configs/mt8516_pumpkin_defconfig          |    2 +-
 configs/odroid-go2_defconfig              |    2 +-
 configs/px30-core-ctouch2-px30_defconfig  |    2 +-
 configs/px30-core-edimm2.2-px30_defconfig |    2 +-
 configs/sandbox_defconfig                 |    3 +-
 configs/socfpga_agilex_atf_defconfig      |    2 +-
 configs/socfpga_agilex_vab_defconfig      |    2 +-
 configs/socfpga_stratix10_atf_defconfig   |    2 +-
 configs/taurus_defconfig                  |    2 +-
 fs/btrfs/compression.c                    |   51 +-
 include/abuf.h                            |  148 +++
 include/compiler.h                        |    8 +
 include/fdt_support.h                     |    2 +-
 include/gzip.h                            |    8 +-
 include/image.h                           |  178 +---
 include/linux/kconfig.h                   |   13 +-
 include/linux/zstd.h                      |   11 +
 include/relocate.h                        |   30 +-
 include/u-boot/aes.h                      |    8 +-
 include/u-boot/ecdsa.h                    |    2 +-
 include/u-boot/hash-checksum.h            |    5 +-
 include/u-boot/rsa.h                      |   12 +-
 lib/Kconfig                               |    5 +
 lib/Makefile                              |    5 +-
 lib/abuf.c                                |  103 ++
 lib/gunzip.c                              |   28 +-
 lib/hash-checksum.c                       |    2 +-
 lib/lmb.c                                 |    2 +-
 lib/rsa/rsa-sign.c                        |    4 +-
 lib/rsa/rsa-verify.c                      |    4 +-
 lib/zstd/Makefile                         |    2 +-
 lib/zstd/zstd.c                           |   64 ++
 test/lib/Makefile                         |    1 +
 test/lib/abuf.c                           |  303 ++++++
 tools/Kconfig                             |  111 ++
 tools/Makefile                            |   19 +-
 tools/image-host.c                        |    6 +-
 68 files changed, 2276 insertions(+), 1650 deletions(-)
 create mode 100644 common/image-board.c
 create mode 100644 common/image-host.c
 create mode 100644 include/abuf.h
 create mode 100644 lib/abuf.c
 create mode 100644 lib/zstd/zstd.c
 create mode 100644 test/lib/abuf.c

-- 
2.31.1.527.g47e6f16901-goog


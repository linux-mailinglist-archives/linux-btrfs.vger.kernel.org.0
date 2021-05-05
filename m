Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B924D374C04
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhEEXje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 19:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEEXjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 May 2021 19:39:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62839C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  5 May 2021 16:38:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id d21so3791747oic.11
        for <linux-btrfs@vger.kernel.org>; Wed, 05 May 2021 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjV9OJUlYLNwDNlPBAwYauDS8eJWzNRTZGDi3/jyY1E=;
        b=dzVlHSDefkpZRnwe/Dz2hUrwfrfduG+lF2phZ9b7118UOm3AnqE8cADGYVi8Fr8xWr
         FwbCq6MRV1k444OSYt7wAuwpU0+5FK3npx30gCgOvqBgaGooamC7HaPP9Qpfo+cjkiR5
         hzb7HpxsruCO2OuHwtuF69TdcUr9qTkwGfLlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjV9OJUlYLNwDNlPBAwYauDS8eJWzNRTZGDi3/jyY1E=;
        b=jURAe8Z0WZ1nCbbFZTBvRMCKOey+j5WVrjpw7bZvcJbgFS4Y9DY8pVGuhR3t6kCOcZ
         4PRKDwA29Cdg+OPY5bTpjvJx9Ws5NJA5TcZpyp4Vm8tq9AaIfWIuCAJT9bjw/0TX4zLQ
         CEXLpstb3BvkH/JDOdxzCAxX4IGzUubvskqWoFVNJiFzi2TDI+Uxxb3XWTIq0KyVMZwt
         AMokFb2EuB2gzSidR9MzUERF0UmiJvOEdJ4/LssN3Q6lvoAWU2fEQlNwT6vi5X4fkxWY
         JRMdqkmcC7+waygaFTeWye5fZHxWmWzMlGssC53jyfOocOHDVtRwN97wVm9df2e1QT3K
         4fKg==
X-Gm-Message-State: AOAM532IIjjB7/I0EdxXr+88K9O1HZln1biYrvQBFalhY7/eBu3uXgQx
        eUD7G+5Op3YaBq53atdDR4RKBigFAy/wSw/P68XSMw==
X-Google-Smtp-Source: ABdhPJyNbU+llWp8tqH8FBppNguMPAU4zXBeLkoUahWUiLu1sOw7V464flFfl4eSF3xyF1VXVn5HVI/hk60zklkdmEY=
X-Received: by 2002:aca:1718:: with SMTP id j24mr8465991oii.81.1620257915301;
 Wed, 05 May 2021 16:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210503231136.744283-1-sjg@chromium.org> <20210504214016.GA17669@bill-the-cat>
In-Reply-To: <20210504214016.GA17669@bill-the-cat>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 5 May 2021 17:38:24 -0600
Message-ID: <CAPnjgZ3Gp4+rPmsuH3jfdwx0jx8ryqq8UnNrsE3ZA86hvUHe4Q@mail.gmail.com>
Subject: Re: [PATCH 00/49] image: Reduce #ifdefs and ad-hoc defines in image code
To:     Tom Rini <trini@konsulko.com>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>,
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
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Tom,

On Tue, 4 May 2021 at 14:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 03, 2021 at 05:10:47PM -0600, Simon Glass wrote:
>
> > Much of the image-handling code predates the introduction of Kconfig and
> > has quite a few #ifdefs in it. It also uses its own IMAGE_... defines to
> > help reduce the #ifdefs, which is unnecessary now that we can use
> > IS_ENABLED() et al.
> >
> > The image code is also where quite a bit of code is shared with the host
> > tools. At present this uses a lot of checks of USE_HOSTCC.
> >
> > This series introduces 'host' Kconfig options and a way to use
> > CONFIG_IS_ENABLED() to check them. This works in a similar way to SPL, so
> >
> >    CONFIG_IS_ENABLED(FIT)
> >
> > will evaluate to true on the host build (USE_HOSTCC) if CONFIG_HOST_FIT is
> > enabled. This allows quite a bit of clean-up of the image.h header file
> > and many of the image C files.
> >
> > The 'host' Kconfig options should help to solve a more general problem in
> > that we mostly want the host tools to build with all features enabled, no
> > matter which features the 'target' build actually uses. This is a pain to
> > arrange at present, but with 'host' Kconfigs, we can just define them all
> > to y.
> >
> > There are cases where the host tools do not have features which are
> > present on the target, for example environment and physical addressing.
> > To help with this, some of the core image code is split out into
> > image-board.c and image-host.c files.
> >
> > Even with these changes, some #ifdefs remain (101 down to 42 in
> > common/image*). But the code is somewhat easier to follow and there are
> > fewer build paths.
> >
> > In service of the above, this series includes a patch to add an API function
> > for zstd, so the code can be dropped from bootm.c
> >
> > It also introduces a function to handle manual relocation.
>
> I like this idea overall.  The good news is this reduces the size in a
> few places.  The bad news, but I can live with if we can't restructure
> the changes more, is a few functions grow a bit.  This shows the good
> and the bad (something like sama5d2_ptc_ek_mmc shows only growth, to be
> clear):
>             px30-core-edimm2.2-px30: all -36 rodata -24 text -12
>                u-boot: add: 0/0, grow: 3/-4 bytes: 36/-48 (-12)
>                  function                                   old     new   delta
>                  boot_get_fdt                               896     924     +28
>                  image_decomp                               372     376      +4
>                  boot_get_ramdisk                           868     872      +4
>                  do_bootm_vxworks                           552     540     -12
>                  do_bootm_rtems                             124     112     -12
>                  do_bootm_plan9                             228     216     -12
>                  do_bootm_netbsd                            324     312     -12
>             odroid-c2      : all -105 bss +128 rodata -65 text -168
>                u-boot: add: 0/0, grow: 2/-3 bytes: 108/-172 (-64)
>                  function                                   old     new   delta
>                  images                                     504     608    +104
>                  image_decomp                               372     376      +4
>                  image_setup_linux                          108      96     -12
>                  boot_get_ramdisk                           620     580     -40
>                  boot_get_fdt                               660     540    -120
>             origen         : all +47 bss +96 rodata -57 text +8
>                u-boot: add: 0/0, grow: 15/-2 bytes: 180/-104 (76)
>                  function                                   old     new   delta
>                  images                                     288     340     +52
>                  do_bootm_states                           1304    1348     +44
>                  do_bootz                                   164     176     +12
>                  do_bootm_vxworks                           332     344     +12
>                  image_setup_libfdt                         168     176      +8
>                  image_decomp                               156     164      +8
>                  bootm_find_images                          212     220      +8
>                  boot_prep_linux                            276     284      +8
>                  image_setup_linux                           54      58      +4
>                  do_bootm_standalone                         60      64      +4
>                  do_bootm_plan9                             104     108      +4
>                  do_bootm_netbsd                            168     172      +4
>                  boot_prep_vxworks                           48      52      +4
>                  boot_jump_vxworks                            6      10      +4
>                  boot_jump_linux                            148     152      +4
>                  boot_get_ramdisk                           420     392     -28
>                  boot_get_fdt                               420     344     -76
>
> And looking at ls1088ardb_sdcard_qspi_SECURE_BOOT I think there might be
> something wrong as that looks to drop all crypto algos from SPL.  Other
> layerscape SECURE_BOOT configs show this as well.  It does however seem
> to clear up some other issues around unused code, so a deeper dive on
> which patch is dropping stuff is needed.  I see a huge drop on
> am65x_evm_a53 / j721e_evm_a72 SPL as well but I can test those and at
> least the basic case is fine.  socfpga_agilex_atf is one I don't know
> about being right or wrong.  socfpga_agilex_vab dropping hashing code
> does look worrying however, but maybe it's a configuration issue in the
> end?

Yes it seems to be config. Thank you for all the pointers.

The small increase is unavoidable with this approach - basically we
add 16 bytes of rodata as part of making the switch cases into if()
instead of #ifdef. I found that SPL hashing was dropped, which
explained another problem that I had seen but not yet diagnosed.

I will send v2.

Regards,
Simon

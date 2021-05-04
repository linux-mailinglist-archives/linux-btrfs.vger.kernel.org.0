Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A9F3731FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 23:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEDVlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhEDVlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 17:41:18 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4841C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 14:40:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w9so210364qvi.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 May 2021 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a0cU5H7q1LCMAyhSWWKVmutP6bnvt+liyXXmz7rAPpE=;
        b=JFE6DgqigB5NCmWTf1FkzfeyY3KA4IfJyd5t8zP4wU1A/nFJqhhAs5Nv7cmwT4PmXD
         mNYOfikxGvlSUWXilYcuV/sihEX1SEPApJQzWdEhZSXXjwPQEzP+ayaLl/UXx/rxBj2G
         tPhVjP3AO9ycnlpaxSobZEKoViA09VupAPK94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a0cU5H7q1LCMAyhSWWKVmutP6bnvt+liyXXmz7rAPpE=;
        b=nXaMtwguBT3O9ETAIVCVdxkrw65sK6bppYwqeet8Z4amnTI3zw6whsNsRBBjR+tp2w
         CwqnRzTdjXuQ5hNKvn1iK2BV5Hc2+UEt3Ec9ynhIA8dRwOqjeDYmNTtQcLfBE143jW4w
         utzo+7tmiQ/lZ8droFd1pCEQOw8TaBpVRKQDrj6HBXbYuLLU2zoW2XujgjPzCxR/jC93
         PC5Xc5I5RIp2/JiAXkhY6JEhp8Mk8qkANGjvzR4WXuxybPA7oASH30ff5DECUlPrQMYq
         CtzPA45Ed8AksNQGKyic2SKoiKEHHDdTs3v0Ie3Il5JGXMkjyqO12gJB7Xb6v1MJ36cn
         tttQ==
X-Gm-Message-State: AOAM530bg5pbFzMPWWO3wz5DN5GaxO32rB+8vukbgEJDdNLWm5SWQGCC
        diKyyc6a8oOdcyJzv8jYvJiDtQ==
X-Google-Smtp-Source: ABdhPJwVsPY7GTXTFUjIi9DMjfr/UOATTkv71eqUC5T8q0RVtjoZ7h4joPTk3j6tBIP+lNssjTvbWg==
X-Received: by 2002:a0c:f044:: with SMTP id b4mr11886977qvl.3.1620164422145;
        Tue, 04 May 2021 14:40:22 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-140-239.ec.res.rr.com. [65.184.140.239])
        by smtp.gmail.com with ESMTPSA id c14sm3430708qtc.5.2021.05.04.14.40.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 May 2021 14:40:21 -0700 (PDT)
Date:   Tue, 4 May 2021 17:40:16 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Simon Glass <sjg@chromium.org>
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
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis 
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Subject: Re: [PATCH 00/49] image: Reduce #ifdefs and ad-hoc defines in image
 code
Message-ID: <20210504214016.GA17669@bill-the-cat>
References: <20210503231136.744283-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U7PH6YjyT5379uVx"
Content-Disposition: inline
In-Reply-To: <20210503231136.744283-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--U7PH6YjyT5379uVx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 05:10:47PM -0600, Simon Glass wrote:

> Much of the image-handling code predates the introduction of Kconfig and
> has quite a few #ifdefs in it. It also uses its own IMAGE_... defines to
> help reduce the #ifdefs, which is unnecessary now that we can use
> IS_ENABLED() et al.
>=20
> The image code is also where quite a bit of code is shared with the host
> tools. At present this uses a lot of checks of USE_HOSTCC.
>=20
> This series introduces 'host' Kconfig options and a way to use
> CONFIG_IS_ENABLED() to check them. This works in a similar way to SPL, so
>=20
>    CONFIG_IS_ENABLED(FIT)
>=20
> will evaluate to true on the host build (USE_HOSTCC) if CONFIG_HOST_FIT is
> enabled. This allows quite a bit of clean-up of the image.h header file
> and many of the image C files.
>=20
> The 'host' Kconfig options should help to solve a more general problem in
> that we mostly want the host tools to build with all features enabled, no
> matter which features the 'target' build actually uses. This is a pain to
> arrange at present, but with 'host' Kconfigs, we can just define them all
> to y.
>=20
> There are cases where the host tools do not have features which are
> present on the target, for example environment and physical addressing.
> To help with this, some of the core image code is split out into
> image-board.c and image-host.c files.
>=20
> Even with these changes, some #ifdefs remain (101 down to 42 in
> common/image*). But the code is somewhat easier to follow and there are
> fewer build paths.
>=20
> In service of the above, this series includes a patch to add an API funct=
ion
> for zstd, so the code can be dropped from bootm.c
>=20
> It also introduces a function to handle manual relocation.

I like this idea overall.  The good news is this reduces the size in a
few places.  The bad news, but I can live with if we can't restructure
the changes more, is a few functions grow a bit.  This shows the good
and the bad (something like sama5d2_ptc_ek_mmc shows only growth, to be
clear):
            px30-core-edimm2.2-px30: all -36 rodata -24 text -12
               u-boot: add: 0/0, grow: 3/-4 bytes: 36/-48 (-12)
                 function                                   old     new   d=
elta
                 boot_get_fdt                               896     924    =
 +28
                 image_decomp                               372     376    =
  +4
                 boot_get_ramdisk                           868     872    =
  +4
                 do_bootm_vxworks                           552     540    =
 -12
                 do_bootm_rtems                             124     112    =
 -12
                 do_bootm_plan9                             228     216    =
 -12
                 do_bootm_netbsd                            324     312    =
 -12
            odroid-c2      : all -105 bss +128 rodata -65 text -168
               u-boot: add: 0/0, grow: 2/-3 bytes: 108/-172 (-64)
                 function                                   old     new   d=
elta
                 images                                     504     608    =
+104
                 image_decomp                               372     376    =
  +4
                 image_setup_linux                          108      96    =
 -12
                 boot_get_ramdisk                           620     580    =
 -40
                 boot_get_fdt                               660     540    =
-120
            origen         : all +47 bss +96 rodata -57 text +8
               u-boot: add: 0/0, grow: 15/-2 bytes: 180/-104 (76)
                 function                                   old     new   d=
elta
                 images                                     288     340    =
 +52
                 do_bootm_states                           1304    1348    =
 +44
                 do_bootz                                   164     176    =
 +12
                 do_bootm_vxworks                           332     344    =
 +12
                 image_setup_libfdt                         168     176    =
  +8
                 image_decomp                               156     164    =
  +8
                 bootm_find_images                          212     220    =
  +8
                 boot_prep_linux                            276     284    =
  +8
                 image_setup_linux                           54      58    =
  +4
                 do_bootm_standalone                         60      64    =
  +4
                 do_bootm_plan9                             104     108    =
  +4
                 do_bootm_netbsd                            168     172    =
  +4
                 boot_prep_vxworks                           48      52    =
  +4
                 boot_jump_vxworks                            6      10    =
  +4
                 boot_jump_linux                            148     152    =
  +4
                 boot_get_ramdisk                           420     392    =
 -28
                 boot_get_fdt                               420     344    =
 -76

And looking at ls1088ardb_sdcard_qspi_SECURE_BOOT I think there might be
something wrong as that looks to drop all crypto algos from SPL.  Other
layerscape SECURE_BOOT configs show this as well.  It does however seem
to clear up some other issues around unused code, so a deeper dive on
which patch is dropping stuff is needed.  I see a huge drop on
am65x_evm_a53 / j721e_evm_a72 SPL as well but I can test those and at
least the basic case is fine.  socfpga_agilex_atf is one I don't know
about being right or wrong.  socfpga_agilex_vab dropping hashing code
does look worrying however, but maybe it's a configuration issue in the
end?

--=20
Tom

--U7PH6YjyT5379uVx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmCRvzkACgkQFHw5/5Y0
tyxz1Av9Ewf+KwPJFFPgFlDV6jMvbYJTpf6d+I6Hvf77eAgnCTfKyMWdLwfN7M7e
Vl7gQ0HIqDoqcIp2NtnyJUtPuQiLymvJYjqxARYEDTA5mDhLmO84Z+5zKGdrePSs
sS7QCjDqVf4QvIF7kV5WGTKA9mfMJcEu9ityAIc7vwuHd/3pUgr8poWeNO6KEJxw
H+wZsJMShitx4+lL47S2R1ORLMWY+Emav4ji5f29bRXGVacz6hdgziMvnNXwKIB7
cYr46Utnulo6xOwQ9EjLBwUjIAsmhIwnm7/sOr32dcPIsDnWlXKW8eJml8CCj9FD
1S0ohuUac7T8H6yEOvz3wmIKW6+zqvDx8bd9drRXxpw5lOlB9m8ibwRA8oLQRiNw
H2JBKqyv0zMDVhFjmEIvtmb7w2AznKIj1nchCeNIOzwOEXgNl8T/YIMPsRS0BjoW
XCRYGGm7EMzLL6F1bUq8mfp9mbP6ZowN6r9yVSFR1Jmlo1kyzP795UxU9OsJVyMr
Zx16tkT7
=6qD1
-----END PGP SIGNATURE-----

--U7PH6YjyT5379uVx--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8EE373378
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhEEBMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 21:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhEEBMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 21:12:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48DC061574
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 18:11:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i17so122755qki.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 May 2021 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zo7awghbyNyYVWTkcSPp6IYb8W24zjNYZMbo0XzXSU0=;
        b=mxPatJ9AKdPp6bC0TSrEnW0JopUkUfdy0XOfcv+wAj95OmBdmc6sjmCi5/N0Qoui4G
         zgDD20Pjxz4lxXZPVKRLGhUc5uaYazt3kSU2Xp58fViGmIKN2CzWTKls31xZZ/1QREsy
         SDIZc18QwZ/I4st47+zZ4hm/3injZXySYlpms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zo7awghbyNyYVWTkcSPp6IYb8W24zjNYZMbo0XzXSU0=;
        b=LBAK3WEnxR/RPfQeyFFxiYiv4mfUXfyEJdEwYazfgYIF+oPzIhOeiPVI8CxROAjc/F
         trXzPJBTGgmXdcjteYagGS0lWPu29h7BLmF3MG2fKEmIPeWF9AJHqlLvYcMR1RA46bOS
         ZXosCBBYW7F4dJu97foGsToH95niIc23JA6c2EUnmIsPPiKy5EwOlpQ3oZcFcg6mhN4m
         r5O6lhQK9m6hdC+ghsBiBjOOYFZluZZgVTpFlaxnAHxjsM5vT4S3wZ7EqznWAM02ExW9
         5w3rCTfShz4eGB5P51i2IkfcEE4e1x+SLkN0pRA3je0ZVGvRGZBtFQA2Hc/TNnov00F2
         I5PQ==
X-Gm-Message-State: AOAM532zxOXes2KvQ+skGr/sY3SgpDRRNQKLU3h5fnDzjO99w9I+yRmq
        SaubWiZ4z7iFoDAf7TsVYQUswQ==
X-Google-Smtp-Source: ABdhPJwyiSManOGN/QwLd65x7bH8hSYb5GF8YMuYWcQ73oaNoU6uvc6Mvz76Tg5cmPqEsLRHdGcqGw==
X-Received: by 2002:a37:317:: with SMTP id 23mr16092555qkd.66.1620177109403;
        Tue, 04 May 2021 18:11:49 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-140-239.ec.res.rr.com. [65.184.140.239])
        by smtp.gmail.com with ESMTPSA id l188sm12522904qkd.77.2021.05.04.18.11.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 May 2021 18:11:47 -0700 (PDT)
Date:   Tue, 4 May 2021 21:11:42 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Simon Glass <sjg@chromium.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
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
Message-ID: <20210505011142.GB17669@bill-the-cat>
References: <20210503231136.744283-1-sjg@chromium.org>
 <20210504214016.GA17669@bill-the-cat>
 <fee751a1-180b-6b31-3594-586f11549069@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FWLu4iDmFxBfQb5/"
Content-Disposition: inline
In-Reply-To: <fee751a1-180b-6b31-3594-586f11549069@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--FWLu4iDmFxBfQb5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 04, 2021 at 07:24:25PM -0400, Sean Anderson wrote:
> Hi Tom,
>=20
> On 5/4/21 5:40 PM, Tom Rini wrote:
> > On Mon, May 03, 2021 at 05:10:47PM -0600, Simon Glass wrote:
> >=20
> > > Much of the image-handling code predates the introduction of Kconfig =
and
> > > has quite a few #ifdefs in it. It also uses its own IMAGE_... defines=
 to
> > > help reduce the #ifdefs, which is unnecessary now that we can use
> > > IS_ENABLED() et al.
> > >=20
> > > The image code is also where quite a bit of code is shared with the h=
ost
> > > tools. At present this uses a lot of checks of USE_HOSTCC.
> > >=20
> > > This series introduces 'host' Kconfig options and a way to use
> > > CONFIG_IS_ENABLED() to check them. This works in a similar way to SPL=
, so
> > >=20
> > >     CONFIG_IS_ENABLED(FIT)
> > >=20
> > > will evaluate to true on the host build (USE_HOSTCC) if CONFIG_HOST_F=
IT is
> > > enabled. This allows quite a bit of clean-up of the image.h header fi=
le
> > > and many of the image C files.
> > >=20
> > > The 'host' Kconfig options should help to solve a more general proble=
m in
> > > that we mostly want the host tools to build with all features enabled=
, no
> > > matter which features the 'target' build actually uses. This is a pai=
n to
> > > arrange at present, but with 'host' Kconfigs, we can just define them=
 all
> > > to y.
> > >=20
> > > There are cases where the host tools do not have features which are
> > > present on the target, for example environment and physical addressin=
g.
> > > To help with this, some of the core image code is split out into
> > > image-board.c and image-host.c files.
> > >=20
> > > Even with these changes, some #ifdefs remain (101 down to 42 in
> > > common/image*). But the code is somewhat easier to follow and there a=
re
> > > fewer build paths.
> > >=20
> > > In service of the above, this series includes a patch to add an API f=
unction
> > > for zstd, so the code can be dropped from bootm.c
> > >=20
> > > It also introduces a function to handle manual relocation.
> >=20
> > I like this idea overall.  The good news is this reduces the size in a
> > few places.  The bad news, but I can live with if we can't restructure
> > the changes more, is a few functions grow a bit.  This shows the good
> > and the bad (something like sama5d2_ptc_ek_mmc shows only growth, to be
> > clear):
> What tool do you use to generate this output? Thanks.

buildman will give that for you.  This was from my world build
before/after wrapper, but for a single machine I have:
#!/bin/bash

# Initial and constant buildman args
ARGS=3D"-devl"
ALL=3D0
KEEP=3D0

# Find our arguments
while test $# -ne 0; do
	if [ "$1" =3D=3D "--all" ]; then
		ALL=3D1
		shift 1
	elif [ "$1" =3D=3D "--branch" ]; then
		BRANCH=3D$2
		shift 2
	elif [ "$1" =3D=3D "--keep" ]; then
		KEEP=3D1
		ARGS=3D"$ARGS -k"
		shift 1
	else
		MACHINE=3D$1
		shift
	fi
done

if [ -z $MACHINE ]; then
	echo Usage: $0 MACHINE [--all] [--keep] [--branch BRANCH]
	exit 1
fi

# If not all, then only first/last
if [ $ALL -ne 1 ]; then
	ARGS=3D"$ARGS --step 0"
fi

if [ ! -z $BRANCH ]; then
	ARGS=3D"$ARGS -b $BRANCH"
else
	ARGS=3D"$ARGS -b `git rev-parse --abbrev-ref HEAD`"
fi

mkdir -p /tmp/$MACHINE

export SOURCE_DATE_EPOCH=3D`date +%s`
=2E/tools/buildman/buildman -o /tmp/$MACHINE $ARGS -SBC $MACHINE
=2E/tools/buildman/buildman -o /tmp/$MACHINE $ARGS -SsB $MACHINE

[ $KEEP -eq 0 ] && rm -rf /tmp/$MACHINE

In a script called "uboot-size-test.sh" to dig in to individual cases
more.

--=20
Tom

--FWLu4iDmFxBfQb5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmCR8McACgkQFHw5/5Y0
tyx+tAwAjLqIJHvgYFq2Hv3MZIMSOKPkHgOV5FeselG91T4i0jkDh7pVqK5wmTlo
HSHVe6rlE1ZxOqIKQ6xKPW7Ni3GRHnplCw8wK10UlPpHYC9wC69IuyBPQx1y6lPm
ZoUjbmzw4HmdN/32oAP9MutfAjmrRt6z3rnbO6As4/0y4QyXepJK6xGWZRext6zT
7yKWDn/UkLPJ72dhuZUUEPlKNKF05bFrM1RvizadquLfAGwB8s/EV+T6Ov0wtv3W
iSJ4o+YlDOoFPNa40zaIn5gpZgTY9ZABdjKfa1iQMcaHcO3KKhi+85KXAhKZac2W
/ddyJMT5XhEVV2faTHV3ep0l3mZT5w+sFZPh7DnEMZ9xXIaowUlQW/Yj9sUyHGPK
A+XJ8Lw+lcpr+W80KYLBpZlVzkftSLWDhrSGWkn6vDzkkc/XlAaDdcAYC9KM+fQ7
HySmkoitp9qAtjP5Nf2guxR4UX9q35PTLgJUlC1QRwKH0eBCJ6FoEZKUL1i8Gp9i
O6qoQrLp
=HuEO
-----END PGP SIGNATURE-----

--FWLu4iDmFxBfQb5/--

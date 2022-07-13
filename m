Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC757394D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGMOxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiGMOxt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 10:53:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA3140FB
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657724014;
        bh=51TJ4O6UnQeKERgTH2WFCvyDtJABL/mFjQ0KcOf7d74=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=eT8ZoPyiKJPNMJhNPUTGT5uOKj59w0Rjf8bvokN7YFSAMkm9QZz5d6mG5H/sUn3aO
         sgUNarc8KYZmdjUem9/LWBMsueJLvx1xKq6dXL90rucxb9RSdtXj4Nf/nBC905fCWe
         CgXcJk8WbG4CVoVOeKVQKdROD8IprKE1d9rn7fjM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LEG-1nWkWn3w8q-015EPV; Wed, 13
 Jul 2022 16:53:33 +0200
Date:   Wed, 13 Jul 2022 14:53:23 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/2 v2 RFC] device type and create chunk
Message-ID: <20220713145324.67650a0d@gecko>
In-Reply-To: <cover.1657275159.git.anand.jain@oracle.com>
References: <cover.1657275159.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/09oWtTC7_l=pH3l84y+NFvn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:K7VfRRD65kvAe+9OG9sfosUig1Ed9FATP7MFV4usdQudDe8r7qv
 e/aHHNnjBqKpIOiSBEhqotygwWy9HHJDw2XdTU6LNuNTS++SVV/JGBFgFAgKJ+OCMCfgnk5
 aJ7dK+7qf78bHCU+eWi3Dh283Oxg6rNZ4Ac4XMT/S5C+lG38OYlaSPK6l0UFi4gOIRtLjgN
 6taEdgCqqs2rzMv7JGxAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YGEexCuRYM0=:5s5LI4Jwi0hJFsnIffFs1O
 okz2j2QTc1VOzsgsYTlGz2MPS1LLPYoL4sX1wWCkt9wr329TWrJH0bw9aTk+pl21/FgYB0i2p
 f7ElP36OE8TZWBR4HAfybSCbx6tbY+WGevtjplRg2Kr7Uszr0v4zsIP9keKiWCK0jQHx9K82Z
 KYFCC1j7l645ygy1sGv+5Mt5OBiurTNpCnsExQUx81IAJvJieKWt1hxNwHhUDLY8MEBpdrcT9
 ni0BAnImRfJUh4Bs0RjArHXMK5WoD+yfIrPtuSVcDMaTGAkvm8ltp3Ew2tsexd9U/WFn5a2o8
 g8hAouyb9p9OsQkPPIVI+nL3fxuXv8PwDM2b0uKFsvdxYF3TpJuFi/3HTH0pmM5cYF2HXPydS
 5MrF+hPwTM0wN3Eww/sO9w7oWQLxXvG7Y0apLYU8GE8r/3Ibus3jypnWiO8XLrVQKAoq5XlqN
 byOLOjro8FKF1bB92iLFoCRUvhEXVEPiT4oLXpIFVa6EIqVMOzESZhGyyahkdtKnOrxSm0JNo
 8Hs/oul79dVss8+2ANqbrzR/A0C5A/33TjutElFnNHgK1ru/1IE3Pz6NKvqWKUqr981n1/7Po
 ONu2XC6D8is+P6gNtkzgJAjsZQTn8MHwgjjGGkbPpn7YKqCEEMzhgqF9w8hWNr9KsER7S1wR5
 obD3C7fUfiBL7cKNo/CJ4exk6oKdoLm9Mt1y5Fo/vhwmbC9AsjNto52LkgxjM/bJ6jjMagDLN
 7TFMG0Vodfp0JlDKTI0lHP1ep/q9l+sUr4XbcKWcDlws17HG4QtxIWGvMxae4eM82+xbLyQl4
 a5HLAapmKNhtMNI+yXr5dNJtPziF8b9ati/CEsLbT6YD0Llpv/WZMRLiu3n+C/K0exUqw0odC
 yg+UWjChQULvgFx7t26CTERh2xr44f5ORZ+/7FU3TAJKeKdyWUZbzT6fIZxhJ/8Xsdl+/u3SI
 YHdvqeqoapqNb7vNfE8lSq5wL8wjYG+kjccc/iv5KwdUj1sjlK1NQjwyK3MzNxWXmCCVxgLwW
 3vPHd/I3TcjiJQ4cpsQTiXmxGoqmHJJ+ZlpCCAlNaq+sPH7YsyPS6wNle+M84CssqIsJv9wm4
 +V585YoojUP6u/vlBvIdu9W+RpNrEK5uXCo3zAr5pKQFewEzO+Gbg09Bw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/09oWtTC7_l=pH3l84y+NFvn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Jul 2022 19:14:50 +0800
Anand Jain <anand.jain@oracle.com> wrote:

> v2: Arrange devices by type and then by free space. Split device type and
>      its latency into an enum array. (Kdave)
>     Marked RFC to obtain more feedback.
>=20
> v1: https://lore.kernel.org/linux-btrfs/cover.1642518245.git.anand.jain@o=
racle.com/t/
>=20
> -------- original cover letter -----
>=20
> I had these patches as part of experiments with the readpolicy I am
> sending it now. This is different from the allocation_hint mode patch-set
> where I use the device type to make the allocation destination automatic.

IMHO this auto-detection is not worth it. Everyone else (lvmcache, bcache,
dm-writecache, etc.) has the user specify manually which devices is the
faster one and if you set up a new storage array you'll have to think
about this anyway.

I'd like for btrfs to be boring and not differ from other
implementations if possible.

> Patch 1/2 keeps the device's type in the struct btrfs_device so that we
> could maintain the status if there are mixed devices in the
> filesystem.
>=20
> And if so, then patch 2/2 shall take care of arranging the disks by the
> order of latency so that metadata chunks can pick disk with low latency
> and data can pick the disk with higher latency.
>=20
> By having fewer restrictions and not hard coding the chunk allocation
> destination helps to cause the spillover to the available disk space
> instead of causing the spurious ENOSPC.

If we only let the user set allocation _hints_ (e.g. prefer this device
over that) that won't be a problem.

Regards,
Lukas Straub

> Anand Jain (2):
>   btrfs: keep device type in the struct btrfs_device
>   btrfs: create chunk device type latency aware
>=20
>  fs/btrfs/dev-replace.c |   1 +
>  fs/btrfs/disk-io.c     |   2 +
>  fs/btrfs/volumes.c     | 109 +++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/volumes.h     |  24 ++++++++-
>  4 files changed, 129 insertions(+), 7 deletions(-)
>=20



--=20


--Sig_/09oWtTC7_l=pH3l84y+NFvn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmLO3GQACgkQNasLKJxd
sliPJA/9FMDegZ2MtG9Ggs2QdcBc9ARmL5JFUFlTbG1Bx38PZ3xHGLx15pAD82+b
ZkkHKwJbQuWl7bX1YFXK3H9oR7quZouesGiGWVOZ5ZgIR866/aqspR87yk5AWBxc
8ng88LlesKioroRP7Vn5QfYzqNMswj2GZ/y//356hAsLTiw8t6q+nheJM9Zy4H4O
NLjnB9VwwpGEvT7MZbcp0bT8Lssxtk+Jqe9In7rqasrA7xgxzeoGKueG8K+QvF8L
V6HA1TDLcAqyDtn/ImDeCjqOgahrpyOzfm+RX0YkEHUvyJCl9hYMTH8l8EmuiqX/
vgn4Ex1FAsHNKfzMjLCCmcnMA1DsVbaiuStaLHjlX5uIMHaHVxFDrR9JkROr3fQr
Z6lNC3K0t6ozy4HePDkmOQ1d1CnSUvL7KtaBeVEV/KSJaQhdyHPY7u3qx0hmX9L3
T0BcSXFltvXKZoHH46GDcdX43P+k4NRaP4v2DBwlpRKgWm9U3D3Zjf4ICSHgbcMD
FZvyRYpdVv7etOgeORKSY7+ThllE4W1A27DIQtmGNWhktDCHl8QUW0sqSHZJnpon
/TG/LAGLbsCVSuCzcedHhfmDsXWLG1HwNzT61TEMfxgaXzHoiQn3KP6oRUo7kMiC
qU/8ob6QB72gY8lOkIzl61ADUg7qXrSuwGW5KUJPLRYwd5IHXvY=
=P05A
-----END PGP SIGNATURE-----

--Sig_/09oWtTC7_l=pH3l84y+NFvn--

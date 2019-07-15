Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968D669F9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 01:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfGOX6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 19:58:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36374 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731475AbfGOX6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 19:58:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so13125280qkl.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6a759YhjkUDLLvSly44ZJBgDDurXCkchxNZ99/jlkHo=;
        b=Pf56CHz+M7vKcEPwRIe+7gZNjq/gr8vGv6foLNPkzKh8Fx7tP7rHhTG6WVdTBa93LJ
         f3MZzHhqsk2WlSlQzdBWKLw3FzZyF9cwpCzZJL1ZOtcGhFX49CCON5YjgnHFGY9/V54k
         VbySzuxyGrgXogxR6/p9XQOUWtRdAqhub7tVBT6ANgGAiJDSfg3P2Fjg6R22YOTV/Sba
         k8J7AoCSqwaxRZPd4TXL3oKq/lLKDnSCSwvSz6tM2jTGg5FKuvfTIT2921vRc8vREx0w
         7ENdQi65m06U5onnPyMN3Xp8gSAWnVhr3MPQA+zVBsl7BtIOgrfEvj92y20eziwLQ8mx
         Cyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6a759YhjkUDLLvSly44ZJBgDDurXCkchxNZ99/jlkHo=;
        b=Yd5EBXQVgVh4AH9PKHVR2oggd8PcG5ausvgKFecquUq5sKIhbAEXQuq+osTeGNdq+0
         CVumi2vgQKOK9MdKyeZ6E7RS1wMR4av5FiW0CXKIP/Js/uEe/TTG+c8gjj1a8HmCnSv7
         +4P+Zdyi1rQr786Q2Fx6PzI1cXH8RSI52bSRm6peQ6mpcO7SS137V03/hW2N3JoeEcbX
         RQmaHjhWu/ff6uzX4tv71w7IovcAVQdpeURBXE4O/BtlblQphmr3/hsGnkoAo2Ac2p11
         cbxpwHU7tYVuV2yrTrAimSQrpOuPSvabwwFID9VkLpweivzRQx4jx40jj2BfzFtr0wME
         onGg==
X-Gm-Message-State: APjAAAV0vm9UfO0U1kFR8KnJbta5HNWaih45/SpEJPBgr7WrtjtJMsg1
        feFHpRN8vKDG7M1ch8pzJKOlSInGE8w=
X-Google-Smtp-Source: APXvYqzfFMHElSdiF/VhPw3cK42vZwmYPIcD6x0EMIhhfwBqWRep6QXyRgpGFSxe1LEEWQhp1E6xJg==
X-Received: by 2002:a05:620a:1106:: with SMTP id o6mr18139876qkk.272.1563235103859;
        Mon, 15 Jul 2019 16:58:23 -0700 (PDT)
Received: from DigitalMercury.dynalias.net (mtrlpq0313w-lp130-03-76-66-184-70.dsl.bell.ca. [76.66.184.70])
        by smtp.gmail.com with ESMTPSA id b7sm8523088qtt.38.2019.07.15.16.58.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 16:58:23 -0700 (PDT)
Received: by DigitalMercury.dynalias.net (Postfix, from userid 1000)
        id 8498D13907F; Mon, 15 Jul 2019 19:58:22 -0400 (EDT)
Date:   Mon, 15 Jul 2019 19:58:22 -0400
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Subject: Re: [RFC] a standard user-friendly way to find a snapshot in nested
 subvolumes [was: find subvolume directories]
Message-ID: <20190715235821.rh7elbip3dgzkq7y@DigitalMercury.dynalias.net>
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
 <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
 <20190713112832.GA30696@tik.uni-stuttgart.de>
 <20190715132228.GF4212@pontus.sran>
 <20190715224051.GA30754@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="srizgt4lshvhpjoc"
Content-Disposition: inline
In-Reply-To: <20190715224051.GA30754@tik.uni-stuttgart.de>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--srizgt4lshvhpjoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulli,

On Tue, Jul 16, 2019 at 12:40:51AM +0200, Ulli Horlacher wrote:
> On Mon 2019-07-15 (15:22), Piotr Szymaniak wrote:
>=20
> > > I want a list of all subvolumes directories (which I can access with =
UNIX
> > > tools like cd and ls or btrfs subvolume ...).
> >=20
> > what about btrfs sub list [options]? (see man btrfs-subvolume)
> >=20
> > You can make ie.:
> > root@ed:~# btrfs sub list -a / | head -10
> > ID 259 gen 142795 top level 5 path <FS_TREE>/@rut
> > ID 267 gen 1599 top level 259 path @rut/BUP/190417-1748_Image_SYSVOL
>=20
> There is no directory "<FS_TREE>/@rut" or
> "@rut/BUP/190417-1748_Image_SYSVOL" which I cann access directly with
> standard UNIX commands.
>=20
>=20
> > But, I'm a bit like Andrei, and not sure what are you looking for. You
> > already asked about "mounted" and then about "list of all subvols"...
> > So you want to find mounted subvolumes or all subvolumes or all mounted
> > subvolumes or ...?
>=20
> I need a list of all subvolumes DIRECTORIES, to be accessible with
> standard UNIX commands like cd and ls or btrfs subvolume show
>=20

"a list of all subvolumes DIRECTORIES" doesn't make sense...  It
sounds like you want to list all available subvolumes (presumably
snapshots, given that the path has BUP in it), to find a specific one
you want, and then access an older copy of one of your files.

Something like the following method might do the trick:

First, mount /dev/sdX to /btrfs-admin without using a subvol option.
This will wonly work if you haven't changed the default subvol.

  sudo btrfs sub list -at /btrfs-admin/ | sed 's:<FS_TREE>:btrfs-admin:

It should then be obvious how to get out of @rut ;-)

If for some reason it's not obvious what to do next, here's a simple
method that should show the full path for (presumably) snapshots such as
"@rut/BUP/190417-1748_Image_SYSVOL"

  sudo btrfs sub list -a /btrfs-admin/ \
    | sed 's:<FS_TREE>:/btrfs-admin:' \
    | grep -v /btrfs-admin \
    | awk '{print "/btrfs-admin/"$9}'

If by "volume DIRECTORIES" you actually mean independent "btrfs
volumes" then this function will output a list of devices you can
mount the top-level of:

  https://github.com/kdave/btrfsmaintenance/blob/f7a8ed25805ed321a1dfc20b65=
cd35728c3723c4/btrfsmaintenance-functions#L11-L34

On the topic of the absence of a standard way to get a top-down
tree-like view of all subvolumes, without duplicates...it could be
nice to have /btrfs-admin or /.btrfs-admin mountpoint officially
recognised as the cross-distribution standard method.  In cases where
there are multiple volumes, this would be
/btrfs-admin/{volume-name0,volume-name1,etc}.  Then, if btrfs sub list
was run with a hypothetical "--tree" option it could provide
user-friendly output like findmnt.

Alternatively, are there any reasons why we don't have some VFS magic
providing such a view in /proc or /sys?

Whatever the implementation, I think that this class of wishlist bug
would be solved with something like "sudo btrfs fi show" with no other
arguments would output a comprehensive btrfs view of all detected
volumes.


Cheers,
Nicholas
--srizgt4lshvhpjoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4qYmHjkArtfNxmcIWogwR199EGEFAl0tEx0ACgkQWogwR199
EGG2nw//bNOeTlAnHIa1HbzVnwTvMeItlO0ei7uKOh4cd67IS/4ZI7ViPmxcfowJ
JStDQN7U1jV+/hhO2pEEKeeLJO9kZKIaJ4Mg8lvdzZMCUAk6YX5QjX/OAYB1OYw6
ioOC07LomlLLyUIJTrnTJmkJS430XAzmYEWkzOi/hiqfIg/Rf3OUoZ2+qhIzG6Nz
9yB1GEXEmF95g6LOqvsRx4CIxO+nCxCHdBBPl6sbx5QBiWkSuvlGRcGrVUFa9Uvj
qUVEWbUhKugEcwDQmIeD74NwpH3oIgj7TDgy8MXWxq109+o5qyfbpfXMqoaPrAwj
GcfPRB1386pcBIWVkTx4+AzNPfEJH0KYt/nVo2XIFTjHMMdos1HTVylEn7w0yM0/
ujV0S11x3EdVHYqFXf0bDeGg22nZFdLebqCwItckUboSMruwcboarWjNApyNupu5
L2C8KTz62FVFMqnStAqZXXxrImF+k/FV3T6zTuRbRx4FrPvld0HHChk3kTiZTJDU
XULk31inPK+Wvmf7jj33BnI2tTlKaUL/dqFRbb2l0izo61ykIoY2CDbuGLAar/6/
1I9hFOdRis8xHBYolfRV7Qa4Zc6bZNX7kVv2IXKVFip7AYEEhfQX+hWUP4P48Onf
iTmxH9QDjzuaFUUI8GLahgpBCgzIPkZd3obBPb2/0PKhLdAnpCs=
=BfTT
-----END PGP SIGNATURE-----

--srizgt4lshvhpjoc--

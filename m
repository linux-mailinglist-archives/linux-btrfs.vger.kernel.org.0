Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF81103080
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKTAF0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 19:05:26 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46038 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKTAF0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 19:05:26 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 86F264E254E; Tue, 19 Nov 2019 19:05:24 -0500 (EST)
Date:   Tue, 19 Nov 2019 19:05:24 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nathan Dehnel <ncdehnel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: How to replace a missing device with a smaller one
Message-ID: <20191120000524.GE22121@hungrycats.org>
References: <CAEEhgEt_hNzY7Y3oct767TGGOHpqvOn4V_xWoOOB0NfYi1cswg@mail.gmail.com>
 <58154d62-7f6e-76ee-94d5-00bfcd255e59@gmx.com>
 <d9cc411e-804d-d1c4-f65f-60a9c383b690@gmx.com>
 <20191119143857.GU3001@twin.jikos.cz>
 <0a8fd2a8-12fe-f899-5a53-b5f584a35878@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
Content-Disposition: inline
In-Reply-To: <0a8fd2a8-12fe-f899-5a53-b5f584a35878@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 08:02:43AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/19 =E4=B8=8B=E5=8D=8810:38, David Sterba wrote:
> > On Mon, Nov 18, 2019 at 03:08:00PM +0800, Qu Wenruo wrote:
> >> On 2019/11/18 =E4=B8=8B=E5=8D=881:32, Qu Wenruo wrote:
> >>> On 2019/11/18 =E4=B8=8A=E5=8D=8810:09, Nathan Dehnel wrote:
> >>>> I have a 10-disk raid10 with a missing device I'm trying to replace.=
 I
> >>>> get this error when doing it though:
> >>>>
> >>>> btrfs replace start 1 /dev/bcache0 /mnt
> >>>> ERROR: target device smaller than source device (required 1000203091=
968 bytes)
> >>>>
> >>>> I see that people recommend resizing a disk before replacing it, whi=
ch
> >>>> isn't an option for me because it's gone.
> >>>
> >>> Oh, that's indeed a problem.
> >>>
> >>> We should allow to change missing device's size.
> >>
> >> I have CCed you with a patch to allow user to *shrink* the missing dev=
ice.
> >>
> >> You can also get the patch from patchwork:
> >> https://patchwork.kernel.org/patch/11249009/
> >>
> >> Please give a try, since the device size is pretty small, I believe wi=
th
> >> that patch, we can go quick shrink, that means "btrfs fi resize" comma=
nd
> >> should return immediately.
> >=20
> > So it can be recteated eg. on loop devices, where some of them are
> > slightly smaller, then go missing and replace is started, right?
> >=20
>=20
> Replace will still be rejected, but we can do resize of that missing
> dev, then replace, as a workaround.
>=20
> I haven't do the auto-resize for replace yet, since I'm not sure if that
> could make cases like replacing 1T device with 10G driver happening.

That case would be much more tolerable if device replace/resize/delete would
stop to check for fatal signals at least between block groups, if not more
often.  Currently if you pick the wrong size, the only way to make it stop
is to reboot.

> Thanks,
> Qu
>=20




--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXdSDRAAKCRCB+YsaVrMb
nIxyAJ0WltDirnellMew4IkhbhYYhBIkRACfaBLtItWddhTe+OxtuxGs2s5A2+o=
=/mLZ
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--

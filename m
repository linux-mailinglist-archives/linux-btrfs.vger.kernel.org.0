Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6010EF6A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 19:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLBSmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 13:42:33 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34868 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBSmd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 13:42:33 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 08469507460; Mon,  2 Dec 2019 13:42:27 -0500 (EST)
Date:   Mon, 2 Dec 2019 13:42:04 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: add support for LOGICAL_INO_V2 features
 in logical-resolve
Message-ID: <20191202184203.GH1046@hungrycats.org>
References: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
 <3d8298c5-bab4-67f5-2bf7-8156865d949f@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <3d8298c5-bab4-67f5-2bf7-8156865d949f@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 07:02:26PM +0800, Anand Jain wrote:
> On 27/11/19 11:55 AM, Zygo Blaxell wrote:
> > This patch set adds support for LOGICAL_INO_V2 features:
> >=20
> >          - bigger buffer size (16M instead of 64K, default also increas=
ed to 64K)
> >=20
> >          - IGNORE_OFFSETS flag to look up references by extent instead =
of block
> >=20
> > If the V2 options are used, it calls the V2 ioctl; otherwise, it calls
> > the V1 ioctl for old kernel compatibility.
> >=20
> >=20
>=20
> For the whole series.
>=20
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>=20
> (Nit: This should be v4 as this patch was submitted before:
>=20
> https://lore.kernel.org/linux-btrfs/20170922175847.6071-1-ce3g8jdj@umail.=
furryterror.org/T/#t

Nit^2:  That was the kernel patch, this is a btrfs-progs patch to use
the kernel feature.

I'm assuming kernel and userspace patches get different version
numbering...?

>=20
>=20

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXeVa8wAKCRCB+YsaVrMb
nL2AAKDbZDXyH5ZLMRBMP/YfBFayI1BwHQCgwmNhCuEI5Y1OzsGRCfPLG1306wg=
=2H0i
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--

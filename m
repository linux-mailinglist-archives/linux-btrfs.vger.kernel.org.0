Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B99D401723
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 09:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhIFHhT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 03:37:19 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:46928 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbhIFHhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 03:37:19 -0400
Date:   Mon, 06 Sep 2021 07:36:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630913772; bh=Nwv2qFshiiZAKdvyrCRi7wL2pLrNpMGz/mEr9OEaIrE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=fJMul1+d73p6XUvkoEVTUw/hu1MB9X/PpgGvVotRsw8j60i4Tk0OdSgaIjx6gjNBZ
         wg4FhsNiu+UH09vzXYnmbRDC0SmYV3cqhe0Rz/zm9CzdAl+D0ld7hBR+/XXpiD7tx6
         GG2Ad8o8IbAv81e02+lIAk4Fw+7bsiyDsk946Pn3JjsEkk1D+q+1cnnlrlq/QEEGR7
         rRzuXYlWhkLH5YJ7jYY72+v5DU3GrPwSMXUwFIp+ZikzUo5lUbUatdOBhdGsU5OoQK
         JLyZNWvZUd0bo9p2/Xd4qqyh+ZthUq3V9bM28HkYx9fChuTDXqpBIvET0YhR57NNrz
         io1eA5oSNYH7Q==
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   ahipp0 <ahipp0@pm.me>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <X22KT2a2ywiYJobKrRljHvGlknKSvvJllnSFDIK-TAky7J1P0DyHwFxh4_kV0fmy_UafPSmSn86Lg3uYLIZCVPD9R1s6t-lILkdQ7L-RiNs=@pm.me>
In-Reply-To: <4b0164c3-04af-fd70-df20-a728d05d453c@gmx.com>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me> <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me> <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com> <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me> <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com> <BhXDP0Vx_AExb9FuTS6hEpr1eRkrux_n7AoNG-T1HOvtJaM7mkRN2Yifk5tIoodD5wSEfErIrpbNISVqeQyJU_w6-VePY5T060AxrmLqOf0=@pm.me> <7de2d71d-5c75-8215-d5c9-35b4c4f092ca@gmx.com> <C5tOxTE7_J1eoIcALQiUE09PG9c3gVTon54gyKHZRgDJlTI0QOVoff0zeu2REq4iHD2cWwsVmIbMTmxnBUW3Uv4_grN69kCgSRAXcWusVsY=@pm.me> <4b0164c3-04af-fd70-df20-a728d05d453c@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------138f6646493e95b832846b70956bc29a2f491751054a6393176e4ac5f6add991"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------138f6646493e95b832846b70956bc29a2f491751054a6393176e4ac5f6add991
Content-Type: multipart/mixed;boundary=---------------------db1f3b209f1e4c0f797f3a53e4b88b85

-----------------------db1f3b209f1e4c0f797f3a53e4b88b85
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Monday, September 6th, 2021 at 3:20 AM, Qu wrote:

> On 2021/9/6 =E4=B8=8B=E5=8D=883:00, ahipp0 wrote:
> =


> [...]
> =


> > > Nope, the original corruption looks like some bug in btrfs code,
> > > =


> > > DUP/RAID1 won't help to prevent it at all.
> > =


> > Oh, even RAID1 wouldn't have helped?
> =


> If btrfs module determines to write some corrupted metadata back to
> disk, both copy will contain the corruption, thus RAID1 won't help.
> =


> RAID can only help if the real problem is disks (either missing device,
> or really rotten bits).

Yeah, fair enough.

<snip>

> > Is it generally advisable to use DUP profile for metadata and system g=
oing forward?
> As a generic idea, have more duplication for metadata is always good,
> even if you're using a SSD.
> =


> Thus DUP/RAID1/RAID10 is always recommended for metadata.

Yeah, makes sense.
I enabled DUP for metadata.


Thank you again for your help!
-----------------------db1f3b209f1e4c0f797f3a53e4b88b85--

--------138f6646493e95b832846b70956bc29a2f491751054a6393176e4ac5f6add991
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE1xMgAIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZK49eAQDCQ4QSSt14LT/1a1yuGR8YC8gBX7Y0x8jQYk4aJ73buQD+MY4m
//5HnfJpcyCs4YtVGgV7tisDj71DcI6ey11g3gU=
=MhEi
-----END PGP SIGNATURE-----


--------138f6646493e95b832846b70956bc29a2f491751054a6393176e4ac5f6add991--


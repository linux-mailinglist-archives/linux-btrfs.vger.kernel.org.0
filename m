Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61815FEFA
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 16:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgBOPeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Feb 2020 10:34:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35830 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBOPeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Feb 2020 10:34:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so14510007wrt.2
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2020 07:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qXZ8V4IhUPuJWxRbU7yuy5Y/+Rv2dFZMMNeYP+Itdpg=;
        b=FPmhtQzGASxyt83Ajm80qHoQirKdHtzeKWQG6nbSjiahiK/D1annOKwnD77ZCwpULy
         0MK3bWXBcFAIOqeHnMSvefbiFJJnEu5lQFhjZU29lAYp/2WMs6eIm1hbLTMoLnyVp6sc
         /MSormygqm/WIrzEV/j0bJw6YDCbCNhTkLh+A9UbGxc6Gzo6bSNuN1SBnKYL7Iqbg+LF
         r7MmRLia07o8SamJX6B4qYbs0VCn4cB7uxfV6wORiFM2JczkDGV3SEAg1SZiw0KQsduB
         ImeZMf58nc8r1SVD52xa0q5+eQewpcxcQyP6nvt1wDtAbAjMWc60jWbGwLKHVN2kWfA+
         s83Q==
X-Gm-Message-State: APjAAAWR9ITx3hV+RxPRghqctIjlfozZeiz+iGp5Etf/lvS4xvD/6ZIi
        CysdbLZ9lLzFeIVFTpyIzDFaaTdp
X-Google-Smtp-Source: APXvYqwrXBo22X8TjPbCsC474anvE4DpmacQ2gxqYJPeDqYqVtt/lTRMg0CXxbKtpXz7RzI2/CG4LQ==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr10207965wrp.238.1581780853294;
        Sat, 15 Feb 2020 07:34:13 -0800 (PST)
Received: from localhost (0541c831.skybroadband.com. [5.65.200.49])
        by smtp.gmail.com with ESMTPSA id j14sm12168657wrn.32.2020.02.15.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 07:34:12 -0800 (PST)
Date:   Sat, 15 Feb 2020 15:34:08 +0000
From:   Samir Benmendil <me@rmz.io>
To:     linux-btrfs@vger.kernel.org
Subject: Re: read time tree block corruption detected
Message-ID: <20200215153408.a3raoibms2nlxfn2@hactar>
X-Clacks-Overhead: GNU Terry Pratchett
References: <20200212215822.bcditmpiwuun6nxt@hactar>
 <94cb47d7-625c-ab36-0087-504fd6efd7ef@gmx.com>
 <da987d5b-630f-bf41-8c5c-bb222d09e5a4@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iojxmwe2pfac5cmy"
Content-Disposition: inline
In-Reply-To: <da987d5b-630f-bf41-8c5c-bb222d09e5a4@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--iojxmwe2pfac5cmy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 13, 2020 at 22:01, Qu Wenruo wrote:
> On 2020/2/13 =E4=B8=8A=E5=8D=888:26, Qu Wenruo wrote:
>> On 2020/2/13 =E4=B8=8A=E5=8D=885:58, Samir Benmendil wrote:
>>> I've been getting the following "BTRFS errors" for a while now, the=20
>>> wiki [0] advises to report such occurrences to this list.
>>=20
>> Please provide the following dump:
>>=20
>> # btrfs ins dump-tree -b 194756837376 /dev/sda2
>> # btrfs ins dump-tree -b 194347958272 /dev/sda2
>>>=20
>>> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D19475683=
7376
>>> slot=3D72 ino=3D1359622 file_offset=3D475136, extent end overflow, have=
 file
>>> offset 475136 extent num bytes 18446744073709486080
>=20
> 	item 72 key (1359622 EXTENT_DATA 475136) itemoff 11140 itemsize 53
> 		generation 954719 type 1 (regular)
> 		extent data disk byte 0 nr 0
> 		extent data offset 0 nr 18446744073709486080 ram 18446744073709486080
> 		extent compression 0 (none)
>=20
> Also obvious underflow.
>=20
>>> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D19434795=
8272
>>> slot=3D131 ino=3D1357455 file_offset=3D1044480, extent end overflow, ha=
ve file
>>> offset 1044480 extent num bytes 18446744073708908544
>=20
> 	item 131 key (1357455 EXTENT_DATA 1044480) itemoff 6497 itemsize 53
> 		generation 952602 type 1 (regular)
> 		extent data disk byte 0 nr 0
> 		extent data offset 0 nr 18446744073708908544 ram 18446744073708908544
> 		extent compression 0 (none)
>=20
> As you can see, 18446744073708908544 =3D -653072, which means it overflow=
s.
>=20
> Both look like a bug in older kernels.
>=20
> Since currently btrfsprogs can't detect nor fix it yet, the only way is
> to delete the offending files.
>=20
> You can use the inode number 1357455, and root id 466 to locate the
> offending files, and delete it using older kernels.
> (root id is your subvolume id, which is shown in `btrfs subv list`.
> inode number can be passed to `find` command using `-inum` option)

I deleted the offending file for inode 1357455 using kernel 4.4.165.

However `find` did not return any results for inode 1359622. The newer=20
kernel doesn't seem to complain about that anymore though.

Thank you for you help Qu.

Regards
Samir

--iojxmwe2pfac5cmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO8iRpJat6BxHTtT0gmAAVevIWpMFAl5ID20ACgkQgmAAVevI
WpNqQQ//e7T5FGLINJxI1eLMBXC2RC3SsI8P462KPkHsbrqJYHisYrhaTpnjLGrx
Ley1hIVuuGb831pvkCWux1YJHEaEJHLb4CB78vANNoGNWIY6VpeOxF0SuUyD4hIX
OQDQyGv4LQ0SCre6cSEyKYuY2r7G0nsLqXWl8cva4EQ5Ax3la8oKi14lTeOQsPIC
rXcyWgsrLvWcQpvgJHLI2P6ha4fJawboBUzV66Toxg3WmK7oqZejaI8H41n/KmPN
AeUNVjcIsWGqaUZ5nXNMGLXJm9IJ8GiduXfxVM8/jJKVjS3PjH+MUmBc/xYQ2/41
Qe81d5Fou5TZj+g0aAJ9BJrhS3Hv5W+bjZy1NwnabVVZN/7HD0doDKHMfOt8pi8I
KTtmLyv+HjNaCmon03zJmU9AoPPO7Cxtj6Nk2PeZGfn/uVa5xpk/LVMZ+TaewgXV
gafah09kGkquypCxw7f3sW7bVkwbeOJebjo3KwBPGewmMm/vKYvAXLArG5KbJ0u6
KAMfea1R6nXlteCbSNFLsLpdhqpCxd9s2J68br9jZfk/dbpvFX7Au83vRrKQqUq2
5bbk1GzEDavAshNe2cb/SFmRNuBJiiu4TKDUoQzFjTY6gIar/DnoXV0r85HxNlji
Pb4DxBu9PIdZQMVrYKtzOwv53ShMrXaAvugmpmWgp96wRYmLUl8=
=j6Dm
-----END PGP SIGNATURE-----

--iojxmwe2pfac5cmy--

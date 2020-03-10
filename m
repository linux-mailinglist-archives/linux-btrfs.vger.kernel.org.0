Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6045017EE13
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 02:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCJBli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 21:41:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:54225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgCJBlh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 21:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583804495;
        bh=9/U+xK95qVwtzWK3CfdDKRwdfUSGdze8SHQWl9yvJl0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FIjLBHadtbk6ClwKja1KSeC7BHKIS0hXibCCE0i2KpTxaSXwG/dCoPFPD/hLqdGnQ
         oDKehCmCG653prT7T1hp7/4w2NDKFR4b+Usz6docxiXHMNNPN+lyTsrcijJGXRV6bo
         1uIpI3se8f2ALjz7o+LpmupRX4/ty2+FXEI0FB/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFbW0-1j7axZ2qti-00H4DB; Tue, 10
 Mar 2020 02:41:35 +0100
Subject: Re: ENOSPC in btrfs_drop_snapshot with 5.4.21
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020170c1c26e04-031eb2cc-f2da-4ba3-b259-986730cfae7a-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <f44d3ea5-7ec5-60c2-f0cb-bb9654bf7d47@gmx.com>
Date:   Tue, 10 Mar 2020 09:41:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <01020170c1c26e04-031eb2cc-f2da-4ba3-b259-986730cfae7a-000000@eu-west-1.amazonses.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5JdemBgzQOzlYYt5zvjGgt2PUhYYgFh2e"
X-Provags-ID: V03:K1:apVzDXmrgMrA0uBFtKZgkGPHYQvPsvGh7hMFiRdwAaf3lcYE8zw
 eMXeu6gTM/ZArNsL2ipMMkECg3JZZWz0eQiOVp0zqec8lJiXyfzpbLT8sG3Fsc6zQWgFi8u
 acxDu0Tv9y1MkT4TDalQaBHgsadDjaHUKy1uxskh607RReWdURNCehd/wpm4wMdju2GTS7X
 n02T+qXJQeoIAuMlAWzaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z+R11N9k4QQ=:ZFcXWYvvhVaV/wQ54vhJ/w
 IRzUHNqno90+vCgYoS/Sqv4rIEABYfWZ9pXrvdeymqek2DE+XM+/jFAs9irCimNxfZIvWqGnm
 /FOJsdnPZS6OUI+P4OgdmKpM/4vKuOJPf9jK0DRyenTNkdYLs4TywUOk+a0GbuV+dE/3UpS4W
 u3MtY1sETw6+matvuJOdQYMb+i2H/2/jHvuJ4sZ1tq2d6kiLD38DFMpxsla3tLMd65cxNgBLX
 H0kEakY9kSam/fe1Uo1VKGjLeIbzGPLTxRlrRkfDXfmb/U8etOoIpxL6l5U0tjmpKEqCDE4lq
 VszEVjyy8yeOIORpzPz+ndbncsDPOA+DOQZMXz4akWTN8X7Y/fx9DNR2V7oHKtdcsndNsAt6G
 olzTIbmTjCVSizXIO36ED1ABIQy2WhXhCvlS50RoDdApn6kY74OPxmWScRfN7TZxs+H/jxRMx
 F2tBwlcklECmznjmlAw0tMM+/h5JJdrT5MzmokBt6Lk5J/tTDEpYgLMz7UlO/V9jp65+Dm+Cy
 5rp1qAJYODL/0Gbv5IXmbs9WjCBYCZCnHSqh68nQn8kkAe7eG1kIH0KoE69iZnwPgf9S0/Rx0
 V7q0nZDOJLnQzAHK2G8O1e37DjvyncpgMaasJTeQ64gDtzA1hIfuJt6axm9Co8eDvvutPklol
 ZPpzEF7D4P6Ewn15B0DBq8aqDiTaUb7qCjG/VrJU5PB/PbvyM8f9dZVcEd08vJSjxY4BOkD30
 0G+g8/L/5caawCoT+QgLptgaO8/oeA1u/wzKj105dy888ZiEij4gPYlZjRDHYTV/e0NF15s8l
 hc31Ulh+n1kbLOVslFrUb1BAUd7JjzNKK87SQ0C/fLZrCwcN8MFs3H4zUq8UyZjJ3RsU2RQrY
 YR8hzi/NFRzWe1gp+BM/LJmY59Y8ONSo3AWxUBW7ClfipcyUlMcBgDCcTxFjEXzjRBe+reiQm
 7qPw8LVkmcEikQYv0k/ozM0GwBwE0yxTviVzMs6mW0nF1abLynwvA7N6OjOp6Jgu05BSmmpp2
 cMeKuK0/g/45u/hFXmS3p0KpA+/NnInEmGPQ66Z80wsXATsAOxNtrMLQdI9ima7Ojy095ezIP
 8gjCG+ZDr+XLplTqINyPZTD1jtOt8HMaYbF3Jr+wTb3sBGMfVSpqijb3wEux9cKU9RgeppxbY
 1NnAr2f1xc7XqbMi9iOpebmKXppFNZNVhxe3NbQvxWqs2Rc5fxA0NCE1UfDWNMrSQDcI5G/U7
 2TpsuejccHzT51No1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5JdemBgzQOzlYYt5zvjGgt2PUhYYgFh2e
Content-Type: multipart/mixed; boundary="Bm6UQmJS9ddIDV45Y1vk5UuGj44UVDsdA"

--Bm6UQmJS9ddIDV45Y1vk5UuGj44UVDsdA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/10 =E4=B8=8A=E5=8D=888:05, Martin Raiber wrote:
> Hi,
>=20
> I get a enospc to remount-ro with 5.4.21. Details:

Sorry, the attached dmesg doesn't contain the transaction abort message.

It only has the flooded ENOSPC from enospc_debug option.

Thanks,
Qu
>=20
> Linux 5.4.21 #1 SMP Fri Feb 21 03:20:26 CET 2020 x86_64 GNU/Linux
>=20
> btrfs fi usage /media/btrfs (after remount-ro)
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 511.99GiB
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 511.99GiB
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 443.68GiB
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 54.94GiB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (min: 54.94GiB)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0=
0
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (used: 0.00B)
>=20
> Data,single: Size:490.98GiB, Used:436.04GiB (88.81%)
> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=A0=
 490.98GiB
>=20
> Metadata,single: Size:21.01GiB, Used:7.65GiB (36.40%)
> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=A0=
=C2=A0 21.01GiB
>=20
> System,single: Size:4.00MiB, Used:80.00KiB (1.95%)
> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=A0=
=C2=A0=C2=A0 4.00MiB
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>=20
> Mount options:
> /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc on /media/btrfs
> type btrfs
> (ro,noatime,compress-force=3Dzstd:3,nossd,space_cache=3Dv2,enospc_debug=
,skip_balance,metadata_ratio=3D8,subvolid=3D5,subvol=3D/)
>=20
> btrfs fi df /media/btrfs
> Data, single: total=3D490.98GiB, used=3D436.04GiB
> System, single: total=3D4.00MiB, used=3D80.00KiB
> Metadata, single: total=3D21.01GiB, used=3D7.65GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> dmesg attached.
>=20


--Bm6UQmJS9ddIDV45Y1vk5UuGj44UVDsdA--

--5JdemBgzQOzlYYt5zvjGgt2PUhYYgFh2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5m8EcACgkQwj2R86El
/qiIxAf9G7dpi81Ic+iEyhh1yR52UImk/eOdLdHxWPmygZU6/wn7Z/U2e5LAwFmH
+9xNzUUe0hh1TaWeTvL3Eha6VldbXtRRBgM56VW8gu5Pd5J1McTrfwc8Wg3pv//g
k8ElCsKkP9bANsIlQ+S60p1ppdaWtmJ6lOcBbmrMyLYhqO+nUd5xrpXMBNOWwD0n
bs4i74iXOVVNZrTmXXJqPpfsvywnzHIRCGDCMSMUmtM/B0omPmbSildJwtJm28tw
Wi15ApIlkBmaCms/Req366Om/e6g4ARc1LYnDBm7iUMUMmlAjsV9AHqv0NIV73ux
zx6FlC6+VXtDkJ7NTjg9chWto2GdNg==
=Ox2p
-----END PGP SIGNATURE-----

--5JdemBgzQOzlYYt5zvjGgt2PUhYYgFh2e--

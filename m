Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422512CB33D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 04:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgLBDW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 22:22:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:48165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgLBDW7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Dec 2020 22:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606879286;
        bh=9cdxtoECzlXwux+f4gfxpZXwUP0Mv6XF2Ix4KsJxRbQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Oh0x6IqDbuQ23VSFPWnPT7iepmcVYp8tnm1lawBovjH0pn3FKwxBGeDFiKllKVwhK
         JZnTrPiGtNePJ0rlpcfo3zeZI9dyOC244ptkodujFNCucexClN+S3KzsMqWce7UiKG
         QWsXfB7DPyr4ZWn77/wSagN/Xj4TGM8CpAwk5qtA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1jtRAd09VR-00rDZi; Wed, 02
 Dec 2020 04:21:26 +0100
Subject: Re: Problem with Btrsf
To:     =?UTF-8?Q?R=c3=a9gis_Priqueler?= <regis.priqueler@free.fr>,
        linux-btrfs@vger.kernel.org
References: <f10d57a3-fbf3-ed19-aeac-6da26dc13f7f@free.fr>
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
Message-ID: <b6f26a88-b933-eaa1-6ead-b2ecc6b2e63e@gmx.com>
Date:   Wed, 2 Dec 2020 11:21:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f10d57a3-fbf3-ed19-aeac-6da26dc13f7f@free.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KCxqywUOr3G5NHzjNDXkQ0HhHqCksgxBv"
X-Provags-ID: V03:K1:vvSq5C6+BSdDhzp4zgog+oyX9fR7WhViGKQkdPgEzg2uYgApmYw
 5I0CAP0GJkgL24v5ESFL/AdxTdv4sduSpiDZGQWnaxg2TdMaO3tnR1If2osvbYTpLDntPaK
 KdOgIabgMzrGwlSFh5mtlYGPXG799WlB6uZNVy3Sz+3Z8vxYL5Eh6iz2cQzQ6y7roDVgG6h
 1jMx9jatiWKtyF+AXcQHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9FcSNKwsZNg=:eTHMW2jq9qbbTDFgOoYndb
 dFSKLbu6JotBFyeqtB/R1+T3id0mum1AfSf5aoRoAWYDb0P+MAFyFV36mzeFAWpIYgn/D9tO8
 atWftZ5lqBWILM4TFVx8e+GVPCTPMLPL8wR1ZUDac8wqPiMlr6QMHWqSIw1uLImp4Vi8Fxivs
 XlVr1QtWoTRIFQgvGt4XtiZeQv7IyPgkE46MXvOwxq7XDYN9ZgM/mV8/5cjN5UXSGOgBJA5T1
 tUIpLL8obA8YKZtfjOUpNg9pWobTM/rV8/Mk/e383HKOLk/OofT0I9orCsgTOnsDKuYjMoU+E
 hALGOMNpGBM2ehEp119iKJtX39xOOkBCSmHAaVZy9CbzKtF1Xxf9WRP7MEbJK7DtpLoCNMdLW
 CkhQu+70dVp3REGGIZ0QCb802jG+mB5UwmzZnO4eajJza0scAqt++/esXbXvEatLMkJ2/sORC
 2Ppmn11R2F1a/HGDP5JktULUpGKPWwKyGa402bJt5CuXsZ2mUC1kEVdZKNOcgfchNemlV0GTn
 As3OHBGjTKYU0CBeFm3QVp6CDoeLgw07Go66/ka9EOFcx4HSCUWE3OoxombLWeD5WQjjVbJXG
 eKo4wpO3qRdqbVyK90Ytb+hdoUXsb1WLD01TBlex0jF1QPueDjxV0su1tLXyzL1x69w5tBcV4
 /YZGYq6tFo5grAG9/imAUk1fdND/++EK4LVoovp9X2cZ+GuxABKGJPEAUtaAnXlu+MXlhVzkV
 0FA1qP1/le+ZBFPJEWZGjZMNLP5UUQRgOmJme47Rk772csTYlSpP8B3tnF1aOHs7LZF5qJKk6
 IGM2tIyjbOl0KxkNuN6v4pTqJYRW0YF/6tXUb3OfH4OmXSwI4iePxP7BGWwJHuC6vAs19XLnd
 tU7gtuCMqOr5gmj+yboQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KCxqywUOr3G5NHzjNDXkQ0HhHqCksgxBv
Content-Type: multipart/mixed; boundary="VT5lcqSYS1Uq9zFJjVb7m04EXFbmT981q"

--VT5lcqSYS1Uq9zFJjVb7m04EXFbmT981q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/2 =E4=B8=8A=E5=8D=882:48, R=C3=A9gis Priqueler wrote:
> Hi,
>=20
> My system is an synology with a SHR array of 3 2Tb WD Red (WD40EFAX)
> whish seems to be a SMR .
>=20
> The filesystem has gone to read only this afternoon (without any
> modification of the NAS).
>=20
> Synology says that the disks are not compatible because of SMR.
>=20
> As I wanted to be sure I browse the logs and found that there's some er=
rors
>=20
> In dmesg
>=20
> some BTRFS critical (device dm-0): leaf bad key order,
> block=3D2717818945536, root=3D2, slot=3D41

That's the root cause, extent tree has something corrupted.

Normally if you're using newer enough kernel, such problem should not
reach disk at least.

The vendor kernel is pretty old, 4.4, and I'm not sure how heavily the
backport is.

>=20
> then
>=20
> 2020-12-01T13:50:28+01:00 MediasHomeBase kernel: [5372093.750621] BTRFS=
:
> error (device dm-0) in btrfs_start_dirty_block_groups:4004: errno=3D-5 =
IO
> failure
> 2020-12-01T13:50:28+01:00 MediasHomeBase kernel: [5372093.766864] BTRFS=

> warning (device dm-0): Skipping commit of aborted transaction.
> 2020-12-01T13:50:28+01:00 MediasHomeBase kernel: [5372093.775340] BTRFS=
:
> error (device dm-0) in cleanup_transaction:2032: errno=3D-5 IO failure
> 2020-12-01T14:50:35+01:00 MediasHomeBase kernel: [5375701.176237]
> nr_pdflush_threads exported in /proc is scheduled for removal
>=20
> I'm not very familliar with BTRFS
>=20
> Is there a way to repair this problem ?

Btrfs check output please.

Please try the latest btrfs-progs.

At the meantime, the corruption is only limited to extent tree, thus you
still have a chance to mount the fs RO, and salvage your data.

Thanks,
Qu

>=20
> Best regards,
>=20
> Infos:
>=20
> Linux MediasHomeBase 4.4.59+ #25426 SMP PREEMPT Wed Jul 8 03:21:29 CST
> 2020 x86_64 GNU/Linux synology_apollolake_1019+
> btrfs-progs v4.0
> Label: '2020.09.17-15:40:50 v25426'=C2=A0 uuid:
> aae48b56-d453-4dfb-b5dd-3af62e923686
> =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 2.22TiB
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 7.27TiB used 2.52TiB =
path /dev/mapper/vg1000-lv
>=20
> Data, single: total=3D2.46TiB, used=3D2.22TiB
> System, DUP: total=3D8.00MiB, used=3D64.00KiB
> Metadata, DUP: total=3D28.50GiB, used=3D2.64GiB
> GlobalReserve, single: total=3D2.00GiB, used=3D0.00B
>=20


--VT5lcqSYS1Uq9zFJjVb7m04EXFbmT981q--

--KCxqywUOr3G5NHzjNDXkQ0HhHqCksgxBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/HCDIACgkQwj2R86El
/qhlbQf+KkTBDPxuA0EdjRjVAylXunHDFH5RTrVAns61es/nD/et8SBzK9ckAtXS
YXSDN/eh6KU5RrVm5hc4dSO93g1xdQ6IIa1v7QmFdubkMGj+iJ78BD4X2VMcD4iI
IwY1zkTKUzlF8v0/Ma9Rt9Kni+AYF6f5OqzCbTHachB8dDFPocV+tQLLgWnTy9KE
AIafz+sM9yFa4iSBAYZrjgMguouy8jIvTSZ26RMzrXdNVYNo/7ingRJFi9Ws7z51
6oUj7BagQCfBPgC3qVY2YDwDZGj3r0iU2E5ImzqcN/WFLbnpze/HS97URT1Brxwz
hYbWFlWK4ZP5r7UJ6Zg9WmEivzwmyg==
=rHgB
-----END PGP SIGNATURE-----

--KCxqywUOr3G5NHzjNDXkQ0HhHqCksgxBv--

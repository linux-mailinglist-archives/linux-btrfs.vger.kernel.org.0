Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C25B12758B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfLTGJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 01:09:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:45655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfLTGJZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 01:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576822158;
        bh=sJW0sL65awx9yXW4yIRud2RkK9FqZ3dF8529Xj/cIgs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Sb7pdtEJZsJP8yt/7XCqDwtd23LUPGxEUuZDHhR3ettE3WdGtVQb+TjpWhKkZJc0y
         LdrAWmyHCXTBIjTkL6dpZlK9R5trpt+Yeuo5V6Y5fNtjrpalfFahX/XUY7MhS3YtOW
         WF19x/72Dwy9NMonrkI3JMka9N2JdKZlbXlZwFxo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1i2Gsj0Y0N-00hyaD; Fri, 20
 Dec 2019 07:09:18 +0100
Subject: Re: [PATCH] btrfs-progs: tests: mkfs/011: Fix path for rootdir
To:     dsterba@suse.cz, Long An <lan@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1576564610.3899.20.camel@suse.com>
 <20191218161919.GM3929@twin.jikos.cz>
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
Message-ID: <8f45b38d-753a-78e9-8d59-6ae6bf39ff7a@gmx.com>
Date:   Fri, 20 Dec 2019 14:09:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218161919.GM3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XT08vTScmvQUumq0z0Whh2lFR6pEFlMIf"
X-Provags-ID: V03:K1:kjmsMibwsKUmFl6njGNOtxZQeYowHJo2ZVmOIq6l67fAW+hK1Zu
 g92UrZ8Y+CjncKEIfbHRJdHg5GiVcbsKR+io096m0rSU2A8oNdpW1IG/nF0fST7fy7e66cl
 LQUYzq2Ykh2nMgoE8cMKSx5hFHImE6Mqbo/zlcZ1WManPqVJheR/MR8XWW6+X+ZsE3+nwiF
 XmqStSPi3+qNg05ZyO79Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Abmhcj8S71o=:vcv2wLPQaQOARYqPcyftVf
 04cjjlwabgX83RgHeOa6iJD30zaDBrc7LeExJsj66uBT+aR/eLYkYF+E4R75MTnW2BViUBR9z
 f0MBjNOIOCUhlnNLQpul4aTx0bhiAsVJ4gIuSIRsHHd81QQu24ayUWNbkwAJcsRWGa3DybRm4
 oNIAzMfL56wicTyp4AhSdHz4swJ5kJNtMwQ2Gm/aJp6dUwt3Yj03yeKrTy7WEGOfCoz5Mz52K
 EZeHxqE1SJutu5d7kEKCjyDSNFik/9hjWhUX6X/wwJr9tlL50l5rhIw3ctk/eIRYrDOCleUZK
 h57BhhaIMJrUrhTYXhSmd8WtfFaums82pet3NZFU+3HzX//BIM+pYwv4npsfhLxc2wO148VG+
 e+6XfD6vbHYLbr3rJNvvhYvrtuWc8ln5rgP9BgyIKIMKmBIZeJoACsUe1Ku7+hybvRu6JlAf3
 LOr0+qdnrrrq1KI0WpKmd8Xo2jn/E6isY6SpWloA8DJC+0c6IK1SnxWVJs8L/5gay3iMZ1cZC
 2UdqcspTtsyoP11e1Zt6qiO2/SytvRgDsTd9xdgDkmsKBVy9Mf4/hF33ZSsnci2RQpEmCUkIm
 uLQmUgXKwbmcO+DU1nCLWD3sklJ7SIvnWjyGQ5Z/fiqYRxLNJA2V+txdK8Dl9NdHsvZlF3eoy
 NJliRWLLToG/6hldY9JD/U3a/jxknK5x+20gEMSevodjsJqZbQPRLdm9NoEWriZKJS38aEwnP
 HIkjt8P+5ea+8URjyo2wgUwUSIFnZ0djWRZEFTJTj3dbYVrcMj3ASKs6AWKfNdo8n9h/ENtq9
 9jN8oI+8FAB/fdZaWR5qrQ63krBC644BloBr46/uqOmgK2qBdcmzggzR7eo4Yi02aaPm4No8F
 AkTS31QRTRExn8hKiWo0VtJp0jvEe+0aijcPHeMdbHGHwhRCGAnFqlnK/o17FwgVWAnk18bnr
 gRHzqCwJPbWgqkYXkkJl7R4ksxCQnE3DTF8zLXJ61BCsICZekRoflefHrjuMY0NudMJrBdf75
 YF7vd8fE/JwqW635XPQzhGLwUmzKRrxwgvUw8eJxojDpIc7OvXSvHxPCK/RfYWPEBgsQ55ooc
 PFueZ7hCynNVch5PtnSihupN0uar1KjG0Lalq7OUdG89luI0LUj43VOq1uWYDZcp/mqML6fyS
 Zv551xUIBZnWknBmf5rgrJsHwlACf6IGlZP+S/lbrSKoZI4mBx/7hTu0x6nyCtUGY0pv9EgPR
 +hcWaNFZqXWWqRZWVaOVeRTiJ8hXkbjp7WlZOr7Dx5BKfmEvdxT3LJL+i6SA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XT08vTScmvQUumq0z0Whh2lFR6pEFlMIf
Content-Type: multipart/mixed; boundary="6ivRLFgLgxiPkAjRSo7cI55MEglu50x3V"

--6ivRLFgLgxiPkAjRSo7cI55MEglu50x3V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/19 =E4=B8=8A=E5=8D=8812:19, David Sterba wrote:
> On Tue, Dec 17, 2019 at 06:36:51AM +0000, Long An wrote:
>> Documentation folder path is wrong on exported testsutie. Fix this by
>> replace TOP with INTERNAL_BIN.
>=20
> It feels wrong that the tests use INTERNAL_BIN but it obviously exists
> and works so I'll apply the patch but maybe this could use some cleanup=
=2E
> Thanks.
>=20

The patch itself is kinda OK, but I guess we'd better to have some file
generation function to test mkfs.btrfs --rootdir.

Thanks,
Qu


--6ivRLFgLgxiPkAjRSo7cI55MEglu50x3V--

--XT08vTScmvQUumq0z0Whh2lFR6pEFlMIf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl38ZYgACgkQwj2R86El
/qiJ+QgAoSaV+FfSbiYPjLmb4xBo5OLbvhU4lQt6da2YPtb5JQh9vwLj16e0nvha
dkEZAdU9/2EqLHPFRwvu4UeLiLTbjZ+95dzNw/74j8aBgaYhivwM5bySltuB1jvX
Y5FgegM7aXSi5jefQxP7xCG3JBEo4+dSCGjcPtul9m5Il6BYWZnTzjT/EUFsCPEw
p6mWaNeNdexkbeGTrBHmfhufAqfoEt7OEXnRPiVsMNQo4FvNpTUecuwe9fSZGVKn
pjOqh0VrpFFkD2j6HwbA5XcOV6yCafe2fOKEknCswNAhCxlADjRY9d3az/XFEvIJ
6PKuMdgwOH2yxUVfLRc6pXi5KyuyYw==
=Weg2
-----END PGP SIGNATURE-----

--XT08vTScmvQUumq0z0Whh2lFR6pEFlMIf--

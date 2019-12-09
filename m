Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782781164F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 03:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLICFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 21:05:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:59663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfLICFK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 21:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575857107;
        bh=ENCWD72KUBehrYLuBEAtxZNoUpM8A/RvUO8KtvDFaDg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bzN222eXGjm8Pggr+2n3OivG3AHxZRbPdT4vaP9pQf91/qvLn4tN5fROdOpYaxLRd
         jk+1HFkYu7JlDmtMUKKtk/z5ZCtzviXsmYv6B+Y+QkF5jLOY/8QQO6BXdmkwkMeFf6
         uCujdPITl/AMJQupLnFGQLqnv04TLx58Av0L8IPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4JmT-1idrIx1fI9-000LTC; Mon, 09
 Dec 2019 03:05:07 +0100
Subject: Re: Unable to remove directory entry
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
 <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
 <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
 <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com>
 <CAJ0EP40UUPe9VrF1x8mxnEhFxiTzgC9DkQZB684UuMF1571D+Q@mail.gmail.com>
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
Message-ID: <d954ccdb-ac9a-1209-130c-e3b34e4a7a45@gmx.com>
Date:   Mon, 9 Dec 2019 10:05:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ0EP40UUPe9VrF1x8mxnEhFxiTzgC9DkQZB684UuMF1571D+Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UOScAeOCldPYSjbIdAi5TNfpsbQJ9Zuvy"
X-Provags-ID: V03:K1:XRncw1H9ya5adeq7DhzbH2YybdnDFGQLXhWEZB7lxfcaHxVKjVA
 Cyv2lLK8zn1Zjahm1MuDtkFgW4AusFe34ZWr8O9xFukjH9aB/S8T0Q4Ut/u+0CfNiBx7A3Q
 4eBsL1o7AHjYOoHH+wcLDblJ0igaIXvOzKlCrlYOQ5kX4uQ/f30M53ICsSCLIdHyh/aro/f
 I+bvjaWPYc9iK7s0l7OaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EJM2jdJwbrA=:Fep5thsM0NuL7RRr428Ous
 rC9+I1jtUMuRIq2ZASqh5dAFTbCo9KUP94xnLnheLsduVaHlom74RM7nCG8TUbq9oF2DbNbqa
 2U/jgUQCI8qwzJzHAMIvbdMItIaQ5fFx8yzptqDL74rsB3ZZcTLNK3fupM4TCIPYkrpClzito
 I6gd4oSn4mgxA8XnGsoTjD2gFbhqmcYv1XRbg/qlxsnDYuWdNPoV6G+DVLLceDtMMkGlYry7r
 +J3dwnM8Sc8yTgUANDDSjclfaoHTsq+FScvgnpeoqeD99VnMVe/CuW3Qvm3RmnRVJvjI3QmXc
 UAVuQVuutJg/bQFLZVTrElCl1m3RJZm+oSONEhXOuK1hBoXASLH34TAs3GFAuLxasQcWjDxCc
 8iUEd/P+17fO5uE8Xx/GaJNBFPy81rBfRzMmEg0NB6dlL7OUcXUY67/zpHOPd2cDkRjG8ouhN
 tb0TWR32CiQc1ar2I1g/GQU3IGWCW0icX9aEJzQ4wgu/pc39JsvprAI0sfCFsEKt7AdAVo9Q5
 cAqfR4ElARz2QXe4tEn7P0sZ2x49LppV3QDRlDoJRHFL9VLAbfGj8QemRD6CM1YXr4V4c2EVc
 BckNjDI2rF33ZPEbG5UYjNxvO9tXBO1RCw+KEk1whW17YIHjNvn2fizZl28nqY6n1cbkWUvXD
 FWQJrpRIqFXC5jxVZiMllxzjX3+AY5QRx6ry6DwauZkr1RhLlsWADMXr44tVSmU+4E/tv0vmn
 +mVDLb2hcR5tmf/JuovNkTKZMe6LrwQBAVvXi6EXGhoW7hsYVz6JVO5rb3ZRH3LAimt73UsxM
 H4RtRbSJCbJNrqvoVfMEp6KEL5XLfYX0LxAt0FK+g8HcIG/f8rzyFNN01jk90UKs2pIKwXesz
 CZkuNJwRDEMsl2HCzdzeQu/QIHn2VD34/sqLk0PMq49PdR3MmzWx8RV0WRIUhKfHPCSH2gJlS
 1czQtnQqeIRbcpDicvw0Ux8r/lAvjZMUdf4067V9OuiJGaJ3/SjeeyBsofxi/x7mev9dJwDvS
 oU2sge3kiBfxYKytUH6D9roKDprfZoyTi8ge18BNeeIULTPYvqAjrZY9Aoi/zWm2X8MppVLGq
 RL+H+Sv5xm4KA5pXGkDpXmPvSCIj5zGh0u+dZNPeN9cuLDMJqKmAnAVXqFiLHqFccLSwOoMqt
 ZXTneHxHksdznU0eUCoxxtUbSXJ8Y/q6XOcSsALHJuQRJ+tksitc7QDh7Unp9UQY7wZjM8EkZ
 /fIXJXpAdwDQ2kT425B/5Na5/aSYxIAYarmjtZ5APJnuhWf/gvT26pfrHv6A=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UOScAeOCldPYSjbIdAi5TNfpsbQJ9Zuvy
Content-Type: multipart/mixed; boundary="9HL2giu0joMXuTxjqp4uD5jN7SOfX7lA7"

--9HL2giu0joMXuTxjqp4uD5jN7SOfX7lA7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=889:51, Mike Gilbert wrote:
[...]
>=20
> Here you go.
>=20
> I ran this while the filesystem was mounted; if you need it to be run
> while offline, I'll have to fire up a livecd.
The info is good enough, no need to go livecd.

> --
>        item 6 key (4065004 INODE_ITEM 0) itemoff 15158 itemsize 160
>                generation 21397 transid 21397 size 12261 nbytes 12288
>                block group 0 mode 100644 links 1 uid 250 gid 250 rdev 0=

>                sequence 23 flags 0x0(none)
>                atime 1565546668.383680243 (2019-08-11 14:04:28)
>                ctime 1565546668.383680243 (2019-08-11 14:04:28)
>                mtime 1565546668.383680243 (2019-08-11 14:04:28)
>                otime 1565546668.336681213 (2019-08-11 14:04:28)
>        item 7 key (4065004 INODE_REF 486836) itemoff 15104 itemsize 54
>                index 13905 namelen 44 name:
> 0390cb341d248c589c419007da68b2-7351.manifest

That inode exists and is good.

>        item 8 key (4065004 EXTENT_DATA 0) itemoff 15051 itemsize 53
>                generation 21397 type 1 (regular)
>                extent data disk byte 6288928768 nr 12288
>                extent data offset 0 nr 12288 ram 12288
>                extent compression 0 (none)
>        item 9 key (4210974 INODE_ITEM 0) itemoff 14891 itemsize 160
>        item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
>                location key (4065004 INODE_ITEM 0) type FILE
>                transid 21397 data_len 0 name_len 44
>                name: 0390cb341d248c589c419007da68b2-7351.manifest

Good parent dir index.

> leaf 533498265600 items 128 free space 6682 generation 176439 owner FS_=
TREE
> leaf 533498265600 flags 0x1(WRITTEN) backref revision 1
> fs uuid 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> chunk uuid 0be705de-5d3b-4c23-979e-d7aaad224cfb
>        item 62 key (486836 DIR_ITEM 2543451757) itemoff 6273 itemsize 7=
4
>                location key (4065004 INODE_ITEM 1073741824) type FILE
>                transid 21397 data_len 0 name_len 44
>                name: 0390cb341d248c589c419007da68b2-7351.manifest

This is the problem, bad parent dir hash.

The key should be (4065004 INODE_ITEM 0). The 1073741824 (0x40000000) is
completely garbage.

That garbage looks like a bit flip at runtime.
It's recommended to check your memory.

I'll add extra tree-check checks, so that such runtime problem can be
detected before corrupted data reach disk.


For repair, I'll craft a special btrfs-progs for you to handle it, as
that should be the safest way.
Please wait for another 15min for that tool.

Thanks,
Qu


>        item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
>                location key (4065004 INODE_ITEM 0) type FILE
>                transid 21397 data_len 0 name_len 44
>                name: 0390cb341d248c589c419007da68b2-7351.manifest
> parent transid verify failed on 629293056 wanted 177041 found 177044
> parent transid verify failed on 629293056 wanted 177041 found 177044
> Ignoring transid failure
>=20


--9HL2giu0joMXuTxjqp4uD5jN7SOfX7lA7--

--UOScAeOCldPYSjbIdAi5TNfpsbQJ9Zuvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3tq84ACgkQwj2R86El
/qi8pgf7Bx6e2mNknrxRjncSGzJfPsiF4fqEIbG0K2XexJSrjqjMJcPHMQ4v8ttQ
HooXtObwjTChcXM4DaC7QloLxP5MudZfv5Tlv5O+mYtxbnzMZeevwmnfDSRPJUnS
SK/b0l4UHUrceoaxagHGs1j5K8zmIIU5xWTsXUVG3YhOMXQY+BP1d9uVZsF6jnYW
YOh3RIkYYIJ2L7vb2J8ECnKP0bdAaQBHUMIQ6UAWsw0FtuVMKM677xU1mMun4c2q
lryrdzaempP6leWTNwACtPIovpY89XHn11BKrpW9IJg1fhHlAV14HkxZbxdZ91zE
iCi7XtDRROn3UdXZ/REvgJQ1bG9Efg==
=Agu3
-----END PGP SIGNATURE-----

--UOScAeOCldPYSjbIdAi5TNfpsbQJ9Zuvy--

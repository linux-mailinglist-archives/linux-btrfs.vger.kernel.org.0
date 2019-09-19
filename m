Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C33B877C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2019 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405151AbfISWhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Sep 2019 18:37:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:42829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405093AbfISWhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Sep 2019 18:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568932629;
        bh=+wsqRu4nNKJZOPZFmQvChHJGR0K7/6SPOSRRZGI1Mk4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lY4OK4l7sdNDA6T7kEvsCbnwp2oxozqMZJpi9MI3PnGfag5mj718MKDtoOE48fXzT
         pvPKxn79n2hq4bzhjJArLgEcon5OepAKi136KH9ujoSvM1P4FRC2BwEdI9b6xwks/Y
         /UDr2Yh5kYS5Zfw2noiTanFEChEqdGz/054O0iXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEm27-1iRMT23Qj5-00GFAz; Fri, 20
 Sep 2019 00:37:08 +0200
Subject: Re: Unable to delete directory: input/output error and corrupt leaf
To:     "Barnes, Samuel" <SABarnes@llu.edu>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4DF2D58151C4C8499907B16D8F72881901CEC458EC@MCDBS2A.mc.ad.lluahsc.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <a9947937-ac36-f21f-8029-2b6198ec6cbb@gmx.com>
Date:   Fri, 20 Sep 2019 06:37:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4DF2D58151C4C8499907B16D8F72881901CEC458EC@MCDBS2A.mc.ad.lluahsc.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w796b1IVetciRGQf55aox5WeEZXGgHOXP"
X-Provags-ID: V03:K1:uI3s5Puk+1P6fP89oWDJqiGElEwUUgJHTsvyz+T63hUVuIZcbMm
 in1W9iFsGKwvjlpVudId5yxlJQdBFhkbO8CXDwZ6oOBlcG7CGkNlzh5UdkVsBLrWDXs8THl
 I/Ugk3NszJ803EJjj7Y3XZVDh0Yny2JflXxj2Jtx5UbqAvsxA5GsC5Bzaq7fsFV4nZAEyOO
 dnb3dn1RJ9hK5BfuCUVRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4dF6gelL8FQ=:DKgRF5UOlnkAaQ9lCKFNtC
 mmGx94/q7c7hYXbYakr1FPfu9HlvHnLrdjt6KxqaTc/k8CesJcNfHI9Rs438FgT0Ox/ZIQDi9
 lYp+AHRWBRYpSN+2VGo+U98p9wP5OE8/KE7nQieeE8MJNj4rBv0HliWVsuFsRKPqXscpx37l8
 5wZFHqxLl6yTq7MVKhIAXlzZ86bM49UcjjEHAr00Umf2fvI8rBVK5lDLMQVSNKPFFPmHLnMC+
 E9qTAFayL3SsssCz7QWyeOVOZfJ2KlvDRz9osPAyyy/ZI/hTU6LtHzUPxFRzuTNtEXZG7j7Pr
 Ooyjm44nnbanRk+h2+vyyBg+kN31xZ8IaF6m+GiefNrqSVirg50FbPkAQUTPIeB0PRXmN7q0n
 DxkKZmy6hadpBIdLzM8eg6AXIK6rSt6oitaCQy1twMiHxCjM/o/5f/A1wCGshpn4dn+EudYeW
 czvbzad2bYz+37+sgnadphtN0fP4VYONKHNh0S5LM2fIxAL2xYHySU/q8sjOCHEznTk6BI15A
 5mjW+xpSS1romTeka6HMb2pHQtCk3FUP+/80zMzs2a5oIUwYhohuDImy9PSxRGkPIMKpqLSsw
 /XsSoRlS/a5Kl2qEd7Ib7a/rj5dqk1yv3rpqped/kyl2Lhi/IbDV2JW12A9yCYJmigYqzRdwp
 uHSfXHjkqYw8abrJ3a9GJhigkGaaikFZjl76MeyA0SR+Q7EV9WZBd4tkxeJJTt0liMIQ+tXeE
 /m/Nuxb6hYcFFdu9fyuyrVKxGfWHta4yl7ahmbrT9bvFfG27acDbsl1C6D5/a+kBSLa0XGwfV
 gJz+VyHVXm96aGLQVIjcAI01cAcbq3DcQO7W3nR4OLGtFJc8JJs6KgUW1HsbcXuhgKWJAU08X
 Ujo43dWnhN8poHQny7Cpzzuym5SJ6qG2W37nExpDE4QmEZTezuc8/NH/kbCZLhXZgLI0F76Gw
 NELTXgKCSA3/T405k1P4+hrIq9IJhZf0k6+2MocRkINOlyIb5TxHW3cOaqofjuP2pB1Rh/PWN
 DicabAYrVkwcE1OI1Q0ZDgmJbFzkh7aKpMH0IBI6KShxpUnDo3LJL6znNYQHa4cWxYE3B5CRF
 szEcff0G4pdc3fOQB+KpepHNv+3ox9Ipli/5BMqUGxljO3fDbkJXujdO+O9KypEa4MWSN8F5n
 GtGI9YK9ED9Ob7gtz+8M9qyn40Cyr68Cnk6fkrPdUDyuQoU6n0XpK25LBHObqAplTHUajyGCW
 FnnDmhUDtGy6rKdt2gQZNVhCYokkTzyCkxBXbqxmpGgT4cQQleLS+SD8X6+w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w796b1IVetciRGQf55aox5WeEZXGgHOXP
Content-Type: multipart/mixed; boundary="jgWho1ICKQudxhIAkMGSO0Y8lLEEAuupX"

--jgWho1ICKQudxhIAkMGSO0Y8lLEEAuupX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/20 =E4=B8=8A=E5=8D=881:38, Barnes, Samuel wrote:
> I have a btrfs drive that started have problems, I first noticed some o=
f my old backup directories couldn't be deleted, the automated delete com=
mands removed all the files, but got stuck on the directories. Now if I t=
ry to delete I get input/output error:
>=20
> rm -rf 20190806-020001-412/
> rm: cannot remove '20190806-020001-412/backup/media/network_mriphysics/=
HAT_data/Phantoms/Penn State Coll Time1': Input/output error
>=20
> dmesg shows the following errors:
>=20
> [11655.022724] BTRFS critical (device sdc1): corrupt leaf: root=3D5 blo=
ck=3D1399280648192 slot=3D69 ino=3D8904454, name hash mismatch with key, =
have 0x00000000d8649173 expect 0x00000000f88d2ac3 [11655.027629] BTRFS cr=
itical (device sdc1): corrupt leaf: root=3D5 block=3D1399280648192 slot=3D=
69 ino=3D8904454, name hash mismatch with key, have 0x00000000d8649173 ex=
pect 0x00000000f88d2ac3 [11655.027990] BTRFS critical (device sdc1): corr=
upt leaf: root=3D5 block=3D1399280648192 slot=3D69 ino=3D8904454, name ha=
sh mismatch with key, have 0x00000000d8649173 expect 0x00000000f88d2ac3 [=
11655.028311] BTRFS critical (device sdc1): corrupt leaf: root=3D5 block=3D=
1399280648192 slot=3D69 ino=3D8904454, name hash mismatch with key, have =
0x00000000d8649173 expect 0x00000000f88d2ac3

Some old kernel screwed up the leaf.
One ITEM_DIR has bad hash. Normally it should be fixed by btrfs check,
but...

>=20
> I have tried a scrub, no errors:
>=20
> sudo ./btrfs scrub status /dev/sdc1
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
> Scrub started:=C2=A0=C2=A0=C2=A0 Tue Sep 17 10:43:20 2019
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fin=
ished
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:46:29
> Total to scrub:=C2=A0=C2=A0 1.18TiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 193.46MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>=20
> a btrfs check gives a very very long list of errors most include "link =
count wrong" such as:

That's in fact not the biggest problem.

>=20
> root 5 inode 5202109 errors 2000, link count wrong
> =C2=A0=C2=A0=C2=A0 unresolved ref dir 7424552 index 19 namelen 9 name 1=
2-25.dcm filetype 0 errors 3, no dir item, no dir index
> =C2=A0=C2=A0=C2=A0 unresolved ref dir 8454942 index 19 namelen 9 name 1=
2-25.dcm filetype 0 errors 3, no dir item, no dir index
> =C2=A0=C2=A0=C2=A0 unresolved ref dir 8616651 index 19 namelen 9 name 1=
2-25.dcm filetype 0 errors 3, no dir item, no dir index
>=20
> another example:
>=20
> root 5 inode 7422709 errors 2001, no inode item, link count wrong
> =C2=A0=C2=A0=C2=A0 unresolved ref dir 261 index 182 namelen 19 name 201=
90630-020001-715 filetype 2 errors 4, no inode ref
>=20
> I ran a balance, that didn't help, and interestingly if I run check --r=
epair it aborts:
>=20
> sudo ./btrfs check --repair /dev/sdc1
> enabling repair mode
> Opening filesystem to check...
> Checking filesystem on /dev/sdc1
> UUID: d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> incorrect offsets 9191 67118055
> incorrect offsets 9191 67118055
> incorrect offsets 9191 67118055
> incorrect offsets 9191 67118055

And this is the biggest problem.

You have bad extent tree offsets, that's a bigger problem.
In that case, the corruption is pretty beyond repair, although I'm not
sure how this happened, it's definitely not a good sign to your fs.

I'd recommend to salvage your data and rebuild the fs.

Thanks,
Qu

> items overlap, can't fix
> check/main.c:4265: fix_item_offset: BUG_ON `ret` triggered, value -5 ./=
btrfs(+0x5e2f0)[0x557b1e3c62f0] ./btrfs(+0x5e396)[0x557b1e3c6396] ./btrfs=
(+0x6951b)[0x557b1e3d151b] ./btrfs(+0x6a45a)[0x557b1e3d245a] ./btrfs(+0x6=
cf09)[0x557b1e3d4f09] ./btrfs(main+0x95)[0x557b1e37c690]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f7aec452b97]=

> ./btrfs(_start+0x2a)[0x557b1e37c1ea]
> Aborted
>=20
> dev stats doesn't show any corruption errors:
>=20
> sudo ./btrfs dev stats /dev/sdc1
> [/dev/sdc1].write_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdc1].read_io_errs=C2=A0=C2=A0=C2=A0=C2=A0 0
> [/dev/sdc1].flush_io_errs=C2=A0=C2=A0=C2=A0 0
> [/dev/sdc1].corruption_errs=C2=A0 0
> [/dev/sdc1].generation_errs=C2=A0 0
>=20
> SMART doesn't show any problems. I updated my kernel to 5.0 and built t=
he latest version of btrfs-prog (5.2.2) and have been using that. I can't=
 find anything else to try, these are incremental backups so it would be =
nice to save them if possible. Any help much appreciated!! Version and ot=
her info listed below:
>=20
> uname -a
> Linux mrispec 5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22 03:00:=
32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>=20
> ./btrfs --version
> btrfs-progs v5.2.2=20
>=20
> sudo ./btrfs fi show
> Label: 'backup'=C2=A0 uuid: d462aea8-a4e8-47a0-b5e7-ab8ec91af82a
> =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 1.17TiB
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 9.09TiB used 1.18TiB =
path /dev/sdc1
>=20
> sudo ./btrfs fi df /media/mrispec/backup/ Data, single: total=3D1.16TiB=
, used=3D1.16TiB System, DUP: total=3D8.00MiB, used=3D160.00KiB Metadata,=
 DUP: total=3D11.00GiB, used=3D8.33GiB GlobalReserve, single: total=3D512=
=2E00MiB, used=3D0.00B
>=20
>=20
>=20
>=20
>=20
> CONFIDENTIALITY NOTICE: This e-mail communication and any attachments m=
ay contain confidential and privileged information for the use of the des=
ignated recipients named above. If you are not the intended recipient, yo=
u are hereby notified that you have received this communication in error =
and that any review, disclosure, dissemination, distribution or copying o=
f it or its contents is prohibited. If you have received this communicati=
on in error, please notify me immediately by replying to this message and=
 destroy all copies of this communication and any attachments. Thank you.=

>=20


--jgWho1ICKQudxhIAkMGSO0Y8lLEEAuupX--

--w796b1IVetciRGQf55aox5WeEZXGgHOXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2EAw8ACgkQwj2R86El
/qhPAAf9EIgHrPJys7HmMaWZTD5CWw+ddiV2icX33VMAEv2qZ5SbH/nKYVWLAetR
eTsoax8sSGj+I9y4eDE2KyNTM+2Vuc7I08XMGWS203tiZ3e7LYRFLi84i8uCpZOE
EvK6DSSd6lQDv7JlEdy+2JzhK2HxOgdRB7U+DiycVwsmLXW6bevSEjQLeNHYsrNb
aFolb1F6rBf5/YKll1KFntHhDJ0or5GGnm2R20VMMcah2AXUjPK2zJx5GBeWrOLY
6KKAqr7fJKgFE2uBLDPIx7Q6VnFM0ZEL/IrUKv6wGj/BBZHsLnj1ENeFRlNsXQf/
eKVTy11c7iCd8r1vvCtkYNa813em/g==
=NG13
-----END PGP SIGNATURE-----

--w796b1IVetciRGQf55aox5WeEZXGgHOXP--

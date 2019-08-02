Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21F8030A
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 01:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfHBXJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 19:09:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:60843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfHBXJv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 19:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564787388;
        bh=eksPetsVWWWLIvO6k73tCj2L0U5FXoxT4wShKqvJMH4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=djIYsfyrKFxxCWug0EQMxKkhQSyjJMxsU4ioWfXmYT42aQ1rGdEoynvgNgoFvoM8a
         9/xlr4xfMi8Z3uhAmk1dwOq53fb0qTE/7BhbBpEvyMV+jK5oTwxAPqoTwRVSFpkp4d
         cVZlkWo4yrwSRka+g9qtuEhJo4xFQp7aCjuUdBEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lskr7-1iMOjV0KIz-012KJt; Sat, 03
 Aug 2019 01:09:48 +0200
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
Date:   Sat, 3 Aug 2019 07:09:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aSlNiuj77KEqhGOjXmmXA3Ffzy58OsClO"
X-Provags-ID: V03:K1:hwqHLDwWriJ0aDX8HklcDE0hcFy0CLALeYr5g/JQPfTl8SMsiDB
 RcCP5XLGEtSMGCwzS4z7nhnSEcCqKXvqKSfXtC3ERepJaZ/LvL2SFlNb4QwibSnfr3A15Nl
 BhlGTR6gDbSxNLo/edtLZsRK4WQ7WJleqqabIrlXmiOS0ogjv0llDwsjCCRNo+MJu26ozKJ
 pFkKD1+JtCxu4zoVu15/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHzRo04KeKM=:MbiDI7RkuYKkSVpY2/FsXC
 8aqfYSQpQT4RoUAU6YrfBA8MQhUTNg9qxdu70ZW1fnH0XhCUzDGJvEfWv2w0+arK9xzOmId5Z
 efrY/d7A3gY/VqSUZa01Bw4AFvisKNeYgn/MPJ3oCDWlQoKWwZ+hmS1fIu3ZpPtti006DHKJq
 Pu8aVyiMMTu5KSAH+1vyEaSlRFZclZ3u+sXZetpGyiEYz+CdXsHamzLONfOL5eS5ZnXGZKTaI
 aeN/rFDmGriMBV0uIoEbi92SZ0de/RcJhz2LqfpeGzlAAXeCfCxqqrtuDRQhXffBhCGnjwq7/
 m0D292uDsWua3ukOlabapBDUE5hJK/3nJNwd1LCnsX2LzKVGgg5LdRWnpMJFuSM+Z1LZ10sFa
 SjHIGSydq0yJdzTDODotAu0vu63xMdfO2IQ6BWewd/j+EHX8BNdymCFqH1VNIQYBQqmL/dg2G
 xrzouDsaaaGjlZ9BPI18V8b1HZv5aYPk2REpz866Ha4Ae4VM63v103kjYWnp4HgiICMIY4wxU
 2spjKCzhmIh0rM2k+xPO/g+rd5hQi0kj25cBNsehZ3xEfiyIcBnNpXBOOO+7ruOCFV+g0yfZq
 vCFsP6RcQGXQAt2OAtBqyNMTqO8b0QaSW2jYJCoX2ROBzOirfV/xNOz37rZtSLLx7tJ6LvUdO
 glCvU8LDdLqH0F+Wb7pKXCB3IUyL+l1lCH1hWmCa36494ElVHtJN/fMs1dZzyHz4gRCyiPvn7
 5QM/Hg0Iw9+cOk9aMPvu8w81SU9BzaqgBdcwmmomh1YfF2lk8wquaw08J2Uf1y772JG241MuU
 kKFzFxErAJz3URNDCW/nxFUY+HRHZmjhRJ8YxHLPOTpEkIMcvv+1Edn9hI+5hqT0AGZgae9LG
 uMcRlEQw19t2TJoirLMEYZyMANHMUX06QYHkwthG1IsXoxZi+JsK2kRGOC1GYyZgbS5C5J1Rf
 hK67XtubY//PYda2R8NipM7L5xewxFYNMI9qEPBMnKx2uSetMXFoTgnQSDOWz15dkUygQVZrQ
 I09u0MyHKRi1K95zQntNdCF81nL555iPP+ai1IuFPGRba9XRzaMx5D9bmOhB3MqUGtEUuPwEL
 BN7gbW4JHJBNcKOD+URQWuwu+SkpW0SlHLLz7tqbt9reigcpwbjvj5vuw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aSlNiuj77KEqhGOjXmmXA3Ffzy58OsClO
Content-Type: multipart/mixed; boundary="D5voXdOUy5g732n7plQ4Ff9u1LsscBbwF";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
In-Reply-To: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>

--D5voXdOUy5g732n7plQ4Ff9u1LsscBbwF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/3 =E4=B8=8A=E5=8D=882:08, Andrei Borzenkov wrote:
> bor@tw:~> sudo btrfs qgroup show .
> ERROR: cannot find the qgroup 0/789
> bor@tw:~>
>=20
> Fine. This openSUSE with snapper which creates and automatically
> destroys snapshots and apparently either kernel or snapper now also
> remove corresponding qgroup. I played with snapshots and created severa=
l
> top level qgroups that included snapshot qgroups existing at this time.=

> Now these snapshots are gone, their qgroups are gone ...

Kernel version please.

IIRC latest upstream kernel doesn't remove the level 0 qgroup.
It may be the userspace doing it improperly.

> and what can I
> do? I have no way to even know what is wrong because the very command
> that shows it fails immediately.
>=20
> bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 0/7=
89
> (0/789 QGROUP_RELATION 2/792)
> (0/789 QGROUP_RELATION 2/793)
> (0/789 QGROUP_RELATION 2/795)
> (0/789 QGROUP_RELATION 2/799)
> (0/789 QGROUP_RELATION 2/800)
> (0/789 QGROUP_RELATION 2/803)
> (0/789 QGROUP_RELATION 2/804)
> (0/789 QGROUP_RELATION 2/805)
> (0/789 QGROUP_RELATION 2/806)
> (0/789 QGROUP_RELATION 2/807)
> (0/789 QGROUP_RELATION 2/808)
> (0/789 QGROUP_RELATION 2/809)
> (0/789 QGROUP_RELATION 2/814)
> (0/789 QGROUP_RELATION 2/818)
> (0/789 QGROUP_RELATION 2/819)
> (2/792 QGROUP_RELATION 0/789)
> (2/793 QGROUP_RELATION 0/789)
> (2/795 QGROUP_RELATION 0/789)
> (2/799 QGROUP_RELATION 0/789)
> (2/800 QGROUP_RELATION 0/789)
> (2/803 QGROUP_RELATION 0/789)
> (2/804 QGROUP_RELATION 0/789)
> (2/805 QGROUP_RELATION 0/789)
> (2/806 QGROUP_RELATION 0/789)
> (2/807 QGROUP_RELATION 0/789)
> (2/808 QGROUP_RELATION 0/789)
> (2/809 QGROUP_RELATION 0/789)
> (2/814 QGROUP_RELATION 0/789)
> (2/818 QGROUP_RELATION 0/789)
> (2/819 QGROUP_RELATION 0/789)
> bor@tw:~/python-btrfs/examples>
>=20
> And even if I find it out, I cannot fix it anyway

Furthermore, latest kernel should automatically remove the relation when
deleting the qgroup.

Would you please provide the (minimal) script/reproducer causing the
situation and kernel version?

Thanks,
Qu

>=20
> bor@tw:~/python-btrfs/examples> sudo btrfs qgroup remove 0/789 2/792 .
> ERROR: unable to assign quota group: Invalid argument
> bor@tw:~/python-btrfs/examples>
>=20
> I can remove parent qgroup, but it does not clean up parent-child
> relationship
>=20
> bor@tw:~/python-btrfs/examples> sudo btrfs qgroup destroy 2/792 .
> bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 2/7=
92
> (0/789 QGROUP_RELATION 2/792)
> (2/792 QGROUP_RELATION 0/789)
> bor@tw:~/python-btrfs/examples>
>=20


--D5voXdOUy5g732n7plQ4Ff9u1LsscBbwF--

--aSlNiuj77KEqhGOjXmmXA3Ffzy58OsClO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1EwrgACgkQwj2R86El
/qhBSQf9GsTeyaxfZtZLvfAmT+vkafoPzZCUnLNQnG0o4MqCt/0DCoqAe9oLDErk
RqCpXURx0oXZ9RRpU4CROgbWcoMGIy6YejuTVcC4hbqZdbJoWiJ206DFfCQB/9aY
TDtVpk5xyxRmPk0Fvu4+YOOHJn3Adh4GFIgmH5atP97/MxJt+twtJQVybWnhmOk0
1zHj/ugvH/WOQ6MpS7pTeOd8Dey4G2D3TFzU5RXfkOuYtI+ok+kRMLl6Z66oJmf2
K2GMmELzS0Tqk3QdXuj2fDNtKkua8nUiBQhzKKzEBGgzvvVJX1NDhFy71Dvsh7Qp
Cdx6t2pBn4kdptP1XcPMr7zpNgDT4Q==
=w97T
-----END PGP SIGNATURE-----

--aSlNiuj77KEqhGOjXmmXA3Ffzy58OsClO--

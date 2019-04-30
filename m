Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38FF184
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfD3HjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Apr 2019 03:39:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:33141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3HjQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Apr 2019 03:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556609954;
        bh=WPgJpiA/Et+COAYdzRtlgTZdighLMs0gFy+RylRYSOY=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=HnTGyHwf+VUpkU1j84K8ROdkavkHH0OJ1mCo/Fq9IKHYJZRXdA+673DlOJWgajod0
         sj5aqPouZ2C+fODG0l9opCoa7EC9zi7+9wx3Cn8BkxORIN2kVE5URZQEqLJNIOs+yT
         wbvpX/9J1UbySqNgv1jFpAHFCHlT1M6tLaI41m3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lp8h6-1gpKKb3vW8-00exGo for
 <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2019 09:39:14 +0200
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: btrfs-profiler update: New tool to detect
 btrfs_space_info::bytes_(pinned|may_use) underflow
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
Message-ID: <daaf8812-b7c6-e761-4d69-dcae4cf6db95@gmx.com>
Date:   Tue, 30 Apr 2019 15:39:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V6qVdaiXYSo51yZVrzyXzY8Zf0iK3fLkf"
X-Provags-ID: V03:K1:czeGeOXVOmjX/tZZGRujWrF3fQ1xu2cBzqHunfCuAVA96kSF9Vy
 V8xFe4Di6Tz4DB50dj9uatJsm1vxxktMzwOV8+TAxl8fwQnyqsbKvL/V5nRCxkPm+yjQXtl
 f4pVakEk52x19hc94w70x0ILacY/GCa+GnyLx5reZlH+TQ/aGQWvMFLgdGHJx8VSabDmBZl
 gM0IGydctkIPYrM08MPuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZlDf/7rhsRE=:uVYD7dp0nW4ko6TOpQptha
 f0LWbT9PPVRbgXtKF4O8Yec7pHh08bPLPlP43mSexkttM96oMEp1tzAwNOxMuP1Y1lMoESCb6
 QtwhJ0JFh4XnC4kgIF7ZmTNfhelY+FwYjhMRmBN7++9+FLJttjJ57/Dg30ejahBFW7N127yUj
 m0DT+a3dBwDd3B2lF0g2yTDd4kPgPZG0n4At0itwPIaRdxGwbPOny9fMfSDAdSUP6Z2RFWbQK
 m1tbYfbRC/eq6CB/+JBbb2RB9rmhdVtnRGZ1sYdQllIlYuH4Oiv5RvgyxDWo0/Lg3PrFT9pxH
 DT/fCS4XVumt0z7NguvC1n2nJFYn67XMkW79bt3Iala0R+IFGUBU149dKmkD+NrBhbyMxHgLK
 TqCJsL2T7MTv/iAguUrQBI7rskP12vgy8DSf28N9I80syqm283CvoK9ZJTUQZZdrjbxgj8S22
 4W4KgqoQZ2GrOn7v/RWM4fk5kYtvY2J9VaBHeK3Epe62UUFnj0mnkYp6lEdPKYOyr4t4F8yFk
 D9ANVmy5aXLh1QaPlRJU/ZsOish9nyVpCWKEd49ntsS2czD70Zrg2zfCKdQuHQ0a3kRqcjcdy
 LXC3fsioFlA5zemIpy3scq0Q2dYzKCcI6eN3yZ1gDGg3yJlW7sJkkTMASDylbodKyqlR/2tbv
 2q5NWswa/cah9TTqqJ9/FLbnY0r3OA1fO9d+LUOliM07vE8Z9YRjMIKm/aGVtORLDZvmmSKFW
 +wu8qxML+/JqgqElCGmnsFY45RkhJ+1v1zHkDvKQSAUrXdvim/uSal+g5QNi801Q+DNPV1T7c
 7IMnW2cwOCN4BJocIF0qKYIulSn1KkDouaXxbR/Do1BBCheJVM5yhDkUk/WbbFCrgpNectb5F
 DHB8/Pl6hy7tCaYBWB7vrBm7vb4fndnYFIh8Xv6fiClzh4SzWea+SUEk8r1uE6
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6qVdaiXYSo51yZVrzyXzY8Zf0iK3fLkf
Content-Type: multipart/mixed; boundary="d1wZ5rrv5U59OYuTLAHMi6xDsPeRGkpqc";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <daaf8812-b7c6-e761-4d69-dcae4cf6db95@gmx.com>
Subject: btrfs-profiler update: New tool to detect
 btrfs_space_info::bytes_(pinned|may_use) underflow

--d1wZ5rrv5U59OYuTLAHMi6xDsPeRGkpqc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

While fixing the bytes_may_use underflow after reverting c6887cd11149
("Btrfs: don't do nocow check unless we have to"), there is a new tool
to trace such problem.

Now btrfs-profiler has added a new script, space_underflow.py to detect
above problem.

Before trying this tool, there are some prerequisite for it:
- bcc (including python2 binding)
- Extra trace events for update_bytes_(may_use|pinned)
  Can be found here:
  https://patchwork.kernel.org/patch/10921241/
- Use CONFIG_UNWINDER_FRAME_POINTER as a workaround before v5.2
  Due to bug in trace pointer stack, if using ORC unwinder, it will only
  provide one single frame of the call stack.

This tool will use update_bytes_(may_use|pinned) trace events to record
all related events and calculate the underflow independently.

Also, if it detects an underflow, it will show the related events from
last good checkpoint (the watched number reach 0), with all its backtrace=
=2E

It also support tracing for multiple fs and multiple profiles.

This simple tool can be found in:
https://github.com/adam900710/btrfs-profiler/blob/master/space_underflow.=
py

Thanks,
Qu


--d1wZ5rrv5U59OYuTLAHMi6xDsPeRGkpqc--

--V6qVdaiXYSo51yZVrzyXzY8Zf0iK3fLkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzH+58ACgkQwj2R86El
/qgLnwf/U+T61Hy0tpsqdY9I/vPey8c/x1Sa037nveQOHZ+ySM/7uuh1FvoS3f5b
K14ZlsuwshLEXEtBh6xtKMxu9dX65DvEiAGXdszUyazKEIEDKMH29MfdadIKVcL6
WTxwp/unRMod7Q7F2hPQoz82G83w1qYuzuwGF+PqdCLCjYog1FrsnriJGwjJLWqf
G1lmCLzayveyiIhyw9AH6ts6RF1qW9JoFeEq/T5J4KPyoHK/XXm6lHwSf5/a8qpy
cdZjcXgd/AAz+7GRc02ATXuNySx5QZKGFXlEkdbcG1sVcIM4dQYGI369pCMsDrEN
wmzxoW2yJgTMH2ol9fdQW4MGjxAvMQ==
=YeT0
-----END PGP SIGNATURE-----

--V6qVdaiXYSo51yZVrzyXzY8Zf0iK3fLkf--

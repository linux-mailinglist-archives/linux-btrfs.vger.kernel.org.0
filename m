Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A024665299
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2019 09:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfGKHoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jul 2019 03:44:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:34179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKHoG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jul 2019 03:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562831043;
        bh=FxFuEHbYPh33vwDHOWA8uqrYr2x4zR2mEgOdMdJD+sM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lpOo/rmF2TnFVRD4EZkKiaFpboYz6pzfPjH1WEvbcTJiZevTyMzTCrXqwR/933djL
         BOHikRDgVDeEG1QD5sb/c6y30cwpddWCd9OgogO/1yqR8Fa9P1DJXNXvoJPOMR9Odr
         /FERluKCzkErOawmPRwnAOF9CnirAW9HQ5c0Xj0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1i8FX51fmZ-00QA6V; Thu, 11
 Jul 2019 09:44:03 +0200
Subject: Re: Btrfs Bug Report
To:     Jungyeon Yoon <jungyeon.yoon@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
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
Message-ID: <b10a34bc-8d6b-e3cb-76d4-4398b4926a22@gmx.com>
Date:   Thu, 11 Jul 2019 15:43:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NjcNQqHIhqZL35DPALDxydZDzIe5wWkGu"
X-Provags-ID: V03:K1:Wuz8LGFnlPCQ6lGHJQ1k/XHw/BvLmYM9l2hUhfw/eHltq8WH3CI
 dkWTVYxA63L2rigNbeXwgXGhc0SBxRW3SNEYJVyRxMnFbF5Fsig6P5bx6QwrPoaHfhJ1SBg
 egbFgpEc99DS4INaaHVLYMBtBkJwwj75ErGNHgFaogqbDBiXKnzcLXhV3kTk53pep0PvXg0
 315366HZc1wCkdNPSbjwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n/rQEGMMMxI=:URxYt+yBF5EGWG3wmyeu8H
 RuBwdv87bAO2DF/nGw+TirsqVAfwNg+LpNnZe4AVQgH3NGdSPtlrr+a4sfkT8kIExRew2LBGj
 iOIjie20s5dPirVqQxJeBuGyraIJKGeoNieh+b2sIOG2i8bqckI0/rKQYSR5XckdoXqBMrgtp
 +AA0kDTNh1iH0CscfdimREmoJgiGTpA8nMcEr/rwOO/yWeTYGs6HKLtPd1HKUTxBbGlrUwKIH
 ymo975msKpvc7+M0/AyhWMmOf7O79LbTWCNxyfAo2YRXFNYSThqJMRZou4+/xGwXSt3UuqDUp
 Xn07jw/CZwpzxFpmLmzrQCks0w6W0RRhE8mI2pg7gw/DD8zR4kIw9JE6amXuVRfK3Y73h/YrM
 a9SdoRTTHgZqcXvTMgfvvwYXTcTahQeqcf7jIR5X2gGO3zkYqyzP7nRGZfy8f/DVC0QF1+uz8
 Sl/ZvcdKmB6LjO7TbbMeuKjqIvsbuIdsrc+lRm8zsEUWmaau3VpyfXZ31DbnDnSKdptjXDmkw
 t0V9nEamTareSNZC+YGxMEaK1PPE7+MX4lgxIQx7v1YJLel5UFpiiQ9Kxv5wp1fq4IizRS6RA
 yrZK5xc50ASJvULZeucc4XqKRja9K5RwhhSGUlVVtb7mUIXZogwpQ0bSfXMGf7J5IID1s0XUC
 7cLp5cCxWIKU5zIjfoXA30YyfB3GQP/+LILIk9oiAgXLG+CBRD5KrqXFCjUJ8T9z1+STwT9PY
 1NXDaBZIWEwv2TBKGqsSV4FZojCZ4+zhfsLFbVrgWz3NxwNAjYf7vRVw8flyMivqCeHOUncHN
 ZhqX+fClEALPhAoGtqSkKkGWC4MlqPewoMoh7o8RbF3BX0c/1vo10D4Xr0jRuNQuW4W4bUZqm
 0KYqORlIYxUnXw3Py3Vk1XlG+Fo9QR0bkn6aAE5D8InaBccdnanMAMr35jlx2dSCPqyq6Squp
 pS8kre9wIbOYzRdoMKn40452/RBYAGrdOkHcm0p00Zytfl39f0Xg0fu3UMf2J94dGytdQzTdd
 /fH4yzH+HLiFHtixtlqwwwaXgop3Vu2Bs2vOQMqS2Y0MeMhtgPL3jU5PNqDI0Pqj277PK6pt1
 GeGj8LTSxRwDEQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NjcNQqHIhqZL35DPALDxydZDzIe5wWkGu
Content-Type: multipart/mixed; boundary="2vENNjA9pQ5PmE8aBsh677exx97hzi5O9";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jungyeon Yoon <jungyeon.yoon@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <b10a34bc-8d6b-e3cb-76d4-4398b4926a22@gmx.com>
Subject: Re: Btrfs Bug Report
References: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>
In-Reply-To: <CANocb6dCc23jUTeHu9+YC5KK9X+ARNuL8aHm0PBT=UkKKXtrFw@mail.gmail.com>

--2vENNjA9pQ5PmE8aBsh677exx97hzi5O9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/9 =E4=B8=8A=E5=8D=888:49, Jungyeon Yoon wrote:
> Hi btrfs developers,
>=20
> I'm Jungyeon Yoon. I have reported btrfs bug before.
> Some of them have marked to fixed thanks to your efforts.
> Additionally following bugs seems also fixed as I've checked.
> If okay, I would like to close following bugs, too.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202839
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202751
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202753
>=20
>=20
> In addition to those bugs,
> I would like for following 16 reports to be checked.
> Most of following 9 cases end up reporting kernel panic or kernel BUG m=
essages.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202817
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202819
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202821
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202823
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202825
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202827
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202829
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202831
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202833
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202837

Have addressed all above cases with the new patchset titled "[PATCH 0/5]
btrfs: Enhanced runtime defence against fuzzed images".
Although more than half of the reports are already fixed in v5.2.


Just one recommendation for later reports.

Please, please don't use DUP metadata/data profile. Use SINGLE instead.
It will make our life MUCH MUCH MUCH easier.

The problem here is, btrfs-progs' check on tree block is not as strict
as kernel, since btrfs-progs needs to repair them, rejecting just like
kernel is not acceptable.

This leads to one problem, btrfs dump-tree can sometimes uses the
incorrect mirror while kernel uses the other mirror (correct one),
causing unexpected result for manual analyze.

This makes manual analyze more time consuming, normally I need to either
mount the fs and trigger all read on all tree blocks and let kernel to
fix the incorrect mirror and hopes no other modification is done to the f=
s.

Or for the worst case, I need to manually corruption certain mirrors to
force btrfs-progs to use the other mirror.

If you could change the metadata profile to SINGLE, it would save us a
lot of time.

Thanks,
Qu

>=20
>=20
> Following 7 cases run into assertion with btrfs check integrity options=
 on.
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203279
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203253
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203255
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203257
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203259
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203261
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203251
>=20
>=20
> Thank you,
> Jungyeon
>=20


--2vENNjA9pQ5PmE8aBsh677exx97hzi5O9--

--NjcNQqHIhqZL35DPALDxydZDzIe5wWkGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0m6LwACgkQwj2R86El
/qhgCgf8D2Mt0fSJ/Qc+GsdrxAVstlCjxg3Sgxk//9m7qg6O+PjWososJmpKB79k
X7gEsjS5N5ua/sEINaSpQJj2ZE7ldWEqAB6G7L8gB8Q85jXsTU7libwih+3/3P+E
RzZVUsKRmyxhZ87QKNJLWuxhKspd4pMuGRAuqGTOaXYP0xC+Zg6pmb6R5ELyo/1D
21Dh1dU6X0mjhRpYsi9JzBEdqz6QwvbULDtZILa+wulEfxIi53bskp0sMzgunxQO
uSEmgzXuJ+vKzZOwUrZWjK0dnZ7vX+SeQaBgmaJpuv//K/RsXBZq7EqG1dHo6mAv
llduJ003hYV6jRrVotVxVYxBT2QHzA==
=lAjS
-----END PGP SIGNATURE-----

--NjcNQqHIhqZL35DPALDxydZDzIe5wWkGu--

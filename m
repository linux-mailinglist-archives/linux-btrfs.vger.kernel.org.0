Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11DA4F2E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 08:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfIBG1y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 02:27:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:59587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfIBG1y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 02:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567405668;
        bh=s82DwtA8W4vtdSby5bkeJcvWhzlDwe5/JMP+ws5Oiqo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=S5lPk2R0XlA54+YM5ENxocP6iQ+XItLEiGMV6yiV2LT9dxZFrEH+zCsfdwqXKmmkX
         axto8eg7Kc8QpIVIAgW95MgahxXzjG8oLnfSFSJcaYbQtCQZ5kLM1KZ14uBCaGvZiZ
         oySLCY89a5D6bXiIzQii2AemXeGQ9XjxfnSyOiVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1iHCDd3PmA-015pmb; Mon, 02
 Sep 2019 08:27:48 +0200
Subject: Re: block corruption
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Rann Bar-On <rann@math.duke.edu>,
        Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
 <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
 <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
 <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
 <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>
 <270df1b2-0564-53a6-3cb0-e8d4245c6ed6@gmx.com>
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
Message-ID: <2cb3f9b8-c265-a421-4c5a-1c92eff8de49@gmx.com>
Date:   Mon, 2 Sep 2019 14:27:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <270df1b2-0564-53a6-3cb0-e8d4245c6ed6@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ErO0aEyhKoX7D4mCB9YA6dmNQjgshvGcb"
X-Provags-ID: V03:K1:uTxq7fets2pugyQCNxB/5UOdE1qprPHEeYB181rzpwVFYe2l5Co
 MS+GK4gFszDLY4JmuV74agP+4LpeOze6rX8hQdpSItBZVU2R4brbV1V6NTrLhRllys4b1tG
 LB+6J/LOx36ij72e5L/z59KozbTgZcBoZTexpvzLo5GIAPV6GbtzUOAzBDmrGiVVWsUsUZb
 070AYLQl0OdUY2479jrbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+tDbj1wZv6o=:1NfyT/C3KPSCQUbYJUzNMv
 HLNJH29KeHno9ddXKMh8RfVrAGUtW8LB/Nzm2XFq72EwIV3SaSPDldm3PLzysYz3GxF+jEoQw
 XnqoDym6TfrQYP4YnNdOOe0OgY3KQlM9cyMGLQY+HwnI7JOajfHPTTKpGcb65AIPK/9ZVNA1R
 abHZ2ZYHUM0/RrFC+W3tQSgy5IEjvwiYF9KEE5EmCSeTcD/aqjXEl+K7xpB7F98Pai8MiMEiG
 PPf7P3OpbrKK0lIeO/JPzOobnffMT032Inc3hF+1+rAqOKEStt3GuuskTohBTs1bcczrnAWCB
 Prrar6YrsEhtDjkn/xHB5XWtzmUPtLAFgLloYuKJyeOF/7e+Zyc4037a9fsYaGzyc0HWfwRFo
 nxkdzO81XFQ1ii9Oe0+QxQfXi47+AgMDuT0JXVeiyRcBsYr4tFrYWlg16OF8lyxqcWYYYN9QO
 kHpXHUcgzINz8RtMPhrePEd/3vd696ziGcXuVstGgZcWyPjL3ViPSyHhzw/LbuMF5ka2vOYiv
 vYoWX/MQXGd57i4SDT9CuLVXBiR3KzHgVCFmUGMa2B6PDxLH91Lgo65za84vqw5gaxaaXLE/0
 6ahAXu6KUJcqeZ5LhlWCdfTsnNThtcT1qlJHL8iIJuzNjOPurEdYaZkIc4pvs9PFa0unCF7JX
 YnKogsTMhkRJ/cvfZHSSippB5QsBbm+QCJJBicDlxFLiBG6HsIIybdGmvyDd7xkKKEGdw/hka
 6CbptM4uwZCUu4EvWrICqpLUCZJ3TRZW9XEQdn5VuPV7aOnZ9egOq0yKaUwkTVWaPvUaMEuKw
 /e4jCYkNqFCeHsmdxs9+jrPTcJjtGaDuTnwCElGgz2yKvh1xxntVRDtE9J3o+6UtgbRJb0Xzd
 RB18ZkjZUeE/ox6LvhSqU5DFBWH94OMeXmyugywzrHfegDjav2e77er0yeOKn20OSeZV90Ghp
 Bc77kUZfY5KBUshAqhiX4hC6KPXOM6M6R0LQj8eZ+q5F21vD0W2ddOgRU0Wk9FKUtd+uczpzp
 4kXHS5RT6eNyyURykBL2cojuI+ZAFbcZfip09/3SK70vgU7x2scu/5xbOrZyvHUpYsGQuJ7Pn
 OLtuCr9YC+OCNLqI4osw4V7AH3LhQcuF9NK0gICE1YTuTX+g4WDjvScXIBhrsX3PbTJnQl4wE
 dVzaaXmTiJLEdJScZUpAD132L4R1vT3+zFq4wLnq+kszRFXQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ErO0aEyhKoX7D4mCB9YA6dmNQjgshvGcb
Content-Type: multipart/mixed; boundary="Ic5yMNbRflI4PTOUbduufVL1S9QzLyFBI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Rann Bar-On <rann@math.duke.edu>, Chris Murphy <lists@colorremedies.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <2cb3f9b8-c265-a421-4c5a-1c92eff8de49@gmx.com>
Subject: Re: block corruption
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
 <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
 <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
 <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
 <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>
 <270df1b2-0564-53a6-3cb0-e8d4245c6ed6@gmx.com>
In-Reply-To: <270df1b2-0564-53a6-3cb0-e8d4245c6ed6@gmx.com>

--Ic5yMNbRflI4PTOUbduufVL1S9QzLyFBI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/2 =E4=B8=8B=E5=8D=881:33, Qu Wenruo wrote:
> [...]
>>>
>>> I'm curious if either 2 or 3 are permitted.
>>>
>>>
>>
>> Wish I could help, but I already deleted the file. If there's somethin=
g
>> I can do to move this forward, I'd be glad to.
>>
>=20
> Maybe it's too late to mention, in fact "btrfs check" has the ability t=
o
> find such problem.
>=20
> "btrfs check" has two modes, original mode (the default one) and lowmem=

> mode.
> The latter is mostly written from scratch, thus it has more strict chec=
k
> rules (not to mention it uses less memory while will be much slower as
> it causes more IO).
>=20
> If you're not sure if those inodes are the only offending ones, then yo=
u
> can try "btrfs check --mode=3Dlowmem --readonly" to verify.
>=20
> The support for original mode will come very soon.

Wait for a minute, that report and repair functionality is already added
in v5.1 btrfs-progs.

Are you using some too old btrfs-progs?

THanks,
Qu

>=20
> Thanks,
> Qu
>=20


--Ic5yMNbRflI4PTOUbduufVL1S9QzLyFBI--

--ErO0aEyhKoX7D4mCB9YA6dmNQjgshvGcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1stl8ACgkQwj2R86El
/qivUQgAg5Z0JWNGEZ4sD4Jumypky97RinU72rjKtUeTLL199ZwOuBfQe0gnuWw4
YEtF9H14FzN/2rlc0UxXh1pW8Vxg+lbVjEYFC5f6UfdFYDQFtklf3E7M/nPLcOou
bhYULVdL6hGlGZ/05CGAVWv7dGWHtcMO5Q+dftnMU2d0TQjo85IzYH+oe/OSxmBQ
CHwG0/FZnp116KSYe4Odb4XW1N2ri9tuDHRZzg5DOq6Fs6s+WOGhGjWSJVQKeRU1
68k69JChrQuvnESi77Fcl13m4UJi+j6ishdpGmiXUp2VLhcRMw2X1i+cdsZXDadN
tJG788T4bi4F2sCbpz8L4ZoGN0fgDA==
=4dbp
-----END PGP SIGNATURE-----

--ErO0aEyhKoX7D4mCB9YA6dmNQjgshvGcb--

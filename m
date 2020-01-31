Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D161714E6E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 02:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgAaB5m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 20:57:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:49823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgAaB5m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 20:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580435846;
        bh=/iG0QajrWuwutGHiHJ2jKaj50UzTr7Tp5Ps4qsCmb2Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Snv0agG8Mq3wwdkGWDmmj35XVuT1ZKnlknz4jSmrEbmKY+/Vs8VzQi0eyKg2EC66k
         FcRBADg/y2FYr8Y7UREY7htpmOaB0OKgx6f3P7q4JI2h0M6Yr822Vdu6+12robuAGI
         U+stuyQZQUDRnQ2zYE0qf8cAAR7qDzNrQGcd/CHA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1jD6Us3hz5-00QD8p; Fri, 31
 Jan 2020 02:57:26 +0100
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Matt Corallo <kernel@bluematt.me>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1746386.HyI1YD2b7T@merkaba>
 <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
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
Message-ID: <7ab6c91f-6185-06be-0091-f3540858de29@gmx.com>
Date:   Fri, 31 Jan 2020 09:57:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="slYtH9T99bSkRVpOQusSoVyfC6jYD2MLR"
X-Provags-ID: V03:K1:nLZLw61ufGgULNpdJ7QPP758fpcjXV9Z1K6idUJNTGyuUI24d8g
 1L30ateUCkrTwsiZkOWptLQwBF2CTSrM/Lf+t259xdRJ6tUz+jyiIq4qpkbovjpgMtLDbRf
 zBEU841wrgEfVHZJPiMeWvsX4uH+MnY086K5aEjJZ9cwDsiVGnulKQQaniu5kSsms0ap5lq
 qIf+yICvRjhF034WOeqPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cSK0tcb9psU=:QzQkzYkCQywVymTy4wqZVv
 bUR2jNjB0HGbP/Azgsy7K2Cpz6ivL3czke2I+zTImjWRs0tzzdNUbqXmuoNE8bNXyoRHVPVF0
 cvaqOebYpZaWxkPC0nbWlqUd/tAsQPQ33GJEVfPLb0spqXWuIenQ3DZBSiePSELE+YMqR2b/P
 TVRKbXPzCWrnjdLXlXyLW9vgAemsftqves9Cvt3HGfrA4yWwnRRl/NHzSGvir4CFqr5g63OT3
 t6NcUvmpvTt0pf59ao2kVubg8V4+T4ZKkSPG/28vUP5+lI5o0eczNjUd1iqzZf5gi0rk5xIXE
 X4kPS0soEMgMcyOaUuIPdX3e4hyB5x3sWQ1+J2qUhXU6FGrNZLhMBAY3noL+QxVFbub8xbJQT
 c+mjg7fJLzxrDOeN1xKNSJaszjy2vzD09qVTSL7qBjztaEQaQPCV3asHLwFUZE7N+qDIZWhhK
 VJYBP9G/lgpgR1sPTO8l/fvbt2ofRpJuouc35DB4QTRM8wtT2oCNb+8tbr2PikNuZtURbRquz
 NsGK6Hmq0jc/zBF1As8E++HMstpGhkmgqNYIC2iwG1vQVv5RMXhJJu97XEydkKKPven37kjVA
 jnkIxU7L7dGHB++bmgoUMzKoYfRFiZe6zmR3UC1Mds8AnwAWCUv1tVXIIco2J1EDOE2IsgCit
 LDIHzq5x7xVtNXevE3sBqfp+/Y1oWjUSS3lUhy0GizuWu8HUeVAx4FijF02+iu4FsrxOdvEmf
 I94fUF+tMfDKxup07QduHif+yrfBKq+zoEHuW8Cl3VFUXixfEvh8KQx/dmuPJ2xtqMd6yRFYU
 XfwC2gm1vScUCG8FWbl+g2YIttIwwBco2lH+G5HSpzR9HGcvaAWvG+/m+o5RnvE8hWlj9+LQR
 4M4DRxFAexBPsS5MpSaOoTibRyqiDNL8/ZUzWKXeiShxi/hKvNSyMSLUHkHkQG34vFoUiq6At
 V+J41VmoY4rsLWGyP1JFtQplLwSQ5aoJeznEprMYQjJ+QcRSxYCrPFVqwW5jM/QlzWXT5AUDu
 kxRZ730p3h8pqTzuEmGQGgmxBj8uL+2ouqERnZgxciLCYvIezkJoDbGP4vw58NXpSJv6ZhyxJ
 jG4diFjjov8QC+/QbagFYgdg2e5x/Awy7LHofsSpnen6CQXYJktdHPba4/zYsbnaQe30Nsuqt
 DW7EGl9keRvWsJSBtta32NZYU6EMFNrYdfYPOk/nclc/Z0sOy4riXfr9UsmdFoSOTrO6dfW4Q
 2KdFTpr/xE2UjpkVo
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--slYtH9T99bSkRVpOQusSoVyfC6jYD2MLR
Content-Type: multipart/mixed; boundary="qJ3RnhK9PklUtpAmychM16M3OVL423zcL"

--qJ3RnhK9PklUtpAmychM16M3OVL423zcL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/31 =E4=B8=8A=E5=8D=889:43, Matt Corallo wrote:
> This is a pretty critical regression for me. I have a few applications =
that regularly check space available and exit if they find low available =
space, as well as a number of applications that, eg, rsync small files, c=
ausing this bug to appear (even with many TB free). It looks like the sug=
gested patch isn=E2=80=99t moving towards stable, is there some other pat=
ch we should be testing?

That mentioned patch is no longer maintained, since it was original
planned for a quick fix for v5.5, but extra concern about whether we
should report 0 available space when metadata is exhausted is the
blockage for merge.

The proper fix for next release can be found here:
https://github.com/adam900710/linux/tree/per_type_avail

I hope this time, the patchset can be merged without extra blockage.

Thanks,
Qu
>=20
>> On Jan 30, 2020, at 18:12, Martin Steigerwald <martin@lichtvoll.de> wr=
ote:
>>
>> =EF=BB=BFRemi Gauvin - 30.01.20, 22:20:47 CET:
>>>> On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:
>>>> I am done with re-balancing experiments.
>>>
>>> It should be pretty easy to fix.. use the metadata_ratio=3D1 mount
>>> option, then write enough to force the allocation of more data
>>> space,,
>>>
>>> In your earlier attempt, you wrote 500MB, but from your btrfs
>>> filesystem usage, you had over 1GB of allocated but unused space.
>>>
>>> If you wrote and deleted, say, 20GB of zeroes, that should force the
>>> allocation of metatada space to get you past the global reserve size
>>> that is causing this bug,, (Assuming this bug is even impacting you. =

>>> I was unclear from your messages if you are seeing any ill effects
>>> besides the misreporting in df.)
>>
>> I thought more about writing a lot of little files as I expect that to=
=20
>> use more metadata, but=E2=80=A6 I can just work around it by using com=
mand line=20
>> tools instead of Dolphin to move data around. This is mostly my music,=
=20
>> photos and so on filesystem, I do not change data on it very often, so=
=20
>> that will most likely work just fine for me until there is a proper fi=
x.
>>
>> So do need to do any more things that could potentially age the=20
>> filesystem. :)
>>
>> --=20
>> Martin
>>
>>
>=20


--qJ3RnhK9PklUtpAmychM16M3OVL423zcL--

--slYtH9T99bSkRVpOQusSoVyfC6jYD2MLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ziYEACgkQwj2R86El
/qiIGQgApN4mMSYa09MgTR9u9E4WWTAkMYC9HOVdssKodLQNwvL68qQGBekApJ7t
y2gwCh+PmJ3I8HepXEkvLm/KaEFpj/ZcDiXh//8iCsqVTaJufqQVPBeHzX3mtriH
wX0oj29ty8AUy/2eoyzTsCNBbmyubkAy4U1B1Rur/TUf/CsWeIZV1BpkvaJuwYMm
3tpccnmm60x5OrXozeSnLSQgZf6/FT/r2JmByxlPEjneFKno4Q/OAGFd0KY2Rmjl
FTIX+wjysCLTL7b4H1FXYYJrfq7L4eCep2j2YOwHmfe82Jz1Kon2smj6iJmEq29e
LiVDb/cO8lf8cow4khBE4t2y94zK8w==
=p9hY
-----END PGP SIGNATURE-----

--slYtH9T99bSkRVpOQusSoVyfC6jYD2MLR--

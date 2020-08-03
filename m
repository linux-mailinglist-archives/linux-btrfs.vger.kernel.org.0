Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086E23A065
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgHCHem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 03:34:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:59709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgHCHel (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 03:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596440053;
        bh=rE/IbWeL9F+Ag6VPwuUxzNj3EBCGD8LCYDfqUl7vu6s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=axDEv7prwnJuBHXwvHrTWj3jK0OGF2vZl2ciWB6n+dL4YN+LuFulAiwPpU6sKLSQw
         qnAl+x6eEKhu/zDuzyT0SH79YhHhq+h3EQgT519BfilmhQJAbHSLDOdxMBWMGgzpUe
         pZTuzt78uxLr8gQvCuBPudZN8Sv0aqITQOtOxwMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1k79113RJn-008bit; Mon, 03
 Aug 2020 09:34:13 +0200
Subject: Re: [PATCH] kobject: Avoid premature parent object freeing in
 kobject_cleanup()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <guenter@roeck-us.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1908555.IiAGLGrh1Z@kreacher>
 <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
 <CAHp75VcbSR1NSSPemg5dMyfp00uC4wkktVjKSFx4sjSgFC-_vQ@mail.gmail.com>
 <CAHp75Ve0AozEbB_kc+S4qaZJxJJWf20toDK-T2QHYi1o2hfJBg@mail.gmail.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <703338a4-4806-f919-9ed8-b06749b748b4@gmx.com>
Date:   Mon, 3 Aug 2020 15:33:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve0AozEbB_kc+S4qaZJxJJWf20toDK-T2QHYi1o2hfJBg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fsqg85kF8Lun4LYR6YcEnvM7ZwZrbfYoF"
X-Provags-ID: V03:K1:N5hYrRroCY9MwDHcZf+32NMQmGP81L7NfZTf1DQfNGN3nu6ZWYb
 ZPhBHzMl38oy7EeOrc0vkec78wRp4kr8RsDGGQ8Mq1ekNx1lrvoozxVD0legeYw+Kf+VDar
 df1pzf2B3Rd6+rQBhJ19kqgZVChHOGyHCjlpEDLHmkTSYGmG5OpbBcB34FhTq6DnW+ZJKev
 sQ8nzY1zcLu66uk+oGjNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:59ae4JHQ1oE=:CQ0bJiHsi9Gtu97LeUU7nv
 cQQFlikMLn5NuoVYECoXM2mH06QJpjX5Ls9PafP42oM8j/5ZaMOSeGYgQgppvH/RJQ7/rHRiW
 i80GxNooOPmn6R3NNej3SW8PYdRQHkdJpkdX00iFmo2096+C5L5luQGwDESGU1efHlfiw45tj
 9Lul7QGSKxVjLLkI90E0+XyAp1Sf7eHLAspeawawTK067nAwPSYZs9QXUUNMwUM9UNnLudKqx
 P8c2J/nG/2MchccAjjDzOGRgLmPi3y3CO0999zCbJGGvnbTX9jDDeihqH8f3xuFTar201LKf+
 BKKhvFY/4MVcEVYPB2TVP7SBCJcOzOIjkdSkhYN5E4EpvRohs7oeESQuOh7vVxGbpSmdiJ8MP
 vDYpkAhzek4nAyTHhZFR+3i1IjPm69c5vbs/PGEAyYU9It3kj8Qw6zPYB1Yr4CMFTXzR+b+x/
 HHh4GC4ouq7SWS0PWFl1GFnh5GD6jW4Od2O2vCl+32eawprhR5yeBkunYyzKgrA+/r76+yjwi
 ETeUHjIFUmW6I+V8Y6Jh0Tt5XsNGWo4wZP9IB/7xAOnSj09JxVF3fV8tEihNu32yNE+VERIRG
 +KpkFNJ507VQtrh0mOKZ2OznGJ9Ui6glAbs87DdPjtgf4rLZkJFTe+Y9BOgv0M+j00Lyf00GM
 Xz9AkDKseQk705DdW7mlzEkqDJir3U+OOIkW934gKWbNdiVuFPu9EVN50Z2MNyjpuZl5r/VRy
 LR2Yhaj1tEfyx9orEiZoD20hVKIiSN0QzvHziG6yBSZXbF1OcWvumRT+il9mkmuXnr3r5LQ7J
 df6QXSmbnuTx34EoeZTcWftBXWFToZStD12hlfDY7bI/+jSwH7zZWsTlTSB+p9wZ5tnTQgZND
 O72uUBl4hVxVeSrwHzRhPak4lqYOKUQ6q+9bC0sFThCxViCVLkjbtxf4ajWLzaFCJ5kZ7acA6
 i9Is9DThPHN/X06HrIGKQ5HoTEqoiM4gfp27K6emxDb3kHSuqp+CAzzmMGtpczWExsoKm6m8X
 ZqP9tB3Eul+MQtGybxJ6CVQzbwmn1fKrerYEhxPXXzbYVeHrZ1tqTsCi1GRSy/dnzknOLFjTM
 of6DcTsWaCobBj5OSzt2mOCRdv30lYLTYUmgeewnLpfqStgDabKLoPN4AnArSgrDG6zt6Gt5m
 8b88ZUTE5HB4c3FJSldixfUCzuN8V4s8ZACdwurtGaBlQNZL1hjFeUg0D4VFS29Q+u+5gu7+/
 IN675eV/qE2Q8w/wkmGm374J15VocbdJXBDXv6g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fsqg85kF8Lun4LYR6YcEnvM7ZwZrbfYoF
Content-Type: multipart/mixed; boundary="ydnKTAli0j98fagCCCOhnlMI3Zs4OecAg"

--ydnKTAli0j98fagCCCOhnlMI3Zs4OecAg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/3 =E4=B8=8B=E5=8D=883:27, Andy Shevchenko wrote:
> On Mon, Aug 3, 2020 at 10:25 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Aug 3, 2020 at 9:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>> On 2020/6/5 =E4=B8=8A=E5=8D=881:46, Rafael J. Wysocki wrote:
>=20
>>>> +void kobject_del(struct kobject *kobj)
>>>> +{
>>>> +     struct kobject *parent =3D kobj->parent;
>>>> +
>>>> +     __kobject_del(kobj);
>>>> +     kobject_put(parent);
>>>
>>> Could you please add an extra check on kobj before accessing kobj->pa=
rent?
>>
>> I do not understand. Where do we access it?
>> kobject_put() is NULL-aware.
>=20
> Ah, I see, now.
>=20
> Should be something like
>     struct kobject *parent =3D kobj ? kobj->parent : NULL;

Exactly.

Thanks,
Qu

>=20
>>> This patch in fact removes the ability to call kobject_del() on NULL
>>> pointer while not cause anything wrong.
>>>
>>> I know this is not a big deal, but such behavior change has already
>>> caused some problem for the incoming btrfs code.
>>> (Now I feels guilty just by looking into the old
>>> kobject_del()/kobject_put() and utilize that feature in btrfs)
>>>
>>> Since the old kobject_del() accepts NULL pointer intentionally, it wo=
uld
>>> be much better to keep such behavior.
>=20
>=20


--ydnKTAli0j98fagCCCOhnlMI3Zs4OecAg--

--Fsqg85kF8Lun4LYR6YcEnvM7ZwZrbfYoF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8nveYACgkQwj2R86El
/qiM0gf/a+RZA8j5jxGU0g9AyWP6iFlv3rzBugUOL52lVkj5VxaYlHcSA7gNZb2q
LASO9yleGFEwMt6ksuewnxtxtLIvBb8ZTngpRX0svgpOKaFDZp8ee3V9JDpxXfBu
p8I7R6b0Z4v6j2xPwL5XB1X1L0AIJu5K2t0O4i7Ky5Q3F6lLvECgrVMHyRMjlLfJ
Dk9kG28vGCXqMQk4KpFq1lsW9MkE7y8seDBnPLZKlPKrXC4hYOz62Wm7AE+iwXiY
6DbsmniFuRh4EhKGioEOgpEUPpWMIViDCizU0e490Hxdlq8Y3GeGDakNSL7kW+Of
N5kjWW8sHzR1uEdJdIj6RDhSdpb5+Q==
=Zryo
-----END PGP SIGNATURE-----

--Fsqg85kF8Lun4LYR6YcEnvM7ZwZrbfYoF--

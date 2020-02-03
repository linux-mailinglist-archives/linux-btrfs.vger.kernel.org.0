Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC915040A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBCKRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:17:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:55297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgBCKRc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 05:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580725049;
        bh=lmUxFEu79Nr6KcH3pWbWu196dljUxVcQdM6FmQiLPaA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=GQNyFUB2BePHdBTYyKtSx/aEnaDyy9Sh8ddWTIOBYGi90ZSp8pcjkug9DPQmCgWBd
         Qxcw/4/l8PyPR3ZuTwNjwZVnYgBmFZPTFiyFjNJ3DCVb5h0/n64Qa5fVh6IsPtSDgk
         jRcQpmDXgxUsI/nmnxfYcvtIsR1jR2xRMb4juKCc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6e4-1jTlTT08AI-00hdzE; Mon, 03
 Feb 2020 11:17:29 +0100
Subject: Re: My first attempt to use btrfs failed miserably
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Skibbi <skibbi@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
 <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
 <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com>
 <CACN+yT8OD1jFFgbdrNuqrfsfYZMpPfJaTQ+7cGUSuWaaeH9g9w@mail.gmail.com>
 <8944f055-6693-01a9-5b29-23d78c309274@gmx.com>
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
Message-ID: <840cc169-74bd-38fb-0e15-087816c16ffa@gmx.com>
Date:   Mon, 3 Feb 2020 18:17:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8944f055-6693-01a9-5b29-23d78c309274@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y4tAXgfWYGdlkJDIdQwSF7QdcFnGh9reW"
X-Provags-ID: V03:K1:k+gN3hRzTtnNqKD6145U+Ps7UvjQcjlklOFg2KQSQ9zULtjHEyN
 tyjrLNjDVn/yvNdLPRYNQs1/nxWXj5kQvish2Ukf8ZwYfU0B+iC6/GzH9Zso/IthsVesi8K
 XUFYNdb8kEaXTrULL/vFR18O/doZv+/yvR30wbI0GfRXh7e5DNfw2LJn37DyJg8CT7O05gF
 63S3SjmqmDCRYm7TWrZUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aj0dsE0hZMM=:jP693rLU6d8lZCRULYySuX
 dXCdKl8wEYVS8PcIKZ2Galm+7yvcAw0l3U/FByJ01sJhTetNJkSuxZwIkRB3sf92eZ9UrDoVp
 GFfJkAG/D2TkSlNKgkrEcgUNph18DVo5dLau8RTEItJROHcI/3/bzH+3nwbwYgi1Kat4eNGOp
 d212x1K8L/QiRdykj2eDbTaLx+Fl710SlvVdzGInVmroNBoi5sGVVI4HNsxASjgFUhDLWeu2H
 1nywMjjXwJWxwxMVpoNeVTV2Ioiq3BArlywgqOW4GRsBVta1rThcxlf97S3HgVl145b4LPzlv
 6/sg0BML+OfFUH1KLA0CaDzhJu2SBNJjRMXKxGDIKLukyOwJSY6491jjmZ372SspRy1Z5lBIh
 19y+Qs35TQ+dOa9wP9YrPYYBuHVf/dhwRmwnwbqgN0oUqQ5L5kjtt/fS6p0t2ISWaK/QastZO
 aeOY4gATNJ6IDOsxZvXpw4ADgvJV7OIda4TSYZ93PkveU7APzck2ugH/LrbCXWaVMAld3Lsy5
 xobJskazGxpXW9V/fORArageQomp/2HCB5+jN/pPoouFnf3uCu6hyqHCRJitD5XNIxLmZSxpj
 TucYKl58T5KwnzFc0YYNoCK6hVwAAGU19zzo3J/fc8g+HpshSVRUo+tG1gWVs+GenIoYmVlx2
 OWKtMADx8yOZp/x5VHg6haAzdvKNtVzH5BsINd5FkT3/2nn4g05XBUX/mwSWhJ3BZ39kH8y/b
 eALG0R0kWmyB5IMguYK24wWq4EqvEBOg0BHGgXjtyhoF1ldO6y8M/4GPddF4OwIne7UCcjbrB
 +2O06v/Kd40+aqGgeNHC/01oVbGOfQtdp4GQv/K+ifoTTeaOBSranYWU3rENbLHIcYbVzbR7Z
 hw+8jPp3I9C/lYIgvfJfBNr0mNwjmmHfpB5y0IYlpjEtTnqFXoODFelnEJ2Qa9jNqjD1CarID
 EIrlgZVJSDd7hMkjcVgQWc0X14TWuXQMpau3ED8lJgszpwG4k2OuZzDi7Hxu2aDTjH8eJHheg
 N2i75VYk//ilwPGA13YSbdMwALCRJFaoLndiRPQvERrSW651WcWWKtljBa1mlFw6hcdguno+x
 vNPwXomuoE9mxVhtEJPZ6wVBxR/XeDSVptO9w3dEIFeXRODV+ASnf7pt8BJlsy9a9H2WmIhSg
 TO3DXzwWxdQ7M3jel7IbKuyu8YgRKJ5aJGBRU81SCxsDCbWQD1IlovbTvjzaQ8dvp5god/JrX
 J5LjF8Ybn2ofl5vDc
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y4tAXgfWYGdlkJDIdQwSF7QdcFnGh9reW
Content-Type: multipart/mixed; boundary="ydyB6NJSzaTHU2XjZCmuHFrgLY4TqdDHV"

--ydyB6NJSzaTHU2XjZCmuHFrgLY4TqdDHV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/3 =E4=B8=8B=E5=8D=886:10, Qu Wenruo wrote:
>=20
>=20
> On 2020/2/3 =E4=B8=8B=E5=8D=884:42, Skibbi wrote:
>> pon., 3 lut 2020 o 07:51 Qu Wenruo <quwenruo.btrfs@gmx.com> napisa=C5=82=
(a):
>>>
>>>> I'm beginning to think that my Pi draws more power when used with
>>>> external drive (I used only pendrives so far) so I need to investiga=
te
>>>> for power issues.
>>>
>>> That also looks promising.
>>> But since it's a USB hdd, what about try it with regular PC?
>>
>> I tried on widows and disk worked fine. I replaced Pi power supply and=

>> surprise-surprise my disk is working fine! Btrfs + luks encryption. So=

>> it seems power was the culprit.
>=20
> That's great to know!
>=20
>> However I'm a bit concerned about stability of the filesystem. I would=

>> expect some data loss when drive is disconnected, but why the whole
>> filesystem is broken?
>=20
> It depends on the timing.
>=20
> In fact, as your initial report said, btrfs even succeeded to read some=

> tree copy from the disk when we lost the device for a while.
> And finally goes RO if btrfs fails to write any tree blocks.
>=20
> In all cases, btrfs shouldn't fail if all disks follows FUA/FLUSH
> behavior (aka, if FUA/FLUSH returns, all related write should reach dis=
k).

BTW, here "shouldn't fail" I mean, btrfs shouldn't lose COW data or
metadata at all.

Either the disk fails before superblock write, then the fs should be
what it used to be.
Or the disk fails after super block write, then the fs should be in the
new stats (including both metadata and CoWed data).

Unlike traditional fs, they only keep metadata sane while can lose data
when experiencing power loss by default. (They can do journal protection
for data, but has huge performance penalty than btrfs COW)

For re-appearing disk, I really don't have much good idea to address,
nor other fses would.
What we can really do is just to keep the fs is still fine to be mounted
back after disk disapperance.

Thanks,
Qu
>=20
>> I can't ensure that power failures will not happen in the future, so
>> I'm still not sure if I should go with btrfs?
>>
> IIRC, either other fses just ignore any write error (and cause more
> serious problem later, not only data corruption but also metadata
> corruption) or just fail like btrfs when disks suddenly disappear.
>=20
> If the disk is not reliable, then it depends on what really you want.
>=20
> A kinda paranoid fs which refuses to further screw up the fs, or a fs
> ignoring most errors until the whole thing experience a rapid
> unscheduled disassembly.
>=20
> Thanks,
> Qu
>=20


--ydyB6NJSzaTHU2XjZCmuHFrgLY4TqdDHV--

--Y4tAXgfWYGdlkJDIdQwSF7QdcFnGh9reW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl438y8ACgkQwj2R86El
/qiPTwf9FCtMJ2ok3qioMdOp1nYxXqG3biyCNhnrYwB4ITmiIgpqi+ZLo4LwUTx0
2d9BzGwuX2Fv8mA/r6VQqOViwYEoOMXOj4wDRIV0g23BiF9EjCLxI/z381NqnUKX
xWkKLY5e4kpjcrYCUBDHQQcF12/5WjiLJaFCIRz9Cad8GyZkBNWKFtMDMA3Zn2PN
BXDPl2nAh+2mPuttydaKhbP8KAwrT7LmXEVPu5hvHrNadiF9C05OEanwkTgu5kin
X7POtCcoFdNWkFDn8eHt6pd+jIKPHBcQc1OvxuODv2YEJuvzgXnuD1BJAGBQcj5p
2H/zeTzVdEWWw0XQ6mZSj/XS1kAcwg==
=JZCV
-----END PGP SIGNATURE-----

--Y4tAXgfWYGdlkJDIdQwSF7QdcFnGh9reW--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D205283306
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJEJRx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 05:17:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:33087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJEJRw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 05:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601889469;
        bh=psAWT7m++FZ8RETNajyLFli+D02vOVJkk5i3796ITJw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fSV9VT/8WfKdfSOnLgoxJNkJ2/Fq0Io9nbA1tLpxNJwHe2QTnWGj6BRC34OX71vQe
         ue7yQ1pBVO79wRGInFVMi9PxVtLHsb3rp03Dn1dR7JAJdi/uD97rKk5a3cAQE6psXI
         nR5PQkgvmZTY4Imx3WOmA4q8lEmJd0ePzuc6BiPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1kKyuC3Rui-004QSw; Mon, 05
 Oct 2020 11:17:49 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
 <CA++hEgwsLH=9-PCpkR4X2MEqSwwK6ZMhpb+YEB=ze-kOJ8cwaQ@mail.gmail.com>
 <CA++hEgzbFsf6LgPb+XJbf-kkEYEy0cYAbaF=+m3pbEdSd+f62g@mail.gmail.com>
 <c2c0f8e7-b3ff-9e88-9d98-3b903c241644@gmx.com>
 <CA++hEgwdYmfGFudNvkBR6zo3Ux01UFRwHN1WDd7csH5_jBZ0Rg@mail.gmail.com>
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
Message-ID: <0b0cab47-1824-13ae-61c0-1c3c42c5fa10@gmx.com>
Date:   Mon, 5 Oct 2020 17:17:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgwdYmfGFudNvkBR6zo3Ux01UFRwHN1WDd7csH5_jBZ0Rg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O3FkZOAxEZ742bgakEnVX0UBBezksaHYw"
X-Provags-ID: V03:K1:ql03qWoyJIbblMJJMVLzc8cs6hNoYVpqHGhcLnoRNroSudBw0pb
 2/Mbhcm5F/4Y/O9lZJmx6bACaVeE/YC7HsjPvbknAQRtSNkv/COD7m6nU8di/VgQSmVYf4F
 jCbJ2BeyCQLQarP/dPKezLDgW3gq8HSr6xvhdAjdxOqIjI2j0r4JzrslDdOoQs27cDrbple
 110vCk4P6Ymg6YbR1F8BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EeQjA/3clNA=:NEGycSX7W2YA6X662UXVih
 h7+p9pFf04vGPVCi+QYQcQRQJTJa0095p/hlfWWQC/QNsfu9qAYm+dBm/CYXINni2lPJf7OPI
 MbNq5F8itt02ap25npVJXUFyEEouQCs3cAlFmYxzm3FXLAvK41W3cQ04aHIsHINnT4uWT8f90
 IvhN/UtSUPOqlv2vuZSAeUFkbbs+SKqXozBXKJva2X7iEE143R1xTGFD8UIkYn/+ZJMqdUtL9
 /vcQYgz/Pbbl0iOKutx9i85N2wnTJfr+vVO01Sq5CKk12eFvIwZBd4PdiT+r3gd2zVIXinIhJ
 KMEXM4SXzyyxXYEx55WIXRUpHTgewRuRi1fkbkRP11fB9tm4//YxlAcN/+adnEVyh5bI4MzFU
 0LhQcpo5LDq8xOmp6DH8OLs06JWFC9nVW67c/t6EODroCOi6RDz219SIgDpumFss5XJxXTh9m
 Mej+nZIrNas3h7ftXVGFWjqvR7uH4h6qlz/t36iM6Of4INMNXx1RBkO0yIWFk2rF50U1Dypss
 8Pa1vMh7ifKglajO+vgWMepPuYBL1582v/wbAWkcPeIe/twWaWgPeRWyjyXSuixcJYRJaMtL8
 5Sh9fnRNJLMbIngDvcNMrfSyxGA/Wpj4/204i9+E6wwPzgAcTgDkHHWufe64aNfGqsnDmWjzs
 Z9l69B76s3sQ6NUmipMUFGPotYJRYBB7zr1t1owRSFM5pJmSHrCIhL5lt6zjWOhkoPGFRFq31
 Q8UfEDluhmRUfYJA8rHB1ATBp/XSdNqXf+dC3rDMFf+ET4npxDv/DmfqFHJTcqH/mGXB+26DS
 F6iibTzrzNGdE8L/Gxa/+93PwH95XeETrWOYrT6iwHTYW6XYTcjAxzmMUnJwn2XUKfuNWS+6M
 GVv87KMR6JkziChJmu/5DYRn4gPHWaOOm0ifEYbxx+hKovyMtaPcBIxQ0MU3A2/K7O0p2riLG
 3k7KEC/MZDQlcMGGDSo/T2y5+xRFkvy9YgwELirQ974v65OYsOUMa422suWcWYZupqs3BffqX
 rYGsgRnhZQ4bQaRgQeakJMZgJC49JGjalaGMlnL+VSUmftyMBWcGZsuKEYtCBVPAXqApALNXk
 03ouwb7zunU3VCg1TeUO7z4i4hkPyW2RaRCuomiD4+IPa/xp1IWjhNELALS5L8ddcrawY2pCb
 jB5ZXy7JCFlvRS4e+AjWJqgWVY7n7alOXhpQA8JcKmBe+VSPNEY+CMzzKT7N30u6u9c4XC1Pp
 K8vchtq9mwfVgcU+9wU6txqYVPB+0YHE6u5k0Kw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O3FkZOAxEZ742bgakEnVX0UBBezksaHYw
Content-Type: multipart/mixed; boundary="1c5OCB0rqqoyUgzln2RsYta9CWKsrxxHW"

--1c5OCB0rqqoyUgzln2RsYta9CWKsrxxHW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=885:05, Eric Levy wrote:
> The volume is not RAID, only a single NVMe card.

Then this means, we may have a bigger problem.

Normally btrfs space reservation keeps enough margin for critical
operations, thus it will return ENOSPC before we really go to do some
space consuming operations, thus no abort_transaction problem like yours.=


If it's single device, and still hit the case we need more space than we
have, either the space reservation or the space consumer,
btrfs_drop_snapshot(), has something wrong.
>=20
> I deleted all the files and subvolumes except what I need to recover.

You may want to wait until btrfs really drops the subvolume/snapshot.

The command is "btrfs subv sync <mount>". And then check if the usage dro=
ps.

>=20
> Below is the dump from fi usage. It looks as though 1.00Mb is all that
> is unallocated.
>=20
>=20
> $ sudo btrfs fi usage /mnt/custom
> Overall:
>     Device size:         378.04GiB
>     Device allocated:         378.04GiB
>     Device unallocated:           1.00MiB
>     Device missing:             0.00B
>     Used:             323.54GiB
>     Free (estimated):          53.13GiB    (min: 53.13GiB)
>     Data ratio:                  1.00
>     Metadata ratio:              1.00
>     Global reserve:         512.00MiB    (used: 0.00B)
>=20
> Data,single: Size:371.02GiB, Used:317.89GiB (85.68%)
>    /dev/sdb5     371.02GiB
>=20
> Metadata,single: Size:7.01GiB, Used:5.65GiB (80.66%)
>    /dev/sdb5       7.01GiB

This is strange. Even accounting the GlobalRSV (0.5G), we should still
have 1GiB space for metadata.
We shouldn't use that much space just for delete.

Would you please try a more uptodate kernel to see if it works?
(One simpler solution is using rolling release ISOs, like OpenSUSE
tumbleweed or Arch install iso).

I'm wondering it may be a bug not fixed in v4.15 due to the hardness to
backport.


BTW, when mounting the fs, you may want to mount with skip_balance mount
option.

Thanks,
Qu

>=20
> System,single: Size:4.00MiB, Used:64.00KiB (1.56%)
>    /dev/sdb5       4.00MiB
>=20
> Unallocated:
>    /dev/sdb5       1.00MiB
>=20
>=20
>> Oh, that's a completely different bug.
>>
>> Somehow btrfs exhausted the metadata space.
>>
>> Normally caused by unbalanced data/metadata usage and multi-device.
>> (Currently, RAID1/RAID0/RAID10/RAID5/RAID6 can all over-estimate the
>> available space, and cause ENOSPC to happen in critical context, where=

>> we can only abort transaction to avoid further corruption)
>>
>> Currently I guess you need to don't do any balance, but try to remove =
as
>> many unused files as possible, until you have enough unallocated space=

>> for metadata.
>>
>> To check your unalloated space, you can use btrfs fi usage:


--1c5OCB0rqqoyUgzln2RsYta9CWKsrxxHW--

--O3FkZOAxEZ742bgakEnVX0UBBezksaHYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl965LoACgkQwj2R86El
/qi7Qwf8DoVKXuCmjrKQRjyKyzDAT5RFs4b2xD0YojukjDPsn96/9Wi+iz/hvYDX
ThmhdycsBp0/1nQ+DvSwtAPGg1TOTV79Sw5A1CtIoPKg/C7UEdPDmwozdC60tmf1
MIafewE7lAzFxbNzwhZSgiB107BQm27af9wGFhQwN4WeRp5//b2wDWo7SdfU7ZBF
YNYEedydTIMN0DEHdHFkkJn2lDJfSv0y2wMlP35eyrxEUZ9fzh1h2cjVTP6kYLcg
sjX38ARH+yVRFQq6GsOprFXc2EZwiA/tnhagZ7D5zeNGEcIpbu5z3rrTJLuo2wRX
JnPUTE47io/0yHKpWzB87I+A4IB84w==
=Ocod
-----END PGP SIGNATURE-----

--O3FkZOAxEZ742bgakEnVX0UBBezksaHYw--

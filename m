Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D58FDE0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKOMho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 07:37:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:42589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfKOMhn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 07:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573821379;
        bh=as6iV4VLhBIDG/Zp14I99SHggPJpWs+E8EqSfw0tq3g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kwD53eI/WjXosqLqVjhZREZzkREpOlh0Rg9BnoQoIfnJ6QYzy7J++HSykzuTQeUuG
         hFKeQH835r9GXpw3rgYjxBTsI2rXB+PUqpG2nm7BABynj6oOOxTxIgQ8tllg4UcD1x
         /sU7e6vEBAdSYGGO6KWgeRyWubJOPedjtxKLhSOw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCKC-1iHLk703cK-00N97x; Fri, 15
 Nov 2019 13:36:19 +0100
Subject: Re: [PATCH 0/3] btrfs-progs: check: Introduce optional argument for
 -b|--backup
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191021093755.56835-1-wqu@suse.com>
 <20191115123230.GU3001@twin.jikos.cz>
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
Message-ID: <7b145360-ebc8-d0bf-2bc6-3816c047991a@gmx.com>
Date:   Fri, 15 Nov 2019 20:36:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115123230.GU3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XpHPW9QGu76lIxmZIHrYtGM3sY72k9sDa"
X-Provags-ID: V03:K1:Mb36DikFe9Q3fYSdo4SmWB4QlT5VFB5tGdQ7TejQxyWcKENQqP6
 Dd/eYh7wU0Lhcnc1afAUphOJcNLbeag8p0Qs/udOZFfQbsjqmGEbtzn0t0vEqprWc3HcANu
 d/3pFftgF/uNwwcj35H3vSEkrE3fgJpAvfv0boLecb63YC/xtURHB9WTTR17ME37eatoJNw
 /RWKjQCx5j9FqEhPQTV/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rAkaIhmysOs=:EkH0NJENhiRuJZkx9GU+5T
 ygoTFKmloVKv0URUPY+B8s2RCPXFVg/D8GxAsJn4l3tYJg0EqUoSAcTJM+9PHPJFRg+nF3Tsa
 l5RuUJHGy3x0OeWPNkoAoZnMJiDwBk2a4ZV0RXdubNm1lMiZ+qdtD+t32IyCJgeBXH9FNVOMX
 n0e/KQ8eAkR0nj3uC/rQc5U4JGxcJ2QWOLahDMQtjUpYNxTIIWn44P4HZqTZab2r2AIvNThxr
 YEESrvYzGuTn1yrkkod9LCXuHRwI2Xxk8t4YcwgDrjGS5SmctauBxnCsyMuEqZgQfKjxaK8dx
 Zvek81gZi7i1aING+FQEZfgWX/ZkEQi6+OoMWZ8DisDndnCjnNde4Zyy9gtio0BN7RpS8fRKt
 v/Xee2Gm4Ujklw9JpXKRls0srVvnd+xj6ajHU+m05CEfxn1BJchKTM7e56wYaRSR0fMQenmWA
 lgDbLOxD34pEszlQqIEyop7DFNnvNXZ9DrhWZVg+i3ee6qlwXOhdTiXGqyAQIFhJ8969mDYTh
 nqct4tjxdt49JZ+s4PS4v1JVyZUeab9n0gthj+7p9DxKzriKszlGcsXs0cYy/NYE4V/Oe7EzA
 oupPEnlkpTLNPE/xXF+PeOcMsJCoGR6TSWh2Ur0MEnJbkwHG4/Ozo26R5hXqayxZbSf11O0iY
 qsEOjVMXQUeF6XT2RsaneXoV8462W3qp75bS/UP5Oe33MJWUarFdFJmJsJ4HFWfTQlGJxaj88
 87k1ncowum0ZlvQhaFwkRTTiH66czY+wYpWQ77mEbH1E6xkT/XKjNMFTAEciwZ9RWzWOLWZuI
 iIJMrkPy4EBaTW/euwlB35Yaqm9XjFNod5T96rSSG967AqNkAjbFAKfKohnGBkBAY6BXNRy3m
 1qg2IPXAeAVOZG/p/BjSfyXgP+jXKF9d0JhrkPN8+9w0vJI5DePGEsIz/qUSNhOmrP7AN0g8u
 Xz69r3qw8s0ZhXy9bVTk09/DccZc4HqJ8UWUdpahSE6IkfIDRNbnvezyIY1wg3ECyzegbevfX
 mXpzzNh7T5wsaJ2mXww6W8ujdo1sqjEvqmCRIjEH0WpK1LHXOCLK4mfeXnih9V2RJ1qb6B6ai
 PMyy5FdavkdMfLnNpFTi2+1vPWBHezPNcaH41BXBXzBACxZJRfncO+1rHCj5XblH9i4gEtoCL
 L/utD5xV/U9P7WJHXIco5pjIX75nbHiiFpVzzvd2+RwNNNApnkBR49CKmK0xsk9E2uZuJBEFc
 V2QutFcRbk5K9IByuEAhxL9HW8b/BYRlbtufFh0mEbsg2wXaSn628NyDmTxM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XpHPW9QGu76lIxmZIHrYtGM3sY72k9sDa
Content-Type: multipart/mixed; boundary="aecgNkGRHcS6dHlWuLCSdl4itqFV2kdXy"

--aecgNkGRHcS6dHlWuLCSdl4itqFV2kdXy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/15 =E4=B8=8B=E5=8D=888:32, David Sterba wrote:
> On Mon, Oct 21, 2019 at 05:37:52PM +0800, Qu Wenruo wrote:
>> Before this patchset, if we want to use backup roots, it's only possib=
le
>> to let btrfs-check to automatically choose the backup.
>>
>> If user want to use a specified backup, it can only use -r|--tree-root=

>> option along with backup roots dump from "btrfs ins dump-super".
>>
>> This patchset will introduce optional argument for -b|--backup, so use=
r
>> can specify which backup to use by providing the generation difference=

>> (-3, -2, -1).
>=20
> Please don't introduce the optional arguments. I think we've learned th=
e
> lesson with 'defrag -c' or balance -d/-m arguments. In this case a long=

> option would be fine as the backup roots is not something that's used
> often. We can keep the --backup as "use first good" and add the more
> specific selection.
>

OK, I'll rename it to something like --backup-gen-diff, and get rid of
the minus geneartion part.

Thanks,
Qu


--aecgNkGRHcS6dHlWuLCSdl4itqFV2kdXy--

--XpHPW9QGu76lIxmZIHrYtGM3sY72k9sDa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Om74ACgkQwj2R86El
/qgO/wf+IOJ7hVguSmlb0/d/1uDo99ervy7e9g9fEMkpq+kOqa0aY68XnY99dSzN
Hm2U5kwIauFOihcVzpDWd1qYoE0wVO8cOJ8/hAuY4TJJFKBBXod8qPcfyS7HM4TZ
1Iy2RpaMKkyW62U5MNz9UXrZcO7+QsR1xURv3y/R0qKd8KxWJ2uA7mMm9T3MOF5O
Bo0d5uXuobPt5EqAI8rNTBodbPSnjs9Rc/nqoJUTNV9cagR+8JUstjftSVnlUwnb
F5QgXKDKIGsPud5E+kiDgpcFp95r2dqnGa68I2LcsXuw0v4uZvKQHnj2RqBFX33E
niXdQAIhCFCBqlVvIuAM2qJoMohOOA==
=yauE
-----END PGP SIGNATURE-----

--XpHPW9QGu76lIxmZIHrYtGM3sY72k9sDa--

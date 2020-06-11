Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931D51F67F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFKMhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 08:37:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:56885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKMhY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 08:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591879040;
        bh=z27qfCeepoOPzfXTjX4pAsDubYGF2p15ErX+alE4CEc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IQ4j0f+TWpDTpAPVA3iv5bLNKZ9u9wCgPVBCHdjIjuR+c1L9PRB/JxXWlWnWiGHy1
         WDV/X+JFYR7GCsvEyzqI9SIzv+6j4C6zHkmuZTiEhmvDp7+WoUIyMkHTfF0vxKV5ST
         UJEkZnHn2G62Hugcsda9R8yMWPGKQ5Fds9xKDDds=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1j7Xqn3B6o-00pMPG; Thu, 11
 Jun 2020 14:37:20 +0200
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
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
Message-ID: <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
Date:   Thu, 11 Jun 2020 20:37:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611112031.GM27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ovDaEfCIOk84jQHUke4WHuDgB5DctYrZh"
X-Provags-ID: V03:K1:+OPd1aqDMhpGPw87AmMnqidl3U/MbHK75y2FUOLETuJNDk4hHiu
 q5Xrm7Q3mHg72CvvHTET+DKRv2eUaa08ack0pyWxdJUGcYxJc4yTkfXe1DUMt7nvYnj2yih
 oIvoMEgz4kLhz7nBTjTloPqkJ8oeqxV1kr09yaMt3gcN+3TZYh80X2nlN+HWIBgten/lwnX
 XI+/FCLUyrhm1LC5RvLsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6Dvicpjvrk=:cyVA3/ViuNaSrfGk6se9Q3
 9k21TQ0eOI3ccJ84Lw1qT3BR9jmN+s3EPfZLwiqN5UE6gSkTcPpN0Jxdf3aj/Y2/IpSe0gP4F
 gGzWH9t6p7gmtLd9JmX3Bt6Ds5LNx7EJxjPzjZnJ4CjMbEiKuRFy0ajak7cv1hOtfd/KBXn//
 wyWIqUFFDHiFYKDYMj2mVTpxAaY1kh3+X5daV3q3lPf9wdPQp9AeXmpD7DDMQrjNHmBMvYgik
 n7Iqs3AG/YKVqPcizK8e2XhU1qGuSCzyt4IS+0EFIT2RV8WstkVN6VTOjxqLSsv/0Dfts4SEl
 d9qauPkjhPXUTZyc3h6B4tNp3wWY04LS/KM1ZLd9pogzsb8Fx4HUTdA21ZqczBwaRoJxX7kw+
 +MzMYbJ6zg8v+UaLYZ9gm4g2ugGEy0EuEJSoGRgQPNxuCkqVVwicbYkJiPc+cjN2qFti/IJgB
 BR6B89pzpRgz+cGMOeTAlutId8+LxdjDK0F6nWKYoSXBqj1VR5s/AR9Z8039r7km6znUZB4Sc
 Z4UG8x1v0DUp7uDB89x+fUiWX56Zz0juquaAp/2H5x8ydQJ2cLaeUqN6Eat/H3Jh/dF9dMKXo
 BqDcqzuBaBBRH5IexiTfH1GgOuf1b0Tw/ddP02tMM+k5b2CMmSYEX897Hs/tWyq4Lvcb/fyXp
 QuCsdjgJsLkJyRGEQLX7kp3ZGoq99Ik2tzaSPf12pj5kcWXAs1QLSphjcxL7tmy+SATH5hGkm
 c78zIuejXxuQVx9e93e8nWPouRM+7218t2z8E8jlQogKk1gUPhs12W/8gAVthVJ8pQvdcjA1C
 ST1LHUyH2rtaz3abMdAzqDe+Vza2dU92PVewpAxz1N/PcNM3KgoV6xEVxu5iBCSqP4vU1zT+8
 U4lCHkG4D/PiVij65vHzGCPZiohFTigTQw6e/MsoBvAw7gUARECQzVChbunYP8RuLwWfF32z+
 6ECNGBVK9WKBu5xTWhBYr2MppIvcORsM17HxQfhT9I1Mjf5Og6zguIYttIblmkY8bqwwGMCko
 OnAxhUHgAdaO8YhqobVh5/RZByZmPzFDpLBJaw3jEJ9Pu17pfk/Yi3eCy3rYDgIkRkg5J5Vdx
 G71sworffH/D7rQ+n77Abb4AuzxoHbNhHAz//e4Ity01k/YOmb7euD50a7OYDqu6cUrBMs8XZ
 85ns/xB9VKOJBkF41cOQbz3E7okBmZP+bBewYxhCMlEaYDy1VAH8JEA180hoH5eSt/Cs8TtA6
 9/hLvKT0H6BnIceki
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ovDaEfCIOk84jQHUke4WHuDgB5DctYrZh
Content-Type: multipart/mixed; boundary="Qtu5pF2XTFhzrYKc95KPjpxDa0bM8hnt8"

--Qtu5pF2XTFhzrYKc95KPjpxDa0bM8hnt8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/11 =E4=B8=8B=E5=8D=887:20, David Sterba wrote:
> On Thu, Jun 11, 2020 at 06:29:34PM +0800, Greed Rong wrote:
>> Hi,
>> I have got this error several times. Are there any suggestions to avoi=
d this?
>>
>> # dmesg
>> [7142286.563596] ------------[ cut here ]------------
>> [7142286.564499] BTRFS: Transaction aborted (error -24)
>=20
> EMFILE          24      /* Too many open files */
>=20
> you can increase the open file limit but it's strange that this happens=
,
> first time I see this.

Not something from btrfs code, thus it must come from the VFS/MM code.

The offending abort transaction is from btrfs_read_fs_root_no_name(),
which is updated to btrfs_get_fs_root() in upstream kernel.
Overall, it's not much different between the upstream and the 5.0.10 kern=
el.

But with latest btrfs_get_fs_root(), after a quick glance, there isn't
any obvious location to introduce the EMFILE error.

Any extra info about the worload to trigger the bug?

Thanks,
Qu

>=20
>>      5.0.10-050010-generic #201904270832
>=20
> 5.0.10 is quite old, but that shouldn't affect it.
>=20


--Qtu5pF2XTFhzrYKc95KPjpxDa0bM8hnt8--

--ovDaEfCIOk84jQHUke4WHuDgB5DctYrZh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7iJXcACgkQwj2R86El
/qjXggf8DzlIAU3Vd4F1Iz/PHBKKJabhi4wZaFJ0rdIf0iIHTqVOnantbJVtbKbB
2XMRI4dgD8aTL9SbhO/mthqJkxCvHJEpztCVqveD9MlDMbCfRfmbv8v8fgVX5n4C
BNGIg+8t/TigPfcfLsQfA3/4KnAtBX9+3eNak5i2wDEGMe5rK0VotDJgtxMeYZsN
xxrzdEZj0nZWR8CjVbulQ0X5nH458fYyhfVYLCD/IiAn1zPRS2hhqna/pkkzutUb
nm0y+c/cBsfQT/6hdmXaTiGtn8zwVCgtrp1gh0UJmeTHFCrDyfEm6/RbHhnPTSxt
4ywwRJYCuYgsmxrUc4KrMRHXu4i87w==
=J6ZR
-----END PGP SIGNATURE-----

--ovDaEfCIOk84jQHUke4WHuDgB5DctYrZh--

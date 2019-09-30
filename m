Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5125DC1D08
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfI3IVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 04:21:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:51053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfI3IVe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 04:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569831691;
        bh=Pf7wdrIUQAy2jolOsH0mPkq7TBtc9tzF5s2T8Vr4VeE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Py/A8FqvUTWFn63zHN70cPwqiKPnw/JUs/Xn/ixIF/hrczY5WA51tQIIVGfoRIFMp
         y0g3qpjK7L/QkNujlSmpLh7x/Kffy7PHUw21wI+MmiayYpvJrfoLFxUAfhioBf3Q1o
         dT9w1uiqtmA1k9U7DfJpLrToWDmCMxfVOqZtWAXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mr9Bk-1hlWCy3ZkU-00oHFx; Mon, 30
 Sep 2019 10:21:31 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <e513f586-c356-d891-e901-3aadf5d49eec@gmx.com>
Date:   Mon, 30 Sep 2019 16:21:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WNyGIsnGj6GnbS8cKC4LKwAXv4wB8jT4A"
X-Provags-ID: V03:K1:r5AsyvE8DPVe9Nd9SqA0JUfjgZ1XF+C0sg5eCiXmGNVwc5hvNd9
 gVQt51ZlEa+1rrMBk9BAMqFkDRPNorRleN0BoWAL8KVs9iLo++9+g9LVssqIg6NVKFsHbDO
 RuMnMLfY5laYKehz1Q3ngms3oKvSOznEvpVoX0IDamKFuEcOgLK00rThhl2CGs2Obdtnwfh
 Ll2W2RLOj0hu8CJ5iePbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQFRipZS2vg=:A/23+895BdNLQT8AZS111c
 K7xMyz6UgVRzqp0cSk4YJEO1SZs2uQ3DJeITCZRmXsK/kQJazZL4Z7S8tg0BeIDmkw5xo/1at
 gsrV6CTafk8UnUHYPSoHzAROyNyYxzJShJ0/aw3NKZ8MC0Ql/cdZaguueA+zE6nrGsqwqH+uH
 S5XNl3HZqK+3sZxnsNhVFX0JeF4Fs0pZv52bv8d0mqX+VQKiamZO0s+Lkv5avP8yK8XoPCAjE
 MPIBzHu4GffmWB6ZN2NfxQTZ6DwOSEC1VYQgNtaQhikFgO9IvE8eCq/j0KBbBSGwK0aQm7w/S
 KubM+yZTzIZRfBrEZy+UvhY76nzteUOyaLKKoaCvsNSAezKRmZ894R/C0bXF8zzlUhJ0m/QJW
 yPQiIlU7YoZcNkN8QLSsNBzi3Z4ui5UcsZQhydKu8Md8gBabzQGdlhBl5Dk1F/TopTmnItjUI
 07okxI2+1Kkr2f/1GV9GlnZGQsYqM2OdJQ/C+CEVPGrYR0bVAkJY3PKrrYbPraUL+C/Prlapp
 Q16g2xFJVmlFGGIxb3MnIa0//duIZ0ZC4KNkcnl4cp9c3gf9uBXvTuzIhm/92kxWYAqclyZmg
 QLE/IBZNxW8aP4q0O/u0bNQRmCIaKGRsX+oABXwzX8AOq31aYDpVf871Ge8RfhzYw9pqHs4ql
 E6BEjmqy/hlOdyFe8igR7DpKCPuCq80ckTz7n5ZltaRD4Mq3mCKkRxpO4Z6WrqIwV3qjVdFvN
 +FyJhnl5C2pAtDgJIf35igVss2War+48ze7SAqv3RiP8suFP9e+GTW4rubDp7R/0dgk9hLp8q
 g+jwf/buKpfSpl9SdQtnp7o2bG3Io6R61S7nDAriJ0tQO4+Sl1wssB6N4B055YkaFpPW22fvG
 fkoXUj+U9lUjORlp3CyGTv8Ju2tBH5N9QBoYVNIZgt+5mRWZ0EGwmuYS/TQRmS3fNz/duf1pW
 bEGQJjdwv127TZencse/+qqzIr/xMz3yIsc5TKOhmiasdXOduDNO3x0bpkDLse6DEqQAUCC8/
 k4UW3C5ycV2C4stUm7bvW5MvVERyxlDqNnBytOxheFLsjYrDb/fK/NItHvtsaJUbeHlN80uFD
 ZjkGKLmdt4XbPcZPXq7Q9F15pn61fLEskue/nKpNdKFELVbzn2/L17bjaA6vwGoR1l4iZQhvs
 O3QSiNIFWFcrrF1mclOrowvPI6Un15VnatuVh6PY1YSZ2JNTKmy7GIHTCAHJQ1lUkOjze/QnM
 5RcMdryN/b7Qtck60KQ5G7lnwhpTdiVw4lpSbAaiY1bp/RBjPZajLQ+0MA40=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNyGIsnGj6GnbS8cKC4LKwAXv4wB8jT4A
Content-Type: multipart/mixed; boundary="Eg5LwBfdTpni5YOmVKwzdGFjyCG6MqltQ"

--Eg5LwBfdTpni5YOmVKwzdGFjyCG6MqltQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=884:00, Andrey Ivanov wrote:
> On 30.09.2019 10:31, Qu Wenruo wrote:
>> For this one, I could help you by just reverting that bit, and then yo=
u
>> may be able to continue mounting the fs or at least run btrfs check on=

>> it.
>>
>> Please prepare an environment to compile btrfs-progs (at least
>> btrfs-corrupt-block) if you want to try.
>=20
> Great, I'm ready to do it. Environment is ready.
>=20
>=20
>>> I did a memtest earlier. All had passed without errors. I can do a
>>> memtest again,
>>> but it seems to me that if the memory was faulty, the system would no=
t
>>> be stable
>>> and often hung, but the system works fine.
>>
>> Indeed, especially considering that there are already two bitflips in
>> one leaf, which should be pretty rare.
>>
>> Any out-of-tree kernel modules?=20
>=20
> I only have vmware out-of-tree kernel modules.
>=20
>=20
>> Or would you like to try v5.2.15 kernel,
>> which has a self detection for such problem.
>=20
> If I understand correctly, if I install v5.2.15 or later kernel
> then I'll fix my /dev/sda4?

Nope, v5.2.15 is only to detect such problem earlier and prevent such
bad data to reach disk.

Thanks,
Qu


--Eg5LwBfdTpni5YOmVKwzdGFjyCG6MqltQ--

--WNyGIsnGj6GnbS8cKC4LKwAXv4wB8jT4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2RuwcACgkQwj2R86El
/qjRVwf7BSgQeMIOezJxb4DlOoIvrN5OyCrC1+YKrW7071WUK++DfXynPgGlylAk
gB7S0gFYGJGwWXN4UF6c6/S4LKO25Gsr4aYzb0AoiLKly/jKsuqv+k13pOm2k60i
71O16Qwhx9kYo3901QlSFOE3TPL8Iipk5IENpK3g3tWk595H4th02zf5f/lcEnuK
n2CJ+ltiMfH7F1QO2aZ7JaIZHRZxO2JEFxcnqSH+hggeJ3g/aW4AljiQ/jOCvn9k
mWXONFI9SKlzQ5FmXrcB4De5xf//PFAMkGa+6u26CbP1vCOZGCOLH/cUVGg826IU
I30h44DeKlXnFv86cS3+WfoI2lNRpw==
=zZmD
-----END PGP SIGNATURE-----

--WNyGIsnGj6GnbS8cKC4LKwAXv4wB8jT4A--

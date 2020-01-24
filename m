Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEA1479C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAXIzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 03:55:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:35585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAXIzj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 03:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579856127;
        bh=BR2tBry/KPalYWLCwjEM85F6jircgZLkSMs2ivS6nmM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f0eYDtkROEPX0hd5HgmnCyqzplZEphM4WHwYJ4O1l3JbdjqzgaCKyo+QQ0GCaGT8h
         Y+PeCgqzrfnkZrpyDgzqXdpTMraxN/4VcIUAbITdZt5i0YBjMJjxWXEUJZozoTh5w+
         rpw0d3szhs6FlajpvqOthxilSOc2LQohuLX8fzYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXUN-1jDPjd2Wil-00JYUc; Fri, 24
 Jan 2020 09:55:27 +0100
Subject: Re: [PATCH] btrfs-progs: fix btrfs-qgroup man page as unstable
 feature
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200124072521.3462-1-anand.jain@oracle.com>
 <2a302f48-2acd-d963-0c86-992eccb1fe6a@gmx.com>
 <d5103932-90ef-6674-05c2-4d7723ce0c25@oracle.com>
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
Message-ID: <3592adb3-f29c-9b21-6679-f69aae59f7ef@gmx.com>
Date:   Fri, 24 Jan 2020 16:55:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d5103932-90ef-6674-05c2-4d7723ce0c25@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oYlXbbV4DqCH2MQPln8YvQ2fj9n6t4MVY"
X-Provags-ID: V03:K1:fwVQCunGrziTk8b22oSyJR7hVPJNdODGmylPrdPq69LUzeMOQcS
 RrdyNwIkgaMjXR2k4BXZmPob3bscgkHgp0AbuaB6tYCk+My6o0+ulPyyf/04l1B+Pqie2wP
 bhKhhapduNf+HrB8DCVokUk//ur2S3Fh3bE3rMhcAoHWQXWLzSm7LTa6FHBw1yKv22c7w/a
 TCoSAf4WIVKjQ5nadNxSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EkFhKFiKKME=:Fl30DdwpfJMYvEN8NBHLny
 pQcn/UxKERN6LvHiD90IRukGH2oMzdTZNZe7rxx/yBDbMX03ZwRzYG05q1xnFpuIv05Mbjr/S
 eMndiaeGE1OTb7KJXzV6cwEsy7+5EypZ63oSYydOn7tBB05lKRpzcRl9hlhTDmlmY2sX9lixt
 zqGLx/1NhvpHbfVtjVkXdM13zh61yrVUutUFaKDIqzfgB3lXg+zjZd0/YJJeLrOrXJ1/TYFet
 TMd+4i2fOT9PvpckLeTKnwL4UXr1eiamEbnUDKRATqL9PKDmhxIrBwrwGx0XRTtTqF0CSr6rN
 h0Kwf+bETxGgAQG06imfgdkUWVjzsOUexi2za9Ki63mrDa7/NRzMkFuvv7CvKucTEM1jB4Do7
 YLBDiiogByqUPgCwyRJF3e0geLtTUMC7hSGPfJrEyN4A0rH4HEEBQenlAT33XvzMXz68i+3xe
 0ndhm2aaJI/s32+usw5BtTEKZu5yelSbNK14fWReGz1VnW86A2x7uEDs/itX+ikgoqGYeJ+yS
 w/9W7oZSJqowlSVX4Q6bhXDKR8x34l3QV7NvqSrJ75gHijYoeUS1Fs4OoSTorYi1BR8t3jHhU
 bUlA5kTWksd0CgxGFdgQlwBn7huLSbGCkrucdhXGHsP4eN9A9Fv2nH0oyi8camUJC4XizpqBn
 aD9d/G6qiFGVqDIasQiX9XncbZ7j3beH/8qfeQHJQwF7yofT+KhDBaGO4DejA4Y/dhlcvrB8W
 VSXzB/JbmzJVC/f/rJk9nWHQL5aCaSr8wPKvLW73mJ1+NKmWv6mPaTE3R0+Kq8Eh6tsBX5WhF
 +0kKzYk85QQ7C+xwkhQwwX5gte8nuWOHmgyPcCXC0N3jKQVTw6OeCbDMKVQG55kw3ClNpRLZ9
 PsJRE/VEKOHCEXZ3+1CIStnoUAz9I6VfO5MUIrEnsOXuCX+hyqGZUIEdSGKqG2P/efsEeW5Ny
 r59AqWHaAehanL/VnIzy5VVtRDDIRXrrlv31+XNxgkgwjYmTLfx983A6zxK7OnQEbLzxyq7vy
 vU/E2r4jbKTOc79sRnN01zlpzlvgXIJsufNhhst9OE6kkFs1S+bbKthEh8gzItX7f4ioq/I5j
 nMw4JfO4SfVmShrcT4kO7ddeQpl9i7ziij9Y7ZRhG8fPF9HwhlYcHXv6BvEY1ZdsoslTnqNqL
 pi0TD/R/YcR3F5NzUJnWKrnZ4NvJYoioUWIk7THScRMU8LbS0IxB4TYHpg0usyipwzjMLUOK0
 l2ei3rD7tp9GcDgPQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oYlXbbV4DqCH2MQPln8YvQ2fj9n6t4MVY
Content-Type: multipart/mixed; boundary="rKuj7EYM18Euilqqw1HxjrT2z3ZVDAVQF"

--rKuj7EYM18Euilqqw1HxjrT2z3ZVDAVQF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/24 =E4=B8=8B=E5=8D=884:46, Anand Jain wrote:
>=20
>=20
> On 24/1/20 3:28 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/1/24 =E4=B8=8B=E5=8D=883:25, Anand Jain wrote:
>>> There are known performance and counting errors for the quota when
>>> qgroup is
>>> enabled.
>>
>> Counting error is a big problem, please report if you found one not
>> caused by impersistent qgroup status.
>=20
> =C2=A0I mean the already known issues btrfs/153 (count error on write t=
o
> =C2=A0falloc-ed space)=20

This is not count error, it's reserved space/limit error.

>and btrfs/179 (after a lot of snapshot
> =C2=A0create and distroy with fsstress on subvol the btrfs check
> =C2=A0reports qgroup count diff).

I haven't yet reproduce it, it would be nice to have a separate report.

>=20
>> For performance, we still have problem, but that should only be snapsh=
ot
>> dropping.
>> Balance is no longer a big problem.
>>
>> Personally I think the current man page still stands.
>=20
> =C2=A0IMO kernel version in the man page is bit confusing though when
> =C2=A0its still unstable.

OK, for the kernel version part the patch makes sense.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 Documentation/btrfs-qgroup.asciidoc | 3 +--
>>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/btrfs-qgroup.asciidoc
>>> b/Documentation/btrfs-qgroup.asciidoc
>>> index 0c9f5940a1d3..2da3d7819ba6 100644
>>> --- a/Documentation/btrfs-qgroup.asciidoc
>>> +++ b/Documentation/btrfs-qgroup.asciidoc
>>> @@ -16,8 +16,7 @@ DESCRIPTION
>>> =C2=A0 NOTE: To use qgroup you need to enable quota first using *btrf=
s
>>> quota enable*
>>> =C2=A0 command.
>>> =C2=A0 -WARNING: Qgroup is not stable yet and will impact performance=
 in
>>> current mainline
>>> -kernel (v4.14).
>>> +WARNING: Qgroup is an unstable feature as of now.
>>> =C2=A0 =C2=A0 QGROUP
>>> =C2=A0 ------
>>>
>>


--rKuj7EYM18Euilqqw1HxjrT2z3ZVDAVQF--

--oYlXbbV4DqCH2MQPln8YvQ2fj9n6t4MVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4qsPsACgkQwj2R86El
/qhBYAf+O7Al6WUpzZ+5rnZUEp1ETehXdUsAtH8JZppl5kz10kJcnYhSVA4sjcY8
J0Gj/J/lxCbjDipbmyVHvvVFYLIWiXoTEbv0pvU6VmMWd9Go60EOH8XCxh/m69EA
XQ1Xh+5xSL/qc6RQHkYuqWGV5kA9Y709/pGuODue2rG/8qw8NDrKn7viim7s7Eh2
6jy6g3YnFV4k/TLWcQUk0/TBzP7mXcQKH1GyWqqyJNYLRVtnE4YizDZMenfemJcO
zj85JNoNT7OeNb9nRoLKgmc+fx1l+61Qgl5PlkYszhSo1ErRkjNhp0RPb6rk/VK+
jB37eBfXKt77MO0ErY0YhGRslc9SAw==
=uNbu
-----END PGP SIGNATURE-----

--oYlXbbV4DqCH2MQPln8YvQ2fj9n6t4MVY--

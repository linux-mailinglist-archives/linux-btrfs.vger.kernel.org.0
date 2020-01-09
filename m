Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D6135330
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 07:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgAIG1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 01:27:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:34419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgAIG1M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 01:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578551223;
        bh=FUhH7o8YvG8ShXTRHuUD6NmSWmaq4mdGHap2MGFhcWc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ILJ5tg+lj+M7GC/x6BBdC5Kj8j9TCzM8p1jQFW4F4BZw0AMNkBE1wEFyW7/yA3rSz
         cy4q39auxnenYPPHf/FFgSu9xojmapBCWlBoFM0kxNwfvrCOXKsHzzUwAYijxLBzfk
         38RmPTg+oX29oIJWfo9eXcqwtEMgcpcaZahE0MRA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1jDLoL1Ct1-00XpoE; Thu, 09
 Jan 2020 07:27:03 +0100
Subject: Re: [PATCH v3 1/3] btrfs: Introduce per-profile available space
 facility
To:     Qu WenRuo <wqu@suse.com>, "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-2-wqu@suse.com> <20200106143242.GG3929@twin.jikos.cz>
 <9c2308bb-c3ae-d502-4b27-f8dbedc25d1a@gmx.com>
 <20200108150441.GG3929@twin.jikos.cz>
 <e1fa655e-e42a-4bd4-6f83-6175c38a1219@suse.com>
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
Message-ID: <fabf8be0-242d-b682-b6d2-c17027c273ce@gmx.com>
Date:   Thu, 9 Jan 2020 14:26:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e1fa655e-e42a-4bd4-6f83-6175c38a1219@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gaRb3dYJsUliYUHCJ15zt4pdjacQ1V56V"
X-Provags-ID: V03:K1:aFRzx1EDbLi/XL3+0dLTtfoNDqTcDPfARfW2jFPM0IsAB3MpiXr
 V+mL7lLL0G2QIrNwJaOITAc9guXBVAkT3pEcJge83T2cvkjqknSidxWGRJmmMBt2GFnnu1V
 SZJxcgLgJl9DtWrQ0ZU8967FSihwl9nXKZp46dE8kDuLUqpUZUufysyeX8mIbiKIzikGGkT
 DQlvLqGwFdy4/JkVEqH3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1NxaG6gZpQk=:cQYivy71xazEQyCm8YrTQz
 cNtfAGGZDxpg/GE8h+G6SOfCl30y+CbHA09w7QabdIdJKnexHi3k6u5KxfYklaTy/Y1LbyTSS
 3eXjf+Z8rcs65+lLjEbZsssMlqe5uYW5b866ItGgRB6NBzm1YT1AEu2cIH2OYtauXNMfrhE2H
 cE3DQWX6/tfoO1teBFd37ECYrksKNla3iltj9yE5nnWjvnMZddAjX2U9ksTmH6d4NVWmE9xSd
 z+ksRimZmpgSP0yIuFYxX8nVUGsTrRu6nYCeIxSazXdi7mCgTAzA1jOnHwWuEiLpUKWoYgeuB
 N0S54LE8feb1batqqkBqNcihrnSMuLYYrda1XDSpeCm9tPkyNpBEelvTU1oMRLI3pr3shtVTB
 nxmErXrJFMUUsmYkDloGw8c2BS9Ia5ySw4q+EMxyEjNue5Ze9S98JXS85efrDMJL3/T1Wodq7
 Zufg+CipMFvx/tQk9rDkDuTJfXi6yFq8s6QsaMWydd7rYuV55Kmb3GFFzrBBAAtms/yIwJCa8
 XbqAQd4tNhTS99Jz36wApQj7jMFAXyKWeXSs1VBvksKr5avSmXvpLatsoxufAqgzNp217D6wS
 UmOfpAuiz0kxDvN8Fsi+88qpnmkBtbj8HFRGLmKjTpQ87lPpPDdE/gGOXwuKHaVXwFRtPHZ6T
 SDYCbjEaUWD891O3PB4pDE81lvL7eYr6jSMY4QS1aUcfooGWKTnwACP/JIL7t7TewxVuwKsWX
 Dx6dEc0B4FvdQz1AErElf/hUKic2vgzAZEd1thwLwe12GVsQdzshqzFDSdkxGLdx+AWg3BC3v
 jWKJRcollCL+n3rAcYjs41aRDhaKcJOGEJ/Nc44Onb3GbZmXy7EyQrrK3d3OWXom1+3f7R0ab
 AvS61pPW6nUlLFR942Z77mD+ioy7SDXGBdjkgP4OZWV3QhU/p4sxVao+bBeUGKdq3cl/d2e37
 WgcnDqspKBCqN79LBhDv8xTxxRMI3zDyNCAQ8Sq86ujzseDKB/Il2yi+ripqXVNiXhZQnNLL2
 UlD89tIXL0+MPQdwD1opcpM59tr8MQ6e15JP5lSazyT1qVDQu/egsUnnKMlDgMD0Zx2ydTtKd
 6PJ1l0nkUFUK8uAEyBVD+DwH1tl3wIOthITh6zrR1YXtz74lWNzE1lfinf0NxSyPM3TF5RH+B
 068i3S0TTkkDV2mTlTYh7lGhIbsbcrP3bfrdDD0Cjc9lqBH+lexd6hVhPQjCQoQj7Jp6mEikh
 CHDSRPxhqVfiWHOCBoGar3IEADBrLfAphf23b1TWeYoRBs8hGbBmk0OuA2CE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gaRb3dYJsUliYUHCJ15zt4pdjacQ1V56V
Content-Type: multipart/mixed; boundary="xhXc3FN2HUPTqaQXcBfc7MPXk7hVs7wCY"

--xhXc3FN2HUPTqaQXcBfc7MPXk7hVs7wCY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/9 =E4=B8=8A=E5=8D=887:53, Qu WenRuo wrote:
>=20
>=20
> On 2020/1/8 =E4=B8=8B=E5=8D=8811:04, David Sterba wrote:
>> On Tue, Jan 07, 2020 at 10:13:43AM +0800, Qu Wenruo wrote:
>>>>> +	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_=
info),
>>>>> +			       GFP_NOFS);
>>>>
>>>> Calling kcalloc is another potential slowdown, for the statfs
>>>> considerations.
>>>
>>> That's also what we did in statfs() before, so it shouldn't cause ext=
ra
>>> problem.
>>> Furthermore, we didn't use calc_one_profile_avail() directly in statf=
s()
>>> directly.
>>>
>>> Although I get your point, and personally speaking the memory allocat=
ion
>>> and extra in-memory device iteration should be pretty fast compared t=
o
>>> __btrfs_alloc_chunk().
>>>
>>> Thus I don't think this memory allocation would cause extra trouble,
>>> except the error handling mentioned below.
>>
>> Right, current statfs also does allocation via
>> btrfs_calc_avail_data_space, so it's the same as before.
>>
>>> [...]
>>>>> +			ret =3D calc_per_profile_avail(fs_info);
>>>>
>>>> Adding new failure modes
>>>
>>> Another solution I have tried is make calc_per_profile_avail() return=

>>> void, ignoring the ENOMEM error, and just set the affected profile to=
 0
>>> available space.
>>>
>>> But that method is just delaying ENOMEM, and would cause strange
>>> pre-profile values until next successful update or mount cycle.
>>>
>>> Any idea on which method is less worse?
>>
>> Better to return the error than wrong values in this case. As the
>> numbers are sort of a cache and the mount cycle to get them fixed is n=
ot
>> very user friendly, we need some other way. As this is a global state,=
 a
>> bit in fs_info::flags can be set and full recalculation attempted at
>> some point until it succeeds. This would leave the counters stale for
>> some time but I think still better than if they're suddenly 0.

BTW, not sure if this would make you feel less nervous.

When we return ENOMEM from this facility, the timings are:
- Mount
  So really not something would happen, and no problem would be caused
  at all.

- Chunk allocation
  It's from __btrfs_alloc_chunk() which also do memory allocation by
  itself and could return ENOMEM. So no different at error handling.

- Grow device
  This is a little complex.
  My new error handling is aborting transaction as we didn't reset the
  device size to its original size.
  But the existing btrfs_update_devcice() can return -ENOMEM, even
  without resetting device size.
  From this point of view, my new error handling is at least better
  to avoid device size mismatch.

- Shrink device
  This new error handling is overkilling.
  At done tag, we have method to revert to old device size, and we
  haven't done anything yet, so we should be able to recover from that
  situation.

Anyway, I will enhance the error handling part, to make then recover
without aborting transaction for shrinking device and growing device.

Thanks,
Qu

>>
> If can_over_commit() is the only user of this facility, then either an
> extra indicator or sudden 0 is no problem.
> As in that case, we just don't over-commit and do extra flush to free
> meta space.
>=20
> But when statfs() is going to use this facility, either sudden 0 nor
> indicator is good.
> Just image seconds before, we still have several TiB free space, and al=
l
> of a sudden, just several GiB free (from allocated data chunks).
>=20
> User will definitely complain.
>=20
> Thus I still prefer proper error handling, as when we're low on memory,=

> a lot of things can go wrong anyway.
>=20
> Thanks,
> Qu
>=20


--xhXc3FN2HUPTqaQXcBfc7MPXk7hVs7wCY--

--gaRb3dYJsUliYUHCJ15zt4pdjacQ1V56V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4Wx7AACgkQwj2R86El
/qiasQf/R55zTU+/fR+Xq3Y+m6M1AvBKFrTC/XA7p2kENBWO+NcvVhsBZipikIFG
14J8Z4jxXUUhgUaa/8Ry3d0pkqGk5mT6V0oo3mNDFFpWTHnR9fZJ9duG6uQ+pNaE
7JI1OA/xoJxvB+61kVpBQWHmK8bQJcke6crd9wLCVA0DGIZObj/KQTmXic8UaAnX
EPDvjEyNcr2livX7p5uqHXGDKkTVwZsT9kNPjlFHB9sZEzVESMhpwMkOwekwoCjY
63+2iwNVwFpI9jnGInweNUeoG8KIdMWusIcp3xUY5Pb2ZSw8GixuP8BApVnEkRJM
qIEDAvFQvBqt4dfuGv31lisobuEBpg==
=rOD8
-----END PGP SIGNATURE-----

--gaRb3dYJsUliYUHCJ15zt4pdjacQ1V56V--

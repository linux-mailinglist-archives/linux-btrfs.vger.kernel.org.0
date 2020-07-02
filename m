Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24CE212533
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgGBNuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:50:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:39165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgGBNuv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593697846;
        bh=EkTbmfRAIWWoiO4FNoYtL37Xk3I7PC6RzlBbeXmu85E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QVwHuL5DJSq8OywcXRS76Cby1lheoqoOoFHXlJUy/NvL8qZIFT7hZDkSXQOQn7Pr6
         eXymHmwUwoIxfsdPcyj2WmjqYMUHA5HuLlCl568i8eyISo15zaCR1nl/1l7TiNxXBr
         R5H1N7jlhegXN/sx2fx+XZlRSkQw86tLQUea38uM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UV8-1jrXZn0INe-000Zfh; Thu, 02
 Jul 2020 15:50:46 +0200
Subject: Re: [PATCH 1/3] btrfs: Introduce extent_changeset_revert() for qgroup
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-2-wqu@suse.com>
 <b716bb32-b5e6-54a5-ac42-ca559dfd2d3a@toxicpanda.com>
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
Message-ID: <55b63978-fab1-bb2c-bd0a-66fc29af5f26@gmx.com>
Date:   Thu, 2 Jul 2020 21:50:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b716bb32-b5e6-54a5-ac42-ca559dfd2d3a@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fyM6ZUPVkPCcUHfDc8WRb34mQdRHZSeSq"
X-Provags-ID: V03:K1:Hq8gb29spKJ6JT6HpmlMtqb/njX5tzvvtSkCbYLRzIMoyYXNBXb
 iY2G5GO6PKSC7tOEAgtCRFRu6bWiG60EDKSMbbx9CJyUsJSMMT2OeLrmsFPzjUTk6r0qx8S
 mIB0tUShTRgkw7T/Vb83vif/D/Rai+xzqKsAXErgQPbmLK45jATiPlYKACNEWQTpCqLpXmC
 y7keUvHdGn2/CEVGKg0xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qr9uACZ1Lhw=:VtK5XGoD/s6+iVyXhtdLSz
 kd8WRzljpTjw7POiiAopaDkJIZQg8lRc3vR+umDfGUTXB5I1cNKEv9WKP568sxL6tW7YactHu
 fIHAi/X8S++MYPglzzzo440XF7tudLOxiyg+ZmUmj1cD9c2scdz13UMEB4gZJj+XTPCgRJzk8
 jskpkFMwl1gSQfvGrZuGDUOXlZw4rGRK79Mf5hBC3UBaVL28wZJ1eOnAEDuibGRYj83jProD1
 HI5CRfHAIQwBYjqhjmI9oLU0dvd4rMh3lVA9HU/pG8DSSX1Lz2jCLawtoEilJjbmS8EwC74ON
 soFmT4XVpWSiSVR/v5jHBrpcHyXim3HGY8LJy4CYYA56kpQIEnrikKXkV2Nz04oZzvyKSRwo7
 SVP/hyK180DKzslgVQ/O41EkQMS/fyQsQ8/noeBvqYWoeHdWfMomnTCWtogP2P6Epm2dQoNTt
 0NliWk9FMfCOtlHslXVEWXTrAQov5YhYvLUFo5FpU+mpedrDJ5E7zAQI/xYFeVPAbHfjVLVyF
 PQs5uZJVFDvzXrKCOMuGXqo0Wf0d3WaKdBZTvK/PLRFnek+J2Ob7dftilCHZYZmvPRQ9Upfbm
 zhDPK8NNfq05g6YCZpIOsXOiUYtWm1/tiYr4rHHugy84WOsNAGQhZkzwO/rs/4QZti+wEI1Ti
 xURHP/0BdJi6m6Kk/blKOj0vFVW/uWs5BkiSxRl5+qgK3KMXwr4k3JhH9JGdaBs0CAJ+gXizd
 DhaDzTSI1uQPag2ru5FlXyyGn8F405McUtQyejHRZWAdW+HTssy1wT/6xQ7hfRmFWEuzlgL27
 3f9+yz3Lv22Fw6FHD4o+yAvMUQNCSstlOtLNeH19U/v5mwNnWQU0CGfNnJCt1tyLcljdyhnOG
 0CYb/TSdZOK8jCzJnq87rSNlorqvi79gU+yiilD/v7IXG8W/w0zgjtDbaLkGxCWrxNW4d3kXT
 rawDXtsOyLP4gzSgFXWq9Z5x9T6AppFzM4W+wZRFx2nc7WdAb73VziffZMYWt3tG5wqeilaSU
 CeaCeDjhw0JjyliidRoGQue4z4cObicAXpNUU6Z3UFa+UxhZoZDM1+i+6KuSotVbD6RvLAapD
 0mv1q3SjkHizbH1axd0kMPRGRvVfOU2q84W7WspkOowlBUKmGkfqD8XvzqtwzbkVfRvwYoVHD
 QyZzNhEJWN2kP7DOwJ2UNae0V0HkdNhl7iIG6VO+wqyLJ0V+X2fICRHi5pSw5iyHwJ7pDmIuW
 CtONKrYpMFMirFOSw2UVVuAOuGt4rzoZ/pAOfig==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fyM6ZUPVkPCcUHfDc8WRb34mQdRHZSeSq
Content-Type: multipart/mixed; boundary="ulRBgwEmjvor7jugbviZX9JrkhGQlbkRI"

--ulRBgwEmjvor7jugbviZX9JrkhGQlbkRI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=889:40, Josef Bacik wrote:
> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>> [PROBLEM]
>> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all=

>> reserved space of the changeset.
>>
>> This means the following call is not possible:
>> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_qgroup_reserve_data();
>> =C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -EDQUOT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Do something to free som=
e qgroup space */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_qgroup_reserv=
e_data();
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> As if the first btrfs_qgroup_reserve_data() fails, it will free all
>> reserved qgroup space, so the next btrfs_qgroup_reserve_data() will
>> always success, and can go beyond qgroup limit.
>>
>> [CAUSE]
>> This is mostly due to the fact that we don't have a good way to revert=

>> changeset modification accurately.
>>
>> Currently the changeset infrastructure is implemented using ulist, whi=
ch
>> can only store two u64 values, used as start and length for each chang=
ed
>> extent range.
>>
>> So we can't record which changed extent is modified in last
>> modification, thus unable to revert to previous status.
>>
>> [FIX]
>> This patch will re-implement using pure rbtree, adding a new member,
>> changed_extent::seq, so we can remove changed extents which is
>> modified in previous modification.
>>
>> This allows us to implement qgroup_revert(), which allow btrfs to reve=
rt
>> its modification to the io_tree.
>>
>=20
> I'm having a hard time groking what's going on here.=C2=A0 These change=
sets
> are limited to a [start, end] range correct?

Yes, but we may be only responsible for part of the changeset.

One example is we want to falloc range [0, 16K)
And [0, 4K), [8K, 12K) has already one existing file extent.

Then we succeeded in allocating space for [4K, 8K), but failed to
allocating space for [8K, 12K).

In that case, if we just return EDQUOT and clear the range for [4K, 8k)
and [8K, 12K), everything is completely fine.

But if we want to retry, then we should only clear the range for [8K,
12K), but not to clear [4K, 8K).

That's what we need for the next patch, just revert what we did in
previous set_extent_bit(), but not touching previously set bits.

Thanks,
Qu

>=C2=A0 Why can we have multiple
> changesets for the same range?=C2=A0 Are we reserving doubly for
> modifications in the same range?=C2=A0 Because it seems here if you fin=
d your
> changeset at all we'll clear the io_tree, but if you can have multiple
> changesets for the same range then....why even bother?=C2=A0 Thanks,
>=20
> Josef


--ulRBgwEmjvor7jugbviZX9JrkhGQlbkRI--

--fyM6ZUPVkPCcUHfDc8WRb34mQdRHZSeSq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl795jAACgkQwj2R86El
/qgMwgf7BLjQHg4z33T86kjTAJtGcxmvZLa+62H6h5CUS7b0JlUl53QPMXg0YFTN
msK4GfEhY9Y8aAm7y7kksL4OWXS8GumfWtJbNcbI7FEthjz0pE2sxIUweScDmP2m
HlVsoHuDVDtIV5vRLJxhCeFV3rfc4/Wg2HX2UKfchqz/GUnxD/GvgvDL6AIwK3NJ
KZ21CKXc52tMKM8/zS4/nEYuL/1otNkK1er59S8YdQ4dbE+vpF3yb/YxqDVk0DOs
hQV0g++Rs78yO9P6RkPhrtshxy8TW0kw6iEtqFm9z4dDordehyqMsOdXEDvETWC8
nb7e/A3WOR9z7SR2gYCJMPdVrjMzMQ==
=IRtR
-----END PGP SIGNATURE-----

--fyM6ZUPVkPCcUHfDc8WRb34mQdRHZSeSq--

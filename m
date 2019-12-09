Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979CD116513
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 03:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLICoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 21:44:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:39643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfLICn7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 21:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575859436;
        bh=IOuaPWlbridJ/MSpolKQl20ndXJ5Mn8lwbShxiPcMyY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IkSlQQDk8jT2hfWfSHzp/Efp+M/xOqThGwRsRVulpS6Uw3vye86B+RUfKoJVHOiQe
         0oEILKpeSPjC5pzJSLHh7+8TggC6t4ij630u1NWRKj9DYKwa1bkbUJCVVNIoENmhYE
         jRxQgsnCtpOXpiTI5mV1hm2hQ7bBOd5zeaeZL2nE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ3t-1iGmiM3Et3-00WE3v; Mon, 09
 Dec 2019 03:43:56 +0100
Subject: Re: Unable to remove directory entry
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
 <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
 <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
 <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com>
 <CAJ0EP40UUPe9VrF1x8mxnEhFxiTzgC9DkQZB684UuMF1571D+Q@mail.gmail.com>
 <d954ccdb-ac9a-1209-130c-e3b34e4a7a45@gmx.com>
 <5506e5de-a9f8-4830-8172-c07343da4218@gmx.com>
 <CAJ0EP40Pf7m7G77egwRjpSRSjvoMKB_PaRzmRxr0weohCr7tBw@mail.gmail.com>
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
Message-ID: <5bbf99c7-a583-e24a-0fa4-3b2b35fb01fd@gmx.com>
Date:   Mon, 9 Dec 2019 10:43:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ0EP40Pf7m7G77egwRjpSRSjvoMKB_PaRzmRxr0weohCr7tBw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mnjH6OYhHeebp2FLx5sxAfUbS1ShYZdjY"
X-Provags-ID: V03:K1:U5ptAeUaS6nM8RU6L493+rXNk6h7cb6XpbKh/8p8Y6kHD86tuSU
 S11Z4ld1fnCCyvL1BHsPa5JShH921g3N3XvmLtMctzmk/tXvI4d3o4OwVk44uSvdT5cuX18
 /7edEXnJ3V/AV3UFsBxKYpo2pbd0NEw16UhvkOxtbSFqB9nboJL1QRGYbEvggAhsWWyCcQI
 ebvHHgzVyKhtlklHKFvaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yn99HXxfs6I=:LYnz2GkLFe8aoHZ+TWXyXa
 xofMb9JoKlE78T7QZqIPA1CWYutic5qIcjRfZ/7oBnvTx/xoApqLaHr7PGZibuMTTj3lg2mR5
 vRXQL36WxzkhKQzdH0/HOcduNWgwVa+ghZffduUILIqLcH5V6HKjAPASHoxdnE+HzUjC8MYCh
 t/3JmttU6akTREtRDdDo69AUGQagdNmAkTctbp+GeZuIzza5i6+4PdhRBbMnYCeOJcuzbyYLa
 NjetrdsytlqgZjGMewKGopLjlTpTjqDmJP7d8r4TLqHzEB/kZxlDFvhGneNkY+94EqjCMf/KX
 QuQt0dr6i4ZNos5QCFkXIt8YTgRgSGCVvkYxBg6MOZxG3SCBvr8KLz0ZJkIR5fa8i1s7rE7zN
 wan0zd1n4OWLOlCSxVWcQfAl6msEKjuT8NzLrA6x/bDvewUnhw9mZeSUFAzNiNlrOhGeVkqJn
 ewncJOrkH1c9L2GUS7LZ3OMOQi5pRIoH3zYgx/ByUiBjK/Lx3JLX+V4slItn1YRQF+dOSLEwh
 cPpQ5U0iP/o2a8mLpEK5tRiPsnqbmUlFKjXCIz4cY5O8xQenzPKMTb82B+xRZz4g3a3yl77uB
 eRs8KsJ+P0bFS+/X0CfjKXGQdn0vM7DUnVyXHHS7lUhyJEBTpcS8CpAtCMn47a4M0smYJGJUW
 Hjt8XSD09Nu33hvvcFMCkrmdruC+x4ycX5kzogBy1/rCeyawg2G0XNp6SRxiYvvpJZ2m1+DO5
 EL+hVkZ8qogKZABDfNps3iijrsG5OeCTtg/9F8rWiAFNkZgWGVRrMBAwEnzre+zuZqX0dse7g
 KXDqZ9CRhZN+j0ghv7IhhTIYMDjOyTa/t8I87yXwA4+EakUX5djYzCID8YlJa7SicfTEOGBfI
 LsVpJhN5TgsNdFj3nwz2/C1TzZ8H8mjx9jvvI22XxzqqFcC20b7Z7XjQGnZdR9nDwIrIpXEBb
 ZuF11qK96YMyr/vxqpSdV0QvcnOQj9Z6keS89VQfWSSzKSTq2qMsnXO1zpcem7TLxNmyWoAKq
 lBaPdVoOcZfrvyszKCSLKARgnKvIcVMuHhLJ9or1DZFheDVZ39JKGktveTFKpsEHM/czf820k
 7n1VKGFWjuQ3jaR+YfCdD1dR803ndYsIG6mOeFv/7XEmBk/Ub5LPkn6XwWsK0xhsiBb+om6Rj
 bF+zrT9kS5TshX+ppLf6q74H41cFUQI34THVo09aIXRKKPmLVjemlecx3MXk9rQeI0ntnXC+P
 z0gtgVL4GdeNCA9XHM/BxGhnxmuL8X1xKT9rmBM/uVKN9nedCiRLa76GGvzw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mnjH6OYhHeebp2FLx5sxAfUbS1ShYZdjY
Content-Type: multipart/mixed; boundary="fmdPchZ8VGAGA2Wlwgu1xV6orgtkuvnXA"

--fmdPchZ8VGAGA2Wlwgu1xV6orgtkuvnXA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=8810:37, Mike Gilbert wrote:
> On Sun, Dec 8, 2019 at 9:20 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2019/12/9 =E4=B8=8A=E5=8D=8810:05, Qu Wenruo wrote:
>>>
>>>
>>> On 2019/12/9 =E4=B8=8A=E5=8D=889:51, Mike Gilbert wrote:
>>> [...]
>>>>
>>>> Here you go.
>>>>
>>>> I ran this while the filesystem was mounted; if you need it to be ru=
n
>>>> while offline, I'll have to fire up a livecd.
>>> The info is good enough, no need to go livecd.
>>>
>>>> --
>>>>        item 6 key (4065004 INODE_ITEM 0) itemoff 15158 itemsize 160
>>>>                generation 21397 transid 21397 size 12261 nbytes 1228=
8
>>>>                block group 0 mode 100644 links 1 uid 250 gid 250 rde=
v 0
>>>>                sequence 23 flags 0x0(none)
>>>>                atime 1565546668.383680243 (2019-08-11 14:04:28)
>>>>                ctime 1565546668.383680243 (2019-08-11 14:04:28)
>>>>                mtime 1565546668.383680243 (2019-08-11 14:04:28)
>>>>                otime 1565546668.336681213 (2019-08-11 14:04:28)
>>>>        item 7 key (4065004 INODE_REF 486836) itemoff 15104 itemsize =
54
>>>>                index 13905 namelen 44 name:
>>>> 0390cb341d248c589c419007da68b2-7351.manifest
>>>
>>> That inode exists and is good.
>>>
>>>>        item 8 key (4065004 EXTENT_DATA 0) itemoff 15051 itemsize 53
>>>>                generation 21397 type 1 (regular)
>>>>                extent data disk byte 6288928768 nr 12288
>>>>                extent data offset 0 nr 12288 ram 12288
>>>>                extent compression 0 (none)
>>>>        item 9 key (4210974 INODE_ITEM 0) itemoff 14891 itemsize 160
>>>>        item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74=

>>>>                location key (4065004 INODE_ITEM 0) type FILE
>>>>                transid 21397 data_len 0 name_len 44
>>>>                name: 0390cb341d248c589c419007da68b2-7351.manifest
>>>
>>> Good parent dir index.
>>>
>>>> leaf 533498265600 items 128 free space 6682 generation 176439 owner =
FS_TREE
>>>> leaf 533498265600 flags 0x1(WRITTEN) backref revision 1
>>>> fs uuid 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
>>>> chunk uuid 0be705de-5d3b-4c23-979e-d7aaad224cfb
>>>>        item 62 key (486836 DIR_ITEM 2543451757) itemoff 6273 itemsiz=
e 74
>>>>                location key (4065004 INODE_ITEM 1073741824) type FIL=
E
>>>>                transid 21397 data_len 0 name_len 44
>>>>                name: 0390cb341d248c589c419007da68b2-7351.manifest
>>>
>>> This is the problem, bad parent dir hash.
>>>
>>> The key should be (4065004 INODE_ITEM 0). The 1073741824 (0x40000000)=
 is
>>> completely garbage.
>>>
>>> That garbage looks like a bit flip at runtime.
>>> It's recommended to check your memory.
>>>
>>> I'll add extra tree-check checks, so that such runtime problem can be=

>>> detected before corrupted data reach disk.
>>>
>>>
>>> For repair, I'll craft a special btrfs-progs for you to handle it, as=

>>> that should be the safest way.
>>> Please wait for another 15min for that tool.
>>
>> Here is the special branch for you:
>> https://github.com/adam900710/btrfs-progs/tree/dirty_fix_for_mike
>>
>> After compile, you can use btrfs-corrupt-block (I know it's a bad name=
)
>> to repair your fs (must be unmounted):
>>
>> # ./btrfs-corrupt-block -X /dev/sda3
>>
>> If anything wrong happened, your fs should be kept untouched.
>> If repaired successfully, there should be no output.
>>
>> Thanks,
>> Qu
>=20
> That worked. Thank you very much for your help with this!
>=20
> Now, I guess I'll fire up Memtest86 overnight.
>=20
Just a reminder, if tree-checker is properly enhanced, for 5.6 even with
bad memory, we should be able to detect and prevent it in advance.

Thanks,
Qu


--fmdPchZ8VGAGA2Wlwgu1xV6orgtkuvnXA--

--mnjH6OYhHeebp2FLx5sxAfUbS1ShYZdjY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3ttOcACgkQwj2R86El
/qiDigf/S7IjyZNOGZ/A757K1CHPU1BVzRruaS/mvf+G6Q99roajCfC29sWLb10W
WDFjbZP8OFLC+VUZ7P2ksyyxW6D7SVZD+gf+758g5VZVfepr4g2XbS3EgE/UFzy+
pt2MphUFAq0EAo0L4UoAmrRBcZJ4HSL25EM6b8y2Ya3Ht/Yv5hztyx1nCTmDiezr
9kpmy3CpS+rhlbXP2addg4aBFtD/tJRJuq0adn3jcAZDDVxwdisF5sBgV6ySBM5t
2QZVl3Oc44sqP/yOeAdCVN2LpcrE4fEq0zc/3/4YunaI+7ez99IGKE1Wd/s6Vwhj
1oEI7SahT7S9D/CPq4c5VtLFGmYSlg==
=DTav
-----END PGP SIGNATURE-----

--mnjH6OYhHeebp2FLx5sxAfUbS1ShYZdjY--

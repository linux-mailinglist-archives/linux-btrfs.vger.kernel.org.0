Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81C5E62B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfJ0NnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 09:43:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:44535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfJ0NnK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 09:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572183787;
        bh=Q+hhTq/2iI4JKgiVz03GAHhPZQRNenIBOn4mtA/++a4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VkrQs2K+yLDCgbakoEmu/ySM9Eu+IXvo06+e4b/SFOyiq1BJyUGuqRx118Qz55QUH
         V2h9V+zi4/0QGh8kuxX6CwfyVt3kDY+yx6HhQX0AREzl0E1dVVcSYCiPyXRMIWugAE
         1qMZ0vkV2RYnac0QjCopisQQ2fAz4hFBxUDhSZ20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWAOW-1iVwjQ1S8Y-00XaiG; Sun, 27
 Oct 2019 14:43:07 +0100
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Atemu <atemu.main@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
 <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
 <CAE4GHg=-K3JdhvQpTC8fPGBm1sVLDOUW+UkBCSZJwz27fkW90A@mail.gmail.com>
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
Message-ID: <944da320-f5ff-9290-27a1-e39aed7d6d21@gmx.com>
Date:   Sun, 27 Oct 2019 21:43:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAE4GHg=-K3JdhvQpTC8fPGBm1sVLDOUW+UkBCSZJwz27fkW90A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dJ0piif2gUduuaD31VMMdySRmjQz3aRsZ"
X-Provags-ID: V03:K1:QuKr5gjzaGKKehZBmrH91L1PTnjX5zTD+r96BPt51ryiTdDhnv8
 ZAMiPPkKTM/MXEiWuyRQA2FnwXO8k5KAKY8a0Jw+y8AJUAlENiAU3eBxRMbBvQiPlAETovM
 Xg4Krr3zY4ac9W8g6i/SUPNihLR3gm/+6Kg9Hr+Ykyh0EOPJE0bgL8R368R1sclGoGzx21B
 qjMa5GQIzGDuqTqdgkIBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:12ZixJIEkHI=:91iY5Be6OMzFGATA8XZ6ri
 zGrAyYxP5Vo8iBxRpgG3l61OulCTsUeVx7ilD5bCFWgVqHB4XGHTrUMXgQ33sORj2x8O4BY1I
 ceWoPD6xmudN3s66JpBcdjj3YiGkPWTJ8wtL7k6BLgxxlxL6x/IyK4eRSrpDPmxyAKeLTQcIs
 xyesfsFqjgMks7IHPrKOxpsNQL7QbswX5fj7eY5gcpoEV3RxRBaJjR0EccEu9Pa7NOysMWmhU
 sPGX5Yu7O1iIb2zq9Lwvi7PblZTJLM0QBLP/I4vZmqVfOvBKA5Pv6/zkTeYlkOqBEormusk6c
 tDTinJSG8xUjwZO+xg2UrGkIJMejQx7WmiuaNxZgT9H8OBm3EOatD+5CD8h5bHkUefp696lQ8
 atJSgyxTQ8UuXqCLJASEWXXB8jPnPRdhmIoIjCN8DqWnbQ6KVwKN0cz2uf7Xs6XieraZs/Y6/
 0RUh83qiUG+IAlwUQXBjG1eS9IvSJhjyY1qlRdMICeKIFY1SAqsCYVDWYgT/U1lTTx7R7/tUU
 /A8rNJOxOwWEr2Dhw3OychzPE/tRlCBC1xvU1O01xAgn5aX0Rk9tJY/zN/Sf2g5xuRzi5d3P5
 Hcbeerjv9aVB/AWJpDy4mCncKBpwkO/NRsB0iwSObxkCaVVAd95AgK8QWSlLaqvYFzE38YHdK
 l5XtDWE6jjMjzndLK3EOsqLMFt1LJVxZNHLu8WB+/pkPcjkxnRJ2AVZRz3vWDOdSavF92FExU
 6WGnAqWCKalDTv+hexNZvHr2rJOLs+hZWF+f5/wi4ur9MZnfWgg0Qe1FTc9Jesl2dC7RFKkrD
 DNYg6WsuZhcC/25/rOv999feSOfEMlF068ZnSnRd/NYHKQWVr4q/9EUrU50Y2ESfYR+WWvrOs
 kPlxAqiTV5j2dHKfzWKh7vp11ALrEgSY4i3VR+FDmpHBbWXsR838LP0lE41uWlXxlvGuNAN0j
 f7o7+zHG9CEuYwhoFEhZ42DJL1d8NYGf9BRaEg8K8gmpv4PwgBL7C663J74IrGq0Jlluff87A
 1NQEbuRSUN6K/f6KrR/gzbhv5CW7gA3tMeVl0LfVjT1fQLEjnZcviSOXa1fMD0UD+IMkeyWVJ
 WYa0bAz11zHIyTmkqdmRuxrMURt7qMzO/uPd2LE8AS+cWvicY8OwacWmfH7Rvqiy9O+DqmZ24
 Ylt+OPpLQuWy1upHo6ikZgWRDVo31/V4helZDQH/9HbxL1jRIHo2Git9YpjbhFuaqFX5TV07l
 x8SZo88tLamdiETcxQSNPn1XC1x0vpEdJkEP1JczBZdA/7hr6JnBhPlI3AGg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dJ0piif2gUduuaD31VMMdySRmjQz3aRsZ
Content-Type: multipart/mixed; boundary="RWKPjPvutdDhF1vXqdUcgckDwRrw3nE7S"

--RWKPjPvutdDhF1vXqdUcgckDwRrw3nE7S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/27 =E4=B8=8B=E5=8D=888:55, Atemu wrote:
>> This depends on how shared one file extent is.
>=20
> But shouldn't it catch that and cancel the btrfs send before it panics
> the kernel due to its memory usage?

Backref walk is quite tricky in btrfs, we don't really have a good way
to detect whether it's a good idea or not, until we crash...

But at least, we have some plan to fix it, hopefully sooner than later.

>=20
>> If one file extent is shared 10,000 times for one subvolume, and you
>> have 1000 snapshots of that subvolume, it will really go crazy.
>=20
>> But as I mentioned, snapshot is another catalyst for such problem.
>=20
> I only have two snapshots of the subvolume but some the extents might
> very well be shared many many times.
>=20
>> I can't say for 100% sure. We need more info on that.
>=20
> Sure.
>=20
>> That's trim (or discard), not hole punching.
>=20
> I didn't mean discarding the btrfs to the underlying storage, I meant
> mounting the filesystems in the image files sitting inside the btrfs
> through a loop device and running fstrim on them.
> The loop device should punch holes into the underlying image files
> when it receives a discard, right?

That's correctly, that will punch holes for *unused* space.
But still, all 0 extents are still considered used, thus won't really wor=
k.

Since deduperemover has already skipped all 0 extents, it should be a
big problem I guess?

Thanks,
Qu
>=20
>> Normally hole punching is done by ioctl fpunch(). Not sure if dupremov=
e
>> does that too.
>=20
> Duperemove doesn't punch holes afaik it can only ignore the 0 pages
> and not dedup them.>
>> Extent tree dump can provide per-subvolume level view of how shared on=
e
>> extent is.
>=20
>> It's really hard to determine, you could try the following command to
>> determine:
>> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
>>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
>>
>> Then which key is the most shown one and its size.
>>
>> If a key's objectid (the first value) shows up multiple times, it's a
>> kinda heavily shared extent.
>>
>> Then search that objectid in the full extent tree dump, to find out ho=
w
>> it's shared.
>=20
> Thanks, I'll try that out when I can unmount the btrfs.
>=20
>> You can see it's already complex...
>=20
> That's not an issue, I'm fluent in bash ;)
>=20
> - Atemu
>=20


--RWKPjPvutdDhF1vXqdUcgckDwRrw3nE7S--

--dJ0piif2gUduuaD31VMMdySRmjQz3aRsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl21nuQACgkQwj2R86El
/qh9Zgf/T1qRbyfc7CU5kn2CyZMcZ8sODBgCoUS/lEsM0lkXHspnZGz/yuaDlycS
srN+cso0HajtMUTqA5jCefPMce/VsvnxkvTBqz1zvFukboyXAOOhB5JM6Ly9Y3Pp
hZ2W+jYVkAQLF+n8AX1BdRzrkQ35rzhchFnOikbe84mY5s6BT7wy6ms5sqeFx17h
4kuOAV22JBvPA2TeYlR5wJ7cXYwZje6ViJtzbCOhuASnBSykLUK6OBKvhNrjmAe/
zYgn/gYQas44SrDzR8Tg/jEwBiHOg1MwXW44aH/pnvVvd1nBLwkeTmQs8zihTzKf
FAgOt2YdbtUaKISC+BjmTVDAezSUfQ==
=JGum
-----END PGP SIGNATURE-----

--dJ0piif2gUduuaD31VMMdySRmjQz3aRsZ--

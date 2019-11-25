Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AEF108647
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 02:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKYBWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Nov 2019 20:22:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:33971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfKYBWk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Nov 2019 20:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574644957;
        bh=e416UyytUtyH0NHVRGTuBBs/L3uqGX2WizO4yJIfuUg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JQYtTUohpbWQKX7hdi11pu44FNggCKlaouojflOOj4KYfWMEO80Ds/rETIIsxf9VD
         o3Cg2FpWmoyDZipCaUpXDQuI3/tyZt9WbpTURLc84xEpr8KjuT3Zp8Di1zy0gmJT4s
         gYbnip8BgVS12lCwSyodR439+fKX1+vozAs4C+wI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1iANaY3Ura-00OrZ9; Mon, 25
 Nov 2019 02:22:37 +0100
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
 <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
 <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
 <2b0f68d6-6d27-2f14-0b44-8a40abad6542@googlemail.com>
 <CAKbQEqFYhQBLK83uxp1gS9WNbTVkr535LvKyBbc=6ZCstmGP3Q@mail.gmail.com>
 <d362cbc6-2138-2efc-00d2-729549a03886@gmx.com>
 <CAKbQEqG362x12PyDUjiz96kGn15xZY_PRdAknS60kKvDDkKktw@mail.gmail.com>
 <75349379-56b2-7381-4201-dbf53e7a111b@gmx.com>
 <CAKbQEqGoJcP9isUVW479wJMeXa=nNPdU_buNVRFK07LOn8D6Vg@mail.gmail.com>
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
Message-ID: <95efcafa-cce2-8004-d82b-c601cba2d902@gmx.com>
Date:   Mon, 25 Nov 2019 09:22:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGoJcP9isUVW479wJMeXa=nNPdU_buNVRFK07LOn8D6Vg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oxAMtFTEtNsQ5Tbm9VgsSuGbzhU1dJz2f"
X-Provags-ID: V03:K1:KMhqnWG0q28z5E3D1TxGs01YxEN+x6JdRv8HPqeW6NYkTc8/pBR
 uyT54YBbSOxW7YQZyWHrBThsaVqzrC7fOjdGHGJB+P+ybS2+/ARPJSre7UarzPBMJRA3pSG
 sOQUEgYc8FGraBHl9x0UvRis3ewv252Mh3R9zicYwR5zIxH0phyzCchCqbOrc2518eFNqG5
 V6FuUA9GFgTxQHqP6/30Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OAE5bxulsCc=:dcG9yrrPzcrdKKH9P8FXVD
 h9uTyRs8OZEBd2SubcTh/RGw/x2AC6plx9kT9ymZouCdCu6O0nVEg5O5EL+MQENlT6O7/JZgq
 mIBL3bs47V82PdAt6ciQkH4cihhDDU9sroGn3uPkHNE3B5n1vE7FvUSSV9oDeudCdu+UJz+sr
 E+X34YyU+F6o5fJopRpmLaLYXMejvOvOoUzW+fGNvigmER34nza8cbVJ8i3nggl7fTu4gC0gr
 LrLIjVBPa5fC0LlqkiU2b3KN4TL3NWWy8zxJMddAnwWGeyrwm+anRj0hE8D8N9fDr8eun/xBH
 G08E2YOzE573vd2wSC7nuCkWrLvFWtkD0rO3OUO0rYlSeiAspIUKz2jv1DfvJLtoXJWRZ9NGJ
 Dp2UyZbemL4esFr2c1C5kI0leNWstHlb91QfwHNG1jSvGUQVHYqvAGIYQ/k9A8BZiCJ7P1kQe
 LXbnQ4TPp+Xm050eDD6K93fc0MK4zoarfM/MyX8jyJx+wOT+tn8gm6XckFGrrbKeOpPRevjo+
 A1c4Yyo0o4uW4rfelRkPvkHHHCd0WYPSWsUyJbVVY5jtT39Hyntf4RbH1yq0E4AXesXjKZU3f
 mnmdn69PdeFcU0R8r6Ammldi4h2WLNOyClxA43KkHyC/b3WU3s21hUzo7BSN2iw+AfvjSpo8s
 vxAPK9qhFh4uVIuvINNKPNlh8ryM31vBFr8cfu8Q7T340bSP4m/Vq9IBtQV7swmH6U7+SUTNu
 KV034ZSWSG0cZ+Ea8gpWzmXwPCjpLgk8dwQauUS950/Zujb9kJQmnOpbGgu33mWYIKphVsmYR
 nWCpUKLq+mdHnXUaUjvJj6T7ZzpNUFNNj28N/B5BqbxRIQp+G0Lvqlq4+nSelJXxPVlx9W9Gw
 9Iz6K+QgxuUp7wVyOCrQmLxsTDgKADK2LR2LB4LrTcPfSSuawwqBSfiK/xpWWdTbr/1fdq/QJ
 T4cIILEpkimdMq4wrUat3fCi02axWg2o+0cWPUcn8UGV1opU84JC6ufJ9E4TNSdfahFfo0oyk
 932GMu4vJWEE/7/u2wHLXJeFJn3kvmznEGf+GKAIhU+xjmw5CpEaGu33a7QB9uTV1pUoyz+R0
 RIKCBiE5ywbP2gmC69d2XUoKdinbJJT2oxI7JrRxsagpoUvAnSsek7cUUpTMUCVhHFOMAP6tG
 6iTpV1bo0Zl0ZE4q6h4gJDr8t1WlY/UpNFR+3cXp7/kp9yIVvSivop0gPANNatizDXgCgf74L
 a74hEKOwlqvb+Na6e5rtgQ1tRUg+fpESm78/C2FIT8GmAxqHP8qLlRIDgH8M=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oxAMtFTEtNsQ5Tbm9VgsSuGbzhU1dJz2f
Content-Type: multipart/mixed; boundary="UbfSENNKVBrdxtIsZWW9A9xxBbM9C7sOv"

--UbfSENNKVBrdxtIsZWW9A9xxBbM9C7sOv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/25 =E4=B8=8A=E5=8D=883:09, Christian Pernegger wrote:
> Am So., 24. Nov. 2019 um 01:38 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> In short, unless you really need to know how many bytes each snapshots=

>> really takes, then disable qgroup.
>>
>> And BTW, for "many" subvolumes/snapshots, I guess we mean 20.
>> 200 is already prone to cause problem, not only qgroups, but also send=
=2E
>>
>> So it's also recommended to reduce the number of snapshots.
>=20
> I've disabled qgroups for now, we'll see how that goes. These are
> personal desktops, they would have been nice to have, that's all.
> Sadly that means that they probably won't work on any storage setup
> complex enough for them to be really useful, either, yet.
> If btrfs scales so badly with the number of subvolumes that having >20
> at a time should be avoided, doesn't that kill a lot of interesting
> use-cases? My "time machine" desktop setup, certainly, but anything
> with a couple of users or VMs would chew through that 20 pretty
> quickly, even before snapshots. Which leaves the LVM use-case
> (snapshot, backup the snapshot, delete the snapshot).

BTW, that 20 number means 20 snapshots (they all have some shared tree
blocks).

If it's 20 subvolume (no shared tree/data between each), then it counts
as 1.

The main time consuming part is the shared tree/data check, as btrfs
uses indirect way to record them on-disk, forcing us to do complex
walk-back.

Thankfully, we have some plan to improve it.

>=20
>> The slowdown happens in commit transaction, and with commit transactio=
n,
>> a lot of operation is blocked until current transaction is committed.
>>
>> That's why it blocks everything.
>>
>> We had tried our best to reduce the impact, but deletion is still a bi=
g
>> problem, as it can cause tons of extents to change their owner, thus
>> cause the problem.
>=20
> Sure, but why does it *have to* block? Couldn't the intent to delete
> the subvolume be committed, the metadata changes / actual deletion
> happen at leisure?

Unfortunately, not that easy.
We have already delayed a lot of metadata operation, and commit
transaction is the only time we get a consistent metadata view.

That's why it has to happen at that critical section.

> Yes, if qgroups are on, then the qgroup info will
> be behind, but so what?

It's already behind.

> At least I think that lax/lazy qgroups would
> be a nice option to have.

Qgroup is bond to delayed extent tree updates.
While extent tree update is already delayed to transaction commit time,
if it's further delayed, the consistency of the fs will be corrupted.

The plan to solve it is to introduce a global cache for backref walk,
which would not only benefit qgroup, but also send with reflink.

Although there will be some new challenges, we will see if the cache
will be worthy.

Thanks,
Qu

> Also, I still don't get why disabling qgroups, reenabling them and
> doing a full rescan is lightning fast (and non-blocking), while just
> leaving them on results in the observed behaviour.
>=20
> Cheers,
> C.
>=20


--UbfSENNKVBrdxtIsZWW9A9xxBbM9C7sOv--

--oxAMtFTEtNsQ5Tbm9VgsSuGbzhU1dJz2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3bLNoACgkQwj2R86El
/qijcAf/UUbyK+m0poLh52yW2k5XoNMEDySMLTe43tyb+v8hXOEMjT1hWdiYLVm5
dZWZBQXoX/Sum2r0tyQIPhRIqqhMmMdNq5AA+HWFNNk7Gcwee3wrn/Qv/o1mqPVk
piY64ROrUprJGLZyMZGNl2dqTgYivtPWVFW3INBIrsPwJ1jnkvlteFePmINO1UKB
IfT3Qmgyp1gesl1LaIIuq7LfJe6DK5nX3Zk5JsBoRu5aiewVmBL7XuJt9ExC7/5C
JF7VQJpJ3nBUmlPlSodY2XhBQq20uN3euRXbAtFjpmRguj7sPr8LVFr8DJ9fkIBl
nfQAh2ZPzUJ40i22uU+V/bCu5RX5Lw==
=oN0X
-----END PGP SIGNATURE-----

--oxAMtFTEtNsQ5Tbm9VgsSuGbzhU1dJz2f--

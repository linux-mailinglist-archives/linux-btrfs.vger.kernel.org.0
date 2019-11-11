Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1382FF7150
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 11:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKKKDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 05:03:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:38031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKKDz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 05:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573466631;
        bh=KUNSnW0PljXnX7F9+/4Z5AYi3qXn7zP+/TjzLK3jYf0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GAMP1POpgko9V6BFucbQG9fNVwxCy+BtdO/SbYNQmI/BRTm49yPLnUlOFhQaXytYl
         2pq7431SZWqx74NwBhoMSrmoNRmSqSK0pBkGEr6BHJ7lfxfJeVSYKOuUUYAGyVjYd9
         GmhILlWMvsYdIc9l7BUOVtaXLlGjq94cC2NEwpog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1iNG1P2WOv-00XIJ4; Mon, 11
 Nov 2019 11:03:51 +0100
Subject: Re: [PATCH 1/2] btrfs-progs: add comments of block group lookup
 functions
To:     Su Yue <Damenly_Su@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
 <97915605-5df1-ab83-ca98-3133b0648df9@gmx.com>
 <bf2131c4-c780-a66f-8963-452082438375@gmx.com>
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
Message-ID: <9840c8eb-9fc9-972c-8b0a-1907228d7a2c@gmx.com>
Date:   Mon, 11 Nov 2019 18:03:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bf2131c4-c780-a66f-8963-452082438375@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vLoZM3D7xnkMVC9SSY2MDWIM9VRhMiAuI"
X-Provags-ID: V03:K1:pTb4o+cpdqIN3C3EkzCmi7iBmRPg83AXqK1jorhAh2tXTuSyzKt
 l+dJgMAaeYRQmltwetCfuky/ljX8jIEJnLNj4PMHvJrgFPJuQAkWBAD49OMRRKSAXff/EPm
 2CpL3Io97KlGC29YNaSy1DQkcO47pSx8D8+3Waq1KunBNuzLYP+z+YYBDt4R7mzwy4cuJG7
 aAOG1565qSwf+8C8cClCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ukR2YNFbFv0=:d7M5vyqg7caQepoEGkTRAs
 UcX2V9i7V7C95z9Aod+Op3UCeSI2W5D4QepTIFsfLyS4EL8lABHgRbYGnBuE3MC4cTbeZiPfw
 M9cE04r0yPk5V7Qzb5SKBU27FPfMrS31OrWVSy+hsedteke8lsJynIQjsz6hzy61AOPfCGFr2
 h2TTi4LXSmdSkTZI2Ax+Os66+Rhkuyu6NrWjuzeHUo3b+raHVO96gVLgJUc8rLCLscYi594Cd
 WDPyQJLn4c+wIWVyIw7h0M2L79U2ufcSlVusSN/Pzxs07K03vN8f/8zuY7nak3WwzM/CZgCh7
 mN48s37oS4rXypA0rJthuZ8ISb+iE0uMFjk8MF9x+bNhtG76zz0OAumEAfz0Sglg/Ssz7goTY
 QecuZgFykEHgeRnA6ChD/T4fqy4iH8HHB5nMFii7YeZE7VmrTyEJUMwJlFC9U7wYnoPLEKyNj
 Woy023wpWQjBETEu6ZfSb/P91fZkCELHi5axP2MxSaJQZ8y1aIA7MHEOCgBLz8BZtQIdGgdWS
 RF5ENOFwL8mhJkW9/ZC+6sfBQW+R0EYedqCvsGfoEfNfJWM80ySgpxrj5vjJA87Er/ZpJUrna
 pZ9Dlu2jNolLF8NEgXzC11EgdKnQypXrorSzd7Ktm3zuvnMQM6EMojxAxHpTZb0lWGdOhYF8u
 8EO+Ss/o/I6eItudZLPqSQaLr9T5pn4lwamX4MbUUDRKHdCpHy76S+NnSyiV4qqnap2y06GjO
 SWUNKFuSbRU8ofoTDjygsW5fsbG+TmQNp8SMNi5VfMJCFky+ci+HkIYFKt8mo/emVyXukxLBn
 SX2lg6VdT8nucNkngVptGVccqU3sAAVvMX6TDC5LP0pCNbP8Lyh4yrCFJMm+hh4f2G4aWeZV+
 C4CNm2GA3p0Luz8zii4Ib7bGY7gz0tUnGwbtz8ed6bBaffenunJMAh1fnVLcAJFylrKRzI+tk
 c84v8f39fQ1KBqcczrQ7jM55ILAmILA1BVI8lXwjDVJs2Qu5LoN07xQ4kAw7NJFeJpdXUyWoc
 jkYgQVlgRJ0LPon97fUquE2Ex1usvfSqeuFolVSaq8yGegNWVGGwm4EIEwDuxJH09Z52S1ItA
 B+y5pkOhWeu7veFv3KbIyN5bb64AXveXa3OvdZIAT5Vm65OckP1AN3J3yE6kgiZIlqzuI1gSi
 scrn+OI5G/HMLdAhvV1gQBRK1AnTqJ6LH8GMNgQvj/LQ0n1k8JRo0pfmKnEOoN+PtFWtO+reJ
 fnqRJeog7g9R1/XxqcNiZdK44APOCRV3tz+k9hGjWeqCuafy2hRoyjUdxzcU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vLoZM3D7xnkMVC9SSY2MDWIM9VRhMiAuI
Content-Type: multipart/mixed; boundary="JrJDHcSK8ipoaZq32WQIzyEzW6QThSx4V"

--JrJDHcSK8ipoaZq32WQIzyEzW6QThSx4V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/11 =E4=B8=8B=E5=8D=885:49, Su Yue wrote:
>=20
>=20
> On 2019/11/11 5:28 PM, Qu Wenruo wrote:
>>
>>
>> On 2019/11/11 =E4=B8=8B=E5=8D=884:42, damenly.su@gmail.com wrote:
>>> From: Su Yue <Damenly_Su@gmx.com>
>>>
>>> The progs side function btrfs_lookup_first_block_group() calls
>>> find_first_extent_bit() to find block group which contains bytenr
>>> or after the bytenr. This behavior differs from kernel code, so
>>> add the comments.
>>>
>>> Add the coments of btrfs_lookup_block_group() too, this one works
>>> like kernel side.
>>>
>>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>>> ---
>>> =C2=A0 extent-tree.c | 6 ++++++
>>> =C2=A0 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/extent-tree.c b/extent-tree.c
>>> index d67e4098351f..f690ae999f37 100644
>>> --- a/extent-tree.c
>>> +++ b/extent-tree.c
>>> @@ -164,6 +164,9 @@ err:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +/*
>>> + * Return the block group that contains or after bytenr
>>> + */
>>
>> What about "Return the block group thart starts at or after @bytenr" ?=

>>
>=20
> That's what documented in kernel already.
> The thing I try to express is "contains".
> For such a block group marked as B[n, m).
> btrfs_lookup_first_block_group(x) (x > n && x < m). Kernel code will
> return the block group next to B. However, progs side will return the
> block group B.

"Contains" indeed covers your example.
But the "after @bytenr" part looks strange to me.

Did you mean if @bytenr is not covered by any block group, then the next
block group starts after @bytenr is returned?

Then the comment is good.

Thanks,
Qu

>=20
> Thanks.
>> Thanks,
>> Qu
>>
>>> =C2=A0 struct btrfs_block_group_cache *btrfs_lookup_first_block_group=
(struct
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_fs_info *info,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bytenr)
>>> @@ -193,6 +196,9 @@ struct btrfs_block_group_cache
>>> *btrfs_lookup_first_block_group(struct
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return block_group;
>>> =C2=A0 }
>>>
>>> +/*
>>> + * Return the block group that contains the given bytenr
>>> + */
>>> =C2=A0 struct btrfs_block_group_cache *btrfs_lookup_block_group(struc=
t
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_fs_info *info,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bytenr)
>>>
>>


--JrJDHcSK8ipoaZq32WQIzyEzW6QThSx4V--

--vLoZM3D7xnkMVC9SSY2MDWIM9VRhMiAuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3JMgIACgkQwj2R86El
/qg3aAgAqk9UHkwfunt7Aqs1uBJ5zCFEQEasWVyiWwEkvrRduQ0BEPt/mi3BtnBz
ZDJgAfLphhy4IDils6cukWTPrJayDL9o2o1OYGH/IAUapRmPFHXwaxZfJgBWDm5U
W621ykJhq04F9Ip9LSe30ujEnb9cC4/mOkjeiYidpxtN2xbMFYfjcwLdfYPlqXjj
2YRHdGdYen7/3c+6CQpPqdGe3fZ+r4gHbqBPe2OuLxzpTe2fk0AC+zUJZNpaWAH1
RZK3sGDqciiTI7qouFyMflBQdUxmJeNK+WiAAAje4CFyfD25PYiPRsjzlEx/Tv1A
opHlaDrIFktIJpImqQD0mHV+2FzNOg==
=wddw
-----END PGP SIGNATURE-----

--vLoZM3D7xnkMVC9SSY2MDWIM9VRhMiAuI--

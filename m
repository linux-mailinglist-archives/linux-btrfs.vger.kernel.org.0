Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF87212591
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgGBOH3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:07:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:36479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgGBOH2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593698844;
        bh=kRryjb0TxrZYdUL43BijoE1jU1cuWLBAPV6LV9p30YY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=j9NytpzUxMiZd1WplaHwQIwnGFy2uFlupJ05fDN5tXIBeR8GwfseCXl65Nu9sfY+2
         AC3sfmOPXVYymuIUHhWn4KzG+jQbqZB7qBxUDdose3gZ3PhoOgs4xoeSMMywisO1fO
         ybmve4JiG+E2XjY0rKpYszmuSpG9Sjdz6MZaWUFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRQq-1jNBx91PXI-00Tj8I; Thu, 02
 Jul 2020 16:07:24 +0200
Subject: Re: [PATCH 1/3] btrfs: Introduce extent_changeset_revert() for qgroup
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-2-wqu@suse.com>
 <b716bb32-b5e6-54a5-ac42-ca559dfd2d3a@toxicpanda.com>
 <55b63978-fab1-bb2c-bd0a-66fc29af5f26@gmx.com>
 <1f9fe912-72d4-01a5-a5a1-90e87df33037@toxicpanda.com>
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
Message-ID: <5f79d6f7-1e2e-8d44-08c4-0e1d98184b64@gmx.com>
Date:   Thu, 2 Jul 2020 22:07:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1f9fe912-72d4-01a5-a5a1-90e87df33037@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OUONmqsv03DykzKrNcxVPsMBZ5M9MZxR6"
X-Provags-ID: V03:K1:3JWFszr/Pb0+P1yTFjr2Es2FiArCCEWDSQ3k4IKMKwNr61hHdDq
 U6SMgMS0xrS/8ptMOOWR3tsxvvcUMziXRorqcLytxa0hehUVXi2fPX/ATJveKvTYKUBqVe+
 KDNjVBBlMR4TeALNpv7usTssafODoj2L14lJgCzlxP0fEGAhNG60FciHFSiKyrHMbcuFQ3H
 5T6L0G9i0B6eOaXZD4cqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ccal4cL36HQ=:CVzConk8uksdjY5ofLEvHT
 G6tuUIdiViIGdei8rG4wIAj7LGggtqvgJ2uYGrbFzfh8jywvrbiUNZ5btiebvJkcdCVoFL62f
 Q5m4XEEn2MCl80glX36qCQ4pvNcI5jmusrxfmS/wHu5CdT5kKp8pWaqkDHTsbhQ0hCnz2knb0
 Ib/HB4fn1pE4j2AqpQRZRsbS55n/o2NnM1dHvdNav4q2CpoGhtHtcYARy9ti+nTVbCmaq5dAd
 jDpd4shtTLljLhJcyC5fAPIaufOV3JEcDPYmIy+v2snyQbmC67d3XxPwyDq9s3PCII7+t+sJp
 PMA1LqDg2AtqE9uaKtGTd8Sek8eDEHncda2sSxwWbsdvInlLZAN1+QuaCFDxisXAjZhTsUiij
 SnQj2v2M7E5aRpDF0paghbFreWeCfjrvjpvm8aXdyzZ5IFgR8b3gJahsYYyyH/mXJJL8NpQCQ
 YGYtC36Dhp1yuynWegRVvyA6rW27rh1WWyy1P+mc1cF2NGoSpp0B8SAYNGSGSKH3ndxEc9RXM
 wdtgAW42+/VWDFmSy0MhsiaQEFQwO6H9IAN2Y7mJ+AV9tPgMf8P4Xb1qQhVXW4ieipCgwYMl0
 R7PvFhprpLdz5mu/W56rJ3oO1PoX/lklNKOKHibvca9bKN27DixhfLY20aOJaAO5LpuM8ese8
 3Ol968xrzhKkOmli8snZkihgyrzk1TprG0wyZRLTQ+b1plE0wjtvqJzEpHkEQZhDpCD6spmMm
 BlspVOe68fr8T+Vbhh/DeEf9VRjrJV19WKHK88kPmgBnGRJwghltE4XWK1yhSTQXL5T1JA0ie
 5ysb1ZeOqMo/8SGjRpI/yFsMy/t30hR5ekohGE87lSMM4D4fL1tu7Ncn+c2aPuVvv97Lf127i
 3Fw8Q4ewTrQ6b8IR81WxTr/v6MOPvujy//OKCcjDL+XIcIPsk283oXJRYABUYaDkFWZ3gMZca
 mq1sJfxbynh1qEQGF4oYotn56UlZ/VGFbonLeV5I8baN7R5Yx3hgJlH7f7MvNm4DUze706OnE
 oOaN28IUGGssjaG6EAPYmwY/AIYSiVFL+iGjhnzgOXyQR7+DeVzzToujVVyAR3zKVbzdEeBnS
 5Nsv1a7es9xmX1lZdGLFLKCkZqDxwvJOaMsIv+tOjFllNvIIqiCFgv/032mA8MQNY66Brl1T+
 YGWwpEx/cwj5Hy3Ht5kj1S6FHpfsDFcCdBzLAGU8UT/Gtm9x3TUFkT55wqflcRZanMp73Hrdp
 2WpnPKRCQcJdsKFsu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUONmqsv03DykzKrNcxVPsMBZ5M9MZxR6
Content-Type: multipart/mixed; boundary="vKLk0LDEoBWK03dO7IgUowUdiNzUkQmUY"

--vKLk0LDEoBWK03dO7IgUowUdiNzUkQmUY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=889:56, Josef Bacik wrote:
> On 7/2/20 9:50 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/2 =E4=B8=8B=E5=8D=889:40, Josef Bacik wrote:
>>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>>> [PROBLEM]
>>>> Before this patch, when btrfs_qgroup_reserve_data() fails, we free a=
ll
>>>> reserved space of the changeset.
>>>>
>>>> This means the following call is not possible:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_qgroup_reserve_data();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -EDQUOT) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Do something to =
free some qgroup space */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_qgrou=
p_reserve_data();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>>>
>>>> As if the first btrfs_qgroup_reserve_data() fails, it will free all
>>>> reserved qgroup space, so the next btrfs_qgroup_reserve_data() will
>>>> always success, and can go beyond qgroup limit.
>>>>
>>>> [CAUSE]
>>>> This is mostly due to the fact that we don't have a good way to reve=
rt
>>>> changeset modification accurately.
>>>>
>>>> Currently the changeset infrastructure is implemented using ulist,
>>>> which
>>>> can only store two u64 values, used as start and length for each
>>>> changed
>>>> extent range.
>>>>
>>>> So we can't record which changed extent is modified in last
>>>> modification, thus unable to revert to previous status.
>>>>
>>>> [FIX]
>>>> This patch will re-implement using pure rbtree, adding a new member,=

>>>> changed_extent::seq, so we can remove changed extents which is
>>>> modified in previous modification.
>>>>
>>>> This allows us to implement qgroup_revert(), which allow btrfs to
>>>> revert
>>>> its modification to the io_tree.
>>>>
>>>
>>> I'm having a hard time groking what's going on here.=C2=A0 These chan=
gesets
>>> are limited to a [start, end] range correct?
>>
>> Yes, but we may be only responsible for part of the changeset.
>>
>> One example is we want to falloc range [0, 16K)
>> And [0, 4K), [8K, 12K) has already one existing file extent.
>>
>> Then we succeeded in allocating space for [4K, 8K), but failed to
>> allocating space for [8K, 12K).

Sorry, this should be [12K, 16K).

>>
>> In that case, if we just return EDQUOT and clear the range for [4K, 8k=
)
>> and [8K, 12K), everything is completely fine.
>>
>> But if we want to retry, then we should only clear the range for [8K,
>> 12K), but not to clear [4K, 8K).
>>
>> That's what we need for the next patch, just revert what we did in
>> previous set_extent_bit(), but not touching previously set bits.
>>
>=20
> Ok so how do we get to this case then?=C2=A0 The changeset already has =
the
> range we're responsible for correct?
>=C2=A0 Why do we need the sequence
> number?=C2=A0 Like we should have a changeset for [4k, 8k) and one for =
[8k,
> 12k) right?=C2=A0 Or are we handed back the whole thing?=C2=A0 If we fa=
il _just_
> for the [8k, 12k) part, do we know that?=C2=A0 Or do we just know our w=
hole
> [0k, 16k) thing failed, and so we need all this convoluted tracking to
> be able to retry for the range that we fucked up, and this is what you
> are facilitating?=C2=A0 Thanks,

Oh, I got your point.

Right, when the failure happens, the range passed in is not [0, 16K),
but the last failed one.

We can just check the range, free any existing entry in the failure
range, and call it a day...

And I made the case over complicated them.

Thanks for the advice, I'll try to use the existing ulist mechanism to
do the same thing.

Thanks,
Qu
>=20
> Josef


--vKLk0LDEoBWK03dO7IgUowUdiNzUkQmUY--

--OUONmqsv03DykzKrNcxVPsMBZ5M9MZxR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl796hUACgkQwj2R86El
/qihTQf/Rlx+9ML/530ax+KnBabHlEhDwUkf+kwFMTc85PPvPpJpVHmUhuzyWTk3
YSQ0MMTyH0+bh2qqPTkQoU/hQqaY+EJR9L6L8f1OL5t40K7qwPcMBR3zRCUIrI8j
b/tVoePt6usjGE9BlxxBBHDA2V+s901wZEAvh2WGrQy0GCqb12/8ssFbk9H65HvM
eYIumvrl3qXytdIISrEhpYeh2N6L440ZMpiG7wFTWXKWoB1nbvPFDjZUAORenfDj
WRjhKszlMzV6kc3xNs7SAgpfs/Imy98Vgg6jyPU+n9dQo+1nFvg5y7p8qhEa0G+r
q/Zq8pfoBz6+8G9EkNoQsIn/S9zqHA==
=LYZk
-----END PGP SIGNATURE-----

--OUONmqsv03DykzKrNcxVPsMBZ5M9MZxR6--

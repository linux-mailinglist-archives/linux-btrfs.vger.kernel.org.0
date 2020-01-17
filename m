Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68676140176
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 02:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgAQBdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 20:33:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:57113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgAQBdA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 20:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579224774;
        bh=lc9uNPr0P9dcMOPitk8IhcRVpMa3WCVph7A0FWeJi5w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lVX46ZaCBjVfrFdzzPWi8vxnzAkMzLwuif9XoiV3jsJr6qm/zFJyF4Z7w1lQ9ZS0m
         IfHjp4UBehyRCUXxKgxk/29Una9N7E1Q3H/XcIW2uSf/g2lpa53mhxjHGjjgyp0Qvr
         vjr4JkU83aH96W3ezZV5HYkvO8q/TboZQLEfhZoo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9G2-1jOtZj1nra-00oGw9; Fri, 17
 Jan 2020 02:32:54 +0100
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
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
Message-ID: <a8e81e58-8d9d-789c-de33-c213f6a894e6@gmx.com>
Date:   Fri, 17 Jan 2020 09:32:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FHD4lPOR4XcNZVpLgTQROsIRpjnDqy8CT"
X-Provags-ID: V03:K1:U/M5R0x/muNpxPVPilRCK3Y7wmuyNIBMvFLKqHyeuKwUBjAkw65
 m2rBlITvJwcx+GtAL95ptYhb+iRDKpge1RAeSnFjmg9BKUXAYOI2zKYYoJMHwXG8m05WmH6
 /GP8xN/vtGy49WUcalQPR9YSOAPSsMacbV3bey1IhA7VSEOYCn+Mn/l0UH73YFBMO6otI6c
 4k3wOKHpUIHt5Hy7tMuYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgT5Fg5XBEI=:RMv0cNSdcXuRwZqH5SEvYA
 eGPOEahPZuXhvOTlu89CskJIl7RQcInrho1pYloQpzORWuScsGcKgqQq01U15Kb5/gF8Ztn8w
 QVI7k1IeGH0ifQnIKDjeLIrjAokB7zBiu1hpKqmZvro/rPN491k9WJZJA69Xxc2cJ9RMxGZjV
 HjYnIm/QYQl+VzawNgVi1ibnyZy6xY5Z/AY6Vlkn4P0E/wfgBsqZblxFyRDIxNnilEVg4l4s7
 4m7HfIjVn1DlAkhTTsOWwA9tE7SjCu6A5uJ9rcTO79Ty12Ka+5yV4UdwRsFRB96s/IXARmeWC
 P34pWmBdtFicQ9GJ0GW0SJFm7Qxqb4hS6CZt2VBQNQ+l8HJ4a49en5WoHrCfANRVb7ORtjeWd
 TdJzxLvsouPRKyLV2Ap6rvUKulI4i9uvSWBjylw09CGPQ9IIiXp4M31U8h8Hqeoff+q6c/Q5W
 pMl1CAe5gWEhF4aAQIKdGlwGtDkLyPFib63zWF+wMQqHmNHgUm9iZ0sEvhVv03zlRkbGRtw6B
 WQObD7iZu/AfCXkg+HU2DPByRrpB3ZRa8exJWnD4HoXTKaDcy9DtkfmL0RvJMK1tlwW1Jbzgq
 p1oYlRP6zx4UCQYjFp26rcnVRRzOxOR0vVD19BDHhqSMhCdNQUuNbhSvctLoureudMhB1RY3K
 hrwUpSuXPYc68h+lXe7nhw99tJqo4e4mCg2kCODfXDTGqpEPzl2GENWsmY47xBs6aASfweusK
 fcp1qL07grpDgVvg8EbTxm7TGsgHKc192KH9IcI6SFpUFHys8mo6kU1KhX5w/oC7XBPDOA6Ok
 EO9Axsl9Iui0/1vYTz1r+sd6lQCrQ/0XxCS5UEymx3EvJSQoHkT/YiG+2G8NwO4UzEJZ7Vwmh
 MsF7KSB0dwHfu6j17gs+6015Kf/aL0Yy7ntJdMlmnPG4F7wDne0wYVXSumjrAj302fbTHJDts
 uJ10LB9Oox1vOVy0qetbVbhgenYL3eGn2oC45YC6TJdXHRgwPqRRq9MeZ4VQPReNXEQnz0mGu
 x7u7zVEtKhpYhm99dJpsECnM7a7U1ti28QCT6BTfTCxfLLedH72mX82bpRNW15+0sGxZcpCHB
 XFm6gfDqWOevl9lEPmDtuwQ5hMcX/FM1ctJwQmjKbslk9SoR49Au7eIl8Bxb88qZPCgtcagsz
 AjZuf7uyzafSYEHC0q1d2ubt06c4WBl/ZsYJobZbushtFrx0ou6DoPnxpMPn2559mNTSqQ1FM
 X/8X6WXza3CtKY1Uxbjo0RY3SOf+7dbQkHPBp2TOo46zYlyBYJcECZL8j7JM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FHD4lPOR4XcNZVpLgTQROsIRpjnDqy8CT
Content-Type: multipart/mixed; boundary="8IBsot8HoGrdwe1ha2GJ7JprM0zUhU1Us"

--8IBsot8HoGrdwe1ha2GJ7JprM0zUhU1Us
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8A=E5=8D=888:54, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/16 =E4=B8=8B=E5=8D=8810:29, David Sterba wrote:
>> On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> When there are a lot of metadata space reserved, e.g. after balancing=
 a
>>> data block with many extents, vanilla df would report 0 available spa=
ce.
>>>
>>> [CAUSE]
>>> btrfs_statfs() would report 0 available space if its metadata space i=
s
>>> exhausted.
>>> And the calculation is based on currently reserved space vs on-disk
>>> available space, with a small headroom as buffer.
>>> When there is not enough headroom, btrfs_statfs() will report 0
>>> available space.
>>>
>>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>>> reservations if we have pending tickets"), we allow btrfs to over com=
mit
>>> metadata space, as long as we have enough space to allocate new metad=
ata
>>> chunks.
>>>
>>> This makes old calculation unreliable and report false 0 available sp=
ace.
>>>
>>> [FIX]
>>> Don't do such naive check anymore for btrfs_statfs().
>>> Also remove the comment about "0 available space when metadata is
>>> exhausted".
>>
>> This is intentional and was added to prevent a situation where 'df'
>> reports available space but exhausted metadata don't allow to create n=
ew
>> inode.
>=20
> But this behavior itself is not accurate.
>=20
> We have global reservation, which is normally always larger than the
> immediate number 4M.
>=20
> So that check will never really be triggered.
>=20
> Thus invalidating most of your argument.
>=20
> Thanks,
> Qu
>=20
>>
>> If it gets removed you are trading one bug for another. With the chang=
ed
>> logic in the referenced commit, the metadata exhaustion is more likely=

>> but it's also temporary.

Furthermore, the point of the patch is, current check doesn't play well
with metadata over-commit.

If it's before v5.4, I won't touch the check considering it will never
hit anyway.

But now for v5.4, either:
- We over-commit metadata
  Meaning we have unallocated space, nothing to worry

- No more space for over-commit
  But in that case, we still have global rsv to update essential trees.
  Please note that, btrfs should never fall into a status where no files
  can be deleted.

Consider all these, we're no longer able to really hit that case.

So that's why I'm purposing deleting that. I see no reason why that
magic number 4M would still work nowadays.

Thanks,
Qu

>>
>> The overcommit and overestimated reservations make it hard if not
>> impossible to do any accurate calculation in statfs/df. From the
>> usability side, there are 2 options:
>>
>> a) return 0 free, while it's still possible to eg. create files
>> b) return >0 free, but no new file can be created
>>
>> The user report I got was for b) so that's what the guesswork fixes an=
d
>> does a). The idea behind that is that there's really low space, but wi=
th
>> the overreservation caused by balance it's not.
>>
>> I don't see a good way out of that which could be solved inside statfs=
,
>> it only interprets the numbers in the best way under circumstances. We=

>> don't have exact reservation, don't have a delta of the
>> reserved-requested (to check how much the reservation is off).
>>
>=20


--8IBsot8HoGrdwe1ha2GJ7JprM0zUhU1Us--

--FHD4lPOR4XcNZVpLgTQROsIRpjnDqy8CT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hDsEACgkQwj2R86El
/qjfsgf/VxCBtXMm0OMJFimV5wZL60TWunrOaD2hN0qnBPwCkGTjcKvF6V246Qhi
wEuERpcly49N9Pb/eIDpBcjx4OBZaiOuL9WE3qIN0Ngh85ajdVeK+CudKZR7+QYs
f+Oy0e3sG9x1ctxbadKwylzRbRj0Inm/t9TYmH0rYggS2bim8QfS8piDCwbrdHiR
b+R6rxwbDVKCO/JkJBG0UmnrV0HQxEwCcZOBaLNogAVLQRh65xnJsfNULyB7AXWC
yDrFalEsACTCRaQ7DZkmNxy6rjJp7O6xfUV+cXoxiKkXU/wkwP/KKWMvpYNoh198
JubnxpIB3Or+EovVlB7VLqV47H1+Tw==
=j5wS
-----END PGP SIGNATURE-----

--FHD4lPOR4XcNZVpLgTQROsIRpjnDqy8CT--

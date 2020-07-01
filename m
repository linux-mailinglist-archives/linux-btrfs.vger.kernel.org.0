Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32AC2116FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 01:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGAX5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 19:57:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:48617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgGAX5F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 19:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593647821;
        bh=nmm3wMpN1bmTtDpo+sdwxKZQ5YUXKcj8mpEyENvQOkY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iiDTD8MYf3cV5Rt0vBlix9Iqb8c93OriO/MDrUnizezq7fVVXFAGdUzRLkr9Fl9I7
         4zv0EJ+piyjmK3+1E/TuClOPwW9Mm3GETcZKHpTJyfdXoURshruMRNOQ2L6C5fLDH0
         d5w6cE6sc9M161qwHJLF5YYtsrg02cCIvhiCiouU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1jMrFh2Wzt-00U2aA; Thu, 02
 Jul 2020 01:57:01 +0200
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com> <20200616151004.GE27795@twin.jikos.cz>
 <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
 <20200701173928.GF27795@twin.jikos.cz>
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
Message-ID: <0cfc15be-3a4a-c6d2-b294-eeb0a4506df4@gmx.com>
Date:   Thu, 2 Jul 2020 07:56:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701173928.GF27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VBhDUzafzihq8giR3Au0Rb6pTapToHQOK"
X-Provags-ID: V03:K1:TMSqZeKudFIUemlmsjcpcUe+5Dn5UDjGfmKbi78BNvMFkcqyojY
 SHHv6x+MRWNBOCkz3ZwbsEc9SC5Nx//M3ui28A+1KYOv3sR/SQ73KMgwGHpxWTYR42vXslT
 OKFSA7h7sY0V17/WZilK0BSwU3bPpUbbmheU6swweDClI9efid2ZWk99P+5m9WhgSNnJVzW
 p6/HiDyth2uSKf3ZEceWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6FWeXhN+lBI=:ek7QCdgJv2GWZEvMnrbf0F
 hLOuTcIPkP58qAWlF5GW8GCNLN0TyYGlC0lj6Pnjx50tesNODTKxpJG+e+K4IhjvJreoh9lXi
 3vxMw2EC8zmhpW6+CHx1MLR/G2JHzaBHEar/x/h9DR2etze1fk6ietgx/UxzKtgLyJXj7Z9ls
 W8VznuKcngGE1XRsFu7w8aFeyCxsgZXIQt7aoDfQg4ZBzikxRvBIg14qroQzafSz9ib3HXOab
 4r2L0YIDmVUd/8qVusnEq0Q9AUkFZb2NxU2j2u7ARpCkRlr3yVIujzt/uFsKfyNv6ewYsUYXP
 kijrHh2rJl7HHe/uIR5CljNVyvA5F1pYN/I8/I9fN9gnXSUYhGUU9bR5IhYQAuXxcDCpC4yPB
 wrX0YICh1NeWQkDmMy7rVEFPcqxnu/hxKo9kCgKzyq+MGV5yWGQ/KIWyvkVi1DEnjukZD4uWZ
 gsBmM+oDst3n4my5bGDIZx2CCXDFXC45rk7LosAb2/ykvHH5Gqz1as2hjNCJz1o8sq1djHpJy
 TD2xeYp8FFy4R3XBTTW/63E09Hc1W63Nr2eDdpc1YbDI8ZaWZ3nU8spJW+mlXNZHteZ13Ogjo
 3BlM8v7yFX/9SyU/aHkBg0iDHC5THo1YEXy44TxxSdx7tM80ZD0v0b+H37VEWj/lFWv9Syc/N
 E6ozx69NIYYupT/V5V6ioiXJv/L/CJQYzVr6VkUbgy/8n3H3+NdutmLuZ8fQilx44otjFKYGk
 WGorsHb+HgjMga1JqiA6koBDxC3z1e9Tqr/OTEZXfhv/8CGMDFuzl3oK74bLw80i7hMjd/fWS
 gcP46vZqwZ9Dr469oivpUjMXt4nEDRk05696uC+LxigvPa5nUlVlaIhKb+N9uuBCK6nqRJo9D
 sc0lJWQ7wIJTuAm/2P5n/RfEhf6uED03+zwBN4+/kzuHrdNa4j2a9eozmDPNKnJPCTB3zxHOZ
 aY+LraMRVQIol14uhv9Tk1eJJxq/IlXWmTFpWKxlL3Y4SfW/SYUnU1C/0fwsCisQMecCjDUoj
 xzxFUuX/dfWO8BbIExETSm48cmc9IHnD7itsm0ROrYSlqCGilqIfJUez9KspTJTMqW70ug5Uo
 S+uINggZHrM5S+nM1XiJfZtk2nf0jZBF1jzLTHzy6W6+uWuB8fWBToAre/KoIVwWEV+cWbVq0
 /AmSlrIQ8klyPlrVsCkm18U9flJ23oRd4O87Pb4BUO0/cWupAYSyfT/TVPkUggP8j0sNDtYS2
 bXSByjkCWmON2v0HqtuqFN6wN/URnZkEFD50NZA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBhDUzafzihq8giR3Au0Rb6pTapToHQOK
Content-Type: multipart/mixed; boundary="yM6smMqauMWVBRbXArCkPQUG05p7gPoDM"

--yM6smMqauMWVBRbXArCkPQUG05p7gPoDM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8A=E5=8D=881:39, David Sterba wrote:
> On Wed, Jul 01, 2020 at 11:25:27AM +0800, Qu Wenruo wrote:
>>>> +struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_i=
nfo,
>>>> +					 u64 objectid, dev_t anon_dev)
>>>> +{
>>>> +	return __get_fs_root(fs_info, objectid, anon_dev, true);
>>>> +}
>>>
>>> This does not look like a good API, we should keep btrfs_get_fs_root =
and
>>> add the anon_bdev initialization to the callers, there are only a few=
=2E
>>>
>>
>> A few =3D over 25?
>>
>> I have switched to keep btrfs_get_fs_root(), but you won't like the su=
mmary:
>>
>> Old:
>>  fs/btrfs/disk-io.h     |  2 ++
>>  fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
>>  fs/btrfs/transaction.c |  3 ++-
>>  fs/btrfs/transaction.h |  2 ++
>>  5 files changed, 70 insertions(+), 9 deletions(-)
>>
>> New:
>>  fs/btrfs/backref.c     |  4 ++--
>>  fs/btrfs/disk-io.c     | 42 ++++++++++++++++++++++++++++++++++-------=
-
>>  fs/btrfs/disk-io.h     |  3 ++-
>>  fs/btrfs/export.c      |  2 +-
>>  fs/btrfs/file.c        |  2 +-
>>  fs/btrfs/inode.c       |  2 +-
>>  fs/btrfs/ioctl.c       | 31 +++++++++++++++++++++++++------
>>  fs/btrfs/relocation.c  | 11 ++++++-----
>>  fs/btrfs/root-tree.c   |  2 +-
>>  fs/btrfs/scrub.c       |  2 +-
>>  fs/btrfs/send.c        |  4 ++--
>>  fs/btrfs/super.c       |  2 +-
>>  fs/btrfs/transaction.c |  3 ++-
>>  fs/btrfs/transaction.h |  2 ++
>>  fs/btrfs/tree-log.c    |  2 +-
>>  fs/btrfs/uuid-tree.c   |  2 +-
>>  16 files changed, 83 insertions(+), 33 deletions(-)
>>
>> Do we really go that direction?
>=20
> You're right, I don't like the summary and I don't like the code either=
=2E
>=20
> Adding the anon_dev argument to btrfs_get_fs_root is wrong and I have
> never suggested that. What I meant is to put the actual id allocation
> to the callers where the subvolume is created, ie only 2 places.
>=20

You mean to extract btrfs_init_fs_root() out of btrfs_get_fs_root()?

That looks a little risky and I can't find any good solution to make it
more elegant than the current one.

Although I would definitely remove the "__" prefix as we shouldn't add
such prefix anymore.

Thanks,
Qu


--yM6smMqauMWVBRbXArCkPQUG05p7gPoDM--

--VBhDUzafzihq8giR3Au0Rb6pTapToHQOK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79IskACgkQwj2R86El
/qhsEAf/X2KK4wAM2IU9bV4HOLn7fqdHLr58XmIpYHvbFUoRNi3Zd35MHxgv1Id/
tqQzI+N45GbKcL4NSOF9scIwtVPSDoFIDVRIi13z5QnD80vGVauzRxM9/zd3jIwC
lOxDGf9uHAu2bPOLbBElDWWDEk5vDKwrOQINrDq5gbIW+ACGLLzczEAcHnyA8QSw
prY8rBjWSAMHysvALzq+9Tk3umRjn5XG2a8LKslU/plmqoQtMyBc7pi9UhzaSX6j
WdT66q9ugbbk+hbPLFxw0TaWQNWIjaoVGhJMmfFgwJkChD3CRtaPHBqnVYKUD2rV
FgnDkNoOvYzylzuVp+qtlnebdH9tFg==
=kKEB
-----END PGP SIGNATURE-----

--VBhDUzafzihq8giR3Au0Rb6pTapToHQOK--

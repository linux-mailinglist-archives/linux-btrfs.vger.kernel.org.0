Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71F13BE34
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 12:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgAOLLw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 06:11:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:44271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgAOLLv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 06:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579086705;
        bh=dtCP55PQDgPndk7L6Eqz6vRnbpNXzFft0lylMCe+ZFE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YwSZdpkdw/C0jG6yr/k9AivHACitU1YTB4MRuGe1Uuxy9yXX1CQy8XG3WWKk2JdX9
         3gN1+bEIPEBj2SfkVAohrkXRbfxF/SwAEt8kh85lSv3jCO3oXQ0h0V+JGSKKZQ4vsY
         ZfGPZrR8KFusLbMk4FV1fTGj6FvC0jdHO5U2jCPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKDe-1jaZZM1t8O-00yimS; Wed, 15
 Jan 2020 12:11:45 +0100
Subject: Re: [PATCH] btrfs: relocation: Add an introduction for how relocation
 works.
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200115062818.41268-1-wqu@suse.com>
 <CAL3q7H5yLcUsmJVnV4A0UQed+oyQipkQ_cpUPZJLxcXruLcpNw@mail.gmail.com>
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
Message-ID: <9ccd73d5-e130-279e-dc80-76fcc2aa0200@gmx.com>
Date:   Wed, 15 Jan 2020 19:11:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5yLcUsmJVnV4A0UQed+oyQipkQ_cpUPZJLxcXruLcpNw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A6CsbvuEHTb1Odmvs4a6y8HQUjUZrIf9u"
X-Provags-ID: V03:K1:ViGz4j6xntwMk4IFNpU0D0t7yCa92Vqomnr0rlPHkOydHhvNSls
 w/QwO2Om4rr0dUg1yzNlNhskjpYEkIl1gh0DY7M3gN5oaoUj62lrUx5iyRTANneQGCiF7Cx
 K8Qx0+0i4xyEcYJv/1fciuR0YcI4ZTjQVEiVp0ERghH5HvZomi+KHfQdRPFhuscsSQdodZB
 I5g0+Kg1vexVm8vMgHb5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/uoZRAjy5E=:2BcBL4TG3iGZMqmh2x8ge1
 7lA+vt3KyIyU7dPiqv+ZJd7Hubb0/kYEI/t84n23te85ifORYbp8cjsqYuO1JaaLvGCnVQEE8
 cH/55NIbQDRRh2SzFJpD0vDi0Erb2Yn6pCx5b7wzZYxBxKmho1Z9Yx34ugiHzX97HRO5/LUOY
 RwLi9qilJB6N8/vbKZgWH6g15NRcBiobf4P3D83VKoqrGJEPSvLY+5JXDebbEux0H0st5H4K0
 7Z/PGqIEiCSM9R/D/IRBXjS6x40EAO2kA7eJd+PbafeDCOx1C+2mjamFo9tqbcJpcBgNZrc6A
 uqHvPTpVoG6h8WLe1YjBCV1BpzXOK7mqkMvdB08fYxQguEZKtC4iX3T2pvrOTiwb1av9XLHrv
 j8o/a+1U+6ixn5oVjhvhmNmf7kUBBGyTDJhqAq2sobPAS3cKTkGkMH7w3gzR1L/nuf6cIx28j
 vj2x443VyT2I+q2ZwGxYXfzqzvehWhOM4Ja7Xb9VHzEsecwjqHd6hucMc31iBbT70DRyPHE7Z
 M4VBx5ZKGQ5ZuQG0Nbme6oApQ3cudu159b3RLUyh0XhurvMyw+nSrGBffzZD+kRkzHVRvVEbo
 gpLVFx/eizCrwPYpvvUCQLWyic0Pde+3x3SDZMARUjVaHPCzVD90O3+d7BuW1vA29vdTuLB6n
 hrmNTiv2hQRh+D7xeG3pnKHG0CTGWiHk8ZSAe9ySZr94KjK2+5kQmPWLx0mOneUIRX8Il9dYX
 yooTRZz0UkyR99sYhrdZGTlMpxHJVUED5xwJ98Ss6Zcpy2swAOMc9VnrKxRmUW//sj3otobVS
 gdNgB8pD8aYCwKSTmIiO35Ud0+iHtTDuImeZ++rBQlQkDhkv+O6YeG8VKWGUc1DI3SXIsU5Zp
 q9vXwHTC6oClqVNq72nvLuS1KpdjOHB9PPjr68UufdSXHuw6HTabI1+9B5rt2wJpGFVTl40mj
 MvfU7nyLenX6Im+diB2nGJyXkzgieYSIz0nr09vGoM5HOVJG7uHq4Z5TMGus98kn9nHZD8zJW
 HKtQtb+fYpv8bkIHcow/PqiZdgjy3kmzpzRN2XwzORjg0VfS4AyVzHyHQ4K62IFoJsSCBeT+3
 xWUulLk/uW8qOSxSXJy45S6fc8UPutKlKhgrI7leidS6tnJWFbq9mP0VwgT/KLzsmjWoBB55O
 uZsjFbk1Tpn3P0Uho9g7zLGIsdD0cYqU/xtkHawdfI5QBpTXc6+YU6TEXujUl+BpZmC0jIBu0
 1HXWeo/uUurLmFTzjc9F0VncvKulD7jvws7QL14xpuAe2kqb0s4tyDOZNaMg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A6CsbvuEHTb1Odmvs4a6y8HQUjUZrIf9u
Content-Type: multipart/mixed; boundary="eBbOeBbiwWEA0tpqE5MJpBZRM23Pe1a4M"

--eBbOeBbiwWEA0tpqE5MJpBZRM23Pe1a4M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/15 =E4=B8=8B=E5=8D=886:34, Filipe Manana wrote:
> On Wed, Jan 15, 2020 at 6:29 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Relocation is one of the most complex part of btrfs, while it's also t=
he
>> foundation stone for online resizing, profile converting.
>>
>> For such a complex facility, we should at least have some introduction=

>> to it.
>>
>> This patch will add an basic introduction at pretty a high level,
>> explaining:
>> - What relocation does
>> - How relocation is done
>>   Only mentioning how data reloc tree and reloc tree are involved in t=
he
>>   operation.
>>   No details like the backref cache, or the data reloc tree contents.
>> - Which function to refer.
>>
>> More detailed comments will be added for reloc tree creation, data rel=
oc
>> tree creation and backref cache.
>>
>> For now the introduction should save reader some time before digging
>> into the rabbit hole.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/relocation.c | 44 ++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index d897a8e5e430..cd3a15f1716d 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -23,6 +23,50 @@
>>  #include "delalloc-space.h"
>>  #include "block-group.h"
>>
>> +/*
>> + * Introduction for btrfs relocation.
>> + *
>> + * [What does relocation do]
>=20
> For readability, a blank line here would help.
>=20
>> + * The objective of relocation is to relocate all or some extents of =
one block
>> + * group to other block groups.
>=20
> Some? We always relocate all extents of a block group (except if
> errors happen of course).

Error is the exact reason I mention "some".

Thanks,
Qu

>=20
>> + * This is utilized by resize (shrink only), profile converting, or j=
ust
>> + * balance routine to free some block groups.
>> + *
>> + * In short, relocation wants to do:
>> + *             Before          |               After
>> + * ------------------------------------------------------------------=

>> + *  BG A: 10 data extents      | BG A: deleted
>> + *  BG B:  2 data extents      | BG B: 10 data extents (2 old + 8 rel=
ocated)
>> + *  BG C:  1 extents           | BG C:  3 data extents (1 old + 2 rel=
ocated)
>> + *
>> + * [How does relocation work]
>> + * 1.   Mark the target bg RO
>> + *      So that new extents won't be allocated from the target bg.
>> + *
>> + * 2.1  Record each extent in the target bg
>> + *      To build a proper map of extents to be relocated.
>> + *
>> + * 2.2  Build data reloc tree and reloc trees
>> + *      Data reloc tree will contain an inode, recording all newly re=
located
>> + *      data extents.
>> + *      There will be only one data reloc tree for one data block gro=
up.
>> + *
>> + *      Reloc tree will be a special snapshot of its source tree, con=
taining
>> + *      relocated tree blocks.
>> + *      Each tree referring to a tree block in target bg will get its=
 reloc
>> + *      tree built.
>> + *
>> + * 2.3  Swap source tree with its corresponding reloc tree
>> + *      So that each involved tree only refers to new extents after s=
wap.
>> + *
>> + * 3.   Cleanup reloc trees and data reloc tree.
>> + *      As old extents in the target bg is still referred by reloc tr=
ees,
>> + *      we need to clean them up before really freeing the target bg.=

>> + *
>> + * The main complexity is in step 2.2 and 2.3.
>=20
> step -> steps
>=20
> Thanks.
>=20
>> + *
>> + * The core entrance for relocation is relocate_block_group() functio=
n.
>> + */
>>  /*
>>   * backref_node, mapping_node and tree_block start with this
>>   */
>> --
>> 2.24.1
>>
>=20
>=20


--eBbOeBbiwWEA0tpqE5MJpBZRM23Pe1a4M--

--A6CsbvuEHTb1Odmvs4a6y8HQUjUZrIf9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4e820ACgkQwj2R86El
/qhFegf+JXNfFnut/RQOIJwcCpv6hILSRQ9/oJrRE5Tekix4Swz/3fQxBWNIENmq
5cWV/rjX36YyfzEyw2HI3ESEqlWrN3hKC8Q/bQnL4v6QMRmlN6zhJ48OL7SCOTgQ
aH//9p7Cwr/Lpxq2zOQP1L8U/Yrd4RfP8alJV8oXEL0yaCEtgkfAt9M/cu7ZBy5u
HxrtGx5VNDrDUMCU4SK+hmGSzxmKihWiQ7XnDLclZJpQbQfcUjYIJcJgwCZIi30I
NHmlRpSs15GR1yXl2ZgZEcIHg4kPqeeu7OAWSRTsPkqmQ1zYTrEiv1zc/w1dVdtv
oQpYO9Qhya1+cR6xkro9IPx0DtVBNQ==
=l/Ky
-----END PGP SIGNATURE-----

--A6CsbvuEHTb1Odmvs4a6y8HQUjUZrIf9u--

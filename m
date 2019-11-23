Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354FD107BE4
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2019 01:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKWAJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 19:09:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:42585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKWAJf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 19:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574467772;
        bh=mr10MmJFdpZg21BZtAvAzm7xN9kfmi+G50kENJN3T8A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=akzAvrLJjNQw985KbCg6oHx+Y0QN26EkHYXLWOZBHSLAIPEEqFHOmqU3ZzVHrqVx7
         aaENvJc/PpCn/h9+hWHRW9XWLFj6Z0JtQN4V9JD4RbaCLE6kO8QGdgLVAVFmhwtLSh
         yE5M88kSWUdU3c/4uN/RXOmJEw04xvANAgUWoTrQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUUm-1i2UKd1RHw-00pqWr; Sat, 23
 Nov 2019 01:09:31 +0100
Subject: Re: Problems balancing BTRFS
To:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
 <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com>
 <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
 <b1df6eec-4e23-33df-214c-6d49fb5fc085@gmx.com>
 <3f62a074-7712-b72c-fbe1-b63c5ca97271@roosoft.ltd.uk>
 <4edfc730-27c7-4c16-02f8-ccbb58cb5cdb@casa-di-locascio.net>
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
Message-ID: <1582e606-ecd4-a908-c139-05aca4551c2e@gmx.com>
Date:   Sat, 23 Nov 2019 08:09:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4edfc730-27c7-4c16-02f8-ccbb58cb5cdb@casa-di-locascio.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0YaYQL1nLPqn2oX9LjjKW1HdGkZkjWXOL"
X-Provags-ID: V03:K1:+y3gQUzcCeM9fVIU7+pJWzZ9TykcVL4B4e2xc/tsKFkYVB8kGOC
 RnM345AKBcLchl4Cc14QyhHPqKWEaF03gQ5/Zeis09zb0wquO0DxnaMC3FuISgkFysnvZZ2
 EOH/n0/WDgTeU/hYdt4u/EMKJ+O43engO0F2sCHNaJBDGQJGGYxPGletQ69gLkv4O3orHhE
 vrfUHkLGURcK7MhV83HRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/WehmZHRj4=:HkkdoEHAqqEge4EL/0QUO4
 yKGbIUFm+0dMwZ/UoYQar+rFsz+l7JRWkBnimqIlaoo3cy8YK1l5KeGCcWOQjCcorQJW+Oo/C
 iQriEtJC3Wp1E/Z5+2rXmgPVTGL4ATIl9KwN1ZsBnGpC0vza4pNiJ6vJOyix4BJn1It7YIHB1
 vB+g7iPfs0gEJmCkSTRzfLsqA/2Ra4Z6AWAKHUpK/+hDTANcwbbaErXt1L96xz6sg/SAZ9Gy/
 oultcgl3BoxrP2HPL52B1iKGnUR5BuRZGa1w+YxvzJzAUj7DiAWrX+H7H0q+mzcpTmGJ80NHn
 b5aVbICMlxVXzFvye1os4/WJaSuVEXrj8R4MF3ZPy7o5qlMItQr1bNC6tBcaskjL+ohfUD8R2
 M5Dioz2VReXMnUd3W2nEJXVJlRhAgzkbMHyEl4d+CRFhXPMkqp+eUP9JDkd0qi9u4SLqSPhnm
 kYOy349f7J1NMcclIFVsiBm2QwVIYPTtPkg39uevtaHOT0a73bdALccB7BDCfkwlLpZsyMIPv
 DV+BqWBfpbgwqO8qIdIkvD2S2XHz7QDIQN+EW7y16zko8/YO+8mj0hvk/x4GxJm0JrcwctrMh
 vFDL1tg7DdUYrC8v4dJ7f+6J23Vf9MT5l0WnkCbgp/+llVYgHDPxaLogT8XQ/PwAS8KiC6vJI
 lfa/m8yI+MNxiKI/LG4oYIVjPQhkzGUnaWvfzifph6FgpohW5UKv8Thh80Uox/cGzyLTmM4g8
 veU0mQcyhUalzUOxKW+6+DGr6VAucFeBV5b97ZaenUcxdRUwDr7eCSMYfef8cLmrmZ72AU0QU
 WiP3kXzsOnnxxBhhGEOBFkpz84RNZliv/7Lsu5thuMhYg66+i1WwZTx9IKC2ke1NPxVeDFQYD
 v0rc0w7PlLxrGrXEKaf/Zyn2SRMZ+ZgRTaxnostwpkCYfX7Xi7Q0R4Bn3GL2hPBUX/BEyjDVP
 ptadxeue4h6ZMjOb+/31UDBGU2o+d/ybTYa4vrWD8ZJ9ljSrxI5x3weDW00Lgf3Nltapsq1qj
 B2L/hwY/Z7f4cwYrEfJSGdp/dY7s461OBFFjCVPPQkxGdsNsc3kTfo4f95TiqPg7FEYj9Ky4u
 S0cqz/U+PzxaheREbA5yfsejI+hJbko3vYRUFN55NnvBrmxW39FXXF1wATbI5BAILJgVeykQr
 wnv5b1TdIf9LxNcBlJdbehDiK0jxTdPo41kdg2SlRtdqqvU+r8ufGJ2uSWxHOy1j2EVTFaiuX
 5Qvmjitnq6sqAithOaCUbwCj/zKelkzNykAV4hkLWdu0nB2OrgROuv9j6F58=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0YaYQL1nLPqn2oX9LjjKW1HdGkZkjWXOL
Content-Type: multipart/mixed; boundary="dBwGnyQkKteUiTOoI2nDstSis4E79e69x"

--dBwGnyQkKteUiTOoI2nDstSis4E79e69x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/22 =E4=B8=8B=E5=8D=8811:32, devel@roosoft.ltd.uk wrote:
> On 22/11/2019 14:07, devel@roosoft.ltd.uk wrote:
>> On 22/11/2019 13:56, Qu Wenruo wrote:
>>> On 2019/11/22 =E4=B8=8B=E5=8D=889:20, devel@roosoft.ltd.uk wrote:
>>>> On 22/11/2019 13:10, Qu Wenruo wrote:
>>>>> On 2019/11/22 =E4=B8=8B=E5=8D=888:37, devel@roosoft.ltd.uk wrote:
>>>>>> So been discussing this on IRC but looks like more sage advice is =
needed.
>>>>> You're not the only one hitting the bug. (Not sure if that makes yo=
u
>>>>> feel a little better)
>>>>
>>>> Hehe.. well always help to know you are not slowly going crazy by on=
eself.
>>>>
>>>>>> The csum error is from data reloc tree, which is a tree to record =
the
>>>>>> new (relocated) data.
>>>>>> So the good news is, your old data is not corrupted, and since we =
hit
>>>>>> EIO before switching tree blocks, the corrupted data is just delet=
ed.
>>>>>>
>>>>>> And I have also seen the bug just using single device, with DUP me=
ta and
>>>>>> SINGLE data, so I believe there is something wrong with the data r=
eloc tree.
>>>>>> The problem here is, I can't find a way to reproduce it, so it wil=
l take
>>>>>> us a longer time to debug.
>>>>>>
>>>>>>
>>>>>> Despite that, have you seen any other problem? Especially ENOSPC (=
needs
>>>>>> enospc_debug mount option).
>>>>>> The only time I hit it, I was debugging ENOSPC bug of relocation.
>>>>>>
>>>> As far as I can tell the rest of the filesystem works normally. Like=
 I
>>>> show scrubs clean etc.. I have not actively added much new data sinc=
e
>>>> the whole point is to balance the fs so a scrub does not take 18 hou=
rs.
>>> Sorry my point here is, would you like to try balance again with
>>> "enospc_debug" mount option?
>>>
>>> As for balance, we can hit ENOSPC without showing it as long as we ha=
ve
>>> a more serious problem, like the EIO you hit.
>>
>> Oh I see .. Sure I can start the balance again.
>>
>>
>>>> So really I am not sure what to do. It only seems to appear during a=

>>>> balance, which as far as I know is a much needed regular maintenance=

>>>> tool to keep a fs healthy, which is why it is part of the
>>>> btrfsmaintenance tools=20
>>> You don't need to be that nervous just for not being able to balance.=

>>>
>>> Nowadays, balance is no longer that much necessary.
>>> In the old days, balance is the only way to delete empty block groups=
,
>>> but now empty block groups will be removed automatically, so balance =
is
>>> only here to address unbalanced disk usage or convert.
>>>
>>> For your case, although it's not comfortable to have imbalanced disk
>>> usages, but that won't hurt too much.
>>
>> Well going from 1Tb to 6Tb devices means there is a lot of weighting
>> going the wrong way. Initially there was only ~ 200Gb on each of the n=
ew
>> disks and so that was just unacceptable it was getting better until I
>> hit this balance issue. But I am wary of putting too much new data
>> unless it is symptomatic of something else.
>>
>>
>>
>>> So for now, you can just disable balance and call it a day.
>>> As long as you're still writing into that fs, the fs should become mo=
re
>>> and more balanced.
>>>
>>>> Are there some other tests to try and isolate what the problem appea=
rs
>>>> to be?
>>> Forgot to mention, is that always reproducible? And always one the sa=
me
>>> block group?
>>>
>>> Thanks,
>>> Qu
>>
>> So far yes. The balance will always fall at the same ino and offset
>> making it impossible to continue.
>>
>>
>> Let me run it with debug on and get back to you.
>>
>>
>> Thanks.
>>
>>
>>
>>
>=20
>=20
>=20
>=20
> OK so I mounted the fs with enospc_debug
>=20
>=20
>> /dev/sdb on /mnt/media type btrfs
> (rw,relatime,space_cache,enospc_debug,subvolid=3D1001,subvol=3D/media)
>=20
>=20
> Re- ran a balance and it did a little more. but then errored out again.=
=2E
>=20
>=20
> However I don't see any more info in dmesg..

OK, not that ENOSPC bug I'm chasing.

>=20
> [Fri Nov 22 15:13:40 2019] BTRFS info (device sdb): relocating block
> group 8963019112448 flags data|raid5
> [Fri Nov 22 15:14:22 2019] BTRFS info (device sdb): found 61 extents
> [Fri Nov 22 15:14:41 2019] BTRFS info (device sdb): found 61 extents
> [Fri Nov 22 15:14:59 2019] BTRFS info (device sdb): relocating block
> group 8801957838848 flags data|raid5
> [Fri Nov 22 15:15:05 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 305 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 1
> [Fri Nov 22 15:15:05 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 305 off 131764224 csum 0xd009e874 expected csum 0x00000000 mirro=
r 1
> [Fri Nov 22 15:15:05 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 305 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 2
> [Fri Nov 22 15:15:05 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 305 off 131764224 csum 0xd009e874 expected csum 0x00000000 mirro=
r 2
> [Fri Nov 22 15:15:05 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 305 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 1
> [Fri Nov 22 15:15:05 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 305 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 2
> [Fri Nov 22 15:15:13 2019] BTRFS info (device sdb): balance: ended with=

> status: -5
>=20
>=20
> What should I do now to get more information on the issue ?

Not exactly.

But I have an idea to see if it's really a certain block group causing
the problem.

1. Get the block group/chunk list.
   You can go the traditional way, by using "btrfs ins dump-tree" or
   more advanced tool to get block group/chunk list.

   If you go the manual way, it's something like:
   # btrfs ins dump-tree -t chunk <device>
   item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 290455552) itemoff 15785
itemsize 80
                length 1073741824 owner 2 stripe_len 65536 type DATA
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 1 sub_stripes 1
                        stripe 0 devid 1 offset 290455552
                        dev_uuid b929fabe-c291-4fd8-a01e-c67259d202ed


   In above case, 290455552 is the chunk's logical bytenr, and
   1073741824 is the length. Record them all.

2. Use vrange filter.
   Btrfs balance can balance certain block groups only, you can use
   vrange=3D290455552..1364197375 to relocate the block group above.

   So you can try to relocate block groups one by one manually.
   I recommend to relocate block group 8801957838848 first, as it looks
   like to be the offending one.

   If you can manually relocate that block group manually, then it must
   be something wrong with multiple block groups relocation sequence.

Thanks,
Qu
>=20
>=20
> Thank.
>=20
>=20
>=20


--dBwGnyQkKteUiTOoI2nDstSis4E79e69x--

--0YaYQL1nLPqn2oX9LjjKW1HdGkZkjWXOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3YeLcACgkQwj2R86El
/qi5uwgAnOM5QKVwtdr0uGvwZP+O4oqYet2NJ+TFes7a4ZMCFAkTYIqQSLQjqjxD
gYXxrlIwBQCMCST7oUwvss1KQzmwz332ajVm+nMfQJYJSjPpAkChfOFSoktFPc5k
afEtDc+sRQyN7xGuOlToD/GRUo3Ax7DJ2iitNy65npfS8HwUqxRLo+mzv44dwnJ3
GlYWN5yYCDVRPp7fb39V5kN6H0izS1n5tUGzSh+e9SWR8aENO7lUrmLf6Zcey7uR
kSoUO0w7ttaJLqR491KW6Wn+hntRVfhDUh/xiY0+HV+JQJ7jARo+iTXEAo3PEbFX
MI+KadlGY0ddvZaywb7SeCteTjIzEQ==
=3QUD
-----END PGP SIGNATURE-----

--0YaYQL1nLPqn2oX9LjjKW1HdGkZkjWXOL--

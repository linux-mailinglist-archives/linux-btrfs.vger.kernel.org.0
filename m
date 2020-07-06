Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C828D215276
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 08:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGFGPw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 02:15:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:44939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgGFGPv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 02:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594016147;
        bh=EY+k29I7WDDxK51bUUZB8n3pujRqfbYZIIhBssqjDY4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YfjJkbnADTV38nQ91IzpylvXU1eLrPXH6PROSnR+tnhDKTs/TzL0PRJesZihYQGCr
         1//AN7DBmIEIlijMhs7QBp8ctIHS97FZtBet7wB/VFLF9r+XsoV2tPHnYLexL5YkKZ
         mu2L8AJycXqxC1J3l9kMsb4uOl/d+LJ+vPNou2y4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1kLjPY0EsZ-00UdDV; Mon, 06
 Jul 2020 08:15:47 +0200
Subject: Re: Balance + Ctrl-C = forced readonly
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <42c9515d-7913-e768-84b1-d5222a0ca17d@knorrie.org>
 <131421c2-1c2a-4b1b-8885-a8700992a77d@gmx.com>
 <93419615-8f34-efc4-f50e-eac1151f0f37@knorrie.org>
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
Message-ID: <fc428d50-2853-1be7-4764-e643f59faca5@gmx.com>
Date:   Mon, 6 Jul 2020 14:15:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <93419615-8f34-efc4-f50e-eac1151f0f37@knorrie.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3IcGTAjwhd8SxV9hNvtZzJclO88WEgFfl"
X-Provags-ID: V03:K1:2bA0vxVsFtiZNZS1jBav8BkUCK+ONDy4WATZO0cxhneNJLI8ETZ
 2H5KL7zlDaXd3lxqpy+aQBt9y2C/fw7mwgmOYmiWk2LnUxPHSNolKUmFQomWfV4XDiOAnt1
 yNs9XhlN7nYK+ntCxfzi5FBfLVcsMoicnZHsiLys9rSfF4uq9CeXEs7iES3FW2XXC7/AeBn
 HoR+CGpquVIt9wwkEilZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7PzP+F6of3w=:0JuJxwSCt+w5jVTVLpVK6d
 DOKBla8ELsd0pbvC2ojkxk0PUmmDZAJepfuLpmPe8bzIeb+sfJiY/uYVyQIGjPNLJet91m7Qd
 TNFKbOgPahyzv+cwDfgzQUBr2JjkWCP1nlLvavyTwGtV7LjpPcqh0jjciZcBn9hTry0H42X7D
 4VXywjnGUsVKpfCAsV176DvWDWsZmJ3NEPYNAZ+INhvw3Ug5d5+TbpNoNvhQ7tX7S5dYOsd+A
 cFrV8ux0bCMv70HrK4ASgzYyojRAcl/dly7Jrm7YScydmuVLH33BL4fSSpejD9QGjLqcIYc6K
 3DA8wXMf0szNj10Izqmlp0Z3cG5q49IusCEH1T3Oijb2Vcj3M4ZPhbSR4wQ/10mfsbvB9RFUt
 lapHB7rN1TnL9RDowhTy5k/Jea/99fvAc7Q6S95E1QU9R3d8lNqG/lMMNRaXtKA+08OT9K8DV
 zB1OGffFIZrWBA36ZmQJHlUwhuYGsKdNHjeWIzRe/VeN3va+XhqRQ0RAiGLJYENspPpmUfdK5
 qZl4ojuk+N3Xem8uXtAjd/7ivOjx5+V6n4LYPVr1EFh5ZDtQK2s27sG1dnHIZzvt9l1BwU68w
 nEXaHW2a9k2LzUarzkjC08khWu5NAK6oxsqQ977HFSGpy9sUJOXeamVZhACNDZT4EyB+Yb6/x
 PGXB9H7mfGY8dnR1DtEXHU0k2Srx2F88JDNfn67XIn+f8GMiZm1HrVivtt2Ou7v5B6Y3xhj/0
 ochMKR7N6iCLaW8LchX/uG3aJ9LFAkIcGPnUXdkzSNve21YsTf30tNKKX8nRJXIYKyewkSJkx
 u5RzHe5ZfNB06Qbp/DvQMHgrLmOm0ljsU6CnZFtV75/N6xSlBJdykb1eLjwnsF9wYvALxqSFh
 TSNWLpUsRQ4uSkHFebr8eEV/SS4OUV/F+DXRXHNL7A96ZOQNzULngdDL/4eQD0SM9srOE5YnO
 KQCh+99mgTKyjKem+M65bny4XlL8aYZnkeTX+gcCNfLZ8oA/BT+jEMMH558x1nnBspK+RcaMO
 wqT+2uCd0uGNYYyDrkzI5XE6pBAEeRRnRbSnwKFxexIHW/PF2aEGIjlr0SuEyPAzhC69cKZ2/
 G5OuKjKd6JJ6YSUc81x/lLBUaL2NLyJdZcHKuwTLI56mM9FBBOdSutGu/8wnRVflFDY3esvWs
 Vc/9uVD1H2pT9/xAATK/3YUwTgNgLmlI2ytWKxw4P4LzGgT7h6kvmEpTEa6ktH26vfwYUnFBj
 Ut8K63ng80anAf9Nt3w1eVPOpbsvwXd1dax8Lwg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3IcGTAjwhd8SxV9hNvtZzJclO88WEgFfl
Content-Type: multipart/mixed; boundary="wwvtw5TKYkbe1ztAH6GPJUdB4uJq9cay0"

--wwvtw5TKYkbe1ztAH6GPJUdB4uJq9cay0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/5 =E4=B8=8B=E5=8D=8810:53, Hans van Kranenburg wrote:
> On 7/5/20 3:13 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/5 =E4=B8=8B=E5=8D=888:49, Hans van Kranenburg wrote:
>>> Hi,
>>>
>>> This is Linux kernel 5.7.6 (the Debian package, 5.7.6-1).
>>>
>>> So, I wanted to try out this new quicker balance interrupt thing, and=

>>> the result was that I could crash the fs at my very first try using i=
t,
>>> which was simply doing balance, and then pressing Ctrl-C.
>>>
>>> Recipe to reproduce: Start balance, wait a few seconds, then press
>>> Ctrl-C. For me here, ~ 5 out of 10 times, it ends up exploding:
>>>
>>> -# btrfs balance start --full /btrfs/
>>> ^C
>>>
>>> [41190.572977] BTRFS info (device xvdb): balance: start -d -m -s
>>> [41190.573035] BTRFS info (device xvdb): relocating block group
>>> 73001861120 flags metadata
>>> [41205.409600] BTRFS info (device xvdb): found 12236 extents, stage:
>>> move data extents
>>> [41205.509316] BTRFS info (device xvdb): relocating block group
>>> 71928119296 flags data
>>> [41205.695319] BTRFS info (device xvdb): found 3 extents, stage: move=

>>> data extents
>>> [41205.723009] BTRFS info (device xvdb): found 3 extents, stage: upda=
te
>>> data pointers
>>> [41205.750590] BTRFS info (device xvdb): relocating block group
>>> 60922265600 flags metadata
>>> [41208.183424] BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505=
:
>>> errno=3D-4 unknown
>>
>> -4 means -EINTR.
>=20
> From extent-tree.c:
>=20
>   5495         /*
>   5496          * So if we need to stop dropping the snapshot for
> whatever reason we
>   5497          * need to make sure to add it back to the dead root lis=
t
> so that we
>   5498          * keep trying to do the work later.  This also cleans u=
p
> roots if we
>   5499          * don't have it in the radix (like when we recover afte=
r
> a power fail
>   5500          * or unmount) so we don't leak memory.
>   5501          */
>   5502         if (!for_reloc && !root_dropped)
>   5503                 btrfs_add_dead_root(root);
>   5504         if (err && err !=3D -EAGAIN)
>   5505                 btrfs_handle_fs_error(fs_info, err, NULL);
>   5506         return err;
>   5507 }
>=20
>> It means during btrfs balance, signal could interrupt code running in
>> kernel space??!!
>=20
> What a wonderful world.
>=20
> In the cases where the fs does not crash, it displays e.g.:
>=20
> [ 1749.607057] BTRFS info (device xvdb): balance: start -d -m -s
> [ 1749.607154] BTRFS info (device xvdb): relocating block group
> 69780635648 flags data
> [ 1749.732598] BTRFS info (device xvdb): found 3 extents, stage: move
> data extents
> [ 1750.087368] BTRFS info (device xvdb): found 3 extents, stage: update=

> data pointers
> [ 1750.109675] BTRFS info (device xvdb): relocating block group
> 60922265600 flags metadata
> [ 1758.021840] BTRFS info (device xvdb): balance: ended with status: -4=

>=20
> ...and it fairly quickly after pressing Ctrl-C exits 130 because SIGINT=
=2E
> (128+2)

I could get this reproduced now, with more filled fs.

Although I haven't yet reproduced the abort transaction, it should
already be a valid bug.

As at this case, next balance run can cause a kernel warning due to the
reloc tree not yet cleaned up.

This really exposed a new set of problems.

Thanks for the report, now it's time to debug it.

Thanks,
Qu

>=20
> But when it goes wrong, then in between pressing Ctrl-C and the forced
> readonly happening, the balance in kernel continues for some time (this=

> can be even multiple next block groups), until it hits the code path
> seen above (in btrfs_drop_snapshot), and it's *always* at that line.
>=20
> So, it seems that depending on what part of the kernel code is running
> when the signal is sent, it's queued for being processed in that
> (different) part of the running code?
>=20
>> I thought when we fall into the balance ioctl, we're unable to
>> receive/handle signal, as we are in the kernel space, while signal
>> handling are all handled in user space.
>=20
> System calls can be interrupted from user space, e.g. a large read that=

> goes to slow.
>=20
> Previously, ^C on the btrfs balance execution would exit when the
> current block group in progress was ended. So, in that case the signal
> would also be picked up somewhere in the kernel.
>=20
>> Or is there some config or out-of-tree patches make it possible? Is th=
is
>> specific to Debian kernels?
>> At least I tried several times with upstream kernel, unable to reprodu=
ce
>> it yet (maybe my fs is too small?)
>=20
> So, it at least seems to depends on the moment when Ctrl-C is pressed.
>=20
> This is a two-disk fs, where I reflinked a single file many tens of
> thousands of time to generate quite some metadata. You might have to
> need some more data or metadata to have enough change to hit Ctrl-C at
> the right time, but I can only make guesses about that now.
>=20
> -# btrfs fi show /btrfs/
> Label: none  uuid: 4771ea11-6ec6-4c00-a5f5-58acb3233659
> 	Total devices 2 FS bytes used 5.76GiB
> 	devid    1 size 10.00GiB used 3.50GiB path /dev/xvdb
> 	devid    2 size 10.00GiB used 3.53GiB path /dev/xvdc
>=20
> -# btrfs-search-metadata block_groups /btrfs
> block group vaddr 78370570240 length 1073741824 flags DATA used
> 1072177152 used_pct 100
> block group vaddr 79444312064 length 268435456 flags METADATA used
> 219824128 used_pct 82
> block group vaddr 79712747520 length 33554432 flags SYSTEM used 16384
> used_pct 0
> block group vaddr 79746301952 length 1073741824 flags DATA used
> 1071206400 used_pct 100
> block group vaddr 80820043776 length 268435456 flags METADATA used
> 214712320 used_pct 80
> block group vaddr 81088479232 length 1073741824 flags DATA used
> 1073045504 used_pct 100
> block group vaddr 82162221056 length 268435456 flags METADATA used
> 262979584 used_pct 98
> block group vaddr 85920317440 length 1073741824 flags DATA used
> 1069948928 used_pct 100
> block group vaddr 86994059264 length 1073741824 flags DATA used 1597849=
6
> used_pct 1
> block group vaddr 90349502464 length 1073741824 flags DATA used
> 1073246208 used_pct 100
> block group vaddr 91423244288 length 268435456 flags METADATA used
> 109608960 used_pct 41
>=20
>> If it's config related, then we must re-consider a lot of error handli=
ng.
>=20
> I don't know, but I don't think so.
>=20
>>
>> Thanks,
>> Qu
>>> [41208.183450] BTRFS info (device xvdb): forced readonly
>>> [41208.183469] BTRFS info (device xvdb): balance: ended with status: =
-4
>>>
>>> Boom, readonly FS.
>>>
>>> Hans
>>>
>>
>=20
> Hans
>=20


--wwvtw5TKYkbe1ztAH6GPJUdB4uJq9cay0--

--3IcGTAjwhd8SxV9hNvtZzJclO88WEgFfl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8CwY8ACgkQwj2R86El
/qjnVwf/cYFA6wNiGjWvhYsgqLI1WV8xpncAzyL/ZX52C0pPGR6d+QgYkkWbHKK+
PaJSTTmM2DW3FliUuZRY3RkyiJFYLHmZtQSuxKLB1oe72AUJfCTgVR4Ia/gwXzDk
xI8AClbpZcZGHQZ2RZSzzXmVm+7PT3rWz7FkDBhIvH/i3eZJbexc3PEn3YMGGzRW
A5kzUX58U8x8AH/9ZVtonMTNYyq652mfBWft7FNSk2UkrRYe+m5y2sby4ZpxJ4wd
d+bZzSsqU2q7KuJfMbV9ijwyuTHRB6O6G+MkWw37MJFjAC+p2rZEMq2mYVk5b2Iu
n7X88N7yIS8zznxpvTn4NvQuX+Jn1g==
=GNCi
-----END PGP SIGNATURE-----

--3IcGTAjwhd8SxV9hNvtZzJclO88WEgFfl--

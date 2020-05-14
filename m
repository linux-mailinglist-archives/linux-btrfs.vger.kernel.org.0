Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF61D41C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 01:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgENXnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 19:43:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:58341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgENXnM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 19:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589499788;
        bh=kn1zfAIwA1BFcJUQ8wUtkbgCGpfTVV7V1/HQHawIPV4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BMWHxrpgK1vd3OGPx2io7hjf5KiZMYTxtibd5kVdD7XXE67QmnkbBrQJy4XsoCglD
         WOzlkDKX556g0bGhf4qdA1+sc1OeLzb4Y7i7X9C4Zsf/wFvtpjGsFp/KSvhUdN3w0m
         NS9RRQTRlmkTHhs5W/KdOEEh77AO5SLRAqnqiNxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mr9Bk-1imIv70e4U-00oFI4; Fri, 15
 May 2020 01:43:08 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513052452.GY10769@hungrycats.org>
 <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
 <20200513122140.GA10769@hungrycats.org>
 <3b3c805d-7c75-5fe7-1ed8-4a7841b16647@gmx.com>
 <70689a06-dc5f-5102-c0bb-23eadad88383@gmx.com>
 <20200514174409.GC10769@hungrycats.org>
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
Message-ID: <fc456c8b-358d-89d9-77d4-4c8efa5ebf63@gmx.com>
Date:   Fri, 15 May 2020 07:43:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514174409.GC10769@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oHN0VsQJnUfRzEeLpzNJDfaPGTdIc7DH3"
X-Provags-ID: V03:K1:4vcw4XiFC3l0uL2ig7C2Ik/javQwcwkIp4u20zTQhKwRyvqAmiQ
 nXsSW9wNW8AGK6qIjf4uQz6Cg4qiXUf9f5uN8T2j3EIsYAIQzswo7YoFVj62nO367+xh/Xo
 yYxJrzp6Lb9AG6LWTu+NyKNrKSH478/hkaEHjyEuoUbriJyj0BArA9KfEArsJ/LajDeJHvw
 Kxx/l1EUwo2SFFgt9xOqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NkaxPmfATEY=:4lfUgjNUdY+GIe1GCzS0XV
 WR3c5D8cD/vYAiQkvyazZKGbTLwbJrCpKXkVj8+yEGQpYjQuTlZorsavrciMd8uHlTSIGyviv
 VSL5thBRJwYXScE+hZ19XJKnnbEVyjOlOfV1l9kuya2lq/dtmK5st5r8CqNELbmp20mLF+C4V
 W6Q9c/y5fdecDy6siuoLb/NBpgTuG9vqrzEvzEwpcfyrsGgZa8+rcOVasMfcSz7nydGWRNpsn
 8aVHdXUhdlV7Kkd/YVNheFfQHOursLm+g+LMF7ZchfyzV5QLxrvjROy7U+0fGIDvtNdjKelHr
 DLN+T3VOlX9V3rI7eWhF6oS7SycuADG6JhmIktyzqY+StJR1+0txM9VmxA1eklZoyeysc2AW/
 rjHwbDRcjWtbuQ7C5DiE8GyAp+ZMiDUMcHFMmAnSayg2Y9qab1c92Swex8JGnlL1BrVxiCPVD
 Eksh69H5wncBxVhiLeCJHMqeSrnnrRsjpjolyClVMGd65QRkNzmAajQwoEzovIENzHLJOKyGy
 r8wdRgpYBQ8K9CxVX2iePIMofogfDgFRWEFu6u+KMcvbu+doLgi0X3fNVVntHW4UDFx/U+d5O
 usKOricY6iP4xNsPNL3WHQMHsuct24EOm9Sc6mwGB+1kocf+ZNLZtxU4wsyeX/gOPDlax8xte
 BfkzzgPLA3zPemU9QBRVOVy+DnEp6/93M7evGt84gd74U2vt/Tnq2YrEQd/u80y6BQ+iuGVuw
 xAA4w0NKMJDJU5YIDinaArEqhKhzyCifnR31ntrHJLZ13b605Du/CFfANnI/51cUj7y0aKerR
 yakXNsSWlsPsAUQ03BCos3iecbip3auv7Nkb7DszFqPWgOT8hLGmvbx1fFuOOAoUE9uPyQuHV
 A2IzjlEhN8axxqFJ6Xd8HP0+vpRFLVz7Xfr9iICH79sXjSSjgou3WMT2nSmSrwTZg+Gn+Wz7j
 USsaGwQeH74GScevUgVwXVZd5PapvBlq46yfvxisILx5ttHW+RrpJezgleKNs+MsaljprQIk+
 n6maHE+/bl6VGEsxhrvuJjGFQ8H48OYyp67KF7ZK8V0sNtXV00izTB/IaQyp4ZlZ+Mg8GFY2K
 LBYIbWPMy638P3GP8EbcekUwrXXun012ySUsM/XmF/Q6s2mXuV2xIctzDSImT2XvPWnikVTX9
 VjRFpE8pLj21crkVZn5YakgDn9RoCPznhphRe7TkthFGs7YvirFquMLRoJ6brdtaMXNnAaE43
 PxE0wwSHPyWibcgkY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oHN0VsQJnUfRzEeLpzNJDfaPGTdIc7DH3
Content-Type: multipart/mixed; boundary="Tm7EKG9fOyo7vJD2xVFHpE9699YFDASdQ"

--Tm7EKG9fOyo7vJD2xVFHpE9699YFDASdQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/15 =E4=B8=8A=E5=8D=881:44, Zygo Blaxell wrote:
> On Thu, May 14, 2020 at 04:55:18PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/5/14 =E4=B8=8B=E5=8D=884:08, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/5/13 =E4=B8=8B=E5=8D=888:21, Zygo Blaxell wrote:
>>>> On Wed, May 13, 2020 at 07:23:40PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>> [...]
>>>>
>>>> Kernel log:
>>>>
>>>> 	[96199.614869][ T9676] BTRFS info (device dm-0): balance: start -d
>>>> 	[96199.616086][ T9676] BTRFS info (device dm-0): relocating block g=
roup 4396679168000 flags data
>>>> 	[96199.782217][ T9676] BTRFS info (device dm-0): relocating block g=
roup 4395605426176 flags data
>>>> 	[96199.971118][ T9676] BTRFS info (device dm-0): relocating block g=
roup 4394531684352 flags data
>>>> 	[96220.858317][ T9676] BTRFS info (device dm-0): found 13 extents, =
loops 1, stage: move data extents
>>>> 	[...]
>>>> 	[121403.509718][ T9676] BTRFS info (device dm-0): found 13 extents,=
 loops 131823, stage: update data pointers
>>>> 	(qemu) stop
>>>>
>>>> btrfs-image URL:
>>>>
>>>> 	http://www.furryterror.org/~zblaxell/tmp/.fsinqz/image.bin
>>>>
>>> The image shows several very strange result.
>>>
>>> For one, although we're relocating block group 4394531684352, the
>>> previous two block groups doesn't really get relocated.
>>>
>>> There are still extents there, all belongs to data reloc tree.
>>>
>>> Furthermore, the data reloc tree inode 620 should be evicted when
>>> previous block group relocation finishes.
>>>
>>> So I'm considering something went wrong in data reloc tree, would you=

>>> please try the following diff?
>>> (Either on vanilla kernel or with my previous useless patch)
>>
>> Oh, my previous testing patch is doing wrong inode put for data reloc
>> tree, thus it's possible to lead to such situation.
>>
>> Thankfully the v2 for upstream gets the problem fixed.
>>
>> Thus it goes back to the original stage, still no faster way to
>> reproduce the problem...
>=20
> Can we attack the problem by logging kernel activity?  Like can we
> log whenever we add or remove items from the data reloc tree, or
> why we don't?

Sure, the only and tiny problem is the amount of logs we're adding.

I have no problem to add such debugging, either using plain pr_info() or
trace events.
Although I prefer plain pr_info().

>=20
> I can get a filesystem with a single data block group and a single
> (visible) extent that loops, and somehow it's so easy to do that that I=
'm
> having problems making filesystems _not_ do it.  What can we do with th=
at?

Even without my data reloc tree patch?

>=20
> What am I (and everyone else with this problem) doing that you are not?=


I just can't reproduce the bug, that's the biggest problem.

> Usually that difference is "I'm running bees" but we're running out of
> bugs related to LOGICAL_INO and the dedupe ioctl, and I think other peo=
ple
> are reporting the problem without running bees.  I'm also running balan=
ce
> cancels, which seem to increase the repro rate (though they might just
> be increasing the number of balances tested per day, and there could be=

> just a fixed percentage of balances that loop).

I tend to not to add cancel into the case, as it may add more complexity
and may be a different problem.

>=20
> I will see if I can build a standalone kvm image that generates balance=

> loops on blank disks.  If I'm successful, you can download it and then
> run all the experiments you want.

That's great.
Looking forward that.

Thanks,
Qu
>=20
> I also want to see if reverting the extended reloc tree lifespan patch
> (d2311e698578 "btrfs: relocation: Delay reloc tree deletion after
> merge_reloc_roots") stops the looping on misc-next.  I found that
> reverting that patch stops the balance looping on 5.1.21 in an earlier
> experiment.  Maybe there are two bugs here, and we've already fixed one=
,
> but the symptom won't go away because some second bug has appeared.
>=20
>=20
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Qu
>>>
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index 9afc1a6928cf..ef9e18bab6f6 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -3498,6 +3498,7 @@ struct inode *create_reloc_inode(struct
>>> btrfs_fs_info *fs_info,
>>>         BTRFS_I(inode)->index_cnt =3D group->start;
>>>
>>>         err =3D btrfs_orphan_add(trans, BTRFS_I(inode));
>>> +       WARN_ON(atomic_read(inode->i_count) !=3D 1);
>>>  out:
>>>         btrfs_put_root(root);
>>>         btrfs_end_transaction(trans);
>>> @@ -3681,6 +3682,7 @@ int btrfs_relocate_block_group(struct
>>> btrfs_fs_info *fs_info, u64 group_start)
>>>  out:
>>>         if (err && rw)
>>>                 btrfs_dec_block_group_ro(rc->block_group);
>>> +       WARN_ON(atomic_read(inode->i_count) !=3D 1);
>>>         iput(rc->data_inode);
>>>         btrfs_put_block_group(rc->block_group);
>>>         free_reloc_control(rc);
>>>
>>
>=20
>=20
>=20


--Tm7EKG9fOyo7vJD2xVFHpE9699YFDASdQ--

--oHN0VsQJnUfRzEeLpzNJDfaPGTdIc7DH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6914gACgkQwj2R86El
/qhhTgf/Ti5YufAEAugiEl28E4zlhFloFt3FNNLUDVQYeS+JgO4+JdhXUOANhfEO
4njzvDi6l2ePQVJxgK+7Hqn2/UeRJoggt7zR6rSnyjtcEfBH9EZZySCoi1brnxdu
xYIYrGGWAGT3Yr5T8PfrXX+a5C3UV27d+utGzDn5eC9aBvVwrSGM8UGqBOzMU+yU
922buODl09bD9I0jTgKD0l9tffbX/XG8N2hdykPGxjZDZrZT9tn6PEgpy4m/1Dww
+WeKIQ3vSMFaDmEvUkM8NOJf+oKTy3djHgC7W/YVIXSlPxiXYWRDJZf2nVpzB51l
YeIKFxiDnP3KlszCKV08rNh/T7/FHw==
=yKf3
-----END PGP SIGNATURE-----

--oHN0VsQJnUfRzEeLpzNJDfaPGTdIc7DH3--

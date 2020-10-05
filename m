Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9F283290
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJEIv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 04:51:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:55133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgJEIv1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 04:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601887882;
        bh=C0gaEFIdEGvvWZakGEOWhThF4gDgm2p6HSdvenJ3DZ4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BF8EPUxi9G9tsg1LWhRpTFQVDjcJ+cQnMkoU8d/b7V/4XgjTwNo5F/jyHYZlo6BS3
         acoOxObbw9N+amxuBXkwMmUAebKtOL9p1leLdnFVJp+NjQlUzpWTGLb2p/D1RaUH/I
         5L8V+IyDSI8vbYs1nmo5+f5JKsINNUSBbUFPrJzw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ob6-1kU6yC0bI6-015mkT; Mon, 05
 Oct 2020 10:51:22 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
 <CA++hEgwsLH=9-PCpkR4X2MEqSwwK6ZMhpb+YEB=ze-kOJ8cwaQ@mail.gmail.com>
 <CA++hEgzbFsf6LgPb+XJbf-kkEYEy0cYAbaF=+m3pbEdSd+f62g@mail.gmail.com>
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
Message-ID: <c2c0f8e7-b3ff-9e88-9d98-3b903c241644@gmx.com>
Date:   Mon, 5 Oct 2020 16:51:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgzbFsf6LgPb+XJbf-kkEYEy0cYAbaF=+m3pbEdSd+f62g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2MNf8cKJA6vgNDm9m3Cb5BJ488n5GSUx3"
X-Provags-ID: V03:K1:9FFbj5CSGolwm87aNJo7kjUzfceeNcCfSeYYgcjt3N+s20IK3/v
 i2xQtsl0WyU8ghFOcElvCS+qboaf1NAkO/P8vpZsaEuSvO7jXtZnbMMQp2Q1rsrv5vLgUiZ
 31fO/rl0hQvAGNbw2DlTsIon0DBLeJGimTgn7Id5gidscdi8OtuSnS44NGaIPwobezZ3DVv
 Sh1X7qlaqlsEviX4Ng/kA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:evL04EURLPU=:OKxo48/ODZCHyVcnhfieUt
 nU1d1QdGOoaP3fUGkA/dJp39qF8ZBZ2DWJ5ORkRS7X1JTUpgj8ouAvfMo2EWmkA3W0TEDW70A
 ejFnSPzQ/5teKCIKIt60CrdBht+ys5rUOdkgwFKD3iFfGh4cdwZFXh7TkBWxGIYmNU6Doed1A
 YoSwZ2GKS4b7WS4FZv+oWpzg11HTOPZclvHLXbXQdRHi0FWiLAvg3HIpkzKiWrHo/E7lHCDqE
 CEbLpABgcUYtFb/hnCixZKnLrFADBgfaJnn3HQzIDN/aiUzuG2qbSm2rQrr9LRR/EJWWDB4aR
 0ZRwnaoyZr0OffcKNFA5rb9oqE35BKx9VaG4WGe3CoZTkEG8yZy6khRBAB2NJP9qal4eU6m6n
 U0S+wJEHqJl3jhjIdNRIy7ukweLA8sd5TUKwZbox2+YC4oykBBAB9c8wiBEx7xJ6NvNMMb6ar
 IpYp6qBN72ZJZAS37ySvOFJYGX74GU1iv4b6EETQwA3DzaGzbmSJE8Veugu7TLdJU5OoIanLm
 PeHb0gCmZxUe9lsnhjLEFcv5xzDjHfduTq58SOzpZ/NkTyS99sEsXp1okWiapx9OFyjH4n93t
 88cVicGikTfwqV998Ff1W8GbSet+hRr5hDxeTKt3hzwPCmgoSR1/Blau8U6qA269UdiExwMI9
 cmoYKofbyehdqOOVbL6Xp/4/ku18/Om88zKbRGj9nxemXP3sDmMU/3AL8WltT3Noxc4sejHtL
 PufsUFU76G/nk9xvIADuuq9WnivZ1FLbYGJD77zNptzoGbHODQQLuXxDGFQDL5oYDQueN9g+D
 bGCItjSFGYU5GSU5lKivFFsJDn4iLN8itKu+Dg/1oQcp97zEsY1LlbXj2Wnyeycz9glsU3610
 WE95NoGS9lkzCoXbEtyVsATfaQ8GEhDYvNzSjQxegMUUSEmSB1dF6l6mEvztXrEZYB23f23+j
 2ysdhk8BTvU1ZtpmT694jXjzNRFV51lpPefnD/YF8MvpNcK8Sdy7gp+GAJU0g89E0owGO4Kw5
 T0ubHBLrb7wTzzwnuBFezopGROxOFns6uKauSevifAFteibVga0tapg9SmNdPLlD2APYTfoRJ
 EUtdNlBuUR18MMdS7UcCtXW5Eil5UVdDfQbOMvO2woDdl0XkwFjgWwZ3jnIkXG37SqTthFTd0
 a7VnOM12/9DUOmQsVjLgm/0s04oaGvTw2imJA12kitqMm7xh/TapbAqlbp3G9C1uUz2IAlJcZ
 jLLnw7+9JYoC6BcfU1ICyBTW3xMcX/0ZHjZcDww==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MNf8cKJA6vgNDm9m3Cb5BJ488n5GSUx3
Content-Type: multipart/mixed; boundary="1TcPW26Nwtnnzk1mfNpsSQzS1BAQ2vQv0"

--1TcPW26Nwtnnzk1mfNpsSQzS1BAQ2vQv0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=883:58, Eric Levy wrote:
> Well, I see the complaint about limited disk space. I suppose it is a
> surprise to me that disk usage causes this problem, because the mount
> was fully functional under kernel versions 5.3.x.
>=20
> Is the best solution simply to free disk space? If so, then the act
> would have to fall in the time window during which the mount retains
> RW state.
>=20
>=20
> [277402.736070] usb 2-1: new SuperSpeed Gen 1 USB device number 34
> using xhci_hcd
> [277402.756644] usb 2-1: New USB device found, idVendor=3D152d,
> idProduct=3D0583, bcdDevice=3D 2.08
> [277402.756648] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [277402.756650] usb 2-1: Product: USB to PCIE Bridge
> [277402.756652] usb 2-1: Manufacturer: JMicron
> [277402.756653] usb 2-1: SerialNumber: 0123456789ABCDEF
> [277402.761143] scsi host1: uas
> [277402.761780] scsi 1:0:0:0: Direct-Access     JMicron  Generic
>    0208 PQ: 0 ANSI: 6
> [277402.762495] sd 1:0:0:0: Attached scsi generic sg0 type 0
> [277404.731514] sd 1:0:0:0: [sda] 1000215216 512-byte logical blocks:
> (512 GB/477 GiB)
> [277404.731517] sd 1:0:0:0: [sda] 4096-byte physical blocks
> [277404.731635] sd 1:0:0:0: [sda] Write Protect is off
> [277404.731637] sd 1:0:0:0: [sda] Mode Sense: 5f 00 00 08
> [277404.731877] sd 1:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [277404.732086] sd 1:0:0:0: [sda] Optimal transfer size 33553920 bytes
> not a multiple of physical block size (4096 bytes)
> [277405.557376]  sda: sda1 sda2 sda3 sda4 sda5
> [277405.559054] sd 1:0:0:0: [sda] Attached SCSI disk
> [277410.526995] BTRFS info (device sda5): disk space caching is enabled=

> [277410.526999] BTRFS info (device sda5): has skinny extents
> [277410.877674] BTRFS info (device sda5): enabling ssd optimizations
> [277431.217341] BTRFS info (device sda5): checking UUID tree
> [277435.854502] BTRFS info (device sda5): balance: resume
> -mconvert=3Ddup,soft -sconvert=3Ddup,soft
> [277435.854776] BTRFS info (device sda5): relocating block group
> 518463160320 flags metadata
> [277506.944843] BTRFS info (device sda5): relocating block group
> 483205840896 flags metadata
> [277597.158985] BTRFS: error (device sda5) in
> btrfs_drop_snapshot:5428: errno=3D-28 No space left

Oh, that's a completely different bug.

Somehow btrfs exhausted the metadata space.

Normally caused by unbalanced data/metadata usage and multi-device.
(Currently, RAID1/RAID0/RAID10/RAID5/RAID6 can all over-estimate the
available space, and cause ENOSPC to happen in critical context, where
we can only abort transaction to avoid further corruption)

Currently I guess you need to don't do any balance, but try to remove as
many unused files as possible, until you have enough unallocated space
for metadata.

To check your unalloated space, you can use btrfs fi usage:

You need enough "Device unallocated" for your profile. (1MiB is not
usable, as that is reserved space for superblock)

E.g. if you're using RAID1, you need *2* devices with enough unallocated
space.

Normally this is pretty hard by just deleting enough files/snapshots to
free a full data block.
But if you did it, then you can try balance data space to free more
space and get out of the ENOSPC spiral.

I really need to push the fix harder before it affects more people.

Thanks,
Qu

> [277597.158988] BTRFS info (device sda5): forced readonly
> [277597.159022] BTRFS info (device sda5): 2 enospc errors during balanc=
e
> [277597.159022] BTRFS info (device sda5): balance: ended with status: -=
30
> [277607.030026] BTRFS info (device sda5): delayed_refs has NO entry
>=20
> On Sun, Oct 4, 2020 at 11:35 PM Eric Levy <ericlevy@gmail.com> wrote:
>>
>>> There is an off-tree branch to do the repair:
>>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>
>> Ok. I was able to build and run. Part of the earlier confusion was
>> from reading the documentation in the wrong branch of the repository.
>>
>> I ran the repair, and now the check passes in both the stock and
>> forked version of the utility.
>>
>> However, the file system is still behaving badly. It reverts to RO
>> mode after several minutes of use.
>>
>> Even a scrub operation fails ('aborted" result was not from a manual
>> intervention).
>>
>> $ btrfs check /dev/sda5
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda5
>> UUID: 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups
>> Rescan hasn't been initialized, a difference in qgroup accounting is e=
xpected
>> Qgroup are marked as inconsistent.
>> found 399944884224 bytes used, no error found
>> total csum bytes: 349626220
>> total tree bytes: 6007685120
>> total fs tree bytes: 4510924800
>> total extent tree bytes: 881704960
>> btree space waste bytes: 1148459015
>> file data blocks allocated: 570546290688
>>  referenced 530623602688
>>
>> $ sudo btrfs scrub start -B /mnt/custom
>> ERROR: scrubbing /mnt/custom failed for device id 1: ret=3D-1, errno=3D=
5
>> (Input/output error)
>> scrub canceled for 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
>> Scrub started:    Sun Oct  4 23:25:22 2020
>> Status:           aborted
>> Duration:         0:01:41
>> Total to scrub:   378.04GiB
>> Rate:             0.00B/s
>> Error summary:    no errors found


--1TcPW26Nwtnnzk1mfNpsSQzS1BAQ2vQv0--

--2MNf8cKJA6vgNDm9m3Cb5BJ488n5GSUx3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl963ocACgkQwj2R86El
/qjs4Af6A4BkE/Irfy3cvjHuiloW60oqV+ZHKU6UtWR8RryUyN+2gamSJvZ0YuUt
G48jLcVS0I5QBXoJ8RHxPhnYbUYTSczEjpnYyOzSUmCZk8v5lUK2kX+8Fhch6MJG
M9CRANGPhi0UOl+FfUgYFWXWnomW86+fB610t8vJlmi8b8xnmqtuopppQHo/p3GJ
DRapnInER8/KVWdOb/WmKoVvpQV0t1Bn+icXyd6tLvXFqH8EsMlhzUpuojKT7RSD
NVnVTFQIE4ybCbmiaeRcSN6QyNl1FcN1bAUCwbM90cZXLsI6ai1jyH91eEr4R0NN
Rz4gsOY0wJvvG7OLWoYP2CHBKVuIHg==
=hKdd
-----END PGP SIGNATURE-----

--2MNf8cKJA6vgNDm9m3Cb5BJ488n5GSUx3--

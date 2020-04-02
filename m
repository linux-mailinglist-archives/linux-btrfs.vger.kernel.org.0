Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FF019C151
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 14:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgDBMnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 08:43:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:34685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbgDBMnY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 08:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585831395;
        bh=O3LMW3QOiolDgo5BttFj2+x3eeK668ire7eBysvVG+k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DRKRXVrR8MM3DqBSDNo/uUG5IuEigFYALtH17rZcDjtwePmIF18owKpFu/zyMOTZ/
         pyxjmJ7osPV2jAIS0ksh9CfCDodiCt+sOeB0S5eeJWxFxYMhLdnm+OFRnC78/dcX3e
         3PDIam08zTSPKhdLwuqkLdM+EqFnG4vcR6+o3i5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1jCved2moT-012FTA; Thu, 02
 Apr 2020 14:43:15 +0200
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
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
Message-ID: <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com>
Date:   Thu, 2 Apr 2020 20:43:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="spvlnRcapkRJHrn7sp24Uo5WdzpMgLvmm"
X-Provags-ID: V03:K1:3Acfxh8J9lZkx76rkFlvSL/ZVPw0kA/UsuFyEuVgVLM7RLvLWE2
 1IZ3mZvZZnh+0nWvOQVcf5YfCAQhEHmhs6+/KOch5eVsJkjmYpShD5NieinYVGxOJOwik8J
 csuHPMgHLabvEkc21QysAATaoTQOJfGOsQp4w/AxY00xeAEJ8pFdbbQc7LSyrYE3OxJLv8t
 iCOyjlHpszP+PyqwDlzJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5AOsqLTrZTw=:jdl9l4efszZj0m8t991MSX
 tMSklR9fDqfYoz2W9H6dXM3Vcj4FasQ93/dsERnpHq5LCEbMNJ1kNpoXtkeIo5lpoBmXn+4w+
 881ZQ3nqhwP92M9eCoWp2bmdE/GjJSbeS68BshuxZFDisZ4aU7iX+ay8LhK8QyoT6H+QEVGlm
 1wxb8mc01ZTAD5X3gA+xonNzZm8p3qZocUNMVVs85JfGZy8jmvLeDOMty1Kl/b+FPIHZbZEFe
 WnNnZHOWeploMQXMpa0HrZ2ZqNOMR216jTjcYOFQ980DB3zCfdJN+QvKDXNZoYTx9mHPnYQSn
 BjXMJ1eZiPo5zcj1ZBVW+SbZSOlaPm8cCh6bmHC2ggL49pVodcLt9+OnsmPlaTUe9+DLyMhHh
 +t7m7Ftl3IuwTz3YfmYA8yk7ctvG0kkCP18aACJDWohOK7JIRboI4hg2lHYKbkWPEGPYT1Ged
 Y+rZuV0XSyNNWX5BdLhhgHwBKW1AepQAFn3GP/Rh2oq/dnewU1RhPC8lfwePaVhPWT8GL9KkE
 kMysoYU6uGzeuoRhO7AgM13PAuBVkCJ8Kb4VvDUxZSmCG2lQG09W1dZd/T4SrcEZum15W7xuZ
 T8bh4jaM0MSf9C4OZFcCtYPvVzzIZRXCTJHz4T2umtXzhWyi8zt7D+PeQbkJ0mmwCIKNR5EBj
 RGRxD/TdLtaCDpzZOVkFtJENoz1fqbDlOpMFJh9q9vkffqtkHAwOPCZXGi9FtuNPqvt4ch/MR
 /YyV075nFiyGqL0CZLLPXv50Tuk4byQC6MKJN+QSNwu1OmajHrHFPkjdGmpODIwYWr6P27eI2
 I4P32wVk1bm9f4KW3R7ynn1WrEJLodeBtV2OLLy8vkHYNS3LUIsuHc/BE5fNb6qxXyC6LYw0L
 sz0g1/ypRfDTmv6GnGfR2qvrd4c5HpGG8PyFK9GAtgXUok4jWkiBuufN4SexrEaAmZoLMYddz
 XzrNaDxGbhmi4lGjirReJXE4FlQyDUOkmbW0bQ8G4M12h/d9aLJh9HIzetI7EQQQCuqJ1SDzf
 96fsFER/nAarJ2wFQRtEIMVw1vdcnBAUJXrWhtwZYrIAHONW5MXbQ8Wqi0agagW83dLHICe4f
 tGoB2hpAzs7kLg2v+CPFdjzdRfzCUcShdBjpnLNhgeywXWcRdkDBaCrIJV9lhqu1CcVqOIUpA
 1s0gBQe733FqSWQFm8kCB6+wPm8mmPHLQx5GcWtneLF9luR7WJ8AL3PEToPAgO3h+iGOmyWq3
 L+VIfIaj/Pqd+hENT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--spvlnRcapkRJHrn7sp24Uo5WdzpMgLvmm
Content-Type: multipart/mixed; boundary="BDMpNTCjt2xawyWt4XOIGmALSDWyObtXV"

--BDMpNTCjt2xawyWt4XOIGmALSDWyObtXV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/2 =E4=B8=8B=E5=8D=888:33, Filipe Manana wrote:
> On Thu, Apr 2, 2020 at 12:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/4/2 =E4=B8=8B=E5=8D=887:08, Filipe Manana wrote:
>>> Hi,
>>>
>>> Recently I was looking at why the test case btrfs/125 from fstests of=
ten fails.
>>> Typically when it fails we have something like the following in dmesg=
/syslog:
>>>
>>>  (...)
>>>  BTRFS error (device sdc): space cache generation (7) does not match =
inode (9)
>>>  BTRFS warning (device sdc): failed to load free space cache for bloc=
k
>>> group 38797312, rebuilding it now
>>>  BTRFS info (device sdc): balance: start -d -m -s
>>>  BTRFS info (device sdc): relocating block group 754581504 flags data=
|raid5
>>>  BTRFS error (device sdc): bad tree block start, want 39059456 have 0=

>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39059456
>>> (dev /dev/sde sector 18688)
>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39063552
>>> (dev /dev/sde sector 18696)
>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39067648
>>> (dev /dev/sde sector 18704)
>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39071744
>>> (dev /dev/sde sector 18712)
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376256
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380352
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445888
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384448
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388544
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392640
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396736
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400832
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404928
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409024
>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>  BTRFS info (device sdc): read error corrected: ino 257 off 1380352
>>> (dev /dev/sde sector 718728)
>>>  BTRFS info (device sdc): read error corrected: ino 257 off 1376256
>>> (dev /dev/sde sector 718720)
>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0=

>>>  BTRFS info (device sdc): balance: ended with status: -5
>>>  (...)
>>>
>>> So I finally looked into it to figure out why that happens.
>>>
>>> Consider the following scenario and steps that explain how we end up
>>> with a metadata extent
>>> permanently corrupt and unrecoverable (when it shouldn't be possible)=
=2E
>>>
>>> * We have a RAID5 filesystem consisting of three devices, with device=

>>> IDs of 1, 2 and 3;
>>>
>>> * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
>>>
>>> * We have a single metadata block group that starts at logical offset=

>>> 38797312 and has a
>>>   length of 715784192 bytes.
>>>
>>> The following steps lead to a permanent corruption of a metadata exte=
nt:
>>>
>>> 1) We make device 3 unavailable and mount the filesystem in degraded
>>> mode, so only
>>>    devices 1 and 2 are online;
>>>
>>> 2) We allocate a new extent buffer with logical address of 39043072, =
this falls
>>>    within the full stripe that starts at logical address 38928384, wh=
ich is
>>>    composed of 3 stripes, each with a size of 64Kb:
>>>
>>>    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
>>> stripe 3, offset 39059456 ]
>>>    (the offsets are logical addresses)
>>>
>>>    stripe 1 is in device 2
>>>    stripe 2 is in device 3
>>>    stripe 3 is in device 1  (this is the parity stripe)
>>>
>>>    Our extent buffer 39043072 falls into stripe 2, starting at page
>>> with index 12
>>>    of that stripe and ending at page with index 15;
>>>
>>> 3) When writing the new extent buffer at address 39043072 we obviousl=
y
>>> don't write
>>>    the second stripe since device 3 is missing and we are in degraded=

>>> mode. We write
>>>    only the stripes for devices 1 and 2, which are enough to recover
>>> stripe 2 content
>>>    when it's needed to read it (by XORing stripes 1 and 3, we produce=

>>> the correct
>>>    content of stripe 2);
>>>
>>> 4) We unmount the filesystem;
>>>
>>> 5) We make device 3 available and then mount the filesystem in
>>> non-degraded mode;
>>>
>>> 6) Due to some write operation (such as relocation like btrfs/125
>>> does), we allocate
>>>    a new extent buffer at logical address 38993920. This belongs to
>>> the same full
>>>    stripe as the extent buffer we allocated before in degraded mode (=
39043072),
>>>    and it's mapped to stripe 2 of that full stripe as well,
>>> corresponding to page
>>>    indexes from 0 to 3 of that stripe;
>>>
>>> 7) When we do the actual write of this stripe, because it's a partial=

>>> stripe write
>>>    (we aren't writing to all the pages of all the stripes of the full=

>>> stripe), we
>>>    need to read the remaining pages of stripe 2 (page indexes from 4 =
to 15) and
>>>    all the pages of stripe 1 from disk in order to compute the conten=
t for the
>>>    parity stripe. So we submit bios to read those pages from the corr=
esponding
>>>    devices (we do this at raid56.c:raid56_rmw_stripe()). The problem =
is that we
>>>    assume whatever we read from the devices is valid - in this case w=
hat we read
>>>    from device 3, to which stripe 2 is mapped, is invalid since in th=
e degraded
>>>    mount we haven't written extent buffer 39043072 to it - so we get
>>> garbage from
>>>    that device (either a stale extent, a bunch of zeroes due to trim/=
discard or
>>>    anything completely random). Then we compute the content for the
>>> parity stripe
>>>    based on that invalid content we read from device 3 and write the
>>> parity stripe
>>>    (and the other two stripes) to disk;
>>>
>>> 8) We later try to read extent buffer 39043072 (the one we allocated =
while in
>>>    degraded mode), but what we get from device 3 is invalid (this ext=
ent buffer
>>>    belongs to a stripe of device 3, remember step 2), so
>>> btree_read_extent_buffer_pages()
>>>    triggers a recovery attempt - this happens through:
>>>
>>>    btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
>>>      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio(=
) ->
>>>        -> raid56_parity_recover()
>>>
>>>    This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (=
the parity
>>>    stripe) by XORing the content of these last two. However the parit=
y
>>> stripe was
>>>    recomputed at step 7 using invalid content from device 3 for strip=
e 2, so the
>>>    rebuilt stripe 2 still has invalid content for the extent buffer 3=
9043072.
>>>
>>> This results in the impossibility to recover an extent buffer and
>>> getting permanent
>>> metadata corruption. If the read of the extent buffer 39043072
>>> happened before the
>>> write of extent buffer 38993920, we would have been able to recover i=
t since the
>>> parity stripe reflected correct content, it matched what was written =
in degraded
>>> mode at steps 2 and 3.
>>>
>>> The same type of issue happens for data extents as well.
>>>
>>> Since the stripe size is currently fixed at 64Kb, the issue doesn't h=
appen only
>>> if the node size and sector size are 64Kb (systems with a 64Kb page s=
ize).
>>>
>>> And we don't need to do writes in degraded mode and then mount in non=
-degraded
>>> mode with the previously missing device for this to happen (I gave th=
e example
>>> of degraded mode because that's what btrfs/125 exercises).
>>
>> This also means, other raid5/6 implementations are also affected by th=
e
>> same problem, right?
>=20
> If so, that makes them less useful as well.
> For all the other raid modes we support, which use mirrors, we don't
> have this problem. If one copy is corrupt, we are able to recover it,
> period.
>=20
>>
>>>
>>> Any scenario where the on disk content for an extent changed (some bi=
t flips for
>>> example) can result in a permanently unrecoverable metadata or data e=
xtent if we
>>> have the bad luck of having a partial stripe write happen before an a=
ttempt to
>>> read and recover a corrupt extent in the same stripe.
>>>
>>> Zygo had a report some months ago where he experienced this as well:
>>>
>>> https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats=
=2Eorg/
>>>
>>> Haven't tried his script to reproduce, but it's very likely it's due =
to this
>>> issue caused by partial stripe writes before reads and recovery attem=
pts.
>>>
>>> This is a problem that has been around since raid5/6 support was adde=
d, and it
>>> seems to me it's something that was not thought about in the initial =
design.
>>>
>>> The validation/check of an extent (both metadata and data) happens at=
 a higher
>>> layer than the raid5/6 layer, and it's the higher layer that orders t=
he lower
>>> layer (raid56.{c,h}) to attempt recover/repair after it reads an exte=
nt that
>>> fails validation.
>>>
>>> I'm not seeing a reasonable way to fix this at the moment, initial th=
oughts all
>>> imply:
>>>
>>> 1) Attempts to validate all extents of a stripe before doing a partia=
l write,
>>> which not only would be a performance killer and terribly complex, ut=
 would
>>> also be very messy to organize this in respect to proper layering of
>>> responsabilities;
>>
>> Yes, this means raid56 layer will rely on extent tree to do
>> verification, and too complex.
>>
>> Not really worthy to me too.
>>
>>>
>>> 2) Maybe changing the allocator to work in a special way for raid5/6 =
such that
>>> it never allocates an extent from a stripe that already has extents t=
hat were
>>> allocated by past transactions. However data extent allocation is cur=
rently
>>> done without holding a transaction open (and forgood reasons) during
>>> writeback. Would need more thought to see how viable it is, but not t=
rivial
>>> either.
>>>
>>> Any thoughts? Perhaps someone else was already aware of this problem =
and
>>> had thought about this before. Josef?
>>
>> What about using sector size as device stripe size?
>=20
> Unfortunately that wouldn't work as well.
>=20
> Say you have stripe 1 with a corrupt metadata extent. Then you do a
> write to a metadata extent located at stripe 2 - this partial write
> (because it doesn't cover all stripes of the full stripe), will read
> the pages from the first stripe and assume they are all good, and then
> use those for computing the parity stripe - based on a corrupt extent
> as well. Same problem I described, but this time the corrupt extent is
> in a different stripe of the same full stripe.

Yep, I also recognized that problem after some time.

Another possible solution is, always write 0 bytes for pinned extents
(I'm only thinking metadata yet).

This means, at transaction commit time, we also need to write 0 for
pinned extents before next transaction starts.
This needs some extra work, and will definite re-do a lot of parity
re-calculation, which would definitely affect performance.

So for a new partial write, before we write the new stripe, we read the
remaining data stripes (which we already need) and the parity stripe
(the new thing).

We do the rebuild, if the rebuild result is all zero, then it means the
full stripe is OK, we do regular write.

If the rebuild result is not all zero, it means the full stripe is not
consistent, do some repair before write the partial stripe.

However this only works for metadata, and metadata is never all 0, so
all zero page can be an indicator.

How this crazy idea looks?

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> It would make metadata scrubbing suffer, and would cause performance
>> problems I guess, but it looks a little more feasible.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>
>>
>=20
>=20


--BDMpNTCjt2xawyWt4XOIGmALSDWyObtXV--

--spvlnRcapkRJHrn7sp24Uo5WdzpMgLvmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6F3dwACgkQwj2R86El
/qjScAf/YvpLdh3XO0ZeFn04Zx9Ohyg2ZNBQq1/AIsPr/8RzCCpSptgMQ5WMWwCC
H4JAFXanu/fU+IlFNNj4puxRw9cFoMjMVyKxIYVCK8S9l96Nc2AFt7agw8zzaVx3
aPHYX3whb8fS63tVB7QmmfUnSSBkEKUy7laLj81M3gpzzhUcoFGIXk9z/BaMZczo
2X/FovLqTCxnU4U5lDVrGNYVMnxVtE9Bn36USM7Js+UJ2MPuk7KmulL7weJ0jhhN
RsO0lBynsn9BM6ZY0PtXr0QUl/+Fm2+/pt6pn0KZ6ne2XlubRUTdCG4V98dWYSP6
E8Vdvalw1ZeHefsiMYTPxoy0sDrm5g==
=bAtb
-----END PGP SIGNATURE-----

--spvlnRcapkRJHrn7sp24Uo5WdzpMgLvmm--

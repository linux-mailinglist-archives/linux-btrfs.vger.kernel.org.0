Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2518719CDB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbgDCAAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 20:00:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:50547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390235AbgDCAAt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 20:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585872044;
        bh=k86Pv51XV+xjZwfCyIgp9Pcc8AH4xahBzsHT+aH180g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eSji7ugxeP7VbkDv8z/bHWc12gL9eL/3dMsak3Ct+ChuobhARcYNvEsIXwfIIyqpg
         CfBktHNWBoHWe1XMohFW5fklrW8poCjNK5Xo2IDv12fTvZucmPESxMubZBYXeELsfd
         fdcc9ne8os2MXPYE6amzACfHOAH+aDdKAQnlqG4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1iymZR20v0-00qR4S; Fri, 03
 Apr 2020 02:00:44 +0200
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
 <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com>
 <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
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
Message-ID: <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com>
Date:   Fri, 3 Apr 2020 08:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4reD7PCUgcbg6P1QO0swk2wbP3pbtR0ii"
X-Provags-ID: V03:K1:/DI2l9R5LJWNCyb2I1R7xfBb9oaQDc13XSnlPNFQOBHWdP0lGWF
 /P/n0FDesD5hD4deh6oG0vmNvNj/O1UaJ2qf9LUYMHMKE3g0xZ5wcTaWI86S/CK9QYTVKFk
 0zaku7SodGgmo6Oho+8lj0gPcXP8KF1qSRtFLqlSY0pFbhZ+lk1ljmjIM6BUiQleq+5VBoY
 tt2MzEZRKb1VqPcoree5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bYgn8utqBc=:3TPkrj2CxIuBNtxm3TPs48
 kQFbUpuTtN+pEz8GWxZxJmSann4eZHjOWmZOfFwAttEAKYksAuJO0rgVVUPzs/tmONwE2Rs8h
 FQx71Mfc03S8oxSZ0ykPOCYBkCT7HyGwrAXWeT6H6muJq29v7ZhHzcSPgYpX2m8Dfk2oulxP9
 +dijcZog9OiAtrckNq2+Ui8IIRUnS5qhNf5qbLq/QdtFfOshAv3lDcL4vns3hxJvy1rw1fvyj
 b5LRczzD9aUE+rXteQJggFbwv4FFkyBb6Rujmse7VNjkO/7Z/Nmmw0wGOC6Pub08nX6sN/Ooa
 1pU2wtcN1MpfswcoD8ALRDtvD7118Eza+be7FaqhVmojDin3z/pur+EzV0qiOSfzwV2gM5tid
 H0703uH+nhVayQWFffLXfXX7yrexxPL/8fpCFu1g1CADZrtwDanZdo0AGfzKQGPcrOIB+qm2N
 b1Ujo2p0fbvO8dnFClpX6tms6Hi29qUCYGNmO44iUpAvRXU1+6LgZqd1LBe3IHcdiZXOeFfbe
 uKa7BdZfB7maQBKT6ZnjswDKb0NHcgzNzAUvWaCFhObhgnynPESG/85jI0xjiFicjkDhtpYNC
 0rYDGK1m6Hv2YwI2Q7UduOSNp96aeJbKK/CQDvozpivyA0gJ5an/EDo4qvKj5mxefVHIZS90K
 LqzJqxsrbaRz+RfDTnlSdAJTsS9ZmT3CY/cKN5ckTJOHy+hO3CicWOwIX+a665/CAuIqUS8E2
 dZb1QXPAIoGDHWVgXi0Y+z+g5QRbSx8cTjVhOESx3JfdNcdD1IRn+5A8UBAwoiUagQyEv61uw
 o7ldm1gqdjWBv8ypS9SP/1pClqhxiKktWWOwsungpn0tI0nTk5qJMmDJOsUlwog5Glbu/Tl9X
 RayI6MTayE1Q/cnBoo9D8IMdRvOQWdjahopXNhDWZZo3/5LoI/ivEIMivCJs2BW5f51p6IzKd
 kvGwrMk0py1HBKoYQ1Q0yGaWLfAUdYih9KfrsTJUXE4dkIN7zpB50GTTaAhpENGFN4h6kalpv
 FAVuZSo06+cQSvSfjGDlkkdyRO18qf2ZRh5QkZKDlL65dyJqsxjz1tMeNLOHGAsYL4yR4QBc0
 1e5g/p40Mqwc09e5UL2RvJrCsbmN0KODHjcc+5k51gevtkDOZGXuAre/1YlY3XjabA655bESr
 zB1IosmvDwZfbyqJwyft2YVav/d9Tx0u9HVmEEy6SiYA5KpbzUdHEv291uBCe8yhY7HIgG+uD
 7mN/YEGA2GD2Yz2t5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4reD7PCUgcbg6P1QO0swk2wbP3pbtR0ii
Content-Type: multipart/mixed; boundary="LsJdKzKy0ZTfpdA0yY8aFLjGQDPdCeD8u"

--LsJdKzKy0ZTfpdA0yY8aFLjGQDPdCeD8u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/2 =E4=B8=8B=E5=8D=889:26, Filipe Manana wrote:
> On Thu, Apr 2, 2020 at 1:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/4/2 =E4=B8=8B=E5=8D=888:33, Filipe Manana wrote:
>>> On Thu, Apr 2, 2020 at 12:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>
>>>>
>>>>
>>>> On 2020/4/2 =E4=B8=8B=E5=8D=887:08, Filipe Manana wrote:
>>>>> Hi,
>>>>>
>>>>> Recently I was looking at why the test case btrfs/125 from fstests =
often fails.
>>>>> Typically when it fails we have something like the following in dme=
sg/syslog:
>>>>>
>>>>>  (...)
>>>>>  BTRFS error (device sdc): space cache generation (7) does not matc=
h inode (9)
>>>>>  BTRFS warning (device sdc): failed to load free space cache for bl=
ock
>>>>> group 38797312, rebuilding it now
>>>>>  BTRFS info (device sdc): balance: start -d -m -s
>>>>>  BTRFS info (device sdc): relocating block group 754581504 flags da=
ta|raid5
>>>>>  BTRFS error (device sdc): bad tree block start, want 39059456 have=
 0
>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39059456
>>>>> (dev /dev/sde sector 18688)
>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39063552
>>>>> (dev /dev/sde sector 18696)
>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39067648
>>>>> (dev /dev/sde sector 18704)
>>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39071744
>>>>> (dev /dev/sde sector 18712)
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 137625=
6
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 138035=
2
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 144588=
8
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 138444=
8
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 138854=
4
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 139264=
0
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 139673=
6
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 140083=
2
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 140492=
8
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 140902=
4
>>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
>>>>>  BTRFS info (device sdc): read error corrected: ino 257 off 1380352=

>>>>> (dev /dev/sde sector 718728)
>>>>>  BTRFS info (device sdc): read error corrected: ino 257 off 1376256=

>>>>> (dev /dev/sde sector 718720)
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have=
 0
>>>>>  BTRFS info (device sdc): balance: ended with status: -5
>>>>>  (...)
>>>>>
>>>>> So I finally looked into it to figure out why that happens.
>>>>>
>>>>> Consider the following scenario and steps that explain how we end u=
p
>>>>> with a metadata extent
>>>>> permanently corrupt and unrecoverable (when it shouldn't be possibl=
e).
>>>>>
>>>>> * We have a RAID5 filesystem consisting of three devices, with devi=
ce
>>>>> IDs of 1, 2 and 3;
>>>>>
>>>>> * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
>>>>>
>>>>> * We have a single metadata block group that starts at logical offs=
et
>>>>> 38797312 and has a
>>>>>   length of 715784192 bytes.
>>>>>
>>>>> The following steps lead to a permanent corruption of a metadata ex=
tent:
>>>>>
>>>>> 1) We make device 3 unavailable and mount the filesystem in degrade=
d
>>>>> mode, so only
>>>>>    devices 1 and 2 are online;
>>>>>
>>>>> 2) We allocate a new extent buffer with logical address of 39043072=
, this falls
>>>>>    within the full stripe that starts at logical address 38928384, =
which is
>>>>>    composed of 3 stripes, each with a size of 64Kb:
>>>>>
>>>>>    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
>>>>> stripe 3, offset 39059456 ]
>>>>>    (the offsets are logical addresses)
>>>>>
>>>>>    stripe 1 is in device 2
>>>>>    stripe 2 is in device 3
>>>>>    stripe 3 is in device 1  (this is the parity stripe)
>>>>>
>>>>>    Our extent buffer 39043072 falls into stripe 2, starting at page=

>>>>> with index 12
>>>>>    of that stripe and ending at page with index 15;
>>>>>
>>>>> 3) When writing the new extent buffer at address 39043072 we obviou=
sly
>>>>> don't write
>>>>>    the second stripe since device 3 is missing and we are in degrad=
ed
>>>>> mode. We write
>>>>>    only the stripes for devices 1 and 2, which are enough to recove=
r
>>>>> stripe 2 content
>>>>>    when it's needed to read it (by XORing stripes 1 and 3, we produ=
ce
>>>>> the correct
>>>>>    content of stripe 2);
>>>>>
>>>>> 4) We unmount the filesystem;
>>>>>
>>>>> 5) We make device 3 available and then mount the filesystem in
>>>>> non-degraded mode;
>>>>>
>>>>> 6) Due to some write operation (such as relocation like btrfs/125
>>>>> does), we allocate
>>>>>    a new extent buffer at logical address 38993920. This belongs to=

>>>>> the same full
>>>>>    stripe as the extent buffer we allocated before in degraded mode=
 (39043072),
>>>>>    and it's mapped to stripe 2 of that full stripe as well,
>>>>> corresponding to page
>>>>>    indexes from 0 to 3 of that stripe;
>>>>>
>>>>> 7) When we do the actual write of this stripe, because it's a parti=
al
>>>>> stripe write
>>>>>    (we aren't writing to all the pages of all the stripes of the fu=
ll
>>>>> stripe), we
>>>>>    need to read the remaining pages of stripe 2 (page indexes from =
4 to 15) and
>>>>>    all the pages of stripe 1 from disk in order to compute the cont=
ent for the
>>>>>    parity stripe. So we submit bios to read those pages from the co=
rresponding
>>>>>    devices (we do this at raid56.c:raid56_rmw_stripe()). The proble=
m is that we
>>>>>    assume whatever we read from the devices is valid - in this case=
 what we read
>>>>>    from device 3, to which stripe 2 is mapped, is invalid since in =
the degraded
>>>>>    mount we haven't written extent buffer 39043072 to it - so we ge=
t
>>>>> garbage from
>>>>>    that device (either a stale extent, a bunch of zeroes due to tri=
m/discard or
>>>>>    anything completely random). Then we compute the content for the=

>>>>> parity stripe
>>>>>    based on that invalid content we read from device 3 and write th=
e
>>>>> parity stripe
>>>>>    (and the other two stripes) to disk;
>>>>>
>>>>> 8) We later try to read extent buffer 39043072 (the one we allocate=
d while in
>>>>>    degraded mode), but what we get from device 3 is invalid (this e=
xtent buffer
>>>>>    belongs to a stripe of device 3, remember step 2), so
>>>>> btree_read_extent_buffer_pages()
>>>>>    triggers a recovery attempt - this happens through:
>>>>>
>>>>>    btree_read_extent_buffer_pages() -> read_extent_buffer_pages() -=
>
>>>>>      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bi=
o() ->
>>>>>        -> raid56_parity_recover()
>>>>>
>>>>>    This attempts to rebuild stripe 2 based on stripe 1 and stripe 3=
 (the parity
>>>>>    stripe) by XORing the content of these last two. However the par=
ity
>>>>> stripe was
>>>>>    recomputed at step 7 using invalid content from device 3 for str=
ipe 2, so the
>>>>>    rebuilt stripe 2 still has invalid content for the extent buffer=
 39043072.
>>>>>
>>>>> This results in the impossibility to recover an extent buffer and
>>>>> getting permanent
>>>>> metadata corruption. If the read of the extent buffer 39043072
>>>>> happened before the
>>>>> write of extent buffer 38993920, we would have been able to recover=
 it since the
>>>>> parity stripe reflected correct content, it matched what was writte=
n in degraded
>>>>> mode at steps 2 and 3.
>>>>>
>>>>> The same type of issue happens for data extents as well.
>>>>>
>>>>> Since the stripe size is currently fixed at 64Kb, the issue doesn't=
 happen only
>>>>> if the node size and sector size are 64Kb (systems with a 64Kb page=
 size).
>>>>>
>>>>> And we don't need to do writes in degraded mode and then mount in n=
on-degraded
>>>>> mode with the previously missing device for this to happen (I gave =
the example
>>>>> of degraded mode because that's what btrfs/125 exercises).
>>>>
>>>> This also means, other raid5/6 implementations are also affected by =
the
>>>> same problem, right?
>>>
>>> If so, that makes them less useful as well.
>>> For all the other raid modes we support, which use mirrors, we don't
>>> have this problem. If one copy is corrupt, we are able to recover it,=

>>> period.
>>>
>>>>
>>>>>
>>>>> Any scenario where the on disk content for an extent changed (some =
bit flips for
>>>>> example) can result in a permanently unrecoverable metadata or data=
 extent if we
>>>>> have the bad luck of having a partial stripe write happen before an=
 attempt to
>>>>> read and recover a corrupt extent in the same stripe.
>>>>>
>>>>> Zygo had a report some months ago where he experienced this as well=
:
>>>>>
>>>>> https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungryca=
ts.org/
>>>>>
>>>>> Haven't tried his script to reproduce, but it's very likely it's du=
e to this
>>>>> issue caused by partial stripe writes before reads and recovery att=
empts.
>>>>>
>>>>> This is a problem that has been around since raid5/6 support was ad=
ded, and it
>>>>> seems to me it's something that was not thought about in the initia=
l design.
>>>>>
>>>>> The validation/check of an extent (both metadata and data) happens =
at a higher
>>>>> layer than the raid5/6 layer, and it's the higher layer that orders=
 the lower
>>>>> layer (raid56.{c,h}) to attempt recover/repair after it reads an ex=
tent that
>>>>> fails validation.
>>>>>
>>>>> I'm not seeing a reasonable way to fix this at the moment, initial =
thoughts all
>>>>> imply:
>>>>>
>>>>> 1) Attempts to validate all extents of a stripe before doing a part=
ial write,
>>>>> which not only would be a performance killer and terribly complex, =
ut would
>>>>> also be very messy to organize this in respect to proper layering o=
f
>>>>> responsabilities;
>>>>
>>>> Yes, this means raid56 layer will rely on extent tree to do
>>>> verification, and too complex.
>>>>
>>>> Not really worthy to me too.
>>>>
>>>>>
>>>>> 2) Maybe changing the allocator to work in a special way for raid5/=
6 such that
>>>>> it never allocates an extent from a stripe that already has extents=
 that were
>>>>> allocated by past transactions. However data extent allocation is c=
urrently
>>>>> done without holding a transaction open (and forgood reasons) durin=
g
>>>>> writeback. Would need more thought to see how viable it is, but not=
 trivial
>>>>> either.
>>>>>
>>>>> Any thoughts? Perhaps someone else was already aware of this proble=
m and
>>>>> had thought about this before. Josef?
>>>>
>>>> What about using sector size as device stripe size?
>>>
>>> Unfortunately that wouldn't work as well.
>>>
>>> Say you have stripe 1 with a corrupt metadata extent. Then you do a
>>> write to a metadata extent located at stripe 2 - this partial write
>>> (because it doesn't cover all stripes of the full stripe), will read
>>> the pages from the first stripe and assume they are all good, and the=
n
>>> use those for computing the parity stripe - based on a corrupt extent=

>>> as well. Same problem I described, but this time the corrupt extent i=
s
>>> in a different stripe of the same full stripe.
>>
>> Yep, I also recognized that problem after some time.
>>
>> Another possible solution is, always write 0 bytes for pinned extents
>> (I'm only thinking metadata yet).
>>
>> This means, at transaction commit time, we also need to write 0 for
>> pinned extents before next transaction starts.
>=20
> I'm assuming you mean to write zeroes to pinned extents when unpinning
> them- after writing the superblock of the committing transaction.

So the timing of unpinning them would also need to be changed.

As mentioned, it needs to be before starting next transaction.

Anyway, my point is, if we ensure all unwritten data contains certain
pattern (for metadata), then we can at least use them to detect out of
sync full stripe.

Thanks,
Qu

> But
> way before that, the next transaction may have already started, and
> metadata and data writes may have already started as well, think of
> fsync() or writepages() being called by the vm due to memory pressure
> for example (or page migration, etc).
>=20
>> This needs some extra work, and will definite re-do a lot of parity
>> re-calculation, which would definitely affect performance.
>>
>> So for a new partial write, before we write the new stripe, we read th=
e
>> remaining data stripes (which we already need) and the parity stripe
>> (the new thing).
>>
>> We do the rebuild, if the rebuild result is all zero, then it means th=
e
>> full stripe is OK, we do regular write.
>>
>> If the rebuild result is not all zero, it means the full stripe is not=

>> consistent, do some repair before write the partial stripe.
>>
>> However this only works for metadata, and metadata is never all 0, so
>> all zero page can be an indicator.
>>
>> How this crazy idea looks?
>=20
> Extremely crazy :/
> I don't see how it would work due to the above comment.
>=20
> thanks
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>>
>>>> It would make metadata scrubbing suffer, and would cause performance=

>>>> problems I guess, but it looks a little more feasible.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>=20
>=20


--LsJdKzKy0ZTfpdA0yY8aFLjGQDPdCeD8u--

--4reD7PCUgcbg6P1QO0swk2wbP3pbtR0ii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6GfKgACgkQwj2R86El
/qjHnwgAp/4rvTxU3jiyzPbfLkhDGoI++Nv65faKs4tUhzib7L47VoPdlCeRJ0qk
ideykaZ4WsW7l8XgH0MB1D1Lf1NDOrmZ4b5h9LeYykC04GFjeS3s+PqNdwI55OM+
64AU58ZZ5jHdxWJJPXoAk0FzQX5XUZX3ZFVpMBBvsShIl2TKiobYXPXBaZ+ouVDC
+FytUUBkepvCfAaliQAOQxC/T4r/8J5HWFUvTEnpNhQTKSZl6HWkgXMLWQxWiNZf
uDGhTsyhto4mskdh+UmZhbVdFTFqVxofmklMOIW7ok6bvUSWgWzXac18cNOunFiN
RrtqhcNOJL9etnHmKku0PrVqmD3lAA==
=gJQA
-----END PGP SIGNATURE-----

--4reD7PCUgcbg6P1QO0swk2wbP3pbtR0ii--

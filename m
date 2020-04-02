Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286AF19C097
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbgDBLzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 07:55:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:42661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbgDBLzT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 07:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585828513;
        bh=DnfNajvHVq5IZmj9jLd5lrnMoCpeBiqX1UuSyl/EARQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gXeGg7o3EfbDcKFSyYE0HVnv+OqzEMqp197OmjxilkiT1lJi6IPNBW86z4w3SISbB
         R/Av+yg5pdQlsnXDGTbyVuWXpD0s4vX83niqTBG8goZy/RZXNRX+Zh5Ti/9ppqZZKK
         MEILnx+RmAowJYzKZaxLOptHf/ZG9CHnqKQ9p59E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4zAs-1j9uGS37iu-010xYF; Thu, 02
 Apr 2020 13:55:13 +0200
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
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
Message-ID: <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
Date:   Thu, 2 Apr 2020 19:55:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gXED2FgqxBkN28OD7tqogPZk1hxi4jrSM"
X-Provags-ID: V03:K1:iHA47pptUVN+CaYwkgyRyMU/TjvsjUQWngU+KwQngKDydBwes27
 Hr/G9EIBpjECMmDKRQit0wfRCs7ffU93x2L0NB0raXOXo/N2SjIlTXhQyPd3kzEi9RqNxsD
 9NwdiGM9m0O+chUYOeaNc/CiB22oi6SZgDEZTsrNJs7fr7mle5tVrLL+CqHPVLPWiUvQnNb
 hM8ts+Te/Yn/w/CLLTUoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:610qu1aaZLY=:mXA7/KpTrB41WuX2CBoD2n
 bdpDMIi1hb56ue5PCWDm0AXrJIXyB9T6ALVpsslgcDdd2e6DzgATqxb59+64j1AUMgjI4oi5b
 N2/cahJMqrwMAcb/Mv3pLpSRpbMUKyMpEL0Xx4B66UnI5gYTU0mICl/1ey/JxBE8xZOt0434y
 +kdaI9S0INd7yE69zBelaDbatKa1YO85zs53bAMTiApts784qjQyzBm/ujkDTy2lqnDtVxdvc
 t20+KYY/TJ8CGhNqOPuO8+IpFm5S0PnhItm4aXYmN+LcKf1kiEpMGyAcLNH9lMCzO4pFu/DND
 JoWSeIBhqQBU92BOG03e4MOP2NUpOQNIsNPGWoBGR4WFPXhAP6e7mwJtJRwfjvvszvhjaUwty
 29/Ad3al+Ri6TEr/X23iyX/2z4u6DS7gm9qtjmp+JMs+l1GfXnwgOumN1mKmbafu/bUPlLa9Y
 SHhG+pvoDSI+bNoFw7WVg51QP6i5x/Bev+atgZhhYob6onupn2KVCugqcpl+tyd0kvD4T3CAT
 bdrE0LHHlVEf77+pPOSNQmHEYe8/1GlhEkJ3dzwHE2rOjvo+evE1NC5nLifo3FvMnMER8AKRW
 ReBbMt0plu7W2I7282gPQiqPEOdPtdBZL5F4KT4e0HD8D/TOd9ZLhwAVqrlKm+RPHpHt0S68m
 lcSv0ZG5jvJnzFySLerG+y3tEiFcZHbFi/LZ0sOWqAZPQ3EGLe9ZLEkKw9Apx+BYwyeJoluS4
 VZhoTZTwfk+scG6ypRqmHEevlB5VLoHqewceMQLmFZnN7xSZLFNxX91oXtxX76dzmqiXveoQi
 HNn39kziKKP7YcjS8I8/Va5eZo2Bb73FT7rHIFPAOn0o0029tsF8dNbvhRlO62rv2d+dejUCR
 hCA7snAU1YYJaparfiPs3JIGl+H4WDlyNqsyEnkgbwkgAKQM8WmctnfyTNcAyGpEyKEdmAv3u
 nESrWf/Yv/HRWE6D7Gtw3mM/q8TezxzNkt7xrf36RQtqTqh6usHBOR1egodamWj9+4hcuhzz7
 7yrz98B6CYXEwWMsLEeqjQ0sE8rN3A8x2/xIKfVKYKABwm/XIiQMunVoyFxUBWLf2yWaGhq6v
 Axv28QisxFAylFtYyCfgS4IGyboLYGF4AV1TX6ahpibnJC82MJqcbUTB/h+9xPQXj+JLJeHRT
 1cl9uHNhNw+joIX6eWPPZCUxLmKHYllwUq6Ay4Y7sUaZegsdbj0f1Wn5eAQODdFDK56IGsozU
 mgnV7Vak+HeJyBhiM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gXED2FgqxBkN28OD7tqogPZk1hxi4jrSM
Content-Type: multipart/mixed; boundary="JwKC33nV02CO2VTFXxmrja6CA9FjTSlpb"

--JwKC33nV02CO2VTFXxmrja6CA9FjTSlpb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/2 =E4=B8=8B=E5=8D=887:08, Filipe Manana wrote:
> Hi,
>=20
> Recently I was looking at why the test case btrfs/125 from fstests ofte=
n fails.
> Typically when it fails we have something like the following in dmesg/s=
yslog:
>=20
>  (...)
>  BTRFS error (device sdc): space cache generation (7) does not match in=
ode (9)
>  BTRFS warning (device sdc): failed to load free space cache for block
> group 38797312, rebuilding it now
>  BTRFS info (device sdc): balance: start -d -m -s
>  BTRFS info (device sdc): relocating block group 754581504 flags data|r=
aid5
>  BTRFS error (device sdc): bad tree block start, want 39059456 have 0
>  BTRFS info (device sdc): read error corrected: ino 0 off 39059456
> (dev /dev/sde sector 18688)
>  BTRFS info (device sdc): read error corrected: ino 0 off 39063552
> (dev /dev/sde sector 18696)
>  BTRFS info (device sdc): read error corrected: ino 0 off 39067648
> (dev /dev/sde sector 18704)
>  BTRFS info (device sdc): read error corrected: ino 0 off 39071744
> (dev /dev/sde sector 18712)
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376256
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380352
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445888
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384448
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388544
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392640
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396736
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400832
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404928
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409024
> csum 0x8941f998 expected csum 0x93413794 mirror 1
>  BTRFS info (device sdc): read error corrected: ino 257 off 1380352
> (dev /dev/sde sector 718728)
>  BTRFS info (device sdc): read error corrected: ino 257 off 1376256
> (dev /dev/sde sector 718720)
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
>  BTRFS info (device sdc): balance: ended with status: -5
>  (...)
>=20
> So I finally looked into it to figure out why that happens.
>=20
> Consider the following scenario and steps that explain how we end up
> with a metadata extent
> permanently corrupt and unrecoverable (when it shouldn't be possible).
>=20
> * We have a RAID5 filesystem consisting of three devices, with device
> IDs of 1, 2 and 3;
>=20
> * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
>=20
> * We have a single metadata block group that starts at logical offset
> 38797312 and has a
>   length of 715784192 bytes.
>=20
> The following steps lead to a permanent corruption of a metadata extent=
:
>=20
> 1) We make device 3 unavailable and mount the filesystem in degraded
> mode, so only
>    devices 1 and 2 are online;
>=20
> 2) We allocate a new extent buffer with logical address of 39043072, th=
is falls
>    within the full stripe that starts at logical address 38928384, whic=
h is
>    composed of 3 stripes, each with a size of 64Kb:
>=20
>    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
> stripe 3, offset 39059456 ]
>    (the offsets are logical addresses)
>=20
>    stripe 1 is in device 2
>    stripe 2 is in device 3
>    stripe 3 is in device 1  (this is the parity stripe)
>=20
>    Our extent buffer 39043072 falls into stripe 2, starting at page
> with index 12
>    of that stripe and ending at page with index 15;
>=20
> 3) When writing the new extent buffer at address 39043072 we obviously
> don't write
>    the second stripe since device 3 is missing and we are in degraded
> mode. We write
>    only the stripes for devices 1 and 2, which are enough to recover
> stripe 2 content
>    when it's needed to read it (by XORing stripes 1 and 3, we produce
> the correct
>    content of stripe 2);
>=20
> 4) We unmount the filesystem;
>=20
> 5) We make device 3 available and then mount the filesystem in
> non-degraded mode;
>=20
> 6) Due to some write operation (such as relocation like btrfs/125
> does), we allocate
>    a new extent buffer at logical address 38993920. This belongs to
> the same full
>    stripe as the extent buffer we allocated before in degraded mode (39=
043072),
>    and it's mapped to stripe 2 of that full stripe as well,
> corresponding to page
>    indexes from 0 to 3 of that stripe;
>=20
> 7) When we do the actual write of this stripe, because it's a partial
> stripe write
>    (we aren't writing to all the pages of all the stripes of the full
> stripe), we
>    need to read the remaining pages of stripe 2 (page indexes from 4 to=
 15) and
>    all the pages of stripe 1 from disk in order to compute the content =
for the
>    parity stripe. So we submit bios to read those pages from the corres=
ponding
>    devices (we do this at raid56.c:raid56_rmw_stripe()). The problem is=
 that we
>    assume whatever we read from the devices is valid - in this case wha=
t we read
>    from device 3, to which stripe 2 is mapped, is invalid since in the =
degraded
>    mount we haven't written extent buffer 39043072 to it - so we get
> garbage from
>    that device (either a stale extent, a bunch of zeroes due to trim/di=
scard or
>    anything completely random). Then we compute the content for the
> parity stripe
>    based on that invalid content we read from device 3 and write the
> parity stripe
>    (and the other two stripes) to disk;
>=20
> 8) We later try to read extent buffer 39043072 (the one we allocated wh=
ile in
>    degraded mode), but what we get from device 3 is invalid (this exten=
t buffer
>    belongs to a stripe of device 3, remember step 2), so
> btree_read_extent_buffer_pages()
>    triggers a recovery attempt - this happens through:
>=20
>    btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
>      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio() =
->
>        -> raid56_parity_recover()
>=20
>    This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (th=
e parity
>    stripe) by XORing the content of these last two. However the parity
> stripe was
>    recomputed at step 7 using invalid content from device 3 for stripe =
2, so the
>    rebuilt stripe 2 still has invalid content for the extent buffer 390=
43072.
>=20
> This results in the impossibility to recover an extent buffer and
> getting permanent
> metadata corruption. If the read of the extent buffer 39043072
> happened before the
> write of extent buffer 38993920, we would have been able to recover it =
since the
> parity stripe reflected correct content, it matched what was written in=
 degraded
> mode at steps 2 and 3.
>=20
> The same type of issue happens for data extents as well.
>=20
> Since the stripe size is currently fixed at 64Kb, the issue doesn't hap=
pen only
> if the node size and sector size are 64Kb (systems with a 64Kb page siz=
e).
>=20
> And we don't need to do writes in degraded mode and then mount in non-d=
egraded
> mode with the previously missing device for this to happen (I gave the =
example
> of degraded mode because that's what btrfs/125 exercises).

This also means, other raid5/6 implementations are also affected by the
same problem, right?

>=20
> Any scenario where the on disk content for an extent changed (some bit =
flips for
> example) can result in a permanently unrecoverable metadata or data ext=
ent if we
> have the bad luck of having a partial stripe write happen before an att=
empt to
> read and recover a corrupt extent in the same stripe.
>=20
> Zygo had a report some months ago where he experienced this as well:
>=20
> https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats.o=
rg/
>=20
> Haven't tried his script to reproduce, but it's very likely it's due to=
 this
> issue caused by partial stripe writes before reads and recovery attempt=
s.
>=20
> This is a problem that has been around since raid5/6 support was added,=
 and it
> seems to me it's something that was not thought about in the initial de=
sign.
>=20
> The validation/check of an extent (both metadata and data) happens at a=
 higher
> layer than the raid5/6 layer, and it's the higher layer that orders the=
 lower
> layer (raid56.{c,h}) to attempt recover/repair after it reads an extent=
 that
> fails validation.
>=20
> I'm not seeing a reasonable way to fix this at the moment, initial thou=
ghts all
> imply:
>=20
> 1) Attempts to validate all extents of a stripe before doing a partial =
write,
> which not only would be a performance killer and terribly complex, ut w=
ould
> also be very messy to organize this in respect to proper layering of
> responsabilities;

Yes, this means raid56 layer will rely on extent tree to do
verification, and too complex.

Not really worthy to me too.

>=20
> 2) Maybe changing the allocator to work in a special way for raid5/6 su=
ch that
> it never allocates an extent from a stripe that already has extents tha=
t were
> allocated by past transactions. However data extent allocation is curre=
ntly
> done without holding a transaction open (and forgood reasons) during
> writeback. Would need more thought to see how viable it is, but not tri=
vial
> either.
>=20
> Any thoughts? Perhaps someone else was already aware of this problem an=
d
> had thought about this before. Josef?

What about using sector size as device stripe size?

It would make metadata scrubbing suffer, and would cause performance
problems I guess, but it looks a little more feasible.

Thanks,
Qu

>=20
> Thanks.
>=20
>=20


--JwKC33nV02CO2VTFXxmrja6CA9FjTSlpb--

--gXED2FgqxBkN28OD7tqogPZk1hxi4jrSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6F0pwACgkQwj2R86El
/qih2ggArNl5PMVY+tlGghe5yKhzuQjbSFYpP5gFwrtplTYtHBX+Plucpm7Plrdz
D6GXHmV8l0RHVtCcj79e0Xo3dl/IoADz/WI+lZpXTj0XJAx8Zhp3tUahEKpJdSJP
/w8+2zbC4JwkszHeIj+/MEZy+oNSjQHf/uREXYx6M5hFsFPTn/8JQG7kOr5YMak+
u5KvRcZU39edGQB+untv/eD6E1aAtabNnczXlDQJicdO81cr+ER7NQXqBZ3EAAYd
3U1Ck4GskjvbwIeBmfWAai8rTov++8fr5z03TmpsQkv4d2XpkQUD36rZRTolKDNO
gVE99faVlHi48XUSc0I864flw1m3YA==
=l350
-----END PGP SIGNATURE-----

--gXED2FgqxBkN28OD7tqogPZk1hxi4jrSM--

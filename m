Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289E4234256
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgGaJTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 05:19:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:42957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbgGaJTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596187173;
        bh=XfMJp52igBJ0/+ht4CDu6DwrR38NTftuQCD9OBepFrs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lCny6/siyQ061xWmcoq1xIg9jl3G2CtC5c7Cgm+pFYjrt3pG/RgjoE2l1P/Jg5vYS
         thCcOAMoxoj5dvmxmXGBTeMn5RYo4Zrq48c2jAimMJ7lpUFfcLKGwngsdeaGnieNqP
         yKdrjOqGkMomU4kaixdgPG6H0jtuWsNzbv5wMDow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1kFegy1KPU-00VvyE; Fri, 31
 Jul 2020 11:19:33 +0200
Subject: Re: [PATCH] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200731072258.85861-1-wqu@suse.com>
 <CAL3q7H5r9CSbsTTPgstaYEFzo9PE40H2ZC4a7_Wf3BQB_Q+9Ow@mail.gmail.com>
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
Message-ID: <e65b4920-07a7-2c22-51a5-51dd16cc1246@gmx.com>
Date:   Fri, 31 Jul 2020 17:19:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5r9CSbsTTPgstaYEFzo9PE40H2ZC4a7_Wf3BQB_Q+9Ow@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="stLFqI0SfXD6KyxoyeUrVfzTowJkr17Nx"
X-Provags-ID: V03:K1:uKuTeeHuiY/TUif7ZS/wdFnnNDAQYPHrjsGO0g7neu+MvY7Q3wH
 gwwCtRUuGPHaM9wnAaWWN1Km1hACVYsva2kqZszRFKI/yetdOwjXsemxb8yXvdQYPUHkDKv
 rzC+tmpWq0HkDQ4XNgPLOLLI593gL6Z/z7PSCrvr0A/VNHg/Vrp1LNv7sTpwaLDR3yLmcr8
 eJxkH7JYaqi0juE6WFIDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pp+tSdr3INc=:HuzuX930xkV7cuQBCvY5dp
 hgewsocROdbP0ycl22xb5m1/QDMca/KjUG9NGA3rl9ypzVmdZNHQaN3l1NGwDgKjc2fXm/FxL
 OstCQ53Xx4RAdITnSHtQ4wn65e32zfzkDP4nCbpXhxZeNDok7McJbReo6QoIw+doRXtd55VGr
 wlaLI37ffhvRPUR2tKKJ2tsIz+tCjzf9mVFOHQKZVkFuOZl23w7owxb5jyzKZG8lg13Cb2UCS
 g1c+8BgW2N8JIBN+nPGzSAA55D3npcumt1AAxvOpnvcqUnDH2dFRC0+Nu5DnbxC8J320jc384
 1Ep2kZmLe9iComhIXzR3Gy7MWR6RfS5guVbtsDHkbHIOfII/PCOPCeI8jM3pnKB7KLNARDzTi
 VvxXtCFwBUVfG0D7xoTfHtGNALzKxgpbwGwl5799zVWdAtTT026uLmCOc9dWGAqkqDHYs/Xq9
 32XF6n42ZBUS+FtbjacdmDXJZqHtThPQi+izptmuMeQIPXBpG+GN8lgQn1Os/gVQ04ed3y+A4
 zR08mSel9kHE3d9Em/apR7y/Qgm3wt2U3freKhdofQw/2f8JTYVUj1nQpNsz0SGjZFT6SZPPX
 skhgWhAHnN51jAb7rXFqYaPBofSTXnUilKI41Wc5OV52PupcGgKqDpl7GbiC6Kr+oG/rM7zp/
 Urkd89wVFDQCFawF1nGqyDHe7bIlwyBo2Zlxfb1HJ8ZQSjVcyefD0xPpoeJcuOXNhBKp83OWJ
 TOayPWpFPPu+rtO9CwUTOYAbTfaJJNhQERkVswCNJK+EArpzOJJsUxQu8oYTOrRpr0LYW250U
 lGwGz2edLhLr+K4upD+UYahrCdrqFjUIoudRklIRaApYPGt9EDwWlYYSQbVlfNRuseJ6+iTPT
 URbzOiAd8t4aWr0xG+VyfTpLD7i2eP1+ab6WvF4V/IsA/iBZv/gAmkrCvKdI+G042cmSpZ3iM
 kewBxXsA8wgvNTU6ras+uwl6IJenKsPnaLvrVUiHDZiaQ+VWL/ZHzl2qKinOVTz6dPkP8Y+gD
 8O+EraC0AD3yqwzhDvRwMKEdDanbAn9DoDj740TaEVjCILMl2xs6umWjJn1+L/pxk9rkHjnUY
 55BK0SGBYDU918gKOkme88R7KI1qtyFC9RG0KJ7uBl+OEmWd22aMiKzYjxsKNUAnDPQkjhp1u
 borj1C5klgIy302KRXrZIPqDKXSapbTXSGuimWQr+dl2nDqdMmu3QDpsJu2vQcy3GWYDFb+jo
 cP1HscwTKbXAXlhOIpVsuFXjGjPMHxWVATXzeGQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--stLFqI0SfXD6KyxoyeUrVfzTowJkr17Nx
Content-Type: multipart/mixed; boundary="2TOByYMEwgJyd070tbq6yvKhEeZ197z24"

--2TOByYMEwgJyd070tbq6yvKhEeZ197z24
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/31 =E4=B8=8B=E5=8D=885:10, Filipe Manana wrote:
> On Fri, Jul 31, 2020 at 8:24 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can lead to tons of beyond device boundary access=
:
>>
>>   mkfs.btrfs -f $dev -b 10G
>>   mount $dev $mnt
>>   trimfs $mnt
>>   btrfs filesystem resize 1:-1G $mnt
>>   trimfs $mnt
>>
>> [CAUSE]
>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
>> already trimmed.
>>
>> So we check device->alloc_state by finding the first range which doesn=
't
>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>
>> But if we shrunk the device, that bits are not cleared, thus we could
>> easily got a range starts beyond the shrunk device size.
>>
>> This results the returned @start and @end are all beyond device size,
>> then we call "end =3D min(end, device->total_bytes -1);" making @end
>> smaller than device size.
>>
>> Then finally we goes "len =3D end - start + 1", totally underflow the
>> result, and lead to the beyond-device-boundary access.
>>
>> [FIX]
>> This patch will fix the problem in two ways:
>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>   This is the root fix
>>
>> - Add extra safe net when trimming free device extents
>>   We check and warn if the returned range is already beyond current
>>   device.
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/282
>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_fi=
rst_clear_extent_bit")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add proper fixes tag
>> - Add extra warning for beyond device end case
>> - Add graceful exit for already trimmed case
>> ---
>>  fs/btrfs/extent-tree.c | 18 ++++++++++++++++++
>>  fs/btrfs/volumes.c     | 12 ++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index fa7d83051587..84ec24506fc1 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -5669,6 +5669,24 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
>>                                             &start, &end,
>>                                             CHUNK_TRIMMED | CHUNK_ALLO=
CATED);
>>
>> +               /* CHUNK_* bits not cleared properly */
>> +               if (start > device->total_bytes) {
>> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +                       btrfs_err(fs_info,
>> +               "alloc_state not cleared properly for shrink, devid %l=
lu",
>> +                                 device->devid);
>=20
> Hum, I find the message a bit cryptic: referring to the name of
> attributes of structures, like alloc_state is not very user friendly.
> Plus this message is assuming all possible current and future bugs of
> attempts to trim beyond the device size are caused by a past shrink
> operation.
> I'm pretty sure we had such bugs in the past due to other causes.
>=20
> How about something like:
>=20
> btrfs_warn("ignoring attempt to trim beyond device size: offset %llu
> length %llu device %s device size %llu")

That's indeed much better.

>=20
> I find it a lot more helpful for both users and developers.
>=20
>> +                       mutex_unlock(&fs_info->chunk_mutex);
>> +                       ret =3D -EUCLEAN;
>> +                       break;
>=20
> I don't see a reason to return an error. Especially EUCLEAN since
> nothing is really corrupted on disk.

OK, let's just return 0 as usual.

Thanks,
Qu
>=20
> Thanks.
>=20
>> +               }
>> +
>> +               /* The remaining part has already been trimmed */
>> +               if (start =3D=3D device->total_bytes) {
>> +                       mutex_unlock(&fs_info->chunk_mutex);
>> +                       ret =3D 0;
>> +                       break;
>> +               }
>> +
>>                 /* Ensure we skip the reserved area in the first 1M */=

>>                 start =3D max_t(u64, start, SZ_1M);
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d7670e2a9f39..4e51ef68ea72 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *de=
vice, u64 new_size)
>>         }
>>
>>         mutex_lock(&fs_info->chunk_mutex);
>> +       /*
>> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyon=
d the
>> +        * current device boundary.
>> +        * This shouldn't fail, as alloc_state should only utilize tho=
se two
>> +        * bits, thus we shouldn't alloc new memory for clearing the s=
tatus.
>> +        *
>> +        * So here we just do an ASSERT() to catch future behavior cha=
nge.
>> +        */
>> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64=
)-1,
>> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
>> +       ASSERT(!ret);
>> +
>>         btrfs_device_set_disk_total_bytes(device, new_size);
>>         if (list_empty(&device->post_commit_list))
>>                 list_add_tail(&device->post_commit_list,
>> --
>> 2.28.0
>>
>=20
>=20


--2TOByYMEwgJyd070tbq6yvKhEeZ197z24--

--stLFqI0SfXD6KyxoyeUrVfzTowJkr17Nx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8j4iAACgkQwj2R86El
/qi3Vgf7BXryLMMgha6DRVnB5SPz71MJfmDXZ5QBYoipJI3Qr9buMkP8+m2MzutH
Bmz2sR+VT70c+wnqGGJpLvy4jnT3EobIp/8eutDnv+H1Ja0THO8NyobrbSAwDmrM
ie8o9AGHj//niIYy4qjW9NSZO0+hKSyvp4efDZbgEs85Zd6a2FEyI+sp6PfpnD9b
FIvPu18lyks8aYk7wLTiCAeF1GNx7q/2edVZaVEQue9XiTOQkj+QZ7P1FQDYPx29
0/0xzi4mHu7U6n5RyJna18FVwsy8caM5WmNHrr6JdSa9F7eFI271arAKHWvrvgf1
AbzyXrO4KZ2QzfJ9/DWWLjiHTvDXMg==
=bZ/R
-----END PGP SIGNATURE-----

--stLFqI0SfXD6KyxoyeUrVfzTowJkr17Nx--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3B2454F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 01:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHOXk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Aug 2020 19:40:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:58239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgHOXk4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Aug 2020 19:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597534846;
        bh=YrKboiBDXM3z6nQPuR4FJvL9DKFAGbgYbhHBP5s9l/M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bUBcVmvEhrIXKlRTOHZOtwtpVNE6BUTKLkWxBz9LbUqiycSbgcDKh0nw53mb8CFXI
         sBngmeGmdnwCHX4c9rY3CzQ0fTNBdubdxGTGNvwNrASIx3Iaw5IquSmeUcUeANyYFA
         mPmwrW/iw2cnjN0ebtgp83jthUaABIzMpQ9E05m4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1kin9o3toP-016fuv; Sun, 16
 Aug 2020 01:40:46 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size
 never exceed device size
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Jiachen YANG <farseerfc@gmail.com>
References: <20200624115527.855816-1-wqu@suse.com>
 <60a0f996-fcd0-4188-3e58-1f0acaae5192@oracle.com>
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
Message-ID: <7141f9c6-7e50-e784-35a2-f8453b49f90c@gmx.com>
Date:   Sun, 16 Aug 2020 07:40:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <60a0f996-fcd0-4188-3e58-1f0acaae5192@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XznuMdFkSooKo9LMQKpxv62OVrwtZ8fLq"
X-Provags-ID: V03:K1:m7n1uMnNAAjZnKKKh82dBre+2RXR6/IzfRBEmlYMdWWXKTRUzy1
 DwfU6r/oFiQZ+tLnP0rYvqJeKKIKgS/q3vNze1Nhfcfbi9XyiE0mK1neHFtsN6zQAr6aF6z
 tp2fOLTz6lLGLSLQpuytgwKF4N7mlyDxcwxsvfx++ZbYRqLszwUQixZMPnsbiCrCU4UUMTs
 nATaKLnAq3lYCTVf56BNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Dnq6ZEtvcU=:xZVWV8fZsKSvB47GbSJSe3
 vgIv6iY6CB3aMaCJsioAT/HDjdSi9Acc7okOa2dBaFLZ694Xw69BEd0qm6yASt0mt3lW65jKI
 cIG7Wh/CWpQOEdUFIADxvKoF+ibp4/8wUXsrjgmR3vSppV0OFUjj5bZ5VAIP5TXxrLnssL27u
 9LwcZYLA7/P+cmuCA61MQfodFaUVoXZDYRmBRoYG7vRm+87cytI73VhORr91BQVGRYgQ8bHN0
 I5VucbD/DDo96+jOmMofseo+3mWju8c22gnLOOtdjBPUv7mrY5sZJAdm/5syx9XxtLUNqakf7
 7+uy01hvzNnDvd39unXY3QWsIvnEJpxRFzTvKzknBGAdu6KEFTqFTzfGFD3OdG3lHaXon8MBk
 S7KKpK5qpWK+FhYMOOZTwYcnjzq5uumhJ82sfxmZ+feUDCzf4wI1NimbtTL0ttxAdCTFuujCm
 U9hFGkynHmTQRgkUV3bWwB/4IcujX/GB7ktEHw7UYgz9jO+casKnxIaFrgQW6aJK5K6c3JL8V
 +hKvrCcmhn4i1Hp5/8jmmSmfG+BUb/Ep5xBLv0Q9/UPZGeQ/CBn1Ozf+uzlLHhoIlGCjHtkYs
 0EwR/zCk9IPn7RknrbVWkVOwU682RiHG3NweJLQ91O4nBvNAUBQQfr8FNHUAfSn2NRhys6QGX
 XgMVLD41BkoHTcKdk/mnaPzvDxmkljkRCbsxRr+US6+UeP3ylqonTnvoowellj8hLVn8vI0FG
 VNbum5fQKxc97wnmswOLa6cULn35BD7k7oiv3pnLObhSZAZJJ9JnIXiq/56wjEn9+eSQAkx4z
 Q9MskBl/4KvtcY1B7j1OMflLjCRnOzQthKruVfQ9e2GPz/9QubPagfiPzf8MY7ALhkTbuoPNW
 JwvCHDyd32ZsEdFUcntWHhhF9To6pQQLwWUGS3FORkgCN76Gnh6jApYWdQHIqeQ4m2h8nzNSX
 ivanaBUTMRULmcc0QmpcfDyyUPyAIuXGZO6r10f7aQt2E/LB14VO6eo7M3A+/AQMyvhndxce1
 phngsazYWaGxbAnprT6e4TZiXRUA1e0dM6Qroioz8K9mAl18IKXveGdAyUvmnHcU0Y4eGIc5L
 Ixh2pFfjYA0TQeE4RFiR2JGi00q758p3TbUVdeYKW6jdvgfRIbLnXBYNuoGDBj+mdMVxy9BED
 JDnn8PGohih2fG1NPU4cJQ4SGR7/msC5h5ou3ysGcPYFKk/p/L9q8cxT49KhmieeVdXl+HiHv
 WZBSlawwBSPd9fycdQjroLqFKC/YZzvk7ObIsIA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XznuMdFkSooKo9LMQKpxv62OVrwtZ8fLq
Content-Type: multipart/mixed; boundary="goi3CEmqcShIfDrOYg3uVTucOofPXVdVx"

--goi3CEmqcShIfDrOYg3uVTucOofPXVdVx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/15 =E4=B8=8B=E5=8D=889:38, Anand Jain wrote:
>=20
> Before this patch the converted ext4 was failing to mount due to 'beyon=
d
> device boundary' error.

e2image -Q please.

Thanks,
Qu
>=20
> After this patch
>=20
> # ./btrfs-convert /dev/sda7
> create btrfs filesystem:
> =C2=A0=C2=A0=C2=A0=C2=A0blocksize: 4096
> =C2=A0=C2=A0=C2=A0=C2=A0nodesize:=C2=A0 16384
> =C2=A0=C2=A0=C2=A0=C2=A0features:=C2=A0 extref, skinny-metadata (defaul=
t)
> =C2=A0=C2=A0=C2=A0=C2=A0checksum:=C2=A0 crc32c
> creating ext2 image file
> ERROR: data bytenr 1644167168 is covered by non-data block group
> 1644167168 flags 0x4
> ERROR: failed to create ext2_saved/image: -22
> WARNING: an error occurred during conversion, filesystem is partially
> created but not finalized and not mountable
>=20
>=20
> Any idea?
>=20
>=20
> On 24/6/20 7:55 pm, Qu Wenruo wrote:
>> [BUG]
>> The following script could lead to corrupted btrfs fs after
>> btrfs-convert:
>>
>> =C2=A0=C2=A0 fallocate -l 1G test.img
>> =C2=A0=C2=A0 mkfs.ext4 test.img
>> =C2=A0=C2=A0 mount test.img $mnt
>> =C2=A0=C2=A0 fallocate -l 200m $mnt/file1
>> =C2=A0=C2=A0 fallocate -l 200m $mnt/file2
>> =C2=A0=C2=A0 fallocate -l 200m $mnt/file3
>> =C2=A0=C2=A0 fallocate -l 200m $mnt/file4
>> =C2=A0=C2=A0 fallocate -l 205m $mnt/file1
>> =C2=A0=C2=A0 fallocate -l 205m $mnt/file2
>> =C2=A0=C2=A0 fallocate -l 205m $mnt/file3
>> =C2=A0=C2=A0 fallocate -l 205m $mnt/file4
>> =C2=A0=C2=A0 umount $mnt
>> =C2=A0=C2=A0 btrfs-convert test.img
>>
>> The result btrfs will have a device extent beyond its boundary:
>> =C2=A0=C2=A0 pening filesystem to check...
>> =C2=A0=C2=A0 Checking filesystem on test.img
>> =C2=A0=C2=A0 UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
>> =C2=A0=C2=A0 [1/7] checking root items
>> =C2=A0=C2=A0 [2/7] checking extents
>> =C2=A0=C2=A0 ERROR: dev extent devid 1 physical offset 993198080 len 8=
5786624 is
>> beyond device boundary 1073741824
>> =C2=A0=C2=A0 ERROR: errors found in extent allocation tree or chunk al=
location
>> =C2=A0=C2=A0 [3/7] checking free space cache
>> =C2=A0=C2=A0 [4/7] checking fs roots
>> =C2=A0=C2=A0 [5/7] checking only csums items (without verifying data)
>> =C2=A0=C2=A0 [6/7] checking root refs
>> =C2=A0=C2=A0 [7/7] checking quota groups skipped (not enabled on this =
FS)
>> =C2=A0=C2=A0 found 913960960 bytes used, error(s) found
>> =C2=A0=C2=A0 total csum bytes: 891500
>> =C2=A0=C2=A0 total tree bytes: 1064960
>> =C2=A0=C2=A0 total fs tree bytes: 49152
>> =C2=A0=C2=A0 total extent tree bytes: 16384
>> =C2=A0=C2=A0 btree space waste bytes: 144885
>> =C2=A0=C2=A0 file data blocks allocated: 2129063936
>> =C2=A0=C2=A0=C2=A0 referenced 1772728320
>>
>> [CAUSE]
>> Btrfs-convert first collect all used blocks in the original fs, then
>> slightly enlarge the used blocks range as new btrfs data chunks.
>>
>> However the enlarge part has a problem, that it doesn't take the devic=
e
>> boundary into consideration.
>>
>> Thus it caused device extents and data chunks to go beyond device
>> boundary.
>>
>> [FIX]
>> Just to extra check before inserting data chunks into
>> btrfs_convert_context::data_chunk.
>>
>> Reported-by: Jiachen YANG <farseerfc@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 convert/main.c | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/convert/main.c b/convert/main.c
>> index c86ddd988c63..7709e9a6c085 100644
>> --- a/convert/main.c
>> +++ b/convert/main.c
>> @@ -669,6 +669,8 @@ static int calculate_available_space(struct
>> btrfs_convert_context *cctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cur_off =3D cache->start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_len =3D max=
(cache->start + cache->size - cur_off,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_stripe_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* data chunks should neve=
r exceed device boundary */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_len =3D min(cctx->tota=
l_bytes - cur_off, cur_len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D add_mer=
ge_cache_extent(data_chunks, cur_off, cur_len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>
>=20


--goi3CEmqcShIfDrOYg3uVTucOofPXVdVx--

--XznuMdFkSooKo9LMQKpxv62OVrwtZ8fLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl84cnoACgkQwj2R86El
/qhcLQf/Y/zox5CatelcsA4000rWmsYrX93bEItSjao09Q8XV2aYvEeHRnD6kNSq
OyVz6SQ70gIR/i6r77tJh+7vfFXznkW0ulCBehzCLcDM5om8v3v0WbW8uaTZ0m7G
upDHXneMY5Dprs/BkHXYMU9STuuHnHUelrV6MfcIFX58CHE7eSpuEW8UNSnJcFGH
/n0OJj92jvWRE6whSyfZOZU4X85e/K+H6rpBWeFbErX2SCjzCWoYxPKMrdns8hoi
Nr2xBumCBMMcndJOzoiSXVUYOT6ZEXEJZvAEKTWWqLMu2It9JHyCT+wSVkUjZ7B/
JXw4iz08cheU1t2tqJbJfE0X94W/dQ==
=xPQG
-----END PGP SIGNATURE-----

--XznuMdFkSooKo9LMQKpxv62OVrwtZ8fLq--

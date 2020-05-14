Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1193C1D29B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgENII6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 04:08:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:39875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgENII5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 04:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589443732;
        bh=9wNQ8p1WxSx3B4H2QI7uSMUF2UWg6SN42NZvV25JOyA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SxZGcSVoAqYnbX5X5CSkB6YT7WKT59TXitdeym5uVWI3+e70D7kYKOOtHdQdL5MAc
         fboA66yB6QkrJI4DDUEFAJpp33bVC1MndB0CwS9qtGx9XnK5SWLOWfUiyVSuPD79rZ
         eJZDUvdoBY2tZ05PJLIaWKwObUG0nGMLvqEHrjxs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1jJxZi3qlV-00Fmff; Thu, 14
 May 2020 10:08:52 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513052452.GY10769@hungrycats.org>
 <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
 <20200513122140.GA10769@hungrycats.org>
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
Message-ID: <3b3c805d-7c75-5fe7-1ed8-4a7841b16647@gmx.com>
Date:   Thu, 14 May 2020 16:08:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513122140.GA10769@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A9py9pxakxoHNE5eMqmTx8a9O8aBuXzVA"
X-Provags-ID: V03:K1:CUv52Nm+0Gtg9VCEl9r0GFtohsDpHyg+6Wy5GKza6p64U+BvM+6
 DATyFJ/uuhiy3xQUcgEDn2jr+A/2qCQ1PTxvH3xVJZgZ8MRPZDBhnk4EzMSF244z+UWW13+
 RDZl4QB32vxnSvoFbV3ZaxY0krVqEe7DlpkpcfBQwVmaXJKzfiPx4ZlkcDaQBq4zXMLLwO9
 beg3YaJ7YAkrxgPeZsYBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8LAHILoqchM=:Z38F+qcKztidM+/zg1/ARN
 88SjCG+GfF+gUGuPb8tiJn442DWZBF7rbPI0hbVWLwcNMpWuuSn/WTqMMdj8XpAVFswkJz1rl
 kOOG4PpOt1nTTrAlT4IKiVIF6YPm0YyeEC7IjpI8JSUnhQm20xiMEe3dUPcM8w+LN+zmztU1X
 1achfTK3VUU4uei5CinLW/b+C1jvG3EC6xjj1etlXQmz6Vi5erCYT+mNnwi0rw7uzWg2aGJZK
 lq7VENrbcLQn7Y/wulgPLE5aQxbxmTa2CGsh9dS1lZgKWWTIpX/Pu3uMFStJgX95yeDkq0JWY
 yTC7t7Srj6XEji63g+BPSfP4x6muT/pVwV4SSLQvtFXITTGZRexC6L2mtm0lzc/HUQnZ8L9HY
 9/goYXyXfjZx9BdErwvT6t8EdKXQdvwBNDoC27vp1L1N395Z+n3E9gYF1nVW+Cj73AzeFloZ1
 gXG08UQI017fnTQ2RszPdzS9eHNtp1r7W8BOZHgI80tGw2zAeNcvoF/DZx/Rq07rac2ijrxLI
 7vrfkuNvQMkbWAu01dJXfsm70fQmoO8GcmgDqHGuwaYdN5yBl5myv/B3/wsz8nS1lqafKk7v1
 qxnRfmunMx2BHL4087f86+MegA1W801/q3ZWSK6sEimHQc1q3qk+EC3956ZbLsVpCISco+ywx
 Zr/m4+BoGmlwIPsRBKrragns3Ci7tsJBGc5olJUZNuC2yCWc/jMlu9HXJ2l1+Fg/VBZuSMUGE
 ilxZM7AsmV1A8354goViGc9JTyqnobROVhkzMgxm1NBSzM6m0tTt39iRe62pTlteopxj17pF7
 07W/0qGUCwaDVT4+rs0xsvlHCnOrHMDj1WZn91SP8p0wMd8Fz3R4gaEHa7P9V1EIBGwimJyVt
 FbC5rPULpa5Vgj5REA17ISqsrJJeV+i7BWGN9KWoYExhAU4YG7OlFM3gArZLiOnnCb3YInXnP
 SHaAf1Onr5k5r1BrQahluAaaIhAV9g6X/IDQc/PxP41vE1eYPZIZNeeugwNOvQbIERZh6Vwgr
 15FD1h7obq1bifRc0AK9s/7LyGH6iD8wh75xcA6/0kmgAKZmPZ4RL1DRPS82ZpcpJpU3UFff5
 JvqetAj4wVG7ByqokGA3xX+ktKPKWl8kQJOcvNke0pEYtr6PlvXD1VBOQvXO0PZmxIMvLBcCj
 z3PB7GCxG5N6G7cVSXhdoWbaqPXIBB8pWhwXVzD+3UR9aEf/hpChXRkxaWdJjfOZz/eZYdAYT
 xriFHyZbWhdvghgKN
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A9py9pxakxoHNE5eMqmTx8a9O8aBuXzVA
Content-Type: multipart/mixed; boundary="FhVsha24yzHB0pcqDTHjDAtccx6Fl64eC"

--FhVsha24yzHB0pcqDTHjDAtccx6Fl64eC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/13 =E4=B8=8B=E5=8D=888:21, Zygo Blaxell wrote:
> On Wed, May 13, 2020 at 07:23:40PM +0800, Qu Wenruo wrote:
>>
>>
[...]
>=20
> Kernel log:
>=20
> 	[96199.614869][ T9676] BTRFS info (device dm-0): balance: start -d
> 	[96199.616086][ T9676] BTRFS info (device dm-0): relocating block grou=
p 4396679168000 flags data
> 	[96199.782217][ T9676] BTRFS info (device dm-0): relocating block grou=
p 4395605426176 flags data
> 	[96199.971118][ T9676] BTRFS info (device dm-0): relocating block grou=
p 4394531684352 flags data
> 	[96220.858317][ T9676] BTRFS info (device dm-0): found 13 extents, loo=
ps 1, stage: move data extents
> 	[...]
> 	[121403.509718][ T9676] BTRFS info (device dm-0): found 13 extents, lo=
ops 131823, stage: update data pointers
> 	(qemu) stop
>=20
> btrfs-image URL:
>=20
> 	http://www.furryterror.org/~zblaxell/tmp/.fsinqz/image.bin
>=20
The image shows several very strange result.

For one, although we're relocating block group 4394531684352, the
previous two block groups doesn't really get relocated.

There are still extents there, all belongs to data reloc tree.

Furthermore, the data reloc tree inode 620 should be evicted when
previous block group relocation finishes.

So I'm considering something went wrong in data reloc tree, would you
please try the following diff?
(Either on vanilla kernel or with my previous useless patch)

Thanks,
Qu

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9afc1a6928cf..ef9e18bab6f6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3498,6 +3498,7 @@ struct inode *create_reloc_inode(struct
btrfs_fs_info *fs_info,
        BTRFS_I(inode)->index_cnt =3D group->start;

        err =3D btrfs_orphan_add(trans, BTRFS_I(inode));
+       WARN_ON(atomic_read(inode->i_count) !=3D 1);
 out:
        btrfs_put_root(root);
        btrfs_end_transaction(trans);
@@ -3681,6 +3682,7 @@ int btrfs_relocate_block_group(struct
btrfs_fs_info *fs_info, u64 group_start)
 out:
        if (err && rw)
                btrfs_dec_block_group_ro(rc->block_group);
+       WARN_ON(atomic_read(inode->i_count) !=3D 1);
        iput(rc->data_inode);
        btrfs_put_block_group(rc->block_group);
        free_reloc_control(rc);


--FhVsha24yzHB0pcqDTHjDAtccx6Fl64eC--

--A9py9pxakxoHNE5eMqmTx8a9O8aBuXzVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl68/JAACgkQwj2R86El
/qh4gQf6A3gOJQJx0QuqixX89XvSsKqY4T7H1eDfa+PHRun7rougifP1Xn80sXEn
rNK3XVkSKJS8Q3b0Q5U9Jo4YOsZ3g0nuDmLeYpfNiiVVMlfhTbL6f//C7v+pagNP
izn7MMJkU/dJMENemAAUknao5MatlWdvsLGF2+Ew7KPFKRjHB7mKTf5uHwRlY+2L
gqdCK/5OOFqGo5bz+/cjKW9mthHMIyPRJauJ6XTnVOQHIELmpA8/Sjg/szOXCR3x
x8MEo7K11thgLhIiQOFH9fzE4tqXZ8Frco9rhxECIN9iZRx93JCNSpiJgQR96Hzj
BcMUrZMg2YCbELmKuFmQBuKwgbIX5g==
=ioJa
-----END PGP SIGNATURE-----

--A9py9pxakxoHNE5eMqmTx8a9O8aBuXzVA--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106861517DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgBDJao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 04:30:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:42087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJan (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 04:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580808637;
        bh=w8uv9j4/7VDIGnvV6eJjU2upAoM4BvUO+dy8oq/DGik=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ePqYzVTSLbBecBBrq4YV2U87EQ51aXOhVccS5kKkmty+2Jesbqijm1tGgzWQDSpuR
         uqgTAV2t7NN/HPEZB3oFI6Oqgex+kM0A7aGf9sp/2cO9XjjVWaxEj/bEmUuNteUXLT
         Qx7CEs1SdtQWF/zbo3Y3ZWBwTTPJcJyjplOD+0ZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlGk-1jTpRE2UsK-00dlei; Tue, 04
 Feb 2020 10:30:37 +0100
Subject: Re: [PATCH 1/3] btrfs: add a comment describing block-rsvs
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-2-josef@toxicpanda.com>
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
Message-ID: <8d33b43f-bcba-0fed-60e5-2908e219181b@gmx.com>
Date:   Tue, 4 Feb 2020 17:30:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203204436.517473-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BKWmV8qRrTw6CEAoWTONeF3CczDsOS3ap"
X-Provags-ID: V03:K1:8sqTjDsovzM1a4/pbS+0uTXfIMKpg5HAWtjxGqtN2fAbOQRTXfN
 /K6K/7INvJIrBgcC0m8lKM7itH/Uxa6LKBigRSOGxncMXFGiIbc/kWZfL1FotP8/yR3SPUj
 WkPDYRswcWXgHo+9ZhFh3cKy34d1VAkYDlscvajGTyey/dH3xpY9QpnCE2dbbL8x7yar9n4
 XHEU3X0s7Wr3EtvcLUS3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U2Ph3Ekxbsg=:/p28T6k17QpHxFwsWu0Aqj
 qZRVOtrA+cT9fbaHTnZ4jQFYwruTJd8W6/826vrekvRcn/MRs9KYMsJ1te93QixUA/cExx9Y0
 jFodbLQB69UdLGQolgTLAmm7g1fxs74xtAeti0kzVbQ4LnD44J8d+Gsl3+ZwJKrAKuSnCrTaE
 /3LQY3I+DzotDNf5N9J1MTpnzIGSh+mQawGSHy54r863Z97MobVWENYnDLAz3XoYYEGgxEJJt
 mYuzKdR75EnwRocnfaZwaAlC8i0Mr1h8GlhVIERHtIxSj0YeYshOjEzo/nOkMgLPYoros4u8X
 Ys/3Uuq8oEkk04b8hLHR7l4B0gXXgMZNxdtCENmDao7MVhtKdlunWwCmSQuG5O4d4Tl91DhAc
 UiT9sMfMFKaaFn5Lom7qryfsLip00lKcfubMjCIiB2CuqkYeA8q30PnLJ3MQtCQZVFOuYkdnT
 CU/2o3AVKKOFYQYOTOdZI+raDeXE2H2P/kYug5wHhJ/W9jBfIE7Ohxi11c10JEYrbQe5tbGeI
 svD5NaiRgDZKW8HOD6EZ0cUE1mryMaTHl7rkJ9chlaldsZxxbT01/rENQ5dMFfNPomsJ/Q0yP
 4Pelc1APY2U6EcXXILYF/dgyd/MqywArKFUmJ/d/4L3T6yQC2GIH9idevxKGtuoMGy/xTP29R
 FnAcgqboTvgavD6DNTf+bcxaBhdCq9TiGFTdfwixht7rCmqClUtmSKdsJ7j+GgXXCs4cyOYWO
 Fw4P5UJvD1VV2DuJFSy2hG6R+3O7OTbVqUdgCDqbkvvaqvf+MnJgDD2XWHFPiSo2KUazhYKly
 zxMrSs7eKMBG13k1Wvz15v1hdgIYSSIHMrTNWtwXTu1KmMU/2dbfkigC52pEZI5BQiEGqOR7T
 jCv/X6U+fqf/GXmYTZyyiX1D+E4+Y7VE2nK45crYCpARbsQcpned794gnJQfuIpYzwBk/eU+j
 Xc652teJ0vPYXxsFhqIcoFQ7usMSyJ6vOForKqytHGVrtmPRteBLE9E1z2a+OEITaXZFojeHx
 ys/u7urU4dzIqo3kZrJxAt5DdGL9a25uYxMyEWDC8vm/yeAeZ9gw0zzRkjMBye9M32SK1H9WO
 8slG+Q8bJOoJSBy0xjeWDqCoCQcKlD8Bi8JG2NKoSlsOwgumai14xKfeiYFNNqBBzcLPno9Nr
 L8sxY1TfHhJM5nMb98ek+gnM3I5M5z0rDvvMoxFFZSaWaBwh6jPSfBgOKav+zPjIZgvu0iqlP
 T4cCixMkl7DAN4A8G
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BKWmV8qRrTw6CEAoWTONeF3CczDsOS3ap
Content-Type: multipart/mixed; boundary="q8UdDGocn83wFX7BcAba735F2OIgbi5U2"

--q8UdDGocn83wFX7BcAba735F2OIgbi5U2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/4 =E4=B8=8A=E5=8D=884:44, Josef Bacik wrote:
> This is a giant comment at the top of block-rsv.c describing generally
> how block rsvs work.  It is purely about the block rsv's themselves, an=
d
> nothing to do with how the actual reservation system works.

Such comment really helps!

Although it looks like there are too many words but too little ascii
arts or graphs.
Not sure if it's really easy to read.

And some questions inlined below.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-rsv.c | 81 ++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 81 insertions(+)
>=20
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index d07bd41a7c1e..54380f477f80 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -6,6 +6,87 @@
>  #include "space-info.h"
>  #include "transaction.h"
> =20
> +/*
> + * HOW DO BLOCK RSVS WORK
> + *
> + *   Think of block_rsv's as bucktes for logically grouped reservation=
s.  Each
> + *   block_rsv has a ->size and a ->reserved.  ->size is how large we =
want our
> + *   block rsv to be, ->reserved is how much space is currently reserv=
ed for
> + *   this block reserve.

This block_rsv system is for metadata only, right?
Since data size can be easily determined, no need to such complex system.=


> + *
> + *   ->failfast exists for the truncate case, and is described below.
> + *
> + * NORMAL OPERATION
> + *   We determine we need N items of reservation, we use the appropria=
te
> + *   btrfs_calc*() helper to determine the number of bytes.  We call i=
nto
> + *   reserve_metadata_bytes() and get our bytes, we then add this spac=
e to our
> + *   ->size and our ->reserved.

Since you mentioned bytes_may_use in the finish part, what about also
mentioning that here?

> + *
> + *   We go to modify the tree for our operation, we allocate a tree bl=
ock, which
> + *   calls btrfs_use_block_rsv(), and subtracts nodesize from
> + *   block_rsv->reserved.
> + *
> + *   We finish our operation, we subtract our original reservation fro=
m ->size,
> + *   and then we subtract ->size from ->reserved if there is an excess=
 and free
> + *   the excess back to the space info, by reducing space_info->bytes_=
may_use by
> + *   the excess amount.

So I find the workflow can be expressed like this using timeline (?) grap=
h:

+--- Reserve:
|    Entrance: btrfs_block_rsv_add(), btrfs_block_rsv_refill()
|
|    Calculate needed bytes by btrfs_calc*(), then add the needed space
|    to our ->size and our ->reserved.
|    This also contributes to space_info->bytes_may_use.
|
+--- Use:
|    Entrance: btrfs_use_block_rsv()
|
|    We're allocating a tree block, will subtracts nodesize from
|    block_rsv->reserved.
|
+--- Finish:
     Entrance: btrfs_block_rsv_release()

     we subtract our original reservation from ->size,
     and then we subtract ->size from ->reserved if there is an excess
     and free the excess back to the space info, by reducing
     space_info->bytes_may_use by the excess amount.

> + *
> + *   In some cases we may return this excess to the global block reser=
ve or
> + *   delayed refs reserve if either of their ->size is greater than th=
eir
> + *   ->reserved.
> + *

Types of block_rsv:

> + * BLOCK_RSV_TRANS, BLOCK_RSV_DELOPS, BLOCK_RSV_CHUNK
> + *   These behave normally, as described above, just within the confin=
es of the
> + *   lifetime of ther particular operation (transaction for the whole =
trans
> + *   handle lifetime, for example).
> + *
> + * BLOCK_RSV_GLOBAL
> + *   This has existed forever, with diminishing degrees of importance.=

> + *   Currently it exists to save us from ourselves.  We definitely ove=
r-reserve
> + *   space most of the time, but the nature of COW is that we do not k=
now how
> + *   much space we may need to use for any given operation.  This is
> + *   particularly true about the extent tree.  Modifying one extent co=
uld
> + *   balloon into 1000 modifications of the extent tree, which we have=
 no way of
> + *   properly predicting.  To cover this case we have the global reser=
ve act as
> + *   the "root" space to allow us to not abort the transaciton when th=
ings are
> + *   very tight.  As such we tend to treat this space as sacred, and o=
nly use it
> + *   if we are desparate.  Generally we should no longer be depending =
on its
> + *   space, and if new use cases arise we need to address them elsewhe=
re.

Although we all know global rsv is really important for essential tree
updates, can we make it a little simpler?
It looks too long to read though.

I guess we don't need to put all related info here.
Maybe just mentioning the usage of each type is enough?
(Since the reader will still go greping for more details)

This also applies to the remaining types.

Thanks,
Qu

> + *
> + * BLOCK_RSV_DELALLOC
> + *   The individual item sizes are determined by the per-inode size
> + *   calculations, which are described with the delalloc code.  This i=
s pretty
> + *   straightforward, it's just the calculation of ->size encodes a lo=
t of
> + *   different items, and thus it gets used when updating inodes, inse=
rting file
> + *   extents, and inserting checksums.
> + *
> + * BLOCK_RSV_DELREFS
> + *   We keep a running talley of how many delayed refs we have on the =
system.
> + *   We assume each one of these delayed refs are going to use a full
> + *   reservation.  We use the transaction items and pre-reserve space =
for every
> + *   operation, and use this reservation to refill any gap between ->s=
ize and
> + *   ->reserved that may exist.
> + *
> + *   From there it's straightforward, removing a delayed ref means we =
remove its
> + *   count from ->size and free up reservations as necessary.  Since t=
his is the
> + *   most dynamic block rsv in the system, we will try to refill this =
block rsv
> + *   first with any excess returned by any other block reserve.
> + *
> + * BLOCK_RSV_EMPTY
> + *   This is the fallback block rsv to make us try to reserve space if=
 we don't
> + *   have a specific bucket for this allocation.  It is mostly used fo=
r updating
> + *   the device tree and such, since that is a separate pool we're con=
tent to
> + *   just reserve space from the space_info on demand.
> + *
> + * BLOCK_RSV_TEMP
> + *   This is used by things like truncate and iput.  We will temporari=
ly
> + *   allocate a block rsv, set it to some size, and then truncate byte=
s until we
> + *   have no space left.  With ->failfast set we'll simply return ENOS=
PC from
> + *   btrfs_use_block_rsv() to signal that we need to unwind and try to=
 make a
> + *   new reservation.  This is because these operations are unbounded,=
 so we
> + *   want to do as much work as we can, and then back off and re-reser=
ve.
> + */
> +
>  static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_block_rsv *block_rsv,
>  				    struct btrfs_block_rsv *dest, u64 num_bytes,
>=20


--q8UdDGocn83wFX7BcAba735F2OIgbi5U2--

--BKWmV8qRrTw6CEAoWTONeF3CczDsOS3ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl45ObkACgkQwj2R86El
/qiPAAf/fg5JAHjx4bY/RQWlhjWXlgWST4PivL75E6RGZS144zVlVdJl9+JS8Amu
AoHgj/nBnfZ/aCAyTh+dhKJBAJlqrSMvtNNeanxKMObrwHgka+Cr+1/vH+LoKvSU
8oO+0WSjhkc6I37jPpInUpXfVKrLhYReS52w5EPHgpH5xXiwuQUdyCJ4gT4SeVuU
p0J6679RCjyJmTFyvmb2oaXZTeO5nj0B2jwpZDN1wfwZRt5uV10UTSp/SDkq7BlH
ZeA8GCrBfN2PvqXdcMVQJ7yPKsq05OcEeKP70l+XhE8UIaa/kAlgVDRHLHasicTi
0DsydahotLGOArtD9B5qgR+BjI+6+w==
=U9o0
-----END PGP SIGNATURE-----

--BKWmV8qRrTw6CEAoWTONeF3CczDsOS3ap--

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1399015182C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 10:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDJtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 04:49:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:50167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgBDJtG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 04:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580809739;
        bh=mZUlSNXXh5MO5yVL6K43oKg/NNj4fEW/ZIFZlx/Bn+k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PNrSLnfY1mJ4kvbLgaMV5lhv6l6gxepX82jXni6k8YFgygxSzHKwQccl6ZaXsxm4c
         0jE9Y0hcHIryxinHWaYi9yXcHJKbnGZvXVsTh2wHd+hKF0vNg0/uxJtCnlgTOKo4H0
         JHRO8lj3Vm7ZlhbN/xWaV2eYMfR4pwJzrnSl2Ux4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmUHp-1jP8yR4Bpx-00iU75; Tue, 04
 Feb 2020 10:48:59 +0100
Subject: Re: [PATCH 2/3] btrfs: add a comment describing delalloc space
 reservation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-3-josef@toxicpanda.com>
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
Message-ID: <7000f8a2-4d78-d9a1-2e3f-143b88ace1eb@gmx.com>
Date:   Tue, 4 Feb 2020 17:48:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203204436.517473-3-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tAAZBpDD8hZq7dDUxlyWlCjpjVuUyl4Om"
X-Provags-ID: V03:K1:LpYpvlKdtR9Ey1Ro6dH4VSueLvrnBCQfyyRKj9JaaYLvSuvZVG+
 62vUbTrG1hGzP6zWrEV4HuhvRjAWsZuQ8V35J0QQpR5lqmZjhUKcbzEHJXW1FbeJZYT8rc1
 yqkMuGRysScN0Ge+O6xPFxmGBVGOkDRwJBO0u/kthjTsvwmHEL9rHEuEeF2Fm8SfaooGRAp
 O7uJKDKDvXBX8MftPAqMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bxkVdQOZx+8=:ihz8kqaYUeFsq5UkhzdE32
 Rkx+qOCfmKRS8B++NnW3hmmpE2rNkngPz8r/LoJ0GQEN/gZAz8nH/571RAwRPeuwZCPujlTug
 0KdgjYzXlgS36Q1Cg+kz2r61+UNJPHaCt744mQ4iKejXN1Jgasn9hFDBbfMnF697lydZLSVIp
 LkhpEEOuDGqR3d0SobBe9bp2GlCyuIXd1eTM01Fz1hYLsEExyo1c3Zo3C3fxhu4b/6VtmJePt
 JZzZbGGxBfROa3Fuu/zNz92Rk77F4vh8rkTfnsFucnSsEMchmimnlxm/az7Xq8FVdnZFhrBxD
 hcvuxGi3BLIB9DpF/Zij+R4JTWB/g6DFqj9upODf/87q6s2gtCR2iPaGugwK/kSDxbCmG2vGq
 856eYf61/uZh6+UOGSEvPvkvFKjWPJH02bFJqBZyhmv9bXAC34N5BqSykLs+cr2PWR0bWgNYc
 gu+w0VMXBs9+oMvmHO112Q8sCERrETPNR4Xdc9Rf5NMN57TUZLggztN/iN2lhBk8hrYLvE9GL
 x08AeeYkpCdLaPH8mEJtG1+fyEziLP8h2F0zr/cfzsfmFdVT5UlpCAqmDOwqJvDrP582Rxwb0
 p4/jMCcVAmP8Tdr/3ZrPS5VD+qDaSNlcY0WoQF4KQKxoGRzK0BIXQl6ZlBoK6xgT0/KDnq3Yp
 R/XuNCsCdCanshm56SIJU/ZcjHui3GmKQZe6pB7YjLtCl/PxsJ4CKqdeRS5snSmh1hfgsORK4
 9gL/xQPCSJkVXPZCjGtTK+QHwWzFJ1WSUWEpdH+RFFLVbgUh/9T260tm0TaN1rGU5+BZiPhMY
 BudxGCIKYJjqCY4p0oKL2y9MloY1lvDKCjSi2KQ7BqJ9DZCWuSt0KOM+AeBkvcswwb0Aur1wR
 hVKewKIrIRmbi0HnIalMsoZixdi/ITpjlBs1pJR6fiiNOb2e0TpCOrL1gkuoxXnvh151IRqek
 wkKUSDYge0EpG/vvt3vQANvvgdaJ6Ywp+HhqxHGM5IomcNuUH3rICiAMq5GobFcKEuL4ErZaK
 R5hS8MqPOmJnCLSrkBEEYN4bgmCuBnT9lV5KGdgSLnjtDFK/sBieaafQBOSaY4wIDNOoaz4PK
 L1KWZJAkStRL26JzZudBCr2oRgOB15bz6CdyZCj799bRNsfYjFin2qWUj1HCXRT0bpH+X4VqT
 rhGGVlQ/KDtcriv4xujNxzkPopgl9MrlfrnAr4RM5uaAeI6+TKABN7xaK8DUpso6hw3OASjAy
 1eWHlj/LAfH/H1Jud
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tAAZBpDD8hZq7dDUxlyWlCjpjVuUyl4Om
Content-Type: multipart/mixed; boundary="FWUPvJrYeyI60K0eZwIrjSjcUMiFbupdT"

--FWUPvJrYeyI60K0eZwIrjSjcUMiFbupdT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/4 =E4=B8=8A=E5=8D=884:44, Josef Bacik wrote:
> delalloc space reservation is tricky because it encompasses both data
> and metadata.  Make it clear what each side does, the general flow of
> how space is moved throughout the lifetime of a write, and what goes
> into the calculations.

In fact, the lifespan of a write would be super helpful for newbies.

I still remember the pain when trying to understand the whole mechanism
years ago.

>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delalloc-space.c | 90 +++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 90 insertions(+)
>=20
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index c13d8609cc99..09a9c01fc1b5 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -9,6 +9,96 @@
>  #include "qgroup.h"
>  #include "block-group.h"
> =20
> +/*
> + * HOW DOES THIS WORK
> + *
> + * There are two stages to data reservations, one for data and one for=
 metadata
> + * to handle the new extents and checksums generated by writing data.
> + *
> + *
> + * DATA RESERVATION
> + *   The data reservation stuff is relatively straightforward.  We wan=
t X bytes,
> + *   and thus need to make sure we have X bytes free in data space in =
order to
> + *   write that data.  If there is not X bytes free, allocate data chu=
nks until
> + *   we can satisfy that reservation.  If we can no longer allocate da=
ta chunks,
> + *   attempt to flush space to see if we can now make the reservaiton.=
  See the
> + *   comment for data_flush_states to see how that flushing is accompl=
ished.

What about such less words version?
We want X bytes of data space.

If there is not enough, try the following methods in order:
- Allocate new data chunk
- Flush space
  See comment for data_flush_states

> + *
> + *   Once this space is reserved, it is added to space_info->bytes_may=
_use.  The
> + *   caller must keep track of this reservation and free it up if it i=
s never
> + *   used.  With the buffered IO case this is handled via the EXTENT_D=
ELALLOC
> + *   bit's on the inode's io_tree.  For direct IO it's more straightfo=
rward, we
> + *   take the reservation at the start of the operation, and if we wri=
te less
> + *   than we reserved we free the excess.

This part involves the lifespan and state machine of data.
I guess more explanation on the state machine would help a lot.

Like:
Page clean
|
+- btrfs_buffered_write()
|  Reserve data space for data, metadata space for csum/file
|  extents/inodes.
|
Page dirty
|
+- run_delalloc_range()
|  Allocate data extents, submit ordered extents to do csum calculation
|  and bio submission
Page write back
|
+- finish_oredred_io()
|  Insert csum and file extents
|
Page clean

Although I'm not sure if such lifespan should belong to delalloc-space.c.=


> + *
> + *   For the buffered case our reservation will take one of two paths
> + *
> + *   1) It is allocated.  In find_free_extent() we will call
> + *   btrfs_add_reserved_bytes() with the size of the extent we made, a=
long with
> + *   the size that we are covering with this allocation.  For non-comp=
ressed
> + *   these will be the same thing, but for compressed they could be di=
fferent.
> + *   In any case, we increase space_info->bytes_reserved by the extent=
 size, and
> + *   reduce the space_info->bytes_may_use by the ram_bytes size.  From=
 now on
> + *   the handling of this reserved space is the responsibility of the =
ordered
> + *   extent or the cow path.
> + *
> + *   2) There is an error, and we free it.  This is handled with the
> + *   EXTENT_CLEAR_DATA_RESV bit when clearing EXTENT_DELALLOC on the i=
node's
> + *   io_tree.
> + *
> + * METADATA RESERVATION
> + *   The general metadata reservation lifetimes are discussed elsewher=
e, this
> + *   will just focus on how it is used for delalloc space.
> + *
> + *   There are 3 things we are keeping reservations for.

It looks the 3 things are too detailed I guess?
It's definitely educational, but not sure if it fits the introduction
nature of such comment.

I guess we only need to mention:
- Objective
  How this meta rsv is used for (inode item, file extents, csum)

- Location of interest
  Important details. (outstanding extents and DELALLOC bits for metadata
  rsv calculation)

- Timing of such rsv
  When we reserve/update, use and release. (function entrance)

Then it should be enough for people to dig for their own interest.

Thanks,
Qu

> + *
> + *   1) Updating the inode item.  We hold a reservation for this inode=
 as long
> + *   as there are dirty bytes outstanding for this inode.  This is bec=
ause we
> + *   may update the inode multiple times throughout an operation, and =
there is
> + *   no telling when we may have to do a full cow back to that inode i=
tem.  Thus
> + *   we must always hold a reservation.
> + *
> + *   2) Adding an extent item.  This is trickier, so a few sub points
> + *
> + *     a) We keep track of how many extents an inode may need to creat=
e in
> + *     inode->outstanding_extents.  This is how many items we will hav=
e reserved
> + *     for the extents for this inode.
> + *
> + *     b) count_max_extents() is used to figure out how many extent it=
ems we
> + *     will need based on the contiguous area we have dirtied.  Thus i=
f we are
> + *     writing 4k extents but they coalesce into a very large extent, =
we will
> + *     break this into smaller extents which means we'll need a reserv=
ation for
> + *     each of those extents.
> + *
> + *     c) When we set EXTENT_DELALLOC on the inode io_tree we will fig=
ure out
> + *     the nummber of extents needed for the contiguous area we just c=
reated,
> + *     and add that to inode->outstanding_extents.
> + *
> + *     d) We have no idea at reservation time how this new extent fits=
 into
> + *     existing extents.  We unconditionally use count_max_extents() o=
n the
> + *     reservation we are currently doing.  The reservation _must_ use=

> + *     btrfs_delalloc_release_extents() once it has done it's work to =
clear up
> + *     this outstanding extents.  This means that we will transiently =
have too
> + *     many extent reservations for this inode than we need.  For exam=
ple say we
> + *     have a clean inode, and we do a buffered write of 4k.  The rese=
rvation
> + *     code will mod outstanding_extents to 1, and then set_delalloc w=
ill
> + *     increase it to 2.  Then once we are finished,
> + *     btrfs_delalloc_release_extents() will drop it back down to 1 ag=
ain.
> + *
> + *     e) Ordered extents take on the responsibility of their extent. =
 We know
> + *     that the ordered extent represents a single inode item, so it w=
ill modify
> + *     ->outstanding_extents by 1, and will clear delalloc which will =
adjust the
> + *     ->outstanding_extents by whatever value it needs to be adjusted=
 to.  Once
> + *     the ordered io is finished we drop the ->outstanding_extents by=
 1 and if
> + *     we are 0 we drop our inode item reservation as well.
> + *
> + *   3) Adding csums for the range.  This is more straightforward than=
 the
> + *   extent items, as we just want to hold the number of bytes we'll n=
eed for
> + *   checksums until the ordered extent is removed.  If there is an er=
ror it is
> + *   cleared via the EXTENT_CLEAR_META_RESV bit when clearning EXTENT_=
DELALLOC
> + *   on the inode io_tree.
> + */
> +
>  int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 byt=
es)
>  {
>  	struct btrfs_root *root =3D inode->root;
>=20


--FWUPvJrYeyI60K0eZwIrjSjcUMiFbupdT--

--tAAZBpDD8hZq7dDUxlyWlCjpjVuUyl4Om
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl45PgcACgkQwj2R86El
/qjGDQgAn6lZBHRg/g+CjX37PSBKpA2f0FN5FnAw/t/VwdP43OoD0AflvZLgx0Sc
G3k3EG/HeAH9cFq1jMqkd2WIQp/Yo7/Iv2R7dti+xVbKvCNEcEmCRaO7XOmsErDj
Y1jE2JODR57j12WqiIryA0izhzrDyjayF4zpy2GJvHPt6zQ7WYrRiJM6U5+7wYVp
+6ILFlgBjhjTU/9HOoLh3oHhAWV8LAdt02gdbASfIgSwzcZnr4TJHBeUpTllKV6N
kjBL8zK8+bIkoZj1Xiq8TcYL4qgfXMjtnzyaotA1yWEmMTJyEQLAQbQkwEdmhqqM
MASI7c768v0REdl3DEJR7EYHwlJnaw==
=Ilxq
-----END PGP SIGNATURE-----

--tAAZBpDD8hZq7dDUxlyWlCjpjVuUyl4Om--

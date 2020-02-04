Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3485F1518A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 11:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgBDKOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 05:14:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:45389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgBDKOb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 05:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580811263;
        bh=3aK5t1wHuVVA24XTyrJirc9271HHGaLoG6fm3zxcae0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B/6E4Ewdab2xrnEsWvpLi8pyK16hggcyTEK1urZYwtH0+6meu4ZuSEhPOLdYxsT3L
         K0hLortQAnuiE6qD3Y/A7dDhsI+C2Nl5DvovsCi6mdGnr6zahOTcU/OjaviknWCJCE
         /vCFK24aO4gM9X13ma5GgYjyFhk8nst3kvxd9gJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxlzC-1jkrfU3OZS-00zC1c; Tue, 04
 Feb 2020 11:14:23 +0100
Subject: Re: [PATCH 3/3] btrfs: describe the space reservation system in
 general
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-4-josef@toxicpanda.com>
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
Message-ID: <128ebe61-4a3b-951a-8905-dce2f616fd0f@gmx.com>
Date:   Tue, 4 Feb 2020 18:14:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203204436.517473-4-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QZLQ01BBZS8j8HRI5NQorTuxewWQSFnOr"
X-Provags-ID: V03:K1:BTJLH7SWBsdlzJDOkbOOTvBRZKstXnmT3HxfPgCUs6LcCdpmZo4
 KQDekwqhl2kkvjXIQp/h/KyKDHLbamtpNMS+ioQtV2OlMW5b5haDX02799tBMgtMoBeq63h
 gGYTnoNM4hkrHtZe0V8YX+dLkyk9jcGnpCeUZrosYbxTAWWAleeLCbrCt89TQUHPd3FZCu1
 6GMRmGXjDwEjWGQryHmqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GAUhaUQS64Y=:TfisO7NZmspPfYWKgczycF
 Xq7bhlN0njmVe5OTw89Nd43L0CH6kix9STHnWoLI5R7u4wJyFpAfggIOGqlqcElfP4L+tOyQY
 swWXgTRp6qjm4DzFYNo7NXZRqDntK10BRjsnRxPVqElcDCYigTHZvgmqD/terzMRrPiktwMkx
 IwnrlOo1K433eBkQbskpn5rv8j66Q/YHardX+4Ei9iz/A0TkINVqMbzu7IVyHAFJpdNNmZjWh
 Tw1L0e/juB1PVAr4sMTzGlXzikJNcn7EQPbEjDOsRvQAVUbwyptBRtDPeDc86Qg0iRnIhSZVy
 QbYNAofjR1xqghYTYMefJd5ViboGWRDsBKp6aHYp4EHDsmDZh1kMUErKs5x5r2zDZjKOGnYQ0
 Ms5HwAkq6SLdMNJUKijllQcMiA+rx0LM6Or0Joo9jjWhnoZ745HZxHTWDOwg6jcT0LmzwVJgA
 vYwp4lzLgVDbl2uIUZaLJFqZmcBSgVTyBSHF07BJ+xfUnT+dTj+9bTfUOO04yf75Nz6iDYrBg
 YUuVaw2OONcXYhq1ju0HLAfLUUt5vgy0gDoyIE8dF/n4CSvgH5JbG9NoV9aRXQM8isxeoudCk
 CUpZLUiDVjazZkMaQkcZ8/iIJoNfe64xZgg+UdcmE4BDUwdqIwn99xLgbNIg/iUJBUCaI9G3N
 rWPSkoZ7ysiYX+C3L1qFlVpitPfBgELKnfGZ68ZK3WPWmMF5sr2gbAuI55Fc26hBFTvwZEnZm
 0/eSjt4u2VJy/ugYx0Sw6cA7OCyVoTPegciV5zQgpqP9Ovz0bYMc3BDPNJsRFDzpX7CWXkBhp
 hcXNB08MBYkjhUtMmKFx5R+dv25WC3lqgs1IyccpwfwOQITnIvsGFAJlRnK52enDwKnFECk2r
 8F3GEyVh9jv3iZnGju65GjmljJD4wHgVEddPFwvfSc25VGfdZeoPdZxOlF7QaeGoIy3x8c1h+
 dWvyD8AEgJGYfMerf8jYvdy4gSzouGkZbUpxQwyM96JRkLo6uTFnPCoCVvIKD4XQGXxG6tf74
 wupk7eB7LiG1Ggl/xMO+K7SSkkszta99Fobbx031mPGJR6AUAd7VjhmZ1Gjrj1G3o46WzMsJ/
 VE5YevZBXJjPfhkcRreRZBniF6C9lkLbDJ61YeU7QjDNZ1orn7yE+DE1daSmpz1l8sX29LDNO
 U877NYaKXkPcGDWQMzjGO+yxS8Dpvbojl+XrNnjy5w65svlXZWv28f7h7XKFwsry6a3pRND76
 oBZNAizPx8LrnfCkJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QZLQ01BBZS8j8HRI5NQorTuxewWQSFnOr
Content-Type: multipart/mixed; boundary="59iLDf4UBaXBQxI9VOogWjAClY5sAnCxj"

--59iLDf4UBaXBQxI9VOogWjAClY5sAnCxj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/4 =E4=B8=8A=E5=8D=884:44, Josef Bacik wrote:
> Add another comment to cover how the space reservation system works
> generally.  This covers the actual reservation flow, as well as how
> flushing is handled.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 128 ++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 128 insertions(+)
>=20
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d3befc536a7f..6de1fbe2835a 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -10,6 +10,134 @@
>  #include "transaction.h"
>  #include "block-group.h"
> =20
> +/*
> + * HOW DOES SPACE RESERVATION WORK
> + *
> + * If you want to know about delalloc specifically, there is a separat=
e comment
> + * for that with the delalloc code.  This comment is about how the who=
le system
> + * works generally.
> + *
> + * BASIC CONCEPTS
> + *
> + *   1) space_info.  This is the ultimate arbiter of how much space we=
 can use.
> + *   There's a description of the bytes_ fields with the struct declar=
ation,
> + *   refer to that for specifics on each field.  Suffice it to say tha=
t for
> + *   reservations we care about total_bytes - SUM(space_info->bytes_) =
when
> + *   determining if there is space to make an allocation.

How about mentioning 3 types of space info: DATA, META, SYS?

And it may be a good timing to also update the comment of
btrfs_space_info::bytes_*?.

> + *
> + *   2) block_rsv's.  These are basically buckets for every different =
type of
> + *   metadata reservation we have.  You can see the comment in the blo=
ck_rsv
> + *   code on the rules for each type, but generally block_rsv->reserve=
d is how
> + *   much space is accounted for in space_info->bytes_may_use.
> + *
> + *   3) btrfs_calc*_size.  These are the worst case calculations we us=
ed based
> + *   on the number of items we will want to modify.  We have one for c=
hanging
> + *   items, and one for inserting new items.  Generally we use these h=
elpers to
> + *   determine the size of the block reserves, and then use the actual=
 bytes
> + *   values to adjust the space_info counters.
> + *
> + * MAKING RESERVATIONS, THE NORMAL CASE
> + *
> + *   Things wanting to make reservations will calculate the size that =
they want
> + *   and make a reservation request.  If there is sufficient space, an=
d there
> + *   are no current reservations pending, we will adjust
> + *   space_info->bytes_may_use by this amount.
> + *
> + *   Once we allocate an extent, we will add that size to ->bytes_rese=
rved and
> + *   subtract the size from ->bytes_may_use.  Once that extent is writ=
ten out we
> + *   subtract that value from ->bytes_reserved and add it to ->bytes_u=
sed.

Lifespan! And definitely a graph would be easier to read, with less words=
=2E

> + *
> + *   If there is an error at any point the reserver is responsible for=
 dropping
> + *   its reservation from ->bytes_may_use.
> + *
> + * MAKING RESERVATIONS, FLUSHING
> + *
> + *   If we are unable to satisfy our reservation, or if there are pend=
ing
> + *   reservations already, we will create a reserve ticket and add our=
selves to
> + *   the appropriate list.  This is controlled by btrfs_reserve_flush_=
enum.  For
> + *   simplicity sake this boils down to two cases, priority and normal=
=2E

This is the core of the whole ticketing space rsv system.
Definitely needs something like objective (to get some free space),
entrance functions.

> + *
> + *   1) Priority.  These reservations are important and have limited a=
bility to
> + *   flush space.  For example, the relocation code currently tries to=
 make a
> + *   reservation under a transaction commit, thus it cannot wait on an=
ything
> + *   that may want to commit the transaction.  These tasks will add th=
emselves
> + *   to the priority list and thus get any new space first, and then t=
hey can
> + *   flush space directly in their own context that is safe for them t=
o do
> + *   without causing a deadlock.
> + *
> + *   2) Normal.  These reservations can wait forever on anything, beca=
use the do
> + *   not hold resources that they would deadlock on.  These tickets si=
mply go to
> + *   sleep and start an async thread that will flush space on their be=
half.
> + *   Every time one of the ->bytes_* counters is adjusted for the spac=
e info, we
> + *   will check to see if there is enough space to satisfy the request=
s (in
> + *   order) on either of our lists.  If there is enough space we will =
set the
> + *   ticket->bytes =3D 0, and wake the task up.  If we flush a few tim=
es and fail
> + *   to make any progress we will wake up all of the tickets and fail =
them all.
> + *
> + * THE FLUSHING STATES
> + *
> + *   Generally speaking we will have two cases for each state, a "nice=
" state
> + *   and a "ALL THE THINGS" state.  In btrfs we delay a lot of work in=
 order to
> + *   reduce the locking over head on the various trees, and even to ke=
ep from
> + *   doing any work at all in the case of delayed refs.  Each of these=
 delayed
> + *   things however hold reservations, and so letting them run allows =
us to
> + *   reclaim space so we can make new reservations.

So, it's just some delayed works which can free space if run.
The last sentence looks sufficient to me.

> + *
> + *   FLUSH_DELAYED_ITEMS
> + *     Every inode has a delayed item to update the inode (item).

The best explanation. This one sentence is enough to solve my question
on what delayed items are.

>  Take a simple write
> + *     for example, we would update the inode item at write time to up=
date the
> + *     mtime, and then again at finish_ordered_io() time in order to u=
pdate the
> + *     isize or bytes.  We keep these delayed items to coalesce these =
operations
> + *     into a single operation done on demand.  These are an easy way =
to reclaim
> + *     metadata space.
> + *
> + *   FLUSH_DELALLOC
> + *     Look at the delalloc comment to get an idea of how much space i=
s reserved
> + *     for delayed allocation.  We can reclaim some of this space simp=
ly by
> + *     running delalloc, but usually we need to wait for ordered exten=
ts to
> + *     reclaim the bulk of this space.
> + *
> + *   FLUSH_DELAYED_REFS
> + *     We have a block reserve for the outstanding delayed refs space,=
 and every
> + *     delayed ref operation holds a reservation.  Running these is a =
quick way
> + *     to reclaim space, but we want to hold this until the end becaus=
e COW can
> + *     churn a lot and we can avoid making some extent tree modificati=
ons if we
> + *     are able to delay for as long as possible.
> + *
> + *   ALLOC_CHUNK
> + *     We will skip this the first time through space reservation, bec=
ause of
> + *     overcommit and we don't want to have a lot of useless metadata =
space when
> + *     our worst case reservations will likely never come true.
> + *
> + *   RUN_DELAYED_IPUTS

Although I guess we all know what delayed iput is doing, one line
explanation would definitely help.

> + *     If we're freeing inodes we're likely freeing checksums, file ex=
tent
> + *     items, and extent tree items.  Loads of space could be freed up=
 by these
> + *     operations, however they won't be usable until the transaction =
commits.
> + *
> + *   COMMIT_TRANS
> + *     may_commit_transaction() is the ultimate arbiter on wether we c=
ommit the
> + *     transaction or not.  In order to avoid constantly churning we d=
o all the
> + *     above flushing first and then commit the transaction as the las=
t resort.
> + *     However we need to take into account things like pinned space t=
hat would
> + *     be freed, plus any delayed work we may not have gotten rid of i=
n the case
> + *     of metadata.

All these comments make sense, it would be fantastic if we can reduce
the number of lines though.

Thanks for all these comments, they really help,
Qu

> + *
> + * OVERCOMMIT
> + *   Because we hold so many reservations for metadata we will allow y=
ou to
> + *   reserve more space than is currently free in the currently alloca=
te
> + *   metadata space.  This only happens with metadata, data does not a=
llow
> + *   overcommitting.
> + *
> + *   You can see the current logic for when we allow overcommit in
> + *   btrfs_can_overcommit(), but it only applies to unallocated space.=
  If there
> + *   is no unallocated space to be had, all reservations are kept with=
in the
> + *   free space in the allocated metadata chunks.
> + *
> + *   Because of overcommitting, you generally want to use the
> + *   btrfs_can_overcommit() logic for metadata allocations, as it does=
 the right
> + *   thing with or without extra unallocated space.
> + */
> +
>  u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
>  			  bool may_use_included)
>  {
>=20


--59iLDf4UBaXBQxI9VOogWjAClY5sAnCxj--

--QZLQ01BBZS8j8HRI5NQorTuxewWQSFnOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl45Q/oACgkQwj2R86El
/qhmYQf9HcjGf9+4+Q7SnL9jh858ECq8Y7NEg3UMTVqQ1TgExzVDpmysKw3XngWO
lGyJRVCqzHn1aEr97XIes0fVYqYRno77TPvO3ffqGKfLdUNlvs4vDX3FXwyP2fJJ
qF3BDd/90QsVYqaMiakr941IdtdSewU+EfpP+VE6quQriQ4o7BgK/DLRBZB/nPvG
026JSnIjGZewkFlT2NoLz5d9N3MQcJu16lpVArIhtUOAFS/TFie9Xf2QIsP+eRY3
1DgalB1Lg3vGIzK0o8kUrumsYkzZ/WfHW4JZ0aqwzEBaR9s+Vxz5lxenpzhxSEke
a/9TKW8Cs+Mmvin4+Ca5SLEfLqmCVw==
=ouGB
-----END PGP SIGNATURE-----

--QZLQ01BBZS8j8HRI5NQorTuxewWQSFnOr--

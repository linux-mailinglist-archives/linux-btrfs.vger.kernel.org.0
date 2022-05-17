Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81929529B81
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiEQHxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiEQHxp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:53:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174264968A
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652774006;
        bh=jP0J1510B+REt1SUNKiYSxp84O5uPhyJPDjKsGOK+IA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=IrM/lBXoTpGrkUUDGp+i0DxfNRjGcUSm+nG2h2h6WuJk4TTNkCswd4Stab97IMZCY
         xk9AUdYAv+AKZUACR4/xhYPPybYM2tWNqLMMQUJ/UYZv3st0pTJNmZGYywbqi1iqXD
         HsEUieMFVCTc0LFKgArElzkLr9B/RxLr943edcYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1nPp3e2rvH-00j2vb; Tue, 17
 May 2022 09:53:26 +0200
Message-ID: <a7c330e8-9162-9be7-1b12-18e4b218f02b@gmx.com>
Date:   Tue, 17 May 2022 15:53:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC ONLY 4/8] btrfs: add boilerplate code to insert raid extent
In-Reply-To: <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BC5D9Mgw0rhxWmjeLP8TPsa1MD00vm0/Y5el1PnpfIi+UQY4tSK
 YAsOyxnMZBaXeFO3FMcUxLzeEu6L6p9neuUc8vi9dCiPNZhUJP66QEP/iWdxBilrDdRv+8J
 I7gjKU+bBc388HOXMP6i7q2xf3e3U08CfOKx/rk3yODRjWD8IEsbfDw20lfYNrLBFqz3EwD
 uR1vPxYGncse9f0Ca30yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7pdrKaMAlWY=:DzoqL3ShV+XJBdi2Kz9IFf
 X/XlmSX/nGot+QEU0MlLWuj9jnHQYGwRNl/beqD+mtLefseJDdGtgS3BzJQ6v24i4f1k8+tVQ
 JZVXyszGOW++udveMjvxLnv5VeaH4snui6ceSyDtmSO15tzmEPtji6qA+gLwEmXnagdXVecDK
 ud+LPOgQvmkpSHiqDZdHnkncv4VAxJQo/LJkWeMFs/TrUdarron5Qw3gv8/3++88KpWMqaDNg
 H3FrT7p5u2/wcOGYxPa8rnF+bTfnee8UjEJKxv7Xxu6g3J7Xyp/TPWw8K9c7eCcsjkQDTY1nK
 JGXFQGf1NlBwGXYsPOG3qKaEvTqBpZEmTC8/jcD5Mhrl1gADTOxtyfXXB5IV57AQofK74yLFf
 y1mWPOsu542SNLMpKvnar2EYhg3ld1fXV2XA1J2uwOek0mRtK3HJQxKEjkG/27qnrsbexUlIM
 xhbsCjMn7OX8antSj5yh9OAP1FLNi/MGR4vdCwT6ESdN3bzrlMCYvgSFXPiViwlomRRqck/Mz
 cq+hCw6ZPjufAT6SwKBGXTUDCCVcj8dTWb2tnRtFY4qQRBSjvhC4NNg0LSAXfMm375bjbiZ6d
 ZY82bANkvIsWXje6/0ZkFSFaPkVF3VYK7q5gGaEubXiulTnjvsMC5iaIhs1erxt1VVaFSTGF9
 KjxY29DMkyP8U/cUkDFK6VzASa0wVBs4hl/mNqeMJuTmPJ/yQGSskpHgEOi/vXopjDR+e4Zzr
 yi4BpGi0qsp5Qj3vKDg6ANOqXen3TH1z3vnIHezSbfMYo7PrW5e2v6oYuNnh0n0MoqFas9s8g
 kZnuxl5UpKfqjcGOfJtQmAJixWKOw1KSg3wVEObRlAUqJ7PVmoXPO4kIWc0T+dVCI89Cvx6Db
 9S9gHmrN2Xpezet8W72xLs4+PiJeV3ibDfHZ60GJhvKgn0oLi951Gx3jmTMIYIJTKd6XeP7Ki
 172ohJ1cYgLJRU1rNKIt7ySPXkKl/pxI179N6rLLrVIFKDWGDTQsE46C99Q6YXnQ/G2+WYVI8
 b0bHP9bDECY9Jnhil3I7zBvDetOWjNK50XdsiG2qCi6wKSEpn3jwKiIPENo1M96FqAp9Ei/z8
 F02Q9/N7FtGmGU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/16 22:31, Johannes Thumshirn wrote:
> Add boilerplate code to insert raid extents into the raid-stripe-tree on
> each write to a RAID1 block-group.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/Makefile           |  2 +-
>   fs/btrfs/raid-stripe-tree.c | 72 +++++++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h | 28 +++++++++++++++
>   fs/btrfs/volumes.c          | 21 +++++++++++
>   fs/btrfs/volumes.h          |  3 ++
>   5 files changed, 125 insertions(+), 1 deletion(-)
>   create mode 100644 fs/btrfs/raid-stripe-tree.c
>   create mode 100644 fs/btrfs/raid-stripe-tree.h
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 4188ba3fd8c3..6b9a00ad532a 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -30,7 +30,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.=
o root-tree.o dir-item.o \
>   	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o =
\
>   	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> -	   subpage.o tree-mod-log.o
> +	   subpage.o tree-mod-log.o raid-stripe-tree.o
>
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o
>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) +=3D check-integrity.o
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> new file mode 100644
> index 000000000000..426066bd7c0d
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "ctree.h"
> +#include "transaction.h"
> +#include "disk-io.h"
> +#include "raid-stripe-tree.h"
> +#include "volumes.h"
> +
> +static void btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +				     struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_root *stripe_root =3D fs_info->stripe_root;
> +	struct btrfs_dp_stripe *raid_stripe;
> +	struct btrfs_stripe_extent *stripe_extent;
> +	size_t item_size;
> +	int ret;
> +	int i;
> +
> +	item_size =3D sizeof(struct btrfs_dp_stripe) - sizeof(struct btrfs_str=
ipe_extent) +
> +		bioc->num_stripes * sizeof(struct btrfs_stripe_extent);
> +
> +	raid_stripe =3D kzalloc(item_size, GFP_NOFS);
> +	if (!raid_stripe) {
> +		btrfs_abort_transaction(trans, -ENOMEM);
> +		return;
> +	}
> +
> +	stripe_extent =3D &raid_stripe->extents;
> +	for (i =3D 0; i  < bioc->num_stripes; i++) {
> +		u64 devid =3D bioc->stripes[i].dev->devid;
> +		u64 physical =3D bioc->stripes[i].physical;
> +
> +		btrfs_set_stack_stripe_extent_devid(stripe_extent, devid);
> +		btrfs_set_stack_stripe_extent_offset(stripe_extent, physical);
> +		stripe_extent++;
> +	}
> +
> +	stripe_key.objectid =3D bioc->logical;
> +	stripe_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset =3D bioc->length;
> +
> +	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, raid_stripe=
,
> +				item_size);
> +	if (ret) {
> +		kfree(raid_stripe);
> +		btrfs_abort_transaction(trans, ret);
> +		return;
> +	}
> +
> +	kfree(raid_stripe);
> +}
> +
> +void btrfs_raid_stripe_tree_fn(struct work_struct *work)
> +{
> +	struct btrfs_io_context *bioc;
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_root *root;
> +	struct btrfs_trans_handle *trans =3D NULL;
> +
> +	bioc =3D container_of(work, struct btrfs_io_context, stripe_update_wor=
k);
> +	fs_info =3D bioc->fs_info;
> +	root =3D fs_info->stripe_root;
> +
> +	trans =3D btrfs_join_transaction(root);
> +
> +	btrfs_insert_raid_extent(trans, bioc);
> +	btrfs_end_transaction(trans);
> +
> +	btrfs_put_bioc(bioc);
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> new file mode 100644
> index 000000000000..320a110ecc66
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_RAID_STRIPE_TREE_H
> +#define BTRFS_RAID_STRIPE_TREE_H
> +
> +#include "volumes.h"
> +
> +void btrfs_raid_stripe_tree_fn(struct work_struct *work);
> +
> +static inline bool btrfs_need_stripe_tree_update(struct btrfs_io_contex=
t *bioc)
> +{
> +	u64 type =3D bioc->map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
> +	u64 profile =3D bioc->map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
> +
> +	if (!bioc->fs_info->stripe_root)
> +		return false;
> +
> +	// for now
> +	if (type !=3D BTRFS_BLOCK_GROUP_DATA)
> +		return false;

OK, for now it's indeed excluding metadata/sys chunks from stripe tree.

That's fine for now.

But this really brings the problem of bootstrap, thus I'm afraid that we
may not support metadata/data for stripe tree mapped chunks forever.


This also brings a new problem to us, if we plan to make stripe tree
work for metadata/sys, despite the bootstrap problem, we also need to
determine if stripe tree is something global, or per-chunk.

a) Global switch for stripe tree

If global, then every data chunk needs to be stripe-mapped, or we build
a complex stripe-tree supported chunk type list.

In fact, currently the btrfs_need_stripe_tree_update() is already doing
that.

Without a proper on-disk indicate, we can never really do stable support
for new stripe-tree support on other profiles.

b) Per-chunk type stripe tree

Then we need an extra type/flag for chunks/block groups to indicate that
any read/write into the chunk needs stripe tree update.

This allows us to support different chunk types with stripe tree, but
needs more complex on-disk change, other than just a simple global flag.

Thanks,
Qu

> +
> +	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
> +		return true;
> +
> +	return false;
> +}
> +
> +#endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3fd17e87815a..36acef2ae5d8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -33,6 +33,7 @@
>   #include "block-group.h"
>   #include "discard.h"
>   #include "zoned.h"
> +#include "raid-stripe-tree.h"
>
>   #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
>   					 BTRFS_BLOCK_GROUP_RAID10 | \
> @@ -5917,6 +5918,7 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   	bioc->fs_info =3D fs_info;
>   	bioc->tgtdev_map =3D (int *)(bioc->stripes + total_stripes);
>   	bioc->raid_map =3D (u64 *)(bioc->tgtdev_map + real_stripes);
> +	INIT_WORK(&bioc->stripe_update_work, btrfs_raid_stripe_tree_fn);
>
>   	return bioc;
>   }
> @@ -6677,6 +6679,17 @@ static void btrfs_end_bio(struct bio *bio)
>   		}
>   	}
>
> +	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> +		int i;
> +
> +		for (i =3D 0; i < bioc->num_stripes; i++) {
> +			if (bioc->stripes[i].dev->bdev !=3D bio->bi_bdev)
> +				continue;
> +			bioc->stripes[i].physical =3D bio->bi_iter.bi_sector << SECTOR_SHIFT=
;
> +		}
> +	}
> +
> +
>   	if (bio =3D=3D bioc->orig_bio)
>   		is_orig_bio =3D 1;
>
> @@ -6700,6 +6713,12 @@ static void btrfs_end_bio(struct bio *bio)
>   			 * go over the max number of errors
>   			 */
>   			bio->bi_status =3D BLK_STS_OK;
> +
> +			if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE &&
> +			    btrfs_need_stripe_tree_update(bioc)) {
> +				btrfs_get_bioc(bioc);
> +				schedule_work(&bioc->stripe_update_work);
> +			}
>   		}
>
>   		btrfs_end_bioc(bioc, bio);
> @@ -6788,6 +6807,8 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   	bioc->orig_bio =3D first_bio;
>   	bioc->private =3D first_bio->bi_private;
>   	bioc->end_io =3D first_bio->bi_end_io;
> +	bioc->logical =3D logical;
> +	bioc->length =3D length;
>   	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
>
>   	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 894d289a3b50..4b4235b4432a 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -68,6 +68,9 @@ struct btrfs_io_context {
>   	int mirror_num;
>   	int num_tgtdevs;
>   	int *tgtdev_map;
> +	u64 logical;
> +	u64 length;
> +	struct work_struct stripe_update_work;
>   	/*
>   	 * logical block numbers for the start of each stripe
>   	 * The last one or two are p/q.  These are sorted,

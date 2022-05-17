Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434D529BA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiEQIBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiEQIA5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:00:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA912636
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652774450;
        bh=9SoheUVmuLGLFStrikvhVBAHSizBwV6Nnt4T5Z750Bk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fvuiiSKqo11qr5FaHz9A8/FZBXidYH6rnfw4/iI2P4AeLyR0xoEvyz2wZ3ORVkwj6
         osJdL8pRftN+QxiVSSeef7eCyN1z9X4B6r2y5fKBIgeyqUq2W4LFB+G0nwWtvjLaBb
         Qtu5ckNIY4BwmDsvysxK61cIkCA3QR6dmN9JJlvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybGX-1ngku42lPZ-00ywzo; Tue, 17
 May 2022 10:00:50 +0200
Message-ID: <bc94b2bf-4c29-d436-be18-da4e64f0fc18@gmx.com>
Date:   Tue, 17 May 2022 16:00:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 4/8] btrfs: add boilerplate code to insert raid extent
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tHURCVfShyUMjaHegvcHF89Ri8KhWRz4P3wtVhJVtD3A67DQ2Mx
 naCvPLR9gfaz8+jytp8bU7EWy4knqvZJBJFTLN3Vrk2mDSd2CatfwC2FcDNxJ4Nft1Su9VX
 /YXT2VblaTWm/ah69su88ftk2PBx6kgvoOI152zmjKOdJyB349IApPH46XDQU90vw8Iy4Jx
 AlsujpARJjKoweuCpi90w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JlpdCvWBs5Q=:D9dRjdTaj78WRRj0e3Dkxj
 cnKh0v6uG7WYJo37vruXfjTuk+3pQBlLihSxlgkhf4Ug9tbDYJyaGMdI4pqgtmnYf29yh4iO8
 Zq0Hax4W1vc2pqo2L+FHvrdppL6vd7v0vnwaVBipRUgdLFnh7x//DKMF6V/OOF4i99Z0000p7
 esOh000nqOUTk23BdKDpWl5XdC4PMH2g68VP/hdGNx7wdI4oxVC0i+pgQvdPT4ApnXAaWfKw/
 gfEV2lzjZqlCsuch4fXNpf7bWBbzwNonkXBIfUqXHJuR7Vfd4knW5eLReYRUz5V3sFC8PVUlm
 c7Zq69Rl0SHUoMtSfNE4gGRX8qJ3S8Tkhb0zLCKJJGQD+VytOYoUHFQCBjwoQpNT1ty/s6rfQ
 ijA1jdInjjUKTrfMcbMcVJQ8T9NBSJQrqxCGy7LRCWYJWDPULUwONk/IIiuMYKJcosZICZkLp
 BlnANPHEAapJPzBRwts6yoR8JHPfI9Y5J7cXFeqLYLxx7NSZ1PX5HSrNj95bS8tBvCJCBUVcN
 dF3h137qQTvg4KJIMlG0ikilMJctQ3vTPYfzW5L+WS+6DTQMhsXcrmNcpZXyFB6eYU+KBZpGW
 /742q/SFJ7mMpo7lO7XQgln1WhgHlF8yBD3gwCgdtQ6KLNMg9toriyyuMaRMYaM+4H8Fbpolm
 EMIGytK9ORvcFrl47GhAo8zjuFKDHSlQ8tEp35OO/dwmjgsxPnHW6YHD5JVY9sAaQf67Zu34I
 4qzziJjWtt1ww/4XKyfmIRzpVTN/2avAw5bjQj+jc9SJ3e6ltbkNQNg+WV99yz70iKhQ2uMdQ
 0peroHpnYhxLqvWxEeOdf+DvkzpKhtrgIH4YP09BBy5SiWhiGVD8gb8IPzjW3L3dp9TJNYSog
 yuBu/XRDgkLPWrHKq0ZVaggoRfuYL6/mCR/0WP6mf0iOESQ6QP9tz51qgQzgm1pYp4+QytMDP
 Tp16ZFQc+5T36YQxJEEtewsW4eVpIUTBbp3RXbGlGupHuPZ7/o1PaBnPJKKenAJtykMGAzdLP
 rHndtO0HqVVmOPzCIcesT+7lCDuQVFB3rIrfGNNbGb65AFhYlpFhcALlylWSCZmK6qJOSK5ea
 wn5zpmfdKvrVhE=
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

Considering the stripe tree should be a 1:1 map for file extents, can't
we do it in btrfs_finish_ordered_io()?

Thanks,
Qu

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

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0D7A1298
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 02:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjIOAzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 20:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIOAzf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 20:55:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5626B8;
        Thu, 14 Sep 2023 17:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694739315; x=1695344115; i=quwenruo.btrfs@gmx.com;
 bh=zgvJvCBGJ6wxCa+/riP5RT+ZvbZx9rU5uIeSqocmlPI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lv+yqyDRSOyviBa4U4Zs/bOsB2xOdFowj9rjTnf0HfNWqtLvwH1STbWMzWEs2BlfkRojo7EVqqm
 qVOXbl9NXXpQCeXd+jgEFeWR959+Mh4LDh9y08rd0dlz7xDNPpUyKReenmUsBMc5+ai0w26mOnYHI
 Fblz4K5q39tcOlASxw7ESjkgfhhJ6+gbgk0xfhiTGOxad5/eJWgHYDjdxwNzmbP3IeJxHdflba18Z
 2WwBEm+n9CprweeWuUudzz2vFekDVWuOxe10Oy+d1aVbaFCTVnDOp9VLHw+jWwc8iC+uZ/mgSscAn
 umVL8vhBLwAKAll3VeicQwOzL0tB5gtbgKoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.27.112.223] ([154.6.151.156]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1rkJIO2q94-014llP; Fri, 15
 Sep 2023 02:55:15 +0200
Message-ID: <ca55e159-3ce0-491f-9fc3-fdcbab2bcb05@gmx.com>
Date:   Fri, 15 Sep 2023 10:25:09 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/11] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-3-15d423829637@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230914-raid-stripe-tree-v9-3-15d423829637@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/efh/nQBMRMNM8oK2uz852bqvvLQJL1W7OoSZp56etHxaXjOz66
 Nea0GUhGm2M01Csi6o2gOTVyBO4u+z5ZSaI3znz2+cG8QE/4QkmtJsOSClJk25yxusYsL2D
 DIFUOyaIfdCxmSH90YR+m+M3pqbBLNlDYZkUG9t/FCZzb4ZgktxHJy+ykfKQbxl4bXJS58Z
 Kq4kcolMiH3l74sIm3Jlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kwSikT+wcgM=;4Wyt2HI54hpVk14IduEcM0szyCR
 Hks+6tl4UuQRsut3mdGDZDnGu1uTSmZhISwoWrz2c9TCvGpYmVp95WFbw5rPSAf4ZLDnClrjJ
 3+Jui41TD0YETkFYEOv3z6RvhOglEp4+wjO53l71P47Y1b8d2oGH+EWQ5a2UbnEDRWgt2nkXp
 WEQpcZDp0gWpwUE5JTS3XOkCnRHImS5Ot3o31+2uySav5JWSc/1ESLtIVlZQIpdl9sLyQTcb3
 fXtPdIyi0EzVBv1TE71v7Vva65wbO+v91WtrGV9hGLQ3I9ZdQF6jsEfpQ3b6YSw7er7nUlGQi
 n/vwaqMpVMMykSe1hOf3HidMJuwOiSR43asKgpKSmcLce0KwfxlRBVg3w/pox1hbK5mixcyVa
 h3HF4Hs8d92ktMsR1aNcqb48NtrsuZ8r+fu3mMBrWSgNpzx4zQR3Id3LlBmEWwoZNgjWznlNd
 0wNmIdhxJRt58YCIkizVNm7QwP2wkKQrkC92Askhclh5E62rivYb6BMEFP/3HGT8H1WqqjI/K
 Dbs/CKEhjwevMFvXC0D1vBbMEl3KAv/Vk/IBdbMrTEvYt4pI0Zth8E8RUjApt4x+0zdgMGmJO
 bQoKU79B6tPXcpTl1Va7ETBzmLLLkLhPuXThTsKlWWn2+wbYYipyjhEKuj7mLUVSghezLH2jU
 U/kyjiqJf3NHW417gnZCc6i1AbUWoTLR+Igx2UkqAGyE8ztrUyzourGVqdrqI5VlEaZxHmVa+
 AlO9gAjt0M0iAZ0VCzYLWNdbiiFjFKyysejzgxA4Q0scEJO99oFo1+wo4NpzQqXQ3jTkun1IG
 YSIO2deRo3OTXG8hBxFPlzESy3py7NWmNcPyBPk75Bs8DJdhXxHm3eRaaauqdYKNnhSkwAPUp
 BGq3W/CVnvhRjyS82R/3QoAK/G4C0P/3WyTlAy5+IkpYEAnZ4JPg3rqPmb/h9OrxUEqzf6JY+
 Utv62jkdrDX3F1gDefxmM2QEGSw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/15 01:36, Johannes Thumshirn wrote:
> Add support for inserting stripe extents into the raid stripe tree on
> completion of every write that needs an extra logical-to-physical
> translation when using RAID.
>
> Inserting the stripe extents happens after the data I/O has completed,
> this is done to a) support zone-append and b) rule out the possibility o=
f
> a RAID-write-hole.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/Makefile           |   2 +-
>   fs/btrfs/bio.c              |  23 +++++
>   fs/btrfs/extent-tree.c      |   1 +
>   fs/btrfs/inode.c            |   8 +-
>   fs/btrfs/ordered-data.c     |   1 +
>   fs/btrfs/ordered-data.h     |   2 +
>   fs/btrfs/raid-stripe-tree.c | 245 ++++++++++++++++++++++++++++++++++++=
++++++++
>   fs/btrfs/raid-stripe-tree.h |  34 ++++++
>   fs/btrfs/volumes.c          |   4 +-
>   fs/btrfs/volumes.h          |  15 +--
>   10 files changed, 326 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index c57d80729d4f..525af975f61c 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -33,7 +33,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.=
o root-tree.o dir-item.o \
>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o =
\
>   	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
>   	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
> -	   lru_cache.o
> +	   lru_cache.o raid-stripe-tree.o
>
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o
>   btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) +=3D ref-verify.o
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 31ff36990404..ddbe6f8d4ea2 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -14,6 +14,7 @@
>   #include "rcu-string.h"
>   #include "zoned.h"
>   #include "file-item.h"
> +#include "raid-stripe-tree.h"
>
>   static struct bio_set btrfs_bioset;
>   static struct bio_set btrfs_clone_bioset;
> @@ -415,6 +416,9 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>   	else
>   		bio->bi_status =3D BLK_STS_OK;
>
> +	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND && !bio->bi_status)
> +		stripe->physical =3D bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +
>   	btrfs_orig_bbio_end_io(bbio);
>   	btrfs_put_bioc(bioc);
>   }
> @@ -426,6 +430,8 @@ static void btrfs_clone_write_end_io(struct bio *bio=
)
>   	if (bio->bi_status) {
>   		atomic_inc(&stripe->bioc->error);
>   		btrfs_log_dev_io_error(bio, stripe->dev);
> +	} else if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> +		stripe->physical =3D bio->bi_iter.bi_sector << SECTOR_SHIFT;
>   	}
>
>   	/* Pass on control to the original bio this one was cloned from */
> @@ -487,6 +493,7 @@ static void btrfs_submit_mirrored_bio(struct btrfs_i=
o_context *bioc, int dev_nr)
>   	bio->bi_private =3D &bioc->stripes[dev_nr];
>   	bio->bi_iter.bi_sector =3D bioc->stripes[dev_nr].physical >> SECTOR_S=
HIFT;
>   	bioc->stripes[dev_nr].bioc =3D bioc;
> +	bioc->size =3D bio->bi_iter.bi_size;
>   	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
>   }
>
> @@ -496,6 +503,8 @@ static void __btrfs_submit_bio(struct bio *bio, stru=
ct btrfs_io_context *bioc,
>   	if (!bioc) {
>   		/* Single mirror read/write fast path. */
>   		btrfs_bio(bio)->mirror_num =3D mirror_num;
> +		if (bio_op(bio) !=3D REQ_OP_READ)
> +			btrfs_bio(bio)->orig_physical =3D smap->physical;
>   		bio->bi_iter.bi_sector =3D smap->physical >> SECTOR_SHIFT;
>   		if (bio_op(bio) !=3D REQ_OP_READ)
>   			btrfs_bio(bio)->orig_physical =3D smap->physical;
> @@ -688,6 +697,20 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bb=
io, int mirror_num)
>   			bio->bi_opf |=3D REQ_OP_ZONE_APPEND;
>   		}
>
> +		if (is_data_bbio(bbio) && bioc &&
> +		    btrfs_need_stripe_tree_update(bioc->fs_info,
> +						  bioc->map_type)) {
> +			/*
> +			 * No locking for the list update, as we only add to
> +			 * the list in the I/O submission path, and list
> +			 * iteration only happens in the completion path,
> +			 * which can't happen until after the last submission.
> +			 */
> +			btrfs_get_bioc(bioc);
> +			list_add_tail(&bioc->ordered_entry,
> +				      &bbio->ordered->bioc_list);
> +		}
> +
>   		/*
>   		 * Csum items for reloc roots have already been cloned at this
>   		 * point, so they are handled as part of the no-checksum case.
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index cb12bfb047e7..959d7449ea0d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -42,6 +42,7 @@
>   #include "file-item.h"
>   #include "orphan.h"
>   #include "tree-checker.h"
> +#include "raid-stripe-tree.h"
>
>   #undef SCRAMBLE_DELAYED_REFS
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e02a5ba5b533..b5e0ed3a36f7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -71,6 +71,7 @@
>   #include "super.h"
>   #include "orphan.h"
>   #include "backref.h"
> +#include "raid-stripe-tree.h"
>
>   struct btrfs_iget_args {
>   	u64 ino;
> @@ -3091,6 +3092,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered=
_extent *ordered_extent)
>
>   	trans->block_rsv =3D &inode->block_rsv;
>
> +	ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
> +	if (ret)
> +		goto out;
> +
>   	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
>   		compress_type =3D ordered_extent->compress_type;
>   	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
> @@ -3224,7 +3229,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>   int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
>   {
>   	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
> -	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
> +	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags) &&
> +	    list_empty(&ordered->bioc_list))
>   		btrfs_finish_ordered_zoned(ordered);
>   	return btrfs_finish_one_ordered(ordered);
>   }
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 345c449d588c..55c7d5543265 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -191,6 +191,7 @@ static struct btrfs_ordered_extent *alloc_ordered_ex=
tent(
>   	INIT_LIST_HEAD(&entry->log_list);
>   	INIT_LIST_HEAD(&entry->root_extent_list);
>   	INIT_LIST_HEAD(&entry->work_list);
> +	INIT_LIST_HEAD(&entry->bioc_list);
>   	init_completion(&entry->completion);
>
>   	/*
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 173bd5c5df26..1c51ac57e5df 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -151,6 +151,8 @@ struct btrfs_ordered_extent {
>   	struct completion completion;
>   	struct btrfs_work flush_work;
>   	struct list_head work_list;
> +
> +	struct list_head bioc_list;
>   };
>
>   static inline void
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> new file mode 100644
> index 000000000000..7cdcc45a8796
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/btrfs_tree.h>
> +
> +#include "ctree.h"
> +#include "fs.h"
> +#include "accessors.h"
> +#include "transaction.h"
> +#include "disk-io.h"
> +#include "raid-stripe-tree.h"
> +#include "volumes.h"
> +#include "misc.h"
> +#include "print-tree.h"
> +
> +static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tran=
s,
> +				 int num_stripes,
> +				 struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_root *stripe_root =3D fs_info->stripe_root;
> +	u8 encoding =3D btrfs_bg_flags_to_raid_index(bioc->map_type);
> +	struct btrfs_stripe_extent *stripe_extent;
> +	const size_t item_size =3D struct_size(stripe_extent, strides, num_str=
ipes);
> +	int ret;
> +
> +	stripe_extent =3D kzalloc(item_size, GFP_NOFS);
> +	if (!stripe_extent) {
> +		btrfs_abort_transaction(trans, -ENOMEM);
> +		btrfs_end_transaction(trans);
> +		return -ENOMEM;
> +	}
> +
> +	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
> +	for (int i =3D 0; i < num_stripes; i++) {
> +		u64 devid =3D bioc->stripes[i].dev->devid;
> +		u64 physical =3D bioc->stripes[i].physical;
> +		u64 length =3D bioc->stripes[i].length;
> +		struct btrfs_raid_stride *raid_stride =3D
> +						&stripe_extent->strides[i];
> +
> +		if (length =3D=3D 0)
> +			length =3D bioc->size;
> +
> +		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
> +		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
> +		btrfs_set_stack_raid_stride_length(raid_stride, length);
> +	}
> +
> +	stripe_key.objectid =3D bioc->logical;
> +	stripe_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset =3D bioc->size;
> +
> +	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_exte=
nt,
> +				item_size);
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
> +
> +	kfree(stripe_extent);
> +
> +	return ret;
> +}
> +
> +static int btrfs_insert_mirrored_raid_extents(struct btrfs_trans_handle=
 *trans,
> +				      struct btrfs_ordered_extent *ordered,
> +				      u64 map_type)
> +{
> +	int num_stripes =3D btrfs_bg_type_to_factor(map_type);
> +	struct btrfs_io_context *bioc;
> +	int ret;
> +
> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +		ret =3D btrfs_insert_one_raid_extent(trans, num_stripes, bioc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btrfs_insert_striped_mirrored_raid_extents(
> +				      struct btrfs_trans_handle *trans,
> +				      struct btrfs_ordered_extent *ordered,
> +				      u64 map_type)
> +{
> +	struct btrfs_io_context *bioc;
> +	struct btrfs_io_context *rbioc;
> +	const int nstripes =3D list_count_nodes(&ordered->bioc_list);
> +	const int index =3D btrfs_bg_flags_to_raid_index(map_type);
> +	const int substripes =3D btrfs_raid_array[index].sub_stripes;
> +	const int max_stripes =3D
> +		trans->fs_info->fs_devices->rw_devices / substripes;
> +	int left =3D nstripes;
> +	int i;
> +	int ret =3D 0;
> +	u64 stripe_end;
> +	u64 prev_end;
> +
> +	if (nstripes =3D=3D 1)
> +		return btrfs_insert_mirrored_raid_extents(trans, ordered, map_type);
> +
> +	rbioc =3D kzalloc(struct_size(rbioc, stripes, nstripes * substripes),
> +			GFP_NOFS);
> +	if (!rbioc)
> +		return -ENOMEM;
> +
> +	rbioc->map_type =3D map_type;
> +	rbioc->logical =3D list_first_entry(&ordered->bioc_list, typeof(*rbioc=
),
> +					   ordered_entry)->logical;
> +
> +	stripe_end =3D rbioc->logical;
> +	prev_end =3D stripe_end;
> +	i =3D 0;
> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +
> +		rbioc->size +=3D bioc->size;
> +		for (int j =3D 0; j < substripes; j++) {
> +			int stripe =3D i + j;
> +			rbioc->stripes[stripe].dev =3D bioc->stripes[j].dev;
> +			rbioc->stripes[stripe].physical =3D bioc->stripes[j].physical;
> +			rbioc->stripes[stripe].length =3D bioc->size;
> +		}
> +
> +		stripe_end +=3D rbioc->size;
> +		if (i >=3D nstripes ||
> +		    (stripe_end - prev_end >=3D max_stripes * BTRFS_STRIPE_LEN)) {
> +			ret =3D btrfs_insert_one_raid_extent(trans,
> +							   nstripes * substripes,
> +							   rbioc);
> +			if (ret)
> +				goto out;
> +
> +			left -=3D nstripes;
> +			i =3D 0;
> +			rbioc->logical +=3D rbioc->size;
> +			rbioc->size =3D 0;
> +		} else {
> +			i +=3D substripes;
> +			prev_end =3D stripe_end;
> +		}
> +	}
> +
> +	if (left) {
> +		bioc =3D list_prev_entry(bioc, ordered_entry);
> +		ret =3D btrfs_insert_one_raid_extent(trans, substripes, bioc);
> +	}
> +
> +out:
> +	kfree(rbioc);
> +	return ret;
> +}
> +
> +static int btrfs_insert_striped_raid_extents(struct btrfs_trans_handle =
*trans,
> +				     struct btrfs_ordered_extent *ordered,
> +				     u64 map_type)
> +{
> +	struct btrfs_io_context *bioc;
> +	struct btrfs_io_context *rbioc;
> +	const int nstripes =3D list_count_nodes(&ordered->bioc_list);
> +	int i;
> +	int ret =3D 0;
> +
> +	rbioc =3D kzalloc(struct_size(rbioc, stripes, nstripes), GFP_NOFS);
> +	if (!rbioc)
> +		return -ENOMEM;
> +	rbioc->map_type =3D map_type;
> +	rbioc->logical =3D list_first_entry(&ordered->bioc_list, typeof(*rbioc=
),
> +					   ordered_entry)->logical;
> +
> +	i =3D 0;
> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +		rbioc->size +=3D bioc->size;
> +		rbioc->stripes[i].dev =3D bioc->stripes[0].dev;
> +		rbioc->stripes[i].physical =3D bioc->stripes[0].physical;
> +		rbioc->stripes[i].length =3D bioc->size;
> +
> +		if (i =3D=3D nstripes - 1) {
> +			ret =3D btrfs_insert_one_raid_extent(trans, nstripes, rbioc);
> +			if (ret)
> +				goto out;
> +
> +			i =3D 0;
> +			rbioc->logical +=3D rbioc->size;
> +			rbioc->size =3D 0;
> +		} else {
> +			i++;
> +		}
> +	}
> +
> +	if (i && i < nstripes - 1)
> +		ret =3D btrfs_insert_one_raid_extent(trans, i, rbioc);
> +
> +out:
> +	kfree(rbioc);
> +	return ret;
> +}
> +
> +int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_ordered_extent *ordered_extent)
> +{
> +	struct btrfs_io_context *bioc;
> +	u64 map_type;
> +	int ret;
> +
> +	if (!trans->fs_info->stripe_root)
> +		return 0;
> +
> +	map_type =3D list_first_entry(&ordered_extent->bioc_list, typeof(*bioc=
),
> +				    ordered_entry)->map_type;
> +
> +	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case BTRFS_BLOCK_GROUP_DUP:
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> +		ret =3D btrfs_insert_mirrored_raid_extents(trans, ordered_extent,
> +							 map_type);
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		ret =3D btrfs_insert_striped_raid_extents(trans, ordered_extent,
> +							map_type);
> +		break;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		ret =3D btrfs_insert_striped_mirrored_raid_extents(trans, ordered_ext=
ent, map_type);
> +		break;
> +	default:
> +		btrfs_err(trans->fs_info, "unknown block-group profile %lld",
> +			  map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
> +		ASSERT(0);
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	while (!list_empty(&ordered_extent->bioc_list)) {
> +		bioc =3D list_first_entry(&ordered_extent->bioc_list,
> +					typeof(*bioc), ordered_entry);
> +		list_del(&bioc->ordered_entry);
> +		btrfs_put_bioc(bioc);
> +	}
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> new file mode 100644
> index 000000000000..884f0e99d5e8
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef BTRFS_RAID_STRIPE_TREE_H
> +#define BTRFS_RAID_STRIPE_TREE_H
> +
> +struct btrfs_io_context;
> +struct btrfs_io_stripe;
> +struct btrfs_ordered_extent;
> +struct btrfs_trans_handle;
> +
> +int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
> +			     struct btrfs_ordered_extent *ordered_extent);
> +
> +static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *=
fs_info,
> +						 u64 map_type)
> +{
> +	u64 type =3D map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
> +	u64 profile =3D map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
> +
> +	if (!fs_info->stripe_root)
> +		return false;

I found a corncer case that this can be problematic.

If we have a fs with RST root tree node/leaf corrupted, mounted with
rescue=3Dibadroots, then fs_info->stripe_root would be NULL, and in the
5th patch inside set_io_stripe() we just fall back to regular non-RST path=
.
This would bring us mostly incorrect data (and can be very problematic
for nodatacsum files).

Thus stripe_root itself is not a reliable way to determine if we're at
RST routine, I'd say only super incompat flags is reliable.

And fs_info->stripe_root should only be checked for functions that do
RST tree operations, and return -EIO properly if it's not initialized.

> +
> +	if (type !=3D BTRFS_BLOCK_GROUP_DATA)
> +		return false;
> +
> +	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
> +		return true;

Just a stupid quest, RAID0 DATA doesn't need RST purely because they are
  the same as SINGLE, thus we only update the file items to the real
written logical address, and no need for the extra mapping?

Thus only profiles with duplication relies on RST, right?
If so, then I guess DUP should also be covered by RST.

> +
> +	return false;
> +}
> +#endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a1eae8b5b412..c2bac87912c7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5984,6 +5984,7 @@ static int find_live_mirror(struct btrfs_fs_info *=
fs_info,
>   }
>
>   static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs=
_info *fs_info,
> +						       u64 logical,
>   						       u16 total_stripes)
>   {
>   	struct btrfs_io_context *bioc;
> @@ -6003,6 +6004,7 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   	bioc->fs_info =3D fs_info;
>   	bioc->replace_stripe_src =3D -1;
>   	bioc->full_stripe_logical =3D (u64)-1;
> +	bioc->logical =3D logical;
>
>   	return bioc;
>   }
> @@ -6537,7 +6539,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   		goto out;
>   	}
>
> -	bioc =3D alloc_btrfs_io_context(fs_info, num_alloc_stripes);
> +	bioc =3D alloc_btrfs_io_context(fs_info, logical, num_alloc_stripes);
>   	if (!bioc) {
>   		ret =3D -ENOMEM;
>   		goto out;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 26397adc8706..2043aff6e966 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -390,12 +390,11 @@ struct btrfs_fs_devices {
>
>   struct btrfs_io_stripe {
>   	struct btrfs_device *dev;
> -	union {
> -		/* Block mapping */
> -		u64 physical;
> -		/* For the endio handler */
> -		struct btrfs_io_context *bioc;
> -	};
> +	/* Block mapping */
> +	u64 physical;
> +	u64 length;
> +	/* For the endio handler */
> +	struct btrfs_io_context *bioc;
>   };
>
>   struct btrfs_discard_stripe {
> @@ -428,6 +427,10 @@ struct btrfs_io_context {
>   	atomic_t error;
>   	u16 max_errors;
>
> +	u64 logical;
> +	u64 size;
> +	struct list_head ordered_entry;

Considering this is only utlized by RST, can we rename it to be more
specific?
Like rst_ordered_entry?

Or I'm pretty sure just weeks later I would need to dig to see what this
list is used for.

Thanks,
Qu
> +
>   	/*
>   	 * The total number of stripes, including the extra duplicated
>   	 * stripe for replace.
>

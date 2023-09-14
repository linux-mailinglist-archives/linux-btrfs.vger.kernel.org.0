Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2991079FFED
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjINJZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjINJZ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 05:25:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF0BB;
        Thu, 14 Sep 2023 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694683538; x=1695288338; i=quwenruo.btrfs@gmx.com;
 bh=Wn5OjQ6z0YmbUG6WVEtwMnIvcDQjDXBY9G2XAXDzlOw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OJixUUrqgqNOKWZJa7vhXxWdktgucer58BqkL2k0pw9KaM73kJbRhP/chU4LNmEb+x0F/hrhLFE
 HCHb2CQz2SBoR/SMqfeLJIzQtbm8EiUcOS7ECe8TDH5S1whdNthTqVmiOV1IqvEHww2Dc9Pdy84DQ
 UhCGvJdLlNDtKvfobf+QM9Nn7aPmzKLSJh9vCziCeU2aDwZjF5pF4LL6uYEO9IrcUiKgHBNlYcKXA
 7rGz51secgATlVwM04ZzubsIICeltWe2coT9eekC1JkeRU53HUD16jpt6fkkwRW0Dt8sZRMCBofrD
 i0X99V5EGKtFnzUjKUflUOBxBSvkGJZ0I9SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAONd-1qrUFe0nIB-00Bx2j; Thu, 14
 Sep 2023 11:25:38 +0200
Message-ID: <a5d3a051-0b3e-4fc5-9df5-e70c94adb95e@gmx.com>
Date:   Thu, 14 Sep 2023 18:55:31 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
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
In-Reply-To: <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4L2g0Tv4Eg1FsuzDhUM7oAJQ/kcxYTzg3u9V2Mw9lQpDVAUZH7s
 IFAeS0lV8WbdWKnOfKbC7OYHSjv4H4ca8eAY8B2nkIO7+xojgbiXIru4RAM7Uu1F+g1/aG6
 vgeKEdrlZh7d3gjLTLxruIDPnw3c/RHwA7oYjVuQ/nF4QGOHWF7Ki10Vx/1sRHboXA7/l+u
 6iqutxKDv4HbjhuesdEQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0xmIo187tfw=;WUDsohdJ+OowC+FvwxlUAEQV5n8
 eKBhZBPur/HTMmsxrLRN+Ev4jgnxDXyrHtzp3F1iue4Uc8SVEP2qNLunjZwKBvx9oY+0QOP25
 GbFeeoub0U3Yl7HvH7R40e0SAgKj02jv6bF4liSo0rjOuKtQ/sVd0jWd4yoGCg/nsHNOroeEv
 azkTfdaNYzpyo9hM4DHGcxNuRcAGfJQv/AE3i5BvJpc2u4E5d5CimJ/RLsieJ33V+jszeWadt
 DcSh1JV7F3Shz9Um3dG3Nk3AXz1P4F6DF2dAjCywHNwOZgTUQv+///Isz743fzCUzAXk/qlcs
 XyeydM1ybjVGb9ks7YtBt8Kf+alRX2fFTfRSU1sf3eWyi3HGokSSPkPiz41UxtMWcqQ+E0o0+
 GHjyx/mSuwcXpljwrRJBsa7pzMXYKsoTlWiPw/DXPV5k5xq+0RF4OuodlQpjX20rZEzqiO+jq
 OwPXl7zE3j2YKjyfxu4zrsIyQ+3rYiaQ0KDg9AG4QnMiL6tsnn9D19II4hQcQXpn3JDOpX+I+
 ITSenyy/jQybJOAQ87zx5gorSx9a+89q0BgMFCH5eGPd0FwqGYQAnfs9/lE++QcVz4y17qMmZ
 opjQUPSmR+rknwnFl6usCnsBsOyKGyfFMvqw8Bs52BBLNHl/23OYwXEGgu4w9NUWL2RyQU6Sr
 HMk+wn8AkPgd64SO19D6ih85pigRRV370ritcPxcgX/zJz1ah8aM9JOlChSeRxIcO3/UN+DoN
 BJJySWyLRLmJylHRzlB67+MysotGAyg6ujn9XsWGnVbU8JEyguGwiFBSJlkO5JP7y5+mSNYjf
 9Otm0v0aM1t4kJHcOSW93Kifq8KmgI1ZHrx5KToGuS50GdX3aWCop21VfuqTRTXQLGDNTT3zQ
 egEht6I3EcL8QcOUrRTshreH6zLWmTfuwXhBX/ts6kzdfg6HtCp7A6rUNmz3F23rUx0sRsWmm
 yw4d73OOpZo/06yNV5jO4jxqEIo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/11 22:22, Johannes Thumshirn wrote:
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
>   fs/btrfs/bio.c              |  23 ++++
>   fs/btrfs/extent-tree.c      |   1 +
>   fs/btrfs/inode.c            |   8 +-
>   fs/btrfs/ordered-data.c     |   1 +
>   fs/btrfs/ordered-data.h     |   2 +
>   fs/btrfs/raid-stripe-tree.c | 266 ++++++++++++++++++++++++++++++++++++=
++++++++
>   fs/btrfs/raid-stripe-tree.h |  34 ++++++
>   fs/btrfs/volumes.c          |   4 +-
>   fs/btrfs/volumes.h          |  15 ++-
>   10 files changed, 347 insertions(+), 9 deletions(-)
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
> index 6f6838226fe7..2e11a699ab77 100644
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
> index bafca05940d7..6f71630248da 100644
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
> index 000000000000..2415698a8fef
> --- /dev/null
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -0,0 +1,266 @@
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
> +static u8 btrfs_bg_type_to_raid_encoding(u64 map_type)
> +{
> +	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +	case BTRFS_BLOCK_GROUP_DUP:
> +		return BTRFS_STRIPE_DUP;
> +	case BTRFS_BLOCK_GROUP_RAID0:
> +		return BTRFS_STRIPE_RAID0;
> +	case BTRFS_BLOCK_GROUP_RAID1:
> +		return BTRFS_STRIPE_RAID1;
> +	case BTRFS_BLOCK_GROUP_RAID1C3:
> +		return BTRFS_STRIPE_RAID1C3;
> +	case BTRFS_BLOCK_GROUP_RAID1C4:
> +		return BTRFS_STRIPE_RAID1C4;
> +	case BTRFS_BLOCK_GROUP_RAID5:
> +		return BTRFS_STRIPE_RAID5;
> +	case BTRFS_BLOCK_GROUP_RAID6:
> +		return BTRFS_STRIPE_RAID6;
> +	case BTRFS_BLOCK_GROUP_RAID10:
> +		return BTRFS_STRIPE_RAID10;
> +	default:
> +		ASSERT(0);
> +	}
> +}
> +
> +static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tran=
s,
> +				 int num_stripes,
> +				 struct btrfs_io_context *bioc)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_root *stripe_root =3D btrfs_stripe_tree_root(fs_info);
> +	u8 encoding =3D btrfs_bg_type_to_raid_encoding(bioc->map_type);
> +	struct btrfs_stripe_extent *stripe_extent;
> +	size_t item_size;
> +	int ret;
> +
> +	item_size =3D struct_size(stripe_extent, strides, num_stripes);

I guess David has already pointed out this can be done at initialization
and make it const.

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

Have you tested in near-real-world on how continous the RST items could
be for RAID0/RAID10?

My concern here is, we may want to try our best to reduce the size of
RST, due to the 64K BTRFS_STRIPE_LEN.


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
> +	const int max_stripes =3D trans->fs_info->fs_devices->rw_devices / 2;
> +	int left =3D nstripes;
> +	int stripe =3D 0, j =3D 0;
> +	int i =3D 0;
> +	int ret =3D 0;
> +	u64 stripe_end;
> +	u64 prev_end;
> +
> +	if (nstripes =3D=3D 1)
> +		return btrfs_insert_mirrored_raid_extents(trans, ordered, map_type);
> +
> +	rbioc =3D kzalloc(struct_size(rbioc, stripes, nstripes * substripes),
> +			GFP_KERNEL);
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
> +	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
> +
> +		rbioc->size +=3D bioc->size;
> +		for (j =3D 0; j < substripes; j++) {
> +			stripe =3D i + j;
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
> +	int i =3D 0;
> +	int ret =3D 0;
> +
> +	rbioc =3D kzalloc(struct_size(rbioc, stripes, nstripes), GFP_KERNEL);
> +	if (!rbioc)
> +		return -ENOMEM;
> +	rbioc->map_type =3D map_type;
> +	rbioc->logical =3D list_first_entry(&ordered->bioc_list, typeof(*rbioc=
),
> +					   ordered_entry)->logical;
> +
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
> +		ret =3D -EINVAL;

Maybe we want to be a little more noisy?

Thanks,
Qu

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
> index 000000000000..f36e4c2d46b0
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
> +#include "disk-io.h"
> +
> +struct btrfs_io_context;
> +struct btrfs_io_stripe;
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
> +	if (!btrfs_stripe_tree_root(fs_info))
> +		return false;
> +
> +	if (type !=3D BTRFS_BLOCK_GROUP_DATA)
> +		return false;
> +
> +	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
> +		return true;
> +
> +	return false;
> +}
> +#endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 871a55d36e32..0c0fd4eb4848 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5881,6 +5881,7 @@ static int find_live_mirror(struct btrfs_fs_info *=
fs_info,
>   }
>
>   static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs=
_info *fs_info,
> +						       u64 logical,
>   						       u16 total_stripes)
>   {
>   	struct btrfs_io_context *bioc;
> @@ -5900,6 +5901,7 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   	bioc->fs_info =3D fs_info;
>   	bioc->replace_stripe_src =3D -1;
>   	bioc->full_stripe_logical =3D (u64)-1;
> +	bioc->logical =3D logical;
>
>   	return bioc;
>   }
> @@ -6434,7 +6436,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
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
> index 576bfcb5b764..8604bfbbf510 100644
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
> +
>   	/*
>   	 * The total number of stripes, including the extra duplicated
>   	 * stripe for replace.
>

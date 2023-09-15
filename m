Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FEE7A12A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 02:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjIOA7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 20:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjIOA7Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 20:59:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064826B8;
        Thu, 14 Sep 2023 17:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694739536; x=1695344336; i=quwenruo.btrfs@gmx.com;
 bh=VlDDoWgla76Sf4yY8OaOOXJ2BDa1IoTUWPPLyautPtc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NrUGCxBpCNzsOfCD0UwjgdlMSudhXFUv+/LzEAyDBoYivikSvCDE7Pecq+nyJoHPWQ5Gn+8kwHv
 UMFTNhBYUkK9kcar2f/JmjBg+WV07ytq36NsILBBwEABOXPVw3c6Mrb8/hM59Ta48CpbNx58hNfO6
 jhbF3m+CxhokDzjcKoBhYG6TTkdstIyZphlxsv2yv28CEYSlmNpBG6BJjYToIkmr5ghoJDfhN6BId
 uTwlXeYLUfiutX9Z6sualpPKk9KRckZacVRPnnMKKgyhgbljy4QY+zem9oMVUy/wSYdLgqgz0Xdqw
 lNN/nAnt2tIqXas6ncAZ66aspQugCZ6Wgesg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.27.112.223] ([154.6.151.156]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1qt0Oh10sW-00C9Tm; Fri, 15
 Sep 2023 02:58:55 +0200
Message-ID: <33f4c547-65bc-4523-b1c0-bae0c7ad1e65@gmx.com>
Date:   Fri, 15 Sep 2023 10:28:50 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] btrfs: implement RST version of scrub
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-6-15d423829637@wdc.com>
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
In-Reply-To: <20230914-raid-stripe-tree-v9-6-15d423829637@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDkxKVOovDGSAAkZrF6u68exI6XAoCYplMkdVceCTQDYvyk9af1
 fdTFkGe++YYwb1SZrFqUDVbzTlcwk2AnuucmljkBrJc8hHg9yaHuW6s6bhtHsA1WeOWniRD
 9O+i/ozGx8FVLbupqC+GM7EgxGrLIu1fAvoJXqjnkHWhxVOGqkCtf143ZFHwjexacoFNsAB
 W72mTgH4736N7+xKu+s0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7to4/C0exbk=;7qf1a6ks51HIGVYgdd/nZNLSDwl
 6PFOyR+UWlL85eq/hvBpZfCp3ZnXT53yfIYhZdvUtjECVNmYlrlhFuFMYukZJfiZFycsUC0hb
 ZvzaRljgTOrhzEjuvjvpV/kDDbMKRi6Z2KsXPzJPmyEiA2d+6UETKPe0YnpA2jM9WLkloobUA
 PLt13hy0Wtfak034qHJIWK3u7Fj8q5OkVqn6Y/wlITl4ltfADfkHMJWYfnbDi/ahBqnrdwySL
 P0jgyvmyFTubO/NFtvbJ30ywXH1RA6lbGFgMLjAgqnfyTHS5N5fwhBDmBDxwlAC6z1DTvKubc
 ge9RaCb9A3R8y5s4AojHRm4OtFE5JSe5hQSbjVtb/uXn9MjvLLK0+4RL70Ti+yUkORyR/cmgw
 4Q1cgcubzE6sWN+uLbpNEqkrtrS1Pf1oohhwHhIxv0BMYDfteVwnFuLRqDlVIX7iSienyq3WE
 JdTkbiM2DCdNax8eS9civ8JaL+G2kujQdwTwf4YHYO8Y9mCu3Z5rpnvB80sDL8SMhBf18Q6qg
 od5RWG8CCIXwYmStETQVZ2xqsKAJkkkj/FwQ8/IPaVpBbFWE9G7G2paif76SOUzB+T3YN10s9
 l6sdsjxRD13WLzsf3d9wXhBjrETODbZYjiMLhp80Ni9RKwrszR8bvqcR9oiEJ1a/Qexpu3Zku
 xcp02SKKKCDcq6YyJhha9or77SCHkon8lfBYdD5/7cy9O7v3/CqkAYvXzdS0uIJeaNC8C0iy7
 9M4rlHJuRm4YpRRGDzIyXlXrK1+lr7epcOwzfQVj5HZHLLqF7HKnLwA8UpjrcYdj8QZflSQqM
 56uVo/eazZUhrcqQbdtIm5jUGh01v1gzQmB2aYIIIsPboZKHb1efGekxDr7TiSXfwgGCjITLJ
 R5SZyVpHr+tmSJfKrYb7Zh7LI5poSg8sZu0OU3UuPbRdgKoCiiHMsit0JQVf6pOkNiVCo6xCW
 UMH6dsCnYGsWK8Ll39Ri4/URbRc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/15 01:37, Johannes Thumshirn wrote:
> A filesystem that uses the RAID stripe tree for logical to physical
> address translation can't use the regular scrub path, that reads all
> stripes and then checks if a sector is unused afterwards.
>
> When using the RAID stripe tree, this will result in lookup errors, as t=
he
> stripe tree doesn't know the requested logical addresses.
>
> Instead, look up stripes that are backed by the extent bitmap.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/bio.c              |  2 ++
>   fs/btrfs/raid-stripe-tree.c |  8 ++++++-
>   fs/btrfs/scrub.c            | 53 +++++++++++++++++++++++++++++++++++++=
++++++++
>   fs/btrfs/volumes.h          |  1 +
>   4 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index ddbe6f8d4ea2..bdb6e3effdbb 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -663,6 +663,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbi=
o, int mirror_num)
>   	blk_status_t ret;
>   	int error;
>
> +	smap.is_scrub =3D !bbio->inode;
> +
>   	btrfs_bio_counter_inc_blocked(fs_info);
>   	error =3D btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_lengt=
h,
>   				&bioc, &smap, &mirror_num, 1);
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 697a6e1fd255..63bf62c33436 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -334,6 +334,11 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_in=
fo *fs_info,
>   	if (!path)
>   		return -ENOMEM;
>
> +	if (stripe->is_scrub) {
> +		path->skip_locking =3D 1;
> +		path->search_commit_root =3D 1;
> +	}
> +
>   	ret =3D btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0)=
;
>   	if (ret < 0)
>   		goto free_path;
> @@ -420,7 +425,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_inf=
o *fs_info,
>   out:
>   	if (ret > 0)
>   		ret =3D -ENOENT;
> -	if (ret && ret !=3D -EIO) {
> +	if (ret && ret !=3D -EIO && !stripe->is_scrub) {
> +

One extra newline.

And why scrub path doesn't need the warning?
IIRC if our rst doesn't match extent tree, it can be a problem and we
need some error messages.

Thanks,
Qu
>   		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
>   			btrfs_print_tree(leaf, 1);
>   		btrfs_err(fs_info,
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f16220ce5fba..42948b66d4be 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -23,6 +23,7 @@
>   #include "accessors.h"
>   #include "file-item.h"
>   #include "scrub.h"
> +#include "raid-stripe-tree.h"
>
>   /*
>    * This is only the first step towards a full-features scrub. It reads=
 all
> @@ -1634,6 +1635,53 @@ static void scrub_reset_stripe(struct scrub_strip=
e *stripe)
>   	}
>   }
>
> +static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
> +					    struct scrub_stripe *stripe)
> +{
> +	struct btrfs_fs_info *fs_info =3D stripe->bg->fs_info;
> +	struct btrfs_bio *bbio =3D NULL;
> +	int mirror =3D stripe->mirror_num;
> +	int i;
> +
> +	atomic_inc(&stripe->pending_io);
> +
> +	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors)=
 {
> +		struct page *page =3D scrub_stripe_get_page(stripe, i);
> +		unsigned int pgoff =3D scrub_stripe_get_page_offset(stripe, i);
> +
> +		/* The current sector cannot be merged, submit the bio. */
> +		if (bbio &&
> +		    ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
> +		     bbio->bio.bi_iter.bi_size >=3D BTRFS_STRIPE_LEN)) {
> +			ASSERT(bbio->bio.bi_iter.bi_size);
> +			atomic_inc(&stripe->pending_io);
> +			btrfs_submit_bio(bbio, mirror);
> +			bbio =3D NULL;
> +		}
> +
> +		if (!bbio) {
> +			bbio =3D btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
> +				fs_info, scrub_read_endio, stripe);
> +			bbio->bio.bi_iter.bi_sector =3D (stripe->logical +
> +				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
> +		}
> +
> +		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +	}
> +
> +	if (bbio) {
> +		ASSERT(bbio->bio.bi_iter.bi_size);
> +		atomic_inc(&stripe->pending_io);
> +		btrfs_submit_bio(bbio, mirror);
> +	}
> +
> +	if (atomic_dec_and_test(&stripe->pending_io)) {
> +		wake_up(&stripe->io_wait);
> +		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
> +		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
> +	}
> +}
> +
>   static void scrub_submit_initial_read(struct scrub_ctx *sctx,
>   				      struct scrub_stripe *stripe)
>   {
> @@ -1645,6 +1693,11 @@ static void scrub_submit_initial_read(struct scru=
b_ctx *sctx,
>   	ASSERT(stripe->mirror_num > 0);
>   	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
>
> +	if (btrfs_need_stripe_tree_update(fs_info, stripe->bg->flags)) {
> +		scrub_submit_extent_sector_read(sctx, stripe);
> +		return;
> +	}
> +
>   	bbio =3D btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
>   			       scrub_read_endio, stripe);
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 2043aff6e966..067859de8f4c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -393,6 +393,7 @@ struct btrfs_io_stripe {
>   	/* Block mapping */
>   	u64 physical;
>   	u64 length;
> +	bool is_scrub;
>   	/* For the endio handler */
>   	struct btrfs_io_context *bioc;
>   };
>

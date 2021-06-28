Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ECC3B5D63
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 13:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhF1LxT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:53:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:52563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232558AbhF1LxS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624881048;
        bh=w+06AcwrpRXCGSwnqafOgxZvt26zVPAw0Rix12k5CVs=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=UXSWcJznBqF8v7341cIkG/iHBd4UgqI1/mVzhwZDJpfaUKfXgjgylKXzsCMm24s5M
         J4JdNobSYADrImQ1t6zZiu2to2z7Iazlvo+Rfs/6r6SGOYgbfF+SqVxZp1KBEvkfKk
         BaX6U1nvsG6nC4lavkED54PAo3IwztEcjVBpLHtk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoN2-1m3pGj0tp0-00ExO1; Mon, 28
 Jun 2021 13:50:47 +0200
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210628085728.2813793-1-naohiro.aota@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: properly split extent_map for REQ_OP_ZONE_APPEND
Message-ID: <5c8fd0eb-0f7e-2ac8-af64-909501ec1ac0@gmx.com>
Date:   Mon, 28 Jun 2021 19:50:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628085728.2813793-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:heDfebWOf+hZqUBAx+HpgbTQAGie52Ow/nCSqO63cKuLDqTjmz7
 rZc00yidlJJtuJNpUgktBslcnLauBne2eRJtpTO+yEts+CBaPMqjNr3uR/8nWFKsWTRU7Xh
 qJxocST5KJHvifiXPty+vLV4lKt5uPC5dexx91rIozkdS1PiSIOADd5f9hjF5oHReqYcLn5
 kvTs1CEHdLApkT5Z/bN9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fu8jUQzdFmU=:UdfvNU52i0VUec6B24k/wG
 tFHKJzZ54QHvaLfi3izcppyZV//Cwfds+wqK5fUrZnnKlDYBAS6nSRJphL2ZaSX3f4WR+ouRN
 sh9pjp44Ov52G83DVtuPMxTDGJB/CY9Ri5cvvaMnKxocgiQ2ZXcaYqUhDMx7uGeHSNBy5TglY
 AqDdfu2mufamBnxBXLGqGoU89Q5LXnGGNX0ssdYIyh/3z/grx+3luMVuveY0M3uaQtQZUraMq
 Oj0kmiBvVhrUAatAYdkDjSL7TEWHdGhna65BtsRgMKcgKZ3nuXXx/IRTnEd67sCrQXW5trXQW
 pImEkPPVP+J5nPi545K76Y43yekkzYoIWt1hbdHCPPRf2foPvOhkH5GxbPDLnq85R2xJeOAOk
 iUIRpbwNt49kBH7rwIcSBultb5P2lM6E16WJbX2BQhKyeu3idlBf9+pARAem8rBzIYPxL6d//
 2kqVirw7C+qHklj3ZwlnRSGpJZP669Ube121C9yckJTNeHK5vATfV2SJ+nlIXEl/ezcdfdFEG
 9Hy/WXFdqqEwhiW2MkzGwpHmnJ80z4PkwdiHXkZH4UwM0Rmr5f5/LEibI07Mga00yBJfnBuur
 D6RgeBju64BA8z6LVCtQKM4MsGJtvPmD/+w5WLbOC42ebjOMwUkUYxRtlAXQIGJMyWpCZB8qW
 sliyGW0GeEJ3DHMMsTH6FTBEdpI1W9pKao8k830wT9teoy3YKluQpx3S3EoE6DA1YaL3/E1Jh
 cJUqZ8TDDiuoafrRwbE0sZSuRWIg4W81sS7pAz4wuL3aAAX5/d1hG9ivGetfdPv2HjM8j64y8
 7ob9RBgnE+lb3YVGwQumxK5pUMkejXkGdFxZE1YdKe/oaJ12YEBS8WIchEyhasceRxubU1yYy
 ZLLV9tZ0Z/f6hG6gRl2Suiu32JSs+2whUr43NezIPpiU7Kq/RhhtbSSuKY8kgAzwsfZmRomoc
 a9ZBaT9fUa/gN57F/Ee4IrBwx8v7qqo1sksjxCh1gazYmNks4mZWqznidS2u7NZDs1MeXGXEc
 Ev6SPe2kbl3Cd8MAA+BykAmeDhTdtbTuFCjapKOdUBHa75flnmKci34y4QrcTirFUIzcWie+M
 X0KUYbaHGfRTr6KiqPOYb05I/cu1rHT9nBYN8nMRBcGjrpxUgRVvPjJaQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=884:57, Naohiro Aota wrote:
> Damien reported a test failure with btrfs/209. The test itself ran fine,
> but the fsck run afterwards reported a corrupted filesystem.
>
> The filesystem corruption happens because we're splitting an extent and
> then writing the extent twice. We have to split the extent though, becau=
se
> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.
>
> When dumping the extent tree, we can see two EXTENT_ITEMs at the same
> start address but different lengths.
>
> $ btrfs inspect dump-tree /dev/nullb1 -t extent
> ...
>     item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53
>             refs 1 gen 7 flags DATA
>             extent data backref root FS_TREE objectid 257 offset 786432 =
count 1
>     item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53
>             refs 1 gen 7 flags DATA
>             extent data backref root FS_TREE objectid 257 offset 786432 =
count 1
>
> The duplicated EXTENT_ITEMs originally come from wrongly split extent_ma=
p in
> extract_ordered_extent(). Since extract_ordered_extent() uses
> create_io_em() to split an existing extent_map, we will have
> split->orig_start !=3D split->start. Then, it will be logged with non-ze=
ro
> "extent data offset". Finally, the logged entries are replayed into
> a duplicated EXTENT_ITEM.
>
> Introduce and use proper splitting function for extent_map. The function=
 is
> intended to be simple and specific usage for extract_ordered_extent() e.=
g.
> not supporting compression case (we do not allow splitting compressed
> extent_map anyway).

This may be a pretty stupid question, but why do we need to split the
extent map (and extent item) into several more and causing more extent
items?


I understand for zoned write, we have extra limitation on how many bytes
we can submit before reaching the zone limit.

But we also have stripe boundary for non-zoned device.

And in that case, we just split them into different bios, other than
split the extent into smaller extents.

Of course for current zoned support, only SINGLE profile is supported
thus no stripe boundary to bother.

But I'm wondering if we could do the same thing without really splitting
the extent map.

Thanks,
Qu

>
> Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sen=
t")
> Cc: stable@vger.kernel.org # 5.12+
> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/inode.c | 151 ++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 122 insertions(+), 29 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e6eb20987351..79cdcaeab8de 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2271,13 +2271,131 @@ static blk_status_t btrfs_submit_bio_start(stru=
ct inode *inode, struct bio *bio,
>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
>   }
>
> +/*
> + * split_zoned_em - split an extent_map at [start, start+len]
> + *
> + * This function is intended to be used only for extract_ordered_extent=
().
> + */
> +static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len=
,
> +			  u64 pre, u64 post)
> +{
> +	struct extent_map_tree *em_tree =3D &inode->extent_tree;
> +	struct extent_map *em;
> +	struct extent_map *split_pre =3D NULL;
> +	struct extent_map *split_mid =3D NULL;
> +	struct extent_map *split_post =3D NULL;
> +	int ret =3D 0;
> +	int modified;
> +	unsigned long flags;
> +
> +	/* Sanity check */
> +	if (pre =3D=3D 0 && post =3D=3D 0)
> +		return 0;
> +
> +	split_pre =3D alloc_extent_map();
> +	if (pre)
> +		split_mid =3D alloc_extent_map();
> +	if (post)
> +		split_post =3D alloc_extent_map();
> +	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ASSERT(pre + post < len);
> +
> +	lock_extent(&inode->io_tree, start, start + len - 1);
> +	write_lock(&em_tree->lock);
> +	em =3D lookup_extent_mapping(em_tree, start, len);
> +	if (!em) {
> +		ret =3D -EIO;
> +		goto out_unlock;
> +	}
> +
> +	ASSERT(em->len =3D=3D len);
> +	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
> +	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
> +
> +	flags =3D em->flags;
> +	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
> +	clear_bit(EXTENT_FLAG_LOGGING, &flags);
> +	modified =3D !list_empty(&em->list);
> +
> +	/*
> +	 * First, replace the em with a new extent_map starting from
> +	 * em->start
> +	 */
> +
> +	split_pre->start =3D em->start;
> +	split_pre->len =3D pre ? pre : (em->len - post);
> +	split_pre->orig_start =3D split_pre->start;
> +	split_pre->block_start =3D em->block_start;
> +	split_pre->block_len =3D split_pre->len;
> +	split_pre->orig_block_len =3D split_pre->block_len;
> +	split_pre->ram_bytes =3D split_pre->len;
> +	split_pre->flags =3D flags;
> +	split_pre->compress_type =3D em->compress_type;
> +	split_pre->generation =3D em->generation;
> +
> +	replace_extent_mapping(em_tree, em, split_pre, modified);
> +
> +	/*
> +	 * Now we only have an extent_map at:
> +	 *     [em->start, em->start + pre] if pre !=3D 0
> +	 *     [em->start, em->start + em->len - post] if pre =3D=3D 0
> +	 */
> +
> +	if (pre) {
> +		/* Insert the middle extent_map */
> +		split_mid->start =3D em->start + pre;
> +		split_mid->len =3D em->len - pre - post;
> +		split_mid->orig_start =3D split_mid->start;
> +		split_mid->block_start =3D em->block_start + pre;
> +		split_mid->block_len =3D split_mid->len;
> +		split_mid->orig_block_len =3D split_mid->block_len;
> +		split_mid->ram_bytes =3D split_mid->len;
> +		split_mid->flags =3D flags;
> +		split_mid->compress_type =3D em->compress_type;
> +		split_mid->generation =3D em->generation;
> +		add_extent_mapping(em_tree, split_mid, modified);
> +	}
> +
> +	if (post) {
> +		split_post->start =3D em->start + em->len - post;
> +		split_post->len =3D post;
> +		split_post->orig_start =3D split_post->start;
> +		split_post->block_start =3D em->block_start + em->len - post;
> +		split_post->block_len =3D split_post->len;
> +		split_post->orig_block_len =3D split_post->block_len;
> +		split_post->ram_bytes =3D split_post->len;
> +		split_post->flags =3D flags;
> +		split_post->compress_type =3D em->compress_type;
> +		split_post->generation =3D em->generation;
> +		add_extent_mapping(em_tree, split_post, modified);
> +	}
> +
> +	/* once for us */
> +	free_extent_map(em);
> +	/* once for the tree */
> +	free_extent_map(em);
> +
> +out_unlock:
> +	write_unlock(&em_tree->lock);
> +	unlock_extent(&inode->io_tree, start, start + len - 1);
> +out:
> +	free_extent_map(split_pre);
> +	free_extent_map(split_mid);
> +	free_extent_map(split_post);
> +
> +	return ret;
> +}
> +
>   static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
>   					   struct bio *bio, loff_t file_offset)
>   {
>   	struct btrfs_ordered_extent *ordered;
> -	struct extent_map *em =3D NULL, *em_new =3D NULL;
> -	struct extent_map_tree *em_tree =3D &inode->extent_tree;
>   	u64 start =3D (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 file_len;
>   	u64 len =3D bio->bi_iter.bi_size;
>   	u64 end =3D start + len;
>   	u64 ordered_end;
> @@ -2317,41 +2435,16 @@ static blk_status_t extract_ordered_extent(struc=
t btrfs_inode *inode,
>   		goto out;
>   	}
>
> +	file_len =3D ordered->num_bytes;
>   	pre =3D start - ordered->disk_bytenr;
>   	post =3D ordered_end - end;
>
>   	ret =3D btrfs_split_ordered_extent(ordered, pre, post);
>   	if (ret)
>   		goto out;
> -
> -	read_lock(&em_tree->lock);
> -	em =3D lookup_extent_mapping(em_tree, ordered->file_offset, len);
> -	if (!em) {
> -		read_unlock(&em_tree->lock);
> -		ret =3D -EIO;
> -		goto out;
> -	}
> -	read_unlock(&em_tree->lock);
> -
> -	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
> -	/*
> -	 * We cannot reuse em_new here but have to create a new one, as
> -	 * unpin_extent_cache() expects the start of the extent map to be the
> -	 * logical offset of the file, which does not hold true anymore after
> -	 * splitting.
> -	 */
> -	em_new =3D create_io_em(inode, em->start + pre, len,
> -			      em->start + pre, em->block_start + pre, len,
> -			      len, len, BTRFS_COMPRESS_NONE,
> -			      BTRFS_ORDERED_REGULAR);
> -	if (IS_ERR(em_new)) {
> -		ret =3D PTR_ERR(em_new);
> -		goto out;
> -	}
> -	free_extent_map(em_new);
> +	ret =3D split_zoned_em(inode, file_offset, file_len, pre, post);
>
>   out:
> -	free_extent_map(em);
>   	btrfs_put_ordered_extent(ordered);
>
>   	return errno_to_blk_status(ret);
>

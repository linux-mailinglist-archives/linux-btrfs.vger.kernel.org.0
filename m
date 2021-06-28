Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B83B5DBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhF1MPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:15:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:57319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbhF1MPA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624882350;
        bh=oXMQlpd9Dxkg4/+A0Na0nFPJtERtzNQ6QpjK31BMxq8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H4zxMRjdWeC+lHo7BeC0AZ3HE0cddpq6szy6yTMlOVZpAd3qW3CDM6ZRCfZjkoqk3
         Vcjnrw+MwdEpEj9lXOCT7mds0ea46Ph0Z1+IA6PIT+4tVG2xnYtPd0NXsf+A1Zin4g
         hQp0uCjFe8UfhOvpvNzN7gNfQ6KJ6cQK2jy2TKiI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1l1Rc91tro-00ygoW; Mon, 28
 Jun 2021 14:12:30 +0200
Subject: Re: [PATCH] btrfs: properly split extent_map for REQ_OP_ZONE_APPEND
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20210628085728.2813793-1-naohiro.aota@wdc.com>
 <5c8fd0eb-0f7e-2ac8-af64-909501ec1ac0@gmx.com>
 <DM6PR04MB70812FB4651CB36497CC35CAE7039@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bb02fcc1-7ca0-2ea7-9ae6-9e96058f078c@gmx.com>
Date:   Mon, 28 Jun 2021 20:12:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70812FB4651CB36497CC35CAE7039@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IJ5muSLVAhAxyRXfIdr+hdjUtQsDeq2H5hkXeXzV3SDtrOizZK6
 YJJTg5M8r6lwRGWi36+uHeVygcLzDHsd9QPGNnViCrSXl7Tdx/HKULmfGwZ/pqc6bx/Jwus
 OmawjPa5qEZda1deV75fDW/NQpOD91qNEM9EhUuoOKxvCOss21SW/6N1BdpCPZz+ZUqanwD
 Wsk+YtPTbbpvRShlT+dXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+p4clImj/Y=:nxJt5BsPv3EhEHwDy8lshi
 y2fV0Huk9i3Y6HGm5YQpZKVEMZNu/1LzNbDfntP/VyMAQyOue4r6Kuc8Oj5q+SybS4hXrdti1
 8DQIuVgASh6S36IIH0PNOBF4ZAEQwpV/Hx1CWupM5U6jvoXRROemQafXCkXRzrUOKDD48vNUo
 ZtKlQIbAPzZeUdXUsvgfzPtcu0kkGIZsWFF/zEQtdrSaBPHZayFd5qdIq/XoHE8xw1qaEwi4c
 NEH3sfgkT9W6FER9GCTIviySsiGOmU2exqhdk3HauMZwUnU3Yz7KIN9Et9GsYt9HZRS9f8tNw
 GEgVP/wwtWMSG5YU90bEL6HT81qSieA8J/bYpPW5U33sCZ+VhBdGf8Bxgw3BFKdMBgUs+QQ9r
 ko9g4yDEUl57iD+3Ejnl9bWR9MOySQi+KxySv5i70JLi8r/U+7TboIaBudrnDhO90Fy9W/g5j
 QuS2u43M9klJHut/UFKLJ9uXwpLALBMpi+VDDvU6MCrOTYdBu64mzx//BkPF+IdGnDpZAqM+9
 nvF9QhLPz92jj/VjfEzI8BWGmwZg3tRnWuxCzPxfZdkuSALdu3N7fr0qWuOdlLhNQ3os/Eq2a
 sqjBp4bnkngMoBYm5TcNFMjU0SsF8UMCpbjtkzfSFw7jCpVc8RPNwfr6CJOdGKSPSJ+seB0KK
 4y5o2xjcyqGItzG74M8sxp9e+xCI9/imXn3SXVm0sdk0VndyJ2fznitQBUKISojYpxCLtjo0g
 FwCTJQSZ4RphTPy8pPv4GL5UAlGie7a4vw1WRIhjO0ldY7K15Pyzm3pQaKf+g5+E6XWmmOL8Y
 J73vocErs8xEuQPRFMLbHBqdKSOpJSypaVVFSsw+aueJ7SdZeT3O3ATMauenXtYG9I6oRvjIa
 MTpsNjZO26u24MfOBf3RjlZCJBT4KhMeLEeGc5TbfcNPHBCWijq2o0BkNkB1o7Q7hczaX6i7s
 FotvyNSxatmSPvihZGa7JE42Nito+kYo24t6SLcip/ekR3dqfWmxUTT01mCMmSn7rNGZlY6Kl
 7VXCU/URy4f/s1qcKOUN1y/YVpAbH4zsyTTf92DEDQDD2BbuDsyz15EmYDm8bkXOk5FMf74Vg
 5hAnWyqAoIz0hnuVvIfbT04aYlwSNVnVAtzoSYQdVnCc5DrGezBF2dSbA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=888:08, Damien Le Moal wrote:
> On 2021/06/28 20:50, Qu Wenruo wrote:
>>
>>
>> On 2021/6/28 =E4=B8=8B=E5=8D=884:57, Naohiro Aota wrote:
>>> Damien reported a test failure with btrfs/209. The test itself ran fin=
e,
>>> but the fsck run afterwards reported a corrupted filesystem.
>>>
>>> The filesystem corruption happens because we're splitting an extent an=
d
>>> then writing the extent twice. We have to split the extent though, bec=
ause
>>> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.
>>>
>>> When dumping the extent tree, we can see two EXTENT_ITEMs at the same
>>> start address but different lengths.
>>>
>>> $ btrfs inspect dump-tree /dev/nullb1 -t extent
>>> ...
>>>      item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize=
 53
>>>              refs 1 gen 7 flags DATA
>>>              extent data backref root FS_TREE objectid 257 offset 7864=
32 count 1
>>>      item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize=
 53
>>>              refs 1 gen 7 flags DATA
>>>              extent data backref root FS_TREE objectid 257 offset 7864=
32 count 1
>>>
>>> The duplicated EXTENT_ITEMs originally come from wrongly split extent_=
map in
>>> extract_ordered_extent(). Since extract_ordered_extent() uses
>>> create_io_em() to split an existing extent_map, we will have
>>> split->orig_start !=3D split->start. Then, it will be logged with non-=
zero
>>> "extent data offset". Finally, the logged entries are replayed into
>>> a duplicated EXTENT_ITEM.
>>>
>>> Introduce and use proper splitting function for extent_map. The functi=
on is
>>> intended to be simple and specific usage for extract_ordered_extent() =
e.g.
>>> not supporting compression case (we do not allow splitting compressed
>>> extent_map anyway).
>>
>> This may be a pretty stupid question, but why do we need to split the
>> extent map (and extent item) into several more and causing more extent
>> items?
>>
>>
>> I understand for zoned write, we have extra limitation on how many byte=
s
>> we can submit before reaching the zone limit.
>>
>> But we also have stripe boundary for non-zoned device.
>>
>> And in that case, we just split them into different bios, other than
>> split the extent into smaller extents.
>>
>> Of course for current zoned support, only SINGLE profile is supported
>> thus no stripe boundary to bother.
>>
>> But I'm wondering if we could do the same thing without really splittin=
g
>> the extent map.
>
> The problem is not the limit on the zone end, which as you mention is th=
e same
> as the block group end. The problem is that data write use zone append (=
ZA)
> operations. ZA BIOs cannot be split so a large extent may need to be pro=
cessed
> with multiple ZA BIOs, While that is also true for regular writes, the m=
ajor
> difference is that ZA are "nameless" write operation giving back the wri=
tten
> sectors on completion. And ZA operations may be reordered by the block l=
ayer
> (not intentionally though). Combine both of these characteristics and yo=
u can
> see that the data for a large extent may end up being shuffled when writ=
ten
> resulting in data corruption and the impossibility to map the extent to =
some
> start sector.
>
> To avoid this problem, zoned btrfs uses the principle "one data extent =
=3D=3D one ZA
> BIO". So large extents need to be split. This is unfortunate, but we can=
 revisit
> this later and optimize, e.g. merge back together the fragments of an ex=
tent
> once written if they actually were written sequentially in the zone.

Got it, then the current behavior of splitting into smaller extents is
completely fine.

When we optimize zoned code to something without this behavior, we only
need to defrag them.
So no problem at all, even for the future.

Thanks for the explanation, it really makes me interested in the zoned
code now,
Qu
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is s=
ent")
>>> Cc: stable@vger.kernel.org # 5.12+
>>> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>    fs/btrfs/inode.c | 151 ++++++++++++++++++++++++++++++++++++++------=
---
>>>    1 file changed, 122 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index e6eb20987351..79cdcaeab8de 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -2271,13 +2271,131 @@ static blk_status_t btrfs_submit_bio_start(st=
ruct inode *inode, struct bio *bio,
>>>    	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
>>>    }
>>>
>>> +/*
>>> + * split_zoned_em - split an extent_map at [start, start+len]
>>> + *
>>> + * This function is intended to be used only for extract_ordered_exte=
nt().
>>> + */
>>> +static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 l=
en,
>>> +			  u64 pre, u64 post)
>>> +{
>>> +	struct extent_map_tree *em_tree =3D &inode->extent_tree;
>>> +	struct extent_map *em;
>>> +	struct extent_map *split_pre =3D NULL;
>>> +	struct extent_map *split_mid =3D NULL;
>>> +	struct extent_map *split_post =3D NULL;
>>> +	int ret =3D 0;
>>> +	int modified;
>>> +	unsigned long flags;
>>> +
>>> +	/* Sanity check */
>>> +	if (pre =3D=3D 0 && post =3D=3D 0)
>>> +		return 0;
>>> +
>>> +	split_pre =3D alloc_extent_map();
>>> +	if (pre)
>>> +		split_mid =3D alloc_extent_map();
>>> +	if (post)
>>> +		split_post =3D alloc_extent_map();
>>> +	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {
>>> +		ret =3D -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +
>>> +	ASSERT(pre + post < len);
>>> +
>>> +	lock_extent(&inode->io_tree, start, start + len - 1);
>>> +	write_lock(&em_tree->lock);
>>> +	em =3D lookup_extent_mapping(em_tree, start, len);
>>> +	if (!em) {
>>> +		ret =3D -EIO;
>>> +		goto out_unlock;
>>> +	}
>>> +
>>> +	ASSERT(em->len =3D=3D len);
>>> +	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
>>> +	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
>>> +
>>> +	flags =3D em->flags;
>>> +	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
>>> +	clear_bit(EXTENT_FLAG_LOGGING, &flags);
>>> +	modified =3D !list_empty(&em->list);
>>> +
>>> +	/*
>>> +	 * First, replace the em with a new extent_map starting from
>>> +	 * em->start
>>> +	 */
>>> +
>>> +	split_pre->start =3D em->start;
>>> +	split_pre->len =3D pre ? pre : (em->len - post);
>>> +	split_pre->orig_start =3D split_pre->start;
>>> +	split_pre->block_start =3D em->block_start;
>>> +	split_pre->block_len =3D split_pre->len;
>>> +	split_pre->orig_block_len =3D split_pre->block_len;
>>> +	split_pre->ram_bytes =3D split_pre->len;
>>> +	split_pre->flags =3D flags;
>>> +	split_pre->compress_type =3D em->compress_type;
>>> +	split_pre->generation =3D em->generation;
>>> +
>>> +	replace_extent_mapping(em_tree, em, split_pre, modified);
>>> +
>>> +	/*
>>> +	 * Now we only have an extent_map at:
>>> +	 *     [em->start, em->start + pre] if pre !=3D 0
>>> +	 *     [em->start, em->start + em->len - post] if pre =3D=3D 0
>>> +	 */
>>> +
>>> +	if (pre) {
>>> +		/* Insert the middle extent_map */
>>> +		split_mid->start =3D em->start + pre;
>>> +		split_mid->len =3D em->len - pre - post;
>>> +		split_mid->orig_start =3D split_mid->start;
>>> +		split_mid->block_start =3D em->block_start + pre;
>>> +		split_mid->block_len =3D split_mid->len;
>>> +		split_mid->orig_block_len =3D split_mid->block_len;
>>> +		split_mid->ram_bytes =3D split_mid->len;
>>> +		split_mid->flags =3D flags;
>>> +		split_mid->compress_type =3D em->compress_type;
>>> +		split_mid->generation =3D em->generation;
>>> +		add_extent_mapping(em_tree, split_mid, modified);
>>> +	}
>>> +
>>> +	if (post) {
>>> +		split_post->start =3D em->start + em->len - post;
>>> +		split_post->len =3D post;
>>> +		split_post->orig_start =3D split_post->start;
>>> +		split_post->block_start =3D em->block_start + em->len - post;
>>> +		split_post->block_len =3D split_post->len;
>>> +		split_post->orig_block_len =3D split_post->block_len;
>>> +		split_post->ram_bytes =3D split_post->len;
>>> +		split_post->flags =3D flags;
>>> +		split_post->compress_type =3D em->compress_type;
>>> +		split_post->generation =3D em->generation;
>>> +		add_extent_mapping(em_tree, split_post, modified);
>>> +	}
>>> +
>>> +	/* once for us */
>>> +	free_extent_map(em);
>>> +	/* once for the tree */
>>> +	free_extent_map(em);
>>> +
>>> +out_unlock:
>>> +	write_unlock(&em_tree->lock);
>>> +	unlock_extent(&inode->io_tree, start, start + len - 1);
>>> +out:
>>> +	free_extent_map(split_pre);
>>> +	free_extent_map(split_mid);
>>> +	free_extent_map(split_post);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    static blk_status_t extract_ordered_extent(struct btrfs_inode *inod=
e,
>>>    					   struct bio *bio, loff_t file_offset)
>>>    {
>>>    	struct btrfs_ordered_extent *ordered;
>>> -	struct extent_map *em =3D NULL, *em_new =3D NULL;
>>> -	struct extent_map_tree *em_tree =3D &inode->extent_tree;
>>>    	u64 start =3D (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
>>> +	u64 file_len;
>>>    	u64 len =3D bio->bi_iter.bi_size;
>>>    	u64 end =3D start + len;
>>>    	u64 ordered_end;
>>> @@ -2317,41 +2435,16 @@ static blk_status_t extract_ordered_extent(str=
uct btrfs_inode *inode,
>>>    		goto out;
>>>    	}
>>>
>>> +	file_len =3D ordered->num_bytes;
>>>    	pre =3D start - ordered->disk_bytenr;
>>>    	post =3D ordered_end - end;
>>>
>>>    	ret =3D btrfs_split_ordered_extent(ordered, pre, post);
>>>    	if (ret)
>>>    		goto out;
>>> -
>>> -	read_lock(&em_tree->lock);
>>> -	em =3D lookup_extent_mapping(em_tree, ordered->file_offset, len);
>>> -	if (!em) {
>>> -		read_unlock(&em_tree->lock);
>>> -		ret =3D -EIO;
>>> -		goto out;
>>> -	}
>>> -	read_unlock(&em_tree->lock);
>>> -
>>> -	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
>>> -	/*
>>> -	 * We cannot reuse em_new here but have to create a new one, as
>>> -	 * unpin_extent_cache() expects the start of the extent map to be th=
e
>>> -	 * logical offset of the file, which does not hold true anymore afte=
r
>>> -	 * splitting.
>>> -	 */
>>> -	em_new =3D create_io_em(inode, em->start + pre, len,
>>> -			      em->start + pre, em->block_start + pre, len,
>>> -			      len, len, BTRFS_COMPRESS_NONE,
>>> -			      BTRFS_ORDERED_REGULAR);
>>> -	if (IS_ERR(em_new)) {
>>> -		ret =3D PTR_ERR(em_new);
>>> -		goto out;
>>> -	}
>>> -	free_extent_map(em_new);
>>> +	ret =3D split_zoned_em(inode, file_offset, file_len, pre, post);
>>>
>>>    out:
>>> -	free_extent_map(em);
>>>    	btrfs_put_ordered_extent(ordered);
>>>
>>>    	return errno_to_blk_status(ret);
>>>
>>
>
>

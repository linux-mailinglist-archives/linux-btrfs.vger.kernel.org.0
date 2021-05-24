Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189F38E39E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEXKCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:02:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:49399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhEXKCa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621850454;
        bh=yet/5PlC+Qz8vmLAWaYPAWRlfhC3CFlOScquvuHyWcc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QeaRzShac10JqyHIBzHedJvJvLiV3vhV79bdtzl/EVmMhmjnB/OkdhfbX9B+ARUb9
         zqt1GB8LGDvVV0OquMjit6znKVjy+5JL8Ut58DpEfAGt0iwh7iNlFMm1S52sY5RheD
         3c6W68IzTMJYme+x4vW0cVpZNtXxeUrBAhfA5ZYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSc1B-1lrKW70OKn-00St47; Mon, 24
 May 2021 12:00:54 +0200
Subject: Re: [PATCH v2 3/3] btrfs: zoned: factor out zoned device lookup
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <0177d54fd7d5d9e96ee0bcdc29facd1324149a0e.1621351444.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6acd6d7d-5ea3-8ca4-6184-0018f207797b@gmx.com>
Date:   Mon, 24 May 2021 18:00:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0177d54fd7d5d9e96ee0bcdc29facd1324149a0e.1621351444.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tIseoAcS8RD+o0HJFq617VHivtItAeNph+lQAgSveRpP5sqVzyZ
 QUaFqAkWSZKU8HhHHVOGH6oH7HnSjHMMu1UBYcVFpJrTEByzXTV14vpJAFZhjvAV1yi+Q/D
 +Q6TKrgqMAXYQhy8YdEWSjaF7gRUWdw19d+E3pWNWRyXkqYqTwB/+gD55UoPCADmOv167tA
 GJKv+N8fSFVOdVs0dJodg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x36QhTdTBck=:ytDzhlaRD0YJpc/tmyibZY
 lV/G/42RgQyLOwcGZ2rdaQ7+Nq+l9MF0jUo7PYedaucwAYH67Jwiwi0U6yXUfya2y1EEtL1P7
 JATeTtwyDpwp8QUHHpV5FPYwl0BPArKSFlgGSAThgW9IAt1njN8RArXzvohou0sDyXYq/Z0T1
 pTR9Hv+o2AVxZeZ+3uPccS1Zyi+KrqciIXVCFh2nirhVeDSoDZihjQugDIvzrcWiGgGpp+/R7
 idw0WyBGKlZhNqk9Fbe/AaO+7sGBVBsvnFewkrFFSNwaj2yt8aoKDtOaZjivy4Lwcw/cgN4w5
 X7uZyh1HnP5L+Badj3fSqwnB2aYj3gwfnnm9NGJOtmO+gD84frwCeXpuMJwjZyRYNSQPb95te
 bso5YHnQvLlIX1H3bdohEVOJRf/NU7WTm1ryVyKFjLKDeSgyV9+4fQvqBf29tUw20Q44Ra7C3
 VoRL1l/UzFmmv6gf51JHcPkQZzYdMvOKMwGXCytrByXQyL5LVAJwY/2i1vcdbRvneXaoku0t4
 YNPN/GsvPgcnOZbIXgENfQhQRsr+2rVDvwZmen49b12/kG1vwAvpDiQxWxz5n50mNlYymQZix
 DzqiroMFC08zLmllXwVaC1PQOSyPKOS6EUAyf3A7r4DIzkNsNVgsQHn+bka7zxCtxxsp7u6sz
 qhPLu7B+rTxNA0k887Zlx0zXveZWdsT2te4bxPY4KptnCouL3PU0P86Ov7lFyXRO6fORVpX4i
 9GTtTd68bnIo78iv3P9ZtfK/ot0QW29X42kswhthy3J2aRbwsr2jkcHyB4Ma0ULTAIc4N0crM
 IkwxqUxFnlMa+L4N7fqIQRGH4hjCwUchkp0cqOP8lkthgCAbcmZLuGTEZ0YvXc9hLwxR7IKxn
 RWzRnKZ4z0DygkeW1zCI/AFAlZNl/FvVNqsy/TBPWLgWJWccT/EH+F3N77unHpnkDbK4zNuMg
 Ck8LzIgYBPQuSxN+48U6P/qDxcvAHGzJLYH088XglwhY2831N9zXveEvl9hnHUXQnceuQU0fa
 2Cb9aVzZQ8KWdDDXS9WEBVUkUyzLjDxFPeuF5NN0NN17mR1qEKb218GmOUauxhbWEMsB9iSBL
 izq1VdDRvpPpWq2bETjwQbNZyQ3aEdbkcUpkjplYsnI3dqTGcFolQamIJ4vTUDByzDL6T02/9
 a1+/+Oqo0cMp0+AkRMejelA4KEkVz3pQg3nYMUukGfiGpBIG6hTiCwxaJ4AGth8yrlzNzHsIS
 eatBR+sNn+oVXm+rs
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/18 =E4=B8=8B=E5=8D=8811:40, Johannes Thumshirn wrote:
> To be able to construct a zone append bio we need to look up the
> btrfs_device. The code doing the chunk map lookup to get the device is
> present in btrfs_submit_compressed_write and submit_extent_page.
>
> Factor out the lookup calls into a helper and use it in the submission
> paths.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/compression.c | 16 ++++------------
>   fs/btrfs/extent_io.c   | 16 +++++-----------
>   fs/btrfs/zoned.c       | 21 +++++++++++++++++++++
>   fs/btrfs/zoned.h       |  9 +++++++++
>   4 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f224c35de5d8..b101bc483e40 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -428,24 +428,16 @@ blk_status_t btrfs_submit_compressed_write(struct =
btrfs_inode *inode, u64 start,
>   	bio->bi_end_io =3D end_compressed_bio_write;
>
>   	if (use_append) {
> -		struct extent_map *em;
> -		struct map_lookup *map;
> -		struct block_device *bdev;
> +		struct btrfs_device *device;
>
> -		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
> -		if (IS_ERR(em)) {
> +		device =3D btrfs_zoned_get_device(fs_info, disk_start, PAGE_SIZE);

Not sure if it's too late, but I find that all callers are just passing
PAGE_SIZE (to be more accurate, should be sectorsize) to
btrfs_zoned_get_device().

Do we really need that @length parameter anyway?

Since we're just using one sector to grab the chunk map, the @length
parameter is completely useless and we can grab sectorsize using fs_info.

This makes me to dig deeper than needed every time I see such length
usage...

Thanks,
Qu

> +		if (IS_ERR(device)) {
>   			kfree(cb);
>   			bio_put(bio);
>   			return BLK_STS_NOTSUPP;
>   		}
>
> -		map =3D em->map_lookup;
> -		/* We only support single profile for now */
> -		ASSERT(map->num_stripes =3D=3D 1);
> -		bdev =3D map->stripes[0].dev->bdev;
> -
> -		bio_set_dev(bio, bdev);
> -		free_extent_map(em);
> +		bio_set_dev(bio, device->bdev);
>   	}
>
>   	if (blkcg_css) {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ce6364dd1517..2b250c610562 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3266,19 +3266,13 @@ static int submit_extent_page(unsigned int opf,
>   		wbc_account_cgroup_owner(wbc, page, io_size);
>   	}
>   	if (btrfs_is_zoned(fs_info) && bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)=
 {
> -		struct extent_map *em;
> -		struct map_lookup *map;
> +		struct btrfs_device *device;
>
> -		em =3D btrfs_get_chunk_map(fs_info, disk_bytenr, io_size);
> -		if (IS_ERR(em))
> -			return PTR_ERR(em);
> +		device =3D btrfs_zoned_get_device(fs_info, disk_bytenr, io_size);
> +		if (IS_ERR(device))
> +			return PTR_ERR(device);
>
> -		map =3D em->map_lookup;
> -		/* We only support single profile for now */
> -		ASSERT(map->num_stripes =3D=3D 1);
> -		btrfs_io_bio(bio)->device =3D map->stripes[0].dev;
> -
> -		free_extent_map(em);
> +		btrfs_io_bio(bio)->device =3D device;
>   	}
>
>   	*bio_ret =3D bio;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b9d5579a578d..15843a858bf6 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1520,3 +1520,24 @@ int btrfs_sync_zone_write_pointer(struct btrfs_de=
vice *tgt_dev, u64 logical,
>   	length =3D wp - physical_pos;
>   	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
>   }
> +
> +struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_in=
fo,
> +					    u64 logical, u64 length)
> +{
> +	struct btrfs_device *device;
> +	struct extent_map *em;
> +	struct map_lookup *map;
> +
> +	em =3D btrfs_get_chunk_map(fs_info, logical, length);
> +	if (IS_ERR(em))
> +		return ERR_CAST(em);
> +
> +	map =3D em->map_lookup;
> +	/* We only support single profile for now */
> +	ASSERT(map->num_stripes =3D=3D 1);
> +	device =3D map->stripes[0].dev;
> +
> +	free_extent_map(em);
> +
> +	return device;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index e55d32595c2c..b0ae2608cb6b 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -65,6 +65,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_bloc=
k_group *cache,
>   int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physica=
l, u64 length);
>   int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 lo=
gical,
>   				  u64 physical_start, u64 physical_pos);
> +struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_in=
fo,
> +					    u64 logical, u64 length);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 =
pos,
>   				     struct blk_zone *zone)
> @@ -191,6 +193,13 @@ static inline int btrfs_sync_zone_write_pointer(str=
uct btrfs_device *tgt_dev,
>   	return -EOPNOTSUPP;
>   }
>
> +static inline struct btrfs_device *btrfs_zoned_get_device(
> +						  struct btrfs_fs_info *fs_info,
> +						  u64 logical, u64 length)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>   #endif
>
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device=
, u64 pos)
>

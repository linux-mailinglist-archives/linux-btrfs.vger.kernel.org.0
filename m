Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685B73D59A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhGZLx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:53:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:53219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233742AbhGZLx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302863;
        bh=bA32mal6GH5Ar3UhWzX9KKAcUyVaurVM2RE08C3Pe5k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=heoi+Wg6zp+5TekBMbJdSZ/jkGGT8rEuuoPyZ/djepzJ3MbWTrDz70vdMt56+++YK
         l1iGge7773sxxeyYtfgt5Cw6gDTKBymQRlqBlhTjwZQ07j84lMMs4D/xacm/t0M9v+
         NvCwolQ9Nip6FzUOjr6v0La4ez2n9ty4Ln7r/1FE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1lSu6L21yR-00fjRb; Mon, 26
 Jul 2021 14:34:23 +0200
Subject: Re: [PATCH 06/10] btrfs: uninline btrfs_bg_flags_to_raid_index
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6a4949f84e640c299bf7b1d0898e54895b76c0c7.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cea44339-1e8b-0066-86a6-3980bbc00e1d@gmx.com>
Date:   Mon, 26 Jul 2021 20:34:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6a4949f84e640c299bf7b1d0898e54895b76c0c7.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9NX0fy/2fCjXyDZDrVJqSFWshZinddQz3+x810Xw98H5g4VJQWN
 DMr7GXqlXiKwQhJrZkoosW7Z3E8R4kPCf44qN9czfrwRn+bs4RDmUyEWWm1hG0gdX0IqsxG
 gr8JtxwSD5wHP/WlOOn50y62WWEIGCSbUq0xMfkfnUXKbFGfSQ9Yb74pQ+AJCaSurz2UH1R
 nxV2m7/Bnu8y+uUzs7P8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MypuSo9Vk8s=:RjvlITWS1i+xAQwZlibh1w
 Hbatgb2R8ceY4HOuzmhDLvK5D02NXyu/U0eyDD07sE69137kmcBlojTfdNHxQB8LZIsI5kY94
 XudVSQv59Qw2IGJO3MWxrb1Zxf0Iqkfkj0iI793zXxRyF0DIjmaqiQwdfCb9r+S7Fbh1u/dO4
 JV0c9NthjwLRsl/BqVll+vHJHEwdxpTg9d8R7YK7qRNdvPo9/+5n/qLuR3r9+C8U9YL0PXeK+
 F2cTol0ItT4TTHcUJja6VkNvsujpgUaY+o4+xaag87mRGJcA6HK/tRc1Vn2wEXnjy5R1ageII
 fZ2UTpzSEAXGvkRnJw6tHKGhujPxqmYGxNVhh27uprPSQB4NarfTz9yDCBfb2hX6K9zaf4YqQ
 +1pbc6U4vLzyw4caVBElpfSMTle26iHAn5RcvT8J1XEATYfHeA1FFih0PIwY+KjAZb7d8dPw5
 i+U7khF9osDGuoIUEGF6Lk/DSqHpsvLI114opBHOBCCqBgOm31sh2wfTklNGXcIOGvHKnnhOW
 Fif5oCuUWyDMfwWudDYRzWab14L25k7Cs3efSQ7Xbqs0bnRXuCuPt8/iBouW62I2KJTAeytcj
 9YBaw69SS3XCj/sB3A3hCew0pZtMKGllJpfw3Wk2YWjVSxunP69Xa2TGOdbnUXVR/cJSPsMfY
 sN40XoEVUR1yhCdrEgYrkrbrEBDrBjr9Skqpb3qiM4XFo/G2uQX+rJxE8pDeClq1i7FMyzG0d
 trbc6BF0Y5wkMs9EkSXueVFuEmNXgYrqYBJ+l2dpgyjzwyMCK5FmaHB6G3yspkdVmtgSHg95Y
 gaBkHv6rYrmPmDIPp+FrcUoJLQPXwpf4UK/xR5AkWtrawbFNZVAJgtXoiwtN597YeY7ingFVU
 wt0zB6e5rmZ/aFY13I3/E2xX2U7+krTbrNwpuAFQE462ucNkjlZarZIpE1EsI9babtIEw/BFf
 IcQRzW/9zShOt6YEthRhNewl6HzaS2kFFZMyGJ7MguJlq3+x4+MRHnRgs3lxEyzTGGCe0bHG+
 fWuBaf39TaKL+lepOrg+8cUycnp8eqzgnkLofLUPNzAbU4RV3maXl4CQzaZ0hCEcovlsPWV30
 ZyDYZ2/wNq08quWd6qhTnWe8F8SRmXaOYZj9ByaHeLRQPafMPeJ2o98+w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> The helper does a simple translation from block group flags to index to
> the btrfs_raid_array table. There's no apparent reason to inline the
> function, the translation happens usually once per function and is not
> called in a loop.
>
> Making it a proper function saves quite some binary code (x86_64,
> release config):
>
>     text    data     bss     dec     hex filename
> 1164011   19253   14912 1198176  124860 pre/btrfs.ko
> 1161559   19253   14912 1195724  123ecc post/btrfs.ko
>
> DELTA: -2451

My memory says there used to be some option to allow the compiler to
uninline some functions, but I can't find it in the latest kernel.

It looks to me that this should really be something dependent on kernel
config/compiler optimization.

E.g. to allow -Os optimization to uninline such functions.

Thanks,
Qu

>
> Also add the const attribute as there are no side effects, this could
> help compiler to optimize a few things without the function body.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/volumes.c | 26 ++++++++++++++++++++++++++
>   fs/btrfs/volumes.h | 27 +--------------------------
>   2 files changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 86846d6e58d0..19feb64586fc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -153,6 +153,32 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS=
_NR_RAID_TYPES] =3D {
>   	},
>   };
>
> +/*
> + * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types,=
 which
> + * can be used as index to access btrfs_raid_array[].
> + */
> +enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(=
u64 flags)
> +{
> +	if (flags & BTRFS_BLOCK_GROUP_RAID10)
> +		return BTRFS_RAID_RAID10;
> +	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
> +		return BTRFS_RAID_RAID1;
> +	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
> +		return BTRFS_RAID_RAID1C3;
> +	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
> +		return BTRFS_RAID_RAID1C4;
> +	else if (flags & BTRFS_BLOCK_GROUP_DUP)
> +		return BTRFS_RAID_DUP;
> +	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
> +		return BTRFS_RAID_RAID0;
> +	else if (flags & BTRFS_BLOCK_GROUP_RAID5)
> +		return BTRFS_RAID_RAID5;
> +	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
> +		return BTRFS_RAID_RAID6;
> +
> +	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
> +}
> +
>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>   {
>   	const int index =3D btrfs_bg_flags_to_raid_index(flags);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 70c749eee3ad..b082250b42e0 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -566,32 +566,6 @@ static inline void btrfs_dev_stat_set(struct btrfs_=
device *dev,
>   	atomic_inc(&dev->dev_stats_ccnt);
>   }
>
> -/*
> - * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types,=
 which
> - * can be used as index to access btrfs_raid_array[].
> - */
> -static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 fl=
ags)
> -{
> -	if (flags & BTRFS_BLOCK_GROUP_RAID10)
> -		return BTRFS_RAID_RAID10;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
> -		return BTRFS_RAID_RAID1;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
> -		return BTRFS_RAID_RAID1C3;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
> -		return BTRFS_RAID_RAID1C4;
> -	else if (flags & BTRFS_BLOCK_GROUP_DUP)
> -		return BTRFS_RAID_DUP;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
> -		return BTRFS_RAID_RAID0;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID5)
> -		return BTRFS_RAID_RAID5;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
> -		return BTRFS_RAID_RAID6;
> -
> -	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
> -}
> -
>   void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
>
>   struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
> @@ -601,6 +575,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info =
*fs_info,
>   			       struct block_device *bdev,
>   			       const char *device_path);
>
> +enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(=
u64 flags);
>   int btrfs_bg_type_to_factor(u64 flags);
>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>

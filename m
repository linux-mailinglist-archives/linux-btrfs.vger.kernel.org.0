Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B31390D12
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 01:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEYXwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 19:52:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:33907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhEYXwq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 19:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621986674;
        bh=Ps+3vxpVXWqVNKhe53ub2SXFAOlXFLGwBQUWLRXQG4k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Y7nAJD1X9XKC7tkamdm0fnXtc294CBISVz1RCwov9TL/62jsCI4dX3bU5xi80FbwH
         AaQgks8F/W8599wiQy9lYoaxrwuKdRQVzgFRXDSZxAy3o8W+oPt3W7TRhjLygKJuQe
         trHDT5lCLiRDhXsIPoIrJB2xew/EzwEb4SehQTlQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXuH-1lvyL01um7-00Z0q0; Wed, 26
 May 2021 01:51:14 +0200
Subject: Re: [PATCH 4/9] btrfs: scrub: factor out common scrub_stripe
 constraints
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <d175e98023012390c53755ba85f93606376f51a4.1621961965.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ee829f79-828c-b174-86f7-f30b0a12b6ac@gmx.com>
Date:   Wed, 26 May 2021 07:51:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d175e98023012390c53755ba85f93606376f51a4.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tg0bXHg4gouwmny7OTt2Iv39pf1uREU64pheufIpx4Jd72Zi29c
 mdvRGI0p4dQ37fMvd7ETNILC05hP3/FcprjmhJDZn+3cGAnBolDyUvk8Yo+5NgWj/EE1Cdz
 Y8DqnKM8qsnsB2hlNkWsRxfg918Jm+hEn7o63ZynFTXiimjVpvrI0RBb3J4nRUhbD6IbvSy
 n7iLjYj9jOD/Yd5WWO4Dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aC4T7ZGv+DM=:s7U/LZLNP2t+u+GXzDo9qW
 QV6k0iJ5T25NYlSiqTEB/0mptzc3JAvoV0108aAK1ZaLr0Oqtqt4xJ7TVpi3A+HxFuT4agvIz
 LpFqFus0c58VhnqtJ+ADqxJE+PgrGtfaHFRe0L5k1xOwpJpQ5NtifcZDt2HoMAwDKmmzjJQbO
 O3UeZyG5WSUZXr1Cn1do0pwUthiaFHGMCvOZGSEI6tJRQl8VgGfQom3/DyqqEnDJ/KKDmZm4D
 PqrrD/ocB9LCOD3Ehxsp375Qh873+R+NNglkaf7Y60TXLroBWuz46yYSljXl9p5nnfB/gMOE/
 0sUtOVye1ZB/xVfiSwqbCstmFF9DOs2N9wLe4jzUzGl87xlVo/VVOXdjioEO0rIy/rTtITwoL
 VeQ4mieOZ2L5UR0uN23qCdJKQUbARY1Y+VmOHZONi9/1LUl6opTUiMi7CE60WjZ3p1sXfru+D
 zMTxwmuRyqgBR93G8iRkDxmfriD2bIVSVHEVVB2QrJuqRK8TsxCh+lYu4OQ4eqdtvty9AE3CM
 ED0mFAMKLhkAj5RP31w+3Kzrshz1MgJj3Cl1udW+Wch12qTUGmFgh/7uMqwpc4iof+kYT5LPj
 EGfxMUYp129y23oSKwXZycyyMmbxtkfC0HXlCTylz11uUDuSxKn3p/0gRROaivJZ/LSC0Bb10
 P3iHwMpyN1czWBtffXQlxuAxJdmjsug4e2A0a3MHSi43wAc/ZOfMmsw7ljfkcWwVmNt0ltMfV
 ZtzdFLRI4EoLPM0l6jOG+nscFpv+BeR016RnAm/H1l3VinH0OCnpQIXWisWBa6ovsApC3hfFx
 Fks6RBdxClxEddF8orTnIWLEuyHtfTqNwOemz5hfO6ger5F6wnNt29/zg/vcYRov/rogxkCDu
 8ns0HQZF1rzfQGAVTgl3iGBWHs5t3q9JtHxmmeUvGsABzY6+gpecMVN3Uc/ziMF2Q1pqMxeY6
 GAqPsKBKQgooq2iRL4WiN4+CvcE1ynOW/rmwUQ1dOmbjL2+07BD8MwSY0qrDrhQ4wQVTvHWJ/
 Pt/1T8xN6T4VgP7ETGuwZgKdhRDLbobNu6HezhUcnG2OIwRc1gVBya29LQdANXWTagUGlqHIH
 GINydnA9Z40Z731ZzLnXDbUE0FnmxaFUNEvwuAhf9PoHH4VT2QVdkyyUccY1aKga4b5K8jVGt
 43emzmiCBiGTrUZdG2RH5DL8502/dHRPg/9gJXevqcLRm3YIQwOh/WmaYmXTxTspzcw57nFiN
 C8LqstfXtMTp3pqwo
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> There are common values set for the stripe constraints, some of them
> are already factored out. Do that for increment and mirror_num as well.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 518415d0c122..5839ad1e25a2 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3204,28 +3204,23 @@ static noinline_for_stack int scrub_stripe(struc=
t scrub_ctx *sctx,
>   	physical =3D map->stripes[num].physical;
>   	offset =3D 0;
>   	nstripes =3D div64_u64(length, map->stripe_len);
> +	mirror_num =3D 1;
> +	increment =3D map->stripe_len;
>   	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
>   		offset =3D map->stripe_len * num;
>   		increment =3D map->stripe_len * map->num_stripes;
> -		mirror_num =3D 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
>   		int factor =3D map->num_stripes / map->sub_stripes;
>   		offset =3D map->stripe_len * (num / map->sub_stripes);
>   		increment =3D map->stripe_len * factor;
>   		mirror_num =3D num % map->sub_stripes + 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
> -		increment =3D map->stripe_len;
>   		mirror_num =3D num % map->num_stripes + 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
> -		increment =3D map->stripe_len;
>   		mirror_num =3D num % map->num_stripes + 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>   		get_raid56_logic_offset(physical, num, map, &offset, NULL);
>   		increment =3D map->stripe_len * nr_data_stripes(map);
> -		mirror_num =3D 1;
> -	} else {
> -		increment =3D map->stripe_len;
> -		mirror_num =3D 1;
>   	}
>
>   	path =3D btrfs_alloc_path();
>

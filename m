Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905B717ABC
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjEaIxQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjEaIxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:53:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD10E6
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685523177; i=quwenruo.btrfs@gmx.com;
        bh=ZVe2XFpsFF6r5c5aXiVFzE+vCPLiJctcIelXaJgTMhU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MmZlbbFst8/QZs7CHHF8vn3PAQ6C0eS6QqtPxLXSEO5raUPqYHTpe4QgFYfZ0cWhR
         ojVvZXCYn2bLg3Uo8uzlf0zMlLdQhWz9by9tyQ9i1XRLRgk9DCf46dBUxwRtOOG6Vd
         amsxj/CRB4IGOSr5WJo/R04+PgNG+1PxukUASBHgf8pwPgtCPQVFC1cJQDCUvu53qA
         kKDy+/CLsQ2gdSf/PDLFhKQcT1DSAkZUbPMXeIwuPHcGHb/vNjP37GGnEb+IZHs3Hk
         XftcA2EKyFrQccEPAAw0ARopEVo4lU7DqwAuIentxQ9ngGNh6oV310zPuHwi1A0w2P
         66UevCdcKhJ8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvcA-1pZbXE2wVM-00Uo9d; Wed, 31
 May 2023 10:52:57 +0200
Message-ID: <f1930f26-6422-8f57-0d4a-7cc431dd1a7c@gmx.com>
Date:   Wed, 31 May 2023 16:52:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/6] btrfs: remove need_full_stripe
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230531041740.375963-1-hch@lst.de>
 <20230531041740.375963-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230531041740.375963-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aKVXOid2m7PZam89TG/tg++gJOfNpYtj+TKUMapy+tgbmV5XcyK
 5NPKNgpSYfNePwCVTAFfrjc6ijNp7EFdfXsGuGieLcgLAGJ93l9ZPysJfjiOGF+9XMDAgvC
 uMiGg2HzMozIc4uy0VCgRIrHl4k1L/Q/+GJMrvN3kjw7GJHFuQVMoJqVmamGhhnBZ/dr20T
 aensP2HTRPAPsIA3Lzy5A==
UI-OutboundReport: notjunk:1;M01:P0:Vt3ms1lreAQ=;0e2cG4H6AVL7xvgpepp3WxkDSS0
 r6j9xyEMEy5ke7CJAROG/VlN5IqEVadGBV9lF34AuHXaSlZXWEqs9A4wyO6qox8VWJ2yLWJQL
 nmunHLQB6XC41OkzkEbLVi5N12SOCb3btD3qcla2Nk63f8hiM6OzSi5golu+eji1ct2GpKtPb
 E+k7wn/FKBU7oCKuZgGNKPmB5emiKj+A4iqR1IzSJufIyAnfnPH3tluJEH14xUNmW6WqAGJPS
 /Zbg+ZwJRzZ6CUSPbIXTmQRcXuKHiLlf/gijNqc5oWEmjYcB9LwMKPHR+pFeC1xG/dL0MGUiC
 4UOgqXwnP49rOtxbYUdNOdV+9BEIHJdhGb+FM0kTuE0x9TdwRI1qd05STInM7w8LpB/i34JTb
 sTfVvewnRpRev8bZaDFCZpT6Tir4hb++YVx9Wi7tZNJKs2yhUKVzxvbClNZuQI+Dj5jEXekCx
 /8MSURjdB9xNfa1F7YxBYYtWD6oSUSdqpAdQCBMGWt5UUoHG7ZycFADSoha4r9Koup0+9Etda
 Qz9JNRg2pLwtFTgPG44ka1QfgzrHG/4p3GKzK8KT4LwbXJFuYlZohTHOFJIewLzZ+jU4RHauD
 zly16WPQM7nTJ4frE3eQqhAbN1A6OUZWJHuNpqdMBjaWYYiZ80y4uUrB8DHdzT1EaED/ZYNeN
 bDP20EbbguzqFoZgAgusLTKVnH3nrzPjAPX5oJhtMiwZn29KhR/uGtpIn/FvoY/l8eDssRWHe
 aqjggRL880/fWzx8eriQoTl6uOyxFXsVSj135zYcQ4niWG6r5KHIf3Zasi0OY6+OeE9C+fijF
 tXLTeD2bOPWFP64Jg7fTKGehWVGOQRmoTtX6E1IR5NVVPbxAXshkG5Yq3H6eGw/dzQDrYHdsz
 k4ZTY/mz8jO5Bjd816OjBz9ZCTSsa/q1HKQfvinVylCdXfl9YR94sl006J+qu/v3RKhU9+Q2m
 oygCYrLJwv6GZwJvCPkV0dWsUJI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 12:17, Christoph Hellwig wrote:
> need_full_stripe is just a somewhat complicated way to say
> "op !=3D BTRFS_MAP_READ".  Just spell that explicit check out, which mak=
es
> a lot of the code currently using the helper easier to understand.

In fact the old "need_full_stripe" can even be confusing, as
BTRFS_MAP_READ with mirror_num > 1 on RAID56 would still need all the
stripes.

So removing it completely is indeed better.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 29 ++++++++++++-----------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6141a9fe5a28a0..8137c04f31c9cd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6173,11 +6173,6 @@ static void handle_ops_on_dev_replace(enum btrfs_=
map_op op,
>   	bioc->replace_nr_stripes =3D nr_extra_stripes;
>   }
>
> -static bool need_full_stripe(enum btrfs_map_op op)
> -{
> -	return (op =3D=3D BTRFS_MAP_WRITE || op =3D=3D BTRFS_MAP_GET_READ_MIRR=
ORS);
> -}
> -
>   static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op =
op,
>   			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
>   			    u64 *full_stripe_start)
> @@ -6290,21 +6285,21 @@ int btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
>   	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
>   		stripe_index =3D stripe_nr % map->num_stripes;
>   		stripe_nr /=3D map->num_stripes;
> -		if (!need_full_stripe(op))
> +		if (op =3D=3D BTRFS_MAP_READ)
>   			mirror_num =3D 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
> -		if (need_full_stripe(op))
> +		if (op !=3D BTRFS_MAP_READ) {
>   			num_stripes =3D map->num_stripes;
> -		else if (mirror_num)
> +		} else if (mirror_num) {
>   			stripe_index =3D mirror_num - 1;
> -		else {
> +		} else {
>   			stripe_index =3D find_live_mirror(fs_info, map, 0,
>   					    dev_replace_is_ongoing);
>   			mirror_num =3D stripe_index + 1;
>   		}
>
>   	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
> -		if (need_full_stripe(op)) {
> +		if (op !=3D BTRFS_MAP_READ) {
>   			num_stripes =3D map->num_stripes;
>   		} else if (mirror_num) {
>   			stripe_index =3D mirror_num - 1;
> @@ -6318,7 +6313,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   		stripe_index =3D (stripe_nr % factor) * map->sub_stripes;
>   		stripe_nr /=3D factor;
>
> -		if (need_full_stripe(op))
> +		if (op !=3D BTRFS_MAP_READ)
>   			num_stripes =3D map->sub_stripes;
>   		else if (mirror_num)
>   			stripe_index +=3D mirror_num - 1;
> @@ -6331,7 +6326,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   		}
>
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
> +		if (need_raid_map && (op !=3D BTRFS_MAP_READ || mirror_num > 1)) {
>   			/*
>   			 * Push stripe_nr back to the start of the full stripe
>   			 * For those cases needing a full stripe, @stripe_nr
> @@ -6366,7 +6361,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>
>   			/* We distribute the parity blocks across stripes */
>   			stripe_index =3D (stripe_nr + stripe_index) % map->num_stripes;
> -			if (!need_full_stripe(op) && mirror_num <=3D 1)
> +			if (op =3D=3D BTRFS_MAP_READ && mirror_num <=3D 1)
>   				mirror_num =3D 1;
>   		}
>   	} else {
> @@ -6406,7 +6401,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   	 */
>   	if (smap && num_alloc_stripes =3D=3D 1 &&
>   	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) =
&&
> -	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
> +	    (op =3D=3D BTRFS_MAP_READ || !dev_replace_is_ongoing ||
>   	     !dev_replace->tgtdev)) {
>   		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
>   		*mirror_num_ret =3D mirror_num;
> @@ -6430,7 +6425,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>   	 * It's still mostly the same as other profiles, just with extra rota=
tion.
>   	 */
>   	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
> -	    (need_full_stripe(op) || mirror_num > 1)) {
> +	    (op !=3D BTRFS_MAP_READ || mirror_num > 1)) {
>   		/*
>   		 * For RAID56 @stripe_nr is already the number of full stripes
>   		 * before us, which is also the rotation value (needs to modulo
> @@ -6457,11 +6452,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
>   		}
>   	}
>
> -	if (need_full_stripe(op))
> +	if (op !=3D BTRFS_MAP_READ)
>   		max_errors =3D btrfs_chunk_max_errors(map);
>
>   	if (dev_replace_is_ongoing && dev_replace->tgtdev !=3D NULL &&
> -	    need_full_stripe(op)) {
> +	    op !=3D BTRFS_MAP_READ) {
>   		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
>   					  &num_stripes, &max_errors);
>   	}

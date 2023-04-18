Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522BA6E573A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 03:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDRB7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 21:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDRB7H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 21:59:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8859D
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 18:58:50 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjjCF-1qCstG17db-00lEwi; Tue, 18
 Apr 2023 03:58:41 +0200
Message-ID: <ad41862c-e7fb-acd7-7657-85b76cb302ee@gmx.com>
Date:   Tue, 18 Apr 2023 09:58:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-1-47ba9839f0cc@codewreck.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH U-BOOT 1/3] btrfs: fix offset within
 btrfs_read_extent_reg()
In-Reply-To: <20230418-btrfs-extent-reads-v1-1-47ba9839f0cc@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5DSiT5kHw79N/5InXK7hf4v7/QOVkt6+bvFzuuc06hCxRdGacHE
 TrJhNuoqvNLstfhZ28ckryv6KXEurT/ylLWw/cj10FuH9bS6+c4iggV7LwzSv16WsaOtZGN
 7w81dGltUt/qa9di9g/S82OMytgmiPuUhws5XEZh4y5tgV9ezlSzEDHJVihO75fTwuyvt/p
 o6LGV5DENNxQzldACTHAg==
UI-OutboundReport: notjunk:1;M01:P0:8nSzQxur6vA=;5eVVioM4rmB9wh9aqy5bBl77Xaz
 o0C7OQD8vWuj8dLQufd2AUrQfsLE+SB9forSEUMFGujC6AQ+K1Gd8idHQooC6UlXOYIi1h7Vj
 HfqvDpc3juTNoRUg7Z8MKFyOJDeDvpfxcwKurhACctSRc99N2isdfI1k9eCbGXPhwlzm2zrTA
 K1VB6UupqNZkTL51y9ZEoybXunJ0BD0CpNU3t3Dr2wISyKoo3KGATvv5iZ48lrvGYuU70LH9Y
 fYsfD4Dk8NrL6oAG0QaZZMrFsjs1mcgs9Oy5swJbB0oR4nLmvOv8bmXlkX00tDzg3BYk7V4ss
 cJUfxY+AzFyvol4R7koVLV3yUtB89Ctm8uHKq5dMKi0nVC8ZD1498jZsUUI7rh429nLqEClm5
 ZxWA5sbvOkbN/pOCzz+gVQ+IsS/SYHLFrDlBqETlm7bF//ApxNZk9wMrgv658ifGdgSx0+9BJ
 tIZ+83Ty34o4Q5qN1Et3rrxzgjMI1SvlyAecJyFQUCfVbQvIHKb8SLgDckiKduGotyJSzKclX
 9z+CLbBObZgNGWa/t2jR0nrRu5CW7vSW8o3z1oJMsI4+1jU7NRMpM8AOJgRVEWCe/kdEiMibK
 2c0MYJM9PaU5jHs5tIup0Hd9o68gV4PkYg/738XIkvYTrSoi3ppPevnAtwzke5NiJ1CF607lu
 OjMUVmznY9Wvxv7n5UBeO2mvBSPyH+gJW1U7LVVj46n5dBrR95FrEZf7525g/gs+EKOBJWJew
 AekW8VRxlrZ8OBUsfx8G+kELR3g7FiqweJcIDykE/73R4+j6GO1YRE/EeApk09SzyH313ZdW6
 q9n16u2Xz0S0Mg5K+YdvMHV0bMmE19Mhm7+l+EfDahaK2wtXKKe6ko3MyrNSEnJBp7kx9nL7u
 O9OSctitmRGRPLXdDde4u3/cQeDY1NA6gIOe66/4/CZaoVfRQ7SQ9PSYkhmfvPjtprTcEYBfw
 3q34xMdo0hYjLQYTmedul5Vbvag=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 09:17, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>

The subject can be changed to "btrfs: fix offset when reading compressed 
extents".
The original one is a little too generic.

> 
> btrfs_read_extent_reg correctly computed the extent offset in the
> BTRFS_COMPRESS_NONE case, but did not account for the 'offset - key.offset'
> part correctly in the compressed case, making the function read
> incorrect data.
> 
> In the case I examined, the last 4k of a file was corrupted and
> contained data from a few blocks prior:
> btrfs_file_read()
>   -> btrfs_read_extent_reg
>      (aligned part loop from 0x40480000 to 0x40ba0000, 128KB at a time)
>       last read had 0x4000 bytes in extent, but aligned_end - cur limited
>       the read to 0x3000 (offset 0x720000)
>   -> read_and_truncate_page
>     -> btrfs_read_extent_reg
>        reading the last 0x1000 bytes from offset 0x73000 (end of the
>        previous 0x4000) into 0x40ba3000
>        here key.offset = 0x70000 so we need to use it to recover the
>        0x3000 offset.

You can use "btrfs ins dump-tree" to provide a much easier to read 
on-disk data layout.

And you can also add a smaller reproducer.

> 
> Confirmed by checking data, before patch:
> u-boot=> mmc load 1:1 $loadaddr boot/uImage
> u-boot=> md 0x40ba0000
> 40ba0000: c0232ff8 c0c722cb 030e94be bf10000c    ./#.."..........
> u-boot=> md 0x40ba3000
> 40ba3000: c0232ff8 c0c722cb 030e94be bf10000c    ./#.."..........
> 
> After patch (also confirmed with data read from linux):
> u-boot=> md 0x40ba3000
> 40ba3000: 64cc9f03 81142256 6910000c 0c03483c    ...dV".....i<H..
> 
> Note that the code previously (before commit e3427184f38a ("fs: btrfs:
> Implement btrfs_file_read()")) did not split that read in two, so
> this is a regression.
> 
> Fixes: a26a6bedafcf ("fs: btrfs: Introduce btrfs_read_extent_inline() and btrfs_read_extent_reg()")
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>   fs/btrfs/inode.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 40025662f250..3d6e39e6544d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -443,6 +443,8 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
>   	       IS_ALIGNED(len, fs_info->sectorsize));
>   	ASSERT(offset >= key.offset &&
>   	       offset + len <= key.offset + extent_num_bytes);
> +	/* offset is now offset within extent */
> +	offset = btrfs_file_extent_offset(leaf, fi) + offset - key.offset;

I prefer not to use the @offset, explained later.

>   
>   	/* Preallocated or hole , fill @dest with zero */
>   	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_PREALLOC ||
> @@ -454,9 +456,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
>   	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
>   		u64 logical;
>   
> -		logical = btrfs_file_extent_disk_bytenr(leaf, fi) +
> -			  btrfs_file_extent_offset(leaf, fi) +
> -			  offset - key.offset;
> +		logical = btrfs_file_extent_disk_bytenr(leaf, fi) + offset;

This is touching non-compressed path, which is very weird as your commit 
message said this part is correct.

I prefer the original one to show everything we need to take into 
consideration.

Otherwise looks good to me.

Thanks,
Qu
>   		read = len;
>   
>   		num_copies = btrfs_num_copies(fs_info, logical, len);
> @@ -511,7 +511,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
>   	if (ret < dsize)
>   		memset(dbuf + ret, 0, dsize - ret);
>   	/* Then copy the needed part */
> -	memcpy(dest, dbuf + btrfs_file_extent_offset(leaf, fi), len);
> +	memcpy(dest, dbuf + offset, len);
>   	ret = len;
>   out:
>   	free(cbuf);
> 

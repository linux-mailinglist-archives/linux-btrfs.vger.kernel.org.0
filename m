Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113E1595681
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 11:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiHPJch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiHPJcL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 05:32:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3076155
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660636466;
        bh=FE4VzlhLASUmVSMdPp4KEizG23jadCD0pWGnGJ9jVJE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=j9A7EfvjF+asETF8z4eC1r87xa2aYk7DNWQSqEwAcA2pg7uMQfG/S2WlC4JC8sbL9
         06L2uLjVa3etE6urspZfVeLENYp8LE8HbK4lLcpzX9k7u2Xhd3/5ID29OUEFnWF2aa
         wxIFQUeIJiwslddJs+j2Dw6I+8U1cZzJvLKmI3/Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTiPv-1nw2Tk2A1N-00U3ME; Tue, 16
 Aug 2022 09:54:26 +0200
Message-ID: <3f2bfdc4-9561-bee4-d2ef-98617c258b87@gmx.com>
Date:   Tue, 16 Aug 2022 15:54:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs: round down stripe size and chunk size to pow of 2
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220816014603.1247-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220816014603.1247-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:psjCbi93j9RepHeP6g2actozVjQNdmL5pd70H+Bsok0Sqcc3n8f
 tEEYGGcKsO4LY+FwoyzDL9A6zhjvPGEiWCEYHbIeVWyyzlzPpvb25qOBTHhngn4lhPxZ7TX
 wY8Bd6oYn2ZesfpRgf3Wt7up9tNpMw1LEHzPMBEByJwx/TsAshOOP/DFjJNMeNnPBcmk/6J
 My0xjhuKmQKo5alpC5SQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:un3SvyqgI5w=:g6ydDmvnYYcXkGjbZH56fX
 MRM1eZUoriJntp51Bvwwm0YgY/zBqiV78SCJzm9EQ2eA2TsLPro9+3kccB8ueE1HCC2kSn5C0
 wjWUB3BH6OttIngG9lRq357S5rN/ZE0SihsPj3araeHbt1Uo8V+2ZAGA0L0xQzmI8zROyINWi
 TJ8/4+20u1p+jRaMfxIxla0It5blS8tZGl9Q1Cin76eRK3MMHHB7WEoYcNZ1C+ptkzsnr7A4I
 W6HXkD/HSiSM+dqlhBk/YvhxCrvmmkjjQdmKfhs48gy/Fzwf/a+3IpL2VYSkaMZR2gzniujPq
 KRdJkcFw9VvDedup7sJXhTMHrkRPYi4A7VOw1BfVztcqjrpoy10YdkrJPPxk9wO8k6PaRJf1G
 AqUkyDVMq96FDCXGdyC9shO1Sq1QAfLyGnV1UeMvGBlgz3eBVJJvdfxgD6om3UWUdkzmwWkVL
 SSWFqXORYMP7SniqkRyjlEbQbNm6pSKvtrKbRqXHq4M8qGlw/PRNETHC8wADWzmQkvU57I4HM
 6OW3LUH1Mk8+bA9pAUndOvd73KnFm1yeNF/KupeFtgkea1+SiHZbAM9muU7YvzCTMwmlkBtZW
 bkCZ/t1sXhk8Ax5A2ihiI2ZJR/QjTyFFrdmdpaS42NOpHUoCQM2iUJeVeOqmwnxVTZVsriCxw
 RAx5M0R/8lD8QqZYHrif+TNhWicViDxf16mq3YFmYn2nmJ16sl2eUwBuQVTGz0Td1Tb876so3
 xxlZKzyD7FiyCTzkDfoRWLbBxl6tGwSiD011Naw8HlgE6C21MshwBk0e3YXjH6kWHddvwI7UP
 fCN+YEtOyiTOX7yBicR9XB0DoQLjTK4aj15h6UwcAju4t5/oBNn8sftQRkdRhk3QXjhdr63qC
 0A4o4qV+XrXaHkIjSW29sTr87zNhV23IsQZJICdKVtBL7xPt3OUTGp4Ge+aXGMThDeXYyrthp
 qtibkD6VKwB+S7I7UeLB8Dp3GF9EAZDWJ8W+/hRGAltlI507q9IxM56XKVWIVh/3YHvVQJnxm
 /ATf6ZrSj1PedQ7xWsvRe14puv+mol4zYizC5yEdlgi3CwXjnUEWadCXjGd4pJPYlGjBcYB8a
 MCwIns0csu9dSzLWIfVCYfZIh1WL/8S5pG+MA8fHP5+X80nknW9xrwFug==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/16 09:46, Wang Yugui wrote:
> In decide_stripe_size_regular(), when new disk is added to RAID0/RAID10/=
RAID56,
> it is better to alloc/reuse the free space if stripe size is kept or
> changed to 1/2. so stripe size and chunk size of pow of 2 will be more
> friendly.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>   fs/btrfs/volumes.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6595755..fab9765 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5083,9 +5083,9 @@ static void init_alloc_chunk_ctl_policy_regular(
>   	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
>   		ctl->devs_max =3D min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK=
);
>
> -	/* We don't want a chunk larger than 10% of writable space */
> -	ctl->max_chunk_size =3D min(div_factor(fs_devices->total_rw_bytes, 1),
> -				  ctl->max_chunk_size);
> +	/* We don't want a chunk larger than 1/8 of writable space */

For the 1/8 change I'm completely fine.

> +	ctl->max_chunk_size =3D min_t(u64, ctl->max_chunk_size,
> +			rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));

But I'm not sure if there is any benefit for the extra
dounwdown_pow_of_two().

Our chunk size doesn't really need to be power of 2 at all.

Any extra explanation on why power of 2 chunk size has any benefit?

>   	ctl->dev_extent_min =3D BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   }
>
> @@ -5143,10 +5143,9 @@ static void init_alloc_chunk_ctl_policy_zoned(
>   		BUG();
>   	}
>
> -	/* We don't want a chunk larger than 10% of writable space */
> -	limit =3D max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
> -			       zone_size),
> -		    min_chunk_size);
> +	/* We don't want a chunk larger than 1/8 of writable space */
> +	limit =3D max_t(u64, min_chunk_size,
> +		rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
>   	ctl->max_chunk_size =3D min(limit, ctl->max_chunk_size);
>   	ctl->dev_extent_min =3D zone_size * ctl->dev_stripes;
>   }
> @@ -5284,13 +5283,12 @@ static int decide_stripe_size_regular(struct all=
oc_chunk_ctl *ctl,
>   	 */
>   	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
>   		/*
> -		 * Reduce stripe_size, round it up to a 16MB boundary again and
> +		 * Reduce stripe_size, round down to pow of 2 boundary again and
>   		 * then use it, unless it ends up being even bigger than the
>   		 * previous value we had already.
>   		 */
> -		ctl->stripe_size =3D min(round_up(div_u64(ctl->max_chunk_size,
> -							data_stripes), SZ_16M),
> -				       ctl->stripe_size);
> +		ctl->stripe_size =3D min_t(u64, ctl->stripe_size,
> +			rounddown_pow_of_two(div_u64(ctl->max_chunk_size, data_stripes)));

I think this can even be problematic since now stripe_size can be much
smaller than what we want.

Thanks,
Qu

>   	}
>
>   	/* Align to BTRFS_STRIPE_LEN */

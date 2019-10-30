Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14BE9BAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfJ3Mmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:42:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:59821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJ3Mmf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572439347;
        bh=jxzWJEudPBSGyHGwyFjUvl9DZSrOjLe6+bCaWe23QEg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QeG9gKEYf576lImieyWX2ec7s+wFMBz1rgfDthDq9xuQkfAnK47Juq+OBXxpffvty
         bZPBbll4OStDwJGV3mErgR5ykci3wbLBWDzK+rU9+ERMq0fAoQqrV3ZuLstpmtHGzd
         OTt4kNvxlCAta80t0iUWuKOr2tCPw9LZA5OS2sPo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1hwtY33Yd7-012HTO; Wed, 30
 Oct 2019 13:42:27 +0100
Subject: Re: [PATCH 1/3] btrfs-progs: Initialize sub_stripes to 1 in
 btrfs_alloc_data_chunk
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20191030122227.28496-1-nborisov@suse.com>
 <20191030122227.28496-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5c2ca10a-f59f-b660-b914-69f260e1e12d@gmx.com>
Date:   Wed, 30 Oct 2019 20:42:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030122227.28496-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8mS2/BXwPZbh2sgN/5JfG4FTYMTRVh9XUVXXe1mpDYZVgOJjmeP
 Tu5Fqqgql89Fkv+3LQHLoKVqoei/+Hi+R79c5XqLf5IFL7/CQXs1EQdAzjAYblbt/sJkARn
 f4DfJ+VJWa7Qbyk5T2sx0wUB+rm9pcjhw+HQCW9S5wfeZYjt0aC4eMeHKSFp4YAQf8Y3Nrm
 +06zaMiu9pRVmU+6TI5aA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KpFWd2jxdg4=:rZDRE+qzwimw1DcOBioypc
 ABkNyaVr8Bh7HBScu7hv/zB7nb86eS63g8Uoi3/uoywOKo58c7Fj3+UB7tn5bv9faOPYYs5dY
 75wCd2C7bYXGq8GQxgxHFNlrT6lGlcz7YKhoJsAvTGSzmnQGwNH51JY7DeAiP6zQ0SgORYlAv
 xF8xcidEzNsJz4VPVrD3Zt2QxIh/n6CAfclIN4fsvVaZrN67sRdBzbQhUHtDzNJBqa36+CI09
 anv3dvIvGfY8mCiPcQjJMOC1MxTnXCRJrWCdpquCYbAe7d4MvTJ2sVNW2e4sceKV773F3+DBm
 CzU/vV3bKW0s6D4jJkojYGT+AWaiRNafi1Odu/zYN0ZigSOTJLdxVboH28/rOUHNLdtXY9IT3
 STZzK+lCAloExctQkWDJbsyiH/Bwocz8gFJvEolHgQvkSRlXK4PCVp9KfhmsolLVxFqGCkSyg
 NnewpmQjR6b1+FMY0ggdiDhA0LRFBLEqtzRHMmx+U/SEdGO50cw4D7myemQ9voaU0YpruagCh
 wr884r3We+a+eA6wX2BF8nw2z7IPY2ElGy/pQkQBscKDORc00rlHwfBosWsY39u+bciUJGQcr
 WtYyq5zHmSOZYsBgdV0d4MivIZco6Icb3FnVTQcaOxJamP8gV9+tU4VU6YEJJnpyY46e6gL8B
 H8hT9HtXUnashHc6fo2wOktvIbQQNMiZ8g4zrr6o6CtoSuhPBXQYEPHMbXDiLFuK0OhPstvn9
 ZLg/8w4lDCICptzwz+49v1enlqtk/Vqw77csmOaLYwxhNExTezILfIVMkge19StylMoCS+0fO
 QJRULuMppipgixIm0XqDPNJ7go1lBu2klOb0h6wMOCRmJ0yR+I6sOqbvSNPgDGyHICydtcIZL
 B9wPp2KnJnn3nRyJBz0UICNQPeR8JIV+TkS1/1ZJGqi0IECA0ws2d5JJFfOny4bKkB3AEzFo3
 khMIv7laXs1MXCZjugexnkjSQ0lQAXFX1NADQo+jOR69X40ThQaWebw8Sz5kQB/Eq7hXXmg0N
 dqo5WtGwMjTWma5CZdC9FEZZ/dYI9MWY2zqriwpd0SJEdVlcWYeRfYPwdXYpoysYGXpMlOelR
 opspASlk/1weZmmiVsQ82YHQ6zr2g6dPKFQTW83MGCHoF7jMvHta1m+1N470yEzW0SpFTtYcj
 j/ahn2nHwHMfTnUGha157sfY33+XZV6wSBZUYkE71+u17dWs0s50JNQc1tiCQKjhAgllDDHmB
 m/7oayBJvMP1xYmpnCl81cHUGY525jI9CH9+PJZN7GGNGebwITmHNrPUVunA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/30 =E4=B8=8B=E5=8D=888:22, Nikolay Borisov wrote:
> sub_stripe variables is by default initialized to 0 and it's overriden
> only in case we have RAID10 mode. This leads to the following (minor)
> artifacts on a freshly created filesystem:
>
> item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15863 itemsize=
 112
> 		length 1073741824 owner 2 stripe_len 65536 type METADATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 0
> 			stripe 0 devid 2 offset 9437184
> 			dev_uuid a020fc2f-b526-4800-9278-156f2f431fe9
> 			stripe 1 devid 1 offset 30408704
> 			dev_uuid 0f78aa72-4626-4057-a8f2-285f46b2c664
>
> After balance resulting chunk item is:
>
> item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 3251634176) itemoff 15863 itemsi=
ze 112
> 		length 268435456 owner 2 stripe_len 65536 type METADATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 1
> 			stripe 0 devid 2 offset 3230662656
> 			dev_uuid a020fc2f-b526-4800-9278-156f2f431fe9
> 			stripe 1 devid 1 offset 3251634176
> 			dev_uuid 0f78aa72-4626-4057-a8f2-285f46b2c664
>
> Kernel code usually initializes it to 1, since it takes the value from
> the raid description table which has it set to 1 for all but RAID10 type=
s.
> In userspace it has be statically initialized by 1 since we don't have
> btrfs_bg_flags_to_raid_index. Eventually the kernel/userspace needs
> to be merged but for now it wouldn't bring much value if this function
> is copied.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I guess the tree-checker skips this check except for RAID10 just to work
around this problem.

Thanks,
Qu
> ---
>  volumes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/volumes.c b/volumes.c
> index fbbc22b5b1b3..1d088d93e788 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -993,7 +993,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *tra=
ns,
>  	int num_stripes =3D 1;
>  	int max_stripes =3D 0;
>  	int min_stripes =3D 1;
> -	int sub_stripes =3D 0;
> +	int sub_stripes =3D 1;
>  	int looped =3D 0;
>  	int ret;
>  	int index;
> @@ -1258,7 +1258,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_hand=
le *trans,
>  	struct map_lookup *map;
>  	u64 calc_size =3D SZ_8M;
>  	int num_stripes =3D 1;
> -	int sub_stripes =3D 0;
> +	int sub_stripes =3D 1;
>  	int ret;
>  	int index;
>  	int stripe_len =3D BTRFS_STRIPE_LEN;
>

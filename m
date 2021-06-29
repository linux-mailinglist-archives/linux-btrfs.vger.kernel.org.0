Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C083B7213
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhF2Mdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 08:33:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:48737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhF2Mdf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 08:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624969853;
        bh=9JQCRPCUu0c7UEigZE7I0Nde8v0bDQnAh332/tvZ0Pc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HG6JDWdp+wgWeXASZNc5ZDrjZaymM/fjyx46JoC30r/4MEv8BB0Raz+Q9WAeyBop3
         o6c5Mz+HN1ZvwOoXms7/MybiTecKtuXKHVwKkBMqEZEN8odVhAMoqgDw2KoqxtCANP
         7Jspv1PlnYk2EOWgyTHbqMI76CwI3Be37RnRGZrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1lTZ1Q26yW-00md0K; Tue, 29
 Jun 2021 14:30:53 +0200
Subject: Re: [PATCH] fs: ntfs: super: added return error value while map
 failed
To:     lijian_8010a29@163.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
References: <20210629095333.115111-1-lijian_8010a29@163.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8c9ab967-432a-5912-3e8e-25cae5b9acbf@gmx.com>
Date:   Tue, 29 Jun 2021 20:30:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629095333.115111-1-lijian_8010a29@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGm5U/vCV1wd1UBBUyN/MjcFi07ddNdNs9vFlOhmix7teUeK7B2
 t+rkoK/1NTc7EViorAl98H+cFCGEhv+tJ7qg8Hpp8ZPAYbjbEGZKL0/NAdf7iWc6oPqMqAP
 S2TsAQF0MdCVcYWFESIMPLKc3PwcCbmsmBordeZR/ecpiumo/UsAtcOS5n0E82z0CMxDOeX
 /Y+Xlz+iKz/FZbMmkB6Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQSrwb5hBgo=:hxPhzgF3bmVJTEs6iKOgbz
 GKuhSB+gLvY2eZ2iTBWzabNZoFxiJxf0tFtWYDao6dAGAAV7KnSxtgWyTlB19NgNIuZD/xaqA
 VyTraac88CeOG+yi8j1lY+oaZ0tnJy1q2iJn/m5maclGIRwd/ZLBqyyoHlT+sVWkAJxI/LYPE
 21HUKi5ZPbQu1kgl8GJ/X68ilzAIsXh/xpyq1MovqgqGXkNkRPe4k+L/a6AUJXN6/WT2ViFIl
 GWwp/3pBBTFwHGr2SCbLjwVpef3IwkKGkmfR/ZNMT0Ce0si8MAikZEArAK8XAc96eiyPZKc6A
 NHuy32Tn5iYxjcclDTw+aFR2YYEqkGagZBdqfBI0wwFnXMpn6MBlDpCiT8wL5IugaGLLZ39pP
 w4wq4G74Jd28i32NlLs+6qecvcjMnJZgK3qhd1hPQ3IWPopi+MSV1IxWksaWdSg21HOIbCeb6
 uQiXO0MIZJbi6PCRUXw6foImmMdYoZG3RH8SWxtI0+13zChxswCqazewsq7VOm24r10vQLOe8
 9sY2kzAhk9OK7VrJ9tZyzUrsByJt9NmrhQf1Zc1XjgJ2fJqNSQ3iVOMsHKx3Oh5cz7PqyiF1I
 Vgq7Gf0m9uZPjr1TyTNQ704YZJ9XO4jSEln9/gSXVxGblf+dbneK4SvNAdAgbffjVlZPMtdGu
 q0pmWIr2STQkn1Gdul+dEQQk5FtHDof1HvVQB+eCv1bQNKDBTYAVxNZsAYlN0RFX3huIj8SBp
 em8SWIQJjAr0g//RwAFPkihRDrGYFW+kyzLYRqVxcQJuvxZtR0etiSykTOBNbIkh27scA3928
 Pw5RAOWRip6GuXJJ9WGx5ErkDF4/ra6oXONIHIieH+jJG3uO0RVGXDxikSdCbxAFdo8DKWbpR
 RN0o6KaoBTDHWsnisv8QZgHSf9nZrt/yoKrwLA172LdfYey0cOdUDiL0mdCMV5EtuHRenlYNq
 UfqxAJP7loCXbnnuwFOwkAJbgm4VkYMpP4N0ueVsQa+NXZ7o52aTGy1V/OXQpdVOll2AMX54z
 wrXxWBbkBbC64Li14PeXZVOssZJA85jXQqWPHrHEO5FggGNbto9ndDUX6TyIda2MHeHMk+CJM
 8TGlPizguqbb4S+b9JtOMCBQbbYjdKG6b46e8WZthNVWzVtCF2bupHVlg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Wrong subject, it's not ntfs.

On 2021/6/29 =E4=B8=8B=E5=8D=885:53, lijian_8010a29@163.com wrote:
> From: lijian <lijian@yulong.com>

Still, you guys should try to send from your yulong.com mail box, not 163.

>
> When lookup_extent_mapping failed, should return '-ENOENT'.
>
> Signed-off-by: lijian <lijian@yulong.com>

Some maintainer is OK with name like all lower letters, but at least to
my eyes, Li Jian <lijian@yulong.com> is much easier to read.

Thanks,
Qu

> ---
>   fs/btrfs/extent_map.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 4a8e02f7b6c7..e9d9f2bfc11d 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -305,8 +305,10 @@ int unpin_extent_cache(struct extent_map_tree *tree=
, u64 start, u64 len,
>
>   	WARN_ON(!em || em->start !=3D start);
>
> -	if (!em)
> +	if (!em) {
> +		ret =3D -ENOENT;
>   		goto out;
> +	}
>
>   	em->generation =3D gen;
>   	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
>

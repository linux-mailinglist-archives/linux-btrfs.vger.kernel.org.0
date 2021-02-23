Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C49322B6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhBWN02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 08:26:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:38653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232853AbhBWN0P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 08:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614086682;
        bh=eHyJMQwGEpBkZCKWf7QjecfpH19i8AOOgBtccOHGHkk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PP7OBmJnMtaSWt83v9rjt0Y9w1aSyTADjRHvlRC/VmOjdgv6YFNCZaP0IYTD4LphY
         ACm8KpGyVcNC73G6j0MrqKBWm7B/yrbg47AHVj9f+5KRp+zym9pjdZmeidxbY2j9iL
         xOqA+FzxVBs/Di4wDagmJj1QpkWxC//T4EW5tthw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXuH-1lKRuw2y6h-00Yxje; Tue, 23
 Feb 2021 14:24:42 +0100
Subject: Re: [PATCH] btrfs: Unlock extents in btrfs_zero_range in case of
 errors
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210223132042.1198894-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <54595a8f-d9b0-5cfa-c557-1461354f8037@gmx.com>
Date:   Tue, 23 Feb 2021 21:24:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223132042.1198894-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dYuePilAo3fN8j15Z6YR9KbAZH4N+Y03ibL1lF4Beokk9B6ba+1
 HVBf+OEUyYXIKcnfXRIIPPSlA2icjlh16stWlG/gvcvb8chXfiH4aJ3nviNjoboGTqRU9RT
 nmOwtJHKFcoZmdNxijMP6/49+ubkTUMQuncxPSB7WVz0mbSuqJasRUy3f13V8/7fQ9d3TWW
 ulpoujiViAliyqehLa26Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f5KhrVZwhGk=:iGHqFbju9YfSj5wFSE80/o
 NZvSSunfVDDXbyPxiVhOkLVSlcTLDVFTlrJz6NMehX8nb0LEM4eijh5ioq2mtrv1QeIA3X7bE
 0pEb4WcAgathBf5bj1VvycIBguOyimOFlNQA4DFOa0GMN8s4r4uBZSAsG/G2aWkL1T2lljanE
 BLUIB4oaNLVoNj4Bj1d8CZB6F2548Ke51zA5LoMN6XBrW6SxYwaBXZK26wAO3u/S6MvUrdwEk
 UFmpTJhjtn9eO4gV1klapVJA5r5bi+uDohhM2C3nI3jZdXe6ieZaZbNlxzXDV2jbdYPKNLEGK
 a7CETyl65Be3fbAFJ7aoR68WQVi8JXw1cnOXVvv6P8P9Vsnbd/vYywffhxsoy3z8+8o2nVAWe
 Ax9PWbh8MIy4XmdcrLdyRVpdWwjXWP3DK5p7Fx36meCKaHHZVBcW7iPn9NvQSVlnYVgeOuYMp
 xYHrnkui7uXXF2Uf/lAaTWvYGUH6EogQkUkq9xpJuxVauBd4pzQUt48UELwNLoOYWrcmPrRig
 YXk/X2f9oEVpDZbFaFoi8rqQCI8cvJDsvXzOKdmlcGrH8EEpcH80dyYg6KBlWBqZq2yScLygE
 wU2BGEc+ITigDh169R6GOr7UehzmBrun3XuOWNrh9YbnsxwQsc9rKtD8L7EDlAcr0ApE0pYsG
 eC8lgWmTgXRUz5JjrC+rv41cD11n8B+/bpVv2xUz+exfs1G2MOJWq0UnR3Cy+hAGqqfy9qni9
 Fd6EVI4zBiFy9y+flQBthDNdi1h2fw/MRZ2MIQmRCQ0mQ79X4U/sBumAeHsPMeD+16BRVZQI5
 B11fUnFlagjI6EJeSX4EE/ictmuXhhjFKqvijzwyvKZfGAXuNseA+QYT7JvJezPOyLpfAARk1
 KLdegmVp6J92GGWsvrwg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8B=E5=8D=889:20, Nikolay Borisov wrote:
> If btrfs_qgroup_reserve_data returns an error (i.e quota limit reached)
> the handling logic directly goes to the 'out' label without first
> unlocking the extent range between lockstart, lockend. This results in
> deadlocks as processes try to lock the same extent.
>
> Fixes: a7f8b1c2ac21 ("btrfs: file: reserve qgroup space after the hole p=
unch range is locked")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/file.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1e68349c3884..af0253473508 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3259,8 +3259,11 @@ static int btrfs_zero_range(struct inode *inode,
>   			goto out;
>   		ret =3D btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
>   						alloc_start, bytes_to_reserve);
> -		if (ret)
> +		if (ret) {
> +			unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
> +					     lockend, &cached_state);
>   			goto out;
> +		}
>   		ret =3D btrfs_prealloc_file_range(inode, mode, alloc_start,
>   						alloc_end - alloc_start,
>   						i_blocksize(inode),
>

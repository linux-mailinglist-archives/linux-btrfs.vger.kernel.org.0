Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6838849F9A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348580AbiA1Mjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:39:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:39881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbiA1Mjv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373585;
        bh=6tE2NcFalnAQCMAQKJi17/BdflSRtMX2plkpM36ZVsY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XejTKHw3N2+ugkSzdIXF1nzVGk12heobJzYcCb37GndxHprmkkJtSxAlOm49tbeSi
         Oax1O7oPDU0u2P/TSzIrnl3AimYh3ZKkPNfoHoAldONCXEt4Zvkj57XjgeggdOVzIr
         el9wEQZ0YXlkhm3jbj1Kf+y8n46Pww+IlEdpZ2EI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1m8w1R0JyT-014Toy; Fri, 28
 Jan 2022 13:39:44 +0100
Message-ID: <cef3023e-121d-ad30-8b30-cf71c2da8d4e@gmx.com>
Date:   Fri, 28 Jan 2022 20:39:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: initialize offset early
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220128123558.1223205-1-usama.anjum@collabora.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220128123558.1223205-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:na70Jhk/B47GVbtehEvOD7CSXF2+qUHcD01PG8oUcdetjJW6+SK
 3u5q2WFEvlzCV0R5YfFAb2xoOxz/UIv7RqK9T9qR9zB3symgZRhxnNub7oYDFsbObjxQZiX
 8P4N9dO8vERdKyCRQwq1a+XnRcP8Jc4wBSpUwkeiJf4sqaxCCOGxlBqPZH8yvPDSfSwTSCP
 ijq6LonCCo9n2q3ej2/sQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpSJIOG3HPQ=:ooIdLKh4KcX0a8WMDIqRzq
 m7+QtsGeNUqzX2n0ezyqU3o9u9t3AMYATWtXN0B9tavjW0gt62UMmI/Fs4MY4t27fhDXLeLw4
 BfM1uuZdw/pfdIjUEAIMmt63BTcAmwBMNzQHRtuWVnuzUuTLB00uqqQXHGbonlJKSTTJHtuLu
 4PlgPhssqXiS4NJ+FkKEekY9MGwdLihkQoff467BtgoPWVtK9da1iRT4Yv4cCS7cMGM2lCvb4
 iNyXdi5HI6vRioeo6re1RIPxsCgw6iNANrf2mF9gZqBHefQyF2Js3/4+EQaOOaUBILRRqme8T
 HYfeYfY2Iiyus2snHDmFYLpqBBSB/58xKux8+2heUW/eg1khU05bphtLTqIiDMAgkHrf3VjWR
 poVZZDVvUDy3cfNgUBIhudeSaoIXBk8ZsAPVM8WC3BMVx2+NlIjdeVEtnLx9WHZCzmYFYrDRb
 8rqz+7tne6/ghO90QeGt+/cWoELYT4J++2EKVjQ5C7ePVLZEY77/40zoUZUlMEI1nqzVgrpcU
 QIJ97sMu4dZLVjct7TjDKjoL1XsINW3D7OGCSAEgqF8NgaAREQ7mftheLeAmE55mKehz1EfL6
 JRViLlFxMv2OabM3hjMj0HguCOjp2wDEEm+0QvkBqG/6xKqcOanRvcwmSN+aamMhqibWQU21H
 H2idY4H97ikTD2Pk45B9Rc+AxQs5D+qSEl5KPcwN2WvJR+qEbbVDzmj8x9OPHWawN/uCjfKqG
 0nwQSw6kKPFwNzdkosA1ii44FJ2rrOBNEuS1ReDybHaksBm/ux/H/BbT1nkJN/BHAx5tivXVX
 135NzdD768fT7pOwPFjktcXyTVGQyVyEBrjT6e4ZWaqF8vaD5ytRM3yEiq1YusJKMZKHRX/O9
 7HcUt0Pgk9c8RfpQQSBXVpuR+Hynnn1oFr9Ou0iEvFjcVg+a59S+70rlsssIvHWtOiaSVOJPP
 Om++DPqxUS2CFC49IWJP3M/H19ckx1KTapbdw4awUIq2A3z1UWS4uDfZJ5Uh8Akvjy67g0Dd1
 Wfu++2sEfbuPBHpXjg6hOxTKhREKt6Jd3XAIs+YgZEGA/dsafn9H8HQ0nitbHzWPEv5P/NdbQ
 URLXc3009sjqLg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 20:35, Muhammad Usama Anjum wrote:
> Jump to out label can happen before offset is initialized. offset is
> being used in code after out label. initialize offset early to cater
> this case.
>
> Fixes: 585f784357d8 ("btrfs: use scrub_simple_mirror() to handle RAID56 =
data stripe scrub")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks for the fix.

Although the patch is only in misc-next, and due to another triggered
ASSERT(), the series will be reworked soon.

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 26bbe93c3aa3c..3ace9766527ba 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3530,7 +3530,7 @@ static noinline_for_stack int scrub_stripe(struct =
scrub_ctx *sctx,
>   	u64 logic_end;
>   	u64 physical_end;
>   	u64 increment;	/* The logical increment after finishing one stripe */
> -	u64 offset;	/* Offset inside the chunk */
> +	u64 offset =3D 0;	/* Offset inside the chunk */
>   	u64 stripe_logical;
>   	u64 stripe_end;
>
> @@ -3602,7 +3602,6 @@ static noinline_for_stack int scrub_stripe(struct =
scrub_ctx *sctx,
>   	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
>
>   	physical =3D map->stripes[stripe_index].physical;
> -	offset =3D 0;
>   	nstripes =3D div64_u64(dev_extent_len, map->stripe_len);
>   	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
>   	increment =3D map->stripe_len * nr_data_stripes(map);

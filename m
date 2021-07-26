Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356A3D597D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhGZLtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:49:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:56393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233947AbhGZLtD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627302568;
        bh=HwwEzNd9uvnA9X/zx2Tt2jhSmUjYNRJr6rG9LLyC3RI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eFF0TaUsq82LiIg0IQje9vPMOvlD8BWzCKeIr/YAlejWJmP0C0TDn6YeK42fc6Mva
         LjnHxstveF2W7Njcx+NP8IMBFiWjgEqszjsqn6jtcLd5tllRwejZNlEQqc7HXlxJvs
         60E7RF+B7BhTq1xh118C7Vonp3eXllSvYwB7oT34=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQ5vW-1lm5Ae0ZiS-00M829; Mon, 26
 Jul 2021 14:29:28 +0200
Subject: Re: [PATCH 04/10] btrfs: tree-checker: use table values for stripe
 checks
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <b7a7bb037ee8622784d94f39997d8ab1fbec892a.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <aa326600-b1e0-e3d4-38b5-1ef0b4527e8e@gmx.com>
Date:   Mon, 26 Jul 2021 20:29:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b7a7bb037ee8622784d94f39997d8ab1fbec892a.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LLIOk7gqBjHiSQlNULexxOyqqjBkucJV0JRVaRc/Gzyj/StUzkF
 p1aHo0uxew6zkkGvMks47dH/IIx01BeF3nxv/0UBO6rW6VYYDEG/v8saTEWO+nnMbgAqx95
 Y2IHUbIp0mpTBbTG0rqtFDLvDLDZ7z6q74ukfhK0LnXUILMZNOKC/uWFtcpYyC9qRTZmjzN
 LuP+YcZmB1BuCw90OK5Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PBKSm/E+KDw=:ufuhjRXjojSrbrzDqQnROm
 iF57ggGlQsla9//OUidjmyXRJj7UJUAOPYSq+HmCnAGdlVUZD0y+20cekGWFstTi2ijUV+kwJ
 28XISvPYfHKBlBzUFQcB2bceMtjPj5sr0mcojFQpnzq6+DqEtgUtcGU/BT3PPBuTpk1Xnbulw
 Tt+ObacwZH82p+xv7R9tJKj2ebv6j7zsVgv/Eo0EoGHxGwZEBjf8wsjXB3fd9rDyYbuZVVSt2
 XLjfKUzfcpI8nuqA65RwrClYGjgkCxFsqjLFFGxI71709d1RncZnbx9tthwGfghj6GSbG1fRI
 Tf6lLWzjp3t2wRUhFbo1Qg7r53NsXpVEEXpWEXTeECScIa5hD52v7tKMdxhZEAlMqZkMRG8rn
 USt19cJFeuH2vH5DgS7D7NhnCkeHYGaxMXJq4aQE30ynAEaqa0RlnAlZL3GE5kLiSzYCqEaQe
 HnM6ZnMQGCGMP4alrKgaAvyKcow6pso4bTwy+4zAmeWIeXy4KQih9JFYF8pbhKmjGajbsFIgz
 eU23gU3oJrn1ZG7PAqlvy5UnqMhR4FzuOo2hyEAghproctzKcVAKwruvwZynLCCeW02uvZsZc
 xSbuNnit+GKkOpaNOIR26BPZpP514/ihYXn0tynrnu8zcHRGlILb0vMzpRaYZJ9A6HjaLT2px
 uGEuhXEC0WW511oqC+gYT8/F/MPvifuRMvmBFArtRYA8+rVQUFrOG6cFWa9XlxEQZcYiz9c+M
 wz03PpyurCz33yRp0tvnzwb4QZYsU1s49EZjCotk0E2u7Az6aakUxoRyjSBSKHcyAR66EKnI+
 gZ77IbwZYcSL5iCFvjneXlMu4E57n7qWffuC6p1U/jxgGA7tJwC3xKtcvLiY+6d+FZ/bYX85M
 uurWXSxDVvqejQXvtt2OSy54dYmax0Vutc6U0dvZBlmrtJ1+cKtqpuoBnuRvpR3ZM9CWFuI4H
 37PIEgWI8JrLJMQRHErETHt5n5LbvAJtBa1sxwML9fMmOgPkskjfkH9iUpZTvSTf69bG9Jcmg
 g8GbURd1JyXxrDYDh6aMOXNC9FprN9UBka30TxWIyLB23F5Hgal3VFiXBrb5KyCq9eTtAGrIK
 pVrYGKa8vcbNR1B+/W+IlFpEh4MXbwqec0K9VF5v9HmqSvjTXl7J/QMNA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> There are hardcoded values in several checks regarding chunks and stripe
> constraints. We have that defined in the raid table and ought to use it.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But one weird off-topics inlined below.

> ---
>   fs/btrfs/tree-checker.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a8b2e0d2c025..ac9416cb4496 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -873,13 +873,18 @@ int btrfs_check_chunk_valid(struct extent_buffer *=
leaf,
>   		}
>   	}
>
> -	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes !=3D 2) |=
|
> -		     (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes !=3D 2) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
> -		     (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
> -		     (type & BTRFS_BLOCK_GROUP_DUP && num_stripes !=3D 2) ||
> +	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
> +		      sub_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripe=
s) ||
> +		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
> +		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) |=
|

We're adding support for single device RAID0, but there won't be
anything called single device RAID1 at all, right?

Thanks,
Qu

> +		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
> +		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
> +		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
> +		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
> +		     (type & BTRFS_BLOCK_GROUP_DUP &&
> +		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) =
||
>   		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) =3D=3D 0 &&
> -		      num_stripes !=3D 1))) {
> +		      num_stripes !=3D btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripe=
s))) {
>   		chunk_err(leaf, chunk, logical,
>   			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>   			num_stripes, sub_stripes,
>

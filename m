Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACE10AE21
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 11:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfK0Kqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 05:46:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:47245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfK0Kqq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 05:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574851533;
        bh=LF6tl3R3ehmxNQoisvGQFneTT7/esRZIACPpTeyarXc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yj/lahXRLO1BuiXVRqFSN7bVzNoRr2hrsKBbR4/8PuGqYCd6rvAS3KXAgg/6nRE1X
         nfTE1WTkctY9z5lfX/CAWr3hbdDqfVQl0NoCYmDfOa56M7sfadGOv1L22F2KivhhmG
         qN+rPSYPi5ZhwkuBkfF1/cD3ndFC0Kvouklhg+8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FnZ-1iU7nn43sN-006SbB; Wed, 27
 Nov 2019 11:45:33 +0100
Subject: Re: [PATCH 3/4] btrfs: fix force usage in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20191126162556.150483-1-josef@toxicpanda.com>
 <20191126162556.150483-4-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8f77c09f-2b54-5252-cb49-2cf8dda2fb8a@gmx.com>
Date:   Wed, 27 Nov 2019 18:45:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126162556.150483-4-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H+WTjvvfz7WqmzZqyBE6Jq1LqOiynNCNHGWynr20/IlVNhQSU+V
 dJ3cV6Rjd9sFmB6dLK78aqm4cvbscmnbxOMZu5cp2U705Tv+DjQp+6EiRtGaN5MFpWkub45
 kiDfWBXKO1SFKvt6sEGpnaPg8Njc5dhd0/QvC4q2n3rbOD9VF77fBytoEn2Wdg+5H+/X7nz
 8D2N3eoLFXU6oDdf9K+nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4eLsvpZVwoQ=:Go1ZqJRRcJkTnsYpUc8HR8
 xb3nwEAdY4FYU48M5uuBo5LgpV16Y6dAWiUtTRAJpT1/WmiAtRbc7fXNjOcSSFed7M/LKkHZd
 NHcT1KYkHr5U7z7Du8g/1T8G0x0aJmXGhMWWwmxM8CGnxErsthj/HQyfV2FBfuHmsGvZ4c9lY
 yrLos8uNmuhKfoUeL2M0/8skIBS5NZ/lXrxbCeBr4PsEqlyngeHk3exT6nYqv3RIFX39qaDiA
 vs4qGoIo6gjnpuA1bwQ2ZSWaAGqYWF3zo+X9U/+iXec3WoZSR5gn5Rk7eXfGftUR5oe2Iw2r7
 yt1clWHU+Eit0yPudtt182/qMbmEQLm+Ir0VYhh3e5ZADfRJATmcYFhYcVS5HiZ5KeqBVQLMG
 2iPashYfYRNwGgDsTAPt2mlAk5bQbtWhwy5LiheI8ZBuoPflbj/XSnCaxXoCYf3BbztZR9xze
 VTgiSEtJgl/VKyVp/NK5mYAZM2LUkOkDLgpPwJrNc0fEPKHiH9L/o4zHbWdujxLlbQPyagChO
 HLiHj8wBzUTOliKlsSO+aVVIn4snTtLvccq9NHxfvpB8WlK8WUAMgcbh2liH8+j/pETQ6cypz
 OPTuRabdrfh/rOCcfdDZv9aY1uTrattHMm3KgVGMydaZorC2a9S7Hcxb1/Mc97BYEdj3Znywz
 1vAVvBKTsX+YfIFpbYdDHF04rWh8N8CRiO67yhTXuqRQWsqvbxxVMGLUWX16Avg9Uy5cO5G5r
 IJDcLdZtnd1+Iuhp4/pwtJ/eCjpSZpU0jPskVp4i6N5hbGsnQ7M1Gk0sx34/2X2I27TQta0lO
 MrMhy/u7GV+3azbezxWBiwJf+e6LlvBFd6apMv5tRRH/0LZr8ypWos0kZqkMBgMjgS9gDFnYl
 LSI1nJmUrzv7A5zc3l3ZjGLl4YBzt75bz4cDyBTqcLcDdnzbIkiovZQICPFXd08Dk55py6roQ
 u6fEEBZeRiOvKWtLwb4SHvUfBCZJWdkfY2GqkpGGBNvUoNYDpcX+DSy1DidTZkiHqQLq79CO+
 k9gPaebV2+PlawKHdxlgxmSfgJWSRfBMf63ZO4jn9GQ7kOmUyjEUEuBXwF1r6OZOyB/0GFJe4
 TPBcWebmbv0mJ/Xd647FTYyzeBASCWPkmC7CT/FF3kOJvHltwtXYEInfDxnWYFCrtJQE10KDJ
 UZkppAMcDNeNtigjs+IiL+3e2oeHTjDPkhHeHIPvMPRah9CeI7AYGVMmMEWyJHaZSQX70lUri
 ZVy2OUXUs4TmxeS5JwFvh4gfGE01g3YR3QeoBlncdVvI8EPeTU3X9xFHeC+4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/27 =E4=B8=8A=E5=8D=8812:25, Josef Bacik wrote:
> For some reason we've translated the do_chunk_alloc that goes into
> btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are
> two different things.
>
> force for inc_block_group_ro is used when we are forcing the block group
> read only no matter what, for example when the underlying chunk is
> marked read only.  We need to not do the space check here as this block
> group needs to be read only.
>
> btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates that
> we need to pre-allocate a chunk before marking the block group read
> only.  This has nothing to do with forcing, and in fact we _always_ want
> to do the space check in this case, so unconditionally pass false for
> force in this case.
>
> Then fixup inc_block_group_ro to honor force as it's expected and
> documented to do.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/block-group.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 66fa39632cde..5961411500ed 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1190,8 +1190,15 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
>  	spin_lock(&sinfo->lock);
>  	spin_lock(&cache->lock);
>
> -	if (cache->ro) {
> +	if (cache->ro || force) {
>  		cache->ro++;
> +
> +		/*
> +		 * We should only be empty if we did force here and haven't
> +		 * already marked ourselves read only.
> +		 */
> +		if (force && list_empty(&cache->ro_list))
> +			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
>  		ret =3D 0;
>  		goto out;
>  	}
> @@ -2063,7 +2070,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gr=
oup *cache,
>  		}
>  	}
>
> -	ret =3D inc_block_group_ro(cache, !do_chunk_alloc);
> +	ret =3D inc_block_group_ro(cache, false);

This is going to make scrub return false ENOSPC.

Since commit b12de52896c0 ("btrfs: scrub: Don't check free space before
marking a block group RO"), scrub doesn't do the pre-alloc check at all.

If there is only one single data chunk, and has some reserved data
space, we will hit ENOSPC at scrub time.


That commit is only to prevent unnecessary system chunk preallocation,
since your next patch is going to make inc_block_group_ro() follow
metadata over-commit, there is no need for b12de52896c0 anymore.

You can just revert that commit after your next patch. Or fold the
revert with next patch, to make bisect easier.

Thanks,
Qu


>  	if (!do_chunk_alloc)
>  		goto unlock_out;
>  	if (!ret)
>
